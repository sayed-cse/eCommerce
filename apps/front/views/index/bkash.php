<?php

// bKash Merchant Information

$msisdn = "01615577997"; // bKash Merchant Number

$user = "sayed"; // bKash Merchant Username

$pass = "0786"; // bKash Merchant Password

$url = "https://www.bkashcluster.com:9081"; // bKash API URL with Port Number

$trxid = "1615577997"; // bKash Transaction ID : TrxID 66666AAAAA


// Final URL for getting response from bKash

$bkash_url = $url.'/dreamwave/merchant/trxcheck/sendmsg?user='.$user.'&pass='.$pass.'&msisdn='.$msisdn.'&trxid='.$trxid;


$curl = curl_init();

curl_setopt_array($curl, array(

    CURLOPT_PORT => 9081,

    CURLOPT_URL => $bkash_url,

    CURLOPT_RETURNTRANSFER => true,

    CURLOPT_ENCODING => "",

    CURLOPT_MAXREDIRS => 10,

    CURLOPT_TIMEOUT => 30,

    CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,

    CURLOPT_CUSTOMREQUEST => "GET",

    CURLOPT_HTTPHEADER => array(

        "cache-control: no-cache",

        "content-type: application/json"
    ),

));

$response = curl_exec($curl);

$err = curl_error($curl);

$http_code = curl_getinfo($curl, CURLINFO_HTTP_CODE);

curl_close($curl);

    //print_r($response); // For Getting all Response Data.

    $api_response = json_decode ($response, true);  // Getting Response from bKash API.

    $transaction_status = $api_response['transaction']['trxStatus']; // Transaction Status Codes
    

        if ($err || $transaction_status == "4001") {
                echo 'Problem for Sending Response to bKash API ! Try Again after fews minutes.';
            }
        else
        {
// Assign Transaction Information

            $transaction_amount = $api_response['transaction']['amount']; // bKash Payment Amount

            $transaction_reference = $api_response['transaction']['reference']; // bKash Reference for Invoice ID

            $transaction_time = $api_response['transaction']['trxTimestamp']; // bKash Transaction Time & Date
            
// Print Transaction Information

            echo $transaction_status."<br>".$transaction_amount."<br>".$transaction_reference."<br>".$transaction_time;
        }
?>
