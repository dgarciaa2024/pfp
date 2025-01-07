<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class RoleMiddleware
{
    /**
     * Maneja la solicitud entrante.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @param  string  $role
     * @return mixed
     */
    public function handle(Request $request, Closure $next, $role)
    {
        $userRole = auth()->user()->id_rol; // Cambia esto según tu esquema

        // Si el usuario no tiene el rol requerido, redirigir o mostrar error
        if ($userRole != $role) {
            return redirect('/')->with('error', 'No tienes permiso para acceder a esta página.');
        }

        return $next($request);
    }
}
