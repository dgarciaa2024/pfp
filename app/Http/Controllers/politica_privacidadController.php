<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;


use Illuminate\Http\Request;

class politica_privacidadController extends Controller
{
    public function index()
    {
        

        return view('modulo_otras_paginas.politica_privacidad');  // Asegúrate de tener una vista llamada 'crear_usuario.blade.php'
       
        
    }




    public function store(Request $request)
    {
        
    }




}