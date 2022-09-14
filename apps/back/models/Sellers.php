<?php declare(strict_types=1);
namespace F\Back\Models;
#use Phalcon\Mvc\Model\Behavior\Timestampable;
class Sellers extends BaseModel
{
    public $id;
    public $name;
    public $email;
    public $address;
    public $contact;
    public $shopname;
    public $passwd;
    public $nidpassport;
    public $servicelogo;
    public $active;
    public $level;
    public $type;
    public $salt;
    public $created_at;
    public function initialize()
    {
        parent::initialize();
        $this->setSource('sellers');
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
    public function beforeValidationOnCreate()
    {
        $this->created_at = date('Y-m-d H:i:s');
    }    
# Protect SuperUser from Delete 
    public function beforeDelete(){if($this->level === '3'){ return false;}return true;}   
# Send Activation link email to registered new users mail    
    public function afterCreate(){if($this->level === '0' || $this->active === '0'){return true;}return false;}
//End    
}