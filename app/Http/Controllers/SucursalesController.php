<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;


use Illuminate\Http\Request;

class SucursalesController extends Controller
{
    public function index()
    {
        $response = Http::get('http://localhost:3000/get_sucursales');
        $tabla_estado = Http::get('http://localhost:3000/estados');
        $tabla_municipio = Http::get('http://localhost:3000/get_municipios');

        return view('modulo_mantenimiento.Sucursal')->with([//vista
            'tblestado' => json_decode($tabla_estado, true),
            'tblmunicipio' => json_decode($tabla_municipio, true),
            'Sucursales' => json_decode($response, true)

        ]);
    }


    public function store(Request $request)
    {
        $response = Http::post('http://localhost:3000/insert_sucursal', [
            'id_municipio' => $request->get('muni'),
            'nombre_sucursal' => $request->get('nomb'),
            'id_estado' => $request->get('estdo')

        ]);

        return redirect('Sucursal');

    }


    public function update(Request $request)
    {
        $response = Http::put('http://localhost:3000/update_sucursal', [
            'id_sucursal' => $request->get('cod'),
            'id_municipio' => $request->get('muni'),
            'nombre_sucursal' => $request->get('nomb'),
            'id_estado' => $request->get('estdo'),

        ]);

        return redirect('Sucursal');

    }

}