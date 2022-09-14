{% extends "layouts/main.volt" %}{% block content %}{# Begin #}
<section class="row">
	<article class="rc2">
		<div class="bldh float_left txtLeft">CATEGORY</div>
		<ul class="bldn clrBoth">						
		{% for category in cats %}<li><em><a href="{{url.getBaseUri('')}}index/Category/{{ category.categoryname }}">{{ category.categoryname }}</a></em></li>{% endfor %}
		</ul>
	</article>
	<article class="rc7">
	<figure><img class="bannerImg" itemprop="image" width="729px" height="290px" alt="" src="" data-src="{{url.getBaseUri('')}}uploads/1.webp"/></figure>
	</article>
	<article class="rc3"><div class="rItems">&nbsp;</div></article>
</section>
<section class="row datas">
	<article class="rc12"><div class="pad4x"><h1 class="titleclr">FEATURED</h1></div></article>
		{% for product in products %}
		{% if product.stage === '2' %}
			<div class="rc2 pad4x">
				<figure class="product">
				<a href="{{url.getBaseUri('')}}index/product/{{product.id}}">
					<img itemprop="image" class="marginAuto txtCenter" src="" data-src="{{url.getBaseUri('')}}uploads/shop/{{product.pimg_front}}" alt="{{product.product_title}}" title="{{product.product_title}}">
					<div class="overlay"><br/>{% if product.discount > 0 %}<h1 class="fxlarge colorF60 txtCenter txtUpper">BDT {{product.discount}}</h1><h2 class="txt_linethr colorAAA txtCenter txtUpper">BDT {{product.product_price}}</h2>{% else %}<h3 class="fxlarge colorF60 txtCenter txtUpper">BDT {{product.product_price}}</h3>{% endif %}<br/>
				{% if(product.discount > 0) %}<div class="discountp"><?php $res = (($product->product_price - $product->discount) * 100) / $product->product_price; echo(number_format($res)); ?>%</div>{% endif %}
					</div>
				</a>
				</figure>
			</div>
		{% endif %}
		{% endfor %}			
	<article class="rc12"><div class="pad4x"><h1 class="titleclr">FLASH DEALS</h1></div>
		{% for product in products %}
		{% if product.stage === '3' %}
			<div class="rc2 pad4x">
				<figure class="product">
				<a href="{{url.getBaseUri('')}}index/product/{{product.id}}">
					<img itemprop="image" class="marginAuto txtCenter" src="" data-src="{{url.getBaseUri('')}}uploads/shop/{{product.pimg_front}}" alt="{{product.product_title}}" title="{{product.product_title}}">
					<div class="overlay"><br/>{% if product.discount > 0 %}<h1 class="fxlarge colorF60 txtCenter txtUpper">BDT {{product.discount}}</h1><h2 class="txt_linethr colorAAA txtCenter txtUpper">BDT {{product.product_price}}</h2>{% else %}<h1 class="fxlarge colorF60 txtCenter txtUpper">BDT {{product.product_price}}</h1>{% endif %}<br/>
				{% if(product.discount > 0) %}<div class="discountp"><?php $res = (($product->product_price - $product->discount) * 100) / $product->product_price; echo(number_format($res)); ?>%</div>{% endif %}
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
				<a href="{{url.getBaseUri('')}}index/product/{{product.id}}">
					<img itemprop="image" class="marginAuto txtCenter" src="" data-src="{{url.getBaseUri('')}}uploads/shop/{{product.pimg_front}}" alt="{{product.product_title}}" title="{{product.product_title}}">
					<div class="overlay"><br/>{% if product.discount > 0 %}<h1 class="fxlarge colorF60 txtCenter txtUpper">BDT {{product.discount}}</h1><h2 class="txt_linethr colorAAA txtCenter txtUpper">BDT {{product.product_price}}</h2>{% else %}<h1 class="fxlarge colorF60 txtCenter txtUpper">BDT {{product.product_price}}</h1>{% endif %}<br/>
				{% if(product.discount > 0) %}<div class="discountp"><?php $res = (($product->product_price - $product->discount) * 100) / $product->product_price; echo(number_format($res)); ?>%</div>{% endif %}
					</div>
				</a>
				</figure>
			</div>
		{% endif %}	
		{% endfor %}
	</article>	
	<article class="rc12"><div class="pad4x"><h1 class="titleclr3">INSPIRATION</h1></div>
		{% for product in products %}
		{% if product.stage === '1' %}
			<div class="rc2 pad4x">
				<figure class="product">
				<a href="{{url.getBaseUri('')}}index/product/{{product.id}}">
					<img itemprop="image" class="marginAuto txtCenter" src="" data-src="{{url.getBaseUri('')}}uploads/shop/{{product.pimg_front}}" alt="{{product.product_title}}" title="{{product.product_title}}">
					<div class="overlay"><br/>{% if product.discount > 0 %}<h1 class="fxlarge colorF60 txtCenter txtUpper">BDT {{product.discount}}</h1><h2 class="txt_linethr colorAAA txtCenter txtUpper">BDT {{product.product_price}}</h2>{% else %}<h1 class="fxlarge colorF60 txtCenter txtUpper">BDT {{product.product_price}}</h1>{% endif %}<br/>
				{% if(product.discount > 0) %}<div class="discountp"><?php $res = (($product->product_price - $product->discount) * 100) / $product->product_price; echo(number_format($res)); ?>%</div>{% endif %}
					</div>
				</a>
				</figure>
			</div>
		{% endif %}			
		{% endfor %}
	</article>
</section>{# End #}{% endblock %}