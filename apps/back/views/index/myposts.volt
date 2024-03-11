{% extends "layouts/main.volt" %}
{% block content %}
{# Begin #}
<section class="row">
<article class="rc1">&nbsp;</article>	
<article class="rc10">
<?php if(!empty($page->getItems())){ ?>
	<table class="fsmall brd1x brdsolid brdDDD" border="1" width="100%">
	    <tr>
	        <th class="pad8x bold txtCenter">Title</th>
	        <th class="pad8x bold txtCenter">Stage</th>
	        <th class="pad8x bold txtCenter">Price</th>
	        <th class="pad8x bold txtCenter">Discount</th>
	        <th class="pad8x bold txtCenter">Coupon</th>
	        <th class="pad8x bold txtCenter">Stock</th>
	        <th class="pad8x txtCenter"><i class="ico-pen colorDC3"></i></th>
	        <th class="pad8x txtCenter"><i class="ico-trash colorDC3"></i></th>
	    </tr>
	    <?php foreach ($page->getItems() as $item) { ?>
	    <tr>
	        <td><?php echo($item->product_title); ?></td>	    
	        <td class="pad8x txtCenter">
<?php 
switch(true){
    case '1' === $item->stage:$stage = 'Inspiration';break;
    case '2' === $item->stage:$stage = 'Featured';break;
    case '3' === $item->stage:$stage = 'Flash Deals';break;
    case '4' === $item->stage:$stage = 'More to Love';break;
}
echo($stage); ?>
	        </td>
	        <td class="pad8x txtCenter"><?php echo $item->product_price; ?></td>
	        <td class="pad8x txtCenter"><?php echo $item->discount; ?></td>
	        <td class="pad8x txtCenter"><?php echo $item->coupon; ?></td>
	        <td class="pad8x txtCenter"><?php if($item->stock === 1){echo('<i class="ico-check color080"></i>');}else{echo('<i class="ico-ban colorF00"></i>');}; ?></td>
	        <td class="pad8x txtCenter"><a href="{{url.getBaseUri('')}}back/index/productEdit/{{item.id}}"><i class="ico-pen color080"></i></a></td>
	         <td class="pad8x txtCenter"><a href="{{url.getBaseUri('')}}back/index/productDel/{{item.id}}"><i class="ico-del colorF00"></i></a></td>
	    </tr>
	    <?php } ?>
	    <tr>
	    	<td colspan="8" class="pad8x bold txtCenter">
				<a href="{{url.getBaseUri('')}}back/index/myposts">|&lt;</a>
				<a href="{{url.getBaseUri('')}}back/index/myposts?page=<?php echo($page->getPrevious()); ?>">&lsaquo;</a>
				<?php echo("Page {$page->getCurrent()}  of {$page->getLast()}"); ?>
				<a href="{{url.getBaseUri('')}}back/index/myposts?page=<?php echo($page->getNext()); ?>">&rsaquo;</a>
				<a href="{{url.getBaseUri('')}}back/index/myposts?page=<?php echo($page->getLast()); ?>">&gt;|</a>
	    	</td>
	    </tr>	
	</table>
	<?php }else{echo('<h1 class="txtCenter">No Data Found</h1>');} ?>
{#
	{% for query in mydata %}
		<a href="back/index/productEdit/{{query.id}}">{{query.product_title}}</a><a href="back/index/productDel/{{query.id}}">X</a><br/>
	{% endfor %}
#}
</article>
<article class="rc1">&nbsp;</article>
</section>	
{# End #}
{% endblock %}
