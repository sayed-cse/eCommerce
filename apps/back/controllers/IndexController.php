<?php declare(strict_types=1);
namespace F\Back\Controllers;
use F\Back\Models\Category as Categories;
use F\Back\Models\Subcategory as Subcat;
use F\Back\Models\Ssc as Ssc;
use F\Back\Models\Cart as Cart;
use F\Back\Models\Products as Products;
use F\Back\Models\Sellers as Sellers;
use Phalcon\Image\Adapter\GD as GdAdapter;
use Phalcon\Image\Adapter\Imagick;
use Phalcon\Image\Enum;
use Phalcon\Filter\Validation;
use Phalcon\Filter\Validation\Validator\StringLength\Min;
use Phalcon\Filter\Validation\Validator\PresenceOf;
use Phalcon\Paginator\Adapter\Model as paginator;
//use Phalcon\Paginator\Adapter\NativeArray as PaginatorArray;
//use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;
use RecursiveDirectoryIterator;
use RecursiveIteratorIterator;
use function in_array;
use function substr;
class IndexController extends BaseController
{
    public function initialize()
    {
        parent::initialize();
        $this->view->dynaOgImg = 'img/favicon.png';
        $this->view->dynaArticleTitle = 'Dynamic Article Title';
        $this->view->dynaArticle = 'Dynamic Article';
        $this->view->dynaOgUrl = $this->router->getControllerName();
        $this->view->dynadesc = 'A Trusted Online Shopping Platform in Bangladesh!';
        $this->view->dynakey = 'Buy, Sale, Online shopping, Automotive, Phones, Accessories, Computers, Electronics, Fashion, Beauty, Health, Home, Garden, Toys, Sports, Weddings';
        $this->view->dynagooglebot ='noindex,nofollow';
        $this->view->dynarobot = "noindex,nofollow,noarchive,nosnippet,noodp,noydir,noimagechache";                
    }	
    private function imageCheck($extension = null)
    {
        $allowedTypes = ['image/jpg','image/bmp','image/png','image/jpeg','image/webp']; return in_array($extension, $allowedTypes);
    }    	
    public function indexAction(){ if($this->session->has('uname') && $this->session->get('type') === 's'){return $this->response->redirect('back/index/entry')->send();} }
    public function productEditAction($id = null)
    {
        $user = $this->session->get('uname');
        $product = Products::findFirstByid($id);
        if(!empty($product) && $product->count() > 0){
            if($product->shopid === $this->session->get('id'))
            {
                $this->view->aspect = '1';
                $formAction = 'back/index/update';
                $this->view->setVar('action',$formAction);
                $this->view->id = $product->id;
                $this->view->setVar('pcid', $product->category_id);
                $this->view->setVar('pscid', $product->subcategory_id);
                $this->view->setVar('psscid', $product->sscid);
                $category = Categories::find();
                $this->view->setVar('categories',$category);
                $subcategory = Subcat::findBycategory_id($product->category_id);
                $this->view->setVar('subcategories',$subcategory);  
                $Sscat = Ssc::findBysubcatid($product->subcategory_id);
                $this->view->setVar('ssc',$Sscat); 

                $this->view->pstage = $product->stage;
                $this->view->pprice = $product->product_price;
                $this->view->ptitle = $product->product_title;
                $this->view->psize = $product->psize;
                $this->view->scaletype = $product->scaletype;
                $this->view->pdiscount = $product->discount;
                $this->view->pdesc = $product->specification;
                $this->view->keyword = $product->keywords;
                $this->view->pcoupon = $product->coupon;
                $this->view->pcode = $product->pcode;
                $this->view->stock = $product->stock;
                $this->view->warranty = $product->warranty;
                $this->view->couponless = $product->couponamount;
                $this->view->pick("index/entry");
            }
            else{$this->flashSession->error("ERROR :: You are not authorized to edit this post!"); return $this->response->redirect($this->request->getHTTPReferer());} 
        }else{
            $this->flashSession->error("ERROR :: No Data Found!"); return $this->response->redirect();
        }     
    }
    public function updateAction()
    {
        $this->view->disable();
        $id = $this->request->getPost("id");
        $pTitle = $this->request->getPost('product_title');
        $pSpecify = $this->request->getPost('specification');
        $pRate = $this->request->getPost('product_price');
        $pKeys = $this->request->getPost('keywords');
        $pWeight = $this->request->getPost('pweight'); 
        $pSize = $this->request->getPost('psize');
        $pDiscount = $this->request->getPost('product_discount');
        $cDiscount = $this->request->getPost('coupondiscount');
        $pCoupon = $this->request->getPost('pcoupon');
        $pCode = $this->request->getPost('pcode');
        $stock = $this->request->getPost('stock');
        $pWarranty = $this->request->getPost('warranty');   
        $product = Products::findFirstByid($id);
        $category = Categories::findFirstByid($this->request->getPost('category'));
        $subcategory = Subcat::findFirstByid($this->request->getPost('subcategory'));
        $subsubcategory = Ssc::findFirstByid($this->request->getPost('ssc'));
        $defaultKeys = !empty($category->categoryname) ? array(strtolower(htmlspecialchars($category->categoryname)), strtolower(htmlspecialchars($subcategory->subcategory_name)), strtolower(htmlspecialchars($subsubcategory->ssctitle))) : 'data,product'; //#@Require Edit
        $keyData = explode (",", htmlspecialchars($this->request->getPost('keywords')));
        $marge = !empty($keyData) ? array_unique(array_merge((array)$keyData, (array)$defaultKeys), SORT_REGULAR) : '';
        $product->stage = $this->request->getPost('stage');
        $product->category_id = $this->request->getPost('category');
        $product->subcategory_id = $this->request->getPost('subcategory');
        $product->sscid = $this->request->getPost('ssc');
        $product->scaletype = $this->request->getPost('scaletype');
        $product->product_title = !empty($pTitle) ? htmlspecialchars($pTitle):$product->product_title;
        $product->specification = !empty($pSpecify) ? htmlspecialchars($pSpecify):$product->product_specification;
        $product->product_price = !empty($pRate) ? htmlspecialchars($pRate):$product->product_price;
        $product->keywords = !empty($pKeys) and $product->keywords !== $pKeys ? implode(',', (array)$marge):$product->keywords;
        $product->psize = !empty($pSize) ? implode(',', $pSize):$product->psize;
        $product->pweight = !empty($pWeight) ? implode(',', $pWeight):$product->pweight;
        $product->discount = !empty($pDiscount) ? htmlspecialchars($pDiscount):$product->discount;
        $product->coupon = !empty($pCoupon) ? htmlspecialchars($pCoupon):'0';
        $product->couponamount = !empty($cDiscount) ? htmlspecialchars($cDiscount):'0';
        $product->pcode = !empty($pCode) ? htmlspecialchars($pCode):'0';
        $product->stock = !empty($stock) ? htmlspecialchars($stock):'0';
        $product->warranty = !empty($pWarranty) ? htmlspecialchars($pWarranty):'0';
        $product->shopid = $this->session->get('id');
# Upload And Resize Image
        $query = Products::findFirst(['conditions' => 'shopid = ?1 AND id = ?2', 'bind' => [ 1 => $this->session->get('id'), 2 => $id,]]);
        if($this->request->hasFiles() and $query->count() > 0)
        {
            $isUploaded = false;
            $defaultImg = 'empty.png';
            $uploadPath = 'uploads/shop/';
            $h = $w = 500;

# If Have Old File Remove them
            //if(){
                if(!empty($query->pimg_front) && $query->pimg_front !== $defaultImg){@unlink('uploads/shop/'.$query->pimg_front);}
                if(!empty($query->pimg_back) && $query->pimg_back !== $defaultImg){@unlink('uploads/shop/'.$query->pimg_back);}
                if(!empty($query->pimg_top) && $query->pimg_top !== $defaultImg){@unlink('uploads/shop/'.$query->pimg_top);}
                if(!empty($query->pimg_bottom) && $query->pimg_bottom !== $defaultImg){@unlink('uploads/shop/'.$query->pimg_bottom);}
                if(!empty($query->pimg_left) && $query->pimg_left !== $defaultImg){@unlink('uploads/shop/'.$query->pimg_left);}
                if(!empty($query->pimg_right) && $query->pimg_right !== $defaultImg){@unlink('uploads/shop/'.$query->pimg_right);}           
            //}
# Upload New Files
            $myvars = array();
            foreach($this->request->getUploadedFiles() as $file)
            {
                if($file->getError() === 0){
                    if($this->imageCheck($file->getRealType()))
                    {
                        $imgName = strtolower(date('dmyHis-').preg_replace('/[^A-Za-z0-9.]/', '-', $file->getName()));
                        //strtolower(date('dmyHis-').$file->getName());
                        $isUploaded = $file->moveTo($uploadPath.$imgName) ? true : false;
                        //var_dump($file->getType().' # '.$file->getName());die();
                        $image = class_exists("Imagick") ? new Imagick($uploadPath.$imgName) : new GdAdapter($uploadPath.$imgName);
                        if($image->getWidth() < $w && $image->getHeight() < $h)
                        {
                            @unlink($uploadPath.$imgName);
                            $this->flashSession->error("ERROR:: Choose Large Image!");
                            return $this->response->redirect($this->request->getHTTPReferer());
                        }else{#Resize & Crop Image
                            if($image->getWidth() >= 501 && $image->getHeight() >= 501)
                            { 
                                $image->resize($w,$h, Enum::TENSILE);
                                $image->crop($w,$h,0,0);
                                $image->text('FireFly', TRUE, TRUE, 100, '#ddd', 30); 
                                //$image->render(null, 60); 
                                $image->sharpen(40);
                                $image->save($uploadPath.$imgName, 60);
                                @unlink($uploadPath.$file->getName());
                            }
                        } 
                    }
                    else
                    {
                        $this->flashSession->warning("WARNING:: File extension not allowed"); return $this->response->redirect($this->request->getHTTPReferer());
                    }   
                    #Get Image Array() into a variable
                    $myvars[] = $imgName;
                }else{
                    @unlink($uploadPath.$file->getName());  
                    $this->flashSession->warning("WARNING:: File may corrupted / missing / Invalid Format!");
                    return $this->response->redirect($this->request->getHTTPReferer());
                }
            }
            $product->pimg_front = empty($myvars[0]) ? $defaultImg : $myvars[0];
            $product->pimg_back = empty($myvars[1]) ? $defaultImg : $myvars[1];
            $product->pimg_top = empty($myvars[2]) ? $defaultImg : $myvars[2];
            $product->pimg_left = empty($myvars[3]) ? $defaultImg : $myvars[3];
            $product->pimg_right = empty($myvars[4]) ? $defaultImg : $myvars[4];
            $product->pimg_bottom = empty($myvars[5]) ? $defaultImg : $myvars[5];
            #$isUploaded ? die('Files successfully uploaded') : die('Some error occurred');
        }else{
            $product->pimg_front = $query->pimg_front;
            $product->pimg_back = $query->pimg_back;
            $product->pimg_top = $query->pimg_top;
            $product->pimg_left = $query->pimg_left;
            $product->pimg_right = $query->pimg_right;
            $product->pimg_bottom = $query->pimg_bottom;            
        }
# Update Data
        if(false === $product->update())
        {
            $this->flashSession->error("ERROR:: Data Update Failed!");
            return $this->response->redirect($this->router->getControllerName());
        }
        else{$this->flashSession->success("SUCCESS:: Data Update Success!");return $this->response->redirect($this->router->getControllerName());}
    }
    public function productDelAction($item = null)
    {
        $this->view->disable();
        $uid = $this->session->get('id');
        $defaultImg = 'empty.png';
        $query = Products::findFirst(['conditions' => 'shopid = ?1 AND id = ?2', 'bind' => [ 1 => $uid, 2 => $item,]]);
        if($query->count() > 0){
            if(!empty($query->pimg_front) && $query->pimg_front !== $defaultImg){@unlink('uploads/shop/'.$query->pimg_front);}
            if(!empty($query->pimg_back) && $query->pimg_back !== $defaultImg){@unlink('uploads/shop/'.$query->pimg_back);}
            if(!empty($query->pimg_top) && $query->pimg_top !== $defaultImg){@unlink('uploads/shop/'.$query->pimg_top);}
            if(!empty($query->pimg_bottom) && $query->pimg_bottom !== $defaultImg){@unlink('uploads/shop/'.$query->pimg_bottom);}
            if(!empty($query->pimg_left) && $query->pimg_left !== $defaultImg){@unlink('uploads/shop/'.$query->pimg_left);}
            if(!empty($query->pimg_right) && $query->pimg_right !== $defaultImg){@unlink('uploads/shop/'.$query->pimg_right);}
            if($query->delete() === true){
                $this->flashSession->success("SUCCESS:: Data Removed!");return $this->response->redirect($this->request->getHTTPReferer());
            }else{
                $this->flashSession->warning("WARNING:: Unable to Perform Requested Action!");return $this->response->redirect($this->request->getHTTPReferer());
            }            
        }else{
            $this->flashSession->warning("WARNING:: Invalid Action!");return $this->response->redirect($this->router->getControllerName());
        }
    }    
    public function entryAction()
    {
        if(!empty($this->session->get('uname')) && $this->session->get('type') === 's'){
            $this->view->aspect = '0';
            $formAction = 'back/index/insert';
            $this->view->setVar('action',$formAction);
            $category = Categories::find();
            $this->view->setVar('categories',$category);
            $this->view->ptitle = $this->view->pprice = $this->view->pdiscount = $this->view->pcoupon = $this->view->couponless = $this->view->scaletype = $this->view->psize = $this->view->keyword = $this->view->pimage = $this->view->pdesc = $this->view->pcid = $this->view->pcode = $this->view->warranty = '';
            $this->view->pstage = '1';
            $this->view->stock = 1;
            $this->view->pick('index/entry');
        }else{ $this->flashSession->warning("WARNING:: Please Login First!"); return $this->response->redirect(); }
    }      
    public function insertAction()
    {
        //$this->view->disable();
        $insert = new Products();
# Upload And Resize Image
        if($this->request->hasFiles())
        {
            $isUploaded = false;
            $defaultImg = 'empty.png';
            $uploadPath = 'uploads/shop/';
            $h = $w = 500;
            foreach($this->request->getUploadedFiles() as $file)
            {
                if($file->getError() === 0){
                    if($this->imageCheck($file->getRealType()))
                    {
                        $imgName = strtolower(date('dmyHis-').preg_replace('/[^A-Za-z0-9.]/', '-', $file->getName())); //strtolower(date('dmyHis-').$file->getName());
                        $isUploaded = $file->moveTo($uploadPath.$imgName) ? true : false;
                        //var_dump($file->getType().' # '.$file->getName());die();
                        $image = class_exists("Imagick") ? new Imagick($uploadPath.$imgName) : new GdAdapter($uploadPath.$imgName);
                        if($image->getWidth() < $w && $image->getHeight() < $h)
                        {
                            @unlink($uploadPath.$imgName);
                            $this->flashSession->error("ERROR:: Choose Large Image!");
                            return $this->response->redirect($this->request->getHTTPReferer());
                        }else{#Resize & Crop Image
                            if($image->getWidth() >= 501 && $image->getHeight() >= 501)
                            {                        
                                // $oX = (($image->getWidth() - $w) / 2);
                                // $oY = (($image->getHeight() - $h) / 2);
                                $image->resize($w,$h, Enum::TENSILE);                          
                                $image->crop($w,$h,0,0);
                                $image->text('FireFly', TRUE, TRUE, 100, '#ddd', 30); 
                                //$image->render(null, 60); 
                                $image->sharpen(40);
                                $image->save($uploadPath.$imgName, 60);
                                @unlink($uploadPath.$file->getName());             
                            }
                        }                   
                    }
                    else
                    {
                        $this->flashSession->warning("WARNING:: File extension not allowed"); return $this->response->redirect($this->request->getHTTPReferer());
                    }   
                    #Get Image Array() into a variable
                    $myvars[] = $imgName;
                }else{
                    @unlink($uploadPath.$file->getName());  
                    $this->flashSession->warning("WARNING:: File may corrupted / missing / Invalid Format!");
                    return $this->response->redirect($this->request->getHTTPReferer());
                }
            }
            $insert->pimg_front = empty($myvars[0]) ? $defaultImg : $myvars[0];
            $insert->pimg_back = empty($myvars[1]) ? $defaultImg : $myvars[1];
            $insert->pimg_top = empty($myvars[2]) ? $defaultImg : $myvars[2];
            $insert->pimg_left = empty($myvars[3]) ? $defaultImg : $myvars[3];
            $insert->pimg_right = empty($myvars[4]) ? $defaultImg : $myvars[4];
            $insert->pimg_bottom = empty($myvars[5]) ? $defaultImg : $myvars[5];
            #$isUploaded ? die('Files successfully uploaded') : die('Some error occurred');
        }
        else{
            $this->flashSession->error("ERROR:: Minimum 2 Image Required"); return $this->response->redirect($this->request->getHTTPReferer());
        }
# Custom Error Mesage On Validation
$validator = new Validation();
#$validator->add('specification', new PresenceOf(['message' => 'The specification is required' ]));
$validator->add('product_title', new PresenceOf(['message' => 'The product title is required' ]));
$validator->add('product_price', new PresenceOf(['message' => 'The product price is required' ]));
$validator->add('keywords', new PresenceOf(['message' => 'The keywords is required' ]));
$validator->add('category', new PresenceOf(['message' => 'The Category is required' ]));
$validator->add('subcategory', new PresenceOf(['message' => 'The Sub Category is required' ]));
$validator->add('ssc', new PresenceOf(['message' => 'The Sub Sub Category is required' ]));
$category =  Categories::findFirstByid($this->request->getPost('category'));
$subcategory =  Subcat::findFirstByid($this->request->getPost('subcategory'));
$subsubcategory =  Ssc::findFirstByid($this->request->getPost('ssc'));
$defaultKeys = !empty($category->categoryname) ? array(strtolower($category->categoryname), strtolower($subcategory->subcategory_name), strtolower($subsubcategory->ssctitle)) : 'data,product';  
$keyData = explode (",", $this->request->getPost('keywords'));
$marge = !empty($keyData) ? array_unique(array_merge((array)$keyData, (array)$defaultKeys), SORT_REGULAR) : '';
$insert->category_id = htmlspecialchars($this->request->getPost('category'));
$insert->subcategory_id = $this->request->getPost('subcategory');
$insert->sscid = $this->request->getPost('ssc');
$insert->scaletype = htmlspecialchars($this->request->getPost('scaletype'));
$insert->product_title = htmlspecialchars($this->request->getPost('product_title'));
$insert->specification = htmlspecialchars($this->request->getPost('specification'));
$insert->warranty = htmlspecialchars($this->request->getPost('warranty'));
$insert->product_price = htmlspecialchars($this->request->getPost('product_price'));
$insert->keywords = !empty($this->request->getPost('keywords')) ? implode(',', (array)$marge) : implode(',', (array)$defaultKeys);
$insert->psize = !empty($this->request->getPost('psize')) ? implode(',', $this->request->getPost('psize')) : '0';
$insert->pweight = !empty($this->request->getPost('pweight')) ? implode(',', $this->request->getPost('pweight')) : '0'; 
$insert->discount = !empty($this->request->getPost('product_discount')) ? htmlspecialchars($this->request->getPost('product_discount')) : '0';
$insert->coupon = !empty($this->request->getPost('pcoupon')) ? htmlspecialchars($this->request->getPost('pcoupon')) : 0;
$insert->couponamount = !empty($this->request->getPost('coupondiscount')) ? htmlspecialchars($this->request->getPost('coupondiscount')) : 0;
$insert->pcode = !empty($this->request->getPost('pcode')) ? htmlspecialchars($this->request->getPost('pcode')) : '0';
$insert->warranty = !empty($this->request->getPost('warranty')) ? htmlspecialchars($this->request->getPost('warranty')) : '0';
$insert->stage = $this->request->getPost('stage');
$insert->shopid = $this->session->get('id');
$insert->hits = 0;
        if($insert->save() === true){//save() for uniqueness validation and create() for pair-wise validations
            $this->flashSession->success("SUCCESS:: Data Saved!");
            return $this->response->redirect($this->request->getHTTPReferer());
        }else{ 
            $message = $validator->validate($_POST);
            if(count($message))
            {
                # Delete Uploaded Files if Entry failed!
                !empty($myvars[0]) && $myvars[0] !== $defaultImg ? @unlink($uploadPath.$myvars[0]) : ''; 
                !empty($myvars[1]) && $myvars[1] !== $defaultImg ? @unlink($uploadPath.$myvars[1]) : ''; 
                !empty($myvars[2]) && $myvars[2] !== $defaultImg ? @unlink($uploadPath.$myvars[2]) : ''; 
                !empty($myvars[3]) && $myvars[3] !== $defaultImg ? @unlink($uploadPath.$myvars[3]) : ''; 
                !empty($myvars[4]) && $myvars[4] !== $defaultImg ? @unlink($uploadPath.$myvars[4]) : ''; 
                !empty($myvars[5]) && $myvars[5] !== $defaultImg ? @unlink($uploadPath.$myvars[5]) : '';
                foreach($message as $msg){$msg;}
                $this->flashSession->error("ERROR:: ".$msg);
                return $this->response->redirect($this->request->getHTTPReferer());
            }else{
                # Delete Uploaded Files if Entry failed!
                !empty($myvars[0]) && $myvars[0] !== $defaultImg ? @unlink($uploadPath.$myvars[0]) : ''; 
                !empty($myvars[1]) && $myvars[1] !== $defaultImg ? @unlink($uploadPath.$myvars[1]) : ''; 
                !empty($myvars[2]) && $myvars[2] !== $defaultImg ? @unlink($uploadPath.$myvars[2]) : ''; 
                !empty($myvars[3]) && $myvars[3] !== $defaultImg ? @unlink($uploadPath.$myvars[3]) : ''; 
                !empty($myvars[4]) && $myvars[4] !== $defaultImg ? @unlink($uploadPath.$myvars[4]) : ''; 
                !empty($myvars[5]) && $myvars[5] !== $defaultImg ? @unlink($uploadPath.$myvars[5]) : '';
                foreach($insert->getMessages() as $msg){$msg;}
                $this->flashSession->error("ERROR:: ".$msg);
                return $this->response->redirect($this->request->getHTTPReferer()); 
            }
        }
    }
    public function getSubcategoryAction()
    { 
        $this->view->disable();
        $id = $this->request->getPost('id');
        $data = Subcat::findBycategory_id($id);
        $resData = array();    
        foreach($data as $result)
        {
            $resData[] = array('id' => $result->id, 'category_id' => $result->category_id, 'subcategory' => $result->subcategory_name);
        }echo(json_encode($resData));
    }
    public function getsscAction()
    { 
        $this->view->disable();
        $id = $this->request->getPost('id');
        $data = Ssc::findBysubcatid($id);  
        $resData = array();    
        foreach($data as $result)
        {
            $resData[] = array('id' => $result->id, 'subcatid' => $result->subcatid, 'ssctitle' => $result->ssctitle);
        }echo(json_encode($resData));
    }
# Category|Sub-Category|Sub-Sub Category List
    public function inscategoryAction()
    {
        if($this->session->has('uname') && $this->session->get('type') === 's' && $this->session->get('active') === '1'){         
    #Get Category List        
            $category = Categories::find();
            $this->view->setVar('categories',$category);
    #Get Sub Category List
            $subcategory = Subcat::find();
            $this->view->setVar('subcategories',$subcategory); 
            $this->view->pick('index/categorylist');
        }else{return $this->response->redirect('back/index');}
    }
    public function categorysaveAction()
    {
        $this->view->disable();
        if(!empty($this->request->getPost('catname')))
        {
            $query = Categories::findBycategoryname($this->request->getPost('catname'));
            $numCat = Categories::count();
            //foreach($query as $q){ $dbData = $q->categoryname; }$dbData === $this->request->getPost('catname')
            if($query->count() > 0){
$this->flashSession->warning("WARNING:: Category Exists!");return $this->response->redirect($this->request->getHTTPReferer());
            }elseif($numCat >= 15){
$this->flashSession->warning("WARNING:: More than 15 Category Not Allowed!");return $this->response->redirect($this->request->getHTTPReferer());
            }
            else{
                $data = new Categories();
                $data->categoryname = trim(htmlspecialchars($this->request->getPost('catname')));
                if($data->save() === true){
$this->flashSession->success("SUCCESS:: New Category Created!");return $this->response->redirect($this->request->getHTTPReferer());
                }
                else{
                    foreach($data->getMessages() as $msg){$msg;}
                    $this->flashSession->error("ERROR:: ".$msg); return $this->response->redirect($this->request->getHTTPReferer());
                }   
            }
        }
        else{$this->flashSession->warning("WARNING:: Required Fields Going Empty!");return $this->response->redirect($this->request->getHTTPReferer()); 
        }
    }
    public function subcategorysaveAction()
    {
        if(!empty($this->request->getPost('subcatname')))
        {
            $data = new Subcat();
            $data->category_id = trim(htmlspecialchars($this->request->getPost('category')));
            $data->subcategory_name = trim(htmlspecialchars($this->request->getPost('subcatname')));
            if($data->save() === true){$this->flashSession->success("SUCCESS:: Insertion Success!");
                return $this->response->redirect($this->request->getHTTPReferer()); }
            else{ foreach($data->getMessages() as $msg){$msg;}
                $this->flashSession->error("ERROR:: ".$msg);
                return $this->response->redirect($this->request->getHTTPReferer()); }
        }
        else{ $this->flashSession->warning("WARNING:: Required Fields Going Empty..!");return $this->response->redirect($this->request->getHTTPReferer()); }
    }
    public function subsubcategorysaveAction()
    {
        if(!empty($this->request->getPost('sscname')))
        {
            $data = new Ssc();
            $data->subcatid = trim(htmlspecialchars($this->request->getPost('subcategory')));
            $data->ssctitle = trim(htmlspecialchars($this->request->getPost('sscname')));
            if($data->save() === true){ $this->flashSession->success("SUCCESS:: Insertion Success!");
                return $this->response->redirect($this->request->getHTTPReferer()); }
            else{ foreach($data->getMessages() as $msg){$msg;}
                $this->flashSession->error("ERROR:: ".$msg);
                return $this->response->redirect($this->request->getHTTPReferer()); }
        }else{$this->flashSession->warning("WARNING:: Required Fields Going Empty..!");return $this->response->redirect($this->request->getHTTPReferer());}        
    } 
    public function mypostsAction(){
        // if(!empty($this->session->get('uname')) && $this->session->get('type') === 's'){
        //     $numPage = $this->request->getQuery('page', 'int', 1);
        //     $paginator = new paginator(
        //         [
        //             "model" => Products::class,
        //             "parameters" => [
        //                 "shopid = :shopid:",
        //                 "bind" => ["shopid" => $this->session->get('id'),],
        //                 "order" => "product_title",
        //             ],
        //             "limit" => 10,
        //             "page" => $numPage,
        //         ]
        //     );
        //     $paginate = $paginator->paginate();
        //     if($paginate){
        //         $this->view->setVar('page', $paginate);
        //         $this->view->pick('index/myposts'); 
        //     }else{$this->flashSession->error("ERROR:: No Data Found!");return $this->response->redirect($this->request->getHTTPReferer());}
        // }else{return $this->response->redirect($this->request->getHTTPReferer());}

        if (!empty($uname = $this->session->get('uname')) && ($type = $this->session->get('type')) === 's') {
            $paginator = new Paginator([
                "model" => Products::class,
                "parameters" => ["shopid = :shopid:", "bind" => ["shopid" => $this->session->get('id')], "order" => "product_title"],
                "limit" => 10,
                "page" => $this->request->getQuery('page', 'int', 1)
            ]);

            if ($paginate = $paginator->paginate()) {
                $items = [];
                foreach ($paginate->items as $item) {
                    $items[] = $item->toArray(); // Convert each item to an array
                }
                $chunkedData = array_chunk($items, 5);
                $this->view->setVars(['chunkedData' => $chunkedData, 'page' => $paginate])->pick('index/myposts');
            } else {
                $this->flashSession->error("ERROR:: No Data Found!");return $this->response->redirect($this->request->getHTTPReferer());
            }
        } else {
            return $this->response->redirect($this->request->getHTTPReferer());
        }
    } 
    public function myordersAction(){
        if(!empty($this->session->get('uname')) && $this->session->get('type') === 's'){
            $query = Cart::find(['conditions' => 'shopid = ?1 AND orderflag = ?2','bind' => [1 => $this->session->get('id'), 2 => 1]]);
            if($query->count() > 0){
                $this->view->myorder = $query;
                $this->view->pick('index/myorders');
            }else{
                $this->flashSession->warning("WARNING:: No Data Found!");return $this->response->redirect($this->request->getHTTPReferer());
            }
        }else{return $this->response->redirect($this->request->getHTTPReferer());}
    } 
    public function orderUpdateAction(){
        $this->view->disable();
        $oid = $this->request->getPost('orderid');
        $ostatus = $this->request->getPost('status');
        $query = Cart::findFirst(['conditions' => 'orderid = ?1 AND orderflag = ?2','bind' => [1 => $oid, 2 => '1'],'for_update' => true,]);
        $query->orderstatus = $ostatus;
        if(false === $query->update()){
            foreach($query->getMessages() as $msg){}
            $this->flashSession->warning("WARNING:: ".$msg);return $this->response->redirect($this->request->getHTTPReferer());
        }else{
            $this->flashSession->success("SUCCESS:: Status Updated!");return $this->response->redirect($this->request->getHTTPReferer());
        }
    } 
    public function profileAction()
    {
        if(!empty($this->session->get('uname')) && $this->session->get('type') === 's'){
            $uid = $this->session->get('id');
            $type = $this->session->get('type');
            $this->view->uid = $uid;
            $this->view->uname = $this->session->get('uname');
            $this->view->type = $type;
            $this->view->users = Sellers::find(['conditions' => '(id = ?1 AND type = ?2 AND active = ?3)','bind' => [1 => $uid, 2 => $type, 3 => '1']]);
            $this->view->pick('index/profile');
        }else{return $this->response->redirect('back/index');}
    }      
    public function loginAction()
    {
        $this->view->disable();
        $csrf = $this->security->getRequestToken();
        $postMail = htmlspecialchars(trim($this->request->getPost('mail')));
        $password = htmlspecialchars(trim($this->request->getPost('passwd')));
        if(!empty($postMail) && !empty($password) && $this->request->isPost())
        {
            if($this->security->checkToken($csrf, $this->security->getSessionToken())){
                $user = Sellers::findFirst(['conditions' => '(email = ?1 AND type = ?2 AND active = ?3 AND level = ?4)','bind' => [1 => $postMail, 2 => 's', 3 => '1', 4 => '2']]);
                if($user && $this->security->checkHash($password, $user->passwd)){
                    $this->session->set('id', $user->id);
                    $this->session->set("uname", $user->name);
                    $this->session->set("active", $user->active);
                    $this->session->set("level", $user->level);
                    $this->session->set("type", $user->type); 
                    $this->flashSession->success("SUCCESS:: Welcome to Admin Area!");return $this->response->redirect('back/index/entry');
                }else{$this->flashSession->warning("WARNING:: Invalid Username / Password!");return $this->response->redirect();}
            }else{$this->flashSession->warning("WARNING:: Token Mismatched!");return $this->response->redirect('back/index');}
        }else{$this->flashSession->warning("WARNING:: Empty / Insecure Try!");return $this->response->redirect('back/index');}    
    }
    public function logoutAction()
    {
        if(!empty($this->session->get('uname'))){
            $this->session->remove("uname");
            $this->session->destroy();
            unset($_COOKIE['PHPSESSID']);
            setcookie('PHPSESSID', '', time() - 100);            
            $this->flashSession->success("SUCCESS:: Logged out!"); return $this->response->redirect('index');
        }else{ $this->flashSession->warning("ERROR:: Invalid Try!"); return $this->response->redirect('index'); }         
        // if(!empty($this->session->get('uname')) AND $this->session->get('level') !== '0' ){
        //     $id = $this->session->get('id');
        //     $user = Users::findFirstByid($id);            
        //     $this->session->remove("id");
        //     $this->session->remove("uname");
        //     $this->session->remove("level");
        //     $this->session->remove("active");
        //     //$this->session->destroy(); //Success msg will not show
        //     $user->online = '0';
        //     $user->reason = self::MANUAL;
        //     $user->expired = new \Phalcon\Db\RawValue('now()');
        //     if(!$user->update() || $user->update() === false)
        //     { 
        //         $this->flashSession->error("ERROR :: Logout Error - Something Went Wrong!");
        //         return $this->response->redirect($this->router->getControllerName()); 
        //     }
        //     $this->flashSession->success("SUCCESS :: Logged out!");
        //     return $this->response->redirect();
        // }
        // else{ $this->flashSession->error("ERROR :: Invalid Try!"); return $this->response->redirect(); }        
    }
    public function doPrintAction($id = null)
    {
        $this->view->pdf = Cart::findFirstByid($id); $this->view->pick('index/invoice');
    } 
    public function CashcleanAction()
    {
        $this->view->disable();
        $fileList    = [];
        $whitelist   = ['.', '..', '.gitignore'];
        $path        = BASE_PATH . '/cache';
        $dirIterator = new RecursiveDirectoryIterator($path);
        $iterator    = new RecursiveIteratorIterator(
            $dirIterator,
            RecursiveIteratorIterator::CHILD_FIRST
        );
        foreach ($iterator as $file) {
            if (true !== $file->isDir() && true !== in_array($file->getFilename(), $whitelist)) { $fileList[] = $file->getPathname(); }
        }
        //echo sprintf('Found %s files', count($fileList)) . PHP_EOL;
        foreach ($fileList as $file){ echo '.'; @unlink($file); }
        //echo PHP_EOL . 'Folder cleared' . PHP_EOL;
        $this->flashSession->success("SUCCESS:: ".sprintf('Found %s files,', count($fileList))." Cash cleared");return $this->response->redirect($this->request->getHTTPReferer());
    }      
#END    
}
