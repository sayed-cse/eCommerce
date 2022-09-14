{{ get_doctype() }}
<html itemscope itemtype="http://schema.org/WebPage" dir="ltr" xmlns="http://www.w3.org/1999/xhtml" lang="en-GB">
<head>
<?php $nonce = bin2hex(base64_encode(random_bytes(32))); ?>
<title>{{getTitle()}}</title> 
<meta charset="utf-8"/>
<meta http-equiv="Content-Security-Policy" content="default-src 'self'; img-src 'self' data: https:; style-src 'self' 'unsafe-inline'; script-src 'nonce-<?php echo($nonce);?>' http: https:; base-uri 'self'; font-src 'self' data:;manifest-src 'self'; worker-src 'self'; media-src 'self'; object-src 'none';"/>
<meta http-equiv='x-dns-prefetch-control' content='on'/>
<meta name="Referrer-Policy" content="no-referrer, strict-origin-when-cross-origin"/>
<meta name='viewport' content='width=device-width,minimum-scale=1,initial-scale=1'/>
<meta name="theme-color" media="(prefers-color-scheme: light)" content='#fff'/>
<meta name='HandheldFriendly' content='true'/>
<meta name='format-detection' content='telephone=yes'/>
<meta name='application-name' content='{{siteName}}'/>
<meta name='mobile-web-app-capable' content='yes'/>
<meta name='apple-mobile-web-app-capable' content='yes'/>
<meta name='msapplication-starturl' content="{{url.getBaseUri('')}}"/>
<meta name='robots' content="{{ dynarobot }}"/>
<meta name='description' content="{{ dynadesc }}"/>
<meta name='keywords' content="{{ dynakey }}"/>
<meta name='googlebot' content="{{ dynagooglebot }}"/>
<meta name='rating' content="general">
<meta name='author' content="{{author}}"/>
<meta name="google-site-verification" content="{{googleKey}}"/>
<meta property='og:locale' content='en_US'/>
<meta property='og:type' content="{{ dynaArticleTitle }}"/>
<meta property='og:url' content="{{url.getBaseUri('')}}{{ dynaOgUrl }}"/>
<meta property="og:title" content="{{getTitle()}}"/>
<meta property="og:site_name" content='{{siteName}}'/>
<meta property="og:description" content="{{ dynadesc }}"/>
<meta property="og:locale" content="en_US"/>
<meta property="article:author" content='{{dynaGetAuthor}}'/>
<meta property="article:publisher" content='{{articlePublisher}}'/>
<meta property="og:image" content="{{url.getBaseUri('')}}{{dynaOgImg}}"/>
<link rel="manifest" href="{{url.getBaseUri('')}}manifest.webmanifest"/>
<link rel="preload" fetchpriority="high" as="image" href="{{url.getBaseUri('')}}img/baselogo.webp" type="image/webp"/>
{% if router.getActionName() === 'index' %}<link rel="preload" fetchpriority="high" as="image" href="{{url.getBaseUri('')}}uploads/1.webp" type="image/webp"/>{% endif %}
{{ tag_html("link",["rel": "preload","as": "font","href": url.getBaseUri('')~"css/fonts/fa-brands.ttf","type":"font/ttf","crossorigin":"crossorigin"],'/') }}
{{ tag_html("link",["rel": "preload","as": "font","href": url.getBaseUri('')~"css/fonts/fa-solid.ttf","type":"font/ttf","crossorigin":"crossorigin"],'/') }}
{{ tag_html("link",["rel": "preload","as": "style","href": url.getBaseUri('')~"css/css_compressed.php"],'/') }}
{{ tag_html("link",["rel": "preload","as": "script","href": url.getBaseUri('')~"js/jquery.js"],'/') }}
{{ stylesheet_link('css/css_compressed.php') ~ tag_html("link",["rel": "alternate","type": "application/rss+xml","title": "RSS Feed Thunder Voice","href": "blog/feed"],true,true,true) }}
<link rel="apple-touch-icon" href="{{url.getBaseUri('')}}{{dynaOgImg}}"/>
<link rel='publisher' href='{{url.getBaseUri('')}}'/>
<link rel='canonical' href="http://localhost.com"/>
<link rel='shortcut icon' href="{{url.getBaseUri('')}}{{dynaOgImg}}"/>
<link rel='shortlink' href="{{url.getBaseUri('')}}"/>
<base rel="noopener noreferrer" href="{{url.getBaseUri('')}}" target='_self'/> 
<?php #$this->assets->outputCss(); ?>
<script nonce="<?php echo($nonce);?>" type="text/javascript">
//Service worker registration
if('serviceWorker' in navigator) {
navigator.serviceWorker.register('{{ url("sw.js") }}', {scope: '{{url.getBaseUri('')}}'})
.then(function (registration) {
console.log('Service Worker Registered');
});
navigator.serviceWorker.ready.then(function (registration) {
console.log('Service Worker Ready');
});
}
</script>
</head><body itemscope itemtype="https://schema.org/organization" class="bgFFF">{% block header %} 
<section class="row">{% if flashSession.has() %}{{ flashSession.output() }}{% endif %}
    <header class="pad0x margin0x">
        <article class='rc12 bg006166 bold colorFFF pad10x fxsmall'>
            <div class="rc12 txtJustify marginAuto centerbody">
            <a class="colorFFF bold" title="{{siteName}}" href="{{url.getBaseUri('')}}"><i class="ico-home"></i></a> | 
            <a class="colorFFF bold" href="{{url.getBaseUri('')}}index/track">TRACK ORDER</a> | 
                {% if (not(uname is empty)) %}: <i class="uid nodisp" data-user="{{uid}}"></i><span class="ico-user"></span> {{uname}} : | <a class="colorFFF bold" href="{{url.getBaseUri('')}}users/end">LOGOUT</a>{% else %}<a class="colorFFF bold" data-id="s" href="{{url.getBaseUri('')}}users/signupsale">BE A SELLER</a> | <a class="colorFFF bold" id="login" href="#login">LOGIN</a> | <a class="colorFFF bold" data-id="b" href="{{url.getBaseUri('')}}users/signupbuy">SIGNUP</a>{% endif %}</div>
        </article>
        <article class="rc12">
            <div class="rc3">
                <div class="height100x"><a title="{{siteName}}" data-name="baseUrl" href="{{url.getBaseUri('')}}"><img class="baselogo" itemprop="image" width="264px" height="100px" alt="LampTouch Logo" data-src="{{url.getBaseUri('')}}img/baselogo.webp"/></a></div>
            </div>
            <div class="rc6 pad10x vertmiddle">
                <div id='search-box'>
                <form method="post" action="index/query" enctype="application/x-www-form-urlencoded">
                   <div class="search">
                      <input area-label="searchBar" type="text" name="query" class="searchTerm" placeholder="What are you looking for?"/>
                      <button aria-label="search button" type="submit" class="ico-search searchButton"></button>
                   </div> 
                </form>   
                </div>
            </div>
            <div class="rc3 color0d6">
                <h1 class="fxlarge txtCenter">+8801965573738</h1>
                <ul>{% if (not(uid is empty))  %}
                <li class="pad10x txtCenter"><a title="View Cart" href="index/viewcart/{{uid}}"><span class="ico-cart cursorpoint color080"></span> <i class="citem color0d6">[ {% if (not(mycart is empty)) %}{{ mycart }}{% else %} 0 {% endif %} ]</i></a> &vert; <span class="ico-love"></span> <i class="color0d6">[ 0 ]</i> </li>
               {% else %}&nbsp;{% endif %}</ul>
            </div>
        </article>
    </header>
</section>
{% endblock %}<main itemscope itemtype="https://schema.org/Store" id='maincontent' class='marginAuto disp_block pad0x rel_pos'>{% block content %} {% endblock %}</main>{% block footer %} 
<section class="row marginB0x">
    <footer class="hdft bg006166 fxsmall autoHeight marginAuto">
        <article class="rc3">&nbsp;</article>
        <article class="rc6 txtCenter bold"><br/><br/>
<a href="#aboutus">Aboutus</a> &vert; <a class="feedbacks" href="#feedback">Feedback</a> &vert; <a class="contacts" href="mailto:webmaster.thundervoice@gmail.com">Contact</a> &vert; <a href="#property">Intellectual Property Protection</a><br/> <a href="#privacy">Privacy Policy</a> &vert; <a href="#legal">Legal Disclaimer</a> &vert; <a href="#cookie">Cookie Policy</a> &vert; <a href="#terms">Terms &amp; Conditions</a><br/>
<?php $executionTime = round(microtime(true) - $_SERVER["REQUEST_TIME_FLOAT"],3);echo('page rendered in :'.$executionTime.' seconds'); ?> &vert; memory used <?php echo(round(memory_get_usage()/1048576,2).' MB'); ?>
        </article>
<article class="rc3">
    <ul class="copyright">      
            <li><img itemprop="image" alt="Developer Logo" title="Developed by: Firefly&reg;" class="firefly" data-src="<?php echo('data:image/png;base64,'.base64_encode(file_get_contents('img/bee.png'))); ?>" /><span class="dotfly"></span></li>
            <li><p class="vbar"></p></li>
            <li>
                <div class="bold">{{siteName}}<?php function copyright($year = null){$cYear = (int) date('Y');if($year === null || $year >= $cYear){$result = $cYear;}else{$result = $year.' - '.$cYear;}echo('<br/>Copyright &copy; '.$result.'.<br/>All Rights Reserved.<br>Developed By: <a href="mailto:abc@gmail.com">FireFly</a>&reg;');}copyright('2018');?><br/>Phalcon {{version()}}
                </div>
            </li>
        </ul>
</article>        
    </footer>
</section><a id="backTop" href="#top"><span class="ico-backTop"></span></a>
<div class="login bgEEE bold fsmall">
{{ form_legacy('users/start','id':'logged') }}
    I'm a Buyer {{ radio_field('ltype','id':'buyer','class':'logintype','value':'b') }} I'm a Seller {{ radio_field('ltype','id':'seller','class':'logintype','value':'s') }}<hr/>
    <label for="mail" class="pad0x margin0x">Email</label>
    {{text_field("mail","class":"","autocomplete":"off")}}
    <label for="passwd" class="pad0x margin0x">Password</label>
    {{password_field("passwd","class":"","autocomplete":"off")}}
    {{hidden_field( security.getTokenKey(), 'value':security.getToken() )}}
    <label for="logins" class="pad0x margin0x bold"><em class="nodisp">Submit</em></label>
    {{ submit_button('Login',"id":"logins",'class':'margin4x neumorphism cursorpoint width100p bold pad4x bgEEE') }} 
{{end_form()}}<a class="close" href="#close">X</a>
</div>{% endblock %}
<?php
stream_context_set_default(array('http' => array('method' => 'HEAD')));
$url = 'https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js';
$headers = get_headers($url, 1);
$file_found = strpos($headers[0], '200');
//$file_exists = (@fopen($url, "r")) ? true : false;
//if($file_exists){
if($file_found !== false){
//if(file_get_contents($url)){ ?>
<script nonce="<?php echo($nonce);?>" defer="defer" src="<?php echo($url);?>"></script><?php }else{ ?>
<script nonce="<?php echo($nonce);?>" defer="defer" src="{{url.getStaticBaseUri('')}}js/jquery.min.js"></script>
<?php } ?><noscript>Javascript may disabled!</noscript><script nonce="<?php echo($nonce);?>" defer='defer' src="{{url.getBaseUri('')}}js/jquery.js"></script><noscript>Javascript may disabled!</noscript>
{% if router.getActionName() === 'product' %}
<script defer="defer" nonce="<?php echo($nonce);?>" src="{{url.getBaseUri('')}}js/Nzoom.min.js"></script>
{% endif %}
</body></html>