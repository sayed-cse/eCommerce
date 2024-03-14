<?php
declare(strict_types=1);

namespace F\Libraries\RQueue;

require 'predis-2.2.2/autoload.php';

use Predis\Client;

class RedisQueueHandler
{
    protected $redis;
    protected $queueName;

    public function __construct($host, $port, $queueName)
    {
        $this->redis = new Client([
            'scheme' => 'tcp',
            'host'   => $host,
            'port'   => $port,
        ]);
        $this->queueName = $queueName;
    }

    public function enqueueTask($task)
    {
        $this->redis->rpush($this->queueName, json_encode($task));
    }

    public function dequeueTask()
    {
        $task = $this->redis->lpop($this->queueName);
        return $task ? json_decode($task, true) : null;
    }

    public function processNextTask()
    {
        $task = $this->dequeueTask();
        if ($task) {
            switch ($task['type']) {
                case 'email':
                    $this->sendEmail($task['to'], $task['subject'], $task['body']);
                    break;
                case 'file_upload':
                    $this->handleFileUpload($task['file']);
                    break;
                case 'post_request':
                    $this->handlePostRequest($task['data']);
                    break;
                default:
                    // Unsupported task type
                    break;
            }
        }
    }

    protected function sendEmail($to, $subject, $body)
    {
        //echo "Sending email to: $to\nSubject: $subject\nBody: $body\n";
    }

    protected function handleFileUpload($file)
    {
        //echo "Handling file upload for file: $file\n";
    }

    protected function handlePostRequest($data)
    {
        //echo "Handling POST request with data: ";
        //print_r($data);
    }
}

// Example usage:
$queueHandler = new RedisQueueHandler('127.0.0.1', 6379, 'tasks');
$queueHandler->enqueueTask([
    'type' => 'email',
    'to' => 'recipient@example.com',
    'subject' => 'Test Email',
    'body' => 'This is a test email.'
]);

$queueHandler->enqueueTask([
    'type' => 'file_upload',
    'file' => 'example.txt'
]);

$queueHandler->enqueueTask([
    'type' => 'post_request',
    'data' => ['key' => 'value']
]);

$queueHandler->processNextTask(); // Process the next task in the queue
