<?php declare(strict_types=1);
namespace F\Front\Controllers;
use F\Front\Models\Category as Categories;
use F\Front\Models\Cart as Cart;
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
        $this->view->cats = Categories::find();
        $uid = $this->session->get('id');
        $type = $this->session->get('type');        
        $query = Cart::find(['conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3)','bind' => [1 => $uid, 2 => $type, 3 => '0']]);
        $this->view->mycart = $query->count() > 0 ?  $query->count() : '0';        
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
        $this->view->cats = Categories::find();
        $uid = $this->session->get('id');
        $type = $this->session->get('type');        
        $query = Cart::find(['conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3)','bind' => [1 => $uid, 2 => $type, 3 => '0']]);
        $this->view->mycart = $query->count() > 0 ?  $query->count() : '0';         
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