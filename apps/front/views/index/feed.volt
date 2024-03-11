<?php echo('<?xml version="1.0" encoding="UTF-8" standalone="yes"?><?xml-stylesheet type="text/css" href="'.$this->url->getBaseUri().'css/xml.css"?>'); ?>
<rss version="2.0"
xmlns:wfw="http://wellformedweb.org/CommentAPI/"
xmlns:atom="http://www.w3.org/2005/Atom"
xmlns:slash="http://purl.org/rss/1.0/modules/slash/"
xmlns:dc="http://purl.org/dc/elements/1.1/"
xmlns:sy="http://purl.org/rss/1.0/modules/syndication/"
xmlns:admin="http://webns.net/mvcb/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
xmlns:content="http://purl.org/rss/1.0/modules/content/"
xmlns:xlink="http://www.w3.org/1999/xlink"
xmlns:link='http://www.w3.org/2001/06/xml-link-style'>
<channel>
<title></title>
<link></link>
<description>Most trusted online shopping platform.</description>
{% for post in posts %}
<item>
	<title>{{ post.product_title|e }}</title>
	<link xlink:type="simple" xlink:href="" xlink:show="new">{{url.getBaseUri('')~"details/"~post.product_title | url_encode }}</link>
	<description>{{ post.product_price|e }}</description>
	<html xmlns="http://www.w3.org/1999/xhtml"><img src="{{url.getBaseUri('')~'uploads/shop/'~post.pimg_front}}" /></html>   
	<author>Brand: {% for brand in brands %}{% if post.shopid === brand.id %}{{brand.name}}{% endif %}{% endfor %}</author>
	<pubDate>{#{ post.rss_date }#}</pubDate>
</item>
{% endfor %}
</channel>
</rss> 
