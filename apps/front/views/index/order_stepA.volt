{% extends "layouts/main.volt" %}
{% block content %}
{# Begin #}
<section class="bgFFF">
	<article class="item">&nbsp;</article>
	<article class="item">
		{% if aspect === '1' %}<p class="bg0d6077 colorFFF bold pad10x headRadius">Update Mode Activated</p>{% else %}<p class="bg0d6077 colorFFF bold pad10x headRadius">Entry Mode Activated</p>{% endif %}
{{ form_legacy(action) }}		
		<div class="display-table fSmall width100p ajaxForm dataBorder">
		    <div class="w22p">
		    	<div>Full Name</div><div>:</div><div>{{ text_field('fname','value':fname) }}</div>
		    </div>
		    <div>
		    	<div>Phone Number</div><div>:</div><div>{{ text_field('sphone','value':sphone) }}</div>
		    </div> 
		    <div>
		    	<div>Region</div><div>:</div><div>
					<select name="sregion" id="sregion">
					<option value="0">Reset &amp; Choose Category ...</option>
					{% for region in regions %}<option {% if region.rid is srid %}selected="selected"{% endif %} value="{{region.rid}}">{{region.regionname}}</option>{% endfor %}
					</select>
		    	</div>
		    </div> 
		    <div>
		    	<div>City</div><div>:</div><div>
					<select name="scity" id="scity">
					<option value="0">Reset &amp; Choose Category ...</option>
					{% for city in citys %}<option {% if city.cid is scid %}selected="selected"{% endif %} value="{{city.cid}}">{{city.cityname}}</option>{% endfor %}
					</select>
		    	</div>
		    </div> 
		    <div>
		    	<div>Area</div><div>:</div><div>
					<select name="sarea" id="sarea">
					<option value="0">Reset &amp; Choose Category ...</option>
					{% for area in areas %}<option {% if area.aid is said %}selected="selected"{% endif %} value="{{area.aid}}">{{area.areaname}}</option>{% endfor %}
					</select>
		    	</div>
		    </div>	        
		    <div>
		    	<div>Address</div><div>:</div><div>{{text_area('saddress','value':saddress)}}</div>
		    </div> 
			<div>
				<div>
				{{ hidden_field('dcharge','value':dcharge) }}
				{{ hidden_field('suserid','suserid':suserid,'value':suserid) }}
				{% if aspect === '1' %}				
					{{ submit_button('UPDATE & SHIP TO THIS ADDRESS','formaction':action,'enctype':'application/x-www-form-urlencoded','formmethod':'post','id':'shipupd','class':'margin8x neumorphism cursorPoint width100p bold pad4x bgEEE') }}
				{% else %}
					{{ submit_button('SAVE & SHIP TO THIS ADDRESS','formaction':action,'enctype':'application/x-www-form-urlencoded','formmethod':'post','id':'shipupd','class':'margin8x neumorphism cursorPoint width100p bold pad4x bgEEE') }}
				{% endif %}				
				</div>
			</div>
		</div>
{{end_form()}}		
		<div class="loader nodisp fxSmall txtCenter"><img alt="Loader" data-src="{{url.getBaseUri('')}}img/loading.gif" />Loading Expansion...</div>
		<p class="bg0d6077 colorFFF bold pad10x footRadius">&nbsp;</p>
	</article>
	<article class="item">&nbsp;</article>
</section>
{# End #}
{% endblock %}




















{#

	<article class="rc8">
	<dl class=''>
		<dt>{% if aspect === '1' %}<h4 class="bgF5F color666 pad10x">Update Delivery Information</h4>{% else %}<h4 class="bgF5F color666 pad10x">Enter Delivery Information</h4>{% endif %}</dt>
		<dd>
{% if aspect === '1' %}

	{{ form_legacy() }}
	<div class="display-table fsmall width100p ajaxForm">
		{{ hidden_field('sid','sid':id,'value':id) }}
		{{ hidden_field('suserid','suserid':suserid,'value':suserid) }}
	    <div>
	    	<div>Full Name</div><div>:</div><div>{{ text_field('fname','value':fname) }}</div>
	    </div>
	    <div>
	    	<div>Phone Number</div><div>:</div><div>{{ text_field('sphone','value':sphone) }}</div>
	    </div> 
	    <div>
	    	<div>Region</div><div>:</div><div>
				<select name="sregion" id="sregion">
				<option value="0">Reset &amp; Choose Category ...</option>
				{% for region in sregion %}<option {% if region.rid == srid %}selected="selected"{% endif %} value="{{region.rid}}">{{region.regionname}}</option>{% endfor %}
				</select>
	    	</div>
	    </div> 
	    <div>
	    	<div>City</div><div>:</div><div>
				<select name="scity" id="scity">
				<option value="0">Reset &amp; Choose Category ...</option>
				{% for city in scity %}<option {% if city.cid == scid %}selected="selected"{% endif %} value="{{city.cid}}">{{city.cityname}}</option>{% endfor %}
				</select>
	    	</div>
	    </div> 
	    <div>
	    	<div>Area</div><div>:</div><div>
				<select name="sarea" id="sarea">
				<option value="0">Reset &amp; Choose Category ...</option>
				{% for area in sarea %}<option {% if area.aid == said %}selected="selected"{% endif %} value="{{area.aid}}">{{area.areaname}}</option>{% endfor %}
				</select>
	    	</div>
	    </div>	
	    <div>
	    	<div>Delivery Charge</div><div>:</div><div><select name="dcharge" id="dcharge">
				<option value="{{dcharge}}">{{dcharge}}</option>
	    	</select></div>
	    </div>	        
	    <div>
	    	<div>Address</div><div>:</div><div>{{text_area('saddress','value':saddress)}}</div>
	    </div> 
		<div>
			<div>{{ submit_button('Update & ship to this address','formaction':action,'enctype':'application/x-www-form-urlencoded','formmethod':'post','id':'shipupd','class':'marginAuto neumorphism cursorpoint width90p bold pad4x bgEEE') }}</div>
		</div>	    	    	    	       	    	    	    	    	    	    	    	    	    
{% else %}

	{{ form_legacy('autocomplete':'off') }}
	<div class="display-table fsmall width100p ajaxForm">
		{{ hidden_field('suserid','suserid':suserid,'value':suserid) }}
	    <div>
	    	<div>Full Name</div><div>:</div><div>{{ text_field('fname','value':fname) }}</div>
	    </div>
	    <div>
	    	<div>Phone Number</div><div>:</div><div>{{ text_field('sphone','value':sphone) }}</div>
	    </div> 
	    <div>
	    	<div>Region</div><div>:</div><div>
			<select name="sregion" id="sregion">
				<option value="0">Choose Region ...</option>{% for region in sregion %}<option value="{{region.rid}}">{{region.regionname}}</option>{% endfor %}
			</select>
	    	</div>
	    </div> 
	    <div>
	    	<div>City</div><div>:</div><div><select name="scity" id="scity" disabled="disabled"><option value="0">Choose City ...</option></select></div>
	    </div> 
	    <div>
	    	<div>Area</div><div>:</div><div><select name="sarea" id="sarea" disabled="disabled"><option value="0">Choose Area ...</option></select></div>
	    </div>	 
	    <div>
	    	<div>Delivery Charge</div><div>:</div><div><select name="dcharge" id="dcharge" disabled="disabled"></select></div>
	    </div>	       
	    <div>
	    	<div>Address</div><div>:</div><div>{{text_area('saddress','value':saddress)}}</div>
	    </div> 	
			<div>
				<div>{{ submit_button('Save & ship to this address','formaction':action,'enctype':'application/x-www-form-urlencoded','formmethod':'post','id':'shipbtn','class':'marginAuto neumorphism cursorpoint width90p bold pad4x bgEEE') }}</div>
			</div>	    
{% endif %}
		</div>
	{{end_form()}}
		<div class="loader nodisp fxsmall txtCenter"><img data-src="img/loading.gif" />Loading Expansion...</div>
		</dd>
	</dl>
	</article>
	<article class="rc2">&nbsp;</article>


#}