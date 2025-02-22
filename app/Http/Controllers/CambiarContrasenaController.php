<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Crypt; // Agrega esta línea para usar Crypt
use Illuminate\Contracts\Encryption\DecryptException; // Para manejar excepciones de desencriptación

class CambiarContrasenaController extends Controller
{
    public function index()
    {
        if (!auth()->check()) {
            return redirect()->route('login');
        }
        return view('modulo_usuarios.CambiarContrasena');
    }

    public function store(Request $request)
    {
        if (!auth()->check()) {
            return redirect()->route('login')->with('error', 'You must be logged in to change your password.');
        }
        // Obtener el usuario autenticado en mayúsculas
        $usuario = strtoupper(auth()->user()->usuario);
        $contrasenaActual = $request->input('contrasena_actual');
        $nuevaContrasena = $request->input('nueva_contrasena');
        $confirmarContrasena = $request->input('confirmar_contrasena');

        // Validaciones de las contraseñas
        $request->validate([
            'contrasena_actual' => 'required',
            'nueva_contrasena' => 'required|min:8|max:20|different:contrasena_actual',
            'confirmar_contrasena' => 'required|same:nueva_contrasena',
        ]);

        // Buscar el usuario en la base de datos
        $user = DB::table('pfp_schema.tbl_usuario')
                    ->where('usuario', $usuario)
                    ->first();

        // Verificar que el usuario exista y que la contraseña actual coincida (desencriptando)
        if (!$user) {
            return redirect()->back()->withErrors(['contrasena_actual' => 'El usuario no existe.']);
        }

        // Desencriptar la contraseña almacenada
        $contrasenaAlmacenada = "";
        try {
            $contrasenaAlmacenada = Crypt::decryptString($user->contrasena);
        } catch (DecryptException $e) {
            // Si no se puede desencriptar, asumir que no está encriptada
            $contrasenaAlmacenada = $user->contrasena;
        }

        // Comparar la contraseña actual ingresada con la desencriptada
        if ($contrasenaActual !== $contrasenaAlmacenada) {
            return redirect()->back()->withErrors(['contrasena_actual' => 'La contraseña actual es incorrecta.']);
        }

        // Evaluar la fuerza de la nueva contraseña
        $passwordStrength = $this->evaluatePasswordStrength($nuevaContrasena);

        if ($passwordStrength == 'débil') {
            return redirect()->back()->withErrors(['nueva_contrasena' => 'La contraseña no cumple con los requisitos mínimos de seguridad. Intente nuevamente. (Puede agregar letras, números y simbolos)'])->withInput();
        }

        // Validar que la nueva contraseña y su confirmación coincidan
        if ($nuevaContrasena !== $confirmarContrasena) {
            return redirect()->back()->withErrors(['confirmar_contrasena' => 'La confirmación de la contraseña no coincide.']);
        }

        // Encriptar la nueva contraseña
        $contrasenaEncriptada = Crypt::encryptString($nuevaContrasena);

        // Actualizar la nueva contraseña en la base de datos y cambiar el estado a 'Activo'
        DB::table('pfp_schema.tbl_usuario')
            ->where('id_usuario', $user->id_usuario)
            ->update([
                'contrasena' => $contrasenaEncriptada, // Aquí se usa la contraseña encriptada
                'fecha_modificacion' => now(),   // Cambiar fecha de modificación
                'id_estado' => 1 // Assuming '1' is 'Activo'
            ]);

        // Redirigir a la vista de AdministrarPerfil con un mensaje de éxito y la evaluación de la contraseña
        return redirect('login')->with('success', 'Contraseña actualizada exitosamente. Su contraseña es ' . $passwordStrength . '.');
    }

    private function evaluatePasswordStrength($password)
    {
        $strength = 0;

        // Check length
        if (strlen($password) >= 12) {
            $strength += 1;
        } elseif (strlen($password) >= 8) {
            $strength += 0.5;
        }

        // Check for numbers
        if (preg_match('/[0-9]/', $password)) {
            $strength += 1;
        }

        // Check for uppercase letters
        if (preg_match('/[A-Z]/', $password)) {
            $strength += 1;
        }

        // Check for lowercase letters
        if (preg_match('/[a-z]/', $password)) {
            $strength += 1;
        }

        // Check for special characters
        if (preg_match('/[^a-zA-Z0-9]/', $password)) {
            $strength += 1;
        }

        // Evaluate strength
        if ($strength < 2) {
            return 'débil';
        } elseif ($strength >= 2 && $strength < 4) {
            return 'moderada';
        } else {
            return 'fuerte';
        }
    }

    // New method for real-time password strength evaluation via controller
    public function evaluatePasswordStrengthLive(Request $request)
    {
        $password = $request->input('password');
        $strength = $this->evaluatePasswordStrength($password);

        // Return the strength as JSON
        return response()->json([
            'strength' => $strength
        ]);
    }

    // New method to display the form with real-time feedback
    public function showFormWithLiveFeedback()
    {
        if (!auth()->check()) {
            return redirect()->route('login');
        }
        
        return view('modulo_usuarios.CambiarContrasena', [
            'passwordStrength' => 'No password entered yet'
        ]);
    }

    // New method to handle form submission with real-time feedback
    public function handleFormSubmission(Request $request)
    {
        $password = $request->input('nueva_contrasena');
        $passwordStrength = $this->evaluatePasswordStrength($password);

        // Return the view with the strength feedback
        return view('modulo_usuarios.CambiarContrasena', [
            'passwordStrength' => 'Strength: ' . $passwordStrength
        ]);
    }

    // New method to handle real-time updates as user types
    public function updatePasswordStrengthLive(Request $request)
    {
        $password = $request->input('password');
        $strength = $this->evaluatePasswordStrength($password);

        // Instead of redirecting or changing view, just return JSON for AJAX update
        return response()->json([
            'strength' => $strength
        ]);
    }
}