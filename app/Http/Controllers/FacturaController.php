<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class FacturaController extends Controller
{
    public function index()
    {
        $response = Http::get(env('API_URL', 'http://localhost:3002').'/get_facturas');
        $tabla_producto = Http::get(env('API_URL', 'http://localhost:3002').'/get_producto');
        $tabla_paciente = Http::get(env('API_URL', 'http://localhost:3002').'/get_pacientes');
        $canjes = Http::get(env('API_URL', 'http://localhost:3002').'/get_registro');
        $tabla_estadocanje = Http::get(env('API_URL', 'http://localhost:3002').'/get_estado_canje');
        $tabla_farmacia = Http::get(env('API_URL', 'http://localhost:3002').'/get_farmacias');
        $tabla_registro = Http::get(env('API_URL', 'http://localhost:3002').'/get_tipo_registro');
        $facturas = Http::get(env('API_URL', 'http://localhost:3002').'/get_facturas');


        // Manejo de sesión y permisos
        $usuario = session('usuario'); // Obtener usuario desde la sesión

        // Permisos predeterminados
        $permiso_insercion = 2;
        $permiso_actualizacion = 2;
        $permiso_eliminacion = 2;

        if ($usuario) {
            $idRolUsuario = $usuario['id_rol']; // Obtener el rol del usuario desde la sesión

            // Consultar permisos en la base de datos para el rol y objeto 1 (usuarios)
            $permisos = DB::table('pfp_schema.tbl_permiso')
                ->where('id_rol', $idRolUsuario)
                ->where('id_objeto', 17) // ID del objeto que corresponde a "Factura"
                ->first();

            // Si se encuentran permisos para este rol y objeto, asignarlos
            if ($permisos) {
                $permiso_insercion = $permisos->permiso_creacion;
                $permiso_actualizacion = $permisos->permiso_actualizacion;
                $permiso_eliminacion = $permisos->permiso_eliminacion;
            }
        }


        $activos = array_values(array_filter($tabla_producto->json(), function ($item) {
            return isset($item['estado']) && $item['estado'] === 'ACTIVO';
        }));

        $act = array_values(array_filter($tabla_paciente->json(), function ($item) {
            return isset($item['estado']) && $item['estado'] === 'ACTIVO';
        }));




        // Manejo de sesión y permisos
        $usuario = session('usuario'); // Obtener usuario desde la sesión

        // Permisos predeterminados
        $permiso_insercion = 2; // 2 es el valor predeterminado para sin permiso
        $permiso_edicion = 2;   // 2 es el valor predeterminado para sin permiso

        if ($usuario) {
            $idRolUsuario = $usuario['id_rol']; // Obtener el rol del usuario desde la sesión

            // Consultar permisos en la base de datos para el rol y objeto 9 (facturas)
            $permisos = DB::table('pfp_schema.tbl_permiso')
                ->where('id_rol', $idRolUsuario)
                ->where('id_objeto', 17) // ID del objeto que corresponde a "facturas"
                ->first();

            // Si se encuentran permisos para este rol y objeto, asignarlos
            if ($permisos) {
                $permiso_insercion = $permisos->permiso_creacion ?? 2;
                $permiso_edicion = $permisos->permiso_edicion ?? 2;
            }
        }


        return view('modulo_canjes.Facturas')->with([
            'canjeDirecto' => false,
            'tblestadocanje' => json_decode($tabla_estadocanje, true),
            'tblproducto' => $activos,
            'tblpaciente' => $act,
            'tblfarmacia' => json_decode($tabla_farmacia, true),
            'tblregistro' => json_decode($tabla_registro, true),
            'Canjes' => json_decode($canjes, true),
            'Facturas' => json_decode($facturas, true),
            'permiso_insercion' => $permiso_insercion,
            'permiso_actualizacion' => $permiso_actualizacion,
            'permiso_eliminacion' => $permiso_eliminacion,
        ]);
    }


    public function store(Request $request)
    {
        $canje_habilitado = $request->input('canjeHabilitado');
        $paciente = $request->input('paciente');
        $producto = $request->input('producto');
        $farmacia = $request->input('farmacia');
        $cantidad = $request->input('cantidadCanjes');
        $email = $request->input('email');
        $productoNombre = $request->input('productoNombre');
        $pacienteNombre = $request->input('pacienteNombre');
        $nombre_farmacia = $request->input('nombre_farmacia');
        $rtn_farmacia = $request->input('rtn_farmacia');
        $nombre_paciente = $request->input('nombre_paciente');
        $apellido_paciente = $request->input('apellido_paciente');
        $dni_paciente = $request->input('dni_paciente');
        $telefono_paciente = $request->input('telefono_paciente');
        $correo_paciente = $request->input('correo_paciente');
        $nombre_producto = $request->input('nombre_producto');
        $forma_farmaceutica = $request->input('forma_farmaceutica');
        $fecha_registro = $request->input('fecha_registro');
        $comentarios = $request->input('comentarios');
        $imagen = $request->file('factura');
        $numero = $request->input('numero');
        $imagenBase64 = base64_encode(file_get_contents($imagen->getRealPath()));
        $response = Http::attach('factura', file_get_contents($imagen->getPathname()), $imagen->getClientOriginalName())->post(env('API_URL', 'http://localhost:3002').'/insert_factura', [
            //'factura' => "data:image/{$imagen->getClientOriginalExtension()};base64,{$imagenBase64}",
            'numero' => $numero,
            'id_paciente' => $paciente,
            'id_producto' => $producto,
            'cantidad_producto' => $request->input('cantidad'),
        ]);

        // Verificar si el backend devuelve un mensaje de éxito o notificación
        if ($response->successful()) {
            if ($canje_habilitado === "true") {
                $data = [
                    'savedIdPaciente' => $paciente,
                    'savedIdProducto' => $producto,
                    'savedIdFarmacia' => $farmacia,
                    'savedCantidad' => $cantidad,
                    'email' => $email,
                    'numero' => $numero,
                    'productoNombre' => $productoNombre,
                    'pacienteNombre' => $pacienteNombre,
                    'nombre_farmacia' => $nombre_farmacia,
                    'rtn_farmacia' => $rtn_farmacia,
                    'nombre_paciente' => $nombre_paciente,
                    'apellido_paciente' => $apellido_paciente,
                    'dni_paciente' => $dni_paciente,
                    'telefono_paciente' => $telefono_paciente,
                    'correo_paciente' => $correo_paciente,
                    'nombre_producto' => $nombre_producto,
                    'forma_farmaceutica' => $forma_farmaceutica,
                    'fecha_registro' => $fecha_registro,
                    'comentarios' => $comentarios
                ];
                Storage::put('data.json', json_encode($data));
                $mensaje = "Factura ingresada exitosamente, usted esta habilitado para el canje del producto seleccionado";
                return redirect()->back()
                    ->with('canjeDirecto', true)
                    ->with('mensaje_canje_habilitado', $mensaje)
                    ->with('oldIdPaciente', $paciente)
                    ->with('oldIdProducto', $producto)
                    ->with('oldIdFarmacia', $farmacia)
                    ->with('oldCantidad', $cantidad)
                    ->with('email', $email)
                    ->with('numero', $numero)
                    ->with('productoNombre', $productoNombre)
                    ->with('pacienteNombre', $pacienteNombre)
                    ->with('nombre_farmacia', $nombre_farmacia)
                    ->with('rtn_farmacia', $rtn_farmacia)
                    ->with('nombre_paciente', $nombre_paciente)
                    ->with('apellido_paciente', $apellido_paciente)
                    ->with('dni_paciente', $dni_paciente)
                    ->with('telefono_paciente', $telefono_paciente)
                    ->with('correo_paciente', $correo_paciente)
                    ->with('nombre_producto', $nombre_producto)
                    ->with('forma_farmaceutica', $forma_farmaceutica)
                    ->with('fecha_registro', $fecha_registro)
                    ->with('comentarios', $comentarios);
            } else {
                $mensaje = "Factura ingresada exitosamente";
                return redirect()->back()->with('status_message', $mensaje);
            }
        } else {
            return redirect()->back()->with('status_message', $response->body());
        }
    }

}





