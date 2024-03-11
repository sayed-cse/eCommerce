{% extends "layouts/main.volt" %}
{% block content %}{# Begin #}
<section class="row bgEEE pad10x">
{% for user in users %}
Registered Name : {{user.name}}<br/>
Email : {{user.mail}}<br/>
Status : {% if user.active is 1 %} Active {% else %}Inactive{% endif %}
{% endfor %}
</section>{# End #}{% endblock %}
