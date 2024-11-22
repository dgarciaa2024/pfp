<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;


use Illuminate\Http\Request;

class FarmaciasController extends Controller
{
    
 

    public function index()
    {
        $response = Http::get('http://localhost:3000/get_farmacias');
        $tabla_sucursal = Http::get('http://localhost:3000/get_sucursales');
        $tabla_usuario= Http::get('http://localhost:3000/get_usuarios');
        $tabla_entidad = Http::get('http://localhost:3000/get_tipo_entidad');
        $tabla_estado = Http::get('http://localhost:3000/estados');
        $tabla_contacto = Http::get('http://localhost:3000/get_contactos');
       
        


        return view('modulo_operaciones.Farmacias')->with([//vista
       
        'tblcontacto'=> json_decode($tabla_contacto,true),
        'tblestado'=> json_decode($tabla_estado,true),
        'tblentidad'=> json_decode($tabla_entidad,true),
        'tblusuario'=> json_decode($tabla_usuario,true),
        'tblsucursal'=> json_decode($tabla_sucursal,true),
        'Farmacias'=> json_decode($response,true)

    ]);
    }


    
    public function store(Request $request)
    {
        $response = Http::post('http://localhost:3000/insert_farmacia', [
            'rtn_farmacia' => $request->get('rtn'),
            'nombre_farmacia' => $request->get('nombre'),
            'id_sucursal' => $request->get('sucursal'),
            'id_usuario' => $request->get('usuario'),
            'id_tipo_entidad' => $request->get('entidad'),
            'id_estado' => $request->get('estdo'),
            'id_contacto' => $request->get('contacto'),
             

        ]);

        return redirect('Farmacias');
       
    }


    public function update(Request $request)
    {
        $response = Http::put('http://localhost:3000/update_farmacia', [
            'id_farmacia' => $request->get('cod'),
            'rtn_farmacia' => $request->get('rtn'),
            'nombre_farmacia' => $request->get('nombre'),
            'id_sucursal' => $request->get('sucursal'),
            'id_usuario' => $request->get('usuario'),
            'id_tipo_entidad' => $request->get('entidad'),
            'id_estado' => $request->get('estdo'),
            'id_contacto' => $request->get('contacto'),
            
        ]);

        return redirect('Farmacias');

    }





}
