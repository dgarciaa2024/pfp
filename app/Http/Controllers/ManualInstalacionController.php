<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log; // Importar la clase Log

class ManualInstalacionController extends Controller
{
    public function mostrarManual()
    {
        // Consultar el valor del id_parametro = 9 desde la tabla pfp_schema.tbl_parametro
        $parametro = DB::table('pfp_schema.tbl_parametro')
                       ->where('id_parametro', 11)
                       ->first();

        // Si no se encuentra el parámetro, redirigir con un error
        if (!$parametro) {
            return redirect()->back()->with('error', 'No se encontró el enlace del archivo en la base de datos.');
        }

        // Obtener el valor de la columna "valor" (enlace completo)
        $enlaceCompleto = $parametro->valor;

        // Verificar si el enlace está vacío o no es válido
        if (empty($enlaceCompleto)) {
            return redirect()->back()->with('error', 'El enlace del archivo está vacío o no es válido.');
        }

        // Registrar el valor de $enlaceCompleto en el archivo de logs
        Log::info('Valor de $enlaceCompleto:', ['enlace' => $enlaceCompleto]);

        // Pasar el enlace completo a la vista
        return view('manual-instalacion', compact('enlaceCompleto'));
    }
}


