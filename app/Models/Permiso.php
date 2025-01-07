<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Permiso extends Model
{
    use HasFactory;

    protected $table = 'pfp_schema.tbl_permiso';

    // Definir la clave primaria si no sigue la convención predeterminada
    protected $primaryKey = 'id_permiso';

    // Desactivar timestamps si no los necesitas en la base de datos
    public $timestamps = false;

    // Definir los campos que se asignarán masivamente
    protected $fillable = [
        'id_rol',
        'id_objeto',
        'permiso_creacion',
        'permiso_actualizacion',
        'permiso_eliminacion',
        'permiso_consultar',
        'id_estado',
        'fecha_creacion',
        'creado_por',
        'fecha_modificacion',
        'modificado_por'
    ];
}
