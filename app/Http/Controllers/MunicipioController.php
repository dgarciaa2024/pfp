<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;


use Illuminate\Http\Request;

class MunicipioController extends Controller
{
    

    public function index()
    {
        $response = Http::get('http://localhost:3000/get_municipios');
        $tabla_depto = Http::get('http://localhost:3000/get_departamentos'); 
        $tabla_estado = Http::get('http://localhost:3000/estados');

        return view('modulo_mantenimiento.Municipio')->with([
        'tblestado'=> json_decode($tabla_estado,true),
        'tbldepto'=> json_decode($tabla_depto,true),
        'Municipios'=> json_decode($response,true)
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