<?php declare(strict_types=1);
namespace F\Back\Models;
class Subcategory extends BaseModel
{
	public $id;
	public $category_id;
	public $subcategory_name;
	public function initialize(){
        parent::initialize();		
		# Set table name
    	$this->setSource('subcategory');
	    // category => blog column name which refers to the ID in the Category table
		// Category => name of the Category table
		// id => name of the primary key column in the Category table
    	//$this->belongsTo('category',"Firefly\Frontend\Models\Category", 'id');
  	}
}