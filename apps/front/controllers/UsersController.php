<?php declare(strict_types=1);
namespace F\Front\Controllers;
use F\Front\Models\Users as Users;
use F\Front\Models\Sellers as Sellers;
use Phalcon\Image\Adapter\GD as GdAdapter;
use Phalcon\Encryption\Security\Random;
// use PHPMailer\PHPMailer;
// use PHPMailer\PHPMailer\SMTP;
// use PHPMailer\PHPMailer\Exception;
class UsersController extends BaseController
{
    public function initialize()
    {
        parent::initialize();
    }		
    public function indexAction()
    {
        if($this->session->exists() and !empty($this->session->get('uname')))
        {
            $uid = $this->session->get('id');$name = $this->session->get('uname');$active = $this->session->get('active');$level = $this->session->get('level');$type = $this->session->get('type');
            $this->view->uid = $uid;
            $this->view->uname = $name;
            $this->view->active = $active;
            $this->view->level = $level;
            $this->view->type = $type;                       
        }else{ $this->flashSession->error("ERROR:: Access denied!"); return $this->response->redirect(); }
    }
    public function signupsaleAction()
    {
        $this->view->action = 'users/register';
        $this->view->type = 's';
        if(!empty($this->session->get('uname'))){return $this->response->redirect();}else{$this->view->pick('index/signup');}        
    }
    public function signupbuyAction()
    {
        $this->view->action = 'users/register';
        $this->view->type = 'b';
        if(!empty($this->session->get('uname'))){return $this->response->redirect();}else{$this->view->pick('index/signup');}         
    }    
    public function registerAction()
    {
        //$this->fire();die();
        //$this->view->disable();        
        $type = $this->request->getPost('type');
        if($type === 's'){
            $register = new Sellers();
            $uname = htmlspecialchars(trim($this->request->getPost('uname')));
            $shopname = htmlspecialchars(trim($this->request->getPost('shopname')));
            $address = htmlspecialchars(trim($this->request->getPost('address')));
            $contact = htmlspecialchars(trim($this->request->getPost('contact')));
            $umail = htmlspecialchars(trim($this->request->getPost('umail'))); 
            $passwd = htmlspecialchars(trim($this->request->getPost('passwd')));
            if(!empty($uname) and !empty($umail) and !empty($passwd) and !empty($shopname) and !empty($contact) and !empty($address)){
                $query = Sellers::countByemail($umail);
                if($query > 0){
                    $this->flashSession->warning("WARNING:: User Already Exists!");
                    return $this->response->redirect($this->request->getHTTPReferer());
                }else{
                    $register->name = $uname;
                    $register->shopname = $shopname;
                    $register->address = $address;
                    $register->contact = $contact;
                    $register->email = $umail;
                    $register->type = 's';
                    $register->passwd = $this->security->hash($passwd);
                    $register->level = '2';
                    $register->active = '1';
                    $random = new Random();
                    $register->salt = $random->base64(12); 
        #Upload Image
                    if($this->request->hasFiles())
                    {
                        $uploadPath = 'uploads/users/';
                        $isUploaded = false;
                        $images = $this->request->getUploadedFiles();                     
                        foreach($images as $file)
                        {
                            if($file->getError() === 0)
                            {
                                #Required enable extension=php_fileinfo.dll in php.ini
                                if($this->imageCheck($file->getRealType()))
                                {
                                    //echo $file->getName(), " ", $file->getSize(), "\n";
                                    $imgName = strtolower(date('dmy-His-').$file->getName());
                                    $file->moveTo($uploadPath.$imgName) ? $isUploaded = true : $isUploaded = false;
                                    #Resize & Crop Image
                                    $image = new GdAdapter($uploadPath.$imgName);
                                    if($image->getWidth() > 458)
                                    {
                                        $image->resize(457,457);
                                        $image->sharpen(50);
                                    }                    
                                    $image->save($uploadPath.$imgName);
                                    $myvars[] = $imgName;
                                !empty($myvars[0]) ? $register->nidpassport = $myvars[0] : $register->nidpassport = '0';
                                !empty($myvars[1]) ? $register->servicelogo = $myvars[1] : $register->servicelogo = '0';
                                    @unlink($uploadPath.$file->getName()); 
                                }
                                else
                                {
                                    @unlink($file->getName()); 
                                    $this->flashSession->warning("WARNING:: File extension not allowed");
                                    return $this->response->redirect($this->request->getHTTPReferer());
                                }
                            }else{
                                @unlink($file->getName());
                                $this->flashSession->warning("WARNING:: File may corrupted / missing!");
                                return $this->response->redirect($this->request->getHTTPReferer());
                            }
                        }
                    }
                    else{
                        $this->flashSession->warning("WARNING:: NID/PASSPORT/LICENSE is Required!");
                        return $this->response->redirect($this->request->getHTTPReferer());                
                    }
                    if(false === $register->save()){
                        foreach($register->getMessages() as $msg)
                        {
                        !empty($myvars[0] and $myvars[0] !== 'empty.png') ? @unlink($uploadPath.$myvars[0]) : 'empty.png';
                        !empty($myvars[1] and $myvars[1] !== 'empty.png') ? @unlink($uploadPath.$myvars[1]) : 'empty.png';
                            $this->flashSession->error("ERROR::".$msg);
                            return $this->response->redirect($this->request->getHTTPReferer());                     
                        }
                    }else{
                        $this->flashSession->success("SUCCESS:: Record Saved!");
                        return $this->response->redirect($this->request->getHTTPReferer());                 
                    }
                }
            }else{
                $this->flashSession->error("ERROR:: Required Fields Going Empty!!");
                return $this->response->redirect($this->request->getHTTPReferer());                
            }
        }elseif($type === 'b'){
            $register = new Users();
            $uname = trim($this->request->getPost('name'));
            $umail = trim($this->request->getPost('email')); 
            $passwd = trim($this->request->getPost('passwd'));
            if(!empty($uname) and !empty($umail) and !empty($passwd)){
                $query = Users::countBymail($umail);
                if($query > 0){
                    $this->flashSession->warning("WARNING:: User Already Exists!");
                    return $this->response->redirect($this->request->getHTTPReferer());
                }else{
                    $register->name = $uname;
                    $register->mail = $umail;
                    $register->type = 'b';
                    $register->passwd = $this->security->hash($passwd);
                    $register->level = '1';
                    $register->active = '1';
                    $random = new Random();
                    $register->salt = $random->base64(12); 
                    if(false === $register->save()){
                        foreach($register->getMessages() as $msg)
                        {
                            $this->flashSession->error("ERROR::".$msg);
                            return $this->response->redirect($this->request->getHTTPReferer());
                        }
                    }else{
//Post Mail | better use queue
                        $mail = $this->pmail();                  
                        if($mail){echo('OK');}else{echo('ERRROR');}die();
                        $this->flashSession->success("SUCCESS:: Record Saved!");
                        return $this->response->redirect($this->request->getHTTPReferer());
                    }                
                }
            }else{
                $this->flashSession->error("ERROR:: Required Fields Going Empty!!");
                return $this->response->redirect($this->request->getHTTPReferer());  
            }            
        }else{
            $this->flashSession->error("ERROR:: Invalid Try!");
            return $this->response->redirect($this->request->getHTTPReferer());            
        }
    }

    private function pmail()
    {   
        //$this->view->disable(); 
        include(BASE_PATH . '/library/phpMailer/PHPMailer.php');       
        $pmailer = new pmailer();
        $this->pmailer->From  = "2munax@gmail.com";
        $this->pmailer->FromName = "user";
        $this->pmailer->addReplyTo("2munax@gmail.com", "user");
        $this->pmailer->addAddress('babymachinery83@gmail.com');   
        $this->pmailer->Subject = "email test !";
        $this->pmailer->Body = "success!";
        $this->pmailer->WordWrap = 70;
        if(!$this->pmailer->send()){echo 'Message could not be sent.';
            ## Set Logging for failed mail
            return 'Mailer Error: ' . $this->pmailer->ErrorInfo;
        } else {
            return 'Message has been sent';
        }
    }
    public function startAction()
    {
        $this->view->disable();
        $name = trim($this->request->getPost('mail'));
        $password = trim($this->request->getPost('passwd'));
        $loginType = $this->request->getPost('ltype');
        if($this->request->isPost())
        {
            if($this->security->checkToken()){
                switch($loginType){
                    case 's':
                        $users = Sellers::find([ 'conditions' => '(email = ?1 AND type = ?2 AND active = ?3)','bind' => [1 => $name, 2 => $loginType, 3 => '1'] ]);                        
                        foreach($users as $user){$uname = $user->email;$active = $user->active;$type = $user->type;$level = $user->level;}
                        if($uname === $name and $active === '1' and $type === $loginType and $level !== '1'){
                            if($this->security->checkHash($password, $user->passwd)){
                                $this->session->set('id', $user->id);
                                $this->session->set("uname", $user->name);
                                $this->session->set("active", $user->active);
                                $this->session->set("level", $user->level);
                                $this->session->set("type", $user->type); 
                                $this->flashSession->success("SUCCESS:: Welcome to Admin Area!");return $this->response->redirect('back/index/entry')->send();              
                            }else{$this->flashSession->warning("WARNING:: Invalid Username / Password!");return $this->response->redirect();}
                        }else{$this->flashSession->warning("WARNING:: You may not registered / activated!");return $this->response->redirect();}
                    break;
                    case 'b':
                        $users = Users::findBymail($name);
                        foreach($users as $user){$uname = $user->mail;$active = $user->active;$type = $user->type;$level = $user->level;}                    
                        if($uname === $name and $active === '1' and $level === '1' and $type === $loginType){
                            if($this->security->checkHash($password, $user->passwd)){
                                $this->session->set('id', $user->id);
                                $this->session->set("uname", $user->name);
                                $this->session->set("active", $user->active);
                                $this->session->set("level", $user->level);
                                $this->session->set("type", $user->type); 
                                $this->flashSession->success("SUCCESS:: Welcome to LampTouch Family!");return $this->response->redirect();              
                            }else{$this->flashSession->warning("WARNING:: Invalid Username / Password!");return $this->response->redirect();}
                        }else{$this->flashSession->warning("WARNING:: You may not registered / activated!");return $this->response->redirect();}
                    break;
                    default:
                        $this->flashSession->warning("WARNING:: Please! Confirm You are a Buyer / Seller?");return $this->response->redirect();
                    break;
                }
            }
            else{$this->flashSession->error("ERROR:: Token Mismatched!");return $this->response->redirect();}
        }
        else{$this->flashSession->error("ERROR:: Empty / Insecure Try!");return $this->response->redirect();}    
    }
    public function endAction()
    {
        $this->view->disable();
        if($this->session->exists() and !empty($this->session->get('uname'))){
            $this->session->remove("uname");
            $this->session->destroy();
            $this->flashSession->success("SUCCESS:: Logged out!");
            return $this->response->redirect();
        }else{ $this->flashSession->error("ERROR:: Invalid Try!"); return $this->response->redirect(); }              
    }
    private function imageCheck($extension = null){$allowedTypes = ['image/gif','image/jpg','image/bmp','image/png','image/jpeg'];return in_array($extension, $allowedTypes);} 
    private function postmailAction()
    {
      //   require_once(BASE_PATH . "/library/phpMailer/PHPMailer.php");
      //   $mail = new \PHPMailer();
      //   $mail->isSMTP();                                      // Set mailer to use SMTP
      //   $mail->isHTML(true);                                  // Set email format to HTML
      //   $mail->Host = 'smtp.gmail.com';  // Specify main and backup SMTP servers
      //   $mail->SMTPAuth = true;                               // Enable SMTP authentication
      //   $mail->SMTPKeepAlive = false;  //Prevents the SMTP connection from being closed after each mail sending. If this is set to true then to close the connection requires an explicit call to SmtpClose().
      //   $mail->ConfirmReadingTo = 'anikamachinery@gmail.com'; //Sets the email address that a reading confirmation will be sent.
      //   $mail->Username = $mail->ConfirmReadingTo;                 // SMTP username
      //   $mail->Password = '1234anika';                           // SMTP password
      //   $mail->SMTPSecure = 'tls';                            // Enable TLS encryption, `ssl` also accepted
      //   $mail->CharSet = 'UTF-8';
      //   $mail->Encoding = '7bit';
      //   $mail->Mailer = 'smtp';
      //   $mail->WordWrap = 50;
      //   $mail->Port = 587;                                    // TCP port to connect to
      //   $mail->Priority = 1;                                    // Set Priority
      //   $mail->addCustomHeader("X-Priority: 1");
      //   $mail->AddCustomHeader("X-MSMail-Priority: High");  // Not sure if Priority will also set the Importance header:
      //   $mail->AddCustomHeader("Importance: High");
      //   $mail->AddCustomHeader("X-Originating-IP:".$_SERVER['SERVER_ADDR'].' \r\n');
      //   $mail->AddCustomHeader("Senders IP: ".$_SERVER['REMOTE_ADDR'].' \r\n');
      //   $mail->AddCustomHeader("MIME-Version: 1.0 \r\n");
      //   $mail->AddCustomHeader("Return-Path: ".$mail->ConfirmReadingTo.' \r\n');
      //   $mail->AddCustomHeader("X-Mailer: Phalcon- ".phpversion().' \r\n');
      //   $mail->AddCustomHeader("X-Confirm-Reading-To: ".$mail->ConfirmReadingTo); //For the reading confirmations:
      //   $mail->AddCustomHeader("Return-receipt-to: ".$mail->ConfirmReadingTo);                    
      //   $mail->AddCustomHeader("Disposition-Notification-To: ".$mail->ConfirmReadingTo); //For delivery confirmations:

      // //  $this->pre_store();
      //   $mail->setFrom('anikamachinery@gmail.com', 'Webmaster');
      //   $mail->addAddress($email, $uname);     // Add a recipient
      //   //$mail->addAddress('ellen@example.com');               // Name is optional
      //   $mail->addReplyTo($mail->ConfirmReadingTo, 'Webmaster');
      //   //$mail->addCC('cc@example.com');
      //   //$mail->addBCC('bcc@example.com');
      //   //$mail->addAttachment('/var/tmp/file.tar.gz');         // Add attachments
      //   //$mail->addAttachment('/tmp/image.jpg', 'new.jpg');    // Optional name
      //   $mail->Subject = 'Registration Verification: Continuous Impression';
      //   $mail->Body    = '<b style="color:#026180">Thanks for signing up!</b><br/>Your account has been created, you can now login with the following credentials, after you have activated your account by pressing the url below.
      //       <br/>------------------------<br/>Login : '.$email.'<br/>Password : '.$passwd.'<br/>------------------------<br/>
      //       Please click this link to activate your account <a href=http://localhost/f/users/uactive?umail='.$email.'&salt='.$rnd_id.'>Click Here</a><br/>Best regards,<br/><a href="http://www.eindex.info">eindex</a><br/>webmaster';
      //   $mail->AltBody = 'This message sent via <a href="http://www.eindex.info">eindex</a> for Registration Verification. If you are unable to read your login and password please! Register again. Thank`s<br/> webmaster<br/>';
      //   //echo($stburl);exit();
      //   if(!$mail->send()) {
      //       $this->flashSession->error("Mailer Error: ".$mail->ErrorInfo);
      //       return $this->response->redirect($this->router->getControllerName());
      //   } else {
      //       $this->flashSession->success("Check your email to activate");
      //       return $this->response->redirect($this->router->getControllerName());
      //   }
    }



#END    
}
