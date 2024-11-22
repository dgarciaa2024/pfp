<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;


use Illuminate\Http\Request;

class EstadoController extends Controller
{
  

    public function index()
    {
        $response = Http::get('http://localhost:3000/estados');

        return view('modulo_mantenimiento.Estado')->with('Estados', json_decode($response,true));
    }

    
   

    public function store(Request $request)
{
    // Enviar la solicitud POST a la API para insertar el nuevo estado
    $response = Http::post('http://localhost:3000/insert_estado', [
        'estado' => $request->get('estado')
    ]);
        // Recuperar la lista de estados actualizada con una solicitud GET
        $resGetEstado = Http::get('http://localhost:3000/estados');
        // Pasar la lista de estados a la vista
        return view('modulo_mantenimiento.Estado')->with('Estados', json_decode($resGetEstado, true));
}


public function update(Request $request)
{
    $response = Http::put('http://localhost:3000/update_estado', [
        'id_estado' => $request->get('cod'),
        'estado' => $request->get('estado'),

    ]);

    $http_Estado = Http::get('http://localhost:3000/estados');
    $TBL_Estado = json_decode($http_Estado,true);             

  
    return view('modulo_mantenimiento.Estado')->with("Estados", $TBL_Estado);



}
   
    



}