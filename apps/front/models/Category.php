<?php declare(strict_types=1);
namespace F\Front\Models;
class Category extends BaseModel
{
	public $id;
	public $categoryname;
	
	public function initialize(){
        parent::initialize();		
		# Set table name
    	$this->setSource('category');
    	$this->belongsTo('id', Products::class, 'category_id');
  	}
}