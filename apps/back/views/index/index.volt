{% block content %}{# Begin #}<!DOCTYPE html>
<html dir="ltr" lang="en-US">
<head>
<title></title>
{{ stylesheet_link('css/css_compressed.php') }}
<style type="text/css">
table{margin:0 auto;border:1px solid #eee;border-collapse:collapse;width:250px;font-size:small;}
thead:nth-child(odd) { background-color:#eee }
</style>
<link rel='shortcut icon' href="{{url.getBaseUri('')}}img/favicon.png">
</head>
<body>
{% if flashSession.has() %}{{ flashSession.output() }}{% endif %}
{{ form_legacy('back/index/login','id':'logged','autocomplete':'off') }}
<table class=""><thead><tr><td colspan="3">Login...</td></tr></thead><tbody><tr><td>User</td><td style="width:2px">:</td><td>{{ text_field('mail','placeholder':'Your email') }}</td></tr><tr><td>Password</td><td style="width:2px">:</td><td>{{ password_field('passwd','placeholder':'Your password') }} {{hidden_field( security.getTokenKey(), 'value':security.getToken() )}}</td></tr></tbody><tr><td colspan="3">{{ submit_button('Login','id':'login') }}</td></tr></table>	
{{end_form()}}
</body></html>
{# End #}
{% endblock %}