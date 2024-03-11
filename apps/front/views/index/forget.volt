{% extends "layouts/main.volt" %}{% block content %}{# Begin #}
<section class="signup">
	<article class="item">&nbsp;</article>
	<article class="item">
	<p class="bgDDD Hbar radiusTL radiusTR bold pad10x">Forgot Your Password ?</p>
	<div id="s" class="bgF5F s">		
		{{ form_legacy(action,'enctype':'application/x-www-form-urlencoded','autocomplete':'off') }}
		<br/>
			{% if aspect !== '1' %}		
				I'm a Buyer {{ radio_field('type','id':'buyers','class':'logintype','value':'b','aria-label':'buyers') }} I'm a Seller {{ radio_field('type','id':'sellers','class':'logintype','value':'s','aria-label':'sellers') }}<hr/><br/>
			{% endif %}
			{% if aspect === '1' %}
				<label>New Password*:</label><br/>
				{{ password_field('passwdNa','autocomplete':'off','placeholder':'*****') }}<br/>
				<label>Re-type New Password*:</label><br/>
				{{ password_field('passwdNb','autocomplete':'off','placeholder':'*****') }}<br/>
			{% else %}
				<label>Your Email*:</label><br/>
				{{ text_field('umail','pattern':'[a-z0-9._%+\-]+@[a-z0-9.\-]+\.[a-z]{2,}$','autocomplete':'off','placeholder':'sales@kiyani.com') }}<br/>
			{% endif %}
			{% if aspect === '1' %}	
				{{hidden_field('salt','value':salt)}}
				{{hidden_field('type','value':type)}}
				{{submit_button('Update Password','formaction':action,'enctype':'application/x-www-form-urlencoded','formmethod':'post','id':'Reset','class':'margin8x neumorphism cursorPoint width100p bold pad10x bgEEE')}}
			{% else %}
				{{submit_button('Request New Password','formaction':action,'enctype':'application/x-www-form-urlencoded','formmethod':'post','id':'Recover','class':'margin8x neumorphism cursorPoint width100p bold pad10x bgEEE')}}
			{% endif %}					
		{{end_form()}}
	</div>
	<p class="bgDDD Bbar radiusBL radiusBR pad10x">&nbsp;</p>		
	</article>
	<article class="item">&nbsp;</article>
</section>{# End #}{% endblock %}