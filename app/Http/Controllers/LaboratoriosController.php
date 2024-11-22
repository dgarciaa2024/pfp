<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;


use Illuminate\Http\Request;

class LaboratoriosController extends Controller
{
        public function index()
        {
            $response = Http::get('http://localhost:3000/get_laboratorios');
            $tabla_pais = Http::get('http://localhost:3000/get_paises');
            $tabla_contacto = Http::get('http://localhost:3000/get_contactos');
            $tabla_entidad = Http::get('http://localhost:3000/get_tipo_entidad');
            $tabla_usuario = Http::get('http://localhost:3000/get_usuarios');
            $tabla_estado = Http::get('http://localhost:3000/estados');

                return view('modulo_operaciones.Laboratorios')->with([  
                'tblpais'=> json_decode($tabla_pais,true),
                'tblcontacto'=> json_decode($tabla_contacto,true),
                'tblentidad'=> json_decode($tabla_entidad,true),
                'tblusuario'=> json_decode($tabla_usuario,true),
                'tblestado'=> json_decode($tabla_estado,true),
                'Laboratorios'=> json_decode($response,true)
            ]);
        }




        public function store(Request $request)
        {
            $response = Http::post('http://localhost:3000/insert_laboratorio', [
                'rtn_laboratorio' => $request->get('rtn'),
                'nombre_laboratorio' => $request->get('laboratorio'),
                'id_pais' => $request->get('pais'),
                'id_tipo_entidad' => $request->get('entidad'),
                'id_usuario' => $request->get('usuario'),
                'id_contacto' => $request->get('contacto'),
                'id_estado' => $request->get('estdo')

            ]);
            return redirect('Laboratorios');
        }

        public function update(Request $request)
        {
            $response = Http::put('http://localhost:3000/update_laboratorio', [
                'id_laboratorio' => $request->get('cod'),
              'rtn_laboratorio' => $request->get('rtn'),
                'nombre_laboratorio' => $request->get('laboratorio'),
                'id_pais' => $request->get('pais'),
                'id_tipo_entidad' => $request->get('entidad'),
                'id_usuario' => $request->get('usuario'),
                'id_contacto' => $request->get('contacto'),
                'id_estado' => $request->get('estdo')
    
                
            ]);
    
            return redirect('Laboratorios');
    
        }
    




}
