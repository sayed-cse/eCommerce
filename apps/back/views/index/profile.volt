{% extends "layouts/main.volt" %}
{% block content %}
{# Begin #}
<section class="row">
{% for user in users %}
<img class="width100x height100x" alt="{{user.shopname}}" data-src="{{url.getBaseUri("")}}uploads/users/{{user.servicelogo}}" /><br/>
Registered Name : {{user.name}}<br/>
Vendor : {{user.shopname}}<br/>
Contact : {{user.contact}}<br/>
Email : {{user.email}}<br/>
Address : {{user.address}}<br/>
{% if user.type === 's' and user.active === '1' %}
Progress : <a id="bstatus" href="javascript:void(0);">Sale Status</a><br/>
{% endif %}
Rating : <i class="ico-star"></i><br/>
Verified : {% if user.verified is 1 %}<i class="ico-verified"></i>{% else %}<i class="ico-verifiedNo"></i>{% endif %}<br/>
{% endfor %}
</section>	
{# End #}
{% endblock %}	
