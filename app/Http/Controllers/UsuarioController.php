<?php

namespace App\Http\Controllers;

use Illuminate\Contracts\Encryption\DecryptException;
use Illuminate\Support\Facades\Http;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Mail\ResetPasswordMail; // Add this line
use App\Mail\ResetPasswordNewMail; // Add this line
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Crypt;

class UsuarioController extends Controller
{
    public function index()
    {
        $response = Http::get(env('API_URL', 'http://localhost:3002').'/get_usuarios');
        $tabla_estado = Http::get(env('API_URL', 'http://localhost:3002').'/estados');
        $tabla_rol = Http::get(env('API_URL', 'http://localhost:3002').'/get_roles');

        // Manejo de sesión y permisos
        $usuario = session('usuario'); // Obtener usuario desde la sesión

        // Permisos predeterminados
        $permiso_insercion = 2;
        $permiso_actualizacion = 2;
        $permiso_eliminacion = 2;

        if ($usuario) {
            $idRolUsuario = $usuario['id_rol']; // Obtener el rol del usuario desde la sesión

            // Consultar permisos en la base de datos para el rol y objeto 1 (usuarios)
            $permisos = DB::table('pfp_schema.tbl_permiso')
                ->where('id_rol', $idRolUsuario)
                ->where('id_objeto', 11) // ID del objeto que corresponde a "usuarios"
                ->first();

            // Si se encuentran permisos para este rol y objeto, asignarlos
            if ($permisos) {
                $permiso_insercion = $permisos->permiso_creacion;
                $permiso_actualizacion = $permisos->permiso_actualizacion;
                $permiso_eliminacion = $permisos->permiso_eliminacion;
            }
        }

        // Para depuración: Verificar valores antes de retornar la vista
        // Descomenta esto si quieres depurar.
        // dd(session('usuario'), $permiso_insercion, $permiso_actualizacion, $permiso_eliminacion);

        // Retornar vista con datos y permisos
        $response_mapped = array_map(function ($item) {
            try {
                $item['contrasena'] = Crypt::decryptString($item['contrasena']);
                return $item;
            } catch (DecryptException $e) {
                return $item;
            }
        }, json_decode($response, true));
        return view('modulo_usuarios.Usuarios')->with([
            'tblrol' => json_decode($tabla_rol, true),
            'tblestado' => json_decode($tabla_estado, true),
            'Usuarios' => $response_mapped,
            'permiso_insercion' => $permiso_insercion,
            'permiso_actualizacion' => $permiso_actualizacion,
            'permiso_eliminacion' => $permiso_eliminacion,
        ]);
    }

    public function store(Request $request)
    {
        $newPassword = Str::random(10); // Generate a random password
        $estadoPendiente = 2; // Assuming '2' is the ID for 'Pendiente'
        $duracionContrasena = DB::table('pfp_schema.tbl_parametro')
            ->where('id_parametro', 2)
            ->value('valor');
        $duracionContrasena = $duracionContrasena ? (int) $duracionContrasena : 0;

        $response = Http::post(env('API_URL', 'http://localhost:3002').'/insert_usuario', [
            'usuario' => $request->get('usu'),
            'nombre_usuario' => $request->get('nom_usu'),
            'contrasena' => Crypt::encryptString($newPassword),
            'id_rol' => $request->get('rol'),
            'email' => $request->get('correo'),
            'primer_ingreso' => 1,
            'id_estado' => 4,
            'fecha_vencimiento' => now()->addMinutes($duracionContrasena)
        ]);

        // Send email with temporary password
        Mail::to($request->get('correo'))->send(new ResetPasswordNewMail($newPassword));

        return redirect('Usuarios');
    }

    public function update(Request $request)
    {
        $response = Http::put(env('API_URL', 'http://localhost:3002').'/update_usuario', [
            'id_usuario' => $request->get('cod'),
            'usuario' => $request->get('usu'),
            'nombre_usuario' => $request->get('nom_usu'),
            'contrasena' => Crypt::encryptString($request->get('contra')),
            'id_rol' => $request->get('rol'),
            'email' => $request->get('correo'),
            'primer_ingreso' => $request->get('ingreso'),
            'id_estado' => $request->get('estdo')
        ]);

        return redirect('Usuarios');
    }

    // Nuevo método para verificar si la contraseña ha expirado
    public function checkPasswordExpiration($user)
    {
        if ($user->fecha_vencimiento && $user->fecha_vencimiento < now()) {
            // La contraseña ha expirado, proceder con acciones necesarias
            // Aquí puedes, por ejemplo, cambiar el estado del usuario o notificar
            DB::table('pfp_schema.tbl_usuario')->where('id_usuario', $user->id_usuario)->update([
                'id_estado' => 5 // Supongamos que 5 es el ID para el estado 'Bloqueado'
            ]);
            // Notificación o redirección al usuario
            return false;
        }
        return true;
    }
}