{% extends "layouts/main.volt" %}
{% block content %}
{# Begin #}
<style type="text/css">
div.static{height:100%;animation-duration:3s}
.base{height:600px}
.base {
  background-image:
    radial-gradient(
      transparent,
      hsla(0, 0%, 0%, 0.85)),
    linear-gradient(
      transparent    75%, 
      hsl(0, 0%, 0%) 75%),
    linear-gradient(left, 
      hsl(  0,   0%, 82%) 14.29%,
      hsl( 54, 100%, 50%) 14.29%,
      hsl( 54, 100%, 50%) 28.57%,
      hsl(184, 100%, 50%) 28.57%,
      hsl(184, 100%, 50%) 42.86%,
      hsl(121,  98%, 42%) 42.86%,
      hsl(121,  98%, 42%) 57.14%,
      hsl(320,  93%, 37%) 57.14%,
      hsl(320,  93%, 37%) 71.43%,
      hsl(349, 100%, 50%) 71.43%,
      hsl(349, 100%, 50%) 85.71%,
      hsl(240, 100%, 38%) 85.71%);
  background-image:
    radial-gradient(
      transparent,
      hsla(0, 0%, 0%, 0.85)),
    linear-gradient(
      transparent    75%, 
      hsl(0, 0%, 0%) 75%),
    linear-gradient(to left, 
      hsl(  0,   0%, 82%) 14.29%,
      hsl( 54, 100%, 50%) 14.29%,
      hsl( 54, 100%, 50%) 28.57%,
      hsl(184, 100%, 50%) 28.57%,
      hsl(184, 100%, 50%) 42.86%,
      hsl(121,  98%, 42%) 42.86%,
      hsl(121,  98%, 42%) 57.14%,
      hsl(320,  93%, 37%) 57.14%,
      hsl(320,  93%, 37%) 71.43%,
      hsl(349, 100%, 50%) 71.43%,
      hsl(349, 100%, 50%) 85.71%,
      hsl(240, 100%, 38%) 85.71%);
  position: relative;
  overflow:hidden;
}
.base:before {
  content: '';
  position: absolute;
  display: block;
  background-image:
    linear-gradient(left, 
      hsl(240, 100%, 38%) 14.29%,
      hsl(  0,   0%,  0%) 14.29%,
      hsl(  0,   0%,  0%) 28.57%,
      hsl(320,  93%, 27%) 28.57%,
      hsl(320,  93%, 27%) 42.86%,
      hsl(  0,   0%,  0%) 42.86%,
      hsl(  0,   0%,  0%) 57.14%,
      hsl(184, 100%, 50%) 57.14%,
      hsl(184, 100%, 50%) 71.43%,
      hsl(  0,   0%,  0%) 71.43%,
      hsl(  0,   0%,  0%) 85.71%,
      hsl(  0,  0%, 82%) 85.71%);
  background-image:
    linear-gradient(to left, 
      hsl(240, 100%, 38%) 14.29%,
      hsl(  0,   0%,  0%) 14.29%,
      hsl(  0,   0%,  0%) 28.57%,
      hsl(320,  93%, 27%) 28.57%,
      hsl(320,  93%, 27%) 42.86%,
      hsl(  0,   0%,  0%) 42.86%,
      hsl(  0,   0%,  0%) 57.14%,
      hsl(184, 100%, 50%) 57.14%,
      hsl(184, 100%, 50%) 71.43%,
      hsl(  0,   0%,  0%) 71.43%,
      hsl(  0,   0%,  0%) 85.71%,
      hsl(  0,  0%, 82%) 85.71%);
  height: 5%;
  width: 100%;
  bottom: 25%;
}

/*********************
  STATIC 
*********************/
.static {
  position: absolute;
  width: 100%;
  top: 0;
  left: 0;
  background-image:url('<?php echo('data:image/png;base64,'.base64_encode(file_get_contents('img/noise-2.png'))); ?>');
  animation: static 3s steps(4, end) infinite;
  opacity: 0.65;
}

/*.static div{
  background-size: 100px 100px;
  animation-duration: 1s;
}*/

@keyframes static {
    0% { background-position:   0%   0%; }
   20% { background-position:  25%  15%; }
   40% { background-position:  50%  69%; }
   /*60% { background-position:  33%  25%; }*/
   80% { background-position:  72%   4%; }
  100% { background-position:  80%  91%; }
}

/*********************
  SCAN LINES
*********************/
.scan,
.scan:before,
.scan:after {
  position: absolute;
  left: 0;
  width: 100%;
  height: 10%;
  background-color: hsla(0, 0%, 0%, .13);
  box-shadow: 0 0 10px hsla(0, 0%, 0%, .25);
  animation: scan 3s linear infinite;
}

.scan:before,
.scan:after {
  content: '';
  display: block;
  height: 80%;
}

/*.scan:before {
  top: -85%;
}

.scan:after {
  top: -85%;
}*/

@keyframes scan {
    0% { top: 0%; }
  100% { top: 85%; }
}
.errDisp{height:260px;top:12%;position:relative;background-color:#fff;}
</style>
<section class="row">
	<article class="rc12 base">
		<div class="errDisp">
		    <div>
				  <h1 class="marginAuto txt_center color666 fxxlarge txt-sh">!404 ERROR!</h1>
				  <h2 class="marginAuto txt_center colorFFF txt-shE pad10x fmedium bg666 w50">SORRY!! THE PAGE YOU REQUESTED CANNOT BE FOUND</h2>
				  <div class="txt_center bold fsmall color444">You have tried to access a page which was moved, renamed, expired or might never existed.<br/>Perhaps you can head back to the sites homepage and see if you can find what you are looking for.<br/><br/>
            <span class="pad10x bold errorMessage">[ ERROR ]</span>
          </div>
		    </div>
		</div>
	    <div class="static"></div><div class="scan"></div>
	</article>
</section>
{# End #}
{% endblock %}


{#


#}