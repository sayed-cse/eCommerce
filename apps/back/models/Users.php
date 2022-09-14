<?php declare(strict_types=1);
namespace F\Back\Models;
class Users extends BaseModel
{
    public $id;
    public $name;
    public $mail;
    public $passwd;
    public $active;
    public $level;
    public $type;
    public $salt;
#    public $image;    
#    public $online;
#    public $created_at;    
# Protect SuperUser from Delete 
    public function beforeDelete(){if($this->level === '3'){ return false;}return true;}   
# Send Activation link email to registered new users mail    
    public function afterCreate(){if($this->level === '0' || $this->active === '0'){return true;}return false;}

    // public function afterStart()
    // {
    //     if($this->session->has('uname'))
    //     {
    //         $user = Users::findFirstByumail($this->session->get('uname'));
    //         $user->online = trim('0');
    //         //$idleTime = 2;
    //         //if(time()-$_SESSION['timestamp'] > $idleTime)
    //         if($this->session->get('uname')->expired < time())
    //         {
    //             if(!$user->update())
    //             {
    //                 $this->flashSession->error("Session Error");
    //                 return $this->response->redirect($this->router->getControllerName());
    //             }
    //             else
    //             {
    //                 $this->flashSession->success("You are Logged Out");
    //                 return $this->response->redirect($this->router->getControllerName());
    //             } 
    //         }               
    //      }
    // }




//End    
}