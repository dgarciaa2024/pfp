<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;


use Illuminate\Http\Request;

class UnidadMedidaController extends Controller
{
   

 

    public function index()
    {
        $response = Http::get('http://localhost:3000/get_unidad_medida');
        $tabla_estado = Http::get('http://localhost:3000/estados');
      



        return view('modulo_mantenimiento.UnidadMedida')->with([
        'tblestado'=> json_decode($tabla_estado,true),
        'UMedida'=> json_decode($response,true)
    ]);
    }


    public function store(Request $request)
    {
        $response = Http::post('http://localhost:3000/insert_unidad_medida', [
            'unidad_medida' => $request->get('unidad'),
             'id_estado' => $request->get('estdo')
          

        ]);
  
 return redirect('UnidadMedida');
       
    }


    
    public function update(Request $request)
    {
        $response = Http::put('http://localhost:3000/update_unidad_medida', [
            'id_unidad_medida' => $request->get('cod'),
            'unidad_medida' => $request->get('unidad'),
            'id_estado' => $request->get('estdo'),
            
        ]);

        return redirect('UnidadMedida');

    }

   
}