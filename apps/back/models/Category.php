<?php declare(strict_types=1);
namespace F\Back\Models;
class Category extends BaseModel
{
	public $id;
	public $categoryname;
	public function initialize(){
        parent::initialize();		
		# Set table name
    	$this->setSource('category');
	    // category => blog column name which refers to the ID in the Category table
		// Category => name of the Category table
		// id => name of the primary key column in the Category table
    	//$this->belongsTo('category',"Firefly\Frontend\Models\Category", 'id');
  	}
}