<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;

class Backup_RestoreController extends Controller
{
    // Método para crear el backup
    public function backup(Request $request)
    {
        // Generar un nombre de archivo único
        $filename = 'backup_' . now()->format('Y_m_d_H_i_s') . '.sql';
        
        // Usar una carpeta temporal específica en el servidor
        $tempDir = 'C:\\Temp'; // Ajusta esta ruta a una carpeta existente y escribible en tu servidor
        if (!is_dir($tempDir)) {
            mkdir($tempDir, 0777, true); // Crear la carpeta si no existe
        }
        $backupPath = $tempDir . '\\' . $filename;

        // Verificar permisos
        if (!is_writable($tempDir)) {
            return back()->with('error', 'La carpeta temporal no es escribible: ' . $tempDir . '. Ajusta los permisos en el servidor.');
        }

        // Ruta explícita de pg_dump (ajustar según la instalación en el servidor)
        $pgDumpPath = 'C:\\Program Files\\PostgreSQL\\16\\bin\\pg_dump.exe'; // Cambiar si es necesario
        if (!file_exists($pgDumpPath)) {
            return back()->with('error', 'pg_dump no encontrado en: ' . $pgDumpPath . '. Verifica la instalación de PostgreSQL en el servidor.');
        }

        // Construir el comando pg_dump
        $command = "\"$pgDumpPath\" --host=" . env('DB_HOST') .
                   " --port=" . env('DB_PORT') .
                   " --username=" . env('DB_USERNAME') .
                   " --dbname=" . env('DB_DATABASE') .
                   " --no-password --inserts --encoding=UTF8 > \"$backupPath\" 2>&1";

        // Ejecutar el comando y capturar salida
        putenv('PGPASSWORD=' . env('DB_PASSWORD')); // Establecer la contraseña temporalmente
        $output = [];
        $result_code = null;
        exec($command, $output, $result_code);

        // Verificar si el comando tuvo éxito
        if ($result_code !== 0) {
            $outputMessage = !empty($output) ? implode("\n", $output) : 'Sin detalles';
            return back()->with('error', 'Error al crear el backup. Código: ' . $result_code . '. Detalles: ' . $outputMessage . '. Comando: ' . $command);
        }

        // Verificar que el archivo se creó
        if (!file_exists($backupPath)) {
            return back()->with('error', 'El archivo de backup no se creó en: ' . $backupPath);
        }

        // Devolver el archivo como descarga
        $headers = [
            'Content-Type' => 'application/sql',
            'Content-Disposition' => 'attachment; filename="' . $filename . '"',
        ];
        return response()->download($backupPath, $filename, $headers)->deleteFileAfterSend(true);
    }

    // Método para restaurar el backup
    public function restore(Request $request)
    {
        // Validar el archivo cargado
        $request->validate([
            'backup_file' => 'required|file',
        ]);

        // Guardar el archivo cargado temporalmente
        $tempDir = 'C:\\Temp'; // Ajusta esta ruta a una carpeta existente y escribible en tu servidor
        if (!is_dir($tempDir)) {
            mkdir($tempDir, 0777, true); // Crear la carpeta si no existe
        }
        $uploadedFile = $request->file('backup_file');
        $filePath = $tempDir . '\\' . $uploadedFile->getClientOriginalName();
        $uploadedFile->move($tempDir, $uploadedFile->getClientOriginalName());

        // Ruta explícita de psql (ajusta según tu instalación en el servidor)
        $psqlPath = 'C:\\Program Files\\PostgreSQL\\16\\bin\\psql.exe'; // Cambia esto si es necesario
        if (!file_exists($psqlPath)) {
            return back()->with('error', 'psql no encontrado en: ' . $psqlPath . '. Verifica la instalación de PostgreSQL en el servidor.');
        }

        // Construir el comando psql
        $command = "\"$psqlPath\" --host=" . env('DB_HOST') .
                   " --port=" . env('DB_PORT') .
                   " --username=" . env('DB_USERNAME') .
                   " --dbname=" . env('DB_DATABASE') .
                   " --no-password -f \"$filePath\" 2>&1";

        // Ejecutar el comando
        putenv('PGPASSWORD=' . env('DB_PASSWORD')); // Establecer la contraseña temporalmente
        $output = [];
        $result_code = null;
        exec($command, $output, $result_code);

        // Verificar si el comando tuvo éxito
        if ($result_code !== 0) {
            $outputMessage = !empty($output) ? implode("\n", $output) : 'Sin detalles';
            return back()->with('error', 'Error al restaurar el backup. Código: ' . $result_code . '. Detalles: ' . $outputMessage);
        }

        return back()->with('success', 'La base de datos se ha restaurado correctamente desde el archivo: ' . $uploadedFile->getClientOriginalName());
    }
}