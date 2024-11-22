<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;


use Illuminate\Http\Request;

class ParametroController extends Controller
{
   
    public function index()
    {
        $response = Http::get('http://localhost:3000/get_parametros');
        $tabla_usuario = Http::get('http://localhost:3000/get_usuarios');


            return view('modulo_usuarios.Parametros')->with([  
           'tblusuario'=> json_decode($tabla_usuario,true),
           'Parametros'=> json_decode($response,true)
        ]);
    }




    public function store(Request $request)
    {
        $response = Http::post('http://localhost:3000/insert_parametro', [
            'parametro' => $request->get('par'),
            'valor' => $request->get('val'),
            'id_usuario' => $request->get('usuario')

        ]);
        return redirect('Parametro');
    }

    public function update(Request $request)
    {
        $response = Http::put('http://localhost:3000/update_parametro', [
            'id_parametro' => $request->get('par'),
            'parametro' => $request->get('par'),
            'valor' => $request->get('val'),
            'id_usuario' => $request->get('usuario')
            
        ]);

        return redirect('Parametro');

    }

    public function destroy($id_parametro)
    {
        // Lógica para eliminar el objeto de la base de datos
        $response = Http::delete('http://localhost:3000/delete_parametro', [
            'id_parametro' => $id_parametro
        ]);
    
        return redirect('Parametro');
    }
}