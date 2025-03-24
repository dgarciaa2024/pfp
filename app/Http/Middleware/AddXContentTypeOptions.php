<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class AddXContentTypeOptions
{
    /**
     * Manejar una solicitud entrante.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle(Request $request, Closure $next)
    {
        $response = $next($request);

        // Agregar el encabezado X-Content-Type-Options
        $response->headers->set('X-Content-Type-Options', 'nosniff');

        return $response;
    }
}
