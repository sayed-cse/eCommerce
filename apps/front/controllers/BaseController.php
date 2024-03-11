<?php declare(strict_types=1);
namespace F\Front\Controllers;
#use Phalcon\Support\Version;
use Phalcon\Mvc\Controller;
use Phalcon\Http\Request;
use Phalcon\Tag;
#use F\Frontend\Models\Notify as Notify;
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
        $this->view->dynarobot = 'index,follow';
        $this->view->dynadesc = 'Online Shopping at a cheapest price for Automotive, Phones &amp; Accessories, Computers &amp; Electronics, Fashion, Beauty &amp; Health, Home &amp; Garden, Toys &amp; Sports, Weddings &amp; Events and more; just about anything else
Enjoy Free Shipping! Limited Time Sale Easy Return.';
        $this->view->dynakey = 'Kiyani, kiyani.com, Online shopping, Automotive, Phones & Accessories, Computers & Electronics, Fashion, Beauty & Health, Home & Garden, Toys & Sports, Weddings & Events,Buy, Sale, Online shopping, Automotive, Phones, Accessories, Computers, Electronics, Fashion, Beauty, Health, Home, Garden, Toys, Sports, Weddings';
        $this->view->dynagooglebot = 'index,follow';
        $this->view->dynaGetAuthor = 'FireFly';
        $this->view->author = '\/\/ebmaster:+880 1615577997,+880 1915577997';
        $this->view->googleKey = 'sdfewr3p43432432&^*(*&(*dfdg65ASDADS';
        $this->view->dynaOgImg = 'img/favicon.png';       
        $this->view->uid = $this->session->get('id') ? $this->session->get('id') : 0;
        $this->view->uname = $this->session->get('uname') ? $this->session->get('uname') : 0;
        $this->view->active = $this->session->get('active') ? $this->session->get('active') : 0;
        $this->view->level = $this->session->get('level') ? $this->session->get('level') : 0;
        $this->view->type = $this->session->get('type') ? $this->session->get('type') : 0;
        $this->view->userip = $this->request->getClientAddress() || $this->getuserip();
        





        //$version = new Version();
        # Get Notification        
        // $notify = Notify::find();
        // $this->view->notice = count($notify); 	
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




    private function getuserip()
    {
        return $uip = $this->request->getClientAddress();
        // $client = $_SERVER['HTTP_CLIENT_IP'];
        // $forward = $_SERVER['HTTP_X_FORWARDED_FOR'];
        // $remote = $_SERVER['REMOTE_ADDR'];
        // if(filter_var($client, FILTER_VALIDATE_IP)){$uip = $client;}
        // elseif(filter_var($forward, FILTER_VALIDATE_IP)){$uip = $forward;}
        // else{$uip = $remote;}
        // return $uip;
    } 
## setcookie($name, $value, $expire, $path, $domain, $secure, $httponly);
#End	   
}

