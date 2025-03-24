<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Crypt;

class CambiarContrasenaNewController extends Controller
{
    public function index()
    {
        if (!auth()->check()) {
            return redirect()->route('login');
        }
        return view('modulo_usuarios.CambiarContrasenaNew');
    }

    public function store(Request $request)
    {
        if (!auth()->check()) {
            return redirect()->route('login')->with('error', 'Debe iniciar sesión para cambiar su contraseña.');
        }

        $usuario = strtoupper(auth()->user()->usuario);
        $nuevaContrasena = $request->input('nueva_contrasena');
        $confirmarContrasena = $request->input('confirmar_contrasena');

        $request->validate([
            'nueva_contrasena' => 'required|min:8|max:20',
            'confirmar_contrasena' => 'required|same:nueva_contrasena',
        ]);

        $user = DB::table('pfp_schema.tbl_usuario')
                    ->where('usuario', $usuario)
                    ->first();

        $passwordStrength = $this->evaluatePasswordStrength($nuevaContrasena);

        if ($passwordStrength == 'débil') {
            return redirect()->back()->withErrors(['nueva_contrasena' => 'La contraseña no cumple con los requisitos mínimos de seguridad. Intente nuevamente. (Puede agregar letras, números y simbolos)'])->withInput();
        }

        if ($nuevaContrasena !== $confirmarContrasena) {
            return redirect()->back()->withErrors(['confirmar_contrasena' => 'La confirmación de la contraseña no coincide.']);
        }

        if ($nuevaContrasena === $user->contrasena) {
            return redirect()->back()->withErrors(['nueva_contrasena' => 'No puede utilizar una contraseña utilizada anteriormente.'])->withInput();
        }

        // Obtener el valor del parámetro con id_parametro=12
        $parametro = DB::table('pfp_schema.tbl_parametro')
                        ->where('id_parametro', 12)
                        ->first();

        if (!$parametro) {
            return redirect()->back()->withErrors(['error' => 'No se pudo obtener el parámetro de vencimiento de contraseña.'])->withInput();
        }

        $aniosVencimiento = (int)$parametro->valor;

        // Calcular la nueva fecha de vencimiento
        $fechaVencimiento = now()->addYears($aniosVencimiento);

        // Encriptar la nueva contraseña
        $contrasenaEncriptada = Crypt::encryptString($nuevaContrasena);

        // Actualizar la nueva contraseña, la fecha de modificación, el estado y la fecha de vencimiento
        DB::table('pfp_schema.tbl_usuario')
            ->where('id_usuario', $user->id_usuario)
            ->update([
                'contrasena' => $contrasenaEncriptada,
                'fecha_modificacion' => now(),
                'id_estado' => 1, // Assuming '1' is 'ACTIVO'
                'fecha_vencimiento' => $fechaVencimiento
            ]);

        return redirect('login')->with('success', 'Contraseña actualizada exitosamente. Su contraseña es ' . $passwordStrength . '.');
    }

    private function evaluatePasswordStrength($password)
    {
        $strength = 0;

        if (strlen($password) >= 12) {
            $strength += 1;
        } elseif (strlen($password) >= 8) {
            $strength += 0.5;
        }

        if (preg_match('/[0-9]/', $password)) {
            $strength += 1;
        }

        if (preg_match('/[A-Z]/', $password)) {
            $strength += 1;
        }

        if (preg_match('/[a-z]/', $password)) {
            $strength += 1;
        }

        if (preg_match('/[^a-zA-Z0-9]/', $password)) {
            $strength += 1;
        }

        if ($strength < 2) {
            return 'débil';
        } elseif ($strength >= 2 && $strength < 4) {
            return 'moderada';
        } else {
            return 'fuerte';
        }
    }

    public function evaluatePasswordStrengthLive(Request $request)
    {
        $password = $request->input('password');
        $strength = $this->evaluatePasswordStrength($password);

        return response()->json([
            'strength' => $strength
        ]);
    }

    public function showFormWithLiveFeedback()
    {
        if (!auth()->check()) {
            return redirect()->route('login');
        }
        
        return view('modulo_usuarios.CambiarContrasenaNew', [
            'passwordStrength' => 'No password entered yet'
        ]);
    }

    public function handleFormSubmission(Request $request)
    {
        $password = $request->input('nueva_contrasena');
        $passwordStrength = $this->evaluatePasswordStrength($password);

        return view('modulo_usuarios.CambiarContrasenaNew', [
            'passwordStrength' => 'Strength: ' . $passwordStrength
        ]);
    }

    public function updatePasswordStrengthLive(Request $request)
    {
        $password = $request->input('password');
        $strength = $this->evaluatePasswordStrength($password);

        return response()->json([
            'strength' => $strength
        ]);
    }
}