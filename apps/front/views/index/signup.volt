{% extends "layouts/main.volt" %}{% block content %}{# Begin #}
<section class="row">
	<article class="rc2">&nbsp;</article>
	<article class="rc8">
		{% if type === 's' %}
		<p class="bg0d6077 colorFFF bold pad10x headRadius">Seller Registration</p>
			<div id="s" class="s bgEEE dataBorder">
			{{ form_legacy(action,'enctype': 'multipart/form-data','autocomplete':'off') }}
				<ul class="fsmall">
					{{hidden_field('type','value':type)}}
					<li>*Full-Name: {{ text_field('uname','value':'') }}</li>
					<li>*Shop/Service-Name: {{ text_field('shopname','value':'') }}</li>
					<li>*Email: {{ text_field('umail','value':'') }}</li>
					<li>*Address: {{ text_field('address','value':'') }}</li>
					<li>*Contact: {{ text_field('contact','value':'') }}</li>
					<li>*Password: {{ password_field('passwd','value':'') }}</li>
					<li>*Vendor Logo:{{ file_field('vendor', 'value':'') }}</li>
					<li>*NID/PASSPORT/LICENSE:{{ file_field('nidpass', 'value':'') }}</li>
					<li>{{ submit_button('SAVE','id':'signup','class':'margin4x neumorphism cursorpoint width100p bold pad4x bgEEE') }}</li>
				</ul>
			{{ end_form() }}
			</div>
		{% elseif type === 'b' %}
		<p class="bg0d6077 colorFFF bold pad10x" style="border-radius:8px 8px 0 0">Buyer Registration</p>
			<div id="b" class="b bgEEE" style="border:2px solid #107895">
			{{ form_legacy('class':'','autocomplete':'off') }}
				<ul>
					{{hidden_field('type','value':type)}}
					<li>*Name: {{ text_field('name','value':'') }}</li>
					<li>*Email: {{ text_field('email','value':'') }}</li>
					<li>*Password: {{ password_field('passwd','value':'') }}</li>
					<li>{{ submit_button('SAVE','formaction':action,'enctype':'application/x-www-form-urlencoded','formmethod':'post','id':'signup','class':'margin4x neumorphism cursorpoint width100p bold pad4x bgEEE') }}</li>
				</ul>
			{{ end_form() }}
			</div>
			{% else %}
			<p class="errorMessage">Loading ...</p>
		{% endif %}
		<p class="bg0d6077 colorFFF bold pad10x footRadius">&nbsp;</p>
	</article>
	<article class="rc2">&nbsp;</article>
</section>{# End #}{% endblock %}