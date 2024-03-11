<?php declare(strict_types=1);
namespace F\Front\Controllers;
use Phalcon\Paginator\Adapter\Model as Paginator;
use F\Front\Models\Category as Categories;
use F\Front\Models\Subcategory as Subcat;
use F\Front\Models\Ssc as Ssc;
use F\Front\Models\Products as Products;
use F\Front\Models\Sellers as Sellers;
use F\Front\Models\Cart as Cart;
use F\Front\Models\Region as Regions;
use F\Front\Models\City as Citys;
use F\Front\Models\Area as Areas;
use F\Front\Models\Ship as Shipto;
use F\Front\Models\Ratings as Ratings;
#use Phalcon\Assets\Asset\Css;
#use Phalcon\Assets\Asset\Js;
use Phalcon\Tag;
use FPDF;
class IndexController extends BaseController
{
    public function initialize()
    {
        parent::initialize();
        $this->view->dynaArticleTitle = $this->view->siteName;
        $this->view->dynaArticle = $this->view->siteName;
        $this->view->dynaOgUrl = $this->view->siteName;
        //$escaper = new Escaper();        
        //$escaper->setEncoding('utf-8');
        //$escaper->setDoubleEncode(false);
        #$css = new Css('/css/style.css');
        #$this->assets->addAsset($css);
    }
    public function indexAction()
    {
        $this->view->dynaArticleTitle = $this->view->siteName;
        $this->view->dynaArticle = $this->view->siteName;
        $this->view->dynaOgUrl = $this->router->getControllerName().'/'.$this->router->getActionName();
        $uid = $this->session->get('id');
        $type = $this->session->get('type');
        #$this->view->currentUrl = $this->router->getRewriteUri();
        $cartCount = Cart::count(['conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3)','bind' => [1 => $uid, 2 => $type, 3 => '0']]);
        $this->view->mycart = $cartCount > 0 ?  $cartCount : '0';
# Get Categories
        $this->view->cats = Categories::find();
# Get Products
      // $pdata = $this->view->products = Products::find(['columns' => 'id,stage,product_title,pimg_front,product_price,discount,keywords']);

        // $this->url->get([
        //     "for" => "front-default",
        //     "title" => "X-Sayed-X",
        //     "id" => $id,
        // ]);
# Get Similar
        

//$query = $this->db->query('SELECT * FROM products WHERE stage = "3"');


        // $currenttags =  explode(',', $xdata->keywords);
        // $query = Products::query();
        // $bindParameters = [];
        // for($i=0; $i < count($currenttags); $i++) {
        //    $query->orWhere('keywords LIKE :tag'.$i.':');
        //    $bindParameters['tag'.$i] = '%'.$currenttags[$i].'%';
        // }
        // $similar = $query->bind($bindParameters)->execute();
        // $this->view->setVar('similars', $similar); 

 

// $numStage1 = $this->request->getQuery("pstage1", "int", 1);
// $numStage2 = $this->request->getQuery("pstage2", "int", 1);
// $numStage3 = $this->request->getQuery("pstage3", "int", 1);
// $numStage4 = $this->request->getQuery("pstage4", "int", 1);

// $paginatorStage1 = new Paginator([
//     "model"      => Products::class,
//     "columns"   => 'id,stage,product_title,pimg_front,product_price,discount',
//     "parameters" => [
//         "stage = :stage:",
//         "bind" => ["stage" => 1,],
//         "order" => "RAND()",
//     ],
//     "limit"      => 16,
//     "page"       => $numPage,
// ]);
// $paginatorStage2 = new Paginator([
//     "model"      => Products::class,
//     "columns"   => 'id,stage,product_title,pimg_front,product_price,discount',
//     "parameters" => [
//         "stage = :stage:",
//         "bind" => ["stage" => 2,],
//         "order" => "RAND()",
//     ],
//     "limit"      => 12,
//     "page"       => $numPage,    
// ]);
// $paginatorStage3 = new Paginator([
//     "model"      => Products::class,
//     "columns"   => 'id,stage,product_title,pimg_front,product_price,discount',
//     "parameters" => [
//         "stage = :stage:",
//         "bind" => ["stage" => 3,],
//         "order" => "RAND()",
//     ],
//     "limit"      => 12,
//     "page"       => $numPage,    
// ]);
// $paginatorStage4 = new Paginator([
//     "model"      => Products::class,
//     "columns"   => 'id,stage,product_title,pimg_front,product_price,discount',
//     "parameters" => [
//         "stage = :stage:",
//         "bind" => ["stage" => 4,],
//         "order" => "RAND()",
//     ],
//     "limit"      => 100,
//     "page"       => $numPage,    
// ]);

// $this->view->pstage1 = $paginatorStage1->paginate();
// $this->view->pstage2 = $paginatorStage2->paginate();
// $this->view->pstage3 = $paginatorStage3->paginate();
// $this->view->pstage4 = $paginatorStage4->paginate();


# Shorted Query
$paginatorConfigs = [
    ['stage' => 1, 'limit' => 48],
    ['stage' => 2, 'limit' => 8],
    ['stage' => 3, 'limit' => 12],
    ['stage' => 4, 'limit' => 12],
];
$paginatorInstances = [];

// // Chunk the $paginatorConfigs array
// $chunks = array_chunk($paginatorConfigs, 2);
// foreach ($chunks as $chunk) {
//     foreach ($chunk as $config) {
//         $paginator = new Paginator([
//             'model' => Products::class,
//             'columns' => 'id,product_title,pimg_front,product_price,discount,stock,stage,AVG(Ratings.rating) AS average_rating',
//             'joins' => [
//                 [
//                     'model' => Ratings::class,
//                     'conditions' => 'Products.id = Ratings.productid',
//                     'alias' => 'Ratings',
//                     'type' => 'LEFT'
//                 ]
//             ],        
//             'parameters' => [
//                 'stage = :stage:',
//                 'bind' => ['stage' => $config['stage']],
//                 'group' => 'id',
//                 'order' => 'RAND()',
//             ],
//             'limit' => $config['limit'],
//             'page' => $this->request->getQuery("pstage{$config['stage']}", 'int', 1),
//         ]);
//         $paginatorInstances[] = $paginator;
//     }
// }

foreach ($paginatorConfigs as $config) {
    $paginator = new Paginator([
        'model' => Products::class,
        'columns' => 'id,product_title,pimg_front,product_price,discount,stock,stage,AVG(Ratings.rating) AS average_rating',
        'joins' => [
            [
                'model' => Ratings::class,
                'conditions' => 'Products.id = Ratings.productid',
                'alias' => 'Ratings',
                'type' => 'LEFT'
            ]
        ],        
        'parameters' => [
            'stage = :stage:',
            'bind' => ['stage' => $config['stage']],
            'group' => 'id',
            'order' => 'RAND()',
        ],
        'limit' => $config['limit'],
        'page' => $this->request->getQuery("pstage{$config['stage']}", 'int', 1),
    ]);
    $paginatorInstances[] = $paginator;
}

foreach ($paginatorInstances as $index => $paginator) { $this->view->{"pstage" . ($index + 1)} = $paginator->paginate(); }




// $ratingEx = Ratings::count(['conditions' => '(productid = ?1 AND rating = ?2)','bind' => [1 => $index, 2 => 5]]);
// $ratingDx = Ratings::count(['conditions' => '(productid = ?1 AND rating = ?2)','bind' => [1 => $index, 2 => 4]]);
// $ratingCx = Ratings::count(['conditions' => '(productid = ?1 AND rating = ?2)','bind' => [1 => $index, 2 => 3]]);
// $ratingBx = Ratings::count(['conditions' => '(productid = ?1 AND rating = ?2)','bind' => [1 => $index, 2 => 2]]);
// $ratingAx = Ratings::count(['conditions' => '(productid = ?1 AND rating = ?2)','bind' => [1 => $index, 2 => 1]]);
// $this->view->ratingE = $ratingEx > 0 ? $ratingEx : 0;
// $this->view->ratingD = $ratingDx > 0 ? $ratingDx : 0;
// $this->view->ratingC = $ratingCx > 0 ? $ratingCx : 0;
// $this->view->ratingB = $ratingBx > 0 ? $ratingBx : 0;
// $this->view->ratingA = $ratingAx > 0 ? $ratingAx : 0; 


//var_dump($index);exit();



# MostPopular
    $this->view->fp = Products::query()->where('stage = "3" AND hits != 0')->orderby("hits DESC limit 5")->execute();
    $this->view->lp = Products::query()->where('stage = "4" AND hits != 0')->orderby("hits DESC limit 5")->execute();
# Get Banner Image        
    $this->view->cBanner = '';
    $this->view->rtBanner = '';
    $this->view->rbBanner = '';
    }
# Specification view
    public function productAction($enTitle = null)
    {      
        if(isset($enTitle)){
            $uid = $this->session->get('id');
            $type = $this->session->get('type');
            $csrf = $this->security->getRequestToken();      
            $datax = Products::findFirstByproduct_title(base64_decode(urldecode($enTitle)));
            if(isset($datax) && $this->security->checkToken($csrf, $this->security->getSessionToken())){
                Tag::appendTitle($datax->product_title);
                $this->view->dynakey = $datax->keywords;
                $datax->hits = $datax->hits + 1;
                if($datax->update() === false){return $this->response->redirect();}
                $sellers = Sellers::findFirstByid($datax->shopid);
                $this->view->dynaGetAuthor = $sellers->name;
                $this->view->dynadesc = substr($datax->specification,0,156);
                $this->view->dynaArticleTitle = $datax->product_title;
                $this->view->dynaOgUrl = $this->router->getControllerName().'/'.$this->router->getActionName().'/'.base64_decode(urldecode($enTitle));                
                $cartCount = Cart::count(['conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3)','bind' => [1 => $uid, 2 => $type, 3 => '0']]);
                $this->view->mycart = $cartCount > 0 ? $cartCount : '0';
                $area = Shipto::findFirst(['conditions' => '(suserid = ?1 AND type = ?2)','bind' => [1 => $uid, 2 => $type]]);
                if(isset($area)){
                    $charge = Areas::findFirstByaid($area->sarea);
                    $ship_charge = $charge->delivery_charge > 0 ? $charge->delivery_charge : 0;
                    $this->view->shippingcost = $ship_charge;
                }else{$this->view->shippingcost = 0;}       
                $this->view->adata = $datax;
                $this->view->cats = Categories::find();
                $this->view->vendors = Sellers::find();
                $ratingEx = Ratings::count(['conditions' => '(productid = ?1 AND rating = ?2)','bind' => [1 => $datax->id, 2 => 5]]);
                $ratingDx = Ratings::count(['conditions' => '(productid = ?1 AND rating = ?2)','bind' => [1 => $datax->id, 2 => 4]]);
                $ratingCx = Ratings::count(['conditions' => '(productid = ?1 AND rating = ?2)','bind' => [1 => $datax->id, 2 => 3]]);
                $ratingBx = Ratings::count(['conditions' => '(productid = ?1 AND rating = ?2)','bind' => [1 => $datax->id, 2 => 2]]);
                $ratingAx = Ratings::count(['conditions' => '(productid = ?1 AND rating = ?2)','bind' => [1 => $datax->id, 2 => 1]]);
                $this->view->ratingE = $ratingEx > 0 ? $ratingEx : 0;
                $this->view->ratingD = $ratingDx > 0 ? $ratingDx : 0;
                $this->view->ratingC = $ratingCx > 0 ? $ratingCx : 0;
                $this->view->ratingB = $ratingBx > 0 ? $ratingBx : 0;
                $this->view->ratingA = $ratingAx > 0 ? $ratingAx : 0;            
    #SimilarType 
                $currentKeys =  explode(',', $datax->keywords);
                $query = Products::query()->limit(10);
                $bindParams = [];
                for($i=0; $i < count($currentKeys); $i++) {
                   $query->orWhere('keywords LIKE :key'.$i.':');
                   $bindParams['key'.$i] = '%'.$currentKeys[$i].'%';
                }
                $this->view->similars = $query->bind($bindParams)->execute();
                $this->view->pick('index/details');
            }else{$this->flashSession->warning("WARNING:: No Data Found!"); return $this->response->redirect('index');}
        }else{return $this->response->redirect();}
    } 
    public function getsscidAction(int $sscid = null){
        if(func_num_args()){
            $qry = Products::findBysscid($sscid);
            $this->view->mycart = count($qry);
            $this->view->products = $qry;
            $this->view->cats = Categories::find();
            $this->view->pick('index/products');
        }else{return $this->response->redirect('index');}
    }
    public function CategoryAction($catego = null)
    { 
        if(func_num_args()){
            $uid = $this->session->get('id');
            $type = $this->session->get('type');   
            $cartCount = Cart::count(['conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3)','bind' => [1 => $uid, 2 => $type, 3 => '0']]);
            $this->view->mycart = $cartCount > 0 ?  $cartCount : '0';
    # Get Categories
            $csrf = $this->security->getRequestToken();
            if(!empty($catego) && $this->security->checkToken($csrf, $this->security->getSessionToken())){
                $datax = Categories::find(['conditions' => 'categoryname = ?1','bind' => [1 => urldecode($catego)]]);
                $this->view->data = $datax;
                $this->view->cats = Categories::find();      
                $this->view->pick('index/category');
            }
        }else{return $this->response->redirect('index');}
    }  
    public function subCategoryAction($subcatego = null)
    {      
        $uid = $this->session->get('id');
        $type = $this->session->get('type');
        $this->view->uid = $uid;
        $this->view->type = $type;
        $cartCount = Cart::count(['conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3)','bind' => [1 => $uid, 2 => $type, 3 => '0']]);
        $this->view->mycart = $cartCount > 0 ?  $cartCount : '0';
# Get Categories
        $csrf = $this->security->getRequestToken();
        if(!empty($subcatego) && $this->security->checkToken($csrf, $this->security->getSessionToken())){
            $datax = Subcat::find(['conditions' => 'category_id = ?1','bind' => [1 => urldecode($subcatego)]]);
            $this->view->data = $datax;
            $this->view->pcount = count($datax);
            $this->view->cats = Categories::find();
            $this->view->pick('index/subcategory');
        }else{return $this->response->redirect('index');}
    } 
    public function sscallAction($sscId = null)
    {        
        $uid = $this->session->get('id');
        $type = $this->session->get('type');        
        $cartCount = Cart::count(['conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3)','bind' => [1 => $uid, 2 => $type, 3 => '0']]);
        $this->view->mycart = $cartCount > 0 ?  $cartCount : '0';
# Get Categories
        $csrf = $this->security->getRequestToken();
        if(!empty($sscId) && $this->security->checkToken($csrf, $this->security->getSessionToken())){
            $datax = Ssc::find(['conditions' => 'subcatid = ?1','bind' => [1 => urldecode($sscId)]]);
            $this->view->data = $datax;
            $this->view->pcount = count($datax);
            $this->view->cats = Categories::find();
            $this->view->pick('index/sscall');
        }else{return $this->response->redirect();}
    }         
    public function addcartAction()
    {        
        $this->view->disable();
        if(!empty($this->session->get('uname')))
        {
            $type = $this->session->get('type');
            $userid = $this->session->get('id');
            $shopid = $this->request->getPost('shopno');
            $price = $this->request->getPost('price');
            $productid = $this->request->getPost('productid');
            $color = $this->request->getPost('color');
            $size = $this->request->getPost('psize');
            $weight = $this->request->getPost('weight');
            $quant = $this->request->getPost('quantity');
            $discount = $this->request->getPost('discount');
            $dcharge = $this->request->getPost('delivery');
            $coupon = !empty($this->request->getPost('coupon')) ? $this->request->getPost('coupon') : '0';
            $cashonfee = '0';
            $orderflag = '0';
            $orderstatus = '0';
            $trxn = '0';
            $paytype = '0';
            $data = Products::findFirstByid($productid);
            if(!isset($color)){ $msg = 'Please Choose a Type/Color.'; return $msg; }
            elseif($data->psize !== '0' && empty($size)){ $msg = 'Please Choose a Scale.'; return $msg; }
            else
            {
                $query = Cart::findFirst(['conditions' => 'userid= ?1 AND productid= ?2 AND size= ?3 AND color= ?4 AND type = ?5 AND shopid = ?6 AND orderflag = ?7',
                    'bind' => [1 => $userid, 2 => $productid, 3 => $size, 4 => $color, 5 => $type, 6 => $shopid, 7 => '0']]);
                if(!empty($query))
                {
                    $qty = $query->quantity;
                    $query->quantity = $qty + $quant;
                    if(!empty($query->discount) > 0){$query->subtotal = $query->discount * $query->quantity;}else{$query->subtotal = $query->price * $query->quantity;}
                    $msg = Cart::count(['conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3)','bind' => [1 => $userid, 2 => $type, 3 => '0']]);
                    if($query->update() === true){echo(json_encode($msg));}else{echo $msg = 'Update Failed!';}
                }   
                else
                {
                    $cart = new Cart();
                    $cart->productid = $productid;
                    $cart->userid = $userid;
                    $cart->orderid = $userid.$productid.'-'.date('dmyHis');
                    $cart->quantity = $quant;
                    $cart->price = $price;
                    $cart->discount = $discount;
                    $cart->size = !empty($size) ? $size : '0';
                    $cart->weight = !empty($weight) ? $weight : '0';
                    $cart->color = $color;
                    $cart->type = $type;
                    $cart->shipingcost = !empty($dcharge) ? $dcharge : '0'; 
                    $cart->shopid = $shopid;
                    $cart->coupon = $coupon;
                    $cart->cashonfee = '0';
                    $cart->orderflag = $orderflag;
                    $cart->orderstatus = $orderstatus; 
                    $cart->trxn = $trxn;
                    $cart->paytype = $paytype;                  
                    $cart->orderdate = date('Y-m-d');                   
                    if($cart->discount > 0){$cart->subtotal = $cart->discount * $cart->quantity;}else{$cart->subtotal = $cart->price * $cart->quantity;}
                    if($cart->save() === true){
                    $msg = Cart::count(['conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3)','bind' => [1 => $userid, 2 => $type, 3 => '0']]);
                    echo(json_encode($msg));}else{ foreach($cart->getMessages() as $msg){echo(json_encode($msg));} }
                }
            }            
        }else{return $msg = 'Please Login First!';}
    }  
    public function viewcartAction()
    {
        $csrf = $this->security->getRequestToken();
        if(!empty($this->session->get('uname')) && $this->security->checkToken($csrf, $this->security->getSessionToken()))
        {
            $uid = $this->session->get('id');
            $type = $this->session->get('type');
            $this->view->cats = Categories::find(); 
            $query = Cart::find(['conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3)','bind' => [1 => $uid, 2 => $type, 3 => '0']]);
            $this->view->mycart = $query->count() > 0 ?  $query->count() : '0';
            if($query->count() > 0){
                $this->view->carts = $query;
                $this->view->products = Products::find();
                $st = Cart::sum(['column' => 'subtotal', 'conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3)', 'bind' => [1 => $uid, 2 => $type, 3 => '0']]);
                $this->view->subtotal = $st;
                $sc = Cart::sum(['column' => 'shipingcost', 'conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3)', 'bind' => [1 => $uid, 2 => $type, 3 => '0']]);
                $this->view->shippingcost = $sc;
                $this->view->coupon = '0';            
                $this->view->pick('index/viewcart');
            }
        }else{$this->flashSession->warning("WARNING:: Please Login First!"); return $this->response->redirect();}
    }   
    public function couponAction()
    {
        $uid = $this->session->get('id');
        $type = $this->session->get('type');
        $couponcode = $this->request->getPost('couponcode');
        $query = Products::findFirstBycoupon($couponcode);
        if(!empty($couponcode) and $query->coupon === $couponcode)
        {
            $checkcart = Cart::find([
                'conditions' => '(couponapply = ?1 AND userid = ?2 AND type = ?3)',
                'bind' => [1 => $couponcode, 2 => $uid, 3 => $type]
            ]);
            if($checkcart->count() > 0)
            {echo('Already coupon used');}else{
                $checkcart->couponapply = $couponcode;
                if($checkcart->update() === true){
                    //$checkcart->grandtotal = ($checkcart->subtotal - $query->couponamount); 
                    echo(json_encode('COUPON APPLIED'));
                }else{
                    foreach($checkcart->getMessages() as $msg){echo(json_encode($msg));}
                }
            }
        }else{echo(json_encode('Invalid Coupon'));}
    }
    public function checkoutAction()
    {  
        if(!empty($this->session->get('uname')))
        {
            $uid = $this->session->get('id');
            $type = $this->session->get('type');
            $countcart = Cart::count(['conditions' => 'userid = ?1 AND type = ?2 AND orderflag = ?3 AND orderstatus = ?4 ', 'bind' => [ 1 => $uid, 2 => $type, 3 => '0', 4 => '0']]);
            if($countcart > 0){
                $query = Shipto::find(['conditions' => 'suserid = ?1 AND type = ?2','bind' => [1 => $uid, 2 => $type] ]);
                if($query->count() > 0){
                    $this->view->mycart = $countcart;
                    $q = Cart::find(['conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3)','bind' => [1 => $uid, 2 => $type, 3 => '0']]);
                    $this->view->data = $q;
                    $st = Cart::sum(['column' => 'subtotal', 'conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3)', 'bind' => [1 => $uid, 2 => $type, 3 => '0']]);
                    $this->view->subtotal = $st;
                    $sc = Cart::sum(['column' => 'shipingcost', 'conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3)', 'bind' => [1 => $uid, 2 => $type, 3 => '0']]);
                    $this->view->shippingcost = $sc;
                    $this->view->setVar('shipping', $query);
                    $this->view->citys = Citys::find();
                    $this->view->regions = Regions::find();
                    $this->view->areas = Areas::find();
                    $this->view->cats = Categories::find();
                    $this->view->pick('index/checkout');
                }else{return $this->response->redirect('index/getship');}
            }else{return $this->response->redirect();}
        }else{
            $this->flashSession->warning("WARNING:: Please Login First!"); return $this->response->redirect($this->request->getHTTPReferer());
        }
    }    
    public function updatecartAction()
    {
        $this->view->disable();
        $uid = $this->session->get('id');
        $type =  $this->session->get('type');
        $id = $this->request->getPost('id');
        $quantity = $this->request->getPost('value');
        $query = Cart::findFirst(['conditions' => 'userid = ?1 AND type = ?2 AND id = ?3 AND orderflag = ?4','bind' => [ 1 => $uid, 2 => $type, 3 => $id, 4 => '0']]);
        $query->quantity = $quantity;
        if(!empty($query->discount) > 0){$query->subtotal = $query->discount * $quantity; }else{$query->subtotal = $query->price * $quantity;}
        if($query->update() === true){
            $st = Cart::sum(['column' => 'subtotal', 'conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3)', 'bind' => [1 => $uid, 2 => $type, 3 => '0']]);
            $sh = Cart::sum(['column' => 'shipingcost', 'conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3)', 'bind' => [1 => $uid, 2 => $type, 3 => '0']]);
            $data = Cart::find(['conditions' => '(userid = ?1 AND type = ?2 AND id = ?3 AND orderflag = ?4)', 'bind' => [1 => $uid, 2 => $type, 3 => $id, 4 => '0']]); 
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
        $ssid = $uid = $this->session->get('id');
        $del = Cart::findFirst(['conditions' => 'id = ?1 AND userid = ?2 AND type = ?3 AND orderflag = ?4', 'bind' => [ 1 => $id, 2 => $uid, 3 => $type, 4 => '0']]);
        if($del->delete() === true){
        $countcart = Cart::count(['conditions' => 'userid = ?1 AND type = ?2 AND orderflag = ?3', 'bind' => [ 1 => $uid, 2 => $type, 3 => '0']]);
            $resData = array();
            if($countcart > 0){
                $st = Cart::sum(['column' => 'subtotal', 'conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3)', 'bind' => [1 => $uid, 2 => $type, 3 => '0']]);
                $sh = Cart::sum(['column' => 'shipingcost', 'conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3)', 'bind' => [1 => $uid, 2 => $type, 3 => '0',]]);
                $data = Cart::find(['conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3)', 'bind' => [1 => $uid, 2 => $type, 3 => '0']]);
                        
                    foreach($data as $result)
                    {
                        $resData[] = array('id' => $result->id, 'subtotal' => $st, 'shipingcost' => $sh, 'ccount' => $countcart);
                    }
                    echo(json_encode($resData));
            }else{ $resData[] = array('id' => $ssid); echo(json_encode($resData)); }
        }else{return false;}   
    }
    public function buychooseAction()
    {//Click BuyNow Button
        $this->view->disable();
        if(!empty($this->session->get('uname')))
        {           
            $type = $this->session->get('type');
            $userid = $this->session->get('id');
            $shopid = $this->request->getPost('shopno');
            $price = $this->request->getPost('price');
            $productid = $this->request->getPost('productid');
            $color = $this->request->getPost('color');
            $size = $this->request->getPost('size');
            $weight = $this->request->getPost('weight');
            $quant = $this->request->getPost('quantity');
            $discount = $this->request->getPost('discount');
            $dcharge = $this->request->getPost('delivery');
            $coupon = !empty($this->request->getPost('coupon')) ? $this->request->getPost('coupon') : '0';
            $cashonfee = '0';
            $orderflag = '0';
            $orderstatus = '0';
            $trxn = '0';
            $paytype = '0';           
            $data = Products::findFirstByid($productid);
            if(empty($color)){ $msg = 'Please Choose a Type/Color.'; return json_encode($msg); }
            elseif($data->psize !== '0' && empty($size)){ $msg = 'Please Choose a Scale.'; return json_encode($msg); }  
            else{
                $query = Cart::findFirst(['conditions' => 'userid= ?1 AND productid= ?2 AND size= ?3 AND color= ?4 AND type = ?5 AND shopid = ?6 AND orderflag = ?7',
                    'bind' => [1 => $userid, 2 => $productid, 3 => $size, 4 => $color, 5 => $type, 6 => $shopid, 7 => '0']]);
                if(!empty($query))
                {
                    $qty = $query->quantity;
                    $query->quantity = $qty + $quant;
                    if(!empty($query->discount) > 0){$query->subtotal = $query->discount * $query->quantity;}else{$query->subtotal = $query->price * $query->quantity;} 
                    $msg = Cart::count(['conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3)','bind' => [1 => $userid, 2 => $type, 3 => '0']]); 
                    if($query->update() === true){echo(json_encode($msg));}else{echo $msg = 'Update Failed!';}
                }  
                else{
                    $cart = new Cart();
                    $cart->productid = $productid;
                    $cart->userid = $userid;
                    $cart->orderid = $userid.$productid.'-'.date('dmyHis');
                    $cart->quantity = $quant;
                    $cart->price = $price;
                    $cart->discount = $discount;
                    $cart->size = !empty($size) ? $size : '0';
                    $cart->weight = !empty($weight) ? $weight : '0';
                    $cart->color = $color;
                    $cart->type = $type;
                    $cart->shipingcost = !empty($dcharge) ? $dcharge : '0'; 
                    $cart->shopid = $shopid;
                    $cart->coupon = $coupon;
                    $cart->cashonfee = '0';
                    $cart->orderflag = $orderflag;
                    $cart->orderstatus = $orderstatus; 
                    $cart->trxn = $trxn;
                    $cart->paytype = $paytype;
                    $cart->orderdate = date('Y-m-d'); 
                    if(!empty($cart->discount) > 0){$cart->subtotal = $cart->discount * $cart->quantity;}else{$cart->subtotal = $cart->price * $cart->quantity;}
                    $msg = Cart::count(['conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3)','bind' => [1 => $userid, 2 => $type, 3 => '0']]);
                    if($cart->save() === true){echo(json_encode($msg));}else{echo $msg = 'Data Injection Failed!';} 
                }
            } 
        }else{return $msg = 'Please Login First!';}
    }
    public function getshipAction()
    {//BuyNow Button Send Here
        //$this->dispatcher->forward(['controller' => 'index','action' => 'index',]);
        if(!empty($this->session->get('uname')))
        {
            $uid = $this->session->get('id');
            $type = $this->session->get('type');
            $this->view->cats = Categories::find();
            $cartCount = Cart::count(['conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3)','bind' => [1 => $uid, 2 => $type, 3 => '0']]);
            $this->view->mycart = $cartCount > 0 ?  $cartCount : '0';  
            $query = Shipto::findFirst(['conditions' => 'suserid= ?1 AND type = ?2','bind' => [1 => $uid, 2 => $type] ]);
            if(!empty($query))
            { 
                $mode = '1';
                $this->view->suserid = $query->suserid;
                $this->view->fname = $query->fname;
                $this->view->sphone = $query->sphone;
                $this->view->srid = $query->sregion;
                $this->view->scid = $query->scity;
                $this->view->said = $query->sarea;
                $cartcharge = Cart::findFirst(['conditions' => '(userid = ?1 AND type = ?2)','bind' => [1 => $uid, 2 => $type]]);
                $this->view->dcharge = $cartcharge->shipingcost;
                $this->view->saddress = $query->saddress;          
            }else{ 
                $mode = '0';
                $this->view->suserid = $uid;
                $this->view->fname = $this->view->sphone = $this->view->sregion = $this->view->scity = $this->view->sarea = $this->view->dcharge = $this->view->saddress = $this->view->srid = $this->view->scid = $this->view->said = '';
            }
                $this->view->aspect = $mode;
                $this->view->action = 'index/shipto';
                $this->view->citys = Citys::find();
                $this->view->regions = Regions::find();
                $this->view->areas = Areas::find();
                $this->view->data = Cart::findByuserid($uid);
                $this->view->pick('index/getship');
        }else{ $this->flashSession->warning("WARNING:: Please Login First!");return $this->response->redirect($this->request->getHTTPReferer()); }
    }
    public function shiptoAction()
    {//getShip Send Here for shiped save
        $this->view->disable();
        $type = $this->session->get('type');
        $suserid = $this->session->get('id');        
        if(!empty($this->session->get('uname')))
        {
            $fname = htmlspecialchars($this->request->getPost('fname'));
            $sphone = htmlspecialchars($this->request->getPost('sphone'));
            $sregion = $this->request->getPost('sregion');
            $scity = $this->request->getPost('scity');
            $sarea = $this->request->getPost('sarea');
            $dcharge = !empty($this->request->getPost('dcharge')) ? $this->request->getPost('dcharge') : '0';
            $saddress = htmlspecialchars($this->request->getPost('saddress'));
            $query = Shipto::findFirst(['conditions' => '(suserid = ?1 AND type = ?2)','bind' => [1 => $suserid, 2 => $type] ]); 
            if(!empty($query))
            {  
                $query->suserid = $suserid;
                $query->type = $type;
                $query->fname = !empty($fname) ? $fname : $query->fname;
                $query->sphone = !empty($sphone) ? $sphone : $query->sphone;
                $query->sregion = !empty($sregion) ? $sregion : $query->sregion;
                $query->scity = !empty($scity) ? $scity : $query->scity;
                $query->sarea = !empty($sarea) ? $sarea : $query->sarea;
                $query->saddress = !empty($saddress) ? $saddress : $query->saddress;                
                if($query->update() === true)
                {
                    $cart = Cart::find([ 'conditions' => 'userid = ?1 AND type = ?2 AND orderflag = ?3','bind' => [1 => $suserid, 2 => $type, 3 => '0'] ]);
                    foreach($cart as $cart)
                    {
                        $cart->shipingcost = $dcharge; $response = ($cart->update() === true) ? true : false;
                    }
                    if($response === true){return $this->response->redirect('index/checkout/');}else{$this->flashSession->error("ERROR :: Cart Update Failed!"); return $this->response->redirect('index/getship/');}                    
                }else{ $this->flashSession->error("ERROR:: Unable to Update Data, Please try Again!");return $this->response->redirect($this->request->getHTTPReferer()); }
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
                    $cart = Cart::find([ 'conditions' => 'userid = ?1 AND type = ?2 and orderflag = ?3','bind' => [1 => $suserid, 2 => $type, 3 => '0'] ]);
                    foreach($cart as $c)
                    {
                        $c->shipingcost = $dcharge; $response = ($c->update() === true) ? true : false;                        
                    }
                    if($response === true){return $this->response->redirect('index/checkout/');}else{$this->flashSession->error("ERROR :: Cart Update Failed!");return $this->response->redirect('index/getship/');} 
                }else{$this->flashSession->error("ERROR:: Required Fields Going Empty!"); return $this->response->redirect('index/getship/');}
                //foreach($query->getMessages() as $message){echo $message->getMessage(), "<br/>";}
            }            
        }else{ $this->flashSession->error("ERROR:: Please Login First!"); return $this->response->redirect($this->request->getHTTPReferer()); }  
    }      
    public function paymentAction()
    {  
        $name = $this->session->get('uname');
        $active = $this->session->get('active');
        $level = $this->session->get('level');
        $uid = $this->session->get('id');
        $type = $this->session->get('type');         
        $this->view->uid = $uid;
        $this->view->uname = $name;
        $this->view->active = $active;
        $this->view->level = $level;
        $this->view->type = $type;
        if(!empty($name))
        {               
            $cartCount = Cart::count(['conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3 AND orderstatus = ?4)','bind' => [1 => $uid, 2 => $type, 3 => '0', 4 => '0']]);
            $this->view->mycart = $cartCount > 0 ?  $cartCount : '0';
            $st = Cart::sum(['column' => 'subtotal', 'conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3 AND orderstatus = ?4)', 'bind' => [1 => $uid, 2 => $type, 3 => '0', 4 => '0']]);
            $sh = Cart::sum(['column' => 'shipingcost', 'conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3 AND orderstatus = ?4)', 'bind' => [1 => $uid, 2 => $type, 3 => '0', 4 => '0']]);
            $pamount = ceil((int)($st+$sh));
            $this->view->trxid = $uid.date('dmYHis-').$pamount;
            $this->view->pamount = $pamount;
            $this->view->cats = Categories::find();
            $this->view->pick('index/payment');            
        }else{
            $this->flashSession->error("ERROR:: Please Login First!");return $this->response->redirect($this->request->getHTTPReferer());
        }  
    }
    public function payprocessAction()
    { 
        # KEY BIND FOR NUMBER'S, DOT'S & BACKSPACE ONLY : [8, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 110, 190] 
        $this->view->disable();
        $uid = $this->session->get('id');
        $type = $this->session->get('type');  
        $paytype = $this->request->getPost('paytype');
        $trxID = $this->request->getPost('trxid'); 
        $pamount = $this->request->getPost('pamount'); 
        $paymode = match($paytype){'cashon' => '1','bkash' => '2','nagad' => '3','rocket' => '4'};
        if(!empty($trxID && $paytype)){
            $query = Cart::find([ 'conditions' => 'userid = ?1 AND type = ?2 AND orderflag = ?3 AND orderstatus = ?4','bind' => [1 => $uid, 2 => $type, 3 => '0', 4 => '0'] ]);
            if($paymode === '1'){
                foreach($query as $update){
                    $update->orderstatus = '1'; 
                    $update->orderflag = '1'; 
                    $update->paytype = $paymode;
                    $update->trxn = $trxID;
                    $update->cashonfee = '10';
                    $x = $update->update();
                }
                if($x === true){echo('Y');}else{echo(json_encode('Data Update Failed, Please! Try Again...'));}
            }else{
                foreach($query as $update){
                    $update->orderstatus = '1';
                    $update->orderflag = '1'; 
                    $update->paytype = $paymode;
                    $update->trxn = $trxID;
                    $update->cashonfee = '0';
                    $x = $update->update();
                }
                if($x === true){echo('Y');}else{echo(json_encode('Data Update Failed, Please! Try Again...'));}
            }
        }else{echo(json_encode('Required Data Missing!'));}
    }
    public function thanksAction()
    {  
        if(!empty($this->session->get('uname')))
        {
            $name = $this->session->get('uname');
            $active = $this->session->get('active');
            $level = $this->session->get('level');            
            $uid = $this->session->get('id');
            $type = $this->session->get('type');  
            $this->view->uid = $uid;
            $this->view->uname = $name;
            $this->view->active = $active;
            $this->view->level = $level;
            $this->view->type = $type;
            $cartCount = Cart::count(['conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3 AND orderstatus = ?4)','bind' => [1 => $uid, 2 => $type, 3 => '1', 4 => '1']]);
            $this->view->mycart = $cartCount > 0 ? $cartCount : '0';          
            $this->view->pick('index/thanks');
        }else{$this->flashSession->error("ERROR:: Please Login First!");return $this->response->redirect($this->request->getHTTPReferer());}         
    }
    public function getcityAction()
    { 
        $this->view->disable();$id = $this->request->getPost('id');$data = Citys::findByregionid($id);$resData = array();    
        foreach($data as $result){$resData[] = array('cid' => $result->cid, 'rid' => $result->regionid, 'city' => $result->cityname);}echo(json_encode($resData));
    }
    public function getareaAction()
    { 
        $this->view->disable();$id = $this->request->getPost('id');$data = Areas::findBycid($id); $resData = array();    
        foreach($data as $result){$resData[] = array('aid' => $result->aid, 'cid' => $result->cid, 'area' => $result->areaname);}echo(json_encode($resData));       
    }  
    public function getdeliveryAction()
    { 
        $this->view->disable();$id = $this->request->getPost('xid');$data = Areas::findFirstByaid($id); $resData = array(); 
        foreach($data as $result){$resData[] = array('aid' => $data->aid, 'cid' => $data->cid, 'dcharge' => $data->delivery_charge);}echo(json_encode($resData));
    }
    public function queryAction()
    {
        $uid = $this->session->get('id');
        $type = $this->session->get('type');
        $csrf = $this->security->getRequestToken();       
        $data = htmlspecialchars($this->request->getPost('query'));
        if(!empty($data) && $this->security->checkToken($csrf, $this->security->getSessionToken()))
        {
            $cartCount = Cart::count(['conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3 AND orderstatus = ?4)','bind' => [1 => $uid, 2 => $type, 3 => '0', 4 => '0']]);
            $this->view->mycart = $cartCount > 0 ?  $cartCount : '0';
            $searchTerms = explode(' ' , $data);
            $searchTerms = array_map('trim' , $searchTerms);
            $conditions = [];
            foreach ($searchTerms as $term){ $conditions[] = "product_title LIKE '%$term%' OR keywords LIKE '%$term%' OR specification LIKE '%$term%'"; }
            $conditions = implode(' OR ' , $conditions);
            $query = $this->db->query("SELECT id, pimg_front, product_title, keywords, specification FROM products WHERE $conditions LIMIT 100;");
            if($query->numRows() > 0)
            {              
                $this->view->data = $query->fetchAll();
                $this->view->cats = Categories::find();
                $this->view->pick('index/query');
            }else{$this->flashSession->warning("WARNING:: No Data Found!");return $this->response->redirect('index');}
        }else{$this->flashSession->error("ERROR:: Query Error!");return $this->response->redirect('index');}
    }

//     public function queryAction()
//     {
// # | IN BOOLEAN MODE | IN NATURAL LANGUAGE MODE | IN NATURAL LANGUAGE MODE WITH QUERY EXPANSION | 
// #--
// #-- Indexes for table `products`
// #--
// #ALTER TABLE `products`
// #ADD PRIMARY KEY (`id`);
// #ALTER TABLE `products` ADD FULLTEXT KEY `query` (`product_title`,`keywords`,`specification`);
//         $csrf = $this->security->getRequestToken(); 
//         $data = htmlspecialchars($this->request->getPost('query'));
//         if(!empty($data) and $this->security->checkToken($csrf, $this->security->getSessionToken()))
//         {
//             $a = explode(' ', $data);
//             $b = array_map('trim', $a);
//             $c = implode(',', $b);            

//             $query = $this->db->query("SELECT id,pimg_front,product_title,keywords,specification FROM products WHERE MATCH(product_title,keywords,specification) AGAINST('$c' IN NATURAL LANGUAGE MODE WITH QUERY EXPANSION);");
//               if($query->numRows() > 0)
//               {
//                 $this->view->setVar('data', $query->fetchAll());
//                 $this->view->pick('index/query');
//              }else{$this->flashSession->warning("WARNING:: No Data Found!");return $this->response->redirect('index/index');}    
//         }else{$this->flashSession->error("ERROR:: Query Error!");return $this->response->redirect('index/index');}
//     }
    // public function orderAction()
    // {
    //     # SELECT orderid FROM cart WHERE orderid IN('1-30-120922-134321','1-30-120922-141448');
    //     $this->view->disable();
    //     if($this->session->exists() and !empty($this->session->get('type'))){
    //         $orders = $this->request->getPost('orders');
    //         $uid = $this->session->get('id');
    //         $type = $this->session->get('type');
    //         // $bTypes = array('orderid' => Column::BIND_PARAM_STR,);
    //         // $dox = Cart::find([
    //         //     'conditions' => "orderid IN ({oId:array})",
    //         //     'bind' => ['oId' => $orders],
    //         //     'bindTypes'   => $bTypes,'for_update' => true,'limit' => '10','order' => 'orderid desc',
    //         // ]);
    //         $data = implode("','",$orders);
    //         $query = $this->db->query("UPDATE cart SET orderflag = '1', orderstatus = '1' WHERE orderid IN('$data')");  
    //         if($query->numRows() > 0){echo('Y');}else{echo('X');}
    //     }else{return $this->response->redirect();}  
    // }
# Track    
    public function trackAction()
    {
        $uid = $this->session->get('id');
        $type = $this->session->get('type');
        $query = Cart::find(['conditions' => 'userid = ?1 AND type = ?2 AND orderflag = ?3','bind' => [1 => $uid, 2 => $type, 3 => '1']]);
        $this->view->mycart = $query->count() > 0 ?  $query->count() : '0';
        if(!empty($this->session->get('uname')) && $query->count() > 0){
            $this->view->myorder = $query;
            //$this->view->eKey = $this->crypt->getKey();
            $this->view->cats = Categories::find();
            $this->view->pick('index/track');
        }else{$this->flashSession->error("ERROR:: No Data Found!");return $this->response->redirect($this->router->getControllerName());}
    }
    public function vendorAction($vendor = null)
    {
        $uid = $this->session->get('id');
        $type = $this->session->get('type');
        $cartCount = Cart::count(['conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3 AND orderstatus = ?4)','bind' => [1 => $uid, 2 => $type, 3 => '0', 4 => '0']]);
        $this->view->mycart = $cartCount > 0 ?  $cartCount : '0';       
        $vendor = Products::find(['conditions' => '(shopid = ?1)','bind' => [1 => $vendor]]);
        $this->view->vendor =$vendor;
        $this->view->cats = Categories::find(); 
        $this->view->pick('index/vendor');
    } 
    public function cancelorderAction(int $data = null)
    {
        $this->view->disable();
        $uid = $this->session->get('id');
        $type = $this->session->get('type');
        $query = Cart::findFirst(['conditions' => 'userid = ?1 AND type = ?2 AND orderflag = ?3 AND orderstatus = ?4 AND id = ?5','bind' => [1 => $uid, 2 => $type, 3 => '1', 4 => '1', 5 => $data]]);
        if(!empty($this->session->get('uname')) and $query->delete() === true){
            $this->flashSession->success("SUCCESS:: Order Canceled!");return $this->response->redirect($this->router->getControllerName());
        }else{return $this->response->redirect($this->router->getControllerName());}        
    }
    public function ratingAction()
    {
        $this->view->disable();
        if(!empty($this->session->get('uname'))){
            $rating = $this->request->getPost('rating');
            $pId = $this->request->getPost('pid');
            $uid = $this->session->get('id');
            $getrecord = Ratings::findFirst(['conditions' => 'usrid = ?1 AND productid = ?2','bind' => [1 => $uid, 2 => $pId]]);
            if(!empty($getrecord)){
                $getrecord->rating = $rating;
                if($getrecord->update() === true){ echo(json_encode('Y')); }else{ echo(json_encode('N')); }
            }else{
                $query = new Ratings();
                $query->usrid = $uid;
                $query->productid = $pId;
                $query->rating = $rating;
                if($query->save() === true){ echo(json_encode('Y')); }else{ echo(json_encode('N')); }
            }
        }else{echo(json_encode('Please Login First!'));}
    }
    public function invoiceAction(){
        $uid = $this->session->get('id');
        $type = $this->session->get('type');
        $query = Cart::find(['conditions' => 'userid = ?1 AND type = ?2 AND orderflag = ?3','bind' => [1 => $uid, 2 => $type, 3 => 1]]);
        $this->view->mycart = $query->count() > 0 ?  $query->count() : '0';
        if(!empty($this->session->get('uname')) && $query->count() > 0){
            $this->view->myorder = $query;
            $this->view->cats = Categories::find();
            $this->view->pick('index/invoice');
        }else{return $this->response->redirect($this->router->getControllerName('index'));}
    }
    public function aboutusAction(){ 
        $uid = $this->session->get('id');
        $type = $this->session->get('type');   
        $cartCount = Cart::count(['conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3)','bind' => [1 => $uid, 2 => $type, 3 => '0']]);
        $this->view->mycart = $cartCount > 0 ?  $cartCount : '0';        
        $this->view->pick('index/cookies'); 
    }
    public function propertyAction(){ 
        $uid = $this->session->get('id');
        $type = $this->session->get('type');   
        $cartCount = Cart::count(['conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3)','bind' => [1 => $uid, 2 => $type, 3 => '0']]);
        $this->view->mycart = $cartCount > 0 ?  $cartCount : '0';        
        $this->view->pick('index/cookies'); 
    }
    public function privacyAction(){ 
        $uid = $this->session->get('id');
        $type = $this->session->get('type');   
        $cartCount = Cart::count(['conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3)','bind' => [1 => $uid, 2 => $type, 3 => '0']]);
        $this->view->mycart = $cartCount > 0 ?  $cartCount : '0';        
        $this->view->pick('index/cookies'); 
    }
    public function cookiesAction(){ 
        $uid = $this->session->get('id');
        $type = $this->session->get('type');   
        $cartCount = Cart::count(['conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3)','bind' => [1 => $uid, 2 => $type, 3 => '0']]);
        $this->view->mycart = $cartCount > 0 ?  $cartCount : '0';        
        $this->view->pick('index/cookies'); 
    }
    public function termsAction(){ 
        $uid = $this->session->get('id');
        $type = $this->session->get('type');   
        $cartCount = Cart::count(['conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3)','bind' => [1 => $uid, 2 => $type, 3 => '0']]);
        $this->view->mycart = $cartCount > 0 ?  $cartCount : '0';        
        $this->view->pick('index/cookies'); 
    }
    public function legalAction(){ 
        $uid = $this->session->get('id');
        $type = $this->session->get('type');   
        $cartCount = Cart::count(['conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3)','bind' => [1 => $uid, 2 => $type, 3 => '0']]);
        $this->view->mycart = $cartCount > 0 ?  $cartCount : '0';        
        $this->view->pick('index/cookies'); 
    }
    public function feedbackAction(){ 
        $uid = $this->session->get('id');
        $type = $this->session->get('type');   
        $cartCount = Cart::count(['conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3)','bind' => [1 => $uid, 2 => $type, 3 => '0']]);
        $this->view->mycart = $cartCount > 0 ?  $cartCount : '0';        
        $this->view->pick('index/cookies'); 
    }  

    public function doPdfAction() {
        $this->view->disable();
        $uid = $this->session->get('id');
        $type = $this->session->get('type');
        $query = Cart::find(['conditions' => 'userid = ?1 AND type = ?2 AND orderflag = ?3', 'bind' => [1 => $uid, 2 => $type, 3 => 1]]);
        // Logo path
        $logo = 'img/bee.png'; 
        // Create a new PDF instance
        $pdf = new FPDF("P", "mm", "A5");
        $pdf->AddPage();
        // Set font for entire table
        $pdf->SetFont('Arial', '', 5);
        // Set header background color and text color
        $headerBackgroundColor = array(68, 68, 68); // #444
        $headerTextColor = array(255, 255, 255); // #fff
        // Define column widths
        $columnWidths = array(20, 8, 15, 15, 15, 10, 15, 20);
        // Column headers
        $header = array('OrderID', 'Qty', 'Size', 'Price', 'Discount', 'CoD', 'Shipping', 'Subtotal');
        // Print logo
        $pdf->Image($logo, 10, 10, 0, 10); // Adjust the coordinates and size as needed
        // Print company details with padding
        $pdf->SetXY(50, 12); // Adjust the coordinates as needed
        $pdf->Ln(10);
        $pdf->Cell(0, 3, 'LampTouch', 0, 1, 'L', false, '', 1);
        $pdf->Cell(0, 3, 'Address: 001, Dhaka, Bangladesh', 0, 1, 'L', false, '', 1);
        $pdf->Cell(0, 3, 'Contact: +8801234567890', 0, 1, 'L', false, '', 1);
        $pdf->Cell(0, 3, 'Email: info@lamptouch.com', 0, 1, 'L', false, '', 1);

        // Print Bill To client information
        $pdf->SetXY(150, 15); // Adjust the coordinates as needed
        $pdf->Cell(0, 3, 'Bill To: Client Information Here', 0, 1, 'R', false, '', 1);
        $pdf->Cell(0, 3, 'Address: 001, Dhaka, Bangladesh', 0, 1, 'R', false, '', 1);
        $pdf->Cell(0, 3, 'Contact: +8801234567890', 0, 1, 'R', false, '', 1);
        $pdf->Cell(0, 3, 'Email: info@lamptouch.com', 0, 1, 'R', false, '', 1);
        $pdf->Ln(10);

        $pdf->SetFontSize(16);
        $pdf->Cell(0, 10, 'INVOICE', 0, 1, 'B');
        $pdf->Ln(1);

        $pdf->SetFontSize(5);
        // Print column headers
        $pdf->SetFillColor($headerBackgroundColor[0], $headerBackgroundColor[1], $headerBackgroundColor[2]);
        $pdf->SetTextColor($headerTextColor[0], $headerTextColor[1], $headerTextColor[2]);
        $pdf->SetDrawColor(238, 238, 238); // Set border color for header
        foreach ($header as $key => $columnHeader) { $pdf->Cell($columnWidths[$key], 5, $columnHeader, 1, 0, 'C', true); }
        $pdf->Ln();
        // actual data
        $rowNum = 0;
        foreach ($query as $row) {
            $rowNum++;
            $data = array(
                $row->orderid,
                $row->quantity,
                $row->size,
                $row->price,
                $row->discount,
                $row->cashonfee,
                $row->shipingcost,
                ($row->subtotal + $row->shipingcost + $row->cashonfee) - $row->discount
            );
            if ($rowNum % 2 == 0) {
                $bgColor = array(255, 255, 255); // White background for even rows
            } else {
                $bgColor = array(240, 240, 240); // Light gray background for odd rows
            }
            // Print table data
            $pdf->SetFillColor($bgColor[0], $bgColor[1], $bgColor[2]);
            $pdf->SetTextColor(0); // Black text color for zebra stripes
            $pdf->SetDrawColor(238, 238, 238); // Set border color for table rows
            foreach ($data as $key => $columnData) {
                $pdf->Cell($columnWidths[$key], 5, $columnData, 1, 0, 'C', true);
            }
            $pdf->Ln();
        }
        // Footer
        $pdf->SetY(-28);
        $pdf->SetFont('Arial', '', 8);
        $pdf->Cell(0, 4, 'This is a computer-generated invoice. No seal or signature required.', 0, 0, 'C');
        // Output the PDF as a download
        $pdf->Output('invoice_' . $uid . '.pdf', 'D');
    }
    public function feedAction()
    {
        $posts = Products::find();
        $rss_posts = array();
        foreach($posts as $post)
        {
            #$post->rss_date = $post->datetime; //date("D, d M Y H:i:s O", strtotime($post->datetime));
            $rss_posts[] = $post;
        }
        $this->view->posts = $rss_posts;
        $this->response->setHeader('Content-Type', 'application/xml; charset=UTF-8');
        #$this->response->setHeader('Content-Disposition', 'attachment; filename="feed.xml"');
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $this->view->brands = Sellers::find();
        $this->view->pick('index/feed');
    } 
#END  
}
