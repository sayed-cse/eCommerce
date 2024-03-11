<?php declare(strict_types=1);
error_reporting(E_ALL);
ini_set("session.cookie_httponly", True);
ini_set("session.cookie_secure", True);
ini_set("session.cookie_samesite", "Strict"); 
ini_set("session.cookie_lifetime", 0);
ini_set('session.use_trans_sid', 0);
ini_set('assert.active', 0);
setlocale(LC_ALL, 'en_US.UTF-8');
mb_internal_encoding('UTF-8');
date_default_timezone_set("Asia/Dhaka");
if(!defined('ENVIRONMENT')){define('ENVIRONMENT', 'DEVELOPMENT');}
if(defined('ENVIRONMENT') === 'DEVELOPMENT')
{
    if(!class_exists("Imagick") || !extension_loaded('imagick') and !extension_loaded('psr')){ die("Requires the Imagick & psr extension to run."); }
    if(!class_exists("\\Phalcon\Support\Version")){ die("Requires the Phalcon extension to run."); }
    echo(function_exists('opcache_get_status') and opcache_get_status()['jit']['enabled']) ? 'JIT enabled' : 'JIT disabled';
}
use Phalcon\Di\FactoryDefault;
use Phalcon\Mvc\Application;
#use Phalcon\Mvc\View;
(new \Phalcon\Support\Debug())->listen();
defined('BASE_PATH') || define('BASE_PATH', dirname(__DIR__));
defined('APP_PATH') || define('APP_PATH', BASE_PATH . '/apps');
if(defined('ENVIRONMENT') === 'DEVELOPMENT'){ if(!file_exists(APP_PATH . '/config/config.php')){ die("Configuration file missing."); } }

$di = new FactoryDefault();
$app = new Application($di);
require_once(APP_PATH . '/config/routes.php');
$app->registerModules(
    array(
        'front' => array(
            'className' => \F\Front\Module::class,
            'path'      => APP_PATH . '/front/Module.php',
        ),
        'back'  => array(
            'className' => \F\Back\Module::class,
            'path'      => APP_PATH . '/back/Module.php',
        )
    )
);

try {    
    //echo $app->handle(substr($_SERVER['REQUEST_URI'], strlen('/F/')-1) )->getContent(); //OR
    //$response = $app->handle($_SERVER["REQUEST_URI"]); //OR Required Set BaseUri
    $response = $app->handle(substr($_SERVER["REQUEST_URI"], strlen('/f/')-1));
    $response->send();
} catch (\Exception $e) {
    echo($e->getMessage());
    echo get_class($e),':: ',$e->getMessage(), PHP_EOL;
    echo " File=", $e->getFile(), PHP_EOL;
    echo " Line=", $e->getLine(), PHP_EOL;
    echo " Trace=", $e->getTrace(), PHP_EOL;
    echo " Previous=", $e->getPrevious(), PHP_EOL;
    echo " Line=", $e->getCode(), PHP_EOL;
    echo nl2br(htmlentities($e->getTraceAsString()));    
}
