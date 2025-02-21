<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class BitacoraController extends Controller
{
    /**
     * Muestra los registros de la bitácora en una vista paginada.
     */
    public function index()
    {
        // Recuperar registros desde la tabla de bitácora
        $logs = DB::table('pfp_schema.tbl_bitacora')
            ->orderBy('fecha', 'desc') // Ordenar por la fecha más reciente
            ->paginate(10); // Paginación: 10 registros por página

        // Retornar la vista de la bitácora con los registros
        return view('modulo_usuarios.Bitacora', compact('logs'));
    }
}
