<?php declare(strict_types=1);
namespace F\Front\Models;
class Subcategory extends BaseModel
{
	public $id;
	public $category_id;
	public $subcategory_name;
	
	public function initialize(){
        parent::initialize();
		# Set table name
    	$this->setSource('subcategory');
    	$this->belongsTo('id', Products::class, 'subcategory_id');
  	}
}