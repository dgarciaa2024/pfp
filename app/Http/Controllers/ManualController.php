<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class ManualController extends Controller
{
    // Mostrar el Manual Técnico
    public function tecnico()
    {
        // Valor por defecto para el manual técnico (ajusta el enlace si es necesario)
        $enlaceCompleto = 'https://drive.google.com/file/d/default-tecnico/preview';

        try {
            // Consultar el valor del id_parametro = 9 para el manual técnico
            $parametro = DB::table('pfp_schema.tbl_parametro')
                           ->where('id_parametro', 9)
                           ->first();

            // Log para depuración
            Log::info('Consulta para manual técnico:', [
                'parametro' => $parametro,
                'valor' => $parametro ? $parametro->valor : 'No encontrado'
            ]);

            // Si se encuentra un valor válido, usarlo
            if ($parametro && !empty(trim($parametro->valor))) {
                $enlaceCompleto = trim($parametro->valor);
                Log::info('Enlace asignado para manual técnico:', ['enlaceCompleto' => $enlaceCompleto]);
            } else {
                Log::warning('No se encontró el parámetro o el valor está vacío para manual técnico, usando enlace por defecto');
            }
        } catch (\Exception $e) {
            Log::error('Error al consultar la BD para manual técnico:', ['exception' => $e->getMessage()]);
        }

        // Pasar el enlace a la vista
        return view('manual_tecnico', compact('enlaceCompleto'));
    }

    // Mostrar el Manual de Usuario
    public function usuario()
    {
        // Valor por defecto para el manual de usuario (ajusta el enlace si es necesario)
        $enlaceCompleto = 'https://drive.google.com/file/d/default-usuario/preview';

        try {
            // Consultar el valor del id_parametro = 10 para el manual de usuario (ajusta el ID si es diferente)
            $parametro = DB::table('pfp_schema.tbl_parametro')
                           ->where('id_parametro', 10)
                           ->first();

            // Log para depuración
            Log::info('Consulta para manual de usuario:', [
                'parametro' => $parametro,
                'valor' => $parametro ? $parametro->valor : 'No encontrado'
            ]);

            // Si se encuentra un valor válido, usarlo
            if ($parametro && !empty(trim($parametro->valor))) {
                $enlaceCompleto = trim($parametro->valor);
                Log::info('Enlace asignado para manual de usuario:', ['enlaceCompleto' => $enlaceCompleto]);
            } else {
                Log::warning('No se encontró el parámetro o el valor está vacío para manual de usuario, usando enlace por defecto');
            }
        } catch (\Exception $e) {
            Log::error('Error al consultar la BD para manual de usuario:', ['exception' => $e->getMessage()]);
        }

        // Pasar el enlace a la vista
        return view('manual_usuario', compact('enlaceCompleto'));
    }

    // Mostrar el Manual de Instalación
    public function instalacion()
    {
        // Enlace por defecto que sabemos que funciona
        $enlaceCompleto = 'https://drive.google.com/file/d/11wF_AchnRYYJa4van5AVBIo1Q-9V6StB/preview';

        try {
            // Consultar el valor del id_parametro = 11 para el manual de instalación
            $parametro = DB::table('pfp_schema.tbl_parametro')
                           ->where('id_parametro', 11)
                           ->first();

            // Log para depuración
            Log::info('Consulta para manual de instalación:', [
                'parametro' => $parametro,
                'valor' => $parametro ? $parametro->valor : 'No encontrado'
            ]);

            // Si se encuentra un valor válido, usarlo
            if ($parametro && !empty(trim($parametro->valor))) {
                $enlaceCompleto = trim($parametro->valor);
                Log::info('Enlace asignado para manual de instalación:', ['enlaceCompleto' => $enlaceCompleto]);
            } else {
                Log::warning('No se encontró el parámetro o el valor está vacío para manual de instalación, usando enlace por defecto');
            }
        } catch (\Exception $e) {
            Log::error('Error al consultar la BD para manual de instalación:', ['exception' => $e->getMessage()]);
        }

        // Pasar el enlace a la vista
        return view('manual_instalacion', compact('enlaceCompleto'));
    }
}