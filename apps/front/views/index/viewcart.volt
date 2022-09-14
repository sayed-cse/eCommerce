{% extends "layouts/main.volt" %}
{% block content %}{# Begin #}
<section class="row">
	<article class="rc12">
	{% if mycart > 0 %}
	<p class="bg0d6077 colorFFF bold pad10x headRadius"></p>
	<div class="table brd0d6 brd1x brdsolid">
		<div class="thead">
			<div class="tr">
				<div class="th txtCenter pad8x colorFFF bold fsmallcap fsmall" scope="col">Image</div>
				<div class="th txtCenter pad8x colorFFF bold fsmallcap fsmall width50p" scope="col">Title</div>
				<div class="th txtCenter pad8x colorFFF bold fsmallcap fsmall" scope="col">Qty</div>
				<div class="th txtCenter pad8x colorFFF bold fsmallcap fsmall" scope="col">Size</div>
				<div class="th txtCenter pad8x colorFFF bold fsmallcap fsmall" scope="col">Price</div>
				<div class="th txtCenter pad8x colorFFF bold fsmallcap fsmall" scope="col">Discount</div>
				<div class="th txtCenter pad8x colorFFF bold fsmallcap fsmall" scope="col">Shipping</div>
				<div class="th txtCenter pad8x colorFFF bold fsmallcap fsmall" scope="col"><i title="Delete" class="ico-del"></i></div>
			</div>
		</div>
		<div class="tbody">
		{% for query in cart %}
			<div class="tr fsmall" id="cart_{{query.id}}">
				<div class="td txtCenter" data-label="Image"><img alt="" class="float_left width50x height50x" data-src="uploads/shop/{{query.color}}" /></div>
				<div class="td txtLeft" data-label="title">
					{% for product in products %}
						{% if product.id === query.productid %}
							{{product.product_title}}
						{% endif %}
					{% endfor %}
				</div>
				<div class="td txtCenter" data-label="Qty">
					<span title="Decrement" class="vcqt ico-minus cursorpoint brd0x bold" data-id="{{query.id}}"></span>
					<label><input readonly name="qty[{{query.id}}]" id="qty_{{query.id}}" class="qty width50x color666 txtCenter brd0x pad0x" type="number" value="{{query.quantity}}" /></label>
					<span title="Increment" class="vcqt ico-plus cursorpoint brd0x bold" data-id="{{query.id}}"></span>
				</div>
				{% if (not(query.size === '0')) %}					
					<div class="td txtCenter" data-label="Size">{{ query.size }}</div>
				{% else %}
					<div class="td txtCenter" data-label="Size">N/A</div>				
				{% endif %}
				<div class="td txtCenter" data-label="Price">{{ query.price }}</div>
				<div class="td txtCenter" data-label="Discount">{{ query.discount }}</div>
				<div class="td txtCenter" data-label="Shipping">{{ query.shipingcost }}</div>
				<div class="td txtCenter" data-label="Delete"><a class="cartdel color666" data-id="{{query.id}}" href="#del"><i title="Delete" class="ico-del colorF00"></i></a></div>
			</div>	
		{% endfor %}				
		</div>
	</div>	
	<p class="bgFFF fsmall pad8x">
        {{ submit_button('Continue Shopping','id':'continuebtn','class':'marginAuto neumorphism cursorpoint bold pad4x bgEEE') }}
    {% if shipingcost > 0 %}
        {{ submit_button('Update Shipping','id':'updshipbtn','class':'marginAuto neumorphism cursorpoint bold pad4x bgEEE') }}
    {% else %}
        {{ submit_button('Add Shipping','id':'updshipbtn','class':'marginAuto neumorphism cursorpoint bold pad4x bgEEE') }}        
    {% endif %}
        {{ submit_button('Checkout','id':'checkoutbtn','class':'marginAuto neumorphism cursorpoint bold pad4x bgEEE') }}<br/>
	</p>
	<p id="coupons">
		<label>{{ text_field('coupon','data-id':uid,'class':'','disabled':'disabled') }}</label><br/>
		{{ submit_button('APPLY COUPON','id':'getcoupon','class':'marginAuto neumorphism cursorpoint bold pad4x bgEEE','disabled':'disabled') }}
	</p>
	<div class="bgFFF fsmall txtRight pad8x clrBoth">
        Products Sub Total : BDT <b class="subtotals"><?php echo(number_format($subtotal, 0, '.', '')); ?></b><br/>

		{% if shipingcost > 0 %}
		    Shipping Charge : BDT <b class="shiptotal">{{ shipingcost }}</b>
		{% else %}
		{% set shipingcost = 0 %}
		<strong class="color080">Set Your Delivery Info</strong>
		{% endif %}

	    {% if coupon > 0 %}
	    	<hr/>Coupon Discount: <b>- {{coupon}}</b><hr/> <b class="color080">Grand Total : </b><b class="gtotal colorF00">BDT <?php echo(number_format(($subtotal + $shipingcost) - $coupon, 0, '.', '')); ?></b>
		{% else %}
		    <hr/>
			<b class="color080">Grand Total : </b><b class="gtotal colorF00">BDT <?php echo(number_format($subtotal + $shipingcost, 0, '.', '')); ?></b>
	    {% endif %}
	</div>	
	<p class="bg0d6077 colorFFF bold pad10x footRadius">&nbsp;</p>
{% else %}<p class="bold fsmallcap txtCenter color333">You have no items in your shopping cart!</p>
{% endif %}<div class="loader nodisp fxsmall txtCenter"><img alt="Loader" src="" data-src="img/loading.gif" />Injecting Updates...</div>
	</article>
</section> 
{# End #}{% endblock %}
