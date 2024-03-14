<?php declare(strict_types=1);
namespace F\Front\Models;
use Phalcon\Mvc\Model;
#use DateTime;
#use Phalcon\Mvc\Model\Behavior\Timestampable;
class BaseModel extends Model
{
  // public $db;
  public function initialize()
  {
      $this->setSchema("phalconshop");
      #$this->addBehavior(new Timestampable(['beforeCreate' => ['field' => 'created_at', 'format' => 'dmY-His']])); #Dynamic insert/update dateTime in created_at field
  } 
  public function afterUpdate()
  {
      // Call backup function after each successful update
      $backupFolderPath = BASE_PATH . "/public/schemas"; // Specify the folder where backups will be stored
      $backup = new \F\Libraries\BackupDB\DbBackup($this->getDI()->get('db'), $backupFolderPath);
      $backup->backupDatabase();
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
