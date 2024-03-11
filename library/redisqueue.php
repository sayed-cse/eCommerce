<?php 
declare(strict_types=1);
$redis = new Redis(); 
$redis->pconnect('127.0.0.1',6379); 
while(True){ 
    try{ 
        echo $redis->LPOP('key1')."\n"; 
    }catch(Exception $e){ 
        echo($e->getMessage()."\n"); 
    } 
    sleep(rand()%3); 
}
?>         