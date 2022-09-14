<?php declare(strict_types=1);
namespace F\Back\Models;
use Phalcon\Mvc\Model;
//use Phalcon\Mvc\Model\Query,
class BaseModel extends Model
{

   public $db;
   public function initialize()
   {
      $this->setSchema("phalconshop");
      $this->db = $this->getDi()->getShared('db');
   }   

} 