<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\DB;

class ResetPasswordNewMail extends Mailable
{
    use Queueable, SerializesModels;

    public $newPassword;
    public $expirationTime;

    public function __construct($newPassword)
    {
        $this->newPassword = $newPassword;
        // Obtener el valor del parámetro con id_parametro = 2
        $this->expirationTime = DB::table('pfp_schema.tbl_parametro')
            ->where('id_parametro', 2)
            ->value('valor'); // 'valor' debe ser el nombre de la columna que contiene el dato
    }

    public function build()
    {
        return $this->subject('Bienvenido al Portal de Fidelización de Pacientes - Contraseña Temporal')
                    ->view('emails.ResetPasswordNew')
                    ->with([
                        'newPassword' => $this->newPassword,
                        'expirationTime' => $this->expirationTime
                    ]);
    }
}