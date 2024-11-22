<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;


use Illuminate\Http\Request;

class TipoEntidadController extends Controller
{
   

    public function index()
    {
        $response = Http::get('http://localhost:3000/get_tipo_entidad');
        $tabla_estado = Http::get('http://localhost:3000/estados');

        $Tipentidad= json_decode( $response,true);
        $tblestado = json_decode( $tabla_estado,true);
      

        return view('modulo_mantenimiento.TipoEntidad')->with([

            "Tipentidad"=>  $Tipentidad,
            "tblestado"=> $tblestado
           
        ]);
        
        
      
    }

    public function store(Request $request)
    {
        $response = Http::post('http://localhost:3000/insert_tipo_entidad', [
            'tipo_entidad' => $request->get('tipo'),
             'id_estado' => $request->get('estdo')
          

        ]);
        $response = Http::get('http://localhost:3000/get_tipo_entidad');
        $tabla_estado = Http::get('http://localhost:3000/estados');

        $Tipentidad= json_decode( $response,true);
        $tblestado = json_decode( $tabla_estado,true);

 // Pasar la lista de estados a la vista
 return view('modulo_mantenimiento.TipoEntidad')->with([

    "Tipentidad"=>  $Tipentidad,
    "tblestado"=> $tblestado
   
]);
       
    }


    
    public function update(Request $request)
    {
        $response = Http::put('http://localhost:3000/update_tipo_entidad', [
            'id_tipo_entidad' => $request->get('cod'),
            'tipo_entidad' => $request->get('tipo'),
            'id_estado' => $request->get('estdo'),
            
        ]);

        $response = Http::get('http://localhost:3000/get_tipo_entidad');
        $tabla_estado = Http::get('http://localhost:3000/estados');

        $Tipentidad= json_decode( $response,true);
        $tblestado = json_decode( $tabla_estado,true);
        return redirect('TipoEntidad')->with([

            "Tipentidad"=>  $Tipentidad,
            "tblestado"=> $tblestado
           
        ]);
        
        

    }
}