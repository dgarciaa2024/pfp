<?php

namespace App\Helpers;

use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class LoggerHelper
{
    public static function log($accion, $descripcion, $idObjeto = null)
    {
        try {
            // Obtener el ID del usuario actual, si está autenticado
            $idUsuario = Auth::check() ? Auth::id() : null;

            // Insertar el registro en la tabla tbl_bitacora
            DB::table('pfp_schema.tbl_bitacora')->insert([
                'fecha' => now(),
                'id_usuario' => $idUsuario,
                'id_objeto' => $idObjeto,
                'accion' => $accion,
                'descripcion' => $descripcion,
            ]);

            // Registrar en el archivo de logs de Laravel
            Log::info("[$accion] $descripcion (ID Usuario: $idUsuario, ID Objeto: $idObjeto)");
        } catch (\Exception $e) {
            // Registrar cualquier error que ocurra al intentar registrar la bitácora
            Log::error("Error al registrar en la bitácora: " . $e->getMessage());
        }
    }
}
