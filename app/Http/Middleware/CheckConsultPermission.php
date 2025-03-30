<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class CheckConsultPermission
{
    public function handle(Request $request, Closure $next, $objectId)
    {
        $user = Auth::user();

        if (!$user) {
            return redirect('/login')->with('error', 'Debes iniciar sesión.');
        }

        // Consultar permisos en la tabla tbl_permiso
        $hasPermission = DB::table('pfp_schema.tbl_permiso')
            ->where('id_rol', $user->id_rol) // Usar id_rol del usuario autenticado
            ->where('id_objeto', $objectId)  // ID del objeto pasado como parámetro
            ->where('permiso_consultar', 1)  // Verificar permiso de consulta
            ->exists();

        if (!$hasPermission) {
            return response()->view('errors.403', [], 403);
        }

        return $next($request);
    }
}