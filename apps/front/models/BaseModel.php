<?php declare(strict_types=1);
namespace F\Front\Models;
use Phalcon\Mvc\Model;
#use DateTime;
#use Phalcon\Mvc\Model\Behavior\Timestampable;
class BaseModel extends Model
{
   public $db;
   public function initialize()
   {
      $this->setSchema("phalconshop");
      $this->db = $this->getDi()->getShared('db');
		#$this->addBehavior(new Timestampable(['beforeCreate' => ['field'  => 'created_at','format' => 'dmY-His',] ]));   #Dynamic insert/update dateTime in created_at field	
   }  
    
# Skip NULL Fields No create OR Update By Default
	// public function beforeValidationOnCreate()
 //    {
 //        $notNullAttributes = $this->getModelsMetaData()->getNotNullAttributes($this);
 //        foreach ($notNullAttributes as $field) {
 //            if (is_null($this->$field)) {
 //                $this->$field = new \Phalcon\Db\RawValue('default');
 //            } elseif($this->$field=="") {
 //                $this->$field = new \Phalcon\Db\RawValue("''");
 //            }
 //        }
 //    }
 //    public function beforeValidationOnUpdate()
 //    {
 //        $notNullAttributes = $this->getModelsMetaData()->getNotNullAttributes($this);
 //        foreach ($notNullAttributes as $field) {
 //            if(!is_null($this->$field) && $this->$field=="") {
 //                $this->$field = new \Phalcon\Db\RawValue("''");
 //            }
 //        }
 //    }
#END    
} 
