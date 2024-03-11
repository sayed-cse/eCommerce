{% extends "layouts/main.volt" %}
{% block content %}
{# Begin #}
<section class="row">
<article class="rc2">&nbsp;</article>	
<article class="rc8 fsmall">
{% for query in myorder %}
{{form_legacy('back/index/orderUpdate','enctype':'application/x-www-form-urlencoded','autocomplete':'off')}}
	<img style="width:80px;height:80px" data-src="{{url.getBaseUri('')}}uploads/shop/{{query.color}}"/>
	Delivery Status : <?php 
switch($query->orderstatus){
    case 1: $status = "Pending"; break;
    case 2: $status = "Processing"; break;
    case 3: $status = "Delivered"; break;
    case 4: $status = "Recieved"; break;
    case 5: $status = "Returned"; break;
}
echo($status);
?><br/> 
	Order Number : {{query.orderid}}<br/>
	Order Date : {{query.orderdate}}<br/>
	Quantity : {{query.quantity}}<br/>
	Size : {{query.size}}<br/>
{#	
	Price : {{query.price}} x {{query.quantity}} = {{query.price * query.quantity}}<br/>
	Shipping : {{query.shipingcost}}<br/>
#}
<input type="hidden" name="orderid" value="{{query.orderid}}"/>	
<select name="status"><option {% if query.orderstatus === 1 %}selected{% endif %} value="1">Pending</option><option {% if query.orderstatus === 2 %}selected{% endif %} value="2">Processing</option><option {% if query.orderstatus === 3 %}selected{% endif %} value="3">Delivered</option><option {% if query.orderstatus === 4 %}selected{% endif %} value="4">Recieved</option><option {% if query.orderstatus === 5 %}selected{% endif %} value="5">Returned</option></select>
<input type="submit" name="update" value="UPDATE"/>	<input data-id="{{query.id}}" class="invo cursorpoint" type="submit" name="invoice" value="INVOICE"/>
{{end_form()}}
{% endfor %}
</article>
<article class="rc2">&nbsp;</article>
</section>	
{# End #}
{% endblock %}
