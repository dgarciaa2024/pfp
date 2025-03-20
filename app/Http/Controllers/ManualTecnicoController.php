<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class ManualTecnicoController extends Controller
{
    public function mostrarManual()
    {
        // Enlace por defecto para el manual técnico
        $enlaceCompleto = 'https://drive.google.com/file/d/default-tecnico/preview';

        try {
            // Consultar el valor del id_parametro = 9 para el manual técnico
            $parametro = DB::table('pfp_schema.tbl_parametro')
                           ->where('id_parametro', 9)
                           ->first();

            // Log para depuración
            Log::info('Consulta para manual técnico:', [
                'parametro' => $parametro,
                'valor' => $parametro ? $parametro->valor : 'No encontrado'
            ]);

            // Si se encuentra un valor válido, usarlo
            if ($parametro && !empty(trim($parametro->valor))) {
                $enlaceCompleto = trim($parametro->valor);
                Log::info('Enlace asignado para manual técnico:', ['enlaceCompleto' => $enlaceCompleto]);
            } else {
                Log::warning('No se encontró el parámetro o el valor está vacío para manual técnico, usando enlace por defecto');
            }
        } catch (\Exception $e) {
            Log::error('Error al consultar la BD para manual técnico:', ['exception' => $e->getMessage()]);
        }

        // Pasar el enlace a la vista
        return view('manual-tecnico', compact('enlaceCompleto'));
    }
}