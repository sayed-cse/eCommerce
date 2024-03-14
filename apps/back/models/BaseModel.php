<?php declare(strict_types=1);
namespace F\Back\Models;
use Phalcon\Mvc\Model;
//use Phalcon\Mvc\Model\Query,
//use Phalcon\Mvc\Model\Behavior\Timestampable;
class BaseModel extends Model
{
  //$this->fireEvent('afterUpdate');
   //public $db;
  public function initialize()
  {
      $this->setSchema("phalconshop");
      //$this->db = $this->getDi()->getShared('db');
      //$this->addBehavior(new Timestampable(['beforeCreate' => ['field' => 'created_at', 'format' => 'dmY-His']])); #Dynamic insert/update dateTime in created_at field
  }

  public function afterUpdate()
  {
      // Call backup function after each successful update
      $backupFolderPath = BASE_PATH . "/public/schemas"; // Specify the folder where backups will be stored
      $backup = new \F\Libraries\BackupDB\DbBackup($this->getDI()->get('db'), $backupFolderPath);
      $backup->backupDatabase();
  }


} 
