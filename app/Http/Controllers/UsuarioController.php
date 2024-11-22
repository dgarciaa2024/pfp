<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;


use Illuminate\Http\Request;

class UsuarioController extends Controller
{
    


    public function index()
    {
        $response = Http::get('http://localhost:3000/get_usuarios');
        $tabla_estado = Http::get('http://localhost:3000/estados');
        $tabla_rol = Http::get('http://localhost:3000/get_roles');
        
        

        return view('modulo_usuarios.Usuarios')->with([
        'tblrol'=> json_decode($tabla_rol,true),
        'tblestado'=> json_decode($tabla_estado,true),
        'Usuarios'=> json_decode($response,true)
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
