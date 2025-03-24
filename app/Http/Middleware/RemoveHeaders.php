<?php
namespace App\Http\Middleware;

use Closure;

class RemoveHeaders
{
    public function handle($request, Closure $next)
    {
        $response = $next($request);
        $response->headers->remove('X-Powered-By');
        return $response;
    }
}