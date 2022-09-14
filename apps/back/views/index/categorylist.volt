{% extends "layouts/main.volt" %}
{% block content %}
{# Begin #}
<section class="row">
<article class="rc2">&nbsp;</article>	
<article class="rc8">
	<p class="bg0d6077 colorFFF bold pad10x headRadius">Insert New Category</p>
	<table class="width100p ajaxForm dataBorder">
		<tr>
			<td class="pad10x">
			{{ form_legacy('back/index/categorysave') }}
				{{ text_field('catname','value':'') }}
				{{ submit_button('Save','id':'productinsert','class':'pad8x width100p') }}
			{{end_form()}}
			</td>
		</tr>	
	</table>
	<p class="bg0d6077 colorFFF bold pad10x marginB8x footRadius">&nbsp;</p>

	<p class="bg0d6077 colorFFF bold pad10x headRadius">Insert New Sub Category</p>
	<table class="width100p ajaxForm dataBorder">
		<tr>
			<td class="pad10x">
	{{ form_legacy('back/index/subcategorysave') }}
		{{ hidden_field('id','id':'','value':'') }}
		<select name="category" id="category">
		<option value="0">Reset &amp; Choose Category ...</option>
		{% for category in categories %}<option value="{{category.id}}">{{category.categoryname}}</option>{% endfor %}
		</select>	 
		{{ text_field('subcatname','value':'') }}
		{{ submit_button('Save','id':'productinsert','class':'pad8x width100p') }}
	{{end_form()}}
			</td>
		</tr>	
	</table>
	<p class="bg0d6077 colorFFF bold pad10x marginB8x footRadius">&nbsp;</p>


	<p class="bg0d6077 colorFFF bold pad10x headRadius">Insert New Sub Sub Category</p>
	<table class="width100p ajaxForm dataBorder">
		<tr>
			<td class="pad10x">
	{{ form_legacy('back/index/subsubcategorysave') }}
		{{ hidden_field('id','id':'','value':'') }}
		<select name="subcategory" id="subcategory">
		<option value="0">Reset &amp; Choose Sub-Category ...</option>
		{% for subcategory in subcategories %}<option value="{{subcategory.id}}">{{subcategory.subcategory_name}}</option>{% endfor %}
		</select>
		{{ text_field('sscname','value':'') }}
		{{ submit_button('Save','id':'productinsert','class':'pad8x width100p') }}
	{{end_form()}}
			</td>
		</tr>	
	</table>
	<p class="bg0d6077 colorFFF bold pad10x marginB8x footRadius">&nbsp;</p>












{#


<h4 class="bg666 colorFFF pad10x">Insert Category</h4>
	{{ form_legacy('back/index/categorysave') }}
		{{ text_field('catname','value':'') }}
		{{ submit_button('Save','id':'productinsert') }}
	{{end_form()}}

<hr/>
<h4 class="bg666 colorFFF pad10x">Insert Sub Category</h4>
	{{ form_legacy('back/index/subcategorysave') }}
		{{ hidden_field('id','id':'','value':'') }}
		<select name="category" id="category">
		<option value="0">Reset &amp; Choose Category ...</option>
		{% for category in categories %}<option value="{{category.id}}">{{category.categoryname}}</option>{% endfor %}
		</select>	 
		{{ text_field('subcatname','value':'') }}
		{{ submit_button('Save','id':'productinsert') }}
	{{end_form()}}
<hr/>
<h4 class="bg666 colorFFF pad10x">Insert Sub-Sub Category</h4>
	{{ form_legacy('back/index/subsubcategorysave') }}
		{{ hidden_field('id','id':'','value':'') }}
		<select name="subcategory" id="subcategory">
		<option value="0">Reset &amp; Choose Sub-Category ...</option>
		{% for subcategory in subcategories %}<option value="{{subcategory.id}}">{{subcategory.subcategory_name}}</option>{% endfor %}
		</select>
		{{ text_field('sscname','value':'') }}
		{{ submit_button('Save','id':'productinsert') }}
	{{end_form()}}	

#}

</article>
<article class="rc2">&nbsp;</article>
</section>	
{# End #}
{% endblock %}
