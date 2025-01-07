<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Http;
use Illuminate\Http\Request;
use App\Http\Requests\LoginRequest;
use App\Models\User;
use Illuminate\Support\Facades\DB;

class LoginController extends Controller
{
    // Mostrar el formulario de login
    public function showLoginForm()
    {
        return view('layouts.Login');
    }

    // Manejar el proceso de login interno
    public function login(LoginRequest $request)
    {
        // Buscar al usuario por nombre de usuario
        $usuario = User::where('nombre_usuario', $request->nombre_usuario)->first();

        if ($usuario) {
            // Consultar el estado del usuario en la tabla pfp_schema.tbl_usuario
            $estadoUsuario = DB::table('pfp_schema.tbl_usuario')
                ->where('nombre_usuario', $request->nombre_usuario)
                ->value('id_estado');

            // Verificar el estado del usuario
            if ($estadoUsuario == 1) { // Supongamos que 1 es "ACTIVO"
                // Consultar el número de intentos válidos desde la tabla pfp_schema.tbl_parametro
                $maxIntentos = DB::table('pfp_schema.tbl_parametro')
                    ->where('parametro', 'Num_Int_validos')
                    ->value('valor');

                // Consultar intentos fallidos actuales (implementando una lógica alternativa)
                $intentosKey = 'intentos_fallidos_' . $request->nombre_usuario; // Clave de sesión por usuario
                $intentosFallidos = session($intentosKey, 0); // Si no existe, será 0

                // Verificar si la contraseña es correcta (sin encriptación)
                if ($request->contrasena === $usuario->contrasena) {
                    // Restablecer los intentos fallidos
                    session([$intentosKey => 0]);

                    // Iniciar sesión en el sistema
                    Auth::login($usuario);

                    // Guardar datos relevantes del usuario en la sesión
                    session(['usuario' => [
                        'id' => $usuario->id,
                        'nombre_usuario' => $usuario->nombre_usuario,
                        'id_rol' => $usuario->id_rol,
                    ]]);

                    return redirect()->intended('/inicio');
                } else {
                    // Incrementar los intentos fallidos en la sesión
                    $intentosFallidos++;
                    session([$intentosKey => $intentosFallidos]);

                    // Revisar si se excedió el límite de intentos válidos
                    if ($intentosFallidos >= $maxIntentos) {
                        // Cambiar el estado del usuario a "bloqueado" (3)
                        DB::table('pfp_schema.tbl_usuario')
                            ->where('nombre_usuario', $request->nombre_usuario)
                            ->update(['id_estado' => 3]);

                        return back()->withErrors([
                            'login' => 'Ha superado el número máximo de intentos. El usuario ha sido bloqueado.',
                        ]);
                    }

                    return back()->withErrors([
                        'login' => 'Usuario o contraseña incorrectos. Favor intente nuevamente.',
                    ]);
                }
            } elseif ($estadoUsuario == 2) { // Supongamos que 2 es "INACTIVO"
                return back()->withErrors([
                    'login' => 'El usuario se encuentra inactivo. Comuníquese con el administrador.',
                ]);
            } elseif ($estadoUsuario == 3) { // Supongamos que 3 es "BLOQUEADO"
                return back()->withErrors([
                    'login' => 'El usuario se encuentra bloqueado. Comuníquese con el administrador.',
                ]);
            } else {
                return back()->withErrors([
                    'login' => 'Estado del usuario no válido. Comuníquese con el administrador.',
                ]);
            }
        } else {
            // Fallo en la autenticación
            return back()->withErrors([
                'login' => 'Usuario o contraseña incorrectos. Favor intente nuevamente.',
            ]);
        }
    }

    // Manejar el proceso de login con verificación mediante API externa
    public function verificar_Login(Request $request)
    {
        // Obtener los usuarios desde el endpoint
        $response = Http::get('http://localhost:3000/get_usuarios');
        $usuarios = json_decode($response->body(), true);

        // Recibir los datos del formulario
        $email = $request->input('correo');
        $contrasena = $request->input('contra');

        // Buscar el usuario autenticado
        $usuarioAutenticado = collect($usuarios)->first(function ($usuario) use ($email, $contrasena) {
            return $usuario['email'] == $email && $usuario['contrasena'] == $contrasena && $usuario['estado'] === 'ACTIVO';
        });

        if ($usuarioAutenticado) {
            // Guardar datos relevantes del usuario en la sesión
            session(['usuario' => [
                'id_usuario' => $usuarioAutenticado['id_usuario'],
                'nombre_usuario' => $usuarioAutenticado['nombre_usuario'],
                'email' => $usuarioAutenticado['email'],
                'id_rol' => $usuarioAutenticado['id_rol'],
            ]]);

            return redirect('inicio');
        } else {
            // Mostrar mensaje de error
            $mensaje = $usuarioAutenticado && $usuarioAutenticado['estado'] !== 'ACTIVO'
                ? 'Su cuenta está inactiva, comuníquese con el administrador'
                : 'Acceso incorrecto, intente nuevamente';

            return view('layouts.Login')->with('mensaje', $mensaje);
        }
    }

    // Logout
    public function logout(Request $request)
    {
        // Cerrar la sesión de autenticación
        Auth::logout();

        // Limpiar la sesión para eliminar cualquier dato adicional
        $request->session()->invalidate();
        $request->session()->regenerateToken();

        // Redirigir a la página de login
        return redirect()->route('login');
    }
}
