<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PacientesController extends Controller
{

    public function index()
    {
        $response = Http::get(env('API_URL', 'http://localhost:3002').'/get_pacientes');
        $facturas = Http::get(env('API_URL', 'http://localhost:3002').'/get_facturas');
        $productos = Http::get(env('API_URL', 'http://localhost:3002').'/get_producto');
        $tabla_estado = Http::get(env('API_URL', 'http://localhost:3002').'/estados');
        $tabla_rol = Http::get(env('API_URL', 'http://localhost:3002').'/get_usuarios');

        // Obtener longitud máxima del DNI desde tbl_parametro
        $dniLength = DB::table('pfp_schema.tbl_parametro')
            ->where('id_parametro', 5)
            ->value('valor');

        // Obtener longitud máxima del celular desde tbl_parametro
        $celularLength = DB::table('pfp_schema.tbl_parametro')
            ->where('id_parametro', 8)
            ->value('valor');

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
                ->where('id_objeto', 15) // ID del objeto "especialidad"
                ->first();

          // Si se encuentran permisos para este rol y objeto, asignarlos
          if ($permisos) {
           $permiso_insercion = $permisos->permiso_creacion;
           $permiso_actualizacion = $permisos->permiso_actualizacion;
           $permiso_eliminacion = $permisos->permiso_eliminacion;
        }
    }

        return view('modulo_operaciones.Pacientes')->with([
            'facturas' => json_decode($facturas, true),
            'tblusuario' => json_decode($tabla_rol, true),
            'tblestado' => json_decode($tabla_estado, true),
            'Pacientes' => json_decode($response, true),
            'productos' => json_decode($productos, true),
            'permiso_insercion' => $permiso_insercion,
            'permiso_actualizacion' => $permiso_actualizacion,
            'permiso_eliminacion' => $permiso_eliminacion,
            'dniLength' => $dniLength, // Pasar la longitud del DNI a la vista
            'celularLength' => $celularLength, // Pasar la longitud del celular a la vista
        ]);
    }



    public function store(Request $request)
    {
        // Obtener longitud máxima del DNI desde tbl_parametro
        $dniLength = DB::table('pfp_schema.tbl_parametro')
            ->where('id_parametro', 5)
            ->value('valor');

        // Obtener el patrón de email desde tbl_parametro
        $emailPattern = DB::table('pfp_schema.tbl_parametro')
            ->where('id_parametro', 7)
            ->value('valor');

        // Obtener longitud máxima del celular desde tbl_parametro
        $celularLength = DB::table('pfp_schema.tbl_parametro')
            ->where('id_parametro', 8)
            ->value('valor');

        //validar duplicados y agregar regla para DNI numérico y longitud específica
        $validatedData = $request->validate([
            'dni' => [
                'required',
                'string',
                'max:255',
                "regex:/^[0-9]{1,{$dniLength}}$/", // Solo números, longitud máxima según tbl_parametro
                function ($attribute, $value, $fail) use ($dniLength) {
                    if (strlen($value) < $dniLength) {
                        $fail("El DNI debe tener exactamente {$dniLength} caracteres.");
                    }
                    if (DB::table('pfp_schema.tbl_paciente')->where('dni_paciente', $value)->exists()) {
                        $fail('El DNI ya está registrado en el sistema.');
                    }
                },
            ],
            'email' => [
                'required',
                'email',
                'max:255',
                "regex:/{$emailPattern}/", // Usar el patrón de tbl_parametro
                function ($attribute, $value, $fail) use ($emailPattern) {
                    if (!preg_match("/{$emailPattern}/", $value)) {
                        $fail('El formato del correo electrónico es incorrecto. Debe seguir el patrón: ejemplo@dominio.com');
                    }
                    if (DB::table('pfp_schema.tbl_paciente')->where('email', $value)->exists()) {
                        $fail('El correo electrónico ya está registrado en el sistema.');
                    }
                },
            ],
            'celular' => [
                'required',
                'string',
                "regex:/^[0-9]{1,{$celularLength}}$/", // Solo números, longitud exacta según tbl_parametro
                function ($attribute, $value, $fail) use ($celularLength) {
                    if (strlen($value) != $celularLength) {
                        $fail("El número de celular debe tener exactamente {$celularLength} caracteres.");
                    }
                    if (DB::table('pfp_schema.tbl_paciente')->where('celular', $value)->exists()) {
                        $fail('El número de celular ya está registrado en el sistema.');
                    }
                },
            ],
            'genero' => [
                'required',
                'string',
                'max:1',
                'regex:/^[MFX]$/', // Solo permite M, F o X
                function ($attribute, $value, $fail) {
                    if (!in_array($value, ['M', 'F', 'X'])) {
                        $fail('El género debe ser "M" (Masculino), "F" (Femenino) o "X" (Prefiere no especificar).');
                    }
                },
            ],
        ]);


        $response = Http::post(env('API_URL', 'http://localhost:3002').'/insert_paciente', [
            'dni_paciente' => $request->get('dni'),
            'nombre_paciente' => $request->get('nombre'),
            'apellido_paciente' => $request->get('apellido'),
            'fecha_nacimiento' => $request->get('nacimiento'),
            'email' => $request->get('email'),
            'direccion' => $request->get('direccion'),
            'celular' => $request->get('celular'),
            'tratamiento_medico' => $request->get('tratamiento'),
            'id_usuario' => $request->get('usuario'),
            'id_estado' => $request->get('estdo'),
            'genero' => $request->get('genero'),


        ]);

        //VALIDACION DE DUPLICADOS
        $validatedData = $request->validate([
            'dni_paciente' => [
                'required',
                'string',
                'max:255',
                'unique:pfp_schema.tbl_paciente,dni_paciente,email,celular' // Verifica unicidad en la tabla y columna específicas
            ],
            // Agrega aquí otras validaciones necesarias
        ]);

        return redirect('Pacientes');

    }

    public function update(Request $request)
    {
        // Obtener longitud máxima del DNI desde tbl_parametro
        $dniLength = DB::table('pfp_schema.tbl_parametro')
            ->where('id_parametro', 5)
            ->value('valor');

        // Obtener el patrón de email desde tbl_parametro
        $emailPattern = DB::table('pfp_schema.tbl_parametro')
            ->where('id_parametro', 7)
            ->value('valor');

        // Obtener longitud máxima del celular desde tbl_parametro
        $celularLength = DB::table('pfp_schema.tbl_parametro')
            ->where('id_parametro', 8)
            ->value('valor');

        // Validar el DNI y email en la actualización
        $validatedData = $request->validate([
            'dni' => [
                'required',
                'string',
                'max:255',
                "regex:/^[0-9]{1,{$dniLength}}$/", // Solo números, longitud máxima según tbl_parametro
                function ($attribute, $value, $fail) use ($dniLength) {
                    if (strlen($value) < $dniLength) {
                        $fail("El DNI debe tener exactamente {$dniLength} caracteres.");
                    }
                },
            ],
            'email' => [
                'required',
                'email',
                'max:255',
                "regex:/{$emailPattern}/", // Usar el patrón de tbl_parametro
                function ($attribute, $value, $fail) use ($emailPattern) {
                    if (!preg_match("/{$emailPattern}/", $value)) {
                        $fail('El formato del correo electrónico es incorrecto. Debe seguir el patrón: ejemplo@dominio.com');
                    }
                },
            ],
            'celular' => [
                'required',
                'string',
                "regex:/^[0-9]{1,{$celularLength}}$/", // Solo números, longitud exacta según tbl_parametro
                function ($attribute, $value, $fail) use ($celularLength) {
                    if (strlen($value) != $celularLength) {
                        $fail("El número de celular debe tener exactamente {$celularLength} caracteres.");
                    }
                },
            ],
            'genero' => [
                'required',
                'string',
                'max:1',
                'regex:/^[MFX]$/', // Solo permite M, F o X
                function ($attribute, $value, $fail) {
                    if (!in_array($value, ['M', 'F', 'X'])) {
                        $fail('El género debe ser "M" (Masculino), "F" (Femenino) o "X" (Prefiere no especificar).');
                    }
                },
            ],
        ]);

        $response = Http::put(env('API_URL', 'http://localhost:3002').'/update_paciente', [
            'id_paciente' => $request->get('cod'),
            'dni_paciente' => $request->get('dni'),
            'nombre_paciente' => $request->get('nombre'),
            'apellido_paciente' => $request->get('apellido'),
            'fecha_nacimiento' => $request->get('nacimiento'),
            'email' => $request->get('email'),
            'direccion' => $request->get('direccion'),
            'celular' => $request->get('celular'),
            'tratamiento_medico' => $request->get('tratamiento'),
            'id_usuario' => $request->get('usuario'),
            'id_estado' => $request->get('estdo'),
            'genero' => $request->get('genero')


        ]);

        return redirect('Pacientes');

    }

}