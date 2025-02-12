<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Mail;
use App\Mail\ResetPasswordMail; // Asegúrate de que este archivo exista
use Carbon\Carbon;

class ForgotPasswordController extends Controller
{
    public function showForgotPasswordForm()
    {
        return view('modulo_usuarios.ForgotPassword');
    }

    public function sendResetLink(Request $request)
    {
        // Validación de entrada
        $request->validate([
            'email' => 'required|string|max:255|email',  // Añadido 'email' para validar el formato del correo
        ]);

        // Obtener el usuario en mayúsculas
        $email = ($request->input('email'));

        // Buscar el usuario en la base de datos
        $user = DB::table('pfp_schema.tbl_usuario')->where('email', $email)->first();

        if (!$user) {
            return back()->withErrors(['email' => 'El email no existe.']);
        }

        // Generar una nueva contraseña temporal
        $newPassword = $this->generatePassword();
        // Opcional: Establecer la fecha de expiración de la contraseña
        $expiresAt = Carbon::now()->addHours(config('app.reset_password_expiry', 24));

        // Actualizar la contraseña en la base de datos sin encriptar
        DB::table('pfp_schema.tbl_usuario')->where('id_usuario', $user->id_usuario)->update([
            'contrasena' => $newPassword,
            // 'expira_contrasena' => $expiresAt, // Descomenta si deseas usar este campo
        ]);

        // Enviar un correo con la nueva contraseña
        Mail::to($user->email)->send(new ResetPasswordMail($newPassword));

        return back()->with('status', 'Correo de restablecimiento enviado exitosamente.');
    }

    private function generatePassword()
    {
        // Genera una contraseña compleja de al menos 8 caracteres
        $length = config('app.min_contraseña', 8); // Asegúrate de tener esta configuración
        $symbols = '!@#$%^&*';
        return substr(str_shuffle('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'.$symbols), 0, $length);
    }
}