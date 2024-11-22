<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;


use Illuminate\Http\Request;

class EspecialidadController extends Controller
{

    public function index()
    {
        $response = Http::get('http://localhost:3000/get_especialidad');
        $tabla_estado = Http::get('http://localhost:3000/estados');

        return view('modulo_mantenimiento.Especialidad')->with([
        'tblestado'=> json_decode($tabla_estado,true),
        'Especialidades'=> json_decode($response,true)
    ]);
    }

    
    public function store(Request $request)
    {
        $response = Http::post('http://localhost:3000/insert_especialidad', [
             'nombre_especialidad' => $request->get('especialidad'),
             'id_estado' => $request->get('estdo')

        ]);
  
 return redirect('Especialidad');
       
    }


    
    public function update(Request $request)
    {
        $response = Http::put('http://localhost:3000/update_especialidad', [
            'id_especialidad' => $request->get('cod'),
            'nombre_especialidad' => $request->get('especialidad'),
            'id_estado' => $request->get('estdo'),
            
        ]);

        return redirect('Especialidad');

    }


}