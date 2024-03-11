<?php declare(strict_types=1);
namespace F\Front\Models;
class City extends BaseModel
{
	public $cid;
	public $regionid;
	public $cityname;
	
	public function initialize(){
        parent::initialize();		
		# Set table name
    	$this->setSource('city');
	    // category => blog column name which refers to the ID in the Category table
		// Category => name of the Category table
		// id => name of the primary key column in the Category table
    	//$this->belongsTo('category',"Firefly\Frontend\Models\Category", 'id');
  	}
}