{% extends "layouts/main.volt" %}{% block content %}{# Begin #}
<section class="signup">
	<article class="item">&nbsp;</article>
	<article class="item">
	{% if type === 's' %}
	<p class="bgDDD Hbar radiusTL radiusTR bold pad10x">Seller Registration</p>
	<div id="s" class="bgF5F s">
		{{ form_legacy('class':'','enctype':'multipart/form-data') }}
			<ul class="fSmall">
				{{hidden_field('type','value':type)}}
				<li>*Full-Name: {{ text_field('uname','pattern':'^[a-zA-Z_]+( [a-zA-Z_]+)*$','spellcheck':'false','autocorrect':'off','autocomplete':'off','autocapitalize':'off','placeholder':'Jhon Doe') }}</li>
				<li>*Shop/Service-Name: {{ text_field('shopname','pattern':'^[a-zA-Z_]+( [a-zA-Z0-9_]+)*$','spellcheck':'false','autocorrect':'off','autocomplete':'off','autocapitalize':'off','placeholder':'Kiyani Store') }}</li>
				<li>*Email: {{ text_field('umail','pattern':'[a-z0-9._%+\-]+@[a-z0-9.\-]+\.[a-z]{2,}$','placeholder':'sales@kiyani.com','autocomplete':'off') }}</li>
				<li>*Address: {{ text_field('address','pattern':'^[a-zA-Z0-9]+( [a-zA-Z0-9]+)*$','spellcheck':'false','autocorrect':'off','autocomplete':'off','autocapitalize':'off','placeholder':'19 AbgDce') }}</li>
				<li>*Contact: {{ text_field('contact','pattern':'[0-9]+','placeholder':'8801999999999','autocomplete':'off') }}</li>
				<li>*Password: {{ password_field('passwd','placeholder':'*********','maxlength':'30','autocomplete':'off') }}</li>
				<li>*Vendor Logo:{{ file_field('servicelogo','capture':'','accept':'image/*','value':servicelogo,'area-label':'serviceLogo') }}</li>
				<li class="tooltip">*Valid Document:{{ file_field('legaldoc','capture':'','accept':'image/*','value':legaldoc,'area-label':'legalDoc') }}<span>NID/BIN/TIN<br/>Driving License<br/>Passport</span></li>
				<li>
{% if aspect === '1' %}
	{{submit_button('UPDATE','formaction':action,'enctype':'multipart/form-data','formmethod':'post','id':'signup','class':'margin8x neumorphism cursorPoint width100p bold pad10x bgEEE')}}
{% else %}
	{{submit_button('SAVE','formaction':action,'enctype':'multipart/form-data','formmethod':'post','id':'signup','class':'margin8x neumorphism cursorPoint width100p bold pad10x bgEEE')}}
{% endif %}
				</li>
			</ul>
		{{ end_form() }}
	</div>
	{% elseif type === 'b' %}
	<p class="bgDDD Hbar radiusTL radiusTR bold pad10x">Buyer Registration</p>
	<div id="b" class="bgF5F b">
		{{ form_legacy('class':'') }}
			<ul>
				{{hidden_field('type','value':type)}}			
				<li>*Name: {{ text_field('name','pattern':'^[a-zA-Z_]+( [a-zA-Z_]+)*$','spellcheck':'false','autocorrect':'off','autocomplete':'off','autocapitalize':'off','placeholder':'Jhon Doe') }}</li>
				<li>*Email: {{ text_field('email','pattern':'[a-z0-9._%+\-]+@[a-z0-9.\-]+\.[a-z]{2,}$','placeholder':'jhon@privatemail.com','autocomplete':'off') }}</li>
				<li>*Password: {{ password_field('passwd','placeholder':'********','autocomplete':'off','maxlength':'30') }}</li>
				<li>
{% if aspect === '1' %}
	{{submit_button('UPDATE','formaction':action,'enctype':'application/x-www-form-urlencoded','formmethod':'post','id':'signup','class':'margin8x neumorphism cursorPoint width100p bold pad10x bgEEE')}}
{% else %}
	{{submit_button('SAVE','formaction':action,'enctype':'application/x-www-form-urlencoded','formmethod':'post','id':'signup','class':'margin8x neumorphism cursorPoint width100p bold pad10x bgEEE')}}
{% endif %}
				</li>
			</ul>
		{{ end_form() }}
	</div>	
	{% else %}
	<p class="errorMessage">Loading ...</p>
	{% endif %}
	<p class="bgDDD Bbar radiusBL radiusBR pad10x">&nbsp;</p>
	</article>
	<article class="item">&nbsp;</article>
</section>{# End #}{% endblock %}