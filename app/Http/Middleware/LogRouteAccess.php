<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Support\Facades\Route;
use App\Helpers\LoggerHelper;

class LogRouteAccess
{
    public function handle($request, Closure $next)
    {
        $routeName = Route::currentRouteName();
        LoggerHelper::log('Acceso', "Acceso a la ruta: {$routeName}");
        return $next($request);
    }
}
