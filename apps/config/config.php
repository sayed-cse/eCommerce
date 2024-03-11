<?php
use Phalcon\Config\Config;
//$config = new Phalcon\Config\Adapter\Php('path/config.php');
$config = new Config(array(
    'database'			=> array(
	'mysql'				=> array(
		'adapter'		=> 'Mysql',
		'host'			=> 'localhost',
		'username'		=> 'root',
		'password'		=> '$#Admin1',
		'dbname'		=> 'phalconshop',
        'charset'       => 'utf8mb4',
        'collation'     => 'utf8mb4_unicode_ci',        
	)),
    'appF'              => array(
        'controllersDir'=> '/front/controllers/',
        'modelsDir'		=> '/front/models/',
        'viewsDir'		=> '/front/views/',
        'pluginsDir'	=> '/plugins/',
        'libraryDir'	=> '/library/',
        'helpersDir'	=> '/helpers/',
        'formsDir'		=> '/forms/',
        'cacheDir'		=> '/cache/volt/',
        'sessionDir'    => '/cache/session/',
        'logsDir'       => '/cache/logs/',
        'encryptKey'    => '$#\*0\19\/\/\unaz\@\3m\FireFly\!0\Kiyani',
        'baseUri'       => '/f/',
        'StaticBaseUri' => '/f/',
        'debug'         => '0',
    ),
    'settings'          => array(
        'development'   => false,
        'production'    => true,
    ),
    'appB'              => array(
        'controllersDir'=> '/back/controllers/',
        'modelsDir'     => '/back/models/',
        'viewsDir'      => '/back/views/',
        'pluginsDir'    => '/plugins/',
        'libraryDir'    => '/library/',
        'helpersDir'    => '/helpers/',
        'formsDir'      => '/forms/',
        'cacheDir'      => '/cache/volt/',
        'sessionDir'    => '/cache/session/',
        'logsDir'       => '/cache/logs/',
        'encryptKey'    => '$#\*0\19\/\/\unaz\@\3m\FireFly\!0\Kiyani',
        'baseUri'       => '/f/',
        'StaticBaseUri' => '/f/',
        'debug'         => '0',
    ),    
    'mail'              => array(
        'driver'        => 'smtp',
        'host'          => 'smtp.gmail.com',                           
        'username'      => 'esp.cypher@gmail.com',            
        'password'      => 'riaxivyajusqdhnp', //Should Regenerated with 2FA Activated                           
        'security'      => 'tls',     //ssl:465, tls:587                       
        'port'          => 587, 
        'charset'       => 'UTF-8',
        'email'         => 'esp.cypher@gmail.com',
        'name'          => 'webmaster',
    ),
    'redis'             => array(
        'host'          => '127.0.0.1',
        'port'          => '6379',
        'password'      => '',
        'persistent'    => false
    ),
    'facebook'          => array(
        'clientId'      => '',
        'clientSecret'  => '',
        'redirectUri'   => '',
        'pageId'        => '',
    ),
    'google'            => array(
        'client_id'     => '',
        'client_secret' => '',
        'redirectUri'   => '',
    ),
    'twitter'           => array(
        'key'           => '',
        'secret'        => '',
    ),
    'pinterest'         => array(
        'key'           => '',
        'secret'        => '',
    ),    
#EOF
));
