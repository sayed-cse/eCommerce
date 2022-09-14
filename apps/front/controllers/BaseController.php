<?php declare(strict_types=1);
namespace F\Front\Controllers;
use Phalcon\Mvc\Controller;
use Phalcon\Tag;
#use Firefly\Frontend\Models\Notify as Notify;
class BaseController extends Controller
{
    protected function initialize()
    {  	
        Tag::setTitle('LampTouch');
        $this->view->siteName = 'LampTouch';
        $this->view->dynarobot = 'index,follow';
        $this->view->dynadesc = 'Online Shopping at a cheapest price for Automotive, Phones &amp; Accessories, Computers &amp; Electronics, Fashion, Beauty &amp; Health, Home &amp; Garden, Toys &amp; Sports, Weddings &amp; Events and more; just about anything else
Enjoy Free Shipping! Limited Time Sale Easy Return.';
        $this->view->dynakey = 'LampTouch, LampTouch.com, Online shopping, Automotive, Phones & Accessories, Computers & Electronics, Fashion, Beauty & Health, Home & Garden, Toys & Sports, Weddings & Events,Buy, Sale, Online shopping, Automotive, Phones, Accessories, Computers, Electronics, Fashion, Beauty, Health, Home, Garden, Toys, Sports, Weddings';
        $this->view->dynagooglebot = 'index,follow';
        $this->view->dynaGetAuthor = 'FireFly';
        $this->view->author = '\/\/ebmaster:+880 1615577997,+880 1915577997';
        $this->view->googleKey = 'sdfewr3p43432432&^*(*&(*dfdg65ASDADS';
        $this->view->articlePublisher = 'LampTouch';
        $this->view->dynaOgImg = 'img/favicon.png';        
        if($this->session->exists() and !empty($this->session->get('uname')))
        {
            $uid = $this->session->get('id');$name = $this->session->get('uname');$active = $this->session->get('active');$level = $this->session->get('level');$type = $this->session->get('type');            
        }
        else
        {
            $uid = trim(htmlspecialchars(''));$name = trim(htmlspecialchars(''));$active = trim(htmlspecialchars(''));
            $level = trim(htmlspecialchars(''));$type = trim(htmlspecialchars(''));
        }
        $this->view->uid = $uid;
        $this->view->uname = $name;
        $this->view->active = $active;
        $this->view->level = $level;
        $this->view->type = $type;
        # Get Notification        
        // $notify = Notify::find();
        // $this->view->setVar('notice', count($notify)); 	
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


#End	   
}

