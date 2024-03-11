<?php declare(strict_types=1);
namespace F\Front\Models;
class Cart extends BaseModel
{
	public $id;
    public $userid;
    public $type;  
	public $productid;
    public $quantity;
    public $size;
    public $color;    
    public $price;
    public $discount;
    public $shipingcost;
    public $cashonfee;
    public $subtotal;
    public $coupon;
    public $orderflag;
    public $orderid;
    public $orderstatus;
    public $paytype;
    public $trxn;
    public $orderdate;
    public $shopid;

	public function initialize()
    {
        parent::initialize();        
		# Set table name
    	$this->setSource('cart');
	    // category => blog column name which refers to the ID in the Category table
		// Category => name of the Category table
		// id => name of the primary key column in the Category table
    	//$this->belongsTo('category',"Firefly\Frontend\Models\Category", 'id');  
        //$this->keepSnapshots(true); 
        // $this->skipAttributes(
        //     [
        //         'subtotal',
        //         'grandtotal',
        //     ]
        // );

  	} 	
    // public function beforeUpdate()
    // {
    //     if($this->hasChanged()) 
    //     {
    //         $datetime = new \DateTime('now', new \DateTimeZone('UTC'));
    //         $this->updated_at = $datetime->format('Y-m-d H:i:s');
    //     }
    // }    
}