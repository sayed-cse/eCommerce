<?php declare(strict_types=1);
namespace F\Front\Models;
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
        public $keywords;
        public $specification;
        public $stage;
        public $shopid;

	public function initialize(){
        parent::initialize();                
	# Set table name
    	$this->setSource('products');
        $this->belongsTo("sscid", "ssc", "id");
        $this->belongsTo("subcategory_id", "subcategory", "id");
        $this->belongsTo("category_id", "category", "id");
        # category_id => column name which refers to the ID in the category table
        # category => name of the category table
        # id => name of the primary key column of this table


	    // category => blog column name which refers to the ID in the Category table
		// Category => name of the Category table
		// id => name of the primary key column in the Category table
    	//$this->belongsTo('category',"Firefly\Frontend\Models\Category", 'id');


# Skips fields/columns on both INSERT/UPDATE operations
        // $this->skipAttributes(
        //     [
        //         'coupon',
        //         'couponamount',
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
 //    public function beforeSave()
 //    {
 //    	$this->created_at = date("Y-m-d H:i:s");
 //    	echo('Preview Inserted Data');
 //    	//exit();
 //    } 
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
}