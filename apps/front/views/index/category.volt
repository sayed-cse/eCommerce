{% extends "layouts/main.volt" %}{% block content %}{# Begin #}
<section class="row">
    <article class="rc2">
        <div class="bldh float_left txtLeft">CATEGORY</div>
        <ul class="bldn clr_b">                     
        {% for category in cats %}<li><em><a href="index/Category/{{ category.categoryname }}">{{ category.categoryname }}</a></em></li>{% endfor %}
        </ul>
    </article>
    <article class="rc7">
    <div id="slideshow"><img alt="" data-src="uploads/1.png"></div>
    <div class="data">
        <ul class="scroller">
            <li class="item"><a title="Codeigniter &amp; Phalcon" data-href="#1" href="index/newsload/1">
            <img class="clr_b marginAuto" data-src="uploads/shop.jpg" alt="Image Codeigniter &amp; Phalcon" /></a></li>
            <li class="item"><a title="Laravel" data-href="#2" href="index/newsload/2">
            <img class="clr_b marginAuto" data-src="uploads/shop2.jpg" alt="Image Laravel" />           </a></li>
            <li class="item"><a title="Phalcon fastest php Framework" data-href="#3" href="index/newsload/3">
            <img class="clr_b marginAuto" data-src="uploads/shop.jpg" alt="Image Phalcon fastest php Framework" /></a></li>
            <li class="item"><a title="Linux Server with Squid" data-href="#4" href="index/newsload/4">
            <img class="clr_b marginAuto" data-src="uploads/shop2.jpg" alt="Image Linux Server with Squid" /></a></li>
            <li class="item"><a title="Worlds Best Samba Dance" data-href="#5" href="index/newsload/5">
            <img class="clr_b marginAuto" data-src="uploads/shop.jpg" alt="Image Worlds Best Samba Dance" /></a></li>
        </ul>
        <p class="float_right"><button id="prev">&lsaquo;</button><button id="next">&rsaquo;</button></p>                   
    </div>  
    </article>
    <article class="rc3"><div class=""><img data-src="uploads/rrs.png" alt=""></div></article>
</section>
<section class="row datas">
    <article class="rc12">
{% for datax in data %}
<?php 
$products = $this->modelsManager->executeQuery("SELECT * FROM F\Front\Models\Products WHERE F\Front\Models\Products.category_id = $datax->id"); 
foreach($products as $p){ ?>
    <div class="rc2 pad4x">
        <figure class="product">
        <a href="index/product/{{p.id}}">
            <img class="marginAuto txtCenter" data-src="uploads/shop/{{p.pimg_front}}" alt="{{p.product_title}}" title="{{p.product_title}}">
            <div class="overlay"><br/>{% if p.discount > 0 %}<h1 class="fxlarge colorF60 txtCenter txtUpper">BDT {{p.discount}}</h1><h3 class="txt_linethr colorAAA txtCenter txtUpper">BDT {{p.product_price}}</h3>{% else %}<h1 class="fxlarge colorF60 txtCenter txtUpper">BDT {{p.product_price}}</h1>{% endif %}<br/>
        {% if(p.discount > 0) %}<div class="discountp"><?php $res = (($p->product_price - $p->discount) * 100) / $p->product_price; echo('-'.number_format($res)); ?>%</div>{% endif %}
            </div>
        </a>
        </figure>
    </div>
<?php } ?>
{% else %}
No Data Found
{% endfor %}
    </article>
</section>{# End #}{% endblock %}