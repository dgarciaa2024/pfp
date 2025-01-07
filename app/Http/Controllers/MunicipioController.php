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
        $response = Http::get('http://localhost:3000/get_municipios');
        $tabla_depto = Http::get('http://localhost:3000/get_departamentos'); 
        $tabla_estado = Http::get('http://localhost:3000/estados');

  // Validar permisos para inserción y edición
  $usuario = session('usuario'); // Obtener usuario desde la sesión
  $permiso_insercion = 2;     // Valor predeterminado para inserción
  $permiso_edicion = 2;       // Valor predeterminado para edición

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
      }
  }


        return view('modulo_mantenimiento.Municipio')->with([
        'tblestado'=> json_decode($tabla_estado,true),
        'tbldepto'=> json_decode($tabla_depto,true),
        'Municipios'=> json_decode($response,true),
        'permiso_insercion' => $permiso_insercion,
        'permiso_edicion' => $permiso_edicion,
    ]);
    }


    public function store(Request $request)
    {
        $response = Http::post('http://localhost:3000/insert_municipio', [
            'id_departamento' => $request->get('depto'),
             'municipio' => $request->get('municipio'),
             'id_estado' => $request->get('estdo')

        ]);
  
 return redirect('Municipio');
       
    }


    
    public function update(Request $request)
    {
        $response = Http::put('http://localhost:3000/update_municipio', [
       'id_departamento' => $request->get('depto'),
            'id_municipio' => $request->get('cod'),
             'municipio' => $request->get('municipio'),
             'id_estado' => $request->get('estdo'),
            
        ]);

        return redirect('Municipio');

    }





}