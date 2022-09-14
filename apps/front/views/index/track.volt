{% extends "layouts/main.volt" %}
{% block content %}{# Begin #}
<section class="row">
	<article class="rc2">&nbsp;</article>
	<article class="rc8 bgEEE">
	{% for data in data %}
		{{data.color}}
	{% endfor %}
	</article>
	<article class="rc2">&nbsp;</article>
</section>{# End #}{% endblock %}