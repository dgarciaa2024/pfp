<?php

namespace App\Listeners;

use Illuminate\Auth\Events\Login;
use App\Helpers\LoggerHelper;

class LogSuccessfulLogin
{
    /**
     * Handle the event.
     *
     * @param  \Illuminate\Auth\Events\Login  $event
     * @return void
     */
    public function handle(Login $event)
    {
        $usuario = $event->user;
        LoggerHelper::log('Inicio de sesión', "El usuario {$usuario->name} inició sesión.");
    }
}
