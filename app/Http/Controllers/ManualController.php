<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class ManualController extends Controller
{
    // Mostrar el Manual Técnico
    public function tecnico()
    {
        return view('manual_tecnico');
    }

    // Mostrar el Manual de Usuario
    public function usuario()
    {
        return view('manual_usuario');
    }

    // Mostrar el Manual de Instalación
    public function instalacion()
    {
        return view('manual_instalacion');
    }
}