<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\File;


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

    public function restoreDatabase(Request $request)
    {
        try {
            // Validar el archivo
            $request->validate([
                'backup_file' => 'required|file|max:10240',  // Máximo 10MB
            ]);

            // Subir el archivo
            $file = $request->file('backup_file');
            $fileName = 'backup_' . time() . '.sql';
            $filePath = "backups/{$fileName}";

            if (!$file->storeAs('backups', $fileName)) {
                return redirect()->back()->with('error', 'Error al subir el archivo.');
            }

            // Verificar que el archivo realmente se haya subido
            if (!Storage::exists($filePath)) {
                return redirect()->back()->with('error', 'El archivo no se guardó correctamente.');
            }

            // Ejecutar el comando de Artisan para restaurar la base de datos
            $exitCode = Artisan::call('database:restore', ['file' => $fileName]);

            if ($exitCode !== 0) {
                return redirect()->back()->with('error', 'Error al restaurar la base de datos.');
            }

            return redirect()->back()->with('success', 'Base de datos restaurada exitosamente.');

        } catch (\Exception $e) {
            Log::error('Error al restaurar la base de datos: ' . $e->getMessage());
            return redirect()->back()->with('error', 'Ocurrió un error inesperado al restaurar la base de datos(' . $e->getFile() . ', ' . $e->getLine() . '): ' . $e->getMessage());
        }
    }

    public function generateAndDownloadBackup()
    {
        try {
            // Ejecutar el comando Artisan para generar el backup
            Artisan::call('database:backup');

            // Esperar un momento para asegurarse de que el archivo se haya generado
            sleep(2);

            // Definir la carpeta donde se almacenan los backups
            $backupPath = storage_path("app/backups/");

            // Verificar si el directorio existe
            if (!File::exists($backupPath)) {
                return response()->json(['error' => 'La carpeta de backups no existe.'], 500);
            }

            // Obtener la lista de archivos en el directorio
            $files = File::files($backupPath);

            // Verificar si hay archivos
            if (empty($files)) {
                return response()->json(['error' => 'No se encontró ningún archivo de backup.'], 500);
            }

            // Ordenar los archivos por fecha de modificación y tomar el más reciente
            usort($files, function ($a, $b) {
                return $b->getMTime() - $a->getMTime();
            });

            $latestBackup = $files[0]->getRealPath(); // Ruta completa del último backup
            $fileName = basename($latestBackup); // Nombre del archivo

            // Verificar si el archivo existe antes de descargarlo
            if (!File::exists($latestBackup)) {
                return response()->json(['error' => 'El archivo de backup no se encuentra.'], 500);
            }

            // Retornar la descarga del archivo directamente
            return response()->download($latestBackup, $fileName)->deleteFileAfterSend(true);

        } catch (\Exception $e) {
            Log::error('Error al generar o descargar el backup: ' . $e->getMessage());
            return response()->json(['error' => 'Ocurrió un error inesperado al generar el backup.'], 500);
        }
    }
}