<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;


use Illuminate\Http\Request;

class PaisController extends Controller
{
    

    public function index()
    {
        $response = Http::get('http://localhost:3000/get_paises');
        $tbl_Estado = Http::get('http://localhost:3000/estados');

        return view('modulo_mantenimiento.Pais')->with([

            'tblestado'=> json_decode($tbl_Estado,true),
            'Paises'=> json_decode($response,true),
        ]);
        
    }


    public function store(Request $request)
{
    // Enviar la solicitud POST a la API para insertar el nuevo estado
    $response = Http::post('http://localhost:3000/insert_pais', [
        'nombre_pais' => $request->get('pais'),
        'id_estado' => $request->get('estdo'),
    ]);
    return redirect('Pais');
}


public function update(Request $request)
    {
        $response = Http::put('http://localhost:3000/update_pais', [
            'id_pais' => $request->get('cod'),
            'nombre_pais' => $request->get('pais'),
            'id_estado' => $request->get('estdo'),
            
        ]);

        return redirect('Pais');

    }
}
