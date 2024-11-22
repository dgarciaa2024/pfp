<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;


use Illuminate\Http\Request;

class MarcaProductoController extends Controller
{
    public function index()
    {
        $response = Http::get('http://localhost:3000/get_marca_producto');
        $tabla_estado = Http::get('http://localhost:3000/estados');

            return view('modulo_mantenimiento.Marca')->with([ 
             
            'Marcas'=> json_decode($response,true),
            'tblestado'=> json_decode($tabla_estado,true)
        ]);
       
       
    }

    public function store(Request $request)
    {
        $response = Http::post('http://localhost:3000/insert_marca_producto', [
        'marca_producto' => $request->get('marca'),
        'id_estado' => $request->get('estdo')
    ]);
    return redirect('Marca');
}

public function update(Request $request)
{
    $response = Http::put('http://localhost:3000/update_marca_producto', [
        'id_marca_producto' => $request->get('cod'),
        'marca_producto' => $request->get('marca'),
         'id_estado' => $request->get('estdo'),
        
    ]);

    return redirect('Marca');

}


}