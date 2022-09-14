{% extends "layouts/main.volt" %}
{% block content %}
{# Begin #}
<section class="row">
	<article class="rc3">&nbsp;</article>
	<article class="rc6">
		<ul class="payment">
			<li class="shade width100x height100x"><a class="pay" title="Cash On Delivery" id="cashon" href="javascript:void(0);"><img data-id="cashon" class="width100p height100p" data-src="{{url.getBaseUri()}}img/cashondel.png"></a></li>
			<li class="shade width100x height100x"><a class="pay" title="Pay with Nagad" id="nagad" href="javascript:void(0);"><img data-id="nagad" class="width100p height100p" data-src="{{url.getBaseUri()}}img/nagad.webp"></a></li>
			<li class="shade width100x height100x"><a class="pay" title="Pay with bKash" id="bkash" href="javascript:void(0);"><img data-id="bkash" class="width100p height100p" data-src="{{url.getBaseUri()}}img/bkash.webp"></a></li>
			<li class="shade width100x height100x"><a class="pay" title="Pay with Rocket" id="rocket" href="javascript:void(0);"><img data-id="rocket" class="width100p height100p" data-src="{{url.getBaseUri()}}img/rocket.png"></a></li>
		</ul>
		<div id="paybox" data-id="">
			<img id="pimg" data-id="" class="float_left brd0x width80x height80x clr_both" alt="" data-src="" /><hr/>
			<div id="paymsg">
				TrxID: {{text_field('trxno','value':trxid)}}
				Amount:  {{text_field('pamount','value':pamount)}}
				{#{submit_button('CONFIRM & SUBMIT','id':'pbtns','class':'margin4x neumorphism cursorpoint width100p bold pad4x bgEEE')}#}
				<button id="paybt" class="pbtns margin4x neumorphism cursorpoint width100p bold pad4x bgEEE">CONFIRM & SUBMIT</button>
			</div>
			<div id="cashmsg">
				{{hidden_field('trxno','value':trxid)}}
				{{hidden_field('pamount','value':pamount)}}			
				<h1 class="bold">THANK YOU FOR YOUR BUSINESS</h1>
				<p class="fsmall">Our Customer Care Executive will Contact with You within 48 Hours.</p>
				<button id="cashbt" class="margin4x neumorphism cursorpoint width100p bold pad4x bgEEE">CONFIRM & SUBMIT</button>
			</div>
			<hr/>
			<a href="javascript:void(0);" class="close">X</a>
		</div>
	</article>
	<article class="rc3">&nbsp;</article>
</section>
{# End #}
{% endblock %}