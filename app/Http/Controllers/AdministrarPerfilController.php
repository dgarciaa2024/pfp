<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class AdministrarPerfilController extends Controller
{
    public function index()
    {
        // Obtener el usuario autenticado
        $userId = Auth::id();

        // Buscar información en la tabla tbl_paciente relacionada con el usuario autenticado
        $paciente = DB::table('pfp_schema.tbl_paciente')->where('id_usuario', $userId)->first();

        // Si no hay información, enviar una vista sin datos
        if (!$paciente) {
            return view('modulo_usuarios.AdministrarPerfil', ['paciente' => null]);
        }

        // Enviar los datos del paciente a la vista para mostrarlos
        return view('modulo_usuarios.AdministrarPerfil', ['paciente' => $paciente]);
    }

    public function actualizarDatos(Request $request)
    {
        // Validar los datos entrantes
        $request->validate([
            'celular' => 'nullable|string|max:15',
            'email' => 'nullable|email|max:255',
            'direccion' => 'nullable|string|max:255',
        ]);

        // Obtener el usuario autenticado
        $userId = Auth::id();

        // Actualizar los datos en la tabla tbl_paciente
        DB::table('pfp_schema.tbl_paciente')
            ->where('id_usuario', $userId)
            ->update([
                'celular' => $request->input('celular'),
                'email' => $request->input('email'),
                'direccion' => $request->input('direccion'),
                'fecha_modificacion' => now(),
            ]);

        return redirect()->back()->with('success', 'Datos actualizados exitosamente');
    }

    public function CambiarContrasena()
    {
        return view('CambiarContrasena'); // Muestra la página para cambiar la contraseña
    }
}
