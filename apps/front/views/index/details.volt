{% extends "layouts/main.volt" %}
{% block content %}{# Begin #}
<section itemscope itemtype="https://schema.org/Details" class="detailsData">
	<article class="lmenu">
		<div itemprop="image" class="prevData bgEEE">
			<figure class="zoom"></figure>
			<div class="imgline">
				{% if (not(adata.pimg_front is 'empty.png')) %}<img class="imgkey" alt="{{adata.product_title}}" src="{{url.getBaseUri('')}}uploads/shop/{{adata.pimg_front}}" data-src="{{url.getBaseUri('')}}uploads/shop/{{adata.pimg_front}}" />{% endif %}
				{% if (not(adata.pimg_back is 'empty.png')) %}<img class="imgkey" alt="{{adata.product_title}}" src="" data-src="{{url.getBaseUri('')}}uploads/shop/{{adata.pimg_back}}" />{% endif %}
				{% if (not(adata.pimg_top is 'empty.png')) %}<img class="imgkey" alt="{{adata.product_title}}" src="" data-src="{{url.getBaseUri('')}}uploads/shop/{{adata.pimg_top}}" />{% endif %}
				{% if (not(adata.pimg_right is 'empty.png')) %}<img class="imgkey" alt="{{adata.product_title}}" src="" data-src="{{url.getBaseUri('')}}uploads/shop/{{adata.pimg_right}}" />{% endif %}
				{% if (not(adata.pimg_bottom is 'empty.png')) %}<img class="imgkey" alt="{{adata.product_title}}" src="" data-src="{{url.getBaseUri('')}}uploads/shop/{{adata.pimg_bottom}}" />{% endif %}
				{% if (not(adata.pimg_left is 'empty.png')) %}<img class="imgkey" alt="{{adata.product_title}}" src="" data-src="{{url.getBaseUri('')}}uploads/shop/{{adata.pimg_left}}" />{% endif %}
			</div>
		</div>
	</article>
	<article class="rdata">
<?php
$ratings = Array(1 => $ratingA, 2 => $ratingB, 3 => $ratingC, 4 => $ratingD, 5 => $ratingE);
$max = $n = 0;
foreach ($ratings as $rate => $count) { $max += $rate * $count; $n += $count; }
if($max > 0 || $n > 0){ $avg = ceil($max / $n); }else{$avg = 0;}
$scaleE = ($ratingE > 0 ) ? $ratingE / 5 : $ratingE;
$scaleD = ($ratingD > 0 ) ? $ratingD / 5 : $ratingD;
$scaleC = ($ratingC > 0 ) ? $ratingC / 5 : $ratingC;
$scaleB = ($ratingB > 0 ) ? $ratingB / 5 : $ratingB;
$scaleA = ($ratingA > 0 ) ? $ratingA / 5 : $ratingA;
?>			
		<div itemprop="description" class="sim bgEEE pad5x">
			<div class="display-table width100p height100p bgEEE">
				<h1 itemprop="name" class="clrB color333 fLarge">{{adata.product_title}}</h1>
				<ul itemscope itemprop="aggregateRating" itemtype="https://schema.org/AggregateRating" class="rating">
					<input itemprop="ratingValue" type="hidden" id="avgRating" value="<?php echo($avg); ?>">
					<li itemprop="ratingCount" class="ico-star colorCCC rateA" data-value="1"></li>
					<li itemprop="ratingCount" class="ico-star colorCCC rateB" data-value="2"></li>
					<li itemprop="ratingCount" class="ico-star colorCCC rateC" data-value="3"></li>
					<li itemprop="ratingCount" class="ico-star colorCCC rateD" data-value="4"></li>
					<li itemprop="ratingCount" class="ico-star colorCCC rateE" data-value="5"></li>
				</ul>
				<div>
					<div class="txtUpper fxSmall bold">Price</div><div itemprop="price" class="pad5x bgEEE brd1x brdSolid brdDDD shade">{% if adata.discount > 0 %}BDT <span class="txtLine price colorAAA txtUpper">{{adata.product_price}}</span>{% else %}BDT <span class="txtUpper bold price fxLarge colorDDD">{{adata.product_price}}</span>{% endif %} / Piece</div>
				</div>
				{% if(adata.discount > 0) %}
				<div>
					<div class="txtUpper fxSmall bold">Discount Price</div><div class="pad5x bgEEE brd1x brdSolid brdDDD shade">BDT <span itemprop="discount" class="txtUpper bold fxLarge discount colorAAA">{{adata.discount}}</span> / Piece <mark><?php $res = (($adata->product_price - $adata->discount) * 100) / $adata->product_price; echo('-'.number_format($res)); ?>%</mark></div>
				</div>
				{% endif %}
				<div>
					<div class="txtUpper fxSmall bold">Type/Color</div><div>
						<ul class="pcolor pad5x">
						{% if (not(adata.pimg_front is 'empty.png')) %}
							<li class="width30x height30x shade" data-value="{{adata.pimg_front}}"><img class="width100p height100p" src="" alt="image-{{adata.product_title}}" data-src="{{url.getBaseUri('')}}uploads/shop/{{adata.pimg_front}}" /></li>{% endif %}
						{% if (not(adata.pimg_back is 'empty.png')) %}	
							<li class="width30x height30x shade" data-value="{{adata.pimg_back}}"><img class="width100p height100p" src="" alt="image-{{adata.product_title}}" data-src="{{url.getBaseUri('')}}uploads/shop/{{adata.pimg_back}}" /></li>{% endif %}
						{% if (not(adata.pimg_left is 'empty.png')) %}	
							<li class="width30x height30x shade" data-value="{{adata.pimg_left}}"><img class="width100p height100p" src="" alt="image-{{adata.product_title}}" data-src="{{url.getBaseUri('')}}uploads/shop/{{adata.pimg_left}}" /></li>{% endif %}
						{% if (not(adata.pimg_right is 'empty.png')) %}	
							<li class="width30x height30x shade" data-value="{{adata.pimg_right}}"><img class="width100p height100p" src="" alt="image-{{adata.product_title}}" data-src="{{url.getBaseUri('')}}uploads/shop/{{adata.pimg_right}}" /></li>{% endif %}
						{% if (not(adata.pimg_top is 'empty.png')) %}	
							<li class="width30x height30x shade" data-value="{{adata.pimg_top}}"><img class="width100p height100p" src="" alt="image-{{adata.product_title}}" data-src="{{url.getBaseUri('')}}uploads/shop/{{adata.pimg_top}}" /></li>{% endif %}
						{% if (not(adata.pimg_bottom is 'empty.png')) %}	
							<li class="width30x height30x shade" data-value="{{adata.pimg_bottom}}"><img class="width100p height100p" src="" alt="image-{{adata.product_title}}" data-src="{{url.getBaseUri('')}}uploads/shop/{{adata.pimg_bottom}}" /></li>{% endif %}
						</ul>
					</div>
				</div>
			{% if (not(adata.psize === '0')) %}				
				<div>
					<div class="txtUpper fxSmall bold">Scale</div>
					<div class="pad5x">	
						<div class="pad5x"><ul class="shopSize"><?php $array = explode(',', $adata->psize); foreach($array as $item){ ?><li class="psize shade"><input class="xSize nodisp" type="radio" name="psize" value="{{item}}">{{item}}</li><?php } ?></ul></div>	
					</div>
				</div>
			{% endif %}				
			{% if not(adata.pweight is '0' ) %}
				<div>
					<div class="txtUpper fxSmall bold">Weight</div>
					<div class="pad5x">
						<div class="pad5x"><ul class="shopSize"><?php $array = explode(',', $adata->pweight); foreach($array as $item){ ?><li class="psize shade"><input class="xSize nodisp" type="radio" name="psize" value="{{item}}">{{item}}</li><?php } ?></ul></div>
					</div>
				</div>
			{% endif %}						
				<div>
					<div class="txtUpper fxSmall bold">Quantity</div><div class="pad5x"><span title="Decrement" class="pqty ico-minus cursorPoint brd0x bold"></span><input readonly class="qty width50x color666 txtCenter brd0x pad0x" type="number" value="1" aria-label="counter"/><span title="Increment" class="pqty ico-plus cursorPoint brd0x bold"></span></div>
				</div>
				<div>
					<div class="txtUpper fxSmall bold">Sold By</div>
					<div class="pad5x">
						{% for vendor in vendors %}
							{% if vendor.id === adata.shopid %}
							<a href="{{url.getBaseUri('')}}index/vendor/{{adata.shopid}}"><img alt="" class="floatL width50x height50x clrB" data-src="{{url.getBaseUri('')}}uploads/users/{{vendor.servicelogo|url_encode}}"/> &nbsp;[ {{vendor.name}} ]</a><br/>
							{% endif %}
						{% endfor %}
					</div>
				</div>			
				<div class="height10x"></div>
				<div>
					<input type="hidden" id="shopid" name="shopid" data-value="{{adata.shopid}}"/>
					<div class="txtUpper fxSmall bold">P-CODE: <span class="color080">[{% if (not(adata.pcode is empty)) %} {{adata.pcode}}{% else %} N / A{% endif %} ]</span></div><div><button href="{{url.getBaseUri('')}}index/buynow/{{adata.id}}" class="neumorphism buynow cursorPoint width90p bold pad4x bgEEE" data-id="{{adata.id}}">BUY NOW</button> <button class="neumorphism addcart width90p cursorPoint bold pad4x bgEEE" data-id="{{adata.id}}">ADD TO CART</button></div>
				</div>
				<div class="height10x">&nbsp;</div>
				<div>
					<div class="txtUpper fxSmall bold">Discount Coupon</div><div><button class="neumorphism width90p cursorPoint bgEEE bold pad4x color080"><i class="ico-ticket"></i> &nbsp;TK 50.00 GET IT NOW!</button> <?php if($adata->stock === 0){echo('<strong class="colorF00">[ STOCK OUT ]</strong>');} ?></div>
				</div>						
				<div class="height10x">
				{% if (not(uname is empty)) %}{{ hidden_field('shipcharge','data-value':shippingcost) }}{% endif %}
				</div>
			</div>
		</div>
	</article>	
</section>
<section class="detailsData">
	<article class="pad5x">
		<div class="fSmall fSmallcap bg080 colorFFF bold pad8x marginB8x">People Who Viewed This</div>
		<div class="similar">
		{% for similar in similars %}
            <a class="sim clrB" title="{{similar.product_title}}" href="{{url.getBaseUri('')}}index/product/<?php echo(urlencode(base64_encode($similar->product_title)));?>"> <div class="fxSmall">
            <figure class="floatL width20p height100p"><img alt="" data-src="{{url.getBaseUri('')}}uploads/shop/{{similar.pimg_front}}"/></figure>
            <div class="floatL txtCenter width80p height100p">
            <?php echo $similar->product_title; ?>
<ul class="rating txtCenter fxxSmall">
    <li class="ico-star color360 rateA" data-value="1"></li><li class="ico-star color360 rateB" data-value="2"></li><li class="ico-star color360 rateC" data-value="3"></li><li class="ico-star color360 rateD" data-value="4"></li><li class="ico-star color360 rateE" data-value="5"></li>
</ul>
        {% if similar.discount > 0 %}<h2 class="fxSmall color000 txtCenter txtUpper"> {{similar.discount}} &#124; <span class="colorAAA txtLine">{{similar.product_price}}</span></h2>{% else %}<h2 class="fxSmall color000 txtCenter txtUpper"> {{similar.product_price}}</h2>{% endif %}
            </div>
            </div></a>
		{% endfor %}
		</div>		
	</article>
	<article class="pad4x">
		<div class="fSmall fSmallcap bg080 colorFFF bold pad8x marginB8x">Product details | Shipping &amp; Payment | Seller Guarantees | Reviews | Terms &amp; Conditions</div>
		<div class="similar">

		<details>
		  <summary>Details &gt;</summary>
		  <p class="pad8x">{{adata.specification}}</p>
		</details>

		<details>
		  <summary>Delivery &amp; Payment Options &gt;</summary>
			<p class="pad8x">Inside Dhaka - 80 Taka (3-4 Working Days)</p>
			<p class="pad8x">Outside Dhaka - 150 Taka (4-5 Working Days)</p>
		  	<p class="pad8x bold">[ Cash on delivery ]</p>
		  	<p class="pad8x">Added TK10/= will be applicable over delivery fee for cash on delivery service.</p>
			<p class="pad8x bold">[ Use Merchant ]</p>
			<p class="pad8x">SSLCOMMERZ Secure Payment (Visa, Master, Amex, Bkash, Rocket etc.)</p>
			<p class="pad8x">Bkash, Nagad, Rocket Merchant Number Payment is also available </p>
		</details>

		<details>
		<summary>Sellers Guarantee / Warranty &gt;</summary>
			{% if (not(adata.warranty is empty)) %}
				<?php $warranty = match($adata->warranty){
					'1' => '7 days replacement guarantee.',
					'2' => '15 days replacement guarantee.',
					'3' => '1 month service warranty.',
					'4' => '3 months service warranty.',
					'5' => '6 months service warranty.',
					'6' => '1 year service warranty.',
					'7' => '3 days Full Refund.',
					'8' => '1 Month Full Refund.',								
				};?>
				<p class="pad8x">{{warranty}}</p>
			{% else %}
				<p class="pad8x">This product have no Guarantee / Warranty! from seller.</p>		
			{% endif %}
		</details>

		<p id="rating">
			<i class="star colorCCC ico-star" data-value="1"></i><i class="star colorCCC ico-star" data-value="2"></i><i class="star colorCCC ico-star" data-value="3"></i><i class="star colorCCC ico-star" data-value="4"></i><i class="star colorCCC ico-star" data-value="5"></i>[ {{avg}} / 5 ]
			<input type="hidden" name="rating" id="rat-value" value=""/><input type="hidden" name="pid" id="pid" value="{{adata.id}}"/>
		</p>

		<div id="ratings" class="display-table">
			<div>
				<div><i class="circlestar color080"></i><i class="circlestar color080"></i><i class="circlestar color080"></i><i class="circlestar color080"></i><i class="circlestar color080"></i> </div>
				<div>&nbsp;<meter id="ratingD" value="<?php echo($scaleE); ?>" max="5"></meter>&nbsp;[ {{ratingE}} ]</div>
			</div>
			<div>
				<div></i><i class="circlestar color080"></i><i class="circlestar color080"></i><i class="circlestar color080"></i><i class="circlestar color080"></i><i class="circlestar colorAAA"></i></div>
				<div>&nbsp;<meter id="ratingD" value="<?php echo($scaleD); ?>" max="5"></meter>&nbsp;[ {{ratingD}} ]</div>
			</div>
			<div>
				<div><i class="circlestar color080"></i><i class="circlestar color080"></i><i class="circlestar color080"></i><i class="circlestar colorAAA"></i><i class="circlestar colorAAA"></i></div>
				<div>&nbsp;<meter id="ratingC" value="<?php echo($scaleC); ?>" max="5"></meter>&nbsp;[ {{ratingC}} ]</div>
			</div>
			<div>
				<div><i class="circlestar color080"></i><i class="circlestar color080"></i><i class="circlestar colorAAA"></i><i class="circlestar colorAAA"></i><i class="circlestar colorAAA"></i></div>
				<div>&nbsp;<meter id="ratingB" value="<?php echo($scaleB); ?>" max="5"></meter>&nbsp;[ {{ratingB}} ]</div>
			</div>
			<div>
				<div><i class="circlestar color080"></i><i class="circlestar colorAAA"></i><i class="circlestar colorAAA"></i><i class="circlestar colorAAA"></i><i class="circlestar colorAAA"></i></div>
				<div>&nbsp;<meter id="ratingA" value="<?php echo($scaleA); ?>" max="5"></meter>&nbsp;[ {{ratingA}} ]</div>
			</div>
		</div>

		</div>
	</article>
</section>
<p class="loader nodisp fxSmall txtCenter"><img alt="Loader" src="" data-src="{{url.getBaseUri('')}}img/loading.gif" />Injecting Updates...</p>

{# End #}{% endblock %}


