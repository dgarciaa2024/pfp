<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class CambiarContrasenaController extends Controller
{
    public function index()
    {
        return view('modulo_usuarios.CambiarContrasena');
    }

    public function store(Request $request)
    {
        // Obtener el usuario autenticado en mayúsculas
        $usuario = strtoupper(auth()->user()->usuario);
        $contrasenaActual = $request->input('contrasena_actual');
        $nuevaContrasena = $request->input('nueva_contrasena');
        $confirmarContrasena = $request->input('confirmar_contrasena');

        // Validaciones de las contraseñas
        $request->validate([
            'contrasena_actual' => 'required',
            'nueva_contrasena' => 'required|min:8|max:20|different:contrasena_actual',
            'confirmar_contrasena' => 'required|same:nueva_contrasena',
        ]);

        // Buscar el usuario en la base de datos
        $user = DB::table('pfp_schema.tbl_usuario')
                    ->where('usuario', $usuario)
                    ->first();

        // Verificar que el usuario exista y que la contraseña actual coincida
        if (!$user || $user->contrasena !== $contrasenaActual) {
            return redirect()->back()->withErrors(['contrasena_actual' => 'La contraseña actual es incorrecta.']);
        }

        // Validar que la nueva contraseña y su confirmación coincidan
        if ($nuevaContrasena !== $confirmarContrasena) {
            return redirect()->back()->withErrors(['confirmar_contrasena' => 'La confirmación de la contraseña no coincide.']);
        }

        // Actualizar la nueva contraseña en la base de datos
        DB::table('pfp_schema.tbl_usuario')
            ->where('id_usuario', $user->id_usuario)
            ->update([
                'contrasena' => $nuevaContrasena, // Guardando en texto plano
                'fecha_modificacion' => now(),   // Cambiar fecha de modificación
            ]);

        // Redirigir a la vista de AdministrarPerfil con un mensaje de éxito
        return redirect()->route('AdministrarPerfil')->with('success', 'Contraseña actualizada exitosamente.');
    }
}
