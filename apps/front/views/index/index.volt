{% extends "layouts/main.volt" %}{% block content %}{# Begin #}
<section class="menuSlide">
    <nav class="lmenu">
        <div class="navMenu">
            {% for category in cats %}<em><a href="{{url.getBaseUri('')}}index/Category/{{ category.categoryname|url_encode }}">{{ category.categoryname }}</a></em>{% endfor %}
        </div>
    </nav>
    <article class="pad5x">
        <img class="bannerImg brd1x brdSolid brdDDD marginB8x" fetchpriority="high" loading="auto" alt="Banner" src="{{url.getBaseUri('')}}uploads/siteBanner.jpg" data-src="{{url.getBaseUri('')}}uploads/siteBanner.jpg"/>
        <div class="brd1x brdSolid brdDDD autoHeight maxHeight100x"/>&nbsp;</div>
    </article>
    <article class="pad5x">
        <div class="brd1x brdSolid brdDDD marginB8x height100x">&nbsp;</div>
        <div class="brd1x brdSolid brdDDD marginB8x height100x">&nbsp;</div>
        <div class="brd1x brdSolid brdDDD marginB8x height100x">&nbsp;</div>
        <div class="brd1x brdSolid brdDDD height100x">&nbsp;</div>
    </article>
</section>
<section class="row"><article class="row bgEEE bold pad10x margin4x brdDDD brd1x brdSolid">FEATURED</article></section>

<section class="feature">
    <?php foreach ($pstage2->getItems() as $p2): ?>
            <a href="{{url.getBaseUri('')}}index/product/<?php echo(urlencode(base64_encode($p2->product_title)));?>">
        <div class="pdata">
            <figure>
    <?php if(file_exists('uploads/shop/'.$p2->pimg_front)){ ?>
        <img class="marginA <?php if($p2->stock === 0){echo('ImFilter');} ?>" src="" data-src="{{url.getBaseUri('')}}uploads/shop/{{p2.pimg_front}}" alt="{{p2.product_title}}" title="{{p2.product_title}}">
    <?php }else{ ?>
        <img class="marginA" src="" data-src="{{url.getBaseUri('')}}img/empty.png" alt="{{p2.product_title}}" title="{{p2.product_title}}">
    <?php } ?>
            </figure>
            <figcaption class="fxSmall txtCenter"><?php echo(strlen($p2->product_title) > 30 ? substr($p2->product_title,0,30) : $p2->product_title); ?></figcaption>
                <div class="pprice txtCenter">
{% if p2.discount > 0 %}<h2 class="fxSmall color000 txtCenter txtUpper pad1x"> {{p2.discount}} &#124; <span class="color333 txtLine">{{p2.product_price}}</span></h2>{% else %}<h2 class="fxSmall color000 txtCenter txtUpper pad1x"> {{p2.product_price}}</h2>{% endif %}
                </div>
<ul class="rating txtCenter fxxSmall">
    <li class="ico-star rateA" data-value="1"></li><li class="ico-star rateB" data-value="2"></li><li class="ico-star rateC" data-value="3"></li><li class="ico-star rateD" data-value="4"></li><li class="ico-star rateE" data-value="5"></li>
</ul>
<p class="pbtn fSmall txtCenter pad1x">{% if(p2.discount > 0) %}<mark><?php $res = (($p2->product_price - $p2->discount) * 100) / $p2->product_price; echo('-'.number_format($res)); ?>%</mark>{% else %}&nbsp;{% endif %}</p>
        </div></a>
    <?php endforeach; ?>
</section>
<section class="ads brd1x brdSolid brdDDD height100x"><div class="txtCenter bold">ADS HERE</div></section>
<section class="row"><article class="row bgEEE bold pad10x margin4x brdDDD brd1x brdSolid">FLASH DEAL</article></section>
<section class="flash">
    <article class="steps">
        <?php foreach($fp as $fl){ ?>
            <a class="sim clrB" title="{{fl.product_title}}" href="{{url.getBaseUri('')}}index/product/<?php echo(urlencode(base64_encode($fl->product_title)));?>"> <div class="fxSmall">
            <figure class="floatL width20p height100p">
    <?php if(file_exists('uploads/shop/'.$fl->pimg_front)){ ?>
        <img class="marginA <?php if($fl->stock === 0){echo('ImFilter');} ?>" src="" data-src="{{url.getBaseUri('')}}uploads/shop/{{fl.pimg_front}}" alt="{{fl.product_title}}" title="{{fl.product_title}}">
    <?php }else{ ?>
        <img class="marginA" src="" data-src="{{url.getBaseUri('')}}img/empty.png" alt="{{fl.product_title}}" title="{{fl.product_title}}">
    <?php } ?>
            </figure>
            <div class="floatL txtCenter width80p height100p">
            <?php echo $fl->product_title; ?>
<ul class="rating txtCenter fxxSmall">
    <li class="ico-star color360 rateA" data-value="1"></li><li class="ico-star color360 rateB" data-value="2"></li><li class="ico-star color360 rateC" data-value="3"></li><li class="ico-star color360 rateD" data-value="4"></li><li class="ico-star color360 rateE" data-value="5"></li>
</ul>
        {% if fl.discount > 0 %}<h2 class="fxSmall color000 txtCenter txtUpper"> {{fl.discount}} &#124; <span class="color333 txtLine">{{fl.product_price}}</span></h2>{% else %}<h2 class="fxSmall color000 txtCenter txtUpper"> {{fl.product_price}}</h2>{% endif %}
            </div>
            </div></a>
        <?php } ?>
    </article>
    <article class="stepb">
    <?php foreach ($pstage3->getItems() as $p3): ?>
           <a href="{{url.getBaseUri('')}}index/product/<?php echo(urlencode(base64_encode($p3->product_title)));?>"><div class="pdata">
                <figure>
    <?php if(file_exists('uploads/shop/'.$p3->pimg_front)){ ?>
        <img class="marginA <?php if($p3->stock === 0){echo('ImFilter');} ?>" src="" data-src="{{url.getBaseUri('')}}uploads/shop/{{p3.pimg_front}}" alt="{{p3.product_title}}" title="{{p3.product_title}}">
    <?php }else{ ?>
        <img class="marginA" src="" data-src="{{url.getBaseUri('')}}img/empty.png" alt="{{p3.product_title}}" title="{{p3.product_title}}">
    <?php } ?>
                </figure>
                <figcaption class="fxSmall txtCenter">
                    <?php echo(strlen($p3->product_title) > 30 ? substr($p3->product_title,0,30) : $p3->product_title); ?></figcaption>
                <div class="pprice txtCenter">
{% if p3.discount > 0 %}<h2 class="fxSmall color000 txtCenter txtUpper"> {{p3.discount}} &#124; <span class="color333 txtLine">{{p3.product_price}}</span></h2>{% else %}<h2 class="fxSmall color000 txtCenter txtUpper"> {{p3.product_price}}</h2>{% endif %}</div>
<ul class="rating txtCenter fxxSmall">
    <li class="ico-star color360 rateA" data-value="1"></li><li class="ico-star color360 rateB" data-value="2"></li><li class="ico-star color360 rateC" data-value="3"></li><li class="ico-star color360 rateD" data-value="4"></li><li class="ico-star color360 rateE" data-value="5"></li>
</ul>
<p class="pbtn fSmall txtCenter">{% if(p3.discount > 0) %} <mark><?php $res = (($p3->product_price - $p3->discount) * 100) / $p3->product_price; echo('-'.number_format($res)); ?>%</mark> {% else %}&nbsp;{% endif %}</p>
            </div></a>
    <?php endforeach; ?>
    </article>
</section>
<section class="bads brd1x brdSolid brdDDD height100x">
    <div class="txtCenter bold">ADS HERE</div><div class="txtCenter bold">ADS HERE</div>
</section>
<section class="row"><article class="row bgEEE bold pad10x margin4x brdDDD brd1x brdSolid">MORE TO LOVE</article></section>
<section class="love">
    <article class="steps">
        <?php foreach($lp as $ml){ ?>
            <a class="sim clrB" title="{{ml.product_title}}" href="{{url.getBaseUri('')}}index/product/<?php echo(urlencode(base64_encode($ml->product_title)));?>"> <div class="fxSmall">
            <figure class="floatL width20p height100p">
    <?php if(file_exists('uploads/shop/'.$ml->pimg_front)){ ?>
        <img class="marginA <?php if($ml->stock === 0){echo('ImFilter');} ?>" src="" data-src="{{url.getBaseUri('')}}uploads/shop/{{ml.pimg_front}}" alt="{{ml.product_title}}" title="{{ml.product_title}}">
    <?php }else{ ?>
        <img class="marginA" src="" data-src="{{url.getBaseUri('')}}img/empty.png" alt="{{ml.product_title}}" title="{{ml.product_title}}">
    <?php } ?>

            </figure>
            <div class="floatL txtCenter width80p height100p">
            <?php echo $ml->product_title; ?>
<ul class="rating txtCenter fxxSmall">
    <li class="ico-star color360 rateA" data-value="1"></li><li class="ico-star color360 rateB" data-value="2"></li><li class="ico-star color360 rateC" data-value="3"></li><li class="ico-star color360 rateD" data-value="4"></li><li class="ico-star color360 rateE" data-value="5"></li>
</ul>
        {% if ml.discount > 0 %}<h2 class="fxSmall color000 txtCenter txtUpper"> {{ml.discount}} &#124; <span class="color333 txtLine">{{ml.product_price}}</span></h2>{% else %}<h2 class="fxSmall color000 txtCenter txtUpper"> {{ml.product_price}}</h2>{% endif %}
            </div>
            </div></a>
        <?php } ?>
    </article>
    <article class="stepb">
    <?php foreach ($pstage4->getItems() as $p4): ?>
           <a href="{{url.getBaseUri('')}}index/product/<?php echo(urlencode(base64_encode($p4->product_title)));?>"><div class="pdata">
                <figure>
    <?php if(file_exists('uploads/shop/'.$p4->pimg_front)){ ?>
        <img class="marginA <?php if($p4->stock === 0){echo('ImFilter');} ?>" src="" data-src="{{url.getBaseUri('')}}uploads/shop/{{p4.pimg_front}}" alt="{{p4.product_title}}" title="{{p4.product_title}}">
    <?php }else{ ?>
        <img class="marginA" src="" data-src="{{url.getBaseUri('')}}img/empty.png" alt="{{p4.product_title}}" title="{{p4.product_title}}">
    <?php } ?>
                </figure>
                <figcaption class="fxSmall txtCenter">
                    <?php echo(strlen($p4->product_title) > 30 ? substr($p4->product_title,0,30) : $p4->product_title); ?></figcaption>
                <div class="pprice txtCenter">
{% if p4.discount > 0 %}<h2 class="fxSmall color000 txtCenter txtUpper"> {{p4.discount}} &#124; <span class="color333 txtLine">{{p4.product_price}}</span></h2>{% else %}<h2 class="fxSmall color000 txtCenter txtUpper"> {{p4.product_price}}</h2>{% endif %}</div>
<ul class="rating txtCenter fxxSmall">
    <li class="ico-star color360 rateA" data-value="1"></li><li class="ico-star color360 rateB" data-value="2"></li><li class="ico-star color360 rateC" data-value="3"></li><li class="ico-star color360 rateD" data-value="4"></li><li class="ico-star color360 rateE" data-value="5"></li>
</ul>
<p class="pbtn fSmall txtCenter">{% if(p4.discount > 0) %} <mark><?php $res = (($p4->product_price - $p4->discount) * 100) / $p4->product_price; echo('-'.number_format($res)); ?>%</mark> {% else %}&nbsp;{% endif %}</p>
            </div></a>
    <?php endforeach; ?>
    </article>
</section>
<section class="cads brd1x brdSolid brdDDD height100x">
    <div class="txtCenter bold">ADS HERE</div>
    <div class="txtCenter bold">ADS HERE</div>
    <div class="txtCenter bold">ADS HERE</div>
</section>
<section class="row"><article class="row bgEEE bold pad10x margin4x brdDDD brd1x brdSolid">YOU MAY ALSO LIKE</article></section>
<section class="row">
    <article class="inspire">
    <?php foreach ($pstage1->getItems() as $p1): ?>
        <a href="{{url.getBaseUri('')}}index/product/<?php echo(urlencode(base64_encode($p1->product_title)));?>"><div class="pdata">
                <figure>
    <?php if(file_exists('uploads/shop/'.$p1->pimg_front)){ ?>
        <img class="marginA <?php if($p1->stock === 0){echo('ImFilter');} ?>" src="" data-src="{{url.getBaseUri('')}}uploads/shop/{{p1.pimg_front}}" alt="{{p1.product_title}}" title="{{p1.product_title}}">
    <?php }else{ ?>
        <img class="marginA" src="" data-src="{{url.getBaseUri('')}}img/empty.png" alt="{{p1.product_title}}" title="{{p1.product_title}}">
    <?php } ?>
                </figure>
                <figcaption class="fxSmall txtCenter">
                    <?php echo(strlen($p1->product_title) > 30 ? substr($p1->product_title,0,30) : $p1->product_title); ?></figcaption>
                <div class="pprice txtCenter">
{% if p1.discount > 0 %}<h2 class="fxSmall color000 txtCenter txtUpper"> {{p1.discount}} &#124; <span class="color333 txtLine">{{p1.product_price}}</span></h2>{% else %}<h2 class="fxSmall color000 txtCenter txtUpper"> {{p1.product_price}}</h2>{% endif %}</div>
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
<ul class="rating txtCenter fxxSmall">
    <input itemprop="ratingValue" type="hidden" id="avgRating" value="<?php echo($avg); ?>">
    <li class="ico-star color360 rateA" data-value="1"></li><li class="ico-star color360 rateB" data-value="2"></li><li class="ico-star color360 rateC" data-value="3"></li><li class="ico-star color360 rateD" data-value="4"></li><li class="ico-star color360 rateE" data-value="5"></li>
</ul>
<p class="pbtn fSmall txtCenter">{% if(p1.discount > 0) %} <mark><?php $res = (($p1->product_price - $p1->discount) * 100) / $p1->product_price; echo('-'.number_format($res)); ?>%</mark> {% else %}&nbsp;{% endif %}</p>
            </div></a>
    <?php endforeach; ?>
    </article>
{#    
<?php for ($i = 1; $i <= 4; $i++): ?>
    <h1>Stage <?= $i ?> Products</h1>
    <?php foreach (${"pstage$i"}->getItems() as $product): ?>
        <?php #echo $product->product_title; ?>
    <?php endforeach; ?>
<?php endfor; ?>
#}
</section>
{# End #}{% endblock %}
