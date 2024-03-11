{% extends "layouts/main.volt" %}
{% block content %}
{# Begin #}
<section class="row">
	<article class="color333">
<h1>Invoice</h1>
<table>
    <thead>
        <tr>
            <th>Order ID</th>
            <th>Quantity</th>
            <th>Price</th>
        </tr>
    </thead>
    <tbody>
        {% for item in myorder %}
        <tr>
            <td>{{item.quantity}}</td>
            <td>{{ item.quantity }}</td>
            <td>{{ item.price }}</td>
            <td>{{ item.shipingcost }}</td>
        </tr>
        {% endfor %}
    </tbody>
    <tfoot>
        <tr>
            <td colspan="2">Total:</td>
            <td>{{ total }}</td>
        </tr>
    </tfoot>
</table>

<!-- Print as PDF button -->
<a href="{{url.getBaseUri('')}}index/doPdf" class="btn btn-primary">Print as PDF</a>





	</article>
</section>







{# End #}
{% endblock %}