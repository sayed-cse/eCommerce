<?php declare(strict_types=1);
namespace F\Back\Controllers;
class ErrorController extends BaseController
{    
    public function initialize()
    {
        parent::initialize();
        $this->view->dynaOgImg = "/img/favicon.png";
        $this->view->dynarobot = "noindex,nofollow,noarchive,nosnippet,noodp,noydir,noimagechache";
        $this->view->dynagooglebot = "noindex,nofollow";          
    }
    public function show503Action()
    {
        $this->view->dynaArticleTitle = "Error 503 Service Unavailable";
        $this->view->dynaArticle = "Error 404 page not found";
        $this->view->dynaOgUrl = $this->router->getControllerName();
        $this->view->dynadesc = "Error 503 Service Unavailable";
        $this->view->dynakey = "503, service Unavailable, internal server error";
        $this->response->setHeader('HTTP/1.1 503','Service Unavailable');     
        $this->response->setStatusCode(503, 'Service Unavailable');
        $this->view->pick('errors/503');
    }
    public function show404Action()
    {
        $this->view->dynaArticleTitle = "Error 404 page not found";
        $this->view->dynaArticle = "Error 404 page not found";
        $this->view->dynaOgUrl = $this->router->getControllerName();
        $this->view->dynadesc = "Error 404 page not found";
        $this->view->dynakey = "404, not found";             
        $this->response->setHeader('HTTP/1.0 404','Not Found');     
        $this->response->setStatusCode(404, 'Not Found');         
        $this->view->pick('errors/404');
    }
}