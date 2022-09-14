<?php declare(strict_types=1);
namespace F\Front\Models;
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
    // public $image;    
    // public $online;
    // public $created_at;
    public function initialize()
    {
        parent::initialize();
        $this->setSource('users');
    # SKIP DEFAULT VALIDATION METHOD IN INDIVIDUAL MODEL
        # SKIP BOTH CREATE|UPDATE
        #$this->skipAttributes(array('field1', 'field2'));
        # SKIP ON CREATE
        #$this->skipAttributesOnCreate(array('field1', 'field2'));
        # SKIP ON UPDATE
        #$this->skipAttributesOnUpdate(array('field1', 'field2'));
        #OR
        #$this->allowEmptyStringValues(['name', 'text', 'datetime']);
    }


    
# Protect SuperUser from Delete 
    public function beforeDelete(){if($this->level === '3'){ return false;}return true;}   
# Send Activation link email to registered new users mail    
    public function afterCreate(){if($this->level === '0' || $this->active === '0'){return true;}return false;}





//End    
}