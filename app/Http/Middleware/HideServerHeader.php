<?php

namespace App\Http\Middleware;

use Closure;

class HideServerHeader
{
    public function handle($request, Closure $next)
    {
        $response = $next($request);
        $response->headers->remove('Server'); // Oculta la versión del servidor
        return $response;
    }
}