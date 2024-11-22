<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;


use Illuminate\Http\Request;

class ZonaController extends Controller
{
   


    public function index()
    {
        $response = Http::get('http://localhost:3000/get_zonas');
        $tabla_estado = Http::get('http://localhost:3000/estados');
        $tabla_paises = Http::get('http://localhost:3000/get_paises');
       

        return view('modulo_mantenimiento.Zona')->with([
        'tblpais'=> json_decode($tabla_paises,true),
        'tblestado'=> json_decode($tabla_estado,true),
        'Zonas'=> json_decode($response,true)
    ]);
    }


    public function store(Request $request)
    {
        $response = Http::post('http://localhost:3000/insert_zona', [
            'id_pais' => $request->get('pais'),
             'zona' => $request->get('zona'),
             'id_estado' => $request->get('estdo')

        ]);
  
 return redirect('Zona');
       
    }


    
    public function update(Request $request)
    {
        $response = Http::put('http://localhost:3000/update_zona', [
            'id_zona' => $request->get('cod'),
            'zona' => $request->get('zona'),
            'id_estado' => $request->get('estdo'),
            'id_pais' => $request->get('pais')
             
            
        ]);

        return redirect('Zona');

    }









}