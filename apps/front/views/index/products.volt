{% extends "layouts/main.volt" %}{% block content %}{# Begin #}
<section class="row">
    <article class="ads">&nbsp;</article>
    <article class="xDatas">
		{% if mycart > 0 %}
		{% for product in products %}
		<a class="bgEEE pad10x color333" href="{{url.getBaseUri('')}}index/product/<?php echo(urlencode(base64_encode($product->product_title)));?>">{{product.product_title}}</a>
		{% endfor %}
		{% else %}<p class="width100p fxxLarge bold color333 txtCenter pad10x">No Data Found</p>{% endif %}
    </article>
    <article class="ads">&nbsp;</article>   
</section>{# End #}{% endblock %}
