<?php

namespace App\Http\Controllers;

use Illuminate\Contracts\Encryption\DecryptException;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Crypt;
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
        $usuario = User::where('nombre_usuario', $request->nombre_usuario)->first();
        if (!$usuario) {
            return back()->withErrors([
                'login' => 'Usuario o contraseña incorrectos. Favor intente nuevamente.',
            ]);
        }
        $response = Http::post(env('API_URL', 'http://localhost:3002') . '/save_credential', [
            'usuario' => [
                'id' => $usuario->id_usuario,
                'nombreUsuario' => $usuario->nombre_usuario,
                'idRol' => $usuario->id_rol,
            ]
        ]);
        if ($usuario) {
            // Consultar el estado del usuario en la tabla pfp_schema.tbl_usuario
            $estadoUsuario = DB::table('pfp_schema.tbl_usuario')
                ->where('nombre_usuario', $request->nombre_usuario)
                ->first(); // Aquí obtenemos todo el registro para usar fecha_vencimiento
            $pwd = "";
            try {
                $pwd = Crypt::decryptString($estadoUsuario->contrasena);
            } catch (DecryptException $e) {
                $pwd = $estadoUsuario->contrasena;
            }
            if ($estadoUsuario && $estadoUsuario->id_estado == 4) { // Assuming 4 is 'Pendiente'
                // Asegurarse de que la contraseña ingresada coincida con la de la base de datos

                if ($request->contrasena === $pwd) {
                    Auth::login($usuario); // Log them in even if they are pending
                    session([
                        'usuario' => [
                            'id' => $usuario->id,
                            'nombre_usuario' => $usuario->nombre_usuario,
                            'id_rol' => $usuario->id_rol,
                            'estadoc' => 'PENDIENTE' // Optionally store the state
                        ]
                    ]);
                    return redirect()->route('cambiar-contrasena-new.index');
                } else {
                    return back()->withErrors([
                        'login' => 'Usuario o contraseña incorrectos. Favor intente nuevamente.',
                    ]);
                }
            }

            // Verificar el estado del usuario
            if ($estadoUsuario && $estadoUsuario->id_estado == 1) { // Supongamos que 1 es "ACTIVO"
                // Validar la fecha de vencimiento de la contraseña
                if ($estadoUsuario->fecha_vencimiento && $estadoUsuario->fecha_vencimiento <= now()) {
                    return back()->withErrors(['login' => 'Su usuario o contraseña ha expirado. Por favor, restablezca su contraseña o contacte al administrador.']);
                }

                // Añadir la verificación de la expiración de la contraseña
                if (!$this->checkPasswordExpiration($estadoUsuario)) {
                    return back()->withErrors(['login' => 'Su usuario o contraseña ha expirado. Por favor, restablezca su contraseña o contacte al administrador.']);
                }

                // Consultar el número de intentos válidos desde la tabla pfp_schema.tbl_parametro
                $maxIntentos = DB::table('pfp_schema.tbl_parametro')
                    ->where('parametro', 'Num_Int_validos')
                    ->value('valor');

                // Consultar intentos fallidos actuales (implementando una lógica alternativa)
                $intentosKey = 'intentos_fallidos_' . $request->nombre_usuario; // Clave de sesión por usuario
                $intentosFallidos = session($intentosKey, 0); // Si no existe, será 0
                // Verificar si la contraseña es correcta (sin encriptación)
                if ($request->contrasena === $pwd) {
                    // Restablecer los intentos fallidos
                    session([$intentosKey => 0]);

                    // Iniciar sesión en el sistema
                    Auth::login($usuario);

                    // Guardar datos relevantes del usuario en la sesión
                    session([
                        'usuario' => [
                            'id' => $usuario->id,
                            'nombre_usuario' => $usuario->nombre_usuario,
                            'id_rol' => $usuario->id_rol,
                        ]
                    ]);

                    // Guardar fecha de vencimiento en la base de datos
                    $duracionContrasena = DB::table('pfp_schema.tbl_parametro')
                        ->where('id_parametro', 2)
                        ->value('valor');
                    $duracionContrasena = $duracionContrasena ? (int) $duracionContrasena : 0;
                    DB::table('pfp_schema.tbl_usuario')
                        ->where('id_usuario', $usuario->id)
                        ->update([
                            'fecha_vencimiento' => now()->addMinutes($duracionContrasena)
                        ]);

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
            } elseif ($estadoUsuario && $estadoUsuario->id_estado == 3) { // Supongamos que 3 es "BLOQUEADO"
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
        $response = Http::get(env('API_URL', 'http://localhost:3002') . '/get_usuarios');
        $usuarios = json_decode($response->body(), true);

        // Recibir los datos del formulario
        $email = $request->input('correo');
        $contrasena = $request->input('contra');

        // Buscar el usuario autenticado
        $usuarioAutenticado = collect($usuarios)->first(function ($usuario) use ($email, $contrasena) {
            return $usuario['email'] == $email && $usuario['contrasena'] == $contrasena && $usuario['estado'] === 'ACTIVO';
        });

        if ($usuarioAutenticado) {
            // Añadir verificación de expiración de contraseña si es posible desde la API
            // Suponiendo que 'fecha_vencimiento' está en los datos del usuario
            if (isset($usuarioAutenticado['fecha_vencimiento']) && strtotime($usuarioAutenticado['fecha_vencimiento']) < time()) {
                return view('layouts.Login')->with('mensaje', 'Su contraseña ha expirado. Por favor, restablezca su contraseña.');
            }

            // Guardar datos relevantes del usuario en la sesión
            session([
                'usuario' => [
                    'id_usuario' => $usuarioAutenticado['id_usuario'],
                    'nombre_usuario' => $usuarioAutenticado['nombre_usuario'],
                    'email' => $usuarioAutenticado['email'],
                    'id_rol' => $usuarioAutenticado['id_rol'],
                ]
            ]);

            // Iniciar sesión en el sistema
            Auth::loginUsingId($usuarioAutenticado['id_usuario']); // Añadido para autenticación

            // Actualizar fecha de vencimiento si es necesario
            $duracionContrasena = DB::table('pfp_schema.tbl_parametro')
                ->where('id_parametro', 2)
                ->value('valor');
            $duracionContrasena = $duracionContrasena ? (int) $duracionContrasena : 0;
            DB::table('pfp_schema.tbl_usuario')
                ->where('id_usuario', $usuarioAutenticado['id_usuario'])
                ->update([
                    'fecha_vencimiento' => now()->addMinutes($duracionContrasena)
                ]);

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

    // Nuevo método para verificar si la contraseña ha expirado (reutilizando el método de UsuarioController)
    private function checkPasswordExpiration($user)
    {
        if ($user->fecha_vencimiento && $user->fecha_vencimiento < now()) {
            DB::table('pfp_schema.tbl_usuario')->where('id_usuario', $user->id_usuario)->update([
                'id_estado' => 5 // Supongamos que 5 es el ID para el estado 'Bloqueado'
            ]);
            return false;
        }
        return true;
    }
}