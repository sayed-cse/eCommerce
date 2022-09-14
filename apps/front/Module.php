<?php declare(strict_types=1);
namespace F\Front;
use Phalcon\Autoload\Loader;
use Phalcon\Di\DiInterface;
use Phalcon\Mvc\Dispatcher;
use Phalcon\Events\Event;
use Phalcon\Events\Manager as evManager;
use Phalcon\Mvc\Dispatcher\Exception;
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
use Phalcon\Mvc\Model\Manager as modelsManager;
// use Phalcon\Session\Adapter\Redis;
// use Phalcon\Storage\AdapterFactory;
// use Phalcon\Storage\SerializerFactory;
use Phalcon\Session\Manager as SessionManager;
use Phalcon\Session\Adapter\Stream as Stream;
use Phalcon\Flash\Session as FlashSession;
use \PHPMailer as PHPMailer;
use \Fire;
// use PHPMailer\PHPMailer\SMTP;
// use PHPMailer\PHPMailer\Exception;

class Module implements ModuleDefinitionInterface
{
    public function registerAutoloaders(DiInterface $di = null)
    {
        $eventsManager = new evManager();
        $loader = new Loader();
        $loader->setNamespaces([
            'F\Front\Controllers'   => APP_PATH . '/front/controllers/',
            'F\Front\Models'        => APP_PATH . '/front/models/',
            'F\Library'             => BASE_PATH . '/library/',
            'PHPMailer\PHPMailer'   => BASE_PATH . '/library/phpMailer/',
        ]);
        $loader->setClasses([
            'PHPMailer' => BASE_PATH . '/library/PHPMailer/PHPMailer.php',
            'Fire'      => BASE_PATH . '/library/fire.php',
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
            BASE_PATH . '/library/fire.php',
            //BASE_PATH . '/library/phpMailer/PHPMailer.php',
        ]);
        //$loader->setExtensions([ "php","inc","volt","html", ]); 
        // Listen all the loader events
        if(defined('ENVIRONMENT') === 'DEVELOPMENT'){
            $eventsManager->attach("loader:beforeCheckPath",function (Event $event, Loader $loader) {
                echo($loader->getCheckedPath());
            });
            $loader->setEventsManager($eventsManager);            
        }
        $loader->register();
    }
    public function registerServices(DiInterface $di)
    {
        require(APP_PATH . '/config/config.php');
        $di->setShared('config', $config);        

        $di->setShared('url', function() use ($config){
            $url = new UrlResolver();
            $url->setBaseUri($config->appF->baseUri);
            //if($config->settings->production === true){$url->setStaticBaseUri($config->appF->StaticBaseUri);}  //For CDN Uri        
            return $url;
        }); 
        # Registering a dispatcher
        $di->set('dispatcher',function () {
            $dispatcher = new Dispatcher();
            $dispatcher->setDefaultNamespace('F\Front\Controllers');
            return $dispatcher;
        });
        # Registering the view component
        $di->setShared('voltService',function (ViewBaseInterface $view) use ($config) {
            if(true !== is_dir(BASE_PATH . $config->appF->cacheDir)){ mkdir(BASE_PATH . $config->appF->cacheDir, 0777,true); }
            $volt = new Volt($view);
            $volt->setOptions([
                'always'    => true,
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
                \PDO::ATTR_PERSISTENT               => FALSE,
                \PDO::ATTR_DEFAULT_FETCH_MODE       => \PDO::FETCH_BOTH,
                \PDO::ATTR_EMULATE_PREPARES         => FALSE,
                \PDO::MYSQL_ATTR_USE_BUFFERED_QUERY => TRUE,   
                \PDO::ATTR_ERRMODE                  => \PDO::ERRMODE_EXCEPTION,     
                )
            ));
            return $db;
        }); 
        # For Model Manager
        $di->set('modelsManager', function() { return new modelsManager(); });       
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
            # if(true !== is_dir(BASE_PATH . $config->appF->sessionDir)){ mkdir(BASE_PATH . $config->appF->sessionDir, 0777,true); }
    		# $files = new Stream(array('savePath' => BASE_PATH . $config->appF->sessionDir,));
            $files = new Stream();
            $session->setAdapter($files)->start();                    
            return $session;        
    	});
        # Security        
        $di->set('security', function() {
            $security = new Security();
            $security->setWorkFactor(12);// Set the password hashing factor to 12 rounds
            $security->setDefaultHash(Security::CRYPT_MD5);
            return $security;
        }, true);
        # Cookies
        $di->set('cookies', function() {
            $cookies = new Cookies();
            $cookies->useEncryption(true);
            return $cookies;
        },true);
        # Cache
        # Queue
        # ACL
        # Logging
        $di->set('fire', function(){
            $fires = new Fire();
            return $fires;
        },true);
        # PHPMailer
        include(BASE_PATH . '/library/phpMailer/PHPMailer.php');
        $di->set('pmailer', function() use ($config){
        $pmailer = new \PHPMailer(true);
        //$pmailer->setLanguage('en', '/optional/path/to/language/directory/');
        $pmailer->isSMTP(true);
        $pmailer->isHTML(true);
        $pmailer->SMTPAuth = true;
        $pmailer->SMTPDebug = 3;  // Enable verbose debug output
        $pmailer->SMTPOptions = array('ssl' => array('verify_peer' => false,'verify_peer_name' => false,'allow_self_signed' => true));
        $pmailer->Charset = $config->mail->charset;
        $pmailer->Host = $config->mail->host;
        $pmailer->Username = $config->mail->username;
        $pmailer->Password = $config->mail->password;
        $pmailer->SMTPSecure = $config->mail->security;
        $pmailer->Port = $config->mail->port;
        $pmailer->addAddress($config->mail->email,$config->mail->name);
        return $pmailer;
        });


    }    
}

