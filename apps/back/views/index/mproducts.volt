{% extends "layouts/main.volt" %}
{% block content %}
{# Begin #}
<section class="row">
	<article class="rc1">&nbsp;</article>
	<article class="rc10">
	<p class="bg0d6077 colorFFF bold headRadius">&nbsp;</p>
	<table class="fsmall dataBorder width100p">
		<tr class="bg0d6077 colorFFF">
			<th class="width80p txtCenter">TITLE</th>
			<th class="txtCenter"><i class="ico-pen"></i></th>
			<th class="txtCenter"><i class="ico-del"></i></th>
		</tr>	
<?php if(!empty($data) && count($data) > 0){ ?>
		{% for data in data %}
		<tr class="zebra">
			<td class="width80p"><a href="{{url.getBaseUri('')}}index/product/{{data.id}}">{{data.product_title}}</a></td>
			<td class="txtCenter"><a title="UPDATE INFO" href="{{url.getBaseUri('')}}back/index/productEdit/{{data.id}}"><i class="ico-pen"></i></a></td>
			<td class="txtCenter"><a title="ERASE DATA" href="{{url.getBaseUri('')}}back/index/productDel/{{data.id}}"><i class="ico-del"></i></a></td>
		</tr>
		{% endfor %}
<?php }else{echo('<tr><td colspan="3"><h1 class="txtCenter pad10x">No Products Found!</h1></td></tr>');}?>
	</table>
	<p class="bg0d6077 colorFFF bold pad10x footRadius">&nbsp;</p>
	</article>
	<article class="rc1">&nbsp;</article>
</section>	
{# End #}
{% endblock %}
