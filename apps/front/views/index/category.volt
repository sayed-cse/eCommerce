{% extends "layouts/main.volt" %}{% block content %}{# Begin #}
<section class="row">
    <article class="ads">&nbsp;</article>
   <article class="inspire">
        {% for datax in data %}
    <?php 
    $products = $this->modelsManager->executeQuery("SELECT id,product_title,pimg_front,discount,product_price FROM F\Front\Models\Products WHERE F\Front\Models\Products.category_id = $datax->id"); 
    foreach($products as $p){ ?>
        <a href="{{url.getBaseUri('')}}index/product/<?php echo(urlencode(base64_encode($p->product_title)));?>">
            <div class="pdata">
            <figure><img class="marginA" src="" data-src="{{url.getBaseUri('')}}uploads/shop/{{p.pimg_front}}" alt="{{p.product_title}}" title="{{p.product_title}}"></figure>
                <figcaption class="fxSmall txtCenter"><?php echo(strlen($p->product_title) > 30 ? substr($p->product_title,0,30) : $p->product_title); ?></figcaption>

            <?php if($p->discount > 0){?>
                <h2 class="fxxSmall colorF06 txtCenter txtUpper pad1x"> 
                <?php echo($p->discount);?> &#124; <span class="colorAAA txtLine"><?php echo($p->product_price);?></span></h2>
                <?php }else{ ?><h2 class="fxxSmall colorF06 txtCenter txtUpper pad1x"> <?php echo($p->product_price);?>
                </h2>
            <?php } ?>

                <ul class="rating txtCenter fxxSmall">
                    <li class="ico-star rateA" data-value="1"></li><li class="ico-star rateB" data-value="2"></li><li class="ico-star rateC" data-value="3"></li><li class="ico-star rateD" data-value="4"></li><li class="ico-star rateE" data-value="5"></li>
                </ul>
                <p class="pbtn fSmall txtCenter pad1x">{% if(p.discount > 0) %}<mark><?php $res = (($p->product_price - $p->discount) * 100) / $p->product_price; echo('-'.number_format($res)); ?>%</mark>{% else %}&nbsp;{% endif %}</p>
            </div>
         </a>
    <?php } ?>
        {% endfor %}
    </article>
    <article class="ads">&nbsp;</article>   
</section>
{# End #}{% endblock %}
