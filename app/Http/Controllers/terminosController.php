<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;


use Illuminate\Http\Request;

class terminosController extends Controller
{
    public function index()
    {
        

        return view('modulo_otras_paginas.terminos');  // Asegúrate de tener una vista llamada 'crear_usuario.blade.php'
       
        
    }




    public function store(Request $request)
    {
        
    }




}