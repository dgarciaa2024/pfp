<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;

class ParametroController extends Controller
{
    public function index()
    {
        $response = Http::get(env('API_URL', 'http://localhost:3002') . '/get_parametros');
        $tabla_usuario = Http::get(env('API_URL', 'http://localhost:3002') . '/get_usuarios');

        // Obtener el ID del usuario ADMINISTRADOR
        $adminUser = DB::table('pfp_schema.tbl_usuario')
            ->where('nombre_usuario', 'ADMINISTRADOR')
            ->first();

        if (!$adminUser) {
            return redirect()->back()->with('error', 'No se encontró el usuario ADMINISTRADOR.');
        }

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
                ->where('id_objeto', 3) // ID del objeto "parametro"
                ->first();

            if ($permisos) {
                $permiso_insercion = $permisos->permiso_creacion;
                $permiso_actualizacion = $permisos->permiso_actualizacion;
                $permiso_eliminacion = $permisos->permiso_eliminacion;
            }
        }

        return view('modulo_usuarios.Parametros')->with([
            'tblusuario' => json_decode($tabla_usuario, true),
            'Parametros' => json_decode($response, true),
            'permiso_insercion' => $permiso_insercion,
            'permiso_actualizacion' => $permiso_actualizacion,
            'permiso_eliminacion' => $permiso_eliminacion,
            'adminUser' => $adminUser, // Pasar el usuario ADMINISTRADOR a la vista
        ]);
    }

    public function store(Request $request)
    {
        // Obtener el ID del usuario ADMINISTRADOR
        $adminUser = DB::table('pfp_schema.tbl_usuario')
            ->where('nombre_usuario', 'ADMINISTRADOR')
            ->first();

        if (!$adminUser) {
            return redirect()->back()->with('error', 'No se encontró el usuario ADMINISTRADOR.');
        }

        $response = Http::post(env('API_URL', 'http://localhost:3002') . '/insert_parametro', [
            'parametro' => $request->get('par'),
            'valor' => $request->get('val'),
            'id_usuario' => $adminUser->id_usuario // Siempre usar el ID del ADMINISTRADOR
        ]);

        if ($response->successful()) {
            return redirect('Parametros')->with('success', true);
        } else {
            return redirect()->back()->with('error', 'Error al realizar la operación.');
        }
    }

    public function update(Request $request)
    {
        // Obtener el ID del usuario ADMINISTRADOR
        $adminUser = DB::table('pfp_schema.tbl_usuario')
            ->where('nombre_usuario', 'ADMINISTRADOR')
            ->first();

        if (!$adminUser) {
            return redirect()->back()->with('error', 'No se encontró el usuario ADMINISTRADOR.');
        }

        $response = Http::put(env('API_URL', 'http://localhost:3002') . '/update_parametro', [
            'id_parametro' => $request->get('cod'),
            'parametro' => $request->get('par'),
            'valor' => $request->get('val'),
            'id_usuario' => $adminUser->id_usuario // Siempre usar el ID del ADMINISTRADOR
        ]);

        if ($response->successful()) {
            return redirect('Parametros')->with('success', true);
        } else {
            return redirect()->back()->with('error', 'Error al realizar la operación.');
        }
    }

    public function destroy($id_parametro)
    {
        // Lógica para eliminar el objeto de la base de datos
        $response = Http::delete(env('API_URL', 'http://localhost:3002') . '/delete_parametro', [
            'id_parametro' => $id_parametro
        ]);

        return redirect('Parametros');
    }
}