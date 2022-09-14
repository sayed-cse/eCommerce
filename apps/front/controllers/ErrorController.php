<?php declare(strict_types=1);
namespace F\Front\Controllers;

/**
 * ErrorController 
 */
class ErrorController extends BaseController
{
    
    public function initialize()
    {
        parent::initialize();
    }
    public function show503Action()
    {
        echo('this is status message from controller 503');
    }
    public function show404Action()
    {
        $ogImg = "/img/favicon.png";
        $this->view->setVar('dynaOgImg',$ogImg);
        $og_articleTitle = "Error 404 page not found";
        $this->view->setVar('dynaArticleTitle',$og_articleTitle);
        $og_article = "Error 404 page not found";
        $this->view->setVar('dynaArticle',$og_article);
        $og_url = $this->router->getControllerName();
        $this->view->setVar('dynaOgUrl',$og_url);
        $description = "Error 404 page not found";
        $this->view->setVar("dynadesc", $description);
        $keywords = "";
        $this->view->setVar("dynakey", $keywords);
        $metaIndex = "noindex,nofollow";
        $this->view->setVar("dynarobot", $metaIndex);
        $this->view->setVar("dynagooglebot", $metaIndex);               
        $this->response->setHeader('HTTP/1.0 404','Not Found');     
        $this->response->setStatusCode(404, 'Not Found');         
        $this->view->pick('errors/404');
    } 
}