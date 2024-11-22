<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;


use Illuminate\Http\Request;

class RolController extends Controller
{
    

    public function index()
    {
        $response = Http::get('http://localhost:3000/get_roles');
        $tabla_estado = Http::get('http://localhost:3000/estados');

        return view('modulo_usuarios.Roles')->with([
        'tblestado'=> json_decode($tabla_estado,true),
        'Roles'=> json_decode($response,true)
    ]);
    }


    public function store(Request $request)
    {
        $response = Http::post('http://localhost:3000/insert_rol', [
            'rol' => $request->get('rol'),
             'descripcion' => $request->get('descripcion'),
             'id_estado' => $request->get('estdo')

        ]);
  
 return redirect('Roles');
       
    }


    
    public function update(Request $request)
    {
        $response = Http::put('http://localhost:3000/update_rol', [
            'id_rol' => $request->get('cod'),
            'rol' => $request->get('rol'),
            'descripcion' => $request->get('descripcion'),
            'id_estado' => $request->get('estdo'),
            
        ]);

        return redirect('Roles');

    }





}