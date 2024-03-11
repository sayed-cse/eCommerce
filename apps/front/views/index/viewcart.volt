{% extends "layouts/main.volt" %}
{% block content %}{# Begin #}
<section class="row">
	<article class="">
	{% if mycart > 0 %}
	<div class="table brd026 brd1x brdSolid">
		<div class="thead">
			<div class="tr">
				<div class="th txtCenter pad8x color333 bold fSmallcap fSmall " scope="col">Image</div>
				<div class="th txtCenter pad8x color333 bold fSmallcap fSmall  width50p" scope="col">Title</div>
				<div class="th txtCenter pad8x color333 bold fSmallcap fSmall " scope="col">Qty</div>
				<div class="th txtCenter pad8x color333 bold fSmallcap fSmall " scope="col">Scale</div>
				<div class="th txtCenter pad8x color333 bold fSmallcap fSmall " scope="col">Price</div>
				<div class="th txtCenter pad8x color333 bold fSmallcap fSmall " scope="col">Discount</div>
				<div class="th txtCenter pad8x color333 bold fSmallcap fSmall " scope="col">Shipping</div>
				<div class="th txtCenter pad8x colorDC3 bold fSmallcap fSmall " scope="col"><i title="Delete" class="ico-trash"></i></div>
			</div>
		</div>
		<div class="tbody">
		{% for query in carts %}
			<div class="tr fSmall" id="cart_{{query.id}}">
				<div class="td txtCenter" data-label="Image"><img alt="" class="width50x height50x" data-src="{{url.getBaseUri('')}}uploads/shop/{{query.color}}" /></div>
				<div class="td txtLeft" data-label="title">
					{% for product in products %}
						{% if product.id === query.productid %}
							{{product.product_title}}
						{% endif %}
					{% endfor %}
				</div>
				<div class="td txtCenter" data-label="Qty">
					<span title="Decrement" class="vcqt ico-minus cursorPoint brd0x bold" data-id="{{query.id}}"></span>
					<input readonly name="qty[{{query.id}}]" id="qty_{{query.id}}" class="qty width50x color666 txtCenter brd0x pad0x" type="number" value="{{query.quantity}}" />
					<span title="Increment" class="vcqt ico-plus cursorPoint brd0x bold" data-id="{{query.id}}"></span>
				</div>
				<div class="td txtCenter" data-label="Size">{% if query.size === '0' %}N/A{% else %}{{ query.size }}{% endif %}</div>
				<div class="td txtCenter" data-label="Price">{{ query.price }}</div>
				<div class="td txtCenter" data-label="Discount">{% if query.discount is empty %}N/A{% else %}{{ query.discount }}{% endif %}</div>
				<div class="td txtCenter" data-label="Shipping">{% if shippingcost > 0 %}{{ query.shipingcost }}{% else %}N/A{% endif %}</div>
				<div class="td txtCenter" data-label="Delete"><a class="cartdel color666" data-id="{{query.id}}" href="javascript:void(0);">[ <i title="Delete" class="ico-del colorF00"></i> ]</a></div>
			</div>	
		{% endfor %}				
		</div>
	</div>	
	<p class="bgFFF fSmall pad8x">
        {{ submit_button('Continue Shopping','id':'continuebtn','class':'marginA neumorphism cursorPoint bold pad4x bgEEE') }}
        {{ submit_button('Update Shipping','id':'updshipbtn','class':'marginA neumorphism cursorPoint bold pad4x bgEEE') }}
        {{ submit_button('Checkout','id':'checkoutbtn','class':'marginA neumorphism cursorPoint bold pad4x bgEEE') }}<br/>
	</p>
	<p id="coupons">
		{{ text_field('coupon','data-id':uid,'class':'','disabled':'disabled') }}<br/>
		{{ submit_button('APPLY COUPON','id':'getcoupon','class':'marginA neumorphism cursorPoint bold pad4x bgEEE','disabled':'disabled') }}
	</p>
	<div class="bgFFF fSmall txtRight pad8x clrB">
        Products Sub Total : BDT <strong class="subtotals"><?php echo(number_format($subtotal, 0, '.')); ?></strong><br/>

		{% if shippingcost > 0 %}
		    Shipping Charge : BDT <strong class="shiptotal">{{ shippingcost }}</strong>
		{% else %}
		{% set shippingcost = 0 %}
		<strong class="color080">Shipping Not Available</strong>
		{% endif %}

	    {% if coupon > 0 %}
	    	<hr/>Coupon Discount: <strong>- {{coupon}}</strong><hr/> <strong class="color080">Grand Total : </strong><strong class="gtotal colorF00">BDT <?php echo(number_format(ceil(($subtotal + $shippingcost) - $coupon), 0, '.', '')); ?></strong>
		{% else %}
		    <hr/>
			<strong class="color080">Grand Total : </strong><strong class="gtotal colorF00">BDT 
<?php 
//For Bangla Taka Format
#$fmt = numfmt_create( 'bn_BD', NumberFormatter::CURRENCY );
#echo numfmt_format_currency($fmt, $subtotal + $shippingcost , "BDT")."\n";
?>
<?php echo(number_format(ceil($subtotal + $shippingcost), 2, '.')); ?>
			</strong>
	    {% endif %}
	</div>	
{% else %}<br/><br/><br/><br/><p class="bold fxxLarge txtCenter pad10x"><i class="ico-verifiedNo fxxLarge"></i><br/>You have no items in your shopping cart!</p>
{% endif %}<div class="loader nodisp fxSmall txtCenter"><img src="{{url.getBaseUri('')}}img/loading.gif" data-src="{{url.getBaseUri('')}}img/loading.gif" />Injecting Updates...</div>
	</article>
</section> 
{# End #}{% endblock %}
