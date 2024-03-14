<?php
declare(strict_types=1);

namespace F\Libraries\BackupDB;

use Phalcon\Db\Adapter\Pdo\AbstractPdo;

class DbBackup
{
    private $db;
    private $backupFolderPath;

    public function __construct(AbstractPdo $db, string $backupFolderPath)
    {
        $this->db = $db;
        $this->backupFolderPath = $backupFolderPath;
    }

    public function backupDatabase()
    {
        $backupFilePath = $this->backupFolderPath . "/" . $this->db->getDescriptor()['dbname'] . "_" . date("Y-m-d_H-i-s") . ".sql";

        $this->removePreviousBackupFiles();

        $process = proc_open(
            sprintf(
                "mysqldump --host=%s --user=%s --password=%s %s",
                escapeshellarg($this->db->getDescriptor()['host']),
                escapeshellarg($this->db->getDescriptor()['username']),
                escapeshellarg($this->db->getDescriptor()['password']),
                escapeshellarg($this->db->getDescriptor()['dbname'])
            ),
            [
                0 => ["pipe", "r"],  // stdin
                1 => ["file", $backupFilePath, "w"],  // stdout
                2 => ["pipe", "w"]   // stderr
            ],
            $pipes
        );

        if (!is_resource($process)) {
            error_log("Failed to initiate mysqldump process.");
            #echo "Failed to initiate mysqldump process.";
            return;
        }

        fclose($pipes[0]); // Close stdin

        $errors = stream_get_contents($pipes[2]); // Read errors
        fclose($pipes[2]); // Close stderr

        $return_value = proc_close($process); // Close process

        if ($return_value === 0) {
            #echo "Database backup created successfully: $backupFilePath";
            error_log("Database backup created successfully: $backupFilePath");
        } else {
            #echo "Errors occurred during database backup: $errors";
            error_log("Errors occurred during database backup: $errors");
        }
    }

    private function removePreviousBackupFiles()
    {
        array_map('unlink', glob($this->backupFolderPath . "/" . $this->db->getDescriptor()['dbname'] . "_*.sql"));
    }
}
