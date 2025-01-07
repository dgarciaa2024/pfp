<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;


class UsuarioController extends Controller
{
    


    public function index()
    {
        $response = Http::get('http://localhost:3000/get_usuarios');
        $tabla_estado = Http::get('http://localhost:3000/estados');
        $tabla_rol = Http::get('http://localhost:3000/get_roles');
        
        
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

        // Para depuración: Verificar valores antes de retornar la vista
        // Descomenta esto si quieres depurar.
        // dd(session('usuario'), $permiso_insercion, $permiso_actualizacion, $permiso_eliminacion);

        // Retornar vista con datos y permisos

        return view('modulo_usuarios.Usuarios')->with([
        'tblrol'=> json_decode($tabla_rol,true),
        'tblestado'=> json_decode($tabla_estado,true),
        'Usuarios'=> json_decode($response,true),
        'permiso_insercion' => $permiso_insercion,
        'permiso_actualizacion' => $permiso_actualizacion,
        'permiso_eliminacion' => $permiso_eliminacion,
    ]);
    }


    public function store(Request $request)
    {
        $response = Http::post('http://localhost:3000/insert_usuario', [
            'usuario' => $request->get('usu'),
            'nombre_usuario' => $request->get('nom_usu'),
           'contrasena' => $request->get('contra'),
            'id_rol' => $request->get('rol'),
            'email' => $request->get('correo'),
            'primer_ingreso' => $request->get('ingreso'),
             'id_estado' => $request->get('estdo')

        ]);
  
 return redirect('Usuarios');
       
    }

    public function update(Request $request)
    {
        $response = Http::put('http://localhost:3000/update_usuario', [
            'id_usuario' => $request->get('cod'),
           'usuario' => $request->get('usu'),
            'nombre_usuario' => $request->get('nom_usu'),
            'contrasena' => $request->get('contra'),
            'id_rol' => $request->get('rol'),
            'email' => $request->get('correo'),
            'primer_ingreso' => $request->get('ingreso'),
             'id_estado' => $request->get('estdo')

            
        ]);

        return redirect('Usuarios');

    }




}
