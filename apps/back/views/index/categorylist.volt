{% extends "layouts/main.volt" %}
{% block content %}
{# Begin #}
<section class="row">
<article class="rc2">&nbsp;</article>	
<article class="rc8">
	<p class="bgDDD Hbar radiusTL radiusTR pad10x bold">Insert Category</p>
	<div id="b" class="bgF5F b">
		{{ form_legacy('back/index/categorysave','enctype':'application/x-www-form-urlencoded') }}
		{{ text_field('catname','value':'') }}<br/>
		{{ submit_button('Save New Category','id':'productinsert','class':'margin10x neumorphism cursorPoint width100p bold pad10x bgEEE') }}
		{{end_form()}}
	</div>	
	<p class="bgDDD Bbar radiusBL radiusBR pad10x">&nbsp;</p>
<hr/>
	<p class="bgDDD Hbar radiusTL radiusTR pad10x bold">Insert Sub Category</p>
	<div id="b" class="bgF5F b">
		{{ form_legacy('back/index/subcategorysave','enctype':'application/x-www-form-urlencoded') }}
		{{ hidden_field('id','id':'','value':'') }}
		<select name="category" id="category">
		<option value="0">Reset &amp; Choose Category ...</option>
		{% for category in categories %}<option value="{{category.id}}">{{category.categoryname}}</option>{% endfor %}
		</select>	 
		{{ text_field('subcatname','value':'') }}<br/>
		{{ submit_button('Save New Sub Category','id':'productinsert','class':'margin10x neumorphism cursorPoint width100p bold pad10x bgEEE') }}
		{{end_form()}}
	</div>	
	<p class="bgDDD Bbar radiusBL radiusBR pad10x">&nbsp;</p>
<hr/>
	<p class="bgDDD Hbar radiusTL radiusTR pad10x bold">Insert Sub Sub Category</p>
	<div id="b" class="bgF5F b">
		{{ form_legacy('back/index/subsubcategorysave','enctype':'application/x-www-form-urlencoded') }}
		{{ hidden_field('id','id':'','value':'') }}
		<select name="subcategory" id="subcategory">
		<option value="0">Reset &amp; Choose Sub-Category ...</option>
		{% for subcategory in subcategories %}<option value="{{subcategory.id}}">{{subcategory.subcategory_name}}</option>{% endfor %}
		</select>
		{{ text_field('sscname','value':'') }}<br/>
		{{ submit_button('Save New Sub Sub Category','id':'productinsert','class':'margin10x neumorphism cursorPoint width100p bold pad10x bgEEE') }}
		{{end_form()}}	
	</div>	
	<p class="bgDDD Bbar radiusBL radiusBR pad10x">&nbsp;</p>
</article>
<article class="rc2">&nbsp;</article>
</section>	
{# End #}
{% endblock %}
