<?php
namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\File;

class AdministrarPerfilController extends Controller
{
    public function index()
    {

        $user = Auth::user();
        return view('modulo_usuarios.AdministrarPerfil', compact('user'));

    }

    public function update(Request $request)
    {
        $response = Http::put('http://localhost:3000/update_usuario', [
            'id_usuario'     => $request->get('id_usuario'),
            'nombre_usuario' => $request->get('nombre_usuario'),
            'contraseña'     => $request->get('contraseña'),
            'id_rol'         => $request->get('id_rol'),
            'email'          => $request->get('email'),
            'primer_ingreso' => $request->get('primer_ingreso'),
            'id_estado'      => $request->get('id_estado'),
        ]);

        $imagen = $request->file('profile_image');

        if ( !$imagen ) {
            return redirect()->back()->with('mensaje', 'Datos actualizados correctamente');
        }

        $nombreImagen = 'Foto_perfil.png';

        $directorio = public_path('dist/img');

        $rutaImagenExistente = $directorio . '/' . $nombreImagen;
        if (File::exists($rutaImagenExistente)) {
            File::delete($rutaImagenExistente);
        }

        $imagen->move($directorio, $nombreImagen);

        return redirect()->back()->with('mensaje', 'Datos actualizados correctamente');
    }

    public function changePassword(Request $request)
    {
        $response = Http::put('http://localhost:3000/update_usuario', [
            'id_usuario'     => $request->get('id_usuario'),
            'nombre_usuario' => $request->get('nombre_usuario'),
            'contraseña'     => $request->get('contraseña'),
            'id_rol'         => $request->get('id_rol'),
            'email'          => $request->get('email'),
            'primer_ingreso' => $request->get('primer_ingreso'),
            'id_estado'      => $request->get('id_estado'),
        ]);

        return redirect()->back()->with('mensaje', 'Contraseña actualizada correctamente');
    }


    public function updateImagen(Request $request)
    {
        // Lógica para actualizar la imagen de perfil
        // Ejemplo: Guardar la imagen en storage y actualizar el campo en la base de datos
    }

    public function CambiarContrasena()
    {
        return view('CambiarContrasena');  // Muestra la página para cambiar la contraseña
    }
}
