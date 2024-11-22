<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;


use Illuminate\Http\Request;

class EstadoCanjeController extends Controller
{
   


    public function index()
    {
        $response = Http::get('http://localhost:3000/get_estado_canje');

        return view('modulo_canjes.Estado_Canje')->with([
        'Estacanje'=> json_decode($response,true)
    ]);
    }

    public function store(Request $request)
    {
        $response = Http::post('http://localhost:3000/insert_estado_canje', [
            'estado_canje' => $request->get('canje')

        ]);
  
 return redirect('Estado_Canje');
       
    }

  

public function update(Request $request)
{
    $response = Http::put('http://localhost:3000/update_estado_canje', [
        'id_estado_canje' => $request->get('cod'),
        'estado_canje' => $request->get('canje'),
        
    ]);

    return redirect('Estado_Canje');

}

}
