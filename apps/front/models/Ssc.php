<?php declare(strict_types=1);
namespace F\Front\Models;
class Ssc extends BaseModel
{
	public $id;
	public $subcatid;
	public $ssctitle;
	
	public function initialize(){
        parent::initialize();		
		# Set table name
    	$this->setSource('ssc');
    	$this->belongsTo('id', Products::class, 'sscid');
  	}
}