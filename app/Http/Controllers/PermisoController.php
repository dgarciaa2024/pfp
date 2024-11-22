<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;


use Illuminate\Http\Request;

class PermisoController extends Controller
{
    

    public function index()
    {
        $response = Http::get('http://localhost:3000/get_permisos');
        $tabla_estado = Http::get('http://localhost:3000/estados');
        $tabla_objeto= Http::get('http://localhost:3000/get_objetos');
        $tabla_rol = Http::get('http://localhost:3000/get_roles');

            return view('modulo_usuarios.Permisos')->with([  
            'tblestado'=> json_decode($tabla_estado,true),
            'tblrol'=> json_decode($tabla_rol,true),
            'tblobjeto'=> json_decode($tabla_objeto,true),
            'Permisos'=> json_decode($response,true)
        ]);
    }




    public function store(Request $request)
    {
        $response = Http::post('http://localhost:3000/insert_permiso', [
            'id_rol' => $request->get('rol'),
            'id_objeto' => $request->get('obj'),
            'permiso_creacion' => $request->get('cre'),
            'permiso_actualizacion' => $request->get('act'),
            'permiso_eliminacion' => $request->get('elm'),
            'permiso_consultar' => $request->get('con'),
            'id_estado' => $request->get('estdo')

        ]);
        return redirect('Permiso');
    }

    public function update(Request $request)
    {
        $response = Http::put('http://localhost:3000/update_permiso', [
            'id_permiso' => $request->get('cod'),
            'id_rol' => $request->get('rol'),
            'id_objeto' => $request->get('obj'),
            'permiso_creacion' => $request->get('cre'),
            'permiso_actualizacion' => $request->get('act'),
            'permiso_eliminacion' => $request->get('elm'),
            'permiso_consultar' => $request->get('con'),
            'id_estado' => $request->get('estdo')

        ]);
        return redirect('Permiso');

    }

    public function destroy($id_permiso)
    {
        // Lógica para eliminar el objeto de la base de datos
        $response = Http::delete('http://localhost:3000/delete_permiso', [
            'id_permiso' => $id_permiso
        ]);
    
        return redirect('Permiso');
    }
    
}