{% extends "layouts/main.volt" %}{% block content %}{# Begin #}
<section class="row">
    <article class="ads">&nbsp;</article>
    <article class="xDatas">
        {% if pcount > 0 %}
        {% for datax in data %}
            <a class="bgEEE pad10x color333" href="{{url.getBaseUri('')}}index/getsscid/{{ datax.id|url_encode }}">{{datax.ssctitle}}</a>
        {% endfor %}
        {% else %}<p class="width100p fxxLarge bold color333 txtCenter pad10x">No Data Found</p>{% endif %}
    </article>
    <article class="ads">&nbsp;</article>   
</section>{# End #}{% endblock %}