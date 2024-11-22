<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;


use Illuminate\Http\Request;

class ContactosController extends Controller
{
    public function index()
    {
        $response = Http::get('http://localhost:3000/get_contactos');
        $tabla_usuario = Http::get('http://localhost:3000/get_usuarios');
        $tabla_tipo_contacto = Http::get('http://localhost:3000/get_tipo_contacto');
        $tabla_estado = Http::get('http://localhost:3000/estados');

        return view('modulo_mantenimiento.Contacto')->with([
        'tblusuario'=> json_decode($tabla_usuario,true),
        'tbltipo'=> json_decode($tabla_tipo_contacto,true),
        'tblestado'=> json_decode($tabla_estado,true),
        'Contactos'=> json_decode($response,true)
    ]);
        
    }

    public function store(Request $request)
    {
        $response = Http::post('http://localhost:3000/insert_contacto', [
            'nombre_contacto'=> $request->get('nom_contacto'),
            'id_usuario'=> $request->get('usuario'),
            'id_tipo_contacto' => $request->get('tipo'),
           'telefono_1' => $request->get('telefono_1'),
            'telefono_2' => $request->get('telefono_2'),
            'email'=> $request->get('email'),
            'id_estado' => $request->get('estdo')

        ]);

        return redirect('Contacto');
       
    }


    public function update(Request $request)
    {
        $response = Http::put('http://localhost:3000/update_contacto', [
            'id_contacto' => $request->get('cod'),
            'nombre_contacto' => $request->get('nom_contacto'),
            'id_usuario' => $request->get('usuario'),
            'id_tipo_contacto' => $request->get('tipo'),
            'telefono_1' => $request->get('telefono_1'),
            'telefono_2' => $request->get('telefono_2'),
            'email' => $request->get('email'),
            'id_estado' => $request->get('estdo'),
            
        ]);

        return redirect('Contacto');

    }

    
}