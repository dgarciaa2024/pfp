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
    public $userId; // New property to pass user ID
    public $userEmail; // New property to store user's email

    public function __construct($newPassword, $userId = null, $userEmail = null)
    {
        $this->newPassword = $newPassword;
        $this->userId = $userId; // Store the user ID for use in build method
        $this->userEmail = $userEmail; // Store the user's email
    }

    public function build()
    {
        if ($this->userEmail !== null) {
            try {
                // Use a transaction to ensure the update happens immediately
                DB::transaction(function () {
                    $user = DB::table('pfp_schema.tbl_usuario')
                        ->where('correo', $this->userEmail)
                        ->first();
                    
                    if ($user) {
                        $affectedRows = DB::table('pfp_schema.tbl_usuario')
                            ->where('id_usuario', $user->id_usuario)
                            ->update([
                                'contrasena' => $this->newPassword, 
                                'id_estado' => 4 // Assuming '4' is 'PENDIENTE'
                            ]);

                        // Log if update was successful or not
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
                // Log any exceptions that occur during the database operation
                Log::error("Exception occurred while updating user state for email {$this->userEmail}: " . $e->getMessage());
            }
        } else {
            Log::warning("User email was not provided for state change in ResetPasswordMail.");
        }

        return $this->subject('Restablecimiento de contraseña')
                    ->view('emails.ResetPassword')
                    ->with(['newPassword' => $this->newPassword]);
    }
}
