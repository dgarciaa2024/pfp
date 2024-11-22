<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Http;
use Illuminate\Http\Request;
use App\Http\Requests\LoginRequest;
use App\Models\User;

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

        // Verificar si el usuario existe y la contraseña es correcta (sin encriptación)
        if ($usuario && $request->contrasena === $usuario->contrasena) {
            Auth::login($usuario);
            return redirect()->intended('/inicio');
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

        // Guardar los usuarios en la sesión
        session()->put('pfp_schema.tbl_usuario', $usuarios);

        // Recibir los datos del formulario
        $email = $request->input('correo');
        $contrasena = $request->input('contra');

        // Variable para verificar si se encontró el usuario activo
        $usuarioAutenticado = collect($usuarios)->first(function ($usuario) use ($email, $contrasena) {
            return $usuario['email'] == $email && $usuario['contrasena'] == $contrasena && $usuario['estado'] === 'ACTIVO';
        });

        // Redirigir o mostrar mensajes de error según el estado del usuario
        if ($usuarioAutenticado) {
            // Guardar el usuario autenticado en la sesión
            session()->put('usuario_autenticado', $usuarioAutenticado);
            return redirect('inicio');
        } else {
            // Mensaje de cuenta inactiva o acceso incorrecto
            $mensaje = isset($usuario) && $usuario['estado'] !== 'ACTIVO'
                ? 'Su cuenta está inactiva, comuníquese con el administrador'
                : 'Acceso incorrecto, intente nuevamente';

            return view('layouts.Login')->with('mensaje', $mensaje);
        }
    }





//LOGOUT
public function logout(Request $request)
{
    // Cerrar la sesión de autenticación
    Auth::logout();
    
    // Limpiar la sesión para eliminar cualquier dato adicional
    $request->session()->invalidate();
    $request->session()->regenerateToken();

    // Redirigir a la página de login
    return redirect()->route('login');
}}