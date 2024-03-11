<?php #ob_start("ob_compress");function ob_compress($buf = null){return preg_replace(array('/<!--(.*)-->/Uis',"/[[:blank:]]+/"),array('',' '),str_replace(array("\n","\r","\t"),'',$buf) );} 
    $nonce = bin2hex(base64_encode(random_bytes(64).date('dmYHis'))); ?>{{ get_doctype() }}
<html itemscope itemtype="http://schema.org/WebPage" dir="ltr" xmlns="http://www.w3.org/1999/xhtml" lang="en-GB">
<head>
<title>{{getTitle()|e}}</title>
<meta charset="utf-8"/>
<meta http-equiv='x-dns-prefetch-control' content='on'/> 
<meta name="Referrer-Policy" content="no-referrer,strict-origin-when-cross-origin"/>
<meta name='viewport' content='width=device-width,minimum-scale=1,initial-scale=1'/>
<meta http-equiv="Permissions-Policy" content="interest-cohort=()"/>
<?php 
header("Content-Security-Policy: default-src 'self' https: *.facebook.net *.facebook.com *.fbcdn.net *.fbsbx.com; object-src *.facebook.net *.facebook.com *.fbcdn.net *.fbsbx.com; base-uri 'self'; script-src 'self' 'nonce-$nonce' https: https://cdnjs.cloudflare.com *.facebook.net *.facebook.com *.fbcdn.net *.fbsbx.com; img-src 'self' data: *.facebook.net *.facebook.com *.fbcdn.net *.fbsbx.com; style-src 'self' fonts.googleapis.com; upgrade-insecure-requests; font-src 'self' data: fonts.gstatic.com; manifest-src 'self'; worker-src 'self'; media-src 'self'; form-action 'self'; frame-ancestors *.facebook.net *.facebook.com *.fbcdn.net *.fbsbx.com;");
header("X-XSS-Protection: 1; mode=block;X-Frame-Options:DENY; X-Content-Type-Options nosniff"); 
header("Access-Control-Allow-Headers: x-requested-with, Content-Type, origin, authorization, accept, client-security-token");
Header("Access-Control-Expose-Headers: Content-Security-Policy, Location");
header("Access-Control-Allow-Origin: " . $_SERVER["HTTP_ORIGIN"]);
##
#session_cache_limiter('public');
header("Access-Control-Max-Age-: 315360000");
header("Access-Control-Allow-Credentials: true");
header("ETag: PUB" . time());
header("Pragma: no-cache");
header("Last-Modified: " . gmdate("D, d M Y H:i:s", time() - 1) . " GMT");
header("Expires: " . gmdate("D, d M Y H:i:s", time() + 10) . " GMT");
header("Cache-Control: max-age=1, s-maxage=1, no-cache, must-revalidate");

// if (isset($_SERVER['HTTP_COOKIE'])) {
//     $cookies = explode(';', $_SERVER['HTTP_COOKIE']);
//     foreach($cookies as $cookie) {
//         $parts = explode('=', $cookie);
//         $name = trim($parts[0]);
//         setcookie($name, '', time()-1000);
//         setcookie($name, '', time()-1000, '/');
//     }
// }
?>
<meta name="theme-color" media="(prefers-color-scheme: light)" content='#fff'/>
<meta name='HandheldFriendly' content='true'/>
<meta name='format-detection' content='telephone=yes'/>
<meta name='mobile-web-app-capable' content='yes'/>
<meta name='apple-mobile-web-app-capable' content='yes'/>
<meta name='rating' content="general"/>
<meta name='msapplication-starturl' content="{{url.getBaseUri('')}}"/>
<meta name="google-site-verification" content="{{googleKey}}"/>
<meta name='author' content="{{author}}"/>
<meta name='application-name' content='{{siteName}}'/>
<meta name='robots' content="{{ dynarobot }}"/>
<meta name='description' content="{{ dynadesc }}"/>
<meta name='keywords' content="{{ dynakey }}"/>
<meta name='googlebot' content="{{ dynagooglebot }}"/>
<meta property='og:locale' content='en_US'/>
<meta property='og:type' content="{{ dynaArticle }}"/>
<meta property='og:url' content="{{url.getBaseUri('')}}{{ dynaOgUrl }}"/>
<meta property="og:title" content="{{dynaArticleTitle}}"/>
<meta property="og:site_name" content='{{siteName}}'/>
<meta property="og:description" content="{{ dynadesc }}"/>
<meta property="og:locale" content="en_US"/>
<meta property="article:author" content='{{dynaGetAuthor}}'/>
<meta property="article:publisher" content='{{articlePublisher}}'/>
<meta property="og:image" content="{{url.getBaseUri('')}}{{dynaOgImg}}"/>
<link rel="manifest" href="{{url.getBaseUri('')}}manifest.webmanifest" crossorigin="use-credentials"/>
<link rel="apple-touch-icon" href="{{url.getBaseUri('')}}img/lamptouch192.png"/>
<link rel='publisher' href="{{articlePublisher}}"/>
{% if not(router.getControllerName()~router.getActionName()) == 'index/index' %}<link rel='canonical' href="{{url.getBaseUri('')}}{{dynaOgUrl}}"/>{% endif %}
<link rel='shortcut icon' href="{{url.getBaseUri('')}}{{dynaOgImg}}"/>
<link rel='shortlink' href="{{url.getBaseUri('')}}"/>
<base rel="noopener noreferrer" href="{{url.getBaseUri('')}}" target='_self'/>
<link rel="preload" fetchpriority="high" as="image" href="{{url.getBaseUri('')}}img/siteLogo.png" type="image/png"/>
{% if router.getControllerName() == 'index' or router.getControllerName()~router.getActionName() == 'index/index' %}<link rel="preload" fetchpriority="high" as="image" href="{{url.getBaseUri('')}}uploads/siteBanner.jpg" type="image/jpg"/>{% endif %}
<link rel="preload" fetchpriority="high" as="style" href="{{url.getBaseUri('')}}css/css_compressed.php"/>
<link rel="preload" fetchpriority="high" as="script" href="{{url.getBaseUri('')}}js/jquery.js"/>
<script nonce="<?php echo($nonce); ?>">if('serviceWorker' in navigator){navigator.serviceWorker.register('{{ url("sw.js") }}', {scope:'{{url.getBaseUri("")}}'}).then(function (registration) {console.log('Service Registered');});navigator.serviceWorker.ready.then(function (registration) {console.log('Service Ready');});}</script>
{#{ stylesheet_link('css/css_compressed.php') }#}
<link rel="stylesheet" type="text/css" media="all" href="{{url.getBaseUri('')}}css/css_compressed.php"/>
</head>
<body itemscope itemprop="web" itemtype="https://schema.org/organization" class="bgFFF">{{hidden_field( security.getTokenKey(), 'value':security.getToken() )}}{% if flashSession.has() %}{{ flashSession.output() }}{% endif %}{% block header %}
<header>
    <section class="bar">
        <article class='fxSmall'>
            <div class="item txtJustify marginA"><a aria-label="Home Page" href="{{url.getBaseUri('')}}index" class="{% if router.getControllerName() == '' or router.getControllerName() == 'index' or router.getControllerName()~router.getActionName() == 'index/index' %}{{'active'}}{% else %}{{''}}{% endif %}"><span class="ico-home"></span></a> | {% if (not(uname is empty)) %}<a class="{% if router.getActionName() == 'track' %}{{'active'}}{% else %}{{''}}{% endif %}" href="{{url.getBaseUri('')}}index/track">TRACK ORDER</a> | {% endif %}{% if (not(uname is empty)) %}: <a href="{{url.getBaseUri('')}}users" tabindex="0"><i class="uid nodisp" data-user="{{uid}}"></i><span class="ico-user"></span> {{uname}}</a> : | <a href="{{url.getBaseUri('')}}users/end">LOGOUT</a>{% else %}<a data-id="s" href="{{url.getBaseUri('')}}users/signup/<?php echo(urlencode(base64_encode('s')));?>" class="{% if router.getActionName() == 'signupsale' %}{{'active'}}{% else %}{{''}}{% endif %}" aria-label="Be A Seller">BE A SELLER</a> | <a aria-label="Login"  id="login" href="#login">LOGIN</a> | <a data-id="b" href="{{url.getBaseUri('')}}users/signup/<?php echo(urlencode(base64_encode('b')));?>" class="{% if router.getActionName() == 'signupbuy' %}{{'active'}}{% else %}{{''}}{% endif %}" aria-label="Buyer Signup">SIGNUP</a>{% endif %}</div>
        </article>
    </section>
    <section class="main query">
        <article class="">
<div itemscope itemprop="url" itemtype="https://schema.org/Organization" class="height100x"><a data-name="baseUrl" href="{{url.getBaseUri('')}}"><img class="baselogo" fetchpriority="high" loading="auto" itemprop="logo" alt="LampTouch Logo" src="{{url.getBaseUri('')}}img/siteLogo.png" data-src="{{url.getBaseUri('')}}img/siteLogo.png"/></a></div>
        </article>
        <article class="vaMiddle">
            <div id='search-box'>
            <meta itemprop="url" content="{{url.getBaseUri('')}}"/>
            <form itemscope itemprop="potentialAction" itemtype="https://schema.org/SearchAction" method="post" action="{{url.getBaseUri('')}}index/query" enctype="application/x-www-form-urlencoded">
            <meta itemprop="target" content="{{url.getBaseUri('')}}index/query={query}"/>
               <div class="search">
                  <input itemprop="query-input" pattern="^(?![0-9]*$)[a-zA-Z0-9 ]+$" spellcheck="false" autocomplete="off" autocorrect="off" autocapitalize="off" type="text" name="query" class="searchTerm" placeholder="What are you looking for?"/>
                  <button type="submit" aria-label="search button" class="searchButton"><i class="ico-search"></i></button>
               </div> 
            </form>
            </div>
            <select id="all" class="allp" name="all" aria-label="all products"><option value="0">All Products...</option>{% for category in cats %}<option value="{{category.id}}">{{category.categoryname}}</option>{% endfor %}</select>
        </article>
        <article class="">
                <h1 itemscope itemprop="telephone" itemtype="https://schema.org/LocalBusiness" class="fxLarge txtCenter colorF06"><a href="tel:{{bizTel}}">{{bizTel}}</a></h1>
                <h2 class="fSmall txtCenter">Your IP Is : {{userip}}</h2>
                {% if (not(uid is empty)) %}
                <ul>
                    <li class="pad10x txtCenter">
                        <a title="View Cart" href="{{url.getBaseUri('')}}index/viewcart/<?php echo(urlencode(base64_encode($uid)));?>">
                {% if router.getActionName() === 'track' %}
                        <span class="ico-cartluggage cursorPoint color080"></span>
                {% else %}
                    {% if (not(mycart is empty)) %}<span class="ico-cart cursorPoint color080"></span>{% else %}<span class="ico-cartd cursorPoint color080"></span>{% endif %}
                {% endif %}
                        <i class="citem color080">[ {{ mycart }} ]</i></a> &vert; <span class="ico-love"></span> <i class="color080">[ 0 ]</i>
                    </li>
                </ul>
                {% else %}&nbsp;
                {% endif %}            
        </article>
    </section>
</header>{% endblock %}
<main itemscope itemprop="main content" itemtype="https://schema.org/Store" id='maincontent' class='marginA displayBlock pad0x positionRel'>{% block content %} {% endblock %}</main>
{% block footer %} 
<footer class="footer fxSmall autoHeight">
<article class="">&nbsp;</article>
<article class="txtCenter bold"><br/>
<a aria-label="about us" href="{{url.getBaseUri('')}}index/aboutus">Aboutus</a> &vert; <a class="feedbacks" aria-label="feedback" href="{{url.getBaseUri('')}}index/feedback">Feedback</a> &vert; <a aria-label="business contact" class="contacts" href="mailto:{{bizMail}}">Contact</a> &vert; <a aria-label="property protection" href="{{url.getBaseUri('')}}index/property">Intellectual Property Protection</a><br/> <a aria-label="privacy policy" href="{{url.getBaseUri('')}}index/privacy">Privacy Policy</a> &vert; <a aria-label="legal disclaimer" href="{{url.getBaseUri('')}}index/legal">Legal Disclaimer</a> &vert; <a aria-label="cookie policy" href="{{url.getBaseUri('')}}index/cookies">Cookie Policy</a> &vert; <a aria-label="terms and conditions" href="{{url.getBaseUri('')}}index/terms">Terms &amp; Conditions</a><br/><?php $executionTime = round(microtime(true) - $_SERVER["REQUEST_TIME_FLOAT"],3);echo('page rendered in :'.$executionTime.' seconds'); ?> &vert; memory used <?php echo(round(memory_get_usage()/1048576,2).' MB'); ?></article><article class=""><ul class="copyright"><li><img itemprop="image" alt="Developer Logo" title="Developed by: Firefly&reg;" class="firefly" data-src="<?php echo('data:image/png;base64,'.base64_encode(file_get_contents('img/bee.png'))); ?>"><span class="dotfly"></span></li><li><p class="vbar"></p></li><li><a title="facebook" aria-label="facebook" href="https://www.facebook.com/"><span class="ico-fb"><b class="nodisp">Fbook</b></span></a>                <a title="pinterest" aria-label="pinterest" href="https://pinterest.com/"><span class="ico-pinterest"><b class="nodisp">Pinterest</b></span></a>
                <a title="youtube" aria-label="youtube" href="https://www.youtube.com/"><span class="ico-utube"><b class="nodisp">Ytube</b></span></a>
                <a title="rssfeed" aria-label="feed" href="{{url.getBaseUri('')}}index/feed"><span class="ico-rss"><b class="nodisp">Feed</b></span></a><a title="sitemap" aria-label="sitemap" href="{{url.getBaseUri('')}}sitemap"><span class="ico-sitemap"><b class="nodisp">Sitemap</b></span></a><div class="bold">{{siteName}}<?php function copyright($year = null){$cYear = (int) date('Y');if($year === null || $year >= $cYear){$result = $cYear;}else{$result = $year.' - '.$cYear;}echo('<br/>Copyright &copy; '.$result.'.<br/>All Rights Reserved.<br>Developed By: <a href="#">FireFly</a>&reg;');}copyright($copyYear);?><br/><a href="https://phalcon.io/">Phalcon {{version()}}</a></div></li></ul></article>
{% if (uname is empty) %}<div class="login bgEEE bold fSmall color333">
    {{ form_legacy('users/start','id':'logged') }}
        I'm a Buyer {{ radio_field('ltype','id':'buyer','class':'logintype','value':'b','checked':'checked') }} I'm a Seller {{ radio_field('ltype','id':'seller','class':'logintype','value':'s') }}<hr/>
        <label for="mail" class="pad0x margin0x">Email</label>
        {{text_field("mail", "pattern":"[a-z0-9._%+\-]+@[a-z0-9.\-]+\.[a-z]{2,}$", "autocomplete":"off",'required':'required')}}
        <label for="lpasswd" class="pad0x margin0x">Password</label>
        {{password_field('lpasswd','autocomplete':'off','pattern':'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*_-]).{8,30}$','maxlength':'30','required':'required')}}<i id="pass" class="floatL ico-eyeOn"></i>
        <label for="logins" class="pad0x margin0x bold"><em class="nodisp">Submit</em></label><br/>
        {{ submit_button('Login',"id":"logins",'class':'margin4x neumorphism cursorpoint width100p bold pad10x bgEEE') }} 
    {{check_field('rememberme','value':'Y')}} Remember Me | <a class="color333" aria-label='Recover Password' href="{{url.getBaseUri('')}}users/forgetpass">Forgot Password ?</a>
    {{end_form()}}<br/>
    <p class="width100p txtRight clrB"><a class='close color333' aria-label='Close Button' href="#close"><i class="ico-del colorF00 fLarge"></i></a></p>
    </div>{% endif %}
    <div id="fb-root"></div>
    <div id="fb-customer-chat" class="fb-customerchat"></div>
    <script defer="defer" nonce="<?php echo($nonce); ?>" crossorigin="anonymous">
      // var chatbox = document.getElementById('fb-customer-chat');
      // chatbox.setAttribute("page_id", "107879391792052");
      // chatbox.setAttribute("theme_color", "#0084ff");
      // chatbox.setAttribute("attribution", "biz_inbox");
    </script>
    <script defer="defer" nonce="<?php echo($nonce); ?>" crossorigin="anonymous">
      // window.fbAsyncInit = function() {
      //   FB.init({
      //     xfbml            : true,
      //     autoLogAppEvents : true,
      //     version          : 'v17.0'
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
</footer>{% endblock %}<?php
stream_context_set_default(array('http' => array('method' => 'HEAD')));
$url = 'https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js';
$headers = get_headers($url, true);
$file_found = strpos($headers[0], '200');
//$file_exists = (@fopen($url, "r")) ? true : false;
//if($file_exists){
if($file_found !== false){
//if(file_get_contents($url)){ ?>
<script defer="defer" src="<?php echo($url);?>" nonce="<?php echo($nonce);?>" fetchpriority="high" integrity="" crossorigin="anonymous"></script><?php }else{ ?>
<script defer="defer" src="{{url.getBaseUri('')}}js/jquery.min.js" nonce="<?php echo($nonce);?>"></script><?php } ?><noscript>Javascript may disabled!</noscript><script defer='defer' src="{{url.getBaseUri('')}}js/jquery.js" nonce="<?php echo($nonce);?>" fetchpriority="high"></script><noscript>Javascript may disabled!</noscript></body></html><?php ob_end_flush(); ?>