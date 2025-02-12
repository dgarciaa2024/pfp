<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Bitacora extends Model
{
    protected $table = 'pfp_schema.tbl_bitacora';
    protected $primaryKey = 'id_bitacora';
    protected $fillable = ['fecha', 'id_usuario', 'id_objeto', 'accion', 'descripcion'];

    // Relación con el modelo User
    public function usuario()
    {
        return $this->belongsTo(User::class, 'id_usuario', 'id_usuario');
    }
}
