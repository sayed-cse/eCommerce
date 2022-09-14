<?php declare(strict_types=1);
namespace F\Front\Models;
class Ship extends BaseModel
{
	public $sid;
	public $suserid;
	public $type;
	//public $sorerdid;
	//public $sproductid;
	//public $semail;
	public $fname;
	public $sphone;
	public $sregion;
	public $scity;
	public $sarea;
	public $saddress;
	
	public function initialize(){
        parent::initialize();		
		# Set table name
    	$this->setSource('ship');
	    // category => blog column name which refers to the ID in the Category table
		// Category => name of the Category table
		// id => name of the primary key column in the Category table
    	//$this->belongsTo('category',"Firefly\Frontend\Models\Category", 'id');
  	}
}