<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;


class TipoContactoController extends Controller
{
    public function index()
    {
        $response = Http::get('http://localhost:3000/get_tipo_contacto');
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
                 ->where('id_objeto', operator: 26) // ID del objeto que corresponde a "TipoContacto"
                 ->first();
  // Si se encuentran permisos para este rol y objeto, asignarlos
  if ($permisos) {
     $permiso_insercion = $permisos->permiso_creacion;
     $permiso_actualizacion = $permisos->permiso_actualizacion;
     $permiso_eliminacion = $permisos->permiso_eliminacion;
 }
 }
        return view('modulo_mantenimiento.TipoContacto')->with([
        'tblestado'=> json_decode($tabla_estado,true),
        'Tp_Contacto'=> json_decode($response,true),
        'permiso_insercion' => $permiso_insercion,
        'permiso_actualizacion' => $permiso_actualizacion,
        'permiso_eliminacion' => $permiso_eliminacion,
    ]);
    }


    public function store(Request $request)
    {
        $response = Http::post('http://localhost:3000/insert_tipo_contacto', [
            'tipo_contacto' => $request->get('tipo'),
             'id_estado' => $request->get('estdo')

        ]);

        return redirect('TipoContacto');
       
    }

     
    public function update(Request $request)
    {
        $response = Http::put('http://localhost:3000/update_tipo_contacto', [
            'id_tipo_contacto' => $request->get('cod'),
            'tipo_contacto' => $request->get('tipo'),
            'id_estado' => $request->get('estdo'),
            
        ]);

        return redirect('TipoContacto');

    }

}