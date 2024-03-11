<?php declare(strict_types=1);
namespace F\Front\Models;
class Area extends BaseModel
{
	public $aid;
	public $cid;
	public $areaname;
	public $delivery_charge;
	
	public function initialize(){
        parent::initialize();		
		# Set table name
    	$this->setSource('area');
	    // category => blog column name which refers to the ID in the Category table
		// Category => name of the Category table
		// id => name of the primary key column in the Category table
    	//$this->belongsTo('cid',"F\Front\Models\Category", 'id');
  	}
}