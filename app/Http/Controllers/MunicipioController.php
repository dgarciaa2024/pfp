<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;


class MunicipioController extends Controller
{
    

    public function index()
    {
        $response = Http::get(env('API_URL', 'http://localhost:3002').'/get_municipios');
        $tabla_depto = Http::get(env('API_URL', 'http://localhost:3002').'/get_departamentos'); 
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

      // Consultar permisos en la base de datos para el rol y objeto 5 (Municipio)
      $permisos = DB::table('pfp_schema.tbl_permiso')
          ->where('id_rol', $idRolUsuario)
          ->where('id_objeto', 30) // ID del objeto que corresponde a "Municipio"
          ->first();

      if ($permisos) {
          $permiso_insercion = $permisos->permiso_creacion ?? 2;
          $permiso_edicion = $permisos->permiso_edicion ?? 2;
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


        return view('modulo_mantenimiento.Municipio')->with([
        'tblestado'=> json_decode($tabla_estado,true),
        'tbldepto'=> json_decode($tabla_depto,true),
        'Municipios'=> json_decode($response,true),
        'permiso_insercion' => $permiso_insercion,
        'permiso_actualizacion' => $permiso_actualizacion,
    ]);
    }

}
    public function store(Request $request)
    {
        $response = Http::post(env('API_URL', 'http://localhost:3002').'/insert_municipio', [
            'id_departamento' => $request->get('depto'),
             'municipio' => $request->get('municipio'),
             'id_estado' => $request->get('estdo')

        ]);
  
 
 if ($response->successful()) {
    return redirect('Municipio')->with('success', true);
} else {
    return redirect()->back()->with('error', 'Error al realizar la operación.');
}   
    }
       
    


    
    public function update(Request $request)
    {
        $response = Http::put(env('API_URL', 'http://localhost:3002').'/update_municipio', [
       'id_departamento' => $request->get('depto'),
            'id_municipio' => $request->get('cod'),
             'municipio' => $request->get('municipio'),
             'id_estado' => $request->get('estdo'),
            
        ]);

        if ($response->successful()) {
            return redirect('Municipio')->with('success', true);
        } else {
            return redirect()->back()->with('error', 'Error al realizar la operación.');
        }   
            }
    





}