<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;


class FormaFarmaceuticaController extends Controller
{
    

    public function index()
    {
        $response = Http::get(env('API_URL', 'http://localhost:3002').'/get_forma_farmaceutica');
        $tabla_estado = Http::get(env('API_URL', 'http://localhost:3002').'/estados');

        $usuario = session('usuario'); // Obtener usuario desde la sesión

        // Permisos predeterminados
        $permiso_insercion = 2;
        $permiso_actualizacion = 2;
        $permiso_eliminacion = 2;
        $permiso_consultar = 0; // Permiso de consulta predeterminado en 0


        if ($usuario) {
            $idRolUsuario = $usuario['id_rol']; // Obtener el rol del usuario desde la sesión

            // Consultar permisos en la base de datos para el rol y objeto 1 (usuarios)
            $permisos = DB::table('pfp_schema.tbl_permiso')
                ->where('id_rol', $idRolUsuario)
                ->where('id_objeto', 20) // ID del objeto que corresponde a "forma farmacéutica"
                ->first();

            // Si se encuentran permisos para este rol y objeto, asignarlos
            if ($permisos) {
                $permiso_insercion = $permisos->permiso_creacion;
                $permiso_actualizacion = $permisos->permiso_actualizacion;
                $permiso_eliminacion = $permisos->permiso_eliminacion;
                $permiso_consultar = $permisos->permiso_consultar ?? 0; // Asignar 0 si es nulo
            }

            // Verificar si el usuario tiene permiso de consulta
            if ($permiso_consultar != 1) {
                return view('errors.403');
            }
        } else {
            // Si no hay usuario en sesión, redirigir a la vista de sin permiso
            return view('errors.403');
        }


        return view('modulo_mantenimiento.FormaFarmaceutica')->with([
            'tblestado' => json_decode($tabla_estado, true),
            'FormaFarma' => json_decode($response, true),
            'permiso_insercion' => $permiso_insercion,
            'permiso_actualizacion' => $permiso_actualizacion,
            'permiso_eliminacion' => $permiso_eliminacion,
        ]);
    }

    
    public function store(Request $request)
    {
        $response = Http::post(env('API_URL', 'http://localhost:3002').'/insert_forma_farmaceutica', [
             'forma_farmaceutica' => $request->get('farma'),
             'id_estado' => $request->get('estdo')

        ]);
  
 
 if ($response->successful()) {
    return redirect('FormaFarmaceutica')->with('success', true);
} else {
    return redirect()->back()->with('error', 'Error al realizar la operación.');
}   
    }

       
    


    
    public function update(Request $request)
    {
        $response = Http::put(env('API_URL', 'http://localhost:3002').'/update_forma_farmaceutica', [
            'id_forma_farmaceutica' => $request->get('cod'),
            'forma_farmaceutica' => $request->get('farma'),
            'id_estado' => $request->get('estdo'),
            
        ]);

        if ($response->successful()) {
            return redirect('FormaFarmaceutica')->with('success', true);
        } else {
            return redirect()->back()->with('error', 'Error al realizar la operación.');
        }   
            }
        
    }