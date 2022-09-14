{% extends "layouts/main.volt" %}
{% block content %}
{# Begin #}
<section class="row">
	<article class="rc1">&nbsp;</article>
	<article class="rc10">
		{{ form_legacy(action, 'enctype': 'multipart/form-data') }}
		{% if aspect === '1' %}<p class="bg0d6077 colorFFF bold pad10x headRadius">Update Mode Activated</p>{% else %}<p class="bg0d6077 colorFFF bold pad10x headRadius">Entry Mode Activated</p>{% endif %}
		<div class="display-table fsmall width100p dataBorder ajaxForm">
			<div>
		        <div class="w22p">Stage</div><div>:</div>
		        <div>
		        	Default : <input type="radio" name="stage" value="1"{% if stage === '1' %} checked{% endif %}/>
		        	Featured : <input type="radio" name="stage" value="2"{% if stage === '2' %} checked{% endif %}/>
		        	Flash Deal : <input type="radio" name="stage" value="3"{% if stage === '3' %} checked{% endif %}/>
		        	More to Love<input type="radio" name="stage" value="4"{% if stage === '4' %} checked{% endif %}/>
		        </div>
		    </div>	
			<div>
				<div class="w22p">Category</div><div>:</div>
				<div>
					<select name="category" id="category">
						<option value="0">Choose Category ...</option>
						{% for category in categories %}<option value="{{category.id}}">{{category.categoryname}}</option>{% endfor %}
					</select>			
				</div>
			</div>
			<div>
				<div class="w22p">sub-Category</div><div>:</div><div><select name="subcategory" id="subcategory" disabled="disabled"><option value="0">Choose Sub-Category ...</option></select></div>
			</div>
			<div>
				<div class="w22p">Sub-Sub-Category</div><div>:</div><div><select name="ssc" id="ssc" disabled="disabled"><option value="0">Choose Sub-Sub-Category ...</option></select></div>
			</div>	
			<div>
				<div class="w22p">Product Title</div><div>:</div><div>{{ text_field('product_title','placeholder':'Honda GX4500 Gasoline Generator Set.','value':product_title) }}</div>
			</div>	
			<div>
				<div class="w22p">Product Price</div><div>:</div><div>{{ text_field('product_price','placeholder':'84500','value':product_price) }}</div>
			</div>
			<div>
				<div class="w22p">Discount Price</div><div>:</div><div>{{ text_field('pdiscount','placeholder':'82000','value':pdiscount) }}</div>
			</div>
			<div>
				<div class="w22p">Coupon Code</div><div>:</div><div>{{ text_field('pcoupon','placeholder':'HGX45G','value':pcoupon) }}</div>
			</div>
			<div>
				<div class="w22p">Coupon Discount %</div><div>:</div><div>{{ text_field('couponamount','placeholder':'5','value':couponamount) }}</div>
			</div>				
		    <div>
		    	<div class="w22p">Scale/Size</div><div>:</div><div>
		    		<select id="scales" name="scales">
			    		<option value="0">Choose Measurement Scale ...</option>
			    		<option value="shirtscale">Shirt</option>
			    		<option value="ringscale">Finger Ring</option>
			    		<option value="shoescale">Shoe</option>
			    		<option value="waistscale">Waist</option>
			    		<option value="wristscale">Wrist</option>
			    		<option value="bustscale">Bust</option>
			    		<option value="weightscale">Weight</option>
			    	</select>
		    		<div id="xe"></div>
		    	</div>
		    </div>	
			<div>
				<div class="w22p">Keywords</div><div>:</div><div>{{ text_field('keywords','placeholder':'Lehanga,Kurti,Sharee,Cloths,Women,Pakistani,Guzrati','value':product_keyword) }}</div>
			</div>
			<div>
				<div class="w22p">Specification</div><div>:</div><div>{{ text_area('specification','placeholder':'Pure Cotton, Imported from US. Low cost and very Good Quality.','value':product_desc,'cols':'16','rows':'3') }}</div>
			</div>
			<div>
				<div class="w22p">Image with color</div><div>:</div><div>{{ file_field('product_image[]','value':product_image,'multiple':'multiple','class':'upload','id':'uploads') }}<br/><div class="previewImg"></div></div>
			</div>
	{% if aspect === '1' %}
		<div>
			<div>{{ submit_button('Update','id':'productupdate','class':'margin4x neumorphism cursorpoint width100p bold pad4x bgEEE') }}</div>
		</div>
	{% else %}
		<div>
			<div>{{ submit_button('Save','id':'productinsert','class':'margin4x neumorphism cursorpoint width100p bold pad4x bgEEE') }}</div>
		</div>		
	{% endif %}
		</div>
		<p class="bg0d6077 colorFFF bold pad10x footRadius">&nbsp;</p>
		{{ end_form() }}
	</article>
	<article class="rc1">&nbsp;</article>
</section>	
{# End #}
{% endblock %}
