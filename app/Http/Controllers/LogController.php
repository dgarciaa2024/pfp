<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class LogController extends Controller
{
    public function index()
    {
        // Obtén los registros de la tabla bitácora
        $logs = DB::table('pfp_schema.tbl_bitacora')->orderBy('fecha', 'desc')->get();

        // Retorna la vista con los datos
        return view('modulo_usuarios.Backup_Restore', compact('logs'));
    }
}
