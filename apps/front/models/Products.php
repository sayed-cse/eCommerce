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
        $this->hasMany('id',Ratings::class,'productid');
        $this->hasMany('sscid',Ssc::class,'id');
        $this->hasMany('subcategory_id',Subcategory::class,'id');
        $this->hasMany('category_id',Category::class,'id');
        //$this->belongsTo('category_id', Category::class, 'id');

# Skips fields/columns on both INSERT/UPDATE operations
        // $this->skipAttributesOnCreate(
        //     [
        //         'hits',
        //     ]
        // );        
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
    // public function afterUpdate()
    // {
    //     // Call backup function after each successful update
    //     $backup = new DbBackup($this->getDI()->get('db'));
    //     $backup->backupDatabase();
    // }            	
}