<?php

namespace App\Http\Controllers;

use App\Models\User; // Importa el modelo User
use App\Mail\ResetPasswordMail; // Importa la clase de correo
use Illuminate\Http\Request; // Importa la clase Request
use Illuminate\Support\Facades\Mail; // Importa la fachada Mail
use Illuminate\Support\Str; // Importa la clase Str para generar cadenas aleatorias

class PasswordController extends Controller
{
    // Método para restablecer la contraseña
    public function resetPassword(Request $request)
    {
        // Validar el request
        $request->validate([
            'nombre_usuario' => 'required|string|max:255',
        ]);

        // Buscar el usuario por nombre de usuario (asegurándote de que sea en mayúsculas)
        $user = User::where('nombre_usuario', strtoupper($request->input('nombre_usuario')))->first();

        // Si el usuario no existe, devolver un error
        if (!$user) {
            return back()->withErrors(['user' => 'El usuario no existe.']);
        }

        // Generar una nueva contraseña aleatoria
        $newPassword = Str::random(10); // Cambia esto por tu lógica de generación de contraseñas robustas

        // Almacenar la nueva contraseña en la base de datos (asegurándote de cifrarla)
        $user->password = bcrypt($newPassword); // Asegúrate de que el campo en tu base de datos se llame 'password'
        $user->save();

        // Enviar el correo con la nueva contraseña
        Mail::to($user->email)->send(new ResetPasswordMail($newPassword));

        // Devolver un mensaje de éxito
        return back()->with('status', 'Se ha enviado un correo con la nueva contraseña.');
    }
}
