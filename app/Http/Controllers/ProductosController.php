<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ProductosController extends Controller
{
  


    public function index()
    {
        $response = Http::get('http://localhost:3000/get_producto');
        $tabla_estado = Http::get('http://localhost:3000/estados');
        $tabla_farmaceutica = Http::get('http://localhost:3000/get_forma_farmaceutica');
        $tabla_especialidad = Http::get('http://localhost:3000/get_especialidad');
        $tabla_marca = Http::get('http://localhost:3000/get_marca_producto');
        $tabla_unidad = Http::get('http://localhost:3000/get_unidad_medida');
        $tabla_administracion = Http::get('http://localhost:3000/get_via_administracion');
        $tabla_laboratorio = Http::get('http://localhost:3000/get_laboratorios');
       
         // Manejo de sesión y permisos
         $usuario = session('usuario'); // Obtener usuario desde la sesión

         // Permisos predeterminados
         $permiso_insercion = 2;
         $permiso_actualizacion = 2;
         $permiso_eliminacion = 2;
 
         if ($usuario) {
             $idRolUsuario = $usuario['id_rol']; // Obtener el rol del usuario desde la sesión
 
             // Consultar permisos en la base de datos para el rol y objeto 5 (productos)
             $permisos = DB::table('pfp_schema.tbl_permiso')
                 ->where('id_rol', $idRolUsuario)
                 ->where('id_objeto', 14) // ID del objeto que corresponde a "productos"
                 ->first();
 
             // Si se encuentran permisos para este rol y objeto, asignarlos
             if ($permisos) {
                 $permiso_insercion = $permisos->permiso_creacion;
                 $permiso_actualizacion = $permisos->permiso_actualizacion;
                 $permiso_eliminacion = $permisos->permiso_eliminacion;
             }
         }
 
        
        
        return view('modulo_operaciones.Productos')->with([
        'tbllaboratorio'=> json_decode($tabla_laboratorio,true),
        'tblestado'=> json_decode($tabla_estado,true),
        'tbladministracion'=> json_decode($tabla_administracion,true),
        'tblunidad'=> json_decode($tabla_unidad,true),
        'tblmarca'=> json_decode($tabla_marca,true),
        'tblespecialidad'=> json_decode($tabla_especialidad,true),
        'tblfarmaseutica'=> json_decode($tabla_farmaceutica,true),
        'Productos'=> json_decode($response,true),
        'permiso_insercion' => $permiso_insercion,
        'permiso_actualizacion' => $permiso_actualizacion,
        'permiso_eliminacion' => $permiso_eliminacion,
    ]);
    }

    public function store(Request $request)
    {
        $response = Http::post('http://localhost:3000/insert_producto', [
            'codigo_barra' => $request->get('barra'),
            'nombre_producto' => $request->get('nombre'),
           'id_forma_farmaceutica' => $request->get('farma'),
            'id_especialidad' => $request->get('especialidad'),
            'id_marca_producto' => $request->get('marca'),
            'id_unidad_medida' => $request->get('unidad'),
            'id_via_administracion' => $request->get('via'),
             'id_estado' => $request->get('estdo'),
             'id_laboratorio' => $request->get('laboratorio'),
             'escala' => $request->get('escala'),
             'canje' => $request->get('canje'),
             'contenido_neto' => $request->get('neto'),
             'consumo_diario' => $request->get('consumo'),
             'consumo_max_anual' => $request->get('max'),
             'canjes_max_anual' => $request->get('canjemax'),

        ]);
  
 return redirect('Productos');
       
    }

    public function update(Request $request)
    {
        $response = Http::put('http://localhost:3000/update_producto', [
            'id_producto' => $request->get('cod'),
          'codigo_barra' => $request->get('barra'),
            'nombre_producto' => $request->get('nombre'),
           'id_forma_farmaceutica' => $request->get('farma'),
            'id_especialidad' => $request->get('especialidad'),
            'id_marca_producto' => $request->get('marca'),
            'id_unidad_medida' => $request->get('unidad'),
            'id_via_administracion' => $request->get('via'),
             'id_estado' => $request->get('estdo'),
             'id_laboratorio' => $request->get('laboratorio'),
             'escala' => $request->get('escala'),
             'canje' => $request->get('canje'),
             'contenido_neto' => $request->get('neto'),
             'consumo_diario' => $request->get('consumo'),
             'consumo_max_anual' => $request->get('max'),
             'canjes_max_anual' => $request->get('canjemax'),

            
        ]);

        return redirect('Productos');

    }





}