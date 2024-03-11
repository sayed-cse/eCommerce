<?php declare(strict_types=1);
namespace F\Back\Controllers;
use Phalcon\Mvc\Controller;
use Phalcon\Http\Request;
use Phalcon\Tag;
class BaseController extends Controller
{
    protected function initialize()
    {  	 
        Tag::setTitleSeparator('::');
        Tag::prependTitle('Kiyani');        
        #Tag::appendTitle('::');
        Tag::setTitle('A Most Trusted Online Shopping in Bangladesh');
        $this->view->siteName = $this->view->articlePublisher = $this->view->dynaArticleTitle = $this->view->dynaArticle = 'Kiyani';
        $this->view->bizTel = '+8801965573738';
        $this->view->bizMail = 'sales@kiyani.com';
        $this->view->copyYear = '2023';       
        $this->view->dynarobot = "noindex,nofollow,noarchive,nosnippet,noodp,noydir,noimagechache";
        $this->view->dynadesc = 'Online Shopping at a cheapest price for Automotive, Phones &amp; Accessories, Computers &amp; Electronics, Fashion, Beauty &amp; Health, Home &amp; Garden, Toys &amp; Sports, Weddings &amp; Events and more; just about anything else
Enjoy Free Shipping! Limited Time Sale Easy Return.';
        $this->view->dynakey = 'Kiyani, kiyani.com, Online shopping, Automotive, Phones & Accessories, Computers & Electronics, Fashion, Beauty & Health, Home & Garden, Toys & Sports, Weddings & Events,Buy, Sale, Online shopping, Automotive, Phones, Accessories, Computers, Electronics, Fashion, Beauty, Health, Home, Garden, Toys, Sports, Weddings';
        $this->view->dynagooglebot = 'noindex,nofollow';
        $this->view->dynaGetAuthor = 'FireFly';
        $this->view->author = '\/\/ebmaster:+880 1615577997,+880 1915577997';
        $this->view->googleKey = '';
        $this->view->dynaOgImg = 'img/favicon.png';       
        if($this->session->exists())
        {
            $uid = $this->session->get('id');$name = $this->session->get('uname');$active = $this->session->get('active');$level = $this->session->get('level');$type = $this->session->get('type');            
        }else{ $uid = $name = $active = $level = $type = 0; }
        $this->view->uid = $uid;
        $this->view->uname = $name;
        $this->view->active = $active;
        $this->view->level = $level;
        $this->view->type = $type;
        //$this->view->userip = $this->getuserip();


    }
	// public function beforeExecuteRoute() {




	// /* 
	//  * Force HTTPS. 
	//  */
	// if(!$this->request->isSecureRequest()){
	//     $url = "https://" . $_SERVER["HTTP_HOST"] . $_SERVER["REQUEST_URI"];
	//     $this->response->redirect($url);
	//     return false;
	// }
	// return true;
	// }       
}

