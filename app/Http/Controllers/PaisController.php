<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;


class PaisController extends Controller
{
    

    public function index()
    {
        $response = Http::get(env('API_URL', 'http://localhost:3002').'/get_paises');
        $tbl_Estado = Http::get(env('API_URL', 'http://localhost:3002').'/estados');
   // Validar permisos para inserción y edición
   $usuario = session('usuario'); // Obtener usuario desde la sesión
   $permiso_insercion = 2;     // Valor predeterminado para inserción
   $permiso_edicion = 2;       // Valor predeterminado para edición

   if ($usuario) {
       $idRolUsuario = $usuario['id_rol']; // Obtener el rol del usuario desde la sesión

       // Consultar permisos en la base de datos para el rol y objeto 2 (Pais)
       $permisos = DB::table('pfp_schema.tbl_permiso')
           ->where('id_rol', $idRolUsuario)
           ->where('id_objeto', 27) // ID del objeto que corresponde a "Pais"
           ->first();

       if ($permisos) {
           $permiso_insercion = $permisos->permiso_creacion ?? 2;
           $permiso_edicion = $permisos->permiso_edicion ?? 2;
       }
   }


        return view('modulo_mantenimiento.Pais')->with([

            'tblestado'=> json_decode($tbl_Estado,true),
            'Paises'=> json_decode($response,true),
            'permiso_insercion' => $permiso_insercion,
            'permiso_edicion' => $permiso_edicion,
        ]);
        
    }


    public function store(Request $request)
{
    // Enviar la solicitud POST a la API para insertar el nuevo estado
    $response = Http::post(env('API_URL', 'http://localhost:3002').'/insert_pais', [
        'nombre_pais' => $request->get('pais'),
        'id_estado' => $request->get('estdo'),
    ]);
    return redirect('Pais');
}


public function update(Request $request)
    {
        $response = Http::put(env('API_URL', 'http://localhost:3002').'/update_pais', [
            'id_pais' => $request->get('cod'),
            'nombre_pais' => $request->get('pais'),
            'id_estado' => $request->get('estdo'),
            
        ]);

        return redirect('Pais');

    }
}
