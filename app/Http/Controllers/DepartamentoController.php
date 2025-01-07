<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;

class DepartamentoController extends Controller
{
   


    public function index()
    {
        $response = Http::get('http://localhost:3000/get_departamentos');
        $tabla_zona = Http::get('http://localhost:3000/get_Zonas');
        $tabla_estado = Http::get('http://localhost:3000/estados');


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
         ->where('id_objeto', 29) // ID del objeto que corresponde a "departamento"
         ->first();

     // Si se encuentran permisos para este rol y objeto, asignarlos
     if ($permisos) {
         $permiso_insercion = $permisos->permiso_creacion;
         $permiso_actualizacion = $permisos->permiso_actualizacion;
         $permiso_eliminacion = $permisos->permiso_eliminacion;
     }
 }

        return view('modulo_mantenimiento.Departamento')->with([
        'tblestado'=> json_decode($tabla_estado,true),
        'tblzona'=> json_decode($tabla_zona,true),
        'Departamentos'=> json_decode($response,true),
        'permiso_insercion' => $permiso_insercion,
        'permiso_actualizacion' => $permiso_actualizacion,
        'permiso_eliminacion' => $permiso_eliminacion,
    ]);
    }

    public function store(Request $request)
    {
        $response = Http::post('http://localhost:3000/insert_departamento', [
            'id_zona' => $request->get('zona'),
             'nombre_departamento' => $request->get('depto'),
             'id_estado' => $request->get('estdo')

        ]);
  
 return redirect('Departamento');
       
    }


    
    public function update(Request $request)
    {
        $response = Http::put('http://localhost:3000/update_departamento', [
            'id_zona' => $request->get('zona'),
            'id_departamento' => $request->get('cod'),
             'nombre_departamento' => $request->get('depto'),
             'id_estado' => $request->get('estdo'),
            
        ]);

        return redirect('Departamento');

    }






}