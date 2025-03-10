<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Carbon;

class BackupDatabase extends Command
{
    protected $signature = 'database:backup';
    protected $description = 'Genera un respaldo de la base de datos PostgreSQL en AWS RDS';

    public function handle()
    {
        $dbHost = config('database.connections.pgsql.host');
        $dbPort = config('database.connections.pgsql.port');
        $dbName = config('database.connections.pgsql.database');
        $dbUser = config('database.connections.pgsql.username');
        $dbPassword = config('database.connections.pgsql.password');

        // Nombre del archivo de backup
        $timestamp = Carbon::now()->format('Y-m-d_H-i-s');
        $backupFile = storage_path("app/backups/backup_{$timestamp}.sql");

        // Comando pg_dump
        $command = "PGPASSWORD={$dbPassword} pg_dump -h {$dbHost} -p {$dbPort} -U {$dbUser} -F c -b -v -f {$backupFile} {$dbName}";

        // Ejecutar el comando
        $output = null;
        $resultCode = null;
        exec($command, $output, $resultCode);

        if ($resultCode === 0) {
            $this->info("Backup creado exitosamente en: {$backupFile}");
        } else {
            $this->error("Error al crear el backup.");
        }
    }
}
