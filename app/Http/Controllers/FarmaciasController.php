<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class FarmaciasController extends Controller
{
    
 

    public function index()
    {
        $response = Http::get(env('API_URL', 'http://localhost:3002').'/get_farmacias');
        $tabla_sucursal = Http::get(env('API_URL', 'http://localhost:3002').'/get_sucursales');
        $tabla_usuario= Http::get(env('API_URL', 'http://localhost:3002').'/get_usuarios');
        $tabla_entidad = Http::get(env('API_URL', 'http://localhost:3002').'/get_tipo_entidad');
        $tabla_estado = Http::get(env('API_URL', 'http://localhost:3002').'/estados');
        $tabla_contacto = Http::get(env('API_URL', 'http://localhost:3002').'/get_contactos');
       
        
        // Manejo de sesión y permisos
        $usuario = session('usuario'); // Obtener usuario desde la sesión

        // Permisos predeterminados
        $permiso_insercion = 2;
        $permiso_actualizacion = 2;
        $permiso_eliminacion = 2;

        if ($usuario) {
            $idRolUsuario = $usuario['id_rol']; // Obtener el rol del usuario desde la sesión

            // Consultar permisos en la base de datos para el rol y objeto 4 (farmacias)
            $permisos = DB::table('pfp_schema.tbl_permiso')
                ->where('id_rol', $idRolUsuario)
                ->where('id_objeto', 13) // ID del objeto que corresponde a "farmacias"
                ->first();

            // Si se encuentran permisos para este rol y objeto, asignarlos
            if ($permisos) {
                $permiso_insercion = $permisos->permiso_creacion;
                $permiso_actualizacion = $permisos->permiso_actualizacion;
                $permiso_eliminacion = $permisos->permiso_eliminacion;
            }
        }


        return view('modulo_operaciones.Farmacias')->with([//vista
       
        'tblcontacto'=> json_decode($tabla_contacto,true),
        'tblestado'=> json_decode($tabla_estado,true),
        'tblentidad'=> json_decode($tabla_entidad,true),
        'tblusuario'=> json_decode($tabla_usuario,true),
        'tblsucursal'=> json_decode($tabla_sucursal,true),
        'Farmacias'=> json_decode($response,true),
        'permiso_insercion' => $permiso_insercion,
        'permiso_actualizacion' => $permiso_actualizacion,
        'permiso_eliminacion' => $permiso_eliminacion,

    ]);
    }


    
    public function store(Request $request)
    {
        $response = Http::post(env('API_URL', 'http://localhost:3002').'/insert_farmacia', [
            'rtn_farmacia' => $request->get('rtn'),
            'nombre_farmacia' => $request->get('nombre'),
            'id_sucursal' => $request->get('sucursal'),
            'id_usuario' => $request->get('usuario'),
            'id_tipo_entidad' => $request->get('entidad'),
            'id_estado' => $request->get('estdo'),
            'id_contacto' => $request->get('contacto'),
             

        ]);

        return redirect('Farmacias');
       
    }


    public function update(Request $request)
    {
        $response = Http::put(env('API_URL', 'http://localhost:3002').'/update_farmacia', [
            'id_farmacia' => $request->get('cod'),
            'rtn_farmacia' => $request->get('rtn'),
            'nombre_farmacia' => $request->get('nombre'),
            'id_sucursal' => $request->get('sucursal'),
            'id_usuario' => $request->get('usuario'),
            'id_tipo_entidad' => $request->get('entidad'),
            'id_estado' => $request->get('estdo'),
            'id_contacto' => $request->get('contacto'),
            
        ]);

        return redirect('Farmacias');

    }





}
