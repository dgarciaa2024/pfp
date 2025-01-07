<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;


class TipoRegistroController extends Controller
{
  

    public function index()
    {
        $response = Http::get('http://localhost:3000/get_tipo_registro');

        $TpRegistro= json_decode( $response,true);
    
      
        $tabla_estado = Http::get('http://localhost:3000/estados');
        $tabla_rol = Http::get('http://localhost:3000/get_roles');
        $tabla_tipo_registro = Http::get('http://localhost:3000/get_tipo_registro');
        

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
               ->where('id_objeto', 24) // ID del objeto que corresponde a "TipoRegistro"
               ->first();

               if ($permisos) {
                   $permiso_insercion = $permisos->permiso_creacion;
                   $permiso_actualizacion = $permisos->permiso_actualizacion;
                   $permiso_eliminacion = $permisos->permiso_eliminacion;
               }
           }


        return view('modulo_mantenimiento.TipoRegistro')->with([

            "TpRegistro"=>  $TpRegistro,
            'permiso_insercion' => $permiso_insercion,
            'permiso_actualizacion' => $permiso_actualizacion,
            'permiso_eliminacion' => $permiso_eliminacion,
        ]);
        
        
      
    }
    public function store(Request $request)
    {
            $response = Http::post('http://localhost:3000/insert_tipo_registro', [
                'tipo_registro' => $request->get('tipo')
            ]);


        
            return redirect('TipoRegistro');

        }

    public function update(Request $request)
    {
            $response = Http::put('http://localhost:3000/update_tipo_registro', [
                'id_tipo_registro' => $request->get('cod'),
                'tipo_registro' => $request->get('tipo')
            ]);

            return redirect('TipoRegistro');
        }
    }

