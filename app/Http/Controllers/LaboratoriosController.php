<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class LaboratoriosController extends Controller
{
        public function index()
        {
            $response = Http::get(env('API_URL', 'http://localhost:3002').'/get_laboratorios');
            $tabla_pais = Http::get(env('API_URL', 'http://localhost:3002').'/get_paises');
            $tabla_contacto = Http::get(env('API_URL', 'http://localhost:3002').'/get_contactos');
            $tabla_entidad = Http::get(env('API_URL', 'http://localhost:3002').'/get_tipo_entidad');
            $tabla_usuario = Http::get(env('API_URL', 'http://localhost:3002').'/get_usuarios');
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

            // Consultar permisos en la base de datos para el rol y objeto 3 (laboratorios)
            $permisos = DB::table('pfp_schema.tbl_permiso')
                ->where('id_rol', $idRolUsuario)
                ->where('id_objeto', 12) // ID del objeto que corresponde a "laboratorios"
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

                return view('modulo_operaciones.Laboratorios')->with([  
                'tblpais'=> json_decode($tabla_pais,true),
                'tblcontacto'=> json_decode($tabla_contacto,true),
                'tblentidad'=> json_decode($tabla_entidad,true),
                'tblusuario'=> json_decode($tabla_usuario,true),
                'tblestado'=> json_decode($tabla_estado,true),
                'Laboratorios'=> json_decode($response,true),
                'permiso_insercion' => $permiso_insercion,
                'permiso_actualizacion' => $permiso_actualizacion,
                'permiso_eliminacion' => $permiso_eliminacion,
            ]);
        }




        public function store(Request $request)
        {
            $response = Http::post(env('API_URL', 'http://localhost:3002').'/insert_laboratorio', [
                'rtn_laboratorio' => $request->get('rtn'),
                'nombre_laboratorio' => $request->get('laboratorio'),
                'id_pais' => $request->get('pais'),
                'id_tipo_entidad' => $request->get('entidad'),
                'id_usuario' => $request->get('usuario'),
                'id_contacto' => $request->get('contacto'),
                'id_estado' => $request->get('estdo')

            ]);
            if ($response->successful()) {
                return redirect('Laboratorios')->with('success', true);
            } else {
                return redirect()->back()->with('error', 'Error al realizar la operación.');
            }
    
    
        }

        public function update(Request $request)
        {
            $response = Http::put(env('API_URL', 'http://localhost:3002').'/update_laboratorio', [
                'id_laboratorio' => $request->get('cod'),
              'rtn_laboratorio' => $request->get('rtn'),
                'nombre_laboratorio' => $request->get('laboratorio'),
                'id_pais' => $request->get('pais'),
                'id_tipo_entidad' => $request->get('entidad'),
                'id_usuario' => $request->get('usuario'),
                'id_contacto' => $request->get('contacto'),
                'id_estado' => $request->get('estdo')
    
                
            ]);
    
            if ($response->successful()) {
                return redirect('Laboratorios')->with('success', true);
            } else {
                return redirect()->back()->with('error', 'Error al realizar la operación.');
            }
    
    
        
    
        }
    




}
