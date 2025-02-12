<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;

class Backup_RestoreController extends Controller
{
    // Método para crear el backup
    public function backup()
    {
        // Ruta del archivo de backup
        $filename = 'backup_' . now()->format('Y_m_d_H_i_s') . '.sql';
        $backupPath = storage_path('app/backups/' . $filename);

        // Crear la carpeta de backups si no existe
        if (!File::exists(storage_path('app/backups'))) {
            File::makeDirectory(storage_path('app/backups'), 0755, true);
        }

        // Construir el comando pg_dump para generar un archivo SQL codificado
        $command = "pg_dump --host=" . env('DB_HOST') .
                   " --port=" . env('DB_PORT') .
                   " --username=" . env('DB_USERNAME') .
                   " --dbname=" . env('DB_DATABASE') .
                   " --no-password --inserts --encoding=UTF8 > \"$backupPath\"";

        // Ejecutar el comando
        putenv('PGPASSWORD=' . env('DB_PASSWORD')); // Establecer la contraseña temporalmente
        $output = null;
        $result_code = null;
        exec($command, $output, $result_code);

        // Verificar si el comando tuvo éxito
        if ($result_code !== 0) {
            return back()->with('error', 'Hubo un error al crear el backup. Código de error: ' . $result_code);
        }

        return back()->with('success', 'El backup se ha creado correctamente en: ' . $filename);
    }

    // Método para restaurar el backup
    public function restore(Request $request)
    {
        // Validar el archivo cargado
        $request->validate([
            'backup_file' => 'required|file',
        ]);

        // Guardar el archivo cargado temporalmente
        $uploadedFile = $request->file('backup_file');
        $filePath = storage_path('app/backups/' . $uploadedFile->getClientOriginalName());
        $uploadedFile->move(storage_path('app/backups'), $uploadedFile->getClientOriginalName());

        // Construir el comando psql para restaurar el archivo SQL
        $command = "psql --host=" . env('DB_HOST') .
                   " --port=" . env('DB_PORT') .
                   " --username=" . env('DB_USERNAME') .
                   " --dbname=" . env('DB_DATABASE') .
                   " --no-password -f \"$filePath\"";

        // Ejecutar el comando
        putenv('PGPASSWORD=' . env('DB_PASSWORD')); // Establecer la contraseña temporalmente
        $output = null;
        $result_code = null;
        exec($command, $output, $result_code);

        // Verificar si el comando tuvo éxito
        if ($result_code !== 0) {
            return back()->with('error', 'Hubo un error al restaurar el backup. Código de error: ' . $result_code);
        }

        return back()->with('success', 'La base de datos se ha restaurado correctamente desde el archivo: ' . $uploadedFile->getClientOriginalName());
    }
}
