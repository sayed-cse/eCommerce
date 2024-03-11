<?php
use Phalcon\Di\FactoryDefault;
use Phalcon\Mvc\Router;
$di->set('router', function(){
$router = new Router();
$router->setDI(new FactoryDefault());
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
        'params'     =>  3,
    ))->setName('front-default');  
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
    ])->setName('backend-mini');
# ERROR
    // $router->add('', [
    //     'module'     => 'front',
    //     'controller' => 'error',
    //     'action'    => 'index'

    // ])->setName('notFound');     
#    
    $router->handle($_SERVER["REQUEST_URI"]);
    return $router;
});


