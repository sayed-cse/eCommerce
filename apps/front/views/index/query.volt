{% extends "layouts/main.volt" %}
{% block content %}{# Begin #}
<section class="row bgEEE">
	<?php foreach($data as $query): ?>
		<a title="" href="index/product/<?php echo($query['id']);?>"><?php echo($query['product_title']);?></a>
	<?php endforeach; ?>
</section>{# End #}{% endblock %}