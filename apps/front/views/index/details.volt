{% extends "layouts/main.volt" %}
{% block content %}{# Begin #}
<section class="row bgEEE">
	<article class="rc2">
		<div class="bldh float_left txtLeft">CATEGORY</div>
		<ul class="bldn clrBoth">{% for category in cats %}<li><em><a href="index/Category/{{ category.categoryname }}">{{ category.categoryname }}</a></em></li>{% endfor %}</ul>
	</article>
	<article class="rc10 pad0x">
		<div class="rc4 pad0x">
			<div style="overflow:hidden"><div class="previews" id="NZoomImg" data-NZoomscale="1.5"></div></div>
			<div class="imgline">
{% if (not(adata.pimg_front === 'empty.png')) %}<img alt="Front Side" class="imgkey" src="" data-src="uploads/shop/{{adata.pimg_front}}" />{% endif %}				
{% if (not(adata.pimg_back === 'empty.png')) %}<img alt="Back Side" class="imgkey" src="" data-src="uploads/shop/{{adata.pimg_back}}" />{% endif %}				
{% if (not(adata.pimg_top === 'empty.png')) %}<img alt="Top Side" class="imgkey" src="" data-src="uploads/shop/{{adata.pimg_top}}" />{% endif %}				
{% if (not(adata.pimg_right === 'empty.png')) %}<img alt="Right Side" class="imgkey" src="" data-src="uploads/shop/{{adata.pimg_right}}" />{% endif %}				
{% if (not(adata.pimg_bottom === 'empty.png')) %}<img alt="Bottom Side" class="imgkey" src="" data-src="uploads/shop/{{adata.pimg_bottom}}" />{% endif %}				
{% if (not(adata.pimg_left === 'empty.png')) %}<img alt="Left Side" class="imgkey" src="" data-src="uploads/shop/{{adata.pimg_left}}" />{% endif %}				
			</div>	
<a href="https://facebook.com/share/share.php?u={{url.getBaseUri('')}}index/product/{{adata.id}}">SHARE</a>	
		</div>
		<div class="rc8 fsmall">
			<h1 class="clrBoth color333">{{adata.product_title}}</h1>
			<ul class="rating">
			 	<input type="hidden" name="rat" id="rat-value" value="0"/>
				<li class="ico-star" data-value="1"></li><li class="ico-star" data-value="2"></li><li class="ico-star" data-value="3"></li><li class="ico-star" data-value="4"></li><li class="ico-star" data-value="5"></li>
			</ul>
			<div class="display-table color444">
				<div>
					<div class="txtUpper fxsmall bold">Price</div><div class="pad5x bgEEE brd1x brdsolid brdDDD shade">{% if adata.discount > 0 %}BDT <span class="txt_linethr price color666 txtUpper">{{adata.product_price}}</span>{% else %}BDT <span class="txtUpper bold price fxlarge color444">{{adata.product_price}}</span>{% endif %} / Piece</div>
				</div>
				{% if(adata.discount > 0) %}
				<div>
					<div class="txtUpper fxsmall bold">Discount Price</div><div class="pad5x bgEEE brd1x brdsolid brdDDD shade">BDT <span class="txtUpper bold fxlarge discount color555">{{adata.discount}}</span> / Piece <span class="bgAD0 colorFFF bold"><?php $res = (($adata->product_price - $adata->discount) * 100) / $adata->product_price; echo(number_format($res)); ?>%</span></div>
				</div>
				{% endif %}
				<div>
					<div class="txtUpper fxsmall bold">Type/Color</div><div>
						<ul class="pcolor pad5x">
						{% if (not(adata.pimg_front === 'empty.png')) %}
							<li class="width30x height30x shade" data-value="{{adata.pimg_front}}"><img class="width100p height100p" src="" alt="image-{{adata.product_title}}" data-src="uploads/shop/{{adata.pimg_front}}" /></li>
						{% endif %}
						{% if (not(adata.pimg_back === 'empty.png')) %}	
							<li class="width30x height30x shade" data-value="{{adata.pimg_back}}"><img class="width100p height100p" src="" alt="image-{{adata.product_title}}" data-src="uploads/shop/{{adata.pimg_back}}" /></li>
						{% endif %}
						{% if (not(adata.pimg_left === 'empty.png')) %}	
							<li class="width30x height30x shade" data-value="{{adata.pimg_left}}"><img class="width100p height100p" src="" alt="image-{{adata.product_title}}" data-src="uploads/shop/{{adata.pimg_left}}" /></li>
						{% endif %}	
						{% if (not(adata.pimg_right === 'empty.png')) %}
							<li class="width30x height30x shade" data-value="{{adata.pimg_right}}"><img class="width100p height100p" src="" alt="image-{{adata.product_title}}" data-src="uploads/shop/{{adata.pimg_right}}" /></li>
						{% endif %}
							{% if (not(adata.pimg_top === 'empty.png')) %}
							<li class="width30x height30x shade" data-value="{{adata.pimg_top}}"><img class="width100p height100p" src="" alt="image-{{adata.product_title}}" data-src="uploads/shop/{{adata.pimg_top}}" /></li>
						{% endif %}
						{% if (not(adata.pimg_bottom === 'empty.png')) %}
							<li class="width30x height30x shade" data-value="{{adata.pimg_bottom}}"><img class="width100p height100p" src="" alt="image-{{adata.product_title}}" data-src="uploads/shop/{{adata.pimg_bottom}}" /></li>
						{% endif %}
						</ul>
					</div>
				</div>
				<div>
					<div class="width50p txtUpper fxsmall bold">Size</div><div class="width50p pad5x">
{% if (not(adata.psize === '0')) %}	
				<div>
					<div class="width50p pad5x"><ul class="shopSize"><?php $array = explode(',', $adata->psize); foreach($array as $item){ ?><li class="psize shade"><input class="xSize nodisp" type="radio" name="psize" value="{{item}}">{{item}}</li><?php } ?></ul></div>
				</div>		
{% endif %}	
					</div>
				</div>
				<div>
					<div class="txtUpper fxsmall bold">Quantity</div><div class="pad5x"><span title="Decrement" class="pqty ico-minus cursorpoint brd0x bold"></span><label><input readonly class="qty width50x color444 txtCenter brd0x pad0x" type="number" value="1" /></label><span title="Increment" class="pqty ico-plus cursorpoint brd0x bold"></span></div>
				</div>
				<div class="height10x"></div>
				<div>
					<div class="txtCenter"><button href="index/buynow/{{adata.id}}" class="neumorphism buynow cursorpoint width90p bold pad4x bgEEE" data-id="{{adata.id}}">BUY NOW</button></div><div><button class="neumorphism addcart width90p cursorpoint bold pad4x bgEEE" data-id="{{adata.id}}">ADD TO CART</button></div>
				</div>
				<div class="height10x"></div>
				<div>
					<div class="txtUpper fxsmall bold">VENDOR <span class="color333">[ {{vendor.shopname}} ]</span></div><div class="pad5x">
					<img style="width:60px;height:60px" title="{{vendor.shopname}}" alt="{{vendor.shopname}}" data-src="uploads/users/{{vendor.servicelogo}}" />
					</div>
				</div>	
				<div>
					<div class="txtUpper fxsmall bold">Discount Coupon</div><div><button class="neumorphism width90p cursorpoint bgEEE bold pad4x"><i class="ico-ticket"></i> &nbsp;TK 50.00 GET IT NOW!</button></div>
				</div>	
				<div class="height10x"></div>
				<div class="height10x">{% if (not(uname is empty)) %}{{ hidden_field('shipcharge','data-value':shipingcost) }}{% endif %}</div>
			</div>
		</div>
		<div class="loader nodisp fxsmall txtCenter"><img alt="Loader" src="" data-src="img/loading.gif" />Loading...</div>
	</article>
</section>
<section class="row">
	<article class="rc3"><div class="bg080 colorFFF pad8x fsmall related">Similar Keywords Related Data</div></article>
	<article class="rc9">	
		<div class="fsmall fsmallcap bg080 colorFFF bold pad8x">Product details | Feedback | Shipping &amp; Payment | Seller Guarantees</div>
		{{adata.specification}}
	</article>
</section>{# End #}{% endblock %}


