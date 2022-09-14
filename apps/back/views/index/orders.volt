{% extends "layouts/main.volt" %}
{% block content %}
{# Begin #}
<section class="row">
	<article class="rc1">&nbsp;</article>
	<article class="rc10">
	<p class="bg0d6077 colorFFF bold pad10x headRadius">Orders Status</p>
	<div class="fsmall dataBorder width100p">
<?php if(!empty($data) && count($data) > 0){ ?>
	{% for data in data %}
		{{data.size}}<br/>
		{{data.price}}
	{% endfor %}
<?php }else{echo('<h1 class="txtCenter pad10x">No Orders Found!</h1>');}?>
	</div>
	<p class="bg0d6077 colorFFF bold pad10x footRadius">&nbsp;</p>
	</article>
	<article class="rc1">&nbsp;</article>
</section>	
{# End #}
{% endblock %}
