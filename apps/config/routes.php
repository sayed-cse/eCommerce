<?php declare(strict_types=1);
use Phalcon\Mvc\Router;
$di->set('router', function(){
$router = new Router();
#
$router->setDefaultModule('front');
$router->setDefaultNamespace('F\Front\Controllers');
$router->setDefaultController('index');
$router->setDefaultAction('index');
# Remove Extra Trailing Slashes
$router->removeExtraSlashes(true);

# FRONTEND
$router->add('/f/', array(
    'module'     =>  'front',
    'namespace'  =>  'F\Front\Controllers',
    'controller' =>  1,
    'action'     =>  2,
    'params'     =>  3
))->setName('front-default');


// $router->add('/f/:module/:namespace/:controller/:action/:params', array(
//     'module'     =>  'front',
//     'namespace'  =>  'F\Front\Controllers',
//     'controller' =>  1,
//     'action'     =>  2,
//     'params'     =>  3
// ))->setName('front-default');



# BACKEND
$router->add('/back', [
    'module'     => 'back', 
    'namespace'  => 'F\Back\Controllers',
    'controller' => 'index',
    'action'     => 'index'
])->setName('back-default');

$router->add('/back/:controller/:action/:params', [
    'module'     => 'back',
    'namespace'  => 'F\Back\Controllers',
    'controller' => 1,
    'action'     => 2,
    'params'     => 3
])->setName('back-full');

$router->add('/back/:controller/:action', [
    'module'     => 'back',
    'namespace'  => 'F\Back\Controllers',
    'controller' => 1,
    'action'     => 2,
])->setName('back-short');

$router->add('/back/:controller', [
    'module'     => 'back',
    'namespace'  => 'F\Back\Controllers',
    'controller' => 1
]);
#   
    $uri = str_replace($_SERVER["SCRIPT_NAME"], "", $_SERVER["REQUEST_URI"]);
    $router->handle($uri);
    return $router;
});

