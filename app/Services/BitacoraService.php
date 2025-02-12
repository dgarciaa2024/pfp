<?php

namespace App\Services;

use App\Models\Bitacora;
use Carbon\Carbon;

class BitacoraService
{
    /**
     * Registrar un evento en la bitácora.
     *
     * @param string $accion
     * @param string $descripcion
     * @param int|null $id_usuario
     * @param int|null $id_objeto
     */
    public static function registrar($accion, $descripcion, $id_usuario = null, $id_objeto = null)
    {
        Bitacora::create([
            'fecha' => Carbon::now(),
            'id_usuario' => $id_usuario ?? auth()->id(),
            'id_objeto' => $id_objeto,
            'accion' => $accion,
            'descripcion' => $descripcion,
        ]);
    }
}
