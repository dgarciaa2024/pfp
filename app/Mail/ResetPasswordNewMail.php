<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class ResetPasswordNewMail extends Mailable
{
    use Queueable, SerializesModels;

    public $newPassword;

    public function __construct($newPassword)
    {
        $this->newPassword = $newPassword;
    }

    public function build()
    {
        return $this->subject('Bienvenido al Portal de Fidelización de Pacientes     - Contraseña Temporal')
                    ->view('emails.ResetPasswordNew')
                    ->with(['newPassword' => $this->newPassword]);
    }
}
