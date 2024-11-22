<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;


use Illuminate\Http\Request;

class FormaFarmaceuticaController extends Controller
{
    

    public function index()
    {
        $response = Http::get('http://localhost:3000/get_forma_farmaceutica');
        $tabla_estado = Http::get('http://localhost:3000/estados');

        return view('modulo_mantenimiento.FormaFarmaceutica')->with([
        'tblestado'=> json_decode($tabla_estado,true),
        'FormaFarma'=> json_decode($response,true)
    ]);
    }

    
    public function store(Request $request)
    {
        $response = Http::post('http://localhost:3000/insert_forma_farmaceutica', [
             'forma_farmaceutica' => $request->get('farma'),
             'id_estado' => $request->get('estdo')

        ]);
  
 return redirect('FormaFarmaceutica');
       
    }


    
    public function update(Request $request)
    {
        $response = Http::put('http://localhost:3000/update_forma_farmaceutica', [
            'id_forma_farmaceutica' => $request->get('cod'),
            'forma_farmaceutica' => $request->get('farma'),
            'id_estado' => $request->get('estdo'),
            
        ]);

        return redirect('FormaFarmaceutica');

    }


}