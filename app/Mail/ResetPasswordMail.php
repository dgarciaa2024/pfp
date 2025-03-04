<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class ResetPasswordMail extends Mailable
{
    use Queueable, SerializesModels;

    public $newPassword;
    public $userId;
    public $userEmail;
    public $expirationTime; // Nueva propiedad para almacenar el tiempo de expiración

    public function __construct($newPassword, $userId = null, $userEmail = null)
    {
        $this->newPassword = $newPassword;
        $this->userId = $userId;
        $this->userEmail = $userEmail;
        
        // Obtener el valor del parámetro desde la tabla
        $this->expirationTime = DB::table('pfp_schema.tbl_parametro')
            ->where('id_parametro', 2)
            ->value('valor') ?? '24'; // Si no encuentra el parámetro, usa 24 como default
    }

    public function build()
    {
        if ($this->userEmail !== null) {
            try {
                DB::transaction(function () {
                    $user = DB::table('pfp_schema.tbl_usuario')
                        ->where('correo', $this->userEmail)
                        ->first();
                    
                    if ($user) {
                        $affectedRows = DB::table('pfp_schema.tbl_usuario')
                            ->where('id_usuario', $user->id_usuario)
                            ->update([
                                'contrasena' => $this->newPassword, 
                                'id_estado' => 4
                            ]);

                        if ($affectedRows > 0) {
                            Log::info("User state updated successfully for email: {$this->userEmail}");
                        } else {
                            Log::warning("Failed to update user state for email: {$this->userEmail}");
                        }
                    } else {
                        Log::warning("No user found with email: {$this->userEmail}");
                    }
                });
            } catch (\Exception $e) {
                Log::error("Exception occurred while updating user state for email {$this->userEmail}: " . $e->getMessage());
            }
        } else {
            Log::warning("User email was not provided for state change in ResetPasswordMail.");
        }

        return $this->subject('Restablecimiento de contraseña')
                    ->view('emails.ResetPassword')
                    ->with([
                        'newPassword' => $this->newPassword,
                        'expirationTime' => $this->expirationTime // Pasamos el valor a la vista
                    ]);
    }
}