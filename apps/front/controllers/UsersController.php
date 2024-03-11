<?php declare(strict_types=1);
namespace F\Front\Controllers;
use F\Front\Models\Users as Users;
use F\Front\Models\Sellers as Sellers;
use F\Front\Models\Category as Categories;
use F\Front\Models\Cart as Cart;
use Phalcon\Image\Adapter\GD as GdAdapter;
#use Phalcon\Image\Adapter\Imagick;
use Phalcon\Image\Enum;
use Phalcon\Encryption\Security\Random;
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;
use Phalcon\Http\Request;
use Phalcon\Storage\SerializerFactory;
use Phalcon\Storage\Adapter\Redis;

class UsersController extends BaseController
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
        $this->view->dynarobot = "noindex,nofollow,noarchive,nosnippet,noodp,noydir,noimagechache";
        $this->view->dynagooglebot = "noindex,nofollow";       
    }
    private function imageCheck($extension = null){$allowedTypes = ['image/gif','image/jpg','image/bmp','image/png','image/jpeg'];return in_array($extension, $allowedTypes);}    
    public function indexAction()
    {
        if(!empty($this->session->get('uname')))
        {
            $uid = $this->session->get('id');
            $name = $this->session->get('uname');
            $active = $this->session->get('active');
            $level = $this->session->get('level');
            $type = $this->session->get('type');
            $this->view->uid = $uid;
            $this->view->uname = $name;
            $this->view->active = $active;
            $this->view->level = $level;
            $this->view->type = $type;
            $cartCount = Cart::count(['conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3)','bind' => [1 => $uid, 2 => $type, 3 => '0']]);
            $this->view->mycart = $cartCount > 0 ?  $cartCount : '0';
            $this->view->users = Users::find(['conditions' => '(id = ?1 AND type = ?2 AND active = ?3)','bind' => [1 => $uid, 2 => $type, 3 => '1']]);
            $this->view->cats = Categories::find();
            $this->view->pick('index/user');
        }else{return $this->response->redirect();}
    }
    public function signupAction($type = null)
    {
        if (func_num_args()) {
            $this->view->cats = Categories::find();
            $this->view->action = 'users/register';
            $this->view->aspect = '0';
            $this->view->servicelogo = $this->view->legaldoc = '';
            $this->view->type = base64_decode(urldecode($type));
            if(!empty($this->session->get('uname'))) {return $this->response->redirect('index');}
            $this->view->pick('index/signup');
        }else{return $this->response->redirect();}
    }
    public function registerAction()
    {
        $this->view->disable();
        $csrf = $this->security->getRequestToken();
        $type = $this->request->getPost('type');
        $passwd = htmlspecialchars(trim($this->request->getPost('passwd')));
        $random = new Random();
        $query = ($type === 's') ? Sellers::countByemail(htmlspecialchars($this->request->getPost('umail'))) : Users::countBymail(htmlspecialchars($this->request->getPost('email')));
        if($query > 0){
            $this->flashSession->error("ERROR:: User Already Exists!"); return $this->response->redirect($this->request->getHTTPReferer());
        }else{ 
            if(!empty($passwd) && $this->security->checkToken($csrf, $this->security->getSessionToken())){
                switch($type){
                    case 's':
                        $register = new Sellers();
# UploadBegin
                    if($this->request->hasFiles()){
                        $uploadPath = 'uploads/users/';
                        $defaultImg = 'empty.png';
                        $isUploaded = false;
                        foreach($this->request->getUploadedFiles() as $file){
                            if($file->getError() === 0){
                                if($this->imageCheck($file->getRealType()))
                                {
                                    //echo $file->getName(), " ", $file->getSize(), "\n";
                                    $imgName = strtolower(date('dmyHis-').preg_replace('/[^A-Za-z0-9.]/', '-', $file->getName()));
                                    $file->moveTo($uploadPath.$imgName) ? $isUploaded = true : $isUploaded = false;
                                    #Resize & Crop Image
                                    $image = new GdAdapter($uploadPath.$imgName);
                                    if($image->getWidth() < 200 && $image->getHeight() < 200)
                                    {
                                        @unlink($uploadPath.$imgName);
                                        $this->flashSession->error("ERROR:: Choose Large Image!");return $this->response->redirect($this->request->getHTTPReferer());
                                    }else{
                                        if($image->getWidth() >= 200 && $image->getHeight() >= 200){ $image->resize(200,200, Enum::TENSILE); $image->crop(200,200,0,0); $image->sharpen(50);}
                                        $image->save($uploadPath.$imgName, 60);
                                        @unlink($uploadPath.$file->getName());
                                    }
                                }
                                else
                                {
                                    @unlink($file->getName()); @unlink($uploadPath.$file->getName());
                                    $this->flashSession->error("ERROR:: File extension not allowed");return $this->response->redirect($this->router->getControllerName());
                                }
                            $myvars[] = $imgName;                                    
                            }else{@unlink($uploadPath.$file->getName()); echo('File may corrupted / missing!');}
                        }
                        $register->servicelogo = !empty($myvars[0]) ? $myvars[0] : $defaultImg;
                        $register->legaldoc = !empty($myvars[1]) ? $myvars[1] : $defaultImg; 
                    }
# UploadEnd     
                        $register->name = htmlspecialchars($this->request->getPost('uname'));
                        $register->shopname = htmlspecialchars($this->request->getPost('shopname'));
                        $register->address = htmlspecialchars($this->request->getPost('address'));
                        $register->contact = htmlspecialchars($this->request->getPost('contact'));
                        $umail = $register->email = htmlspecialchars($this->request->getPost('umail'));                   
                        $register->type = 's';
                        $register->level = '2';                         
                    break;
                    case 'b':
                        $register = new Users();
                        $register->name = htmlspecialchars($this->request->getPost('name'));
                        $umail = $register->mail = htmlspecialchars($this->request->getPost('email'));
                        $register->type = 'b';
                        $register->level = '1';                        
                    break;
                }
    #PostMail_Save 
                $register->passwd = $this->security->hash($passwd);
                $register->salt = $random->base64(12);
                $register->active = '0';
                $mailfor = 'reg';
                //$this->enqueueEmailTask($type, $umail, $register->name, $register->salt, $mailfor);
                if($this->autoMail($type, $umail, $register->name, $register->salt, $mailfor) === 'Y'){
                //if($this->enqueueEmailTask($type, $umail, $register->name, $register->salt, $mailfor) === 'Y'){
                    if($register->save() === true){
                        $this->flashSession->success("SUCCESS:: Please! Check Your Email(Inbox/ Spam/ All Mail)."); return $this->response->redirect('index');
                    }else{
                        @unlink($uploadPath.$myvars[0]); @unlink($uploadPath.$myvars[1]);
                        foreach($register->getMessages() as $msg){ $this->flashSession->error("ERROR::".$msg); return $this->response->redirect($this->request->getHTTPReferer()); }
                    }
                }else{
                    @unlink($uploadPath.$myvars[0]); @unlink($uploadPath.$myvars[1]);
                    $this->flashSession->error("ERROR:: Registration Failed! Try again..."); return $this->response->redirect($this->request->getHTTPReferer()); 
                } 
            }else{$this->flashSession->warning("WARNING:: Required Data Missing!");return $this->response->redirect('index');}  
        }       
    }
    private function autoMail(...$param)
    {
        $this->view->disable();
        if(func_num_args() === 5){
            $type = func_get_arg(0);$umail = func_get_arg(1);$uname = func_get_arg(2);$salt = func_get_arg(3);$mailfor = func_get_arg(4);
        }
        $this->pmailer->addAddress($umail, $uname);
        $this->pmailer->addReplyTo($this->pmailer->ConfirmReadingTo, 'Webmaster');
        switch($mailfor){
            case 'reg':
                $this->pmailer->Subject = 'Registration Verification: Continuous Impression';
                $this->pmailer->Body = '<strong style="color:#026180;font-size:xx-large">Thanks for signing up!</strong><br/>Your account has been created, you can now login with the following credentials, after you have activated your account by pressing the url below.<br/>------------------------<br/>Login : '.trim(strip_tags($umail)).'<br/>Secrete : Not Shown<br/>------------------------<br/>Please click this link to activate your account <a href="//'.$_SERVER['HTTP_HOST'].$this->url->getBaseUri().'users/activemail/'.$type.'/'.base64_encode($salt).'"><strong> [ Confirm Activation ] </strong></a><br/>Best regards,<br/><a href="'.$this->url->getBaseUri().'">'.$this->view->siteName.'</a> [ webmaster ]';
                $this->pmailer->AltBody = 'This message sent via <a href="'.$this->url->getBaseUri().'">'.$this->view->siteName.'</a> for Registration Verification. If you are unable to read your login and password please! Register again. Thank`s <br/>[ webmaster ]<br/>';
            break;
            case 'res':
                $aspects = '1';
                $this->pmailer->Subject = 'Credentials Reset';
                $this->pmailer->Body = 'Reset your account by pressing the url below.<br/>
                     Please click this link to reset your account <a href="//'.$_SERVER['HTTP_HOST'].$this->url->getBaseUri().'users/forgetpass/'.$type.'/'.base64_encode($salt).'/'.$aspects.'"><strong> [ Reset Account ] </strong></a><br/>Best regards,<br/><a href="'.$this->url->getBaseUri().'">'.$this->view->siteName.'</a> [ webmaster ]';
                $this->pmailer->AltBody = 'This message sent via <a href="'.$this->url->getBaseUri().'">'.$this->view->siteName.'</a> for Recover Credentials. If you are unable to read your login and password please! contact. Thank`s <br/>[ webmaster ]<br/>';
            break;
        }
        try{ $this->pmailer->send(); return 'Y'; }
        catch (Exception $e){ $this->flashSession->error("ERROR:: ".$this->pmailer->ErrorInfo.' '.$e->getMessage()); return 'N'; }
    }
    public function activemailAction($type = null, $salt = null)
    {
        $this->view->disable();
        if(!empty($type) && !empty($salt)){
           $query = ($type === 's') ? Sellers::findFirstBysalt(base64_decode($salt)) : Users::findFirstBysalt(base64_decode($salt));
            if($query->active === '0' && $query->salt === base64_decode($salt)){
                $query->active = $query->salt = '1';
                if($query->update() === true){$this->flashSession->success("SUCCESS:: You are activated");
                }else{ $this->flashSession->error("ERROR:: Check your email to activate!!");}
            }
        }else{ $this->flashSession->error("ERROR:: Check your email to activate!!");}
        return $this->response->redirect($this->router->getControllerName('index'));
    } 
    public function forgetpassAction(...$params){ 
        # Load Form for sendEmail and reset Password Both 
        $this->view->dynaArticleTitle = 'Forget Password';
        $this->view->dynaArticle = 'Forget Password Form';
        $uid = $this->session->get('id');
        $cartCount = Cart::count(['conditions' => '(userid = ?1 AND type = ?2 AND orderflag = ?3)','bind' => [1 => $uid, 2 => $this->session->get('type'), 3 => '0']]);
        $this->view->mycart = $cartCount > 0 ?  $cartCount : '0';
        $this->view->cats = Categories::find();
        if(func_num_args() === 3){$type = func_get_arg(0); $salt = func_get_arg(1); $uri = func_get_arg(2);}
            $this->view->aspect = !empty($uri) ? $uri : '0';
            $this->view->type = !empty($type) ? $type : '0'; //not for EntryMode but Reset
            $this->view->salt = !empty($salt) ? base64_decode($salt) : '0'; //not for EntryMode but Reset
        $this->view->action = !empty($uri) ? 'users/recovercredentials' : 'users/recovermail';
        $this->view->pick('index/forget');
    }      
    public function recovermailAction()
    {
        #For Send OTP mail to confirm user
        $this->view->disable();
        $rmail = $this->request->getPost('umail');
        $csrf = $this->security->getRequestToken();
        $type = $this->request->getPost('type');
        $salt = date('YmdHis');
        if(!empty($rmail) && !empty($type) && $this->security->checkToken($csrf, $this->security->getSessionToken())){
            $query = ($type === 's') ? Sellers::findFirstByemail($rmail) : Users::findFirstBymail($rmail);
            if(!empty($query)){
                $query->salt = $salt;
                $query->visitmail = '0';
                $mailfor = 'res';
                if($query->update() === true){
                    # PostMail
                    $this->autoMail($type, $rmail, $query->uname, $salt, $mailfor) === 'Y';
                    $this->flashSession->success("SUCCESS:: Check your email for OTP!");return $this->response->redirect($this->router->getControllerName());
                }else{$this->flashSession->error("ERROR:: ".$query->getMessage());return $this->response->redirect($this->router->getControllerName());}
            }else{$this->flashSession->error("ERROR:: Access Denied!");}
        }else{$this->flashSession->warning("WARNING:: Information Missing");}
        return $this->response->redirect('index');
    }      
    public function recovercredentialsAction()
    {
        #Reset Old Password to New One
        $this->view->disable();
        $csrf = $this->security->getRequestToken();
        $type = $this->request->getPost('type');
        $salt = $this->request->getPost('salt');
        $passwdA = $this->request->getPost('passwdNa');
        $passwdB = $this->request->getPost('passwdNb');
        if(!empty($type) && $this->security->checkToken($csrf, $this->security->getSessionToken())){
           $query = match($type){
                's' => Sellers::findFirst(['conditions' => '(salt = ?1 AND type = ?2 AND active = ?3)','bind' => [1 => $salt, 2 => $type, 3 => '1']]),
                'b' => Users::findFirst(['conditions' => '(salt = ?1 AND type = ?2 AND active = ?3)','bind' => [1 => $salt, 2 => $type, 3 => '1']]),
            };
            if($query && $passwdA === $passwdB){
                $query->passwd = $this->security->hash(trim($passwdA));
                if(false === $query->update()){$this->flashSession->warning("WARNING:: Data Update Failed!");
                }else{$this->flashSession->success("SUCCESS:: Data Update Success!");}
            }else{$this->flashSession->warning("WARNING:: Unmatched Credentials!");}
        }else{$this->flashSession->warning("WARNING:: Token Mismatched!");}
        return $this->response->redirect($this->router->getControllerName());
    }
    public function startAction()
    {
        $this->view->disable();
        $csrf = $this->security->getRequestToken();
        $postMail = htmlspecialchars(trim($this->request->getPost('mail')));
        $password = htmlspecialchars(trim($this->request->getPost('lpasswd')));
        $loginType = htmlspecialchars($this->request->getPost('ltype'));
        $rememberme = $this->request->getPost('rememberme');
        if(!empty($csrf) && !empty($postMail) && !empty($password))
        {
            if($this->security->checkToken($csrf, $this->security->getSessionToken())){
                switch($loginType){
                    case 's':
                        $users = Sellers::findFirst(['conditions' => '(email = ?1 AND level = ?2 AND active = ?3)','bind' => [1 => $postMail, 2 => '2', 3 => '1']]);
                        if($users && $this->security->checkHash($password, $users->passwd)){
                            $this->session->set('id', $users->id);
                            $this->session->set("uname", $users->name);
                            $this->session->set("active", $users->active);
                            $this->session->set("level", $users->level);
                            $this->session->set("type", $users->type);
                            $this->flashSession->success("SUCCESS:: Welcome to Admin Area!");return $this->response->redirect('back/index/entry')->send();
                        }else{$this->flashSession->error("ERROR:: Invalid Username / Password!");return $this->response->redirect('index');}
                    break;
                    case 'b':
                        $users = Users::findFirst(['conditions' => '(mail = ?1 AND level = ?2 AND active = ?3)','bind' => [1 => $postMail, 2 => '1', 3 => '1']]);
                        if($users && $this->security->checkHash($password, $users->passwd)){
                            if(isset($rememberme)){
#$param = session_get_cookie_params();setcookie(session_name(), '', 0, $param['path'], $param['domain'], $param['secure'], $param['httponly']);
                                setcookie('umail', $postMail, strtotime('+30 days')); #time() + (86400*30)
                                setcookie('passwd', $password, strtotime('+30 days'));
                                setcookie('uname', $users->name, strtotime('+30 days'));
                                #setcookie('PHPSESSID', 'FireFly'.date('YmdHis'), time() - 3600);
                            }                          
                            $this->session->set('id', $users->id);
                            $this->session->set("uname", $users->name);
                            $this->session->set("active", $users->active);
                            $this->session->set("level", $users->level);
                            $this->session->set("type", $users->type); 
                            $this->flashSession->success("SUCCESS:: Welcome to ".$this->view->siteName." Family!");return $this->response->redirect('index');
                        }else{$this->flashSession->error("ERROR:: Invalid Username / Password!");return $this->response->redirect('index');}
                    break;
                    default:
                        $this->flashSession->error("ERROR:: Please! Confirm You are a Buyer / Seller?");return $this->response->redirect('index');
                    break;
                }
            }else{$this->flashSession->error("ERROR:: Token Mismatched!");}
        }else{$this->flashSession->error("ERROR:: Empty / Insecure Try!");} 
        return $this->response->redirect('index');   
    }
    public function endAction()
    {
        $this->view->disable();
        if($this->session->exists() && !empty($this->session->get('uname'))){
            $this->session->remove("uname");
            $this->session->destroy();
            $this->flashSession->success("SUCCESS:: Logged out!");
        }else{ $this->flashSession->error("ERROR:: Invalid Try!");}
        return $this->response->redirect('index');
    }
#END 


    // public function registerAction()
    // {
    //     // Your existing code
        
    //     // Enqueue email sending task
    //     $this->enqueueEmailTask($type, $umail, $register->name, $register->salt, $mailfor);
        
    //     // Your existing code
    // }

    // private function enqueueEmailTask($type, $umail, $uname, $salt, $mailfor)
    // {
    //     // Connect to Redis
    //     $this->redisQueue->connect('127.0.0.1', 6379);

    //     // Enqueue task
    //     $task = [
    //         'type' => $type,
    //         'umail' => $umail,
    //         'uname' => $uname,
    //         'salt' => $salt,
    //         'mailfor' => $mailfor
    //     ];
    //     $this->redisQueue->rPush('email_queue', json_encode($task));
    // }


    private function enqueueEmailTask($type, $umail, $uname, $salt, $mailfor)
    {
        // Create a serializer factory
        $serializerFactory = new SerializerFactory();

        // Create a new instance of Phalcon's Redis adapter
        $redis = new Redis(
            $serializerFactory,
            [
                "host" => "127.0.0.1",
                "port" => 6379,
                "persistent" => false, // Adjust as needed
                "index" => 1, // Adjust as needed
                "auth" => "", // Adjust as needed
            ]
        );

        // Enqueue task
        $task = [
            'type' => $type,
            'umail' => $umail,
            'uname' => $uname,
            'salt' => $salt,
            'mailfor' => $mailfor
        ];
        $redis->lPush('email_queue', json_encode($task)); // or rPush() if you prefer adding to the end of the list
    }





    // // Worker process function
    public function processEmailQueueAction()
    {
        // Connect to Redis
        $this->redisQueue->connect('127.0.0.1', 6379);

        // Process tasks from the queue
        while (true) {
            $taskJson = $this->redisQueue->lPop('email_queue');
            if ($taskJson === false) {
                // If queue is empty, sleep for a while before checking again
                sleep(1);
                continue;
            }

            // Decode task
            $task = json_decode($taskJson, true);

            // Send email
            $this->autoMail($task['type'], $task['umail'], $task['uname'], $task['salt'], $task['mailfor']);
        }
    }





}
