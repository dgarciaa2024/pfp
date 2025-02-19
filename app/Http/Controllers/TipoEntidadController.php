<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;

class TipoEntidadController extends Controller
{
   

    public function index()
    {
        $response = Http::get(env('API_URL', 'http://localhost:3002').'/get_tipo_entidad');
        $tabla_estado = Http::get(env('API_URL', 'http://localhost:3002').'/estados');

       
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
                ->where('id_objeto', 25) // ID del objeto que corresponde a "TipoEntidad"
                ->first();
// Si se encuentran permisos para este rol y objeto, asignarlos
if ($permisos) {
    $permiso_insercion = $permisos->permiso_creacion;
    $permiso_actualizacion = $permisos->permiso_actualizacion;
    $permiso_eliminacion = $permisos->permiso_eliminacion;
}
}


return view('modulo_mantenimiento.TipoEntidad')->with([
    'Tipentidad' => json_decode($response, true),
    'tblestado' => json_decode($tabla_estado, true),
    'permiso_insercion' => $permiso_insercion,
    'permiso_actualizacion' => $permiso_actualizacion,
    'permiso_eliminacion' => $permiso_eliminacion,
]);
}
public function store(Request $request)
{
  
        $response = Http::post(env('API_URL', 'http://localhost:3002').'/insert_tipo_entidad', [
            'tipo_entidad' => $request->get('tipo'),
            'id_estado' => $request->get('estdo')
        ]);

        
        return redirect('TipoEntidad');
}

public function update(Request $request)
{
   
        $response = Http::put(env('API_URL', 'http://localhost:3002').'/update_tipo_entidad', [
            'id_tipo_entidad' => $request->get('cod'),
            'tipo_entidad' => $request->get('tipo'),
            'id_estado' => $request->get('estdo'),
        

        ]);
        return redirect('TipoEntidad');
    }}

