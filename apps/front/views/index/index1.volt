{% extends "layouts/main.volt" %}{% block content %}{# Begin #}
<section class="row">
	<article class="rc2">
		<div class="bldh float_left txt_left">CATEGORY</div>
        <select id="all" name="all">
        <option value="0">All Products...</option>
            {% for category in cats %}
            <option value="{{category.id}}">{{category.categoryname}}</option>
            {% endfor %}
        </select>		
		<ul class="bldn clr_b">						
		{% for category in cats %}<li><em><a href="{{url.getBaseUri('')}}index/Category/{{ category.categoryname|url_encode }}">{{ category.categoryname }}</a></em></li>{% endfor %}
		</ul>
	</article>
	<article class="rc7">
	<div id="slideshow"><img alt="" src="" data-src="{{url.getBaseUri('')}}uploads/1.png"/></div>	
	</article>
	<article class="rc3"><div>&nbsp;</div></article>
</section>
<section class="row datas">
	<article class="rc12"><div class="pad4x"><h1 class="titleclr">FEATURED</h1></div></article>

{% for product in products %}
{% if product.stage === '2' %}
	<div class="rc2 pad4x"><figure class="product"><a href="{{url.getBaseUri('')}}index/product/{{product.id|url_encode}}">
		<img class="marginAuto txt_center" src="" data-src="{{url.getBaseUri('')}}uploads/shop/{{product.pimg_front}}" alt="{{product.product_title}}" title="{{product.product_title}}"/>
	</a></figure></div>
{% endif %}
{% endfor %}



	<article class="rc12"><div class="pad4x"><h1 class="titleclr">FLASH DEALS</h1></div>
		{% for product in products %}
		{% if product.stage === '3' %}
			<div class="rc2 pad4x">
				<figure class="product">
				<a href="{{url.getBaseUri('')}}index/product/{{product.id|url_encode}}">
					<img class="marginAuto txt_center" src="" data-src="{{url.getBaseUri('')}}uploads/shop/{{product.pimg_front}}" alt="{{product.product_title}}" title="{{product.product_title}}">
					<div class="overlay"><br/>{% if product.discount > 0 %}<h1 class="fxlarge colorF60 txt_center txt_upper">BDT {{product.discount}}</h1><h3 class="txt_linethr colorAAA txt_center txt_upper">BDT {{product.product_price}}</h3>{% else %}<h1 class="fxlarge colorF60 txt_center txt_upper">BDT {{product.product_price}}</h1>{% endif %}<br/>
				{% if(product.discount > 0) %}<div class="discountp"><?php $res = (($product->product_price - $product->discount) * 100) / $product->product_price; echo('-'.number_format($res)); ?>%</div>{% endif %}
					<br/><div class="detailbtn">VIEW DETAILS</div>
					</div>
				</a>
				</figure>
			</div>
		{% endif %}
		{% endfor %}
	</article>
	<article class="rc12"><div class="pad4x"><h1 class="titleclr2">MORE TO LOVE</h1></div>
		{% for product in products %}
		{% if product.stage === '4' %}
			<div class="rc2 pad4x">
				<figure class="product">
				<a href="{{url.getBaseUri('')}}index/product/{{product.id|url_encode}}">
					<img class="marginAuto txt_center" src="" data-src="{{url.getBaseUri('')}}uploads/shop/{{product.pimg_front}}" alt="{{product.product_title}}" title="{{product.product_title}}">
					<div class="overlay"><br/>{% if product.discount > 0 %}<h1 class="fxlarge colorF60 txt_center txt_upper">BDT {{product.discount}}</h1><h3 class="txt_linethr colorAAA txt_center txt_upper">BDT {{product.product_price}}</h3>{% else %}<h1 class="fxlarge colorF60 txt_center txt_upper">BDT {{product.product_price}}</h1>{% endif %}<br/>
				{% if(product.discount > 0) %}<div class="discountp"><?php $res = (($product->product_price - $product->discount) * 100) / $product->product_price; echo('-'.number_format($res)); ?>%</div>{% endif %}
					<br/><div class="detailbtn">VIEW DETAILS</div>
					</div>
				</a>
				</figure>
			</div>
		{% endif %}	
		{% endfor %}
	</article>	
	<article class="rc12"><div class="pad4x"><h1 class="titleclr3">INSPIRATION</h1></div>
{#
		{% for product in products %}
		{% if product.stage === '4' %}
			<div class="rc2 pad4x">
				<figure class="product">
				<a href="{{url.getBaseUri('')}}index/product/{{product.id|url_encode}}">
					<img class="marginAuto txt_center" src="" data-src="{{url.getBaseUri('')}}uploads/shop/{{product.pimg_front}}" alt="{{product.product_title}}" title="{{product.product_title}}">
					<div class="overlay"><br/>{% if product.discount > 0 %}<h1 class="fxlarge colorF60 txt_center txt_upper">BDT {{product.discount}}</h1><h3 class="txt_linethr colorAAA txt_center txt_upper">BDT {{product.product_price}}</h3>{% else %}<h1 class="fxlarge colorF60 txt_center txt_upper">BDT {{product.product_price}}</h1>{% endif %}<br/>
				{% if(product.discount > 0) %}<div class="discountp"><?php $res = (($product->product_price - $product->discount) * 100) / $product->product_price; echo('-'.number_format($res)); ?>%</div>{% endif %}
					<br/><div class="detailbtn">VIEW DETAILS</div>
					</div>
				</a>
				</figure>
			</div>
		{% endif %}	
		{% endfor %}
#}
<?php foreach ($default->getItems() as $item) { ?>
<div class="rc2 pad4x">
	<figure class="product">
	<a href="{{url.getBaseUri('')}}index/product/{{item.id|url_encode}}">
		<img class="marginAuto txt_center" src="" data-src="{{url.getBaseUri('')}}uploads/shop/{{item.pimg_front}}" alt="{{item.product_title}}" title="{{item.product_title}}">
		<div class="overlay"><br/>{% if item.discount > 0 %}<h1 class="fxlarge colorF60 txt_center txt_upper">BDT {{item.discount}}</h1><h3 class="txt_linethr colorAAA txt_center txt_upper">BDT {{item.product_price}}</h3>{% else %}<h1 class="fxlarge colorF60 txt_center txt_upper">BDT {{item.product_price}}</h1>{% endif %}<br/>
	{% if(item.discount > 0) %}<div class="discountp"><?php $res = (($item->product_price - $item->discount) * 100) / $item->product_price; echo('-'.number_format($res)); ?>%</div>{% endif %}
		<br/><div class="detailbtn">VIEW DETAILS</div>
		</div>
	</a>
	</figure>
</div>
<?php } ?><br/>
<a href="index">|&lt;</a>
<a href="index?default=<?php echo $default->getPrevious(); ?>">&lsaquo;</a>
<?php echo "Page {$default->getCurrent()}  of {$default->getLast()}"; ?>
<a href="index?default=<?php echo $default->getNext(); ?>">&rsaquo;</a>
<a href="index?default=<?php echo $default->getLast(); ?>">&gt;|</a>
	</article>
</section>{# End #}{% endblock %}