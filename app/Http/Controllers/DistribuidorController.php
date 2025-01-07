<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\DB;

use Illuminate\Http\Request;

class DistribuidorController extends Controller
{
    
 

    public function index()
    {
        
       
    
     // Consultar datos desde la API
     $response = Http::get('http://localhost:3000/get_distribuidores');
     $tabla_pais = Http::get('http://localhost:3000/get_paises');
     $tabla_usuario= Http::get('http://localhost:3000/get_usuarios');
     $tabla_entidad = Http::get('http://localhost:3000/get_tipo_entidad');
     $tabla_estado = Http::get('http://localhost:3000/estados');
     $tabla_contacto = Http::get('http://localhost:3000/get_contactos');

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
             ->where('id_objeto', 32) // ID del objeto "DISTRIBUIDOR"
             ->first();

         if ($permisos) {
            $permiso_insercion = $permisos->permiso_creacion;
                $permiso_actualizacion = $permisos->permiso_actualizacion;
                $permiso_eliminacion = $permisos->permiso_eliminacion;
         }
     }

     return view('modulo_operaciones.Distribuidor')->with([//vistaddddddddd
       
        'tblcontacto'=> json_decode($tabla_contacto,true),
        'tblestado'=> json_decode($tabla_estado,true),
        'tblentidad'=> json_decode($tabla_entidad,true),
        'tblusuario'=> json_decode($tabla_usuario,true),
        'tblpais'=> json_decode($tabla_pais,true),
        'Distribuidores'=> json_decode($response,true),
        'permiso_insercion' => $permiso_insercion,
        'permiso_actualizacion' => $permiso_actualizacion,
        'permiso_eliminacion' => $permiso_eliminacion,

    ]);
 }
    //

    
    public function store(Request $request)
    {
        $response = Http::post('http://localhost:3000/insert_distribuidor', [
            'rtn_distribuidor' => $request->get('rtn'),
            'nombre_distribuidor' => $request->get('nombre'),
            'id_pais' => $request->get('pais'),
            'id_tipo_entidad' => $request->get('entidad'),
            'id_usuario' => $request->get('usuario'),
            'id_contacto' => $request->get('contacto'),
            'id_estado' => $request->get('estdo'),

        ]);

        return redirect('Distribuidor');
       
    }


    public function update(Request $request)
    {

       
            $response = Http::put('http://localhost:3000/update_distribuidor', [
                'id_distribuidor' => $request->get('cod'),
                'rtn_distribuidor' => $request->get('rtn'),
                'nombre_distribuidor' => $request->get('nombre'),
                'id_pais' => $request->get('pais'),
                'id_tipo_entidad' => $request->get('entidad'),
                'id_usuario' => $request->get('usuario'),
                'id_contacto' => $request->get('contacto'),
                'id_estado' => $request->get('estdo'),
                
            
            ]);

            return redirect('Distribuidor');
    }
}


////////


       

        //return redirect('Distribuidor');

    






