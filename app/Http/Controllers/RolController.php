<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Http;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class RolController extends Controller
{
    public function index()
    {
        // Consultar datos desde la API
        $response = Http::get('http://localhost:3000/get_roles');
        $tabla_estado = Http::get('http://localhost:3000/estados');

        // Manejo de sesión y permisos
        $usuario = session('usuario'); // Obtener usuario desde la sesión

        // Permisos predeterminados
        $permiso_insercion = 2;
        $permiso_actualizacion = 2;
        $permiso_eliminacion = 2;

        if ($usuario) {
            $idRolUsuario = $usuario['id_rol']; // Obtener el rol del usuario desde la sesión

            // Consultar permisos en la base de datos para el rol y objeto 2 (roles)
            $permisos = DB::table('pfp_schema.tbl_permiso')
                ->where('id_rol', $idRolUsuario)
                ->where('id_objeto', 2) // ID del objeto que corresponde a "roles"
                ->first(); //para halar los parametros

            // Si se encuentran permisos para este rol y objeto, asignarlos
            if ($permisos) {
                $permiso_insercion = $permisos->permiso_creacion;
                $permiso_actualizacion = $permisos->permiso_actualizacion;
                $permiso_eliminacion = $permisos->permiso_eliminacion;
            }
        }

        // Retornar vista con datos y permisos
        return view('modulo_usuarios.Roles')->with([
            'tblestado' => json_decode($tabla_estado, true),
            'Roles' => json_decode($response, true),
            'permiso_insercion' => $permiso_insercion,
            'permiso_actualizacion' => $permiso_actualizacion,
            'permiso_eliminacion' => $permiso_eliminacion,
        ]);
    }

    public function store(Request $request)
    {
        $response = Http::post('http://localhost:3000/insert_rol', [
            'rol' => $request->get('rol'),
            'descripcion' => $request->get('descripcion'),
            'id_estado' => $request->get('estdo'),
        ]);

        return redirect('Roles');
    }

    public function update(Request $request)
    {
        $response = Http::put('http://localhost:3000/update_rol', [
            'id_rol' => $request->get('cod'),
            'rol' => $request->get('rol'),
            'descripcion' => $request->get('descripcion'),
            'id_estado' => $request->get('estdo'),
        ]);

        return redirect('Roles');
    }
}
