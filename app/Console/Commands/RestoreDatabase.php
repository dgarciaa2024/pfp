<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\Storage;

class RestoreDatabase extends Command
{
    protected $signature = 'database:restore {file}';
    protected $description = 'Restaura la base de datos PostgreSQL desde un archivo SQL';

    public function handle()
    {
        $file = $this->argument('file');  // Nombre del archivo

        $dbHost = config('database.connections.pgsql.host');
        $dbPort = config('database.connections.pgsql.port');
        $dbName = config('database.connections.pgsql.database');
        $dbUser = config('database.connections.pgsql.username');
        $dbPassword = config('database.connections.pgsql.password');

        // Ruta completa del archivo a restaurar
        $filePath = storage_path("app/backups/{$file}");

        // Verificar si el archivo existe
        if (!file_exists($filePath)) {
            $this->error('El archivo no existe.');
            return;
        }

        // Comando para restaurar la base de datos con pg_restore
        $command = "PGPASSWORD={$dbPassword} pg_restore -h {$dbHost} -p {$dbPort} -U {$dbUser} -d {$dbName} -v {$filePath}";

        $output = null;
        $resultCode = null;
        exec($command, $output, $resultCode);

        if ($resultCode === 0) {
            $this->info('Restauración completada exitosamente.');
        } else {
            $this->error('Error al restaurar la base de datos.');
        }
    }
}
