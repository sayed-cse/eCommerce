{% extends "layouts/main.volt" %}
{% block content %}
{# Begin #}
<section class="row">
	<article class="rc9">
		<dl class="marginB8x zebra brd0d6 brd1x brdsolid">
			<dt class="bg0d6077 colorFFF pad8x fsmallcap marginB1x headRadius">Products Review</dt>
			{% for query in data %}
			<dd class="checkout zebra color444 fsmall pad8x marginB8x">
			<div class="display-table width100p">
				<div class="fxsmall">
					<div>
						<div class="width50x height50x">
							<img alt="" class="width100p height100p" data-src="uploads/shop/{{query.color}}" />
						</div>
					</div>
					<div>
						<div>
							<div>Order Id </div>
							<div>Quantity </div>
						{% if(not(query.size === '0')) %}<div>Size </div>{% endif %}
							<div>Price </div>
						{% if(query.discount > 0) %}<div>Discount Price </div>{% endif %}
							<div>Shipping Charge </div>
						</div>
					</div>
					<div>
						<div>
							<div>:</div>
							<div>:</div>
						{% if(not(query.size === '0')) %}<div>:</div>{% endif %}
							<div>:</div>							
						{% if(query.discount > 0) %}<div>:</div>{% endif %}		
							<div>:</div>
						</div>
					</div>
					<div>
						<div>
							<div class="oid">{{query.orderid}}</div>
							<div>{{query.quantity}}</div>
						{% if (not(query.size === '0')) %}<div>{{query.size}}</div>{% endif %}
							<div>{{query.price}}</div>
						{% if(query.discount > 0) %}<div>{{query.discount}}</div>{% endif %}
							<div>{{query.shipingcost}} BDT</div>
						</div>
					</div>
				</div>
			</div>
			</dd>
			{% endfor %}
			<p class="bg0d6077 colorFFF bold pad10x footRadius">&nbsp;</p>
		</dl>

	</article>
	<article class="rc3">
		<dl class="marginB8x brd025 brd1x brdsolid">
			<dt class="bg025 colorFFF pad8x fsmallcap fsmall">Billing Address</dt>
			<dd class="bgF5F fsmall pad8x">
			{% for getship in shiping %}
				<b>Name :</b> {{getship.fname}}<br/>
				<b>Phone :</b> {{getship.sphone}}<br/>
				<b>Region :</b> {% for region in regions %}{% if region.rid == getship.sregion %}{{region.regionname}}{% endif %}{% endfor %}<br/>
				<b>City :</b> {% for city in citys %}{% if city.cid == getship.scity %}{{city.cityname}}{% endif %}{% endfor %}<br/>
				<b>Area :</b> {% for area in areas %}{% if area.aid == getship.sarea %}{{area.areaname}}{% endif %}{% endfor %}<br/>
				<b>Location :</b> {{getship.saddress}}<br/><hr/>
				{{submit_button('Change Shipping','id':'updshipbtn','class':'marginAuto neumorphism cursorpoint width100p bold pad4x bgEEE')}}<br/>
			{% endfor %}
			</dd>
		</dl>
		<dl class="marginB8x brd025 brd1x brdsolid">
			<dt class="bg025 colorFFF pad8x fsmallcap fsmall">Discount Code</dt>
			<dd class="bgF5F fsmall txtCenter bold colorF00">NA</dd>
		</dl>
		<dl class="marginB8x brd025 brd1x brdsolid">
			<dt class="bg025 colorFFF fsmallcap fsmall pad8x">Order Summery</dt>
			<dd class="bgF5F color444 fsmall pad8x">
				Products Sub Total : BDT <b class="ptotals"><?php echo(number_format($subtotal, 0, '.', '')); ?></b><br/>
				Shipping Charge : BDT <b class="stotal"><?php $res = $shipingcost; echo(number_format($res, 0, '.', '')); ?></b><br/><hr/>
				<b class="color080 gtotal">Grand Total : BDT <?php echo(number_format($subtotal + $res, 0, '.', '')); ?></b><hr/>
				{{ submit_button('Confirm & Place Order','id':'orderbtn','class':'marginAuto neumorphism cursorpoint width100p bold pad4x bgEEE') }}<br/>
			</dd>
		</dl>
	</article>
</section>{# End #}{% endblock %}

