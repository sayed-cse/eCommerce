<?php declare(strict_types=1);
namespace F\Front\Controllers;
use F\Front\Models\Products as Products;
use Phalcon\Http\Response;
class SitemapController extends BaseController
{
    protected $domain = 'http://localhost/f/';
    public function initialize()
    {
        //for big files, to be on the safe side
        set_time_limit(0);
    } 
    public function indexAction()
    { 
        $response = new Response(); 
        $expireDate = new \DateTime();
        $expireDate->modify('+1 day'); 
        $response->setExpires($expireDate); 
        $response->setHeader('Content-Type', "application/xml; charset=UTF-8"); 
        $sitemap = new \DOMDocument("1.0", "UTF-8");
        $urlset = $sitemap->createElement('urlset');
        $urlset->setAttribute('xmlns', 'http://www.sitemaps.org/schemas/sitemap/0.9');
        $urlset->setAttribute('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
        $urlset->setAttribute('xsi:schemaLocation', 'http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd');
        $baseUrl = $this->url->getBaseUri();
         $links = array(
          // Your links here.
           // '/index','/user','/profile'
            'index'
        );
        $modifiedAt = new \DateTime();
        $modifiedAt->setTimezone(new \DateTimeZone('UTC'));        
        $comment = $sitemap->createComment(' Last update of sitemap ' . date("Y-m-d H:i:s").' ');        
        $urlset->appendChild($comment);
//Common links for site
         foreach ($links as $link) {
            $url = $sitemap->createElement('url');
            $href = $this->domain.$link;
            $url->appendChild($sitemap->createElement('loc', $href));
            $url->appendChild($sitemap->createElement('changefreq', 'daily')); //Hourly, daily, weekly etc.
            $url->appendChild($sitemap->createElement('lastmod', $modifiedAt->format('Y-m-d \ H:i:s \ O')));
            $url->appendChild($sitemap->createElement('priority', '0.5')); //1, 0.7, 0.5 ... 
            $urlset->appendChild($url);
        } 
        $sitemap->appendChild($urlset); 
//Products linkup
        $posts = Products::find();
        foreach($posts as $post)
        {
            $url = $sitemap->createElement('url');
            $href = trim($baseUrl, '/') . '/products/' . $post->product_title;
            $url->appendChild($sitemap->createElement('loc', $href));
            $url->appendChild($sitemap->createElement('changefreq', 'daily')); //Hourly, daily, weekly etc.
            $url->appendChild($sitemap->createElement('priority', '0.5'));     //1, 0.7, 0.5 ... 
            $urlset->appendChild($url);            
        }
        $sitemap->appendChild($urlset);
        $response->setContent($sitemap->saveXML());
        return $response;
    }
}