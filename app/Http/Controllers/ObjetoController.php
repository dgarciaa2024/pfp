<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;


use Illuminate\Http\Request;

class ObjetoController extends Controller
{
   
    public function index()
    {
        $response = Http::get('http://localhost:3000/get_objetos');
        $tabla_estado = Http::get('http://localhost:3000/estados');

            return view('modulo_usuarios.Objeto')->with([  
            'tblestado'=> json_decode($tabla_estado,true),
            'Objetos'=> json_decode($response,true)
        ]);
    }




    public function store(Request $request)
    {
        $response = Http::post('http://localhost:3000/insert_objeto', [
            'nombre' => $request->get('nom'),
            'descripcion' => $request->get('des'),
            'id_estado' => $request->get('estdo')

        ]);
        return redirect('Objeto');
    }

    public function update(Request $request)
    {
        $response = Http::put('http://localhost:3000/update_objeto', [
            'id_objeto' => $request->get('cod'),
            'nombre' => $request->get('nom'),
            'descripcion' => $request->get('des'),
            'id_estado' => $request->get('estdo')
            
        ]);

        return redirect('Objeto');

    }

    public function destroy($id_objeto)
    {
        // Lógica para eliminar el objeto de la base de datos
        $response = Http::delete('http://localhost:3000/delete_objeto', [
            'id_objeto' => $id_objeto
        ]);
    
        return redirect('Objeto');
    }
    



}