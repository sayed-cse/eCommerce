{% extends "layouts/main.volt" %}
{% block content %}
{# Begin #}
<section class="checkouts">
	<article class="checkData">
		<div class="pad5x">
		<dl class="marginB8x zebra brd026 brd1x brdSolid radiusTL radiusTR">
			<dt class="bg026 colorFFF pad8x fSmallcap marginB1x">Products Review</dt>
			{% for query in data %}
			<dd class="checkout zebra color444 fSmall pad8x marginB8x">
			<div class="display-table width100p">
				<div>
					<div>
						<div class="width100x height100x">
							<img alt="" class="width100p height100p" data-src="{{url.getBaseUri('')}}uploads/shop/{{query.color}}" />
						</div>
					</div>
					<div>
						<div>
							<div>Order Id </div>
							<div>Quantity </div>
							{% if query.size !== '0' %}<div>Size </div>{% endif %}
							<div>Price </div>
							{% if not(query.discount is empty) %}<div>Discount Price </div>{% endif %}
							<div>Shipping Charge </div>
						</div>
					</div>
					<div>
						<div>
							<div>:</div>
							<div>:</div>
							{% if query.size !== '0' %}<div>:</div>{% endif %}
							<div>:</div>
							{% if not(query.discount is empty) %}<div>:</div>{% endif %}
							<div>:</div>
						</div>
					</div>
					<div>
						<div>
							<div class="oid">{{query.orderid}}</div>
							<div>{{query.quantity}}</div>
							{% if query.size !== '0' %}<div>{{ query.size }}</div>{% endif %}
							{% if query.discount > 0 %}<div class="txtLine colorF00">{{query.price}}</div>{% else %}<div>{{query.price}}</div>{% endif %}
							{% if not(query.discount is empty) %}<div>{{ query.discount }}</div>{% endif %}
							<div>{{query.shipingcost}}</div>
						</div>
					</div>
				</div>
			</div>
			</dd>
			{% endfor %}
		</dl>
		</div>
		<div class="pad5x">

		<dl class="marginB8x brd026 brd1x brdSolid radiusTL radiusTR">
			<dt class="bg026 colorFFF pad8x fSmallcap fSmall">Billing Address</dt>
			<dd class="bgF5F fSmall pad8x">
			{% for getship in shipping %}
				<strong>Name :</strong> {{getship.fname}}<br/>
				<strong>Phone :</strong> {{getship.sphone}}<br/>
				<strong>Region :</strong> {% for region in regions %}{% if region.rid == getship.sregion %}{{region.regionname}}{% endif %}{% endfor %}<br/>
				<strong>City :</strong> {% for city in citys %}{% if city.cid == getship.scity %}{{city.cityname}}{% endif %}{% endfor %}<br/>
				<strong>Area :</strong> {% for area in areas %}{% if area.aid == getship.sarea %}{{area.areaname}}{% endif %}{% endfor %}<br/>
				<strong>Location :</strong> {{getship.saddress}}<br/><hr/>
				{{submit_button('Change Shipping','id':'updshipbtn','class':'marginA neumorphism cursorPoint width100p bold pad4x bgEEE')}}<br/>
			{% endfor %}
			</dd>
		</dl>
		<dl class="marginB8x brd026 brd1x brdSolid radiusTL radiusTR">
			<dt class="bg026 colorFFF pad8x fSmallcap fSmall">Discount Code</dt>
			<dd class="bgF5F fSmall txtCenter bold colorF00">NA</dd>
		</dl>
		<dl class="marginB8x brd026 brd1x brdSolid radiusTL radiusTR">
			<dt class="bg026 colorFFF fSmallcap fSmall pad8x">Order Summery</dt>
			<dd class="bgF5F color444 fSmall txtCenter pad8x">
				Products Sub Total : BDT <strong class="ptotals"><?php echo(number_format($subtotal, 0, '.', '')); ?></strong><br/>
				Shipping Charge : BDT <strong class="stotal"><?php $res = $shippingcost; echo(number_format($res, 0, '.', '')); ?></strong><br/><hr/>
				<strong class="color080 gtotal">Grand Total : BDT <?php echo(number_format(ceil($subtotal + $res), 2, '.')); ?></strong><hr/>
				{{ submit_button('Confirm & Place Order','id':'orderbtn','class':'marginA neumorphism cursorPoint width100p bold pad4x bgEEE') }}<br/>
			</dd>
		</dl>
		</div>
	</article>
</section>
<section class="checkouts">
	<article class="item">
<!-- 		<dl class="marginB8x zebra brd026 brd1x brdSolid">
			<dt class="bg026 colorFFF pad8x fSmallcap marginB1x">Products Review</dt>
			{% for query in data %}
			<dd class="checkout zebra color444 fSmall pad8x marginB8x">
			<div class="display-table width100p">
				<div>
					<div>
						<div class="width100x height100x">
							<img alt="" class="width100p height100p" data-src="{{url.getBaseUri('')}}uploads/shop/{{query.color}}" />
						</div>
					</div>
					<div>
						<div>
							<div>Order Id </div>
							<div>Quantity </div>
							{% if query.size !== '0' %}<div>Size </div>{% endif %}
							<div>Price </div>
							{% if not(query.discount is empty) %}<div>Discount Price </div>{% endif %}
							<div>Shipping Charge </div>
						</div>
					</div>
					<div>
						<div>
							<div>:</div>
							<div>:</div>
							{% if query.size !== '0' %}<div>:</div>{% endif %}
							<div>:</div>
							{% if not(query.discount is empty) %}<div>:</div>{% endif %}
							<div>:</div>
						</div>
					</div>
					<div>
						<div>
							<div class="oid">{{query.orderid}}</div>
							<div>{{query.quantity}}</div>
							{% if query.size !== '0' %}<div>{{ query.size }}</div>{% endif %}
							{% if query.discount > 0 %}<div class="txtLine colorF00">{{query.price}}</div>{% else %}<div>{{query.price}}</div>{% endif %}
							{% if not(query.discount is empty) %}<div>{{ query.discount }}</div>{% endif %}
							<div>{{query.shipingcost}}</div>
						</div>
					</div>
				</div>
			</div>
			</dd>
			{% endfor %}
		</dl> -->
	</article>
	<article class="item">
<!-- 		<dl class="marginB8x brd026 brd1x brdSolid">
			<dt class="bg026 colorFFF pad8x fSmallcap fSmall">Billing Address</dt>
			<dd class="bgF5F fSmall pad8x">
			{% for getship in shipping %}
				<strong>Name :</strong> {{getship.fname}}<br/>
				<strong>Phone :</strong> {{getship.sphone}}<br/>
				<strong>Region :</strong> {% for region in regions %}{% if region.rid == getship.sregion %}{{region.regionname}}{% endif %}{% endfor %}<br/>
				<strong>City :</strong> {% for city in citys %}{% if city.cid == getship.scity %}{{city.cityname}}{% endif %}{% endfor %}<br/>
				<strong>Area :</strong> {% for area in areas %}{% if area.aid == getship.sarea %}{{area.areaname}}{% endif %}{% endfor %}<br/>
				<strong>Location :</strong> {{getship.saddress}}<br/><hr/>
				{{submit_button('Change Shipping','id':'updshipbtn','class':'marginA neumorphism cursorPoint width100p bold pad4x bgEEE')}}<br/>
			{% endfor %}
			</dd>
		</dl>
		<dl class="marginB8x brd026 brd1x brdSolid">
			<dt class="bg026 colorFFF pad8x fSmallcap fSmall">Discount Code</dt>
			<dd class="bgF5F fSmall txtCenter bold colorF00">NA</dd>
		</dl>
		<dl class="marginB8x brd026 brd1x brdsolid">
			<dt class="bg026 colorFFF fSmallcap fSmall pad8x">Order Summery</dt>
			<dd class="bgF5F color444 fSmall pad8x">
				Products Sub Total : BDT <strong class="ptotals"><?php echo(number_format($subtotal, 0, '.', '')); ?></strong><br/>
				Shipping Charge : BDT <strong class="stotal"><?php $res = $shippingcost; echo(number_format($res, 0, '.', '')); ?></strong><br/><hr/>
				<strong class="color080 gtotal">Grand Total : BDT <?php echo(number_format($subtotal + $res, 0, '.', '')); ?></strong><hr/>
				{{ submit_button('Confirm & Place Order','id':'orderbtn','class':'marginA neumorphism cursorPoint width100p bold pad4x bgEEE') }}<br/>
			</dd>
		</dl>	 -->	
	</article>
</section>{# End #}{% endblock %}

