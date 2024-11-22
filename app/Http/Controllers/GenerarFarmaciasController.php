<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;


use Illuminate\Http\Request;

class GenerarFarmaciasController extends Controller
{
    public function index()
    {
        //$response = 'Usuarios';

        return view('layouts.GenerarFarmacias');  // Asegúrate de tener una vista llamada 'crear_usuario.blade.php'
    
    }

    public function store(Request $request)
    {
        
    }
}