<?php declare(strict_types=1);

namespace F\Front\Controllers;
use F\Front\Models\Category as Categories;
use F\Front\Models\Subcategory as Subcat;
use F\Front\Models\Ssc as Ssc;
use F\Front\Models\Products as Products;
use F\Front\Models\Cart as Cart;
use F\Front\Models\Region as Regions;
use F\Front\Models\City as Citys;
use F\Front\Models\Area as Areas;
use F\Front\Models\Ship as Shipto;
use F\Front\Models\Sellers as Sellers;
#use Phalcon\Assets\Asset\Css;
#use Phalcon\Assets\Asset\Js;
class IndexController extends BaseController
{
    public function initialize()
    {
        parent::initialize();
        #$css = new Css('/css/scss.css');
        #$this->assets->addAsset($css);
    }       
    public function indexAction()
    {
        // $this->view->dynaOgImg = 'img/favicon.png';
        $this->view->dynaArticleTitle = 'Dynamic Article Title';
        $this->view->dynaArticle = 'Dynamic Article';
        $this->view->dynaOgUrl = $this->router->getControllerName();
        $this->view->dynadesc = 'A Trusted Online Shopping Platform in Bangladesh!';
        $this->view->dynakey = 'Buy, Sale, Online shopping, Automotive, Phones, Accessories, Computers, Electronics, Fashion, Beauty, Health, Home, Garden, Toys, Sports, Weddings';
        $this->view->dynarobot = 'index,follow';
        $this->view->dynagooglebot ='index,follow';
        $uid = $this->session->get('id');
        $type = $this->session->get('type');
        if(!empty($uid) and !empty($type)){$countcart = Cart::count(['conditions' => 'userid = ?1 AND type = ?2 AND orderflag = ?3 AND orderstatus = ?4', 'bind' => [ 1 => $uid, 2 => $type, 3 => '0', 4 => '0']]);}else{$countcart = '0';}  
        $this->view->mycart = $countcart;    
# Get Categories
        $this->view->cats = Categories::find();
# Get Flash Deals
        $this->view->products = Products::find();
# Get More To Love

# Get Inspiration

# Get Latest Scroll Data

# Get Banner Image        

    }
# Specification view
    public function productAction($id = null)
    {
        // $this->view->dynaOgImg = 'img/favicon.png';
        // $this->view->dynaArticleTitle = 'Dynamic Article Title';
        // $this->view->dynaArticle = 'Dynamic Article';
        // $this->view->dynaOgUrl = $this->router->getControllerName();
        // $this->view->dynadesc = 'A Trusted Online Shopping Platform in Bangladesh!';
        // $this->view->dynakey = 'Buy, Sale, Online shopping, Automotive, Phones, Accessories, Computers, Electronics, Fashion, Beauty, Health, Home, Garden, Toys, Sports, Weddings';
        // $this->view->dynarobot = 'index,follow';
        // $this->view->dynagooglebot ='index,follow';
        $uid = $this->session->get('id');
        $type = $this->session->get('type');
        if(!empty($uid) and !empty($type)){$countcart = Cart::count(['conditions' => 'userid = ?1 AND type = ?2 AND orderflag = ?3 AND orderstatus = ?4', 'bind' => [ 1 => $uid, 2 => $type, 3 => '0', 4 => '0']]);}else{$countcart = '0';}  
        $this->view->mycart = $countcart;

        $area = Shipto::find(['conditions' => '(suserid = ?1 AND type = ?2)','bind' => [1 => $uid, 2 => $type]]);
        if($area->count() > 0){
            foreach($area as $area){$charge_id = $area->sarea;}
            $charge = Areas::findFirstByaid($charge_id);
            $dcharge = $charge->delivery_charge;                
        }else{$dcharge = '0';}
        $this->view->shipingcost = $dcharge;
        # Get Categories      
        $this->view->cats = Categories::find();    
        $datax = Products::findFirstByid($id);
        $this->view->vendor = Sellers::findFirstByid($datax->shopid);
        $this->view->setVar('adata',$datax);
        $this->view->pick('index/details');
    }       
    public function addcartAction()
    {        
        $this->view->disable();
        if($this->session->exists() and !empty($this->session->get('uname')))
        {
            $type = $this->session->get('type');
            $userid = $this->session->get('id');
            $productid = $this->request->getPost('productid');
            $color = $this->request->getPost('color');
            $size = $this->request->getPost('size');
            $dcharge = $this->request->getPost('shipingcost');
            $quant = $this->request->getPost('quantity');
            $price = $this->request->getPost('price');
            $discount = $this->request->getPost('discount');
            $data = Products::findFirstByid($productid);
            if(empty($color)){ $msg = 'Please Choose a Type/Color.'; return $msg; }
            elseif($data->psize !== '0' and empty($size)){ $msg = 'Please Choose a Scale.'; return $msg; }
            else
            {
                $query = Cart::find(['conditions' => 'userid= ?1 AND productid= ?2 AND size= ?3 AND color= ?4 AND type = ?5 AND orderflag = ?6 AND orderstatus = ?7','bind' => [1 => $userid, 2 => $productid, 3 => $size, 4 => $color, 5 => $type, 6 => '0', 7 => '0']]);
                if($query->count() > 0)
                {
                    foreach($query as $q){ $quantity = $q->quantity; }
                    $q->quantity = $quantity + $quant;
                    if(!empty($q->discount) > 0){$q->subtotal = $q->discount * $q->quantity;}else{$q->subtotal = $q->price * $q->quantity;}
                    if($q->update() === true){
                        $msg = Cart::count(['conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3 AND orderstatus = ?4)','bind' => [1 => $userid, 2 => $type, 3 => '0', 4 => '0']]);
                        echo(json_encode($msg));
                    }else{echo $msg = 'Update Failed!';}
                }   
                else
                {
                    $cart = new Cart();
                    $cart->productid = $productid;
                    $cart->userid = $userid;
                    $cart->orderid = $userid.'-'.$productid.'-'.date('dmy-His');
                    $cart->quantity = $quant;
                    $cart->price = $price;
                    $cart->discount = $discount;
                    $cart->size = !empty($size) ? $size : '0';
                    $cart->color = $color;
                    $cart->type = $type;
                    $cart->shopid = $userid;                    
                    $cart->shipingcost = !empty($dcharge) ? $dcharge : '0';                    
                    $cart->orderflag = '0';
                    $cart->orderstatus = '0';
                    $cart->orderdate = date('Y-m-d');
                    $cart->coupon = '0';
                    if($cart->discount > 0){$cart->subtotal = $cart->discount * $cart->quantity;}else{$cart->subtotal = $cart->price * $cart->quantity;}
                    if($cart->save() === true){
                        $msg = Cart::count(['conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3 AND orderstatus = ?4)','bind' => [1 => $userid, 2 => $type, 3 => '0', 4 => '0']]);
                        echo(json_encode($msg));              
                    }else{foreach($cart->getMessages() as $msg){echo(json_encode($msg));}}
                }
            }            
        }else{return $msg = 'Please Login First!';}
    }
    public function buychooseAction()
    {//Click BuyNow Button
        $this->view->disable();
        if(!empty($this->session->get('uname')))
        {   
            $type = $this->session->get('type');     
            $userid = $this->session->get('id');
            $productid = $this->request->getPost('productid');
            $color = $this->request->getPost('color');
            $size = $this->request->getPost('size');
            $quant = $this->request->getPost('quantity');
            $discount = $this->request->getPost('discount');
            $dcharge = $this->request->getPost('dcharge');
            $price = $this->request->getPost('price');
            $data = Products::findFirstByid($productid);
            if(empty($color)){ $msg = 'Please Choose a Type/Color.'; return $msg; }
            elseif($data->psize !== '0' and empty($size)){ $msg = 'Please Choose a Scale.'; return $msg; }
            else{$query = Cart::find(['conditions' => '(userid = ?1 AND productid = ?2 AND size = ?3 AND color = ?4 AND orderstatus = ?5 AND orderflag = ?6)', 'bind' => [1 => $userid, 2 => $productid, 3 => $size, 4 => $color, 5 => '0', 6 => '0']]);                
                if($query->count() > 0)
                {
                    foreach($query as $q){ $quantity = $q->quantity; }
                    $q->quantity = $quantity + $this->request->getPost('quantity');
                    if(!empty($q->discount) > 0){$q->subtotal = $q->discount * $q->quantity;}else{$q->subtotal = $q->price * $q->quantity;}
                    if($q->update() === true){echo('Y');}
                    else{$this->flashSession->error("ERROR :: Data Update Error!");$this->response->redirect($this->router->getControllerName().'/'.$this->router->getActionName());}
                }else{
                    $cart = new Cart();
                    $cart->productid = $productid;
                    $cart->userid = $userid;
                    $cart->orderid = $userid.'-'.$productid.'-'.date('dmy-His');
                    $cart->quantity = $quant;
                    $cart->price = $price;
                    $cart->discount = $discount;
                    $cart->size = $size;
                    $cart->color = $color;
                    $cart->type = $type;
                    $cart->shipingcost = !empty($dcharge) ? $dcharge : '0';
                    $cart->shopid = $userid;
                    $cart->orderflag = '0';
                    $cart->orderstatus = '0';
                    $cart->orderdate = date('Y-m-d');
                    $cart->coupon = '0';                    
                    if(!empty($cart->discount) > 0){$cart->subtotal = $cart->discount * $cart->quantity;}else{$cart->subtotal = $cart->price * $cart->quantity;}
                    if($cart->save() === true){
                        $msg = Cart::count(['conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3 AND orderstatus = ?4)','bind' => [1 => $userid, 2 => $type, 3 => '0', 4 => '0'] ]);
                        echo(json_encode($msg));              
                    }else{echo $msg = 'Data Injection Failed!';} 
                }
            } 
        }else{return $msg = 'Please Login First!';}
    }      
    public function viewcartAction()
    {      
        // $this->view->dynaOgImg = 'img/favicon.png';
        // $this->view->dynaArticleTitle = 'Dynamic Article Title';
        // $this->view->dynaArticle = 'Dynamic Article';
        // $this->view->dynaOgUrl = $this->router->getControllerName();
        // $this->view->dynadesc = 'A Trusted Online Shopping Platform in Bangladesh!';
        // $this->view->dynakey = 'Buy, Sale, Online shopping, Automotive, Phones, Accessories, Computers, Electronics, Fashion, Beauty, Health, Home, Garden, Toys, Sports, Weddings';
        // $this->view->dynarobot = 'index,follow';
        // $this->view->dynagooglebot ='index,follow';
        if($this->session->exists() and !empty($this->session->get('uname')))
        {
            $uid = $this->session->get('id');
            $type = $this->session->get('type');
            if(!empty($uid) and !empty($type)){$countcart = Cart::count(['conditions' => 'userid = ?1 AND type = ?2 AND orderflag = ?3 AND orderstatus = ?4', 'bind' => [ 1 => $uid, 2 => $type, 3 => '0', 4 => '0']]);}else{$countcart = '0';}  
            $this->view->mycart = $countcart;

            $this->view->products = Products::find();

            $query = Cart::find(['conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3 AND orderstatus = ?4)','bind' => [1 => $uid, 2 => $type, 3 => '0', 4 => '0']]);
            $this->view->setVar('cart', $query);

            $st = Cart::sum(['column' => 'subtotal', 'conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3 AND orderstatus = ?4)', 'bind' => [1 => $uid, 2 => $type, 3 => '0', 4 => '0']]);
            $this->view->subtotal = $st;

            $sc = Cart::sum(['column' => 'shipingcost', 'conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3 AND orderstatus = ?4)', 'bind' => [1 => $uid, 2 => $type, 3 => '0', 4 => '0']]);
            $this->view->shipingcost = $sc;

            $this->view->coupon = '0';            
            $this->view->pick('index/viewcart');
        }else{
            $this->flashSession->error("ERROR::Please Login First!");
            return $this->response->redirect();
        }
    } 
    public function CategoryAction($catego = null)
    {
        // $this->view->dynaOgImg = 'img/favicon.png';
        // $this->view->dynaArticleTitle = 'Dynamic Article Title';
        // $this->view->dynaArticle = 'Dynamic Article';
        // $this->view->dynaOgUrl = $this->router->getControllerName();
        // $this->view->dynadesc = 'A Trusted Online Shopping Platform in Bangladesh!';
        // $this->view->dynakey = 'Buy, Sale, Online shopping, Automotive, Phones, Accessories, Computers, Electronics, Fashion, Beauty, Health, Home, Garden, Toys, Sports, Weddings';
        // $this->view->dynarobot = 'index,follow';
        // $this->view->dynagooglebot ='index,follow';  
        $uid = $this->session->get('id');
        $type = $this->session->get('type');
        if(!empty($uid) and !empty($type)){$countcart = Cart::count(['conditions' => 'userid = ?1 AND type = ?2 AND orderflag = ?3 AND orderstatus = ?4', 'bind' => [ 1 => $uid, 2 => $type, 3 => '0', 4 => '0']]);}else{$countcart = '0';}  
        $this->view->mycart = $countcart;
# Get Categories
        $this->view->cats = Categories::find();
        $datax = Categories::find(['conditions' => 'categoryname = ?1','bind' => [1 => $catego]]);
        $this->view->setVar('data', $datax);
        $this->view->pick('index/category');
    }      
    public function couponAction()
    {
        $this->view->disable();        
        $uid = $this->session->get('id');
        $type = $this->session->get('type');
        $couponcode = $this->request->getPost('couponcode');
        $query = Products::findFirstBycoupon($couponcode);
        if($query->coupon === $couponcode)
        {
            $checkcart = Cart::find([
                'conditions' => '(couponapply = ?1 AND userid = ?2 AND type = ?3)',
                'bind' => [1 => $couponcode, 2 => $uid, 3 => $type]
            ]);
            if($checkcart->count() > 0 || $checkcart->numRows() > 0)
            {echo('Already coupon used your cart');}else{
                $checkcart->couponapply = $couponcode;
                if($checkcart->update() === true){
                    //$checkcart->grandtotal = ($checkcart->subtotal - $query->couponamount); 
                    echo('OK DONE');
                }else{
                    $msg = $checkcart->getMessages();
                    foreach($msg as $msg){echo($msg);}
                }                
            }
        }else{echo('Coupon Mismatched');}
    }
    public function checkoutAction()
    {
        // $this->view->dynaOgImg = 'img/favicon.png';
        // $this->view->dynaArticleTitle = 'Dynamic Article Title';
        // $this->view->dynaArticle = 'Dynamic Article';
        // $this->view->dynaOgUrl = $this->router->getControllerName();
        // $this->view->dynadesc = 'A Trusted Online Shopping Platform in Bangladesh!';
        // $this->view->dynakey = 'Buy, Sale, Online shopping, Automotive, Phones, Accessories, Computers, Electronics, Fashion, Beauty, Health, Home, Garden, Toys, Sports, Weddings';
        // $this->view->dynarobot = 'index,follow';
        // $this->view->dynagooglebot ='index,follow';        
        if($this->session->exists() and !empty($this->session->get('uname')))
        {
            $uid = $this->session->get('id');
            $type = $this->session->get('type');
            if(!empty($uid) and !empty($type)){$countcart = Cart::count(['conditions' => 'userid = ?1 AND type = ?2 AND orderflag = ?3 AND orderstatus = ?4', 'bind' => [ 1 => $uid, 2 => $type, 3 => '0', 4 => '0']]);}else{$countcart = '0';}  
            $this->view->mycart = $countcart;
            if($countcart > 0){
                $query = Shipto::find(['conditions' => 'suserid = ?1 AND type = ?2','bind' => [1 => $uid, 2 => $type] ]);
                if($query->count() > 0){
      
                $q = Cart::find(['conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3 AND orderstatus = ?4)','bind' => [1 => $uid, 2 => $type, 3 => '0', 4 => '0']]);
                $this->view->data = $q;

                $st = Cart::sum(['column' => 'subtotal', 'conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3 AND orderstatus = ?4)', 'bind' => [1 => $uid, 2 => $type, 3 => '0', 4 => '0']]);
                $this->view->subtotal = $st;

                $sc = Cart::sum(['column' => 'shipingcost', 'conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3 AND orderstatus = ?4)', 'bind' => [1 => $uid, 2 => $type, 3 => '0', 4 => '0']]);
                $this->view->shipingcost = $sc;

                    foreach($q as $qt){$qt->grandtotal = round(($st + $sc), 0, PHP_ROUND_HALF_UP);}
                    if($qt->update()){
                        $this->view->shiping = $query;
                        $this->view->citys = Citys::find();
                        $this->view->regions = Regions::find();
                        $this->view->areas = Areas::find();
                        $this->view->pick('index/checkout');                        
                    }else{echo('Database Update Failed');}
                }else{return $this->response->redirect('index/getship');}
            }else{return $this->response->redirect();}
        }else{
            $this->flashSession->error("ERROR:: Please Login First!");
            return $this->response->redirect($this->request->getHTTPReferer());            
        }
    }    
    public function updatecartAction()
    {
        $this->view->disable();
        $uid = $this->session->get('id');
        $type =  $this->session->get('type');
        $id = $this->request->getPost('id');
        $quantity = $this->request->getPost('value');
        $query = Cart::findFirst(['conditions' => 'userid = ?1 AND type = ?2 AND id = ?3 AND orderflag = ?4 AND orderstatus = ?5','bind' => [ 1 => $uid, 2 => $type, 3 => $id, 4 => '0', 5 => '0']]);
        $query->quantity = $quantity;
        if(!empty($query->discount) > 0){$query->subtotal = $query->discount * $quantity; }else{$query->subtotal = $query->price * $quantity;}
        if($query->update() === true){
            $st = Cart::sum(['column' => 'subtotal', 'conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3 AND orderstatus = ?4)', 'bind' => [1 => $uid, 2 => $type, 3 => '0', 4 => '0']]);
            $sh = Cart::sum(['column' => 'shipingcost', 'conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3 AND orderstatus = ?4)', 'bind' => [1 => $uid, 2 => $type, 3 => '0', 4 => '0']]);

            $data = Cart::find(['conditions' => '(userid = ?1 AND type = ?2 AND id = ?3 AND orderflag = ?4 AND orderstatus = ?5)', 'bind' => [1 => $uid, 2 => $type, 3 => $id, 4 => '0', 5 => '0']]); 
            $resData = array();    
            foreach($data as $result)
            {
                $resData[] = array('id' => $result->id, 'shipingcost' => $sh, 'subtotal' => $st);//'subtotal' => $result->subtotal,
            }
            echo(json_encode($resData));
        }else{return false;} 

    } 
    public function cartdelAction()
    {
        $this->view->disable();
        $id = $this->request->getPost('id');
        $type = $this->session->get('type');
        $ssid = $this->session->get('id');
        $del = Cart::findFirst(['conditions' => 'id = ?1 AND userid = ?2 AND type = ?3 AND orderflag = ?4 AND orderstatus = ?5', 'bind' => [ 1 => $id, 2 => $ssid, 3 => $type, 4 => '0', 5 => '0']]);
        if($del->delete() === true){
        $countcart = Cart::count(['conditions' => 'userid = ?1 AND type = ?2 AND orderflag = ?3 AND orderstatus = ?4', 'bind' => [ 1 => $ssid, 2 => $type, 3 => '0', 4 => '0']]);
            if($countcart > 0){
                $st = Cart::sum(['column' => 'subtotal', 'conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3 AND orderstatus = ?4)', 'bind' => [1 => $ssid, 2 => $type, 3 => '0', 4 => '0']]);
                $sh = Cart::sum(['column' => 'shipingcost', 'conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3 AND orderstatus = ?4)', 'bind' => [1 => $ssid, 2 => $type, 3 => '0', 4 => '0']]);
                $data = Cart::find(['conditions' => '(userid = ?1 AND type = ?2)', 'bind' => [1 => $ssid, 2 => $type]]); 
                    $resData = array();    
                    foreach($data as $result)
                    {
                        $resData[] = array('id' => $result->id, 'subtotal' => $st, 'shipingcost' => $sh, 'ccount' => $countcart);
                    }
                    echo(json_encode($resData));
            }else{ $datas = array(); $datas[] = array('id' => $ssid); echo(json_encode($datas)); }
        }else{return false;}
    }
    public function getshipAction()
    {//BuyNow Button Send Here
        //$this->dispatcher->forward(['controller' => 'index','action' => 'index',]);
        // $this->view->dynaOgImg = 'img/favicon.png';
        // $this->view->dynaArticleTitle = 'Dynamic Article Title';
        // $this->view->dynaArticle = 'Dynamic Article';
        // $this->view->dynaOgUrl = $this->router->getControllerName();
        // $this->view->dynadesc = 'A Trusted Online Shopping Platform in Bangladesh!';
        // $this->view->dynakey = 'Buy, Sale, Online shopping, Automotive, Phones, Accessories, Computers, Electronics, Fashion, Beauty, Health, Home, Garden, Toys, Sports, Weddings';
        // $this->view->dynarobot = 'index,follow';
        // $this->view->dynagooglebot ='index,follow';         
        if(!empty($this->session->get('uname')))
        {
            $uid = $this->session->get('id');
            $type = $this->session->get('type');
            if(!empty($uid) and !empty($type)){$countcart = Cart::count(['conditions' => 'userid = ?1 AND type = ?2 AND orderflag = ?3 AND orderstatus = ?4', 'bind' => [ 1 => $uid, 2 => $type, 3 => '0', 4 => '0']]);}else{$countcart = '0';}  
            $this->view->mycart = $countcart;

            $q = Shipto::find(['conditions' => 'suserid= ?1 AND type = ?2','bind' => [1 => $uid, 2 => $type] ]);
            if($q->count() > 0)
            { 
                $mode = '1';
                foreach($q as $query)
                {
                    $this->view->suserid = $query->suserid;
                    $this->view->fname = $query->fname;
                    $this->view->sphone = $query->sphone;
                    $this->view->srid = $query->sregion;
                    $this->view->scid = $query->scity;
                    $this->view->said = $query->sarea;
                    $cartcharge = Cart::findFirst(['conditions' => '(userid = ?1 AND type = ?2)','bind' => [1 => $uid, 2 => $type]]); 
                    $this->view->dcharge = $cartcharge->shipingcost;
                    $this->view->saddress = $query->saddress;
                }             
            }else{ 
                $mode = '0';
                $this->view->suserid = $uid;
                $this->view->fname = '';
                $this->view->sphone = '';
                $this->view->sregion = '';
                $this->view->scity = '';
                $this->view->sarea = '';
                $this->view->dcharge = '';
                $this->view->saddress = '';
            }
                $this->view->aspect = $mode;
                $this->view->action = 'index/shipto';
                $this->view->citys = Citys::find();
                $this->view->regions = Regions::find();
                $this->view->areas = Areas::find();
                $id = $this->request->getPost('id');
                $this->view->data = Cart::findByuserid($uid);
                $this->view->pick('index/order_stepA');
        }else{
            $this->flashSession->error("ERROR:: Please Login First!");
            return $this->response->redirect($this->request->getHTTPReferer());
        }
    }
    public function shiptoAction()
    {//getShip Send Here for shiped save
        $this->view->disable();
        if(!empty($this->session->get('uname')))
        {
            $type = $this->session->get('type');
            $suserid = $this->session->get('id');
            $semail = $this->request->getPost('semail');
            $fname = $this->request->getPost('fname');
            $sphone = $this->request->getPost('sphone');
            $sregion = $this->request->getPost('sregion');
            $scity = $this->request->getPost('scity');
            $sarea = $this->request->getPost('sarea');
            $dcharge = $this->request->getPost('dcharge');

         // echo $dcharge;die();  
            $saddress = $this->request->getPost('saddress');          
            $query = Shipto::find(['conditions' => '(suserid = ?1 AND type = ?2)','bind' => [1 => $suserid, 2 => $type] ]); 
            if($query->count() > 0)
            {  
                foreach($query as $q){
                    $q->suserid = $suserid;
                    $q->type = $type;
                    $q->fname = !empty($fname) ? $fname : $q->fname;
                    $q->sphone = !empty($sphone) ? $sphone : $q->sphone;
                    $q->sregion = !empty($sregion) ? $sregion : $q->sregion;
                    $q->scity = !empty($scity) ? $scity : $q->scity;
                    $q->sarea = !empty($sarea) ? $sarea : $q->sarea;
                    $q->saddress = !empty($saddress) ? $saddress : $q->saddress;
                }
                if($q->update() === true)
                {
                    $cart = Cart::find([ 'conditions' => 'userid = ?1 AND type = ?2','bind' => [1 => $suserid, 2 => $type] ]);
                    foreach($cart as $c)
                    {
                        $c->shipingcost = $dcharge;
                        if($c->update() === true){$response = true;}else{$response = false;}                        
                    }
                    if($response === true){return $this->response->redirect('index/checkout/');}else{$this->flashSession->error("ERROR :: Cart Update Failed!"); return $this->response->redirect('index/getship/');}                    
                }else{
                    $this->flashSession->error("ERROR:: Unable to Update Data, Please try Again!");
                    return $this->response->redirect($this->request->getHTTPReferer());
                }
            }
            else{
                $query = new Shipto();
                $query->suserid = $suserid;
                $query->fname = $fname;
                $query->sphone = $sphone;
                $query->sregion = $sregion;
                $query->scity = $scity;
                $query->sarea = $sarea;
                $query->saddress = $saddress;
                $query->type = $type;
                if($query->save() === true){
                    $cart = Cart::find([ 'conditions' => 'userid = ?1 AND type = ?2','bind' => [1 => $suserid, 2 => $type] ]);
                    foreach($cart as $c)
                    {
                        $c->shipingcost = $dcharge;
                        if($c->update() === true){$response = true;}else{$response = false;}                        
                    }
                    if($response === true){return $this->response->redirect('index/checkout/');}else{$this->flashSession->error("ERROR :: Cart Update Failed!");return $this->response->redirect('index/getship/');} 
                }else{$this->flashSession->error("ERROR :: Required Fields Going Empty!"); return $this->response->redirect('index/getship/');}
                //foreach ($query->getMessages() as $message){echo $message->getMessage(), "<br/>";}
            }            
        }else{
            $this->flashSession->error("ERROR:: Please Login First!");
            return $this->response->redirect($this->request->getHTTPReferer());
        }  
    }      
    public function paymentAction()
    {
        // $this->view->dynaOgImg = 'img/favicon.png';
        // $this->view->dynaArticleTitle = 'Dynamic Article Title';
        // $this->view->dynaArticle = 'Dynamic Article';
        // $this->view->dynaOgUrl = $this->router->getControllerName();
        // $this->view->dynadesc = 'A Trusted Online Shopping Platform in Bangladesh!';
        // $this->view->dynakey = 'Buy, Sale, Online shopping, Automotive, Phones, Accessories, Computers, Electronics, Fashion, Beauty, Health, Home, Garden, Toys, Sports, Weddings';
        // $this->view->dynarobot = 'index,follow';
        // $this->view->dynagooglebot ='index,follow';        
        if(!empty($this->session->get('uname')))
        {    
            $uid = $this->session->get('id');
            $type = $this->session->get('type');            
            $cart = Cart::findFirstBytype($type);
            if(!empty($uid) and !empty($type)){$countcart = Cart::count(['conditions' => 'userid = ?1 AND type = ?2 AND orderflag = ?3 AND orderstatus = ?4', 'bind' => [ 1 => $uid, 2 => $type, 3 => '0', 4 => '0']]);}else{$countcart = '0';}  
            $this->view->mycart = $countcart;
        //$pamount = round($this->request->getPost('pamount'), 0, PHP_ROUND_HALF_UP); 
            $name = $this->session->get('uname');
            $active = $this->session->get('active');
            $level = $this->session->get('level');
            $this->view->setVar('uid', $uid);
            $this->view->setVar("uname", $name);
            $this->view->setVar("active", $active);
            $this->view->setVar("level", $level); 
            $this->view->setVar("type", $type);
            $this->view->setVar('mycart', $countcart);
            $this->view->setVar('trxid', $uid);
            $this->view->setVar('pamount', '111');
            $this->view->pick('index/payment');            
        }else{
            $this->flashSession->error("ERROR:: Please Login First!");
            return $this->response->redirect($this->request->getHTTPReferer());
        }  
    }
    public function payprocessAction()
    { 
        # KEY BIND FOR NUMBER'S, DOT'S & BACKSPACE ONLY : [8, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 110, 190] 
        $uid = $this->session->get('id');
        $type = $this->session->get('type');  
        $paytype = $this->request->getPost('paytype');
        $trxID = $this->request->getPost('trxid'); 
        $pamount = round($this->request->getPost('pamount'), 0, PHP_ROUND_HALF_UP); 

//var_dump($uid . ' - ' .$type . ' - ' . $paytype . ' - ' . $pamount . ' - ' . $trxID);exit();

        if($trxID and $pamount and $paytype){
            $query = Cart::find([ 'conditions' => 'userid = ?1 AND type = ?2','bind' => [1 => $uid, 2 => $type] ]);
            if($paytype === 'cashon'){
                foreach($query as $update){
                    $update->paytype = $paytype;
                    $update->trxno = $trxID;
                    $update->pamount = $pamount;                
                }
                if($update->update() === true){echo('Y');}else{echo(json_encode('Data Update Failed, Please! Try Again...'));}
            }else{
                foreach($query as $update){
                    $update->paytype = $paytype;
                    $update->trxno = $trxID;
                    $update->pamount = $pamount;
                }
                if($update->update() === true){echo('Y');}else{echo(json_encode('Data Update Failed, Please! Try Again...'));}
            }
        }else{echo(json_encode('Required Data Missing!'));}                                    
    }
    public function thanksAction()
    {
        $this->view->dynaOgImg = 'img/favicon.png';
        $this->view->dynaArticleTitle = 'Dynamic Article Title';
        $this->view->dynaArticle = 'Dynamic Article';
        $this->view->dynaOgUrl = $this->router->getControllerName();
        $this->view->dynadesc = 'A Trusted Online Shopping Platform in Bangladesh!';
        $this->view->dynakey = 'Buy, Sale, Online shopping, Automotive, Phones, Accessories, Computers, Electronics, Fashion, Beauty, Health, Home, Garden, Toys, Sports, Weddings';
        $this->view->dynarobot = 'index,follow';
        $this->view->dynagooglebot ='index,follow';       
        if(!empty($this->session->get('uname')))
        {
            $uid = $this->session->get('id');
            $type = $this->session->get('type');
            if(!empty($uid) and !empty($type)){$countcart = Cart::count(['conditions' => 'userid = ?1 AND type = ?2 AND orderflag = ?3 AND orderstatus = ?4', 'bind' => [ 1 => $uid, 2 => $type, 3 => '0', 4 => '0']]);}else{$countcart = '0';}  
            $this->view->mycart = $countcart;
            $this->view->pick('index/thanks');            
        }else{
            $this->flashSession->error("ERROR:: Please Login First!");
            return $this->response->redirect($this->request->getHTTPReferer());
        }         
    }
    public function getcityAction()
    { 
        $this->view->disable();
        $id = $this->request->getPost('id');
        $data = Citys::findByregionid($id);
        $resData = array();    
        foreach($data as $result){$resData[] = array('cid' => $result->cid, 'rid' => $result->regionid, 'city' => $result->cityname);}echo(json_encode($resData));       
    }
    public function getareaAction()
    { 
        $this->view->disable();
        $id = $this->request->getPost('id');
        $data = Areas::findBycid($id);  
        $resData = array();    
        foreach($data as $result){$resData[] = array('aid' => $result->aid, 'cid' => $result->cid, 'area' => $result->areaname);}echo(json_encode($resData));       
    }  
    public function getdeliveryAction()
    { 
        $this->view->disable();
        $id = $this->request->getPost('id');
        $data = Areas::findByaid($id);  
        $resData = array();    
        foreach($data as $result){$resData[] = array('aid' => $result->aid, 'cid' => $result->cid, 'dcharge' => $result->delivery_charge);}echo(json_encode($resData));
    } 
    public function queryAction()
    {
# | IN BOOLEAN MODE | IN NATURAL LANGUAGE MODE | IN NATURAL LANGUAGE MODE WITH QUERY EXPANSION | 
#--
#-- Indexes for table `products`
#--
#ALTER TABLE `products`
#  ADD PRIMARY KEY (`id`);
#ALTER TABLE `products` ADD FULLTEXT KEY `query` (`product_title`,`keywords`,`specification`);
        $data = htmlspecialchars($this->request->getPost('query'));       
        if(!empty($data))
        {
            $a = explode(' ',$data); 
            $b = array_map('trim',$a); 
            $c = implode(',',$b);

# SELECT product_title, keywords FROM products WHERE MATCH (product_title, keywords) AGAINST('Lehanga,Cloths' IN NATURAL LANGUAGE MODE WITH QUERY EXPANSION);  
// $sql = "SELECT id,product_title,keywords FROM products WHERE MATCH(product_title,keywords) AGAINST('$c' IN NATURAL LANGUAGE MODE WITH QUERY EXPANSION);"; 
// $query = $this->modelsManager->createQuery($sql);
// $result = $query->execute(); 



            $query = $this->db->query("SELECT id,product_title,keywords,specification FROM products WHERE MATCH(product_title,keywords,specification) AGAINST('$c' IN NATURAL LANGUAGE MODE WITH QUERY EXPANSION);");
            if($query->numRows() > 0)
            {
                $this->view->data = $query->fetchAll();
                $this->view->pick('index/query');
            }else{$this->flashSession->error("ERROR:: No Data Found!");return $this->response->redirect('index/index');}    
        }else{$this->flashSession->error("ERROR:: Required Fields Going Empty!");return $this->response->redirect('index/index');}
    }
    public function orderAction()
    {
# SELECT orderid FROM cart WHERE orderid IN('1-30-120922-134321','1-30-120922-141448');
        $this->view->disable();
        if($this->session->exists() and !empty($this->session->get('type'))){
            $orders = $this->request->getPost('orders');
            $uid = $this->session->get('id');
            $type = $this->session->get('type');
            // $bTypes = array(
            //     'orderid' => Column::BIND_PARAM_STR,
            // );
            // $dox = Cart::find([
            //     'conditions' => "orderid IN ({oId:array})",
            //     'bind' => ['oId' => $orders],
            //     //'bindTypes'   => $bTypes,
            //     // 'for_update' => true,
            //     // 'limit' => '10',
            //     // 'order' => 'orderid desc',
            // ]);

            $data = implode("','",$orders);
            $query = $this->db->query("UPDATE cart SET orderflag = '1', orderstatus = '1' WHERE orderid IN('$data')");  
            if($query->numRows() > 0){
                echo('Y');
            }else{echo('NO');}
        }else{echo('NOK');}    
    }
    public function trackAction()
    {
        if($this->session->exists() and !empty($this->session->get('type'))){
            $uid = $this->session->get('id');
            $type = $this->session->get('type');
        if(!empty($uid) and !empty($type)){$countcart = Cart::count(['conditions' => 'userid = ?1 AND type = ?2 AND orderflag = ?3 AND orderstatus = ?4', 'bind' => [ 1 => $uid, 2 => $type, 3 => '1', 4 => '1']]);}else{$countcart = '0';}  
        $this->view->mycart = $countcart;            
            $query = Cart::find([
                'conditions' => 'userid = ?1 AND type = ?2 AND orderflag = ?3 AND orderstatus = ?4','bind' => [1 => $uid, 2 => $type, 3 => '1', 4 => '1' ]
            ]);
            if($query->count() > 0){
                $this->view->data = $query;
                $this->view->pick('index/track');
            }else{
                $this->flashSession->warning("WARNING:: You Have No Orders!");return $this->response->redirect();
            }
        }else{ return $this->response->redirect(); }
    }      
    // public function feedAction()
    // {
    //     $posts = Products::find();
    //     $rss_posts = array();
    //     foreach($posts as $post)
    //     {
    //         $post->rss_date = date("D, d M Y H:i:s O", strtotime($post->datetime));
    //         $rss_posts[] = $post;
    //     }
    //     $this->view->posts = $rss_posts;
    //     $this->response->setHeader('Content-Type', 'application/xml; charset=UTF-8');
    //     #$this->response->setHeader('Content-Disposition', 'attachment; filename="feed.xml"');
    //     $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
    //     $this->view->pick('index/feed');
    // } 
    // public function sendpayAction()
    // {
    //     if(!empty($this->session->get('uname')))
    //     {
    //         $uid = $this->session->get('id');
    //         $name = $this->session->get('uname');
    //         $active = $this->session->get('active');
    //         $level = $this->session->get('level'); 
    //         $type = $this->session->get('type');           
    //         $getcart = Cart::countByuserid($uid);

    //         $this->view->setVar('uid', $uid);
    //         $this->view->setVar("uname", $name);
    //         $this->view->setVar("active", $active);
    //         $this->view->setVar("level", $level);  
    //         $this->view->setVar("type", $type);
    //         $this->view->setVar('mycart', $getcart);         
    //         //$this->view->pick('index/checkout');   
    //         //$getCart = Cart::countByproductid($this->request->getPost('id'));
    //         $getship = Shipto::countBysuserid($uid);
    //         //var_dump($getship.'-'.$getcart);exit();
    //         if($getcart > 0 && $getship > 0){
    //             return $this->response->redirect('index/payment');
    //         }
    //         elseif($getcart > 0 && $getship < 1){
    //             return $this->response->redirect('index/shipto');
    //         }
    //         elseif($getcart < 1 && $getship > 0){
    //             $cart = new Cart();
    //             $cart->productid = $this->request->getPost('productid');
    //             $cart->userid = $this->session->get('id');
    //             $cart->orderid = '1234';
    //             $cart->quantity = $this->request->getPost('quantity');
    //             $cart->price = $this->request->getPost('price');
    //             $cart->discount = $this->request->getPost('discount');
    //             $cart->size = $this->request->getPost('size');
    //             $cart->color = $this->request->getPost('color');
    //             $cart->shipping_charge = '0';
    //             $cart->subtotal = '0';
    //             if($cart->save() === true){
    //                 $this->flashSession->success("Success:: Saved Data");
    //                 return $this->response->redirect('index/index');                                  
    //             }else{
    //                 $this->flashSession->error("Error:: Data Not Saved");
    //                 return $this->response->redirect('index/index');                     
    //             }
    //         }
    //         else{
    //             $this->flashSession->error("ERROR:: Something Went Wrong, Please Try Again!");
    //             return $this->response->redirect('index/index');
    //         }
    //     }else{echo('Please Loggin First');}                
    // }
    // public function getuseripAction()
    // {
    //     $client = $_SERVER['HTTP_CLIENT_IP'];
    //     $forward = $_SERVER['HTTP_X_FORWARDED_FOR'];
    //     $remote = $_SERVER['REMOTE_ADDR'];
    //     if(filter_var($client, FILTER_VALIDATE_IP)){$uip = $client;}
    //     elseif(filter_var($forward, FILTER_VALIDATE_IP)){$uip = $forward;}
    //     else{$uip = $remote;}
    //     return $uip;
    // }     
#END    
}
