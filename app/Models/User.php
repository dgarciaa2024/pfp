<?php

namespace App\Models;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Support\Facades\DB;
use Exception;

class User extends Authenticatable
{
    use HasFactory, Notifiable;

    // Definir el nombre correcto de la tabla
    protected $table = 'pfp_schema.tbl_usuario';

    protected $primaryKey = 'id_usuario'; // Definir 'id_usuario' como clave primaria

    /**
     * Los atributos que se pueden asignar masivamente.
     */
    protected $fillable = [
        'usuario', 
        'email', 
        'nombre_usuario', 
        'contrasena', 
        'fecha_vencimiento', 
        'creado_por', 
        'modificado_por',
        'primer_ingreso', 
        'preguntas_contestadas', 
        'id_rol',
        'id_estado',
    ];

    /**
     * Los atributos que deben estar ocultos en las serializaciones.
     */
    protected $hidden = [
        'contrasena',
    ];

    /**
     * Los atributos que deben ser convertidos a tipos nativos.
     */
    protected $casts = [
        'primer_ingreso' => 'integer',
        // Retira 'contrasena' => 'hashed' para que no se maneje como hash
    ];

    /**
     * Recuperar la contrasena para la autenticación.
     * Laravel usará este método para obtener la contrasena del usuario.
     */
    public function getAuthPassword()
    {
        return $this->contrasena;
    }

    /**
     * Método para crear un nuevo usuario asegurando que se asigna un id_rol válido.
     */
    public static function createUser(array $data)
    {
        $rol = DB::table('tbl_rol')->get();

        if ($rol->isNotEmpty()) {
            $firstRole = $rol->first();
            $id_rol = $firstRole->id_rol;
        } else {
            throw new Exception('No hay roles disponibles.');
        }

        return self::create([
            'usuario' => $data['usuario'],
            'email' => $data['email'],
            'nombre_usuario' => $data['nombre_usuario'],
            'contrasena' => $data['contrasena'], // Se guardará como texto plano
            'id_rol' => $id_rol, 
            'fecha_ultima_conexion' => $data['fecha_ultima_conexion'], 
            'fecha_vencimiento' => $data['fecha_vencimiento'], 
            'creado_por' => $data['creado_por'], 
            'modificado_por' => $data['modificado_por'], 
            'primer_ingreso' => $data['primer_ingreso'], 
            'preguntas_contestadas' => $data['preguntas_contestadas'], 
            'id_estado' => $data['id_estado'],
        ]);
    }
}
