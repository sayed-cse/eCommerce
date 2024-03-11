<?php #ob_start("ob_compress");function ob_compress($buf = null){return preg_replace(array('/<!--(.*)-->/Uis',"/[[:blank:]]+/"),array('',' '),str_replace(array("\n","\r","\t"),'',$buf) );} 
$nonce = bin2hex(base64_encode(random_bytes(32).date('dmYHis'))); ?>{{ get_doctype() }}
<html dir="ltr" lang="en-US">
<head>
<title>{{getTitle()}}</title>
<?php 
header("Content-Security-Policy: default-src 'self' cdnjs.cloudflare.com *.facebook.net *.facebook.com *.fbcdn.net *.fbsbx.com; object-src 'none'; base-uri 'self'; script-src 'self' 'nonce-$nonce' 'unsafe-inline' cdnjs.cloudflare.com *.facebook.net *.facebook.com *.fbcdn.net *.fbsbx.com; img-src 'self' data:; style-src 'self' fonts.googleapis.com; upgrade-insecure-requests; font-src 'self' data: fonts.gstatic.com; manifest-src 'self'; worker-src 'self'; media-src 'self'; form-action 'self'; frame-src *.facebook.net *.facebook.com *.fbcdn.net *.fbsbx.com; frame-ancestors *.facebook.net *.facebook.com *.fbcdn.net *.fbsbx.com;");
header("Access-Control-Allow-Origin: *;X-XSS-Protection: 1; mode=block;X-Frame-Options:DENY; X-Content-Type-Options nosniff");
?>
<meta charset='utf-8'/>
<meta name='viewport' content='width=device-width'/>
<meta property='og:locale' content='en_US'/>
<meta http-equiv='x-dns-prefetch-control' content='on'/>
<meta name='HandheldFriendly' content='true'/>
<meta name='format-detection' content='telephone=yes'/>
<meta name='application-name' content='{{siteName}}'/>
<meta name='mobile-web-app-capable' content='yes'/>
<meta name='apple-mobile-web-app-capable' content='yes'/>
<meta name='msapplication-starturl' content="{{url.getBaseUri('')}}"/>
<meta name='robots' content="{{ dynarobot }}"/>
<meta name='description' content="{{ dynadesc }}"/>
<meta name='keywords' content="{{ dynakey }}"/>
<meta name='rating' content="general"/>
<meta name='author' content="/\/\unaz:+8801615577997,+8801915577997"/>
<meta name="google-site-verification" content=""/>
<meta property='og:type' content="{{ dynaArticleTitle }}"/>
<meta property='og:url' content="{{url.getBaseUri('')}}{{ dynaOgUrl }}"/>
<meta property="og:title" content="{{ dynaArticleTitle }}"/>
<meta property="og:site_name" content='{{ siteName }}'/>
<meta property="og:description" content="{{ dynadesc }}"/>
<meta property="og:locale" content="en_US"/>
<meta property="article:author" content='dyneGetAuthor'/>
<meta property="article:publisher" content='{{articlePublisher}}'/>
<meta property="og:image" content='{{url.getBaseUri("")}}img/favicon.png'/>
{#{ tag_html("link",["rel": "preload","as": "style","href": url.getBaseUri('')~"css/css_compressed.php"]) }#}
{#{ tag_html("link",["rel": "preload","as": "script","href": url.getBaseUri('')~"js/jquery.js"]) }#}
{{ stylesheet_link('css/scss.css') }}
<!-- <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"> -->
<link rel='publisher' href="{{articlePublisher}}"/>
<link rel='shortcut icon' href="{{url.getBaseUri('')}}img/favicon.png"/>
<link rel='shortlink' href="{{url.getBaseUri('')}}"/>
<base href="{{url.getBaseUri('')}}" target='_self'/> 
</head><body>
{% block header %} {{hidden_field( security.getTokenKey(), 'value':security.getToken() )}}
<section class="row bgEEE">
    <header class="hdft autoHeight marginAuto">{% if flashSession.has() %}{{ flashSession.output() }}{% endif %}
<article class='rc12 bg444 pad0x margin0x height30x'>
    <ul id='bar_l' class='floatL'>
        <li><span class="ico-bell"></span></li>
        <li><a href="{{url.getBaseUri('')}}back/index/entry">Home</a></li>
        <li><a href="{{url.getBaseUri('')}}back/index/inscategory">Category</a></li>
        <li><a href="{{url.getBaseUri('')}}back/index/myorders">Orders</a></li>
        <li><a href="{{url.getBaseUri('')}}back/index/myposts">MyPosts</a></li>
        <li><a href="{{url.getBaseUri('')}}back/index/Cashclean"><i class="ico-refresh colorFFF"></i></a></li>
    </ul>
    <ul id="bar_r" class="floatR"> 
        <li class="fSmall">{% if(not(uname is empty)) %}: <a href="{{url.getBaseUri('')}}back/index/profile"><span class="ico-user"></span> {{uname}}</a> : | <a href="{{url.getBaseUri('')}}back/index/logout">Logout</a>{% else %}<span class="ico-user"></span>{% endif %}</li>
        <li class="menu"><span class="ico-sun"></span>                    
            <ul class="d">
            {% if level === '1' %}
                <li>{{ link_to('users/profile/'~uid,'Profile') }}</li>
                <li>{{ link_to("users/changeSecurity","Change Password") }}</li>
                <li>{{ link_to("back/index/logout","Logout") }}</li>
            {% elseif level === '2' %}
                <li>{{ link_to('users/profile/'~uid,'Profile') }}</li>
                <li>{{ link_to("users/changeSecurity","Change Password") }}</li>
                <li>{{ link_to("back/index/logout","Logout") }}</li>
            {% else %}
                <li>{{ link_to("users/profile","Profile") }}</li>
                <li>{{ link_to("users/priority","Privilege") }}</li>
                <li>{{ link_to("index/Cashclean","Clear") }}</li>
                <li>{{ link_to("back/index/logout","Logout") }}</li>
            {% endif %}                    
            </ul>
        </li>              
    </ul>
</article>
<article class="rc12">
    <div class="rc3">
        <p>&nbsp;</p>
    <a href="{{url.getBaseUri('')~'back'}}"><h1 class='fxxlarge colorFFF bold txt-sh'>{{siteName}}</h1></a>
    <p>&nbsp;</p><p>&nbsp;</p>
    </div>
    <div class="rc6">
&nbsp;
    </div>
    <div class="rc3">&nbsp;</div>
</article>
    </header>
</section>
{% endblock %}
<main>
{% block content %} {% endblock %}    
</main>
{% block footer %} 
<section class="row marginB0x bgEEE">
    <footer class="hdft fxsmall autoHeight marginAuto">
        <article class="rc3">&nbsp;</article>
        <article class="rc6 txt_center bold"><br/><br/>
<a href="javascript:void(0);">Aboutus</a> &vert; <a class="feedbacks" href="javascript:void(0);">Feedback</a> &vert; <a class="contacts" href="mailto:{{bizMail}}">Contact</a>&vert; <a href="javascript:void(0);">Intellectual Property Protection</a><br/> <a href="javascript:void(0);">Privacy Policy</a> &vert; <a href="javascript:void(0);">Legal Disclaimer</a> &vert; <a href="javascript:void(0);">Cookie Policy</a> &vert; <a href="javascript:void(0);">Terms &amp; Conditions</a><br/>
<?php $executionTime = round(microtime(true) - $_SERVER["REQUEST_TIME_FLOAT"],3);echo('page rendered in :'.$executionTime.' seconds'); ?> &vert; memory used <?php echo(round(memory_get_usage()/1048576,2).' MB'); ?>            
        </article>
<article class="rc3">
    <ul class="copyright">      
            <li><img alt="Developer Logo" title="Developed by: Firefly&reg;" class="firefly" src="data:image/gif;base64,R0lGODlhAQABAAD/ACwAAAAAAQABAAACADs=" data-src="<?php echo('data:image/png;base64,'.base64_encode(file_get_contents('img/bee.png'))); ?>" /><span class="dotfly"></span></li>
            <li><p class="vbar"></p></li>
            <li>
                <a title="facebook" href="https://www.facebook.com/lamptouch/"><span class="ico-fb"><b class="nodisp">Fbook</b></span></a>
                <a title="linkedin" href="https://www.linkedin.com/in/badrul-alam-abir-5859aa67/"><span class="ico-linkedin"><b class="nodisp">Linkedin</b></span></a>
                <a title="googleplus" href="https://plus.google.com/108538268418209533299"><span class="ico-gplus"><b class="nodisp">Gplus</b></span></a>
                <a title="twitter" href="https://twitter.com/LampTouch_info"><span class="ico-twitter"><b class="nodisp">Twitter</b></span></a>
                <a title="pinterest" href="https://nl.pinterest.com/lamptouch/pins/"><span class="ico-pinterest"><b class="nodisp">Pinterest</b></span></a>
                <a title="youtube" href="https://www.youtube.com/channel/UCGrwsvZBDJz0cIg9aUIWUVg"><span class="ico-utube"><b class="nodisp">Ytube</b></span></a>
                <a title="rssfeed" href="blog/feed"><span class="ico-rss"><b class="nodisp">Feed</b></span></a>                
                <a title="sitemap" href="sitemap"><span class="ico-sitemap"><b class="nodisp">Sitemap</b></span></a>
                <div class="bold">{{siteName}}<?php function copyright($year = null){$cYear = (int) date('Y');if($year === null || $year >= $cYear){$result = $cYear;}else{$result = $year.' - '.$cYear;}echo('<br/>Copyright &copy; '.$result.'.<br/>All Rights Reserved.<br>Developed By: <a href="mailto:webmaster.firefly@gmail.com">FireFly</a>&reg;');}copyright($copyYear);?><br/><a href="https://phalcon.io/">Phalcon {{version()}}</a>
                </div>
            </li>
        </ul>
</article>        
    </footer>
</section><a id="backTop" href="#top"><span class="ico-backTop"></span></a>
{% endblock %}
<?php
stream_context_set_default(array('http' => array('method' => 'HEAD')));
$url = 'https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js';
$headers = get_headers($url, 1);
$file_found = strpos($headers[0], '200');
//$file_exists = (@fopen($url, "r")) ? true : false;
//if($file_exists){
if($file_found !== false){
//if(file_get_contents($url)){ ?>
<script nonce="<?php echo($nonce);?>" defer="defer" src="<?php echo($url);?>"></script><?php }else{ ?>
<script nonce="<?php echo($nonce);?>" defer="defer" src="{{url.getBaseUri('')}}js/jquery.min.js"></script>
<?php } ?><noscript>Javascript may disabled!</noscript><script nonce="<?php echo($nonce);?>" defer='defer' src="{{url.getBaseUri('')}}js/jquery.js"></script><noscript>Javascript may disabled!</noscript></body></html><?php ob_end_flush(); ?>
