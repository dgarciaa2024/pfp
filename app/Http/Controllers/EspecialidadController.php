<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;


class EspecialidadController extends Controller
{

    public function index()
    {
        $response = Http::get('http://localhost:3002/get_especialidad');
        $tabla_estado = Http::get('http://localhost:3002/estados');

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
        ->where('id_objeto', 23) // ID del objeto "especialidad"
        ->first();

        if ($permisos) {
            $permiso_insercion = $permisos->permiso_creacion;
            $permiso_actualizacion = $permisos->permiso_actualizacion;
            $permiso_eliminacion = $permisos->permiso_eliminacion;
        }
    }


        return view('modulo_mantenimiento.Especialidad')->with([
        'tblestado'=> json_decode($tabla_estado,true),
        'Especialidades'=> json_decode($response,true),
        'permiso_insercion' => $permiso_insercion,
            'permiso_actualizacion' => $permiso_actualizacion,
            'permiso_eliminacion' => $permiso_eliminacion,
    ]);
    }

    
    public function store(Request $request)
    {
        $response = Http::post('http://localhost:3002/insert_especialidad', [
             'nombre_especialidad' => $request->get('especialidad'),
             'id_estado' => $request->get('estdo')

        ]);
  
 return redirect('Especialidad');
       
    }


    
    public function update(Request $request)
    {
        $response = Http::put('http://localhost:3002/update_especialidad', [
            'id_especialidad' => $request->get('cod'),
            'nombre_especialidad' => $request->get('especialidad'),
            'id_estado' => $request->get('estdo'),
            
        ]);

        return redirect('Especialidad');

    }


}