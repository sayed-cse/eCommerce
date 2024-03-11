{% extends "layouts/main.volt" %}
{% block content %}{# Begin #}
<section class="row bgEEE">
<article class="inspire">
{% for query in data %}
	<div class="pdata"><a href="{{url.getBaseUri('')}}index/product/<?php echo(urlencode(base64_encode($query['product_title']))); ?>">
		<img  class="width100p height100p" alt="<?php echo($query['product_title']); ?>" data-src="{{url.getBaseUri('')}}uploads/shop/<?php echo($query['pimg_front']); ?>"/>
	</a></div>
{% endfor %}
</article>
</section>{# End #}{% endblock %}