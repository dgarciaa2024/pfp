<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\DB;

use Illuminate\Http\Request;

class SucursalesController extends Controller
{
    public function index()
    {
        $response = Http::get('http://localhost:3000/get_sucursales');
        $tabla_estado = Http::get('http://localhost:3000/estados');
        $tabla_municipio = Http::get('http://localhost:3000/get_municipios');


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
        ->where('id_objeto', 34) // ID del objeto que corresponde a "usuarios"
        ->first();

    // Si se encuentran permisos para este rol y objeto, asignarlos
    if ($permisos) {
        $permiso_insercion = $permisos->permiso_creacion;
        $permiso_actualizacion = $permisos->permiso_actualizacion;
        $permiso_eliminacion = $permisos->permiso_eliminacion;
    }
}
        return view('modulo_mantenimiento.Sucursal')->with([//vista
            'tblestado' => json_decode($tabla_estado, true),
            'tblmunicipio' => json_decode($tabla_municipio, true),
            'Sucursales' => json_decode($response, true),
            'permiso_insercion' => $permiso_insercion,
            'permiso_actualizacion' => $permiso_actualizacion,
            'permiso_eliminacion' => $permiso_eliminacion,

        ]);
    }


    public function store(Request $request)
    {
        $response = Http::post('http://localhost:3000/insert_sucursal', [
            'id_municipio' => $request->get('muni'),
            'nombre_sucursal' => $request->get('nomb'),
            'id_estado' => $request->get('estdo')

        ]);

        return redirect('Sucursal');

    }


    public function update(Request $request)
    {
        $response = Http::put('http://localhost:3000/update_sucursal', [
            'id_sucursal' => $request->get('cod'),
            'id_municipio' => $request->get('muni'),
            'nombre_sucursal' => $request->get('nomb'),
            'id_estado' => $request->get('estdo'),

        ]);

        return redirect('Sucursal');

    }

}