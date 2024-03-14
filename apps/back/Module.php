<?php declare(strict_types=1);
namespace F\Back;
use Phalcon\Autoload\Loader;
use Phalcon\Di\DiInterface;
use Exception;
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
// use Phalcon\Storage\AdapterFactory;
// use Phalcon\Storage\SerializerFactory;
use Phalcon\Session\Adapter\Files as SessionAdapter;
use Phalcon\Session\Manager as SessionManager;
use Phalcon\Session\Adapter\Stream as Stream;
use Phalcon\Flash\Session as FlashSession;

class Module implements ModuleDefinitionInterface
{
    public function registerAutoloaders(DiInterface $di = null)
    {
        $loader = new Loader();
    #Register NameSpaces
        $loader->setNamespaces([
            'F\Back\Controllers' => APP_PATH . '/back/controllers/',
            'F\Back\Models'      => APP_PATH . '/back/models/',
            'F\Libraries\BackupDB'    => BASE_PATH . '/library/',
            'PHPMailer\PHPMailer' => BASE_PATH . '/library/phpMailer/',
        ]);
    # Register Classes    
        $loader->setClasses([
            'PHPMailer' => BASE_PATH . '/library/phpMailer/PHPMailer.php',
            'SMTP' => BASE_PATH . '/library/phpMailer/SMTP.php',
            'FPDF' => BASE_PATH . '/library/fpdf.php',
            'QRPHP' => BASE_PATH . '/library/qrphp.php',
            'DbBackup' => BASE_PATH . '/library/DbBackup.php',
        ]);
    # Register Dir          
        $loader->setDirectories(array(
            APP_PATH . '/back/models/',
            APP_PATH . '/back/forms/',
            BASE_PATH . '/plugins/',
            BASE_PATH . '/library/',
            BASE_PATH . '/helpers/',
        ),true);
    # Register Files    
        $loader->setFiles([
            BASE_PATH . '/library/fpdf.php',
            BASE_PATH . '/library/qrphp.php',
            BASE_PATH . '/library/DbBackup.php',
            BASE_PATH . '/library/phpMailer/PHPMailer.php',
        ]);
        if(false === $loader->isRegistered()) { $loader->register(); } 
    }
    public function registerServices(DiInterface $di = null)
    {
        require(APP_PATH . '/config/config.php');
        $di->setShared('config', $config);        

        $di->setShared('url', function() use ($config){
          $url = new UrlResolver();
          $url->setBaseUri($config->appB->BaseUri);
          if($config->settings->production === true){$url->setStaticBaseUri($config->appB->StaticBaseUri);}  //For CDN Uri  
          return $url;
        });         
        // Registering a dispatcher
        $di->set('dispatcher',function () {
            $eventManager = new evManager();
            // $eventManager->attach("dispatch:afterUpdate", function (Event $event, $dispatcher, $model = null) {
            //     if ($model instanceof Model) {
            //         $backupFolderPath = BASE_PATH . "/public/schemas";
            //         $backup = new \F\Back\Libraries\DbBackup($model->getDI()->get('db'), $backupFolderPath);
            //         $backup->backupDatabase();
            //     }
            // });
            $eventManager->attach("dispatch:beforeException", function (Event $event, $dispatcher, DispatcherException $exception = null) {
            $action = 'show503';
            if($exception instanceof DispatcherException){
            $action = 'show404';
                switch ($exception->getCode()){
                    case DispatcherException::EXCEPTION_HANDLER_NOT_FOUND:
                    case DispatcherException::EXCEPTION_INVALID_HANDLER:
                    case DispatcherException::EXCEPTION_ACTION_NOT_FOUND:
                    case DispatcherException::EXCEPTION_INVALID_PARAMS:
                    $dispatcher->forward(array('controller' => 'error','action' => $action));
                return false;
                }
            }else{$dispatcher->forward(array('controller' => 'error','action' => $action));}
            }); 
            $dispatcher = new Dispatcher();
            $dispatcher->setDefaultNamespace('F\Back\Controllers');
            $dispatcher->setEventsManager($eventManager);
            return $dispatcher;
        },true);

        # Registering the view component
        $di->setShared('voltService',function (ViewBaseInterface $view) use ($config) {
            if(true !== is_dir(BASE_PATH . $config->appB->cacheDir)){ mkdir(BASE_PATH . $config->appB->cacheDir, 777,true); }
            $volt = new Volt($view);
            $volt->setOptions(
                [
                    'always'    => true,
                    'extension' => '.php',
                    'separator' => '_',
                    'stat'      => true,
                    'path'      => BASE_PATH . $config->appB->cacheDir,
                    'prefix'    => '%%',
                ]
            );
            return $volt;
        });

        $di->set('view',function () use ($config){
            $view = new View();
            $view->setViewsDir(APP_PATH . $config->appB->viewsDir);
            $view->registerEngines([ '.volt' => 'voltService', ]);
            return $view;
        },true);

# Database        
    $di->setShared('db', function() use ($config) {
        #if(true !== is_dir(BASE_PATH . '/public/schemas')){ mkdir(BASE_PATH . '/public/schemas', 777,true); }
        $db = new DbAdapter([
            'adapter'   => $config->database->mysql->adapter,
            'host'      => $config->database->mysql->host,
            'username'  => $config->database->mysql->username,
            'password'  => $config->database->mysql->password,
            'dbname'    => $config->database->mysql->dbname,
            'charset'   => $config->database->mysql->charset,
            'options'   => [
                \PDO::MYSQL_ATTR_INIT_COMMAND       => 'SET NAMES utf8mb4, time_zone = "+06:00"',
                \PDO::ATTR_CASE                     => \PDO::CASE_LOWER,
                \PDO::ATTR_DEFAULT_FETCH_MODE       => \PDO::FETCH_BOTH,
                \PDO::ATTR_ERRMODE                  => \PDO::ERRMODE_EXCEPTION,
                \PDO::ATTR_PERSISTENT               => false,                       
                \PDO::MYSQL_ATTR_USE_BUFFERED_QUERY => true,
                \PDO::MYSQL_ATTR_COMPRESS           => true,
                \PDO::ATTR_AUTOCOMMIT               => true,             
                // Uncomment the line below if you're using SSL
                // \PDO::MYSQL_ATTR_SSL_CA             => "/home/ubuntu/YOUR_PEM_FILE_HERE",
            ]
        ]);
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
    $di->set('session', function() use ($config){
        $session = new SessionManager();
        # if(true !== is_dir(BASE_PATH . $config->appF->sessionDir)){ mkdir(BASE_PATH . $config->appF->sessionDir, 0777,true); }        
        #$files = new Stream(array('savePath' => BASE_PATH . $config->appB->sessionDir,));
        $files = new Stream();
        $session->setAdapter($files)->start();      
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
    # Cache
    # Queue
    # ACL
    # Logging       
#EOF        
    }
}
