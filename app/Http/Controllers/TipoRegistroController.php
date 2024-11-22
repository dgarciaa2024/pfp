<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;


use Illuminate\Http\Request;

class TipoRegistroController extends Controller
{
  

    public function index()
    {
        $response = Http::get('http://localhost:3000/get_tipo_registro');

        $TpRegistro= json_decode( $response,true);
    
      

        return view('modulo_mantenimiento.TipoRegistro')->with([

            "TpRegistro"=>  $TpRegistro
           
        ]);
        
        
      
    }
    public function store(Request $request)
    {
        $response = Http::post('http://localhost:3000/insert_tipo_registro', [
            'tipo_registro' => $request->get('tipo')
          

        ]);
        $response = Http::get('http://localhost:3000/get_tipo_registro');

        $TpRegistro= json_decode( $response,true);
       

 // Pasar la lista de estados a la vista
 return view('modulo_mantenimiento.TipoRegistro')->with([

    "TpRegistro"=>  $TpRegistro
   
]);
}

public function update(Request $request)
{
    $response = Http::put('http://localhost:3000/update_tipo_registro', [
        'id_tipo_registro' => $request->get('cod'),
        'tipo_registro' => $request->get('tipo'),
        
    ]);

    $response = Http::get('http://localhost:3000/get_tipo_registro');

        $TpRegistro= json_decode( $response,true);

    return redirect('TipoRegistro')->with([

       "TpRegistro"=>  $TpRegistro
       
       
    ]);
    
    

}

}