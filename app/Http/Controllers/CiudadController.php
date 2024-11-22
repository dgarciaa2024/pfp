<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;


use Illuminate\Http\Request;

class CiudadController extends Controller
{
    public function index()
    {
        //$response = 'Pais';

        return view('modulo_mantenimiento.Ciudad');  // Asegúrate de tener una vista llamada 'crear_usuario.blade.php'
       
        // return view('modulo_mantenimiento.Pais')->with('Usuarios', json_decode($response,true));
    }




    public function store(Request $request)
    {
        
    }




}