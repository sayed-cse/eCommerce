<?php #ob_start("ob_compress");function ob_compress($buf){return preg_replace(array('/<!--(.*)-->/Uis',"/[[:blank:]]+/"),array('',' '),str_replace(array("\n","\r","\t"),'',$buf), );} 
$nonce = bin2hex(base64_encode(random_bytes(256).date('dmYHis'))); ?>{{ get_doctype() }}
<html itemscope itemtype="http://schema.org/WebPage" dir="ltr" xmlns="http://www.w3.org/1999/xhtml" lang="en-GB">
<head>
<title>{{getTitle()}}</title>
<?php header("Content-Security-Policy: default-src 'self' socialplugin.facebook.net www.facebook.com; object-src 'none'; base-uri 'self'; script-src 'self' 'nonce-$nonce' www.facebook.com web.facebook.com socialplugin.facebook.net connect.facebook.net;img-src 'self' data:; style-src 'self' 'unsafe-inline'; upgrade-insecure-requests;  font-src 'self' data:; manifest-src 'self'; worker-src 'self'; media-src 'self'; form-action 'self'; frame-src www.facebook.com;frame-ancestors www.facebook.com; report-uri  //localhost/f/index/cspreport;"); 
header("X-XSS-Protection: 1; mode=block;X-Frame-Options:DENY; X-Content-Type-Options nosniff");
?>
<meta http-equiv='x-dns-prefetch-control' content='on'/> 
<meta charset="utf-8"/>
<!-- <meta name="Referrer-Policy" content="no-referrer, strict-origin-when-cross-origin"/> -->
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
<link rel="preconnect" href="//connect.facebook.net"/>
<link rel="preconnect" href="//socialplugin.facebook.net"/>
<link rel="preconnect" href="//web.facebook.com"/>
<link rel="manifest" href="{{url.getBaseUri('')}}manifest.webmanifest" crossorigin="use-credentials"/>
{{ stylesheet_link('css/css_compressed.php') }}
<link rel="apple-touch-icon" href="{{url.getBaseUri('')}}img/lamptouch192.png"/>
<link rel='publisher' href='{{url.getBaseUri("")}}'/>
<!-- <link rel='canonical' href="{{url.getBaseUri('')}}{{dynaOgUrl}}"/> -->
<link rel='shortcut icon' href="{{url.getBaseUri('')}}{{dynaOgImg}}"/>
<link rel='shortlink' href="{{url.getBaseUri('')}}"/>
<base rel="noopener noreferrer" href="{{url.getBaseUri('')}}" target='_self'/> 
<script nonce="<?php echo($nonce);?>">
if('serviceWorker' in navigator) {
navigator.serviceWorker.register('{{ url("sw.js") }}', {scope: '{{url.getBaseUri('')}}'})
.then(function (registration) {console.log('Service Registered');});
navigator.serviceWorker.ready.then(function (registration) {console.log('Service Ready');});
}
</script>
</head><body itemscope itemtype="https://schema.org/organization" class="bgFFF">{% block header %} 
{{hidden_field( security.getTokenKey(), 'value':security.getToken() )}}
<section class="row bgFFF">{% if flashSession.has() %}{{ flashSession.output() }}{% endif %}
    <header class="pad0x margin0x">
        <article class='rc12 bgDFD pad10x fxsmall'>
            <div class="rc12 txt_justify marginAuto centerbody"><a aria-label="Home Page" href="{{url.getBaseUri('')}}index"><span class="ico-home color333"></span></a> | {% if (not(uname is empty)) %}<a href="{{url.getBaseUri('')}}index/track">TRACK ORDER</a> | {% endif %}
                {% if (not(uname is empty)) %}: <i class="uid nodisp" data-user="{{uid}}"></i><span class="ico-user"></span> {{uname}} : | <a href="{{url.getBaseUri('')}}users/end">LOGOUT</a>{% else %}<a data-id="s" href="{{url.getBaseUri('')}}users/signupsale">BE A SELLER</a> | <a id="login" href="#login">LOGIN</a> | <a data-id="b" href="{{url.getBaseUri('')}}users/signupbuy">SIGNUP</a>{% endif %}</div>
        </article>
        <article class="rc12">
            <div class="rc3">
                <div itemscope itemtype="https://schema.org/Organization" class="height100x"><a itemprop="url" data-name="baseUrl" href="{{url.getBaseUri('')}}"><img itemprop="logo" alt="LampTouch Logo" data-src="{{url.getBaseUri('')}}img/lamptouch.png"></a></div>
            </div>
            <div class="rc6 pad10x vertmiddle">
                <div id='search-box'>
                <meta itemprop="url" content="{{url.getBaseUri('')}}"/>
                <form itemprop="potentialAction" itemscope itemtype="https://schema.org/SearchAction" method="post" action="index/query" enctype="application/x-www-form-urlencoded">
                <meta itemprop="target" content="{{url.getBaseUri('')}}index/query={query}"/>
                   <div class="search">
                      <input itemprop="query-input" type="text" name="query" class="searchTerm" placeholder="What are you looking for?"/>
                      <button type="submit" class="searchButton"><i class="ico-search"></i></button>
                   </div> 
                </form>   
                </div>
            </div>
            <div class="rc3">
                <h1 class="fxlarge txtCenter color080">+8801965573738</h1>
                <h2>IP IS : {{userip}}</h2>
                {% if (not(uid is empty)) %}
                <ul>
                    <li class="pad10x">
                        <a title="View Cart" href="index/viewcart/{{uid|url_encode}}">
                {% if router.getActionName() === 'track' %}
                        <span class="ico-cartluggage cursorpoint color080"></span>
                {% else %}
                    {% if (not(mycart is empty)) %}
                        <span class="ico-cart cursorpoint color080"></span>
                    {% else %}
                        <span class="ico-cartd cursorpoint color080"></span>
                    {% endif %}
                {% endif %}
                        <i class="citem color080">[ {% if (not(mycart is empty)) %}{{ mycart }}{% else %} 0 {% endif %} ]</i></a> &vert; <span class="ico-love"></span> <i class="color080">[ 0 ]</i>
                    </li>
                </ul>
                {% else %}&nbsp;
                {% endif %}
            </div>
        </article>
    </header>
</section>
{% endblock %}<main itemscope itemtype="https://schema.org/Store" id='maincontent' class='marginAuto disp_block pad0x rel_pos'>{% block content %} {% endblock %}</main>{% block footer %} 
<section class="row marginB0x">
    <footer class="hdft fxsmall autoHeight marginAuto">
        <article class="rc3">&nbsp;</article>
        <article class="rc6 txt_center bold"><br/><br/>
<a href="javascript:void(0);">Aboutus</a> &vert; <a class="feedbacks" href="javascript:void(0);">Feedback</a> &vert; <a class="contacts" href="mailto:webmaster.thundervoice@gmail.com">Contact</a> &vert; <a href="javascript:void(0);">Intellectual Property Protection</a><br/> <a href="javascript:void(0);">Privacy Policy</a> &vert; <a href="javascript:void(0);">Legal Disclaimer</a> &vert; <a href="javascript:void(0);">Cookie Policy</a> &vert; <a href="javascript:void(0);">Terms &amp; Conditions</a><br/>
<?php $executionTime = round(microtime(true) - $_SERVER["REQUEST_TIME_FLOAT"],3);echo('page rendered in :'.$executionTime.' seconds'); ?> &vert; memory used <?php echo(round(memory_get_usage()/1048576,2).' MB'); ?>
        </article>
<article class="rc3">
    <ul class="copyright">      
            <li><img itemprop="image" alt="Developer Logo" title="Developed by: Firefly&reg;" class="firefly" data-src="<?php echo('data:image/png;base64,'.base64_encode(file_get_contents('img/bee.png'))); ?>" /><span class="dotfly"></span></li>
            <li><p class="vbar"></p></li>
            <li>
                <a title="facebook" href="https://www.facebook.com/"><span class="ico-fb"><b class="nodisp">Fbook</b></span></a>
                <a title="linkedin" href="https://www.linkedin.com/i"><span class="ico-linkedin"><b class="nodisp">Linkedin</b></span></a>
                <a title="twitter" href="https://twitter.com/"><span class="ico-twitter"><b class="nodisp">Twitter</b></span></a>
                <a title="pinterest" href="https://pinterest.com/"><span class="ico-pinterest"><b class="nodisp">Pinterest</b></span></a>
                <a title="youtube" href="https://www.youtube.com/"><span class="ico-utube"><b class="nodisp">Ytube</b></span></a>
                <a title="rssfeed" href="{{url.getBaseUri('')}}index/feed"><span class="ico-rss"><b class="nodisp">Feed</b></span></a>                
                <a title="sitemap" href="{{url.getBaseUri('')}}sitemap"><span class="ico-sitemap"><b class="nodisp">Sitemap</b></span></a>
                <div class="bold">{{siteName}}<?php function copyright($year = null){$cYear = (int) date('Y');if($year === null || $year >= $cYear){$result = $cYear;}else{$result = $year.' - '.$cYear;}echo('<br/>Copyright &copy; '.$result.'.<br/>All Rights Reserved.<br>Developed By: <a href="mailto:abc@gmail.com">FireFly</a>&reg;');}copyright('2018');?><br/>Phalcon {{version()}}
                </div>
            </li>
        </ul>
</article>  
<div id="fb-root"></div>
    <div id="fb-customer-chat" class="fb-customerchat"></div>
    <script nonce="<?php echo($nonce);?>" >
      // var chatbox = document.getElementById('fb-customer-chat');
      // chatbox.setAttribute("page_id", "107879391792052");
      // chatbox.setAttribute("attribution", "biz_inbox");
    </script>
    <script nonce="<?php echo($nonce);?>" >
      // window.fbAsyncInit = function() {
      //   FB.init({
      //     xfbml            : true,
      //     version          : 'v12.0'
      //   });
      // };

      // (function(d, s, id) {
      //   var js, fjs = d.getElementsByTagName(s)[0];
      //   if (d.getElementById(id)) return;
      //   js = d.createElement(s); js.id = id;
      //   js.src = 'https://connect.facebook.net/en_US/sdk/xfbml.customerchat.js';
      //   fjs.parentNode.insertBefore(js, fjs);
      // }(document, 'script', 'facebook-jssdk'));
    </script>     
    </footer>
</section><a id="backTop" href="#top"><span class="ico-backTop"></span></a>
<div class="login bgEEE bold fsmall">
{{ form_legacy('users/start','id':'logged') }}
    I'm a Buyer {{ radio_field('ltype','id':'buyer','class':'logintype','value':'b') }} I'm a Seller {{ radio_field('ltype','id':'seller','class':'logintype','value':'s') }}<hr/>
    <label for="mail" class="pad0x margin0x">Email</label>
    {{text_field("mail","autocomplete":"off")}}
    <label for="passwd" class="pad0x margin0x">Password</label>
    {{password_field("passwd","autocomplete":"off")}}
    <label for="logins" class="pad0x margin0x bold"><em class="nodisp">Submit</em></label>
    {{ submit_button('Login',"id":"logins",'class':'margin4x neumorphism cursorpoint width100p bold pad4x bgEEE') }} 
{{end_form()}}<a class="close" aria-label="Close Button" href="javascript:void(0);">X</a>
</div>
{% endblock %}
<?php
stream_context_set_default(array('http' => array('method' => 'HEAD')));
$url = 'https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js';
$headers = get_headers($url, 1);
$file_found = strpos($headers[0], '200');
//$file_exists = (@fopen($url, "r")) ? true : false;
//if($file_exists){
if($file_found !== false){
//if(file_get_contents($url)){ ?>
<script nonce="<?php echo($nonce);?>" defer="defer" src="<?php echo($url);?>"></script><?php }else{ ?>
<script nonce="<?php echo($nonce);?>" defer="defer" src="{{url.getBaseUri('')}}js/jquery.min.js"></script>
<?php } ?><noscript>Javascript may disabled!</noscript><script nonce="<?php echo($nonce);?>" defer="defer" src="{{url.getBaseUri('')}}js/jquery.js"></script><noscript>Javascript may disabled!</noscript></body></html><?php ob_end_flush(); ?>