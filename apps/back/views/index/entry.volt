{% extends "layouts/main.volt" %}
{% block content %}
{# Begin #}
<section class="row">

<article class="rc12">
	<p class="hTitle colorFFF pad10x radiusTL radiusTR">{% if aspect === '1' %}UPDATE MODE ACTIVATED{% else %}ENTRY MODE ACTIVATED{% endif %}</p>
	{{ form_legacy(action, 'enctype':'multipart/form-data') }}
	<table id="form" class="ajaxForm width100p">
		<tbody>	
			<tr>
				<td class="width50p">
					<p class="formbg"><label>STOCK AVAILABLE : </label> <input type="checkbox" value="1" name="stock" {% if stock === 1 %}checked="checked"{% endif %}/></p>
					<div class="formbg"><label>CHOOSE STAGE : </label>
					Default<input type="radio" name="stage" value="1" {% if pstage === '1' %}checked="checked"{% endif %}/>
					Featured<input type="radio" name="stage" value="2" {% if pstage === '2' %}checked="checked"{% endif %}/> 
					Flash Deal<input type="radio" name="stage" value="3" {% if pstage === '3' %}checked="checked"{% endif %}/> 
					More to Love<input type="radio" name="stage" value="4" {% if pstage === '4' %}checked="checked"{% endif %}/></div>
					<div class="formbg "><label>SELLERS GUARANTEE / WARRANTY : </label>
						<select name="warranty">
							<option value="0">Choose Guarantee / Warranty...</option>
							<option value="1">7 days replacement guarantee.</option>
							<option value="2">15 days replacement guarantee.</option>
							<option value="3">1 month service warranty.</option>
							<option value="4">3 months service warranty.</option>
							<option value="5">6 months service warranty.</option>
							<option value="6">1 year service warranty.</option>
							<option value="7">3 days Full Refund.</option>
							<option value="8">1 Month Full Refund.</option>
						</select>
					</div>
					<div class="formbg"><label>CATEGORY : *</label>
						<select name="category" id="category">
						<option value="0">Reset &amp; Choose Category ...</option>
						{% for category in categories %}<option {% if category.id === pcid %}selected="selected"{% endif %} value="{{category.id}}">{{category.categoryname}}</option>{% endfor %}
						</select>
					</div>
					<div class="formbg"><label>SUB-CATEGORY : *</label>
					{% if aspect === '1' %}	
						<select name="subcategory" id="subcategory">
						<option value="0">Reset &amp; Choose Category ...</option>
						{% for subcategory in subcategories %}<option {% if subcategory.id === pscid %}selected="selected"{% endif %} value="{{subcategory.id}}">{{subcategory.subcategory_name}}</option>{% endfor %}
						</select>
					{% else %}
						<select name="subcategory" id="subcategory" disabled="disabled"><option value="0">Choose Sub-Category ...</option></select>
					{% endif %}
					</div>
					<div class="formbg"><label>SUB-SUB-CATEGORY : *</label>
					{% if aspect === '1' %}
						<select name="ssc" id="ssc">
						<option value="0">Reset &amp; Choose Category ...</option>
						{% for Sscat in ssc %}<option {% if Sscat.id === psscid %}selected="selected"{% endif %} value="{{Sscat.id}}">{{Sscat.ssctitle}}</option>{% endfor %}
						</select>
					{% else %}
						<select name="ssc" id="ssc" disabled="disabled"><option value="0">Choose Sub-Sub-Category ...</option></select>
					{% endif %}
					</div>
	<div class="formbg"><label>SIZE : </label>
		<select id="scales" name="scales">
			<option value="0">Choose Measurement Scale ...</option>
			<option value="1">Shirt</option>
			<option value="2">Finger Ring</option>
			<option value="3">Shoe</option>
			<option value="4">Waist</option>
			<option value="5">Wrist</option>
			<option value="6">Brass</option>
			<option value="7">Weight</option>
		</select>
		<input id="scaletype" name="scaletype" type="hidden" value="{{scaletype}}" />
		<input id="dataArr" type="hidden" value="<?php echo($psize);?>" />
    	<div id="xe" data-class="{{scaletype}}"> 
			<?php if($aspect === '1'){ $x = explode(',',$psize); ?>
				{% for sc in x %} 
					<?php $status = in_array($sc, $x) ? 'checked="checked"' : ''; ?>	
					{{sc}}<input class="old" type="checkbox" name="psize[]" {{status}} value="{{sc}}" />
				{% endfor %} 
			<?php } ?>
		</div>
	</div>
	<div class="formbg"><label>WEIGHT : </label>
		<select id="weights" name="weights">
			<option value="0">Choose Weight ...</option>
			<option value="gold">Gold</option>
			<option value="mass">Mass</option>
		</select>
	</div>
					<div class="formbg"><label>IMAGES/COLOR : *</label>
					{{ file_field('product_image[]','multiple':'multiple','class':'upload','id':'uploads') }}
						<br/><div class="previewImg"></div>
					</div>
				</td>
				<td class="width50p">
					<div class="formbg"><label>PRODUCT CODE : </label>
<input name="pcode" type="text" pattern="[A-Z0-9\-]+" placeholder="K-0XO18" value="<?php if($pcode === 0 || $pcode === '0'){}else{echo($pcode);}?>"/>
					</div>
					<div class="formbg"><label>PRODUCT TITLE : *</label>{{ text_field('product_title','pattern':'[a-zA-Z0-9% ]+','placeholder':'Pure Cotton Kids Pant','value':ptitle) }}</div>
					<div class="formbg"><label>PRODUCT PRICE : *</label>{{ text_field('product_price','pattern':'[0-9]+','placeholder':'5000','value':pprice) }}</div>
					<div class="formbg"><label>DISCOUNT PRICE : </label>
<input name="product_discount" type="text" pattern="[0-9]+" placeholder="4300" value="<?php if($pdiscount === 0 || $pdiscount === '0'){}else{echo($pdiscount);}?>"/>
					</div>
					<div class="formbg"><label>COUPON CODE : </label>
<input name="pcoupon" type="text" pattern="[a-zA-Z0-9]+" placeholder="VXG22L" value="<?php if($pcoupon === 0 || $pcoupon === '0'){}else{echo($pcoupon);}?>"/>
					</div>	
					<div class="formbg"><label>COUPON DISCOUNT [ % ] : <a id="couponTips" href="javascript:void(0);"> <i class="ico-info"></i> </a></label>
<input name="coupondiscount" type="text" pattern="[0-9]+" placeholder="15" value="<?php if($couponless === 0 || $couponless === '0'){}else{echo($couponless);}?>"/>
					</div>
					<div class="formbg"><label>KEYWORDS : </label>{{ text_field('keywords','pattern':'[a-zA-Z,0-9 ]+','placeholder':'lehanga,cloths,women,indian,pakistani,guzrati,fashion','value':keyword) }}</div>	
					<div class="formbg"><label>SPECIFICATIONS : *</label>
						{{ text_area('specification','pattern':'[a-zA-Z0-9% ]+','placeholder':'Very good quality and heavy duty pure cotton pant. Imported from US','value':pdesc,'cols':'16','rows':'2') }}
					</div>
					<div class="formbg">&nbsp;</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="formbg">
					{% if aspect === '1' %}
						{{ hidden_field('id','id':id,'value':id) }}
						<p class="submitc">{{submit_button('UPDATE','class':'neumorphism pad10x cursorpoint width90p bold bgEEE')}}</p>
					{% else %}
						<p class="submitc">{{submit_button('SAVE','class':'neumorphism pad10x cursorpoint width90p bold bgEEE')}}</p>
					{% endif %}
					</div>
				</td>
			</tr>
		</tbody>
		<tr>
			<td><div class="loader nodisp fxsmall txt_center"><img data-src="img/loading.gif" />Loading Expansion...</div></td>
		</tr>
	</table>{{end_form()}}
	<p class="hTitle colorFFF pad10x radiusBL radiusBR">&nbsp;</p>
</article>	


{#
<article class="rc1">&nbsp;</article>
<article class="rc10">

<div id="form" class="ajaxForm width100p">
<p class="hTitle colorFFF pad10x radiusTL radiusTR">{% if aspect === '1' %}UPDATE MODE ACTIVATED{% else %}ENTRY MODE ACTIVATED{% endif %}</p>
{{ form_legacy(action, 'enctype': 'multipart/form-data') }}
{% if aspect === '1' %}
	{{ hidden_field('id','id':id,'value':id) }}
{% endif %}
	<div class="formbg"><label>CHOOSE STAGE : </label>
	Default<input type="radio" name="stage" value="1" {% if pstage === '1' %}checked="checked"{% endif %}/>
	Featured<input type="radio" name="stage" value="2" {% if pstage === '2' %}checked="checked"{% endif %}/> 
	Flash Deal<input type="radio" name="stage" value="3" {% if pstage === '3' %}checked="checked"{% endif %}/> 
	More to Love<input type="radio" name="stage" value="4" {% if pstage === '4' %}checked="checked"{% endif %}/></div>
	<div class="formbg"><label>Sellers Guarantee/Warranty : </label>
		<select name="warranty">
			<option value="0">Choose Guarantee / Warranty...</option>
			<option value="1">7 days replacement guarantee.</option>
			<option value="2">15 days replacement guarantee.</option>
			<option value="3">1 month service warranty.</option>
			<option value="3">3 days Full Refund.</option>
		</select>
	</div>
	<div class="formbg"><label>CATEGORY : </label>
		<select name="category" id="category">
		<option value="0">Reset &amp; Choose Category ...</option>
		{% for category in categories %}<option {% if category.id === pcid %}selected="selected"{% endif %} value="{{category.id}}">{{category.categoryname}}</option>{% endfor %}
		</select>
	</div>
	<div class="formbg"><label>SUB-CATEGORY : </label>
	{% if aspect === '1' %}	
		<select name="subcategory" id="subcategory">
		<option value="0">Reset &amp; Choose Category ...</option>
		{% for subcategory in subcategories %}<option {% if subcategory.id === pscid %}selected="selected"{% endif %} value="{{subcategory.id}}">{{subcategory.subcategory_name}}</option>{% endfor %}
		</select>
	{% else %}
		<select name="subcategory" id="subcategory" disabled="disabled"><option value="0">Choose Sub-Category ...</option></select>
	{% endif %}		
	</div>
	<div class="formbg"><label>SUB-SUB-CATEGORY : </label>
	{% if aspect === '1' %}
		<select name="ssc" id="ssc">
		<option value="0">Reset &amp; Choose Category ...</option>
		{% for Sscat in ssc %}<option {% if Sscat.id === psscid %}selected="selected"{% endif %} value="{{Sscat.id}}">{{Sscat.ssctitle}}</option>{% endfor %}
		</select>
	{% else %}
		<select name="ssc" id="ssc" disabled="disabled"><option value="0">Choose Sub-Sub-Category ...</option></select>
	{% endif %}		
	</div>
	<div class="formbg"><label>PRODUCT PRICE : </label>{{ text_field('product_price','pattern':'[0-9]+','placeholder':'5000','value':pprice) }}</div>
	<div class="formbg"><label>DISCOUNT PRICE : </label>{{ text_field('product_discount','pattern':'[0-9]+','placeholder':'4300','value':pdiscount) }}</div>
	<div class="formbg"><label>COUPON CODE : </label>{{ text_field('pcoupon','pattern':'[a-zA-Z0-9]+','placeholder':'VXG22L','value':pcoupon) }}</div>	
	<div class="formbg"><label>COUPON DISCOUNT [ % ]: </label>{{ text_field('coupondiscount','pattern':'[0-9]+','placeholder':'10','value':couponless) }}</div>	
	<div class="formbg"><label>SIZE : </label>
		<select id="scales" name="scales">
			<option value="0">Choose Measurement Scale ...</option>
			<option value="1">Shirt</option>
			<option value="2">Finger Ring</option>
			<option value="3">Shoe</option>
			<option value="4">Waist</option>
			<option value="5">Wrist</option>
			<option value="6">Brass</option>
			<option value="7">Weight</option>
		</select>
		<input id="scaletype" name="scaletype" type="hidden" value="{{scaletype}}" />
		<input id="dataArr" type="hidden" value="<?php echo($psize);?>" />
    	<div id="xe" data-class="{{scaletype}}"> 
			<?php if($aspect === '1'){ $x = explode(',',$psize); ?>
				{% for sc in x %} 
					<?php $status = in_array($sc, $x) ? 'checked="checked"' : ''; ?>	
					{{sc}}<input class="old" type="checkbox" name="psize[]" {{status}} value="{{sc}}" />
				{% endfor %} 
			<?php } ?>
		</div>
	</div>
	<div class="formbg"><label>WEIGHT : </label>
		<select id="weights" name="weights">
			<option value="0">Choose Weight ...</option>
			<option value="gold">Gold</option>
			<option value="mass">Mass</option>
		</select>
	</div>
	<div class="formbg"><label>Product Code : </label>
		<input type="text" name="pcode" pattern="[A-Z0-9\-]+" placeholder="PC-0XO18" />
	</div>		
	<div class="formbg"><label>PRODUCT TITLE : </label>{{ text_field('product_title','pattern':'[a-zA-Z0-9% ]+','placeholder':'Pure Cotton Kids Pant','value':ptitle) }}</div>	
	<div class="formbg"><label>KEYWORDS : </label>{{ text_field('keywords','pattern':'[a-zA-Z,0-9 ]+','placeholder':'lehanga,cloths,women,indian,pakistani,guzrati,fashion','value':keyword) }}</div>	
	<div class="formbg"><label>SPECIFICATIONS : </label>
		{{ text_area('specification','pattern':'[a-zA-Z0-9% ]+','placeholder':'Very good quality and heavy duty pure cotton pant. Imported from US','value':pdesc,'cols':'16','rows':'2') }}
	</div>	
	<div class="formbg"><label>IMAGES/COLOR : </label>
	{{ file_field('product_image[]','value':pimage,'multiple':'multiple','class':'upload','id':'uploads') }}
		<br/><div class="previewImg"></div>
	</div>
	{% if aspect === '1' %}
		<p class="submitc">{{submit_button('UPDATE','class':'neumorphism pad10x cursorpoint width90p bold bgEEE')}}</p>
	{% else %}
		<p class="submitc">{{submit_button('SAVE','class':'neumorphism pad10x cursorpoint width90p bold bgEEE')}}</p>
	{% endif %}
{{end_form()}}
<div class="loader nodisp fxsmall txt_center"><img data-src="img/loading.gif" />Loading Expansion...</div>
<p class="hTitle colorFFF pad10x radiusBL radiusBR">&nbsp;</p>
</div>

</article>
<article class="rc1">&nbsp;</article>
#}


</section>	
{# End #}
{% endblock %}
