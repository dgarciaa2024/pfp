<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;


use Illuminate\Http\Request;

class DepartamentoController extends Controller
{
   


    public function index()
    {
        $response = Http::get('http://localhost:3000/get_departamentos');
        $tabla_zona = Http::get('http://localhost:3000/get_Zonas');
        $tabla_estado = Http::get('http://localhost:3000/estados');

        return view('modulo_mantenimiento.Departamento')->with([
        'tblestado'=> json_decode($tabla_estado,true),
        'tblzona'=> json_decode($tabla_zona,true),
        'Departamentos'=> json_decode($response,true)
    ]);
    }

    public function store(Request $request)
    {
        $response = Http::post('http://localhost:3000/insert_departamento', [
            'id_zona' => $request->get('zona'),
             'nombre_departamento' => $request->get('depto'),
             'id_estado' => $request->get('estdo')

        ]);
  
 return redirect('Departamento');
       
    }


    
    public function update(Request $request)
    {
        $response = Http::put('http://localhost:3000/update_departamento', [
            'id_zona' => $request->get('zona'),
            'id_departamento' => $request->get('cod'),
             'nombre_departamento' => $request->get('depto'),
             'id_estado' => $request->get('estdo'),
            
        ]);

        return redirect('Departamento');

    }






}