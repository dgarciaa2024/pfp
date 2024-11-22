<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;


use Illuminate\Http\Request;

class TipoContactoController extends Controller
{
    public function index()
    {
        $response = Http::get('http://localhost:3000/get_tipo_contacto');
        $tabla_estado = Http::get('http://localhost:3000/estados');

        return view('modulo_mantenimiento.TipoContacto')->with([
        'tblestado'=> json_decode($tabla_estado,true),
        'Tp_Contacto'=> json_decode($response,true)
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