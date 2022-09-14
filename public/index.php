<?php declare(strict_types=1);
error_reporting(E_ALL);
setlocale(LC_ALL, 'en_US.UTF-8');
mb_internal_encoding('UTF-8');
(new \Phalcon\Support\Debug())->listen();
if(!defined('ENVIRONMENT')){define('ENVIRONMENT', 'DEVELOPMENT');}
// if(defined('ENVIRONMENT') === 'DEVELOPMENT'){
//     if(!extension_loaded('psr')) { die("Requires the PHP PSR extension to run."); }
//     if(!class_exists("\\Phalcon\Support\Version")){ die("Requires the Phalcon extension to run."); }
//     if(!class_exists("Imagick") || !extension_loaded('imagick')){ die("Requires the Imagick extension to run."); }
// }
use Phalcon\Di\FactoryDefault;
use Phalcon\Mvc\Application;
defined('BASE_PATH') || define('BASE_PATH', dirname(__DIR__));
defined('APP_PATH') || define('APP_PATH', BASE_PATH . '/apps');
#if(defined('ENVIRONMENT') === 'DEVELOPMENT'){ if(!file_exists(APP_PATH . '/config/config.php')){ die("Configuration file missing."); } }
$di = new FactoryDefault();
$app = new Application($di);
require(APP_PATH . '/config/routes.php');
try {
    $app->registerModules(array(
        'front' => array(
            'className' => \F\Front\Module::class,
            'path'      => APP_PATH . '/front/Module.php',
        ),
        'back'  => array(
            'className' => \F\Back\Module::class,
            'path'      => APP_PATH . '/back/Module.php',
        )
    ));    
    //echo $app->handle(substr($_SERVER['REQUEST_URI'], strlen('/F/')-1) )->getContent(); //OR
    //$response = $app->handle($_SERVER["REQUEST_URI"]); //OR Required Set BaseUri
    $response = $app->handle(substr($_SERVER["REQUEST_URI"], strlen('/f/')-1));
    $response->send();
} catch (\Exception $e) {
    echo($e->getMessage());
    echo get_class($e),':: ',$e->getMessage(), "\n";
    echo " File=", $e->getFile(), "\n";
    echo " Line=", $e->getLine(), "\n";
    echo " Line=", $e->getTrace(), "\n";
    echo " Line=", $e->getPrevious(), "\n";
    echo " Line=", $e->getCode(), "\n";
    echo nl2br(htmlentities($e->getTraceAsString()));    
}
