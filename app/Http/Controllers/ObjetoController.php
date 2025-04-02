<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;


use Illuminate\Http\Request;

class ObjetoController extends Controller
{
   
    public function index()
    {
        $response = Http::get(env('API_URL', 'http://localhost:3002').'/get_objetos');
        $tabla_estado = Http::get(env('API_URL', 'http://localhost:3002').'/estados');

         // Manejo de sesión y permisos
         $usuario = session('usuario'); // Obtener usuario desde la sesión

         // Permisos predeterminados
         $permiso_insercion = 2;
         $permiso_actualizacion = 2;
         $permiso_eliminacion = 2;
         $permiso_consultar = 0; // Permiso de consulta predeterminado en 0

         if ($usuario) {
             $idRolUsuario = $usuario['id_rol']; // Obtener el rol del usuario desde la sesión
 
             // Consultar permisos en la base de datos para el rol y objeto 5 (objeto)
             $permisos = DB::table('pfp_schema.tbl_permiso')
                 ->where('id_rol', $idRolUsuario)
                 ->where('id_objeto', 5) // ID del objeto "objeto"
                 ->first();
 
              // Si se encuentran permisos para este rol y objeto, asignarlos
            if ($permisos) {
                $permiso_insercion = $permisos->permiso_creacion;
                $permiso_actualizacion = $permisos->permiso_actualizacion;
                $permiso_eliminacion = $permisos->permiso_eliminacion;
                $permiso_consultar = $permisos->permiso_consultar ?? 0; // Asignar 0 si es nulo
            }

            // Verificar si el usuario tiene permiso de consulta
            if ($permiso_consultar != 1) {
                return view('errors.403');
            }
        } else {
            // Si no hay usuario en sesión, redirigir a la vista de sin permiso
            return view('errors.403');
        }

        return view('modulo_usuarios.Objeto')->with([  
            'tblestado'=> json_decode($tabla_estado,true),
            'Objetos'=> json_decode($response,true),
           'Usuarios' => json_decode($response, true),
            'permiso_insercion' => $permiso_insercion,
            'permiso_actualizacion' => $permiso_actualizacion,
            'permiso_eliminacion' => $permiso_eliminacion,
        ]);
    }




    public function store(Request $request)
    {

         
        $response = Http::post(env('API_URL', 'http://localhost:3002').'/insert_objeto', [
            'nombre' => $request->get('nom'),
            'descripcion' => $request->get('des'),
            'id_estado' => $request->get('estdo')

        ]);
        if ($response->successful()) {
            return redirect('Objetos')->with('success', true);
        } else {
            return redirect()->back()->with('error', 'Error al realizar la operación.');
        }
    }

    public function update(Request $request)
    {
         
        $response = Http::put(env('API_URL', 'http://localhost:3002').'/update_objeto', [
            'id_objeto' => $request->get('cod'),
            'nombre' => $request->get('nom'),
            'descripcion' => $request->get('des'),
            'id_estado' => $request->get('estdo')
            
        ]); 
        if ($response->successful()) {
            return redirect('Objetos')->with('success', true);
        } else {
            return redirect()->back()->with('error', 'Error al realizar la operación.');
        }
    }

    public function destroy($id_objeto)
    {
        // Lógica para eliminar el objeto de la base de datos
        $response = Http::delete(env('API_URL', 'http://localhost:3002').'/delete_objeto', [
            'id_objeto' => $id_objeto
        ]);
    
        return redirect('Objetos');
    }
}