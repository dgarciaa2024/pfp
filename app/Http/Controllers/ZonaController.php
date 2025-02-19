<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;


class ZonaController extends Controller
{
   


    public function index()
    {
        $response = Http::get(env('API_URL', 'http://localhost:3002').'/get_zonas');
        $tabla_estado = Http::get(env('API_URL', 'http://localhost:3002').'/estados');
        $tabla_paises = Http::get(env('API_URL', 'http://localhost:3002').'/get_paises');
       
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
                ->where('id_objeto', 28) // ID del objeto que corresponde a "Zona"

                ->first();

           // Si se encuentran permisos para este rol y objeto, asignarlos
           if ($permisos) {
            $permiso_insercion = $permisos->permiso_creacion;
            $permiso_actualizacion = $permisos->permiso_actualizacion;
            $permiso_eliminacion = $permisos->permiso_eliminacion;
        }
    }


        return view('modulo_mantenimiento.Zona')->with([
        'tblpais'=> json_decode($tabla_paises,true),
        'tblestado'=> json_decode($tabla_estado,true),
        'Zonas' => json_decode($response, true),
        'permiso_insercion' => $permiso_insercion,
        'permiso_actualizacion' => $permiso_actualizacion,
        'permiso_eliminacion' => $permiso_eliminacion,
    ]);
    }


    public function store(Request $request)
    {
        $response = Http::post(env('API_URL', 'http://localhost:3002').'/insert_zona', [
            'id_pais' => $request->get('pais'),
             'zona' => $request->get('zona'),
             'id_estado' => $request->get('estdo')

        ]);
  
 return redirect('Zona');
       
    }


    
    public function update(Request $request)
    {
        $response = Http::put(env('API_URL', 'http://localhost:3002').'/update_zona', [
            'id_zona' => $request->get('cod'),
            'zona' => $request->get('zona'),
            'id_estado' => $request->get('estdo'),
            'id_pais' => $request->get('pais')
             
            
        ]);

        return redirect('Zona');

    }









}