{% extends "layouts/main.volt" %}
{% block content %}
{# Begin #}
<section class="row">
	<article class="">&nbsp;</article>
	<article class="">
	[ USE TRANJECTION NUMBER ]
		<ul class="payment">
			<li class="shade"><img class="pay width100x height100x cursorPoint" alt="Payment Method Cash" data-id="cashon" title="Cash On Delivery" data-src="{{url.getBaseUri()}}img/cashondel.png"/></li>
			<li class="shade"><img class="pay width100x height100x cursorPoint" alt="Payment Method Nagad" data-id="nagad" data-src="{{url.getBaseUri()}}img/nagad.png"/></li>
			<li class="shade"><img class="pay width100x height100x cursorPoint" alt="Payment Method bKash" data-id="bkash" data-src="{{url.getBaseUri()}}img/bkash.png"/></li>
			<li class="shade"><img class="pay width100x height100x cursorPoint" alt="Payment Method Rocket" data-id="rocket" data-src="{{url.getBaseUri()}}img/rocket.png"/></li>
		</ul>
		[ USE PAYMENT GATEWAY ]
		<div id="paybox" data-id="">
			<img id="pimg" class="floatL brd0x width80x height80x clrB" alt="Payment Method" data-src="" /><hr/>
			<div id="paymsg">
				<strong>[ MERCHANT NO: 01922847852 ]</strong><br/><br/>
				TrxID: {{text_field('trxno','placeholder':trxid)}}
				Amount:  {{text_field('pamount','readonly':'readonly','value':pamount)}}
				<button id="paybt" class="pbtns margin4x neumorphism cursorPoint width100p bold pad4x bgEEE">CONFIRM &amp; SUBMIT</button>
			</div>
			<div id="cashmsg">
				{{hidden_field('autotrxno','value':trxid)}} {{hidden_field('pamount','value':pamount)}}			
				<h1 class="bold">CASH ON DELIVERY</h1>
				<h2 class="bold">ADDED CASH ON DELIVERY FEE TK 10/= APPLICABLE</h2>
				<p class="fSmall">BDT : [ {{pamount + 10}} ]</p>
				<button id="cashbt" class="margin4x neumorphism cursorPoint width100p bold pad4x bgEEE">CONFIRM &amp; SUBMIT</button>
			</div>
			<hr/>
			<a class="close" aria-label='Close Button' href="javascript:void(0);"><i class="ico-del colorF00"></i></a>
		</div>
	</article>
	<article class="">&nbsp;</article>
</section>
{# End #}
{% endblock %}