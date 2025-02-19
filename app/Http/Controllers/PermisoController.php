<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\DB;


use Illuminate\Http\Request;

class PermisoController extends Controller
{
    

    public function index()
    {
        $response = Http::get(env('API_URL', 'http://localhost:3002').'/get_permisos');
        $tabla_estado = Http::get(env('API_URL', 'http://localhost:3002').'/estados');
        $tabla_objeto= Http::get(env('API_URL', 'http://localhost:3002').'/get_objetos');
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
            return view('modulo_usuarios.Permisos')->with([  
            'tblestado'=> json_decode($tabla_estado,true),
            'tblrol'=> json_decode($tabla_rol,true),
            'tblobjeto'=> json_decode($tabla_objeto,true),
            'permisos'=> json_decode($response,true),
            'permiso_insercion' => $permiso_insercion,
            'permiso_actualizacion' => $permiso_actualizacion,
            'permiso_eliminacion' => $permiso_eliminacion,
        ]);
    }




    public function store(Request $request)
    {
        $response = Http::post(env('API_URL', 'http://localhost:3002').'/insert_permiso', [
            'id_rol' => $request->get('rol'),
            'id_objeto' => $request->get('objeto'),
            'permiso_creacion' => $request->get('permiso_creacion'),
            'permiso_actualizacion' => $request->get('permiso_actualizacion'),
            'permiso_eliminacion' => $request->get('permiso_eliminacion'),
            'permiso_consultar' => $request->get('permiso_consultar'),
            'id_estado' => $request->get('estdo')

        ]);
        return redirect('Permisos');
    }

    public function update(Request $request)
    {
        $response = Http::put(env('API_URL', 'http://localhost:3002').'/update_permiso', [
            'id_permiso' => $request->get('cod'),
            'id_rol' => $request->get('rol'),
            'id_objeto' => $request->get('objeto'),
            'permiso_creacion' => $request->get('permiso_creacion'),
            'permiso_actualizacion' => $request->get('permiso_actualizacion'),
            'permiso_eliminacion' => $request->get('permiso_eliminacion'),
            'permiso_consultar' => $request->get('permiso_consultar'),
            'id_estado' => $request->get('estdo')

        ]);
        return redirect('Permisos');

    }

    public function destroy($id_permiso)
    {
        // Lógica para eliminar el objeto de la base de datos
        $response = Http::delete(env('API_URL', 'http://localhost:3002').'/delete_permiso', [
            'id_permiso' => $id_permiso
        ]);
    
        return redirect('Permisos');
    }
    
}