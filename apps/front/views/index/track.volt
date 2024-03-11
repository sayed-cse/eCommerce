{% extends "layouts/main.volt" %}
{% block content %}{# Begin #}
<section class="row">
<article class="txtCenter bold colorFFF fxxSmall">
	<span class="pad4x bgDC3">[ PENDING ]</span> | <span class="pad4x bgF60">[ PROCESSING ]</span> | <span class="pad4x bg39FF14 color333 fxxSmall">[ DELIVERED ]</span> | <span class="pad4x bg080">[ RECIEVED ]</span> | <span class="pad4x bg666">[ RETURNED ]</span><br/><br/><p class="fSmall txtCenter color333">You can cancel your order before <span class="pad4x bgF60 colorFFF fxxSmall">[ PROCESSING ]</span> 
<a id="invoice" class="pad4x bgF00 colorFFF fxxSmall" href="{{ url('index/invoice') }}" class="btn btn-primary">[ INVOICE ]</a></p><br/>
</article>
</section>
<section class="tracker fSmall">
	<article class="row">&nbsp;</article>
	<article class="trackData">
		{% for query in myorder %}
		<div class="pad10x"><img class="width100p height100p" data-src="{{url.getBaseUri('')}}uploads/shop/{{query.color}}"/></div>
		<div class="bgFFF width100p curved brdDDD brd1x brdSolid pad8x">
Delivery Status : <?php 
switch($query->orderstatus){
    case 1: $status = "Pending"; break;
    case 2: $status = "Processing"; break;
    case 3: $status = "Delivered"; break;
    case 4: $status = "Recieved"; break;
    case 5: $status = "Returned"; break;
}
switch(true){
case 'Pending' === $status:
	echo('<span class="pad2x bgDC3 colorFFF fxxSmall">'.$status.'</span>');
break;
	case 'Processing' === $status:
	echo('<span class="pad2x bgF60 colorFFF fxxSmall">'.$status.'</span>');
break;
	case 'Delivered' === $status:
	echo('<span class="pad2x bg39FF14 color333 fxxSmall">'.$status.'</span>');
break;
	case 'Recieved' === $status:
	echo('<span class="pad2x bg080 colorFFF fxxSmall">'.$status.'</span>');
break;
	case 'Returned' === $status:
	echo('<span class="pad2x bg666 colorFFF fxxSmall">'.$status.'</span>');
break;
default:
	echo('Invalid');
break;
}?><br/> 
	Trxn Number : <span class="fxxSmall bg6165 colorFFF">{{query.trxn}}</span><br/>
	Method :  <?php 
switch($query->paytype){
    case 1: $method = "Cash On Delivery"; break;
    case 2: $method = "bKash"; break;
    case 3: $method = "Nagad"; break;
    case 4: $method = "Rocket"; break;
}
	echo('<span class="pad2x bg107895 colorFFF fxxSmall">'.$method.'</span>');?><br/>	
	Order Number : {{query.orderid}}<br/>
	Order Date : {{query.orderdate}}<br/>
	Quantity : {{query.quantity}}<br/>
	Scale/Mesurement : {{query.size}}<br/>
	Price : {% if(query.discount > 0) %}{{query.discount}} x {{query.quantity}} = {{query.discount * query.quantity}}<br/>{% else %}{{query.price}} x {{query.quantity}} = {{query.price * query.quantity}}<br/>{% endif %}
	Shipping : {{query.shipingcost}}<br/>
	<?php if(!empty($query->cashonfee)){ ?>
	Cash Payment Fee : {{query.cashonfee}}<br/>
	<?php } ?>
{% if(query.discount > 0) %}{% set subTotal = query.discount * query.quantity %}{% else %}{% set subTotal = query.price * query.quantity %}{% endif %}
	Total : <?php echo($subTotal + $query->shipingcost + (int)$query->cashonfee); ?><br/>
	{% if query.orderstatus === 1 %}Cancel Order? <a href="{{url.getBaseUri('')}}index/cancelorder/{{query.id|url_encode}}">[ <i class="ico-del colorDC3"></i> ]</a>{% endif %}
		</div>
		{% endfor %}
	</article>
	<article class="row">&nbsp;</article>
</section>{#{crypt.encrypt(query.id, eKey)|url_encode}#}
{# End #}{% endblock %}


	