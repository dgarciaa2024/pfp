<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;


use Illuminate\Http\Request;

class ViaAdministracionController extends Controller
{
 

    public function index()
    {
        $response = Http::get('http://localhost:3000/get_via_administracion');
        $tabla_estado = Http::get('http://localhost:3000/estados');

        return view('modulo_mantenimiento.ViaAdministracion')->with([
        'tblestado'=> json_decode($tabla_estado,true),
        'ViaAdmin'=> json_decode($response,true)
    ]);
    }

    public function store(Request $request)
    {
        $response = Http::post('http://localhost:3000/insert_via_administracion', [
            'id_estado' => $request->get('estdo'),
            'via_administracion' => $request->get('via')
             

        ]);
  
 return redirect('ViaAdministracion');
       
    }


    
    public function update(Request $request)
    {
        $response = Http::put('http://localhost:3000/update_via_administracion', [
            'id_via_administracion' => $request->get('cod'),
            'via_administracion' => $request->get('via'),
            'id_estado' => $request->get('estdo'),
            
        ]);

        return redirect('ViaAdministracion');

    }



}