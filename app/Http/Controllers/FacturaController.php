<?php
namespace App\Http\Controllers;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Log;

class FacturaController extends Controller
{
    public function index(Request $request)
    {
        // Realizar las peticiones HTTP
        $response = Http::get(env('API_URL', 'http://localhost:3002') . '/get_facturas');
        $tabla_producto = Http::get(env('API_URL', 'http://localhost:3002') . '/get_producto');
        $tabla_paciente = Http::get(env('API_URL', 'http://localhost:3002') . '/get_pacientes');
        $canjes = Http::get(env('API_URL', 'http://localhost:3002') . '/get_registro');
        $tabla_estadocanje = Http::get(env('API_URL', 'http://localhost:3002') . '/get_estado_canje');
        $tabla_farmacia = Http::get(env('API_URL', 'http://localhost:3002') . '/get_farmacias');
        $tabla_registro = Http::get(env('API_URL', 'http://localhost:3002') . '/get_tipo_registro');
        $facturas = Http::get(env('API_URL', 'http://localhost:3002') . '/get_facturas');

        // Manejo de sesión y permisos
        $usuario = session('usuario');
        $permiso_insercion = 2;
        $permiso_actualizacion = 2;
        $permiso_eliminacion = 2;

        if ($usuario && isset($usuario['id_rol'])) {
            $idRolUsuario = $usuario['id_rol'];
            $permisos = DB::table('pfp_schema.tbl_permiso')
                ->where('id_rol', $idRolUsuario)
                ->where('id_objeto', 17)
                ->first();

            if ($permisos) {
                $permiso_insercion = $permisos->permiso_creacion ?? 2;
                $permiso_actualizacion = $permisos->permiso_actualizacion ?? 2;
                $permiso_eliminacion = $permisos->permiso_eliminacion ?? 2;
            }
        }

        // Validar y decodificar respuestas de las APIs
        $facturasArray = $facturas->successful() && is_array($facturas->json()) ? $facturas->json() : [];
        $productosArray = $tabla_producto->successful() && is_array($tabla_producto->json()) ? $tabla_producto->json() : [];
        $pacientesArray = $tabla_paciente->successful() && is_array($tabla_paciente->json()) ? $tabla_paciente->json() : [];
        $canjesArray = $canjes->successful() && is_array($canjes->json()) ? $canjes->json() : [];
        $estadoCanjeArray = $tabla_estadocanje->successful() && is_array($tabla_estadocanje->json()) ? $tabla_estadocanje->json() : [];
        $farmaciasArray = $tabla_farmacia->successful() && is_array($tabla_farmacia->json()) ? $tabla_farmacia->json() : [];
        $registroArray = $tabla_registro->successful() && is_array($tabla_registro->json()) ? $tabla_registro->json() : [];

        // Filtrar productos y pacientes activos con validación
        $activos = array_values(array_filter($productosArray, function ($item) {
            return is_array($item) && isset($item['estado']) && $item['estado'] === 'ACTIVO';
        }));

        $act = array_values(array_filter($pacientesArray, function ($item) {
            return is_array($item) && isset($item['estado']) && $item['estado'] === 'ACTIVO';
        }));

        // Filtros de fecha
        $desde = $request->input('desde');
        $hasta = $request->input('hasta');
        $facturasFiltradas = $facturasArray;

        if ($desde && $hasta) {
            $facturasFiltradas = array_filter($facturasFiltradas, function ($factura) use ($desde, $hasta) {
                return is_array($factura) && isset($factura['fecha_creacion']) && 
                       \Carbon\Carbon::parse($factura['fecha_creacion'])->format('Y-m-d') >= $desde && 
                       \Carbon\Carbon::parse($factura['fecha_creacion'])->format('Y-m-d') <= $hasta;
            });
        }

        return view('modulo_canjes.Facturas')->with([
            'canjeDirecto' => false,
            'tblestadocanje' => $estadoCanjeArray,
            'tblproducto' => $activos,
            'tblpaciente' => $act,
            'tblfarmacia' => $farmaciasArray,
            'tblregistro' => $registroArray,
            'Canjes' => $canjesArray,
            'Facturas' => $facturasArray,
            'FacturasFiltradas' => array_values($facturasFiltradas),
            'permiso_insercion' => $permiso_insercion,
            'permiso_actualizacion' => $permiso_actualizacion,
            'permiso_eliminacion' => $permiso_eliminacion,
            'desde' => $desde,
            'hasta' => $hasta,
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

        if ($imagen) {
            $imagenBase64 = base64_encode(file_get_contents($imagen->getRealPath()));
            $response = Http::attach('factura', file_get_contents($imagen->getPathname()), $imagen->getClientOriginalName())->post(env('API_URL', 'http://localhost:3002') . '/insert_factura', [
                'numero' => $numero,
                'id_paciente' => $paciente,
                'id_producto' => $producto,
                'cantidad_producto' => $request->input('cantidad'),
            ]);

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
                    $mensaje = "Factura ingresada exitosamente, usted está habilitado para el canje del producto seleccionado";
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
        } else {
            return redirect()->back()->with('status_message', 'No se proporcionó una imagen válida.');
        }
    }

    public function exportToExcel(Request $request)
    {
        $facturas = json_decode($request->input('facturas', '[]'), true);
        $desde = $request->input('desde');
        $hasta = $request->input('hasta');

        if (empty($facturas) || !$desde || !$hasta) {
            return redirect()->back()->with('status_message', 'No hay datos para exportar o faltan fechas.');
        }

        $filename = "Facturas_{$desde}_al_{$hasta}.xls";
        header("Content-Type: application/vnd.ms-excel");
        header("Content-Disposition: attachment; filename=\"$filename\"");

        echo "Número\tFactura\tDNI Paciente\tNombre Paciente\tNombre Producto\tCantidad Producto\tFecha\n";
        foreach ($facturas as $factura) {
            if (!is_array($factura)) continue;
            $fecha = isset($factura['fecha_creacion']) ? \Carbon\Carbon::parse($factura['fecha_creacion'])->format('Y-m-d') : '';
            if ($desde && $hasta && ($fecha < $desde || $fecha > $hasta)) {
                continue;
            }
            $numero = $factura['numero_factura'] ?? '';
            $facturaImg = $factura['factura'] ?? '';
            $dni = $factura['dni_paciente'] ?? '';
            $nombre = ($factura['nombre_paciente'] ?? '') . ' ' . ($factura['apellido_paciente'] ?? '');
            $producto = $factura['nombre_producto'] ?? '';
            $cantidad = $factura['cantidad_producto'] ?? '';
            echo "$numero\t$facturaImg\t$dni\t$nombre\t$producto\t$cantidad\t$fecha\n";
        }
        exit;
    }

    public function exportToPdf(Request $request)
    {
        Log::info('ExportToPdf called', $request->all());

        $facturas = json_decode($request->input('facturas', '[]'), true);
        $desde = $request->input('desde');
        $hasta = $request->input('hasta');

        if (empty($facturas) || !$desde || !$hasta) {
            Log::warning('Datos incompletos para exportar a PDF', ['facturas' => $facturas, 'desde' => $desde, 'hasta' => $hasta]);
            return redirect()->back()->with('status_message', 'No hay datos para exportar o faltan fechas.');
        }

        // Contenido del PDF con encabezado, logo y paginación
        $pdfContent = "<!DOCTYPE html><html><head><style>";
        $pdfContent .= "body { font-family: Arial, sans-serif; margin: 20px; }";
        $pdfContent .= "table { border-collapse: collapse; width: 100%; }";
        $pdfContent .= "th, td { border: 1px solid black; padding: 8px; text-align: left; font-size: 12px; }";
        $pdfContent .= "th { background-color: #f2f2f2; }";
        $pdfContent .= ".header { display: flex; align-items: center; margin-bottom: 20px; }";
        $pdfContent .= ".header img { width: 100px; margin-right: 20px; }";
        $pdfContent .= ".header h1 { font-size: 20px; text-align: center; flex-grow: 1; }";
        $pdfContent .= ".footer { text-align: center; margin-top: 10px; font-size: 10px; }";
        $pdfContent .= "</style></head><body>";

        // Variables para paginación
        $itemsPerPage = 14;
        $page = 1;
        $itemCount = 0;
        $totalItems = count(array_filter($facturas, function ($factura) use ($desde, $hasta) {
            if (!is_array($factura)) return false;
            $fecha = isset($factura['fecha_creacion']) ? \Carbon\Carbon::parse($factura['fecha_creacion'])->format('Y-m-d') : '';
            return $fecha >= $desde && $fecha <= $hasta;
        }));
        $totalPages = ceil($totalItems / $itemsPerPage);

        foreach ($facturas as $factura) {
            if (!is_array($factura)) continue;
            $fecha = isset($factura['fecha_creacion']) ? \Carbon\Carbon::parse($factura['fecha_creacion'])->format('Y-m-d') : '';
            if ($desde && $hasta && ($fecha < $desde || $fecha > $hasta)) {
                continue;
            }

            if ($itemCount == 0) {
                $pdfContent .= "<div class='header'>";
                $pdfContent .= "<img src='" . public_path('dist/img/Foto_perfil.png') . "' alt='AdminLTE Logo' class='brand-image img-circle elevation-3' style='opacity: .8; border-radius: 50%; width: 100px; height: 100px;'>";
                $pdfContent .= "<h1>LISTA DE FACTURAS DE PRODUCTOS CANJEABLES</h1>";
                $pdfContent .= "</div>";
                $pdfContent .= "<p>Fechas: Desde $desde hasta $hasta</p>";
                $pdfContent .= "<table><tr><th>Número</th><th>DNI Paciente</th><th>Nombre Paciente</th><th>Nombre Producto</th><th>Cantidad</th><th>Fecha</th></tr>";
            }

            $numero = $factura['numero_factura'] ?? 'N/A';
            $dni = $factura['dni_paciente'] ?? 'N/A';
            $nombre = ($factura['nombre_paciente'] ?? '') . ' ' . ($factura['apellido_paciente'] ?? '');
            $producto = $factura['nombre_producto'] ?? 'N/A';
            $cantidad = $factura['cantidad_producto'] ?? 'N/A';
            $pdfContent .= "<tr><td>$numero</td><td>$dni</td><td>$nombre</td><td>$producto</td><td>$cantidad</td><td>$fecha</td></tr>";

            $itemCount++;

            if ($itemCount >= $itemsPerPage) {
                $pdfContent .= "</table>";
                $pdfContent .= "<div class='footer'>Página $page de $totalPages</div>";
                $pdfContent .= "<div style='page-break-before: always;'></div>";
                $page++;
                $itemCount = 0;
            }
        }

        if ($itemCount > 0) {
            $pdfContent .= "</table>";
            $pdfContent .= "<div class='footer'>Página $page de $totalPages</div>";
        }

        $pdfContent .= "</body></html>";

        try {
            $pdf = \Barryvdh\DomPDF\Facade\Pdf::loadHTML($pdfContent)->setPaper('letter', 'portrait');
            return $pdf->download("Facturas_{$desde}_al_{$hasta}.pdf");
        } catch (\Exception $e) {
            Log::error('Error al generar PDF', ['message' => $e->getMessage()]);
            return redirect()->back()->with('status_message', 'Error al generar el PDF: ' . $e->getMessage());
        }
    }

    public function print(Request $request)
    {
        $facturas = json_decode($request->input('facturas', '[]'), true);
        $desde = $request->input('desde');
        $hasta = $request->input('hasta');

        if (empty($facturas) || !$desde || !$hasta) {
            return redirect()->back()->with('status_message', 'No hay datos para imprimir o faltan fechas.');
        }

        // Contenido HTML para impresión con el mismo formato que el PDF
        $htmlContent = "<!DOCTYPE html><html><head><style>";
        $htmlContent .= "body { font-family: Arial, sans-serif; margin: 20px; }";
        $htmlContent .= "table { border-collapse: collapse; width: 100%; }";
        $htmlContent .= "th, td { border: 1px solid black; padding: 8px; text-align: left; font-size: 12px; }";
        $htmlContent .= "th { background-color: #f2f2f2; }";
        $htmlContent .= ".header { display: flex; align-items: center; margin-bottom: 20px; }";
        $htmlContent .= ".header img { width: 100px; margin-right: 20px; }";
        $htmlContent .= ".header h1 { font-size: 20px; text-align: center; flex-grow: 1; }";
        $htmlContent .= ".footer { text-align: center; margin-top: 10px; font-size: 10px; }";
        $htmlContent .= "@media print { .page-break { page-break-before: always; } }";
        $htmlContent .= "</style></head><body>";

        // Variables para paginación
        $itemsPerPage = 20;
        $page = 1;
        $itemCount = 0;
        $totalItems = count(array_filter($facturas, function ($factura) use ($desde, $hasta) {
            if (!is_array($factura)) return false;
            $fecha = isset($factura['fecha_creacion']) ? \Carbon\Carbon::parse($factura['fecha_creacion'])->format('Y-m-d') : '';
            return $fecha >= $desde && $fecha <= $hasta;
        }));
        $totalPages = ceil($totalItems / $itemsPerPage);

        foreach ($facturas as $factura) {
            if (!is_array($factura)) continue;
            $fecha = isset($factura['fecha_creacion']) ? \Carbon\Carbon::parse($factura['fecha_creacion'])->format('Y-m-d') : '';
            if ($desde && $hasta && ($fecha < $desde || $fecha > $hasta)) {
                continue;
            }

            if ($itemCount == 0) {
                $htmlContent .= "<div class='header'>";
                $htmlContent .= "<img src='" . public_path('dist/img/Foto_perfil.png') . "' alt='AdminLTE Logo' style='opacity: .8; border-radius: 50%; width: 100px; height: 100px;'>";
                $htmlContent .= "<h1>LISTA DE FACTURAS DE PRODUCTOS CANJEABLES</h1>";
                $htmlContent .= "</div>";
                $htmlContent .= "<p>Fechas: Desde $desde hasta $hasta</p>";
                $htmlContent .= "<table><tr><th>Número</th><th>DNI Paciente</th><th>Nombre Paciente</th><th>Nombre Producto</th><th>Cantidad</th><th>Fecha</th></tr>";
            }

            $numero = $factura['numero_factura'] ?? 'N/A';
            $dni = $factura['dni_paciente'] ?? 'N/A';
            $nombre = ($factura['nombre_paciente'] ?? '') . ' ' . ($factura['apellido_paciente'] ?? '');
            $producto = $factura['nombre_producto'] ?? 'N/A';
            $cantidad = $factura['cantidad_producto'] ?? 'N/A';
            $htmlContent .= "<tr><td>$numero</td><td>$dni</td><td>$nombre</td><td>$producto</td><td>$cantidad</td><td>$fecha</td></tr>";

            $itemCount++;

            if ($itemCount >= $itemsPerPage) {
                $htmlContent .= "</table>";
                $htmlContent .= "<div class='footer'>Página $page de $totalPages</div>";
                $htmlContent .= "<div class='page-break'></div>";
                $page++;
                $itemCount = 0;
            }
        }

        if ($itemCount > 0) {
            $htmlContent .= "</table>";
            $htmlContent .= "<div class='footer'>Página $page de $totalPages</div>";
        }

        $htmlContent .= "<script>window.print(); window.close();</script>";
        $htmlContent .= "</body></html>";

        return response($htmlContent)
            ->header('Content-Type', 'text/html; charset=utf-8');
    }
}