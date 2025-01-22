<?php

namespace App\Http\Controllers;


use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log; // Importar el facade Log
use Illuminate\Support\Facades\Storage;

class Backup_RestoreController extends Controller
{
    private $dbUser = 'admin_pfp';
    private $dbPassword = 'PFP_BD_2024';
    private $dbName = 'nombre_de_tu_bd';

    public function createBackup()
    {
        Log::info('Backup process started.');
        
        $backupFile = storage_path('app/backups/backup_' . date('Y_m_d_His') . '.sql');
        $command = sprintf(
            'PGPASSWORD="%s" pg_dump -U %s -F c -b -v -f %s %s',
            $this->dbPassword,
            $this->dbUser,
            $backupFile,
            $this->dbName
        );

        $result = null;
        $output = null;
        exec($command, $output, $result);

        if ($result === 0) {
            Log::info('Backup created successfully.');
            return redirect()->back()->with('success', 'Backup creado exitosamente.');
        } else {
            Log::error('Error creating backup.', ['output' => $output]);
            return redirect()->back()->with('error', 'Error al crear el backup.');
        }
    }   

    public function restoreBackup(Request $request)
    {
        $request->validate([
            'backup_file' => 'required|file|mimes:sql',
        ]);

        $backupFile = $request->file('backup_file')->storeAs('backups', 'restore_' . time() . '.sql');
        $backupFilePath = storage_path('app/' . $backupFile);
        $command = sprintf(
            'PGPASSWORD="%s" pg_restore -U %s -d %s -v %s',
            $this->dbPassword,
            $this->dbUser,
            $this->dbName,
            $backupFilePath
        );

        $result = null;
        $output = null;
        exec($command, $output, $result);

        if ($result === 0) {
            return redirect()->back()->with('success', 'Base de datos restaurada exitosamente.');
        } else {
            return redirect()->back()->with('error', 'Error al restaurar la base de datos.');
        }
    }
}
