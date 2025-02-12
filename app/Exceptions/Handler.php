<?php

namespace App\Exceptions;

use Illuminate\Foundation\Exceptions\Handler as ExceptionHandler;
use Throwable;
use App\Helpers\LoggerHelper;

class Handler extends ExceptionHandler
{
    /**
     * Una lista de los tipos de excepciones que no se reportarán.
     *
     * @var array<int, class-string<\Throwable>>
     */
    protected $dontReport = [
        //
    ];

    /**
     * Una lista de los datos que no deben incluirse en los informes de excepción.
     *
     * @var array<string>
     */
    protected $dontFlash = [
        'password',
        'password_confirmation',
    ];

    /**
     * Reportar o registrar una excepción.
     *
     * @param  \Throwable  $e
     * @return void
     * @throws \Throwable
     */
    public function report(Throwable $e)
    {
        // Registrar el error en la bitácora
        if ($this->shouldReport($e)) {
            LoggerHelper::log(
                'Error del sistema',
                $e->getMessage(),
                null, // No hay un ID específico de usuario aquí
                [
                    'file' => $e->getFile(),
                    'line' => $e->getLine(),
                    'trace' => $e->getTraceAsString(),
                ]
            );
        }

        parent::report($e);
    }

    /**
     * Renderizar una excepción en una respuesta HTTP.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Throwable  $e
     * @return \Symfony\Component\HttpFoundation\Response
     */
    public function render($request, Throwable $e)
    {
        return parent::render($request, $e);
    }
}
