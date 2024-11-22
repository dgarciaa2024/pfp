<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Http;
use Illuminate\Http\Request;


class FacturaController extends Controller
{
   

    public function index()
    {
        $response = Http::get('http://localhost:3000/get_facturas');
        $tabla_producto = Http::get('http://localhost:3000/get_producto');
        $tabla_paciente = Http::get('http://localhost:3000/get_pacientes');
 
        return view('modulo_canjes.Facturas')->with([
        'tblpaciente'=> json_decode($tabla_paciente,true),
        'tblproducto'=> json_decode($tabla_producto,true),
        'Facturas'=> json_decode($response,true)
    ]);
    }


    public function store(Request $request)
    {
        $response = Http::post('http://localhost:3000/insert_factura', [
            'factura' => $request->input('factura'),
            'id_paciente' => $request->input('paciente'),
            'id_producto' => $request->input('producto'),
            'cantidad_producto' => $request->input('cantidad'),
        ]);
        
        // Verificar si el backend devuelve un mensaje de éxito o notificación
        if ($response->successful()) {
            $mensaje = $response->json()['mensaje'] ?? 'Factura insertada exitosamente';
            return redirect()->back()->with('status_message', $mensaje);
        } else {
            return redirect()->back()->with('status_message', 'Hubo un error al procesar la factura.');
        }
        

        return redirect('Facturas');
    }

 }

   



