<?php declare(strict_types=1);
namespace F\Back\Models;
class Products extends BaseModel
{
        public $id;
        public $category_id;
        public $subcategory_id;
        public $sscid;
        public $product_title;
        public $pimg_front;
        public $pimg_back;
        public $pimg_left;
        public $pimg_right;
        public $pimg_top;
        public $pimg_bottom;
        public $product_price;
        public $discount;
        public $coupon;
        public $couponamount;
        public $psize;
        public $scaletype;
        public $pweight;
        public $keywords;
        public $specification;
        public $stage;
        public $pcode;
        public $warranty;
        public $shopid;
        public $hits;
        public $stock;
	public function initialize(){
        parent::initialize();                
		# Set table name
        $this->setSource('products');
        // $this->hasMany('id',"Ratings::class",'productid');
        // $this->hasMany('sscid',"Ssc::class",'id');
        // $this->hasMany('subcategory_id',"Subcategory::class",'id');
        // $this->hasMany('category_id',"Category::class",'id');
        # disable the default phalcon validation

	    // category => blog column name which refers to the ID in the Category table
		// Category => name of the Category table
		// id => name of the primary key column in the Category table
    	//$this->belongsTo('category',"Firefly\Frontend\Models\Category", 'id');


# Skips fields/columns on both INSERT/UPDATE operations          
        // $this->skipAttributes(
        //     [
        //         'year',
        //         'price',
        //     ]
        // );
        // // Skips only when inserting
        // $this->skipAttributesOnCreate(
        //     [
        //         'created_at',
        //     ]
        // );
        // // Skips only when updating
        // $this->skipAttributesOnUpdate(
        //     [
        //         'modified_in',
        //     ]
        // );    	
  	}
   // public function beforeSave()
   // {
   //  	// $this->created_at = date("Y-m-d H:i:s");
   //  	// echo('Preview Inserted Data');
   //  	// exit();
   //  } 
	// public function afterSave()
	// {
 //    	echo('Save Success Full');
 //    	//exit();
	// }   
	// public function beforeUpdate()
	// {
	// 	$this->modified_in = date("Y-m-d H:i:s");
	// 	die();
	// }  

    // public function beforeSave()
    // {
    //     //Convert the array into a string
    //     $this->status = join(',', $this->status);
    // }

    // public function afterFetch()
    // {
    //     //Convert the string to an array
    //     $this->status = explode(',', $this->status);
    // }
    	
}