<?php declare(strict_types=1);
namespace F\Front;
use Phalcon\Autoload\Loader;
use Phalcon\Di\DiInterface;
//use Exception;
use Phalcon\Dispatcher\Exception as DispatcherException;
use Phalcon\Mvc\Dispatcher;
use Phalcon\Events\Event;
use Phalcon\Events\Manager as evManager;
use Phalcon\Mvc\ModuleDefinitionInterface;
use Phalcon\Mvc\ViewBaseInterface;
use Phalcon\Mvc\View;
use Phalcon\Mvc\View\Engine\Volt;
use Phalcon\Mvc\Url as UrlResolver;
use Phalcon\Encryption\Security;
use Phalcon\Encryption\Crypt;
use Phalcon\Http\Request;
use Phalcon\Http\Response\Cookies;
use Phalcon\Db\Adapter\Pdo\Mysql as DbAdapter;
// use Phalcon\Session\Adapter\Redis;
use Phalcon\Cache\Adapter\AdapterInterface;
//use Phalcon\Cache\Adapter\Redis;
//use Phalcon\Cache\Adapter\Apcu;

use Phalcon\Storage\Adapter\Redis;
use Phalcon\Storage\SerializerFactory;
use Phalcon\Storage\Serializer\Json;
use Phalcon\Storage\Serializer\RedisJson;
use Phalcon\Session\Manager as SessionManager;
use Phalcon\Session\Adapter\Stream as Stream;
use Phalcon\Flash\Session as FlashSession;
use Phalcon\Logger\Logger;
use Phalcon\Html\Escaper;

class Module implements ModuleDefinitionInterface
{
    public function registerAutoloaders(DiInterface $di = null)
    {
        $loader = new Loader();
        $loader->setNamespaces([
            'F\Front\Controllers' => APP_PATH . '/front/controllers/',
            'F\Front\Models'      => APP_PATH . '/front/models/',
            'F\Libraries\BackupDB'    => BASE_PATH . '/library/',
            'F\Libraries\RQueue'    => BASE_PATH . '/library/',
            'PHPMailer\PHPMailer' => BASE_PATH . '/library/phpMailer/',
        ]);
        $loader->setClasses([
            'PHPMailer' => BASE_PATH . '/library/phpMailer/PHPMailer.php',
            'SMTP' => BASE_PATH . '/library/phpMailer/SMTP.php',
            'FPDF' => BASE_PATH . '/library/fpdf.php',
            'RedisQueueHandler' => BASE_PATH . '/library/RedisQueueHandler.php',
            'DbBackup' => BASE_PATH . '/library/DbBackup.php',
        ]);        
        $loader->setDirectories(array(
            APP_PATH . '/front/models/',
            APP_PATH . '/front/forms/',
            BASE_PATH . '/plugins/',
            BASE_PATH . '/library/',
            BASE_PATH . '/helpers/',
        ),true);
        $loader->setFiles([
            BASE_PATH . '/library/fpdf.php',
            BASE_PATH . '/library/RedisQueueHandler.php',
            BASE_PATH . '/library/DbBackup.php',
            BASE_PATH . '/library/phpMailer/PHPMailer.php',
        ]);
        //$loader->setExtensions([ "php","inc","volt","html"]); 
        // Listen all the loader events
        if(defined('ENVIRONMENT') === 'DEVELOPMENT'){
            $eventsManager = new evManager();
            $eventsManager->attach("loader:beforeCheckPath",function (Event $event, Loader $loader) {
                echo($loader->getCheckedPath());
            });
            $loader->setEventsManager($eventsManager);
        }
        if(false === $loader->isRegistered()) {
            $loader->register();
        } 
        //$loader->register();
        #var_dump($loader->getDebug());               
    }
    public function registerServices(DiInterface $di)
    {
        require_once(APP_PATH . '/config/config.php');
        $di->setShared('config', $config);
        $di->setShared('url', function() use ($config){
            $url = new UrlResolver();
            $url->setBaseUri($config->appF->baseUri);
            if($config->settings->production === true){$url->setStaticBaseUri($config->appF->StaticBaseUri);}  //For CDN Uri
            return $url;
        }); 

    // Registering a dispatcher
        $di->set('dispatcher',function () {
            $eventManager = new evManager();
            //$eventManager->attach('dispatch:beforeForward', function(Event $event, $dispatcher, DispatcherException $exception){});
            //$eventManager->attach('dispatch:beforeExecuteRoute', function(Event $event, $dispatcher, DispatcherException $exception){});
            //$eventManager->attach('dispatch:afterExecuteRoute', function(Event $event, $dispatcher, DispatcherException $exception){});
            $eventManager->attach("dispatch:beforeException", function (Event $event, $dispatcher, DispatcherException $exception = null) {
            $action = 'show503';
            if($exception instanceof DispatcherException){
            $action = 'show404';
                switch ($exception->getCode()){
                    case DispatcherException::EXCEPTION_HANDLER_NOT_FOUND:
                    case DispatcherException::EXCEPTION_INVALID_HANDLER:
                    case DispatcherException::EXCEPTION_ACTION_NOT_FOUND:
                    case DispatcherException::EXCEPTION_INVALID_PARAMS:
                    case DispatcherException::EXCEPTION_CYCLIC_ROUTING:
                    case DispatcherException::EXCEPTION_NO_DI:
                    $dispatcher->forward(array('controller' => 'error','action' => $action));
                return false;
                }
            }else{$dispatcher->forward(array('controller' => 'error','action' => $action));}
            }); 
            $dispatcher = new Dispatcher();
            $dispatcher->setDefaultNamespace('F\Front\Controllers');
            $dispatcher->setEventsManager($eventManager);
            return $dispatcher;
        },true);

        # Registering the view component
        $di->setShared('voltService',function (ViewBaseInterface $view) use ($config) {
            if(true !== is_dir(BASE_PATH . $config->appF->cacheDir)){ mkdir(BASE_PATH . $config->appF->cacheDir, 777,true); }
            $volt = new Volt($view);
            $always = defined('ENVIRONMENT') === 'DEVELOPMENT' ? true : false;
            $volt->setOptions([
                'always'    => $always,
                'extension' => '.php',
                'separator' => '_',
                'stat'      => true,
                'path'      => BASE_PATH . $config->appF->cacheDir,
                'prefix'    => '%%',
            ]);
            return $volt;
        });
        # View
        $di->set('view', function() use ($config){
            $view = new View();
            $view->setViewsDir(APP_PATH . $config->appF->viewsDir);
            $view->registerEngines(['.volt' => 'voltService',]);
            return $view;
        });
        # Database        
        $di->setShared('db', function() use ($config){
            $db = new DbAdapter(array(
                'adapter'   => $config->database->mysql->adapter,
                'host'      => $config->database->mysql->host,
                'username'  => $config->database->mysql->username,
                'password'  => $config->database->mysql->password,
                'dbname'    => $config->database->mysql->dbname,
                'charset'   => $config->database->mysql->charset,
                'options'   => array(
                \PDO::MYSQL_ATTR_INIT_COMMAND       => 'SET NAMES utf8mb4, time_zone = "+06:00"',
                \PDO::ATTR_CASE                     => \PDO::CASE_LOWER,
                \PDO::ATTR_DEFAULT_FETCH_MODE       => \PDO::FETCH_BOTH,
                \PDO::ATTR_ERRMODE                  => \PDO::ERRMODE_EXCEPTION,
                \PDO::ATTR_PERSISTENT               => FALSE,
                \PDO::MYSQL_ATTR_USE_BUFFERED_QUERY => TRUE,
                \PDO::MYSQL_ATTR_COMPRESS           => TRUE,
                \PDO::ATTR_AUTOCOMMIT               => TRUE, 
                #\PDO::MYSQL_ATTR_SSL_CA             => "/home/ubuntu/YOUR_PEM_FILE_HERE",
                )
            ));
            return $db;
        }); 
        # Session
        # For Redis
        // $di->setShared('session', function(){
        //     $options = [
        //         'host'  => '127.0.0.1',
        //         'port'  => 6379,
        //         'index' => '1',
        //     ];
        //     $session           = new SessionManager();
        //     $serializerFactory = new SerializerFactory();
        //     $factory           = new AdapterFactory($serializerFactory);
        //     $redis             = new Redis($factory, $options);
        //     $session->setAdapter($redis)->start();
        //     return $session;
        // });
        # For Stream
    	$di->set('session', function() use ($config) {
    		$session = new SessionManager();
            if(true !== is_dir(BASE_PATH . $config->appF->sessionDir)){ mkdir(BASE_PATH . $config->appF->sessionDir, 0775,true); }
    		# $files = new Stream(array('savePath' => BASE_PATH . $config->appF->sessionDir,));
            $files = new Stream();
            if(session_status() === PHP_SESSION_NONE || session_status() !== PHP_SESSION_ACTIVE)
            {
                //setcookie("PHPSESSID", "", time() - 3600, '/',$config->appF->baseUri,true,true);
                $session->setAdapter($files)->start();
            }
            return $session;
    	});
        # Security
        $di->set('security', function() {
            $security= new Security();
            $security->setWorkFactor(12);// Set the password hashing factor to 12 rounds
            $security->setDefaultHash(Security::CRYPT_MD5);
            return $security;
        }, true);
        # Crypt
        $di->set('crypt',function() use ($config){
            $crypt = new Crypt();
            $crypt->setKey($config->appF->encryptKey);
            return $crypt;
        },true);        
        # Cookies
        $di->set('cookies', function() {
            $cookies = new Cookies();
            $cookies->useEncryption(true);
            return $cookies;
        },true);
        # Escaper
        $di->set('escaper', function() {return new Escaper();},true);
        # Cache
        $di->set('cache', function(){
            $serializerFactory = new SerializerFactory();
            $options = [
                'defaultSerializer' => 'Json',
                'lifetime'          => 7200,
            ];
            $cache = new Apcu($serializerFactory, $options); 
            return $cache;
        });       
        # Queue     
        $di->setShared('redisQueue', function () use ($config) {

            // $jsonSerializer = new Json();
            // $factory        = new SerializerFactory();
            // $jsonSerializer = $factory->newInstance('json');

            $serializerFactory = new SerializerFactory();

            $options = [
                'defaultSerializer' => 'Json',
                'lifetime'          => 7200,
                'host'              => $config->redis->host,
                'port'              => $config->redis->port,
                'index'             => 1,
            ];

            $redis = new Redis($serializerFactory, $options);

           // $redis->auth($config->redis->password);
            return $redis;
        });
        # ACL
        # Logging
        // $di->set('logger', function(){
        //     $adapter = new Stream('/cache/logs/main.log');
        //     $logger = new Logger(
        //         'messages',[ 'main' => $adapter, ]
        //     );
        //     $logger->critical("This is a critical message");
        //     return $logger;
        // });
        # PHPMailer
        $di->set('pmailer', function() use ($config){
        include_once($config->appF->baseUri . "library/phpMailer/PHPMailer.php");
        include_once($config->appF->baseUri . "library/phpMailer/Exception.php");
        include_once($config->appF->baseUri . "library/phpMailer/SMTP.php");
        $pmailer = new \PHPMailer\PHPMailer\PHPMailer(true);
        #$pmailer->setLanguage('bn', '/optional/path/to/language/directory/');
        $pmailer->isSMTP(true);
        $pmailer->isHTML(true);
        $pmailer->SMTPAuth = true;
        $pmailer->SMTPKeepAlive = false; //Prevents the SMTP connection from being closed after each mail sending. If this is set to true 
        #$pmailer->SMTPDebug = 3;  // Enable verbose debug output
        $pmailer->Encoding = "base64";
        $pmailer->Mailer = "smtp";
        $pmailer->WordWrap = 70;
        $pmailer->Priority = 1;
        $pmailer->Charset = $config->mail->charset;
        $pmailer->Host = $config->mail->host;
        $pmailer->ConfirmReadingTo = $pmailer->Username = $config->mail->username;
        $pmailer->setFrom($config->mail->email, $config->mail->name);
        $pmailer->Password = $config->mail->password;
        $pmailer->SMTPSecure = $config->mail->security;
        $pmailer->Port = $config->mail->port;
        $pmailer->SMTPOptions = array('ssl' => array('verify_peer' => false,'verify_peer_name' => false,'allow_self_signed' => true));
        $pmailer->AddCustomHeader("X-pmrqc: 1");
        $pmailer->addCustomHeader("X-Priority: 1");
        $pmailer->AddCustomHeader("X-MSMail-Priority: High");  // Not sure if Priority will also set the Importance header:
        $pmailer->AddCustomHeader("Importance: High");
        $pmailer->AddCustomHeader("X-Originating-IP:".$_SERVER['SERVER_ADDR']." \r\n");
        $pmailer->AddCustomHeader("Senders IP: ".$_SERVER['REMOTE_ADDR']." \r\n");
        $pmailer->AddCustomHeader("MIME-Version: 1.0 \r\n");
        $pmailer->AddCustomHeader("Return-Path: ".$pmailer->ConfirmReadingTo." \r\n");
        $pmailer->AddCustomHeader("X-Mailer: Phalcon- ".phpversion()." \r\n");
        $pmailer->AddCustomHeader("X-Confirm-Reading-To: ".$pmailer->ConfirmReadingTo); //For the reading confirmations:
        $pmailer->AddCustomHeader("Return-Receipt-To: ".$pmailer->ConfirmReadingTo);
        $pmailer->AddCustomHeader("Disposition-Notification-To: ".$pmailer->ConfirmReadingTo); //For delivery confirmations:
        return $pmailer;
        });
    }    
//EOF
}

