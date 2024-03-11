<?php declare(strict_types=1);
namespace F\Front\Models;
class Ratings extends BaseModel
{
	public $id;
	public $usrid;
	public $productid;
	public $rating;
	public $created_at;
	public function initialize(){
        parent::initialize();		
		# Set table name
    	$this->setSource('prating');
    	$this->belongsTo('productid', Products::class, 'id');
  	}
    //public function beforeValidationOnCreate(){$this->timestamp = date('Y-m-d H:i:s');}   
    //public function beforeSave(){ $this->created_at = date("Y-m-d H:i:s"); } 	
}