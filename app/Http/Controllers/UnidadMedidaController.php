<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;

class UnidadMedidaController extends Controller
{
   

 

    public function index()
    {
        $response = Http::get(env('API_URL', 'http://localhost:3002').'/get_unidad_medida');
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
               ->where('id_objeto', 22) // ID del objeto que corresponde a "unidad de medida"
               ->first();
// Si se encuentran permisos para este rol y objeto, asignarlos
if ($permisos) {
   $permiso_insercion = $permisos->permiso_creacion;
   $permiso_actualizacion = $permisos->permiso_actualizacion;
   $permiso_eliminacion = $permisos->permiso_eliminacion;
}
}

        return view('modulo_mantenimiento.UnidadMedida')->with([
        'tblestado'=> json_decode($tabla_estado,true),
        'UMedida'=> json_decode($response,true),
        'permiso_insercion' => $permiso_insercion,
        'permiso_actualizacion' => $permiso_actualizacion,
        'permiso_eliminacion' => $permiso_eliminacion,
    ]);
    }


    public function store(Request $request)
    {
        $response = Http::post(env('API_URL', 'http://localhost:3002').'/insert_unidad_medida', [
            'unidad_medida' => $request->get('unidad'),
             'id_estado' => $request->get('estdo')
          

        ]);
  
 return redirect('UnidadMedida');
       
    }


    
    public function update(Request $request)
    {
        $response = Http::put(env('API_URL', 'http://localhost:3002').'/update_unidad_medida', [
            'id_unidad_medida' => $request->get('cod'),
            'unidad_medida' => $request->get('unidad'),
            'id_estado' => $request->get('estdo'),
            
        ]);

        return redirect('UnidadMedida');

    }

   
}