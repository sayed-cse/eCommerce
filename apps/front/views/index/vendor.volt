{% extends "layouts/main.volt" %}
{% block content %}{# Begin #}
<section class="row bgEEE">
<article class="row">
THIS VENDORS ALL PRODUCTS<br/>
VERIFIED : <i class="ico-del colorF00"></i> Not Verified <i class="ico-check"></i> Verified<br/>
</article>
<article class="inspire">
{% for data in vendor %}
	<div class="pdata"><a href="{{url.getBaseUri('')}}index/product/<?php echo(urlencode(base64_encode($data->product_title)));?>"><img class="width100p height100p" alt="{{data.product_title}}" data-src="{{url.getBaseUri('')}}uploads/shop/{{data.pimg_front}}"/></a></div>
{% endfor %}
</article>
</section>{# End #}{% endblock %}
