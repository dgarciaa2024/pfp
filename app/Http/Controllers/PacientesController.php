<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;


use Illuminate\Http\Request;

class PacientesController extends Controller
{
 
    public function index()
    {
        $response = Http::get('http://localhost:3000/get_pacientes');
        $tabla_estado = Http::get('http://localhost:3000/estados');
        $tabla_rol = Http::get('http://localhost:3000/get_usuarios');
        
        

        return view('modulo_operaciones.Pacientes')->with([
        'tblusuario'=> json_decode($tabla_rol,true),
        'tblestado'=> json_decode($tabla_estado,true),
        'Pacientes'=> json_decode($response,true)
    ]);
    }



    public function store(Request $request)
    {
        $response = Http::post('http://localhost:3000/insert_paciente', [
            'dni_paciente' => $request->get('dni'),
            'nombre_paciente' => $request->get('nombre'),
           'apellido_paciente' => $request->get('apellido'),
            'fecha_nacimiento' => $request->get('nacimiento'),
            'email' => $request->get('email'),
            'direccion' => $request->get('direccion'),
            'celular' => $request->get('celular'),
            'tratamiento_medico' => $request->get('tratamiento'),
            'id_usuario' => $request->get('usuario'),
             'id_estado' => $request->get('estdo'),
             'genero' => $request->get('genero')

        ]);
  
 return redirect('Pacientes');
       
    }

    public function update(Request $request)
    {
        $response = Http::put('http://localhost:3000/update_paciente', [
            'id_paciente' => $request->get('cod'),
          'dni_paciente' => $request->get('dni'),
            'nombre_paciente' => $request->get('nombre'),
           'apellido_paciente' => $request->get('apellido'),
            'fecha_nacimiento' => $request->get('nacimiento'),
            'email' => $request->get('email'),
            'direccion' => $request->get('direccion'),
            'celular' => $request->get('celular'),
            'tratamiento_medico' => $request->get('tratamiento'),
            'id_usuario' => $request->get('usuario'),
             'id_estado' => $request->get('estdo'),
             'genero' => $request->get('genero')

            
        ]);

        return redirect('Pacientes');

    }




}
