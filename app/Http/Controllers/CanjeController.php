<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Storage;
use Mpdf\Mpdf;
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;
use Illuminate\Http\Request;
use App\Http\Controllers\PdfController;
use Illuminate\Support\Facades\DB;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Support\Facades\Log;

class CanjeController extends Controller
{
    /**
     * Muestra la vista de canjes con los datos de los canjes, estado de canje, productos, pacientes, farmacias y tipo de registro.
     *
     * @return \Illuminate\View\View
     */
    public function index(Request $request)
    {
        $response = Http::get(env('API_URL', 'http://localhost:3002').'/get_registro');
        $tabla_estadocanje = Http::get(env('API_URL', 'http://localhost:3002').'/get_estado_canje');
        $tabla_producto = Http::get(env('API_URL', 'http://localhost:3002').'/get_producto');
        $tabla_paciente = Http::get(env('API_URL', 'http://localhost:3002').'/get_pacientes');
        $tabla_farmacia = Http::get(env('API_URL', 'http://localhost:3002').'/get_farmacias');
        $tabla_registro = Http::get(env('API_URL', 'http://localhost:3002').'/get_tipo_registro');
        $facturas = Http::get(env('API_URL', 'http://localhost:3002').'/get_facturas');

        // Manejo de sesión y permisos
        $usuario = session('usuario'); // Obtener usuario desde la sesión

        // Permisos predeterminados
        $permiso_insercion = 2;
        $permiso_actualizacion = 2;
        $permiso_eliminacion = 2;
        $permiso_consultar = 0; // Permiso de consulta predeterminado en 0

        if ($usuario) {
            $idRolUsuario = $usuario['id_rol']; // Obtener el rol del usuario desde la sesión

            // Consultar permisos en la base de datos para el rol y objeto (canjes)
            $permisos = DB::table('pfp_schema.tbl_permiso')
                ->where('id_rol', $idRolUsuario)
                ->where('id_objeto', 10) // ID del objeto que corresponde a "canjes"
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

        $storedData = null;
        $canjeGuardado = Storage::exists('data.json');
        if ($canjeGuardado === true) {
            $storedData = json_decode(Storage::get('data.json'), true);
        }

        // Validar y decodificar respuestas de las APIs
        $canjesArray = $response->successful() && is_array($response->json()) ? $response->json() : [];
        $estadoCanjeArray = $tabla_estadocanje->successful() && is_array($tabla_estadocanje->json()) ? $tabla_estadocanje->json() : [];
        $productosArray = $tabla_producto->successful() && is_array($tabla_producto->json()) ? $tabla_producto->json() : [];
        $pacientesArray = $tabla_paciente->successful() && is_array($tabla_paciente->json()) ? $tabla_paciente->json() : [];
        $farmaciasArray = $tabla_farmacia->successful() && is_array($tabla_farmacia->json()) ? $tabla_farmacia->json() : [];
        $registroArray = $tabla_registro->successful() && is_array($tabla_registro->json()) ? $tabla_registro->json() : [];
        $facturasArray = $facturas->successful() && is_array($facturas->json()) ? $facturas->json() : [];

        // Filtros de fecha
        $desde = $request->input('desde');
        $hasta = $request->input('hasta');
        $canjesFiltrados = $canjesArray;

        if ($desde && $hasta) {
            $canjesFiltrados = array_filter($canjesFiltrados, function ($canje) use ($desde, $hasta) {
                return is_array($canje) && isset($canje['fecha_registro']) && 
                       \Carbon\Carbon::parse($canje['fecha_registro'])->format('Y-m-d') >= $desde && 
                       \Carbon\Carbon::parse($canje['fecha_registro'])->format('Y-m-d') <= $hasta;
            });
        }

        return view('modulo_canjes.Canjes')->with([
            'tblestadocanje' => $estadoCanjeArray,
            'tblproducto' => $productosArray,
            'tblpaciente' => $pacientesArray,
            'tblfarmacia' => $farmaciasArray,
            'tblregistro' => $registroArray,
            'Canjes' => $canjesArray,
            'Facturas' => $facturasArray,
            'CanjesFiltrados' => array_values($canjesFiltrados),
            'permiso_insercion' => $permiso_insercion,
            'permiso_actualizacion' => $permiso_actualizacion,
            'permiso_eliminacion' => $permiso_eliminacion,
            'CanjeGuardado' => $canjeGuardado,
            'storedCanjeData' => $storedData,
            'desde' => $desde,
            'hasta' => $hasta,
        ]);
    }

    public function store(Request $request)
    {
        $nombre_farmacia = $request->get("nombre_farmacia");
        $rtn_farmacia = $request->get("rtn_farmacia");
        $nombre_paciente = $request->get("nombre_paciente");
        $apellido_paciente = $request->get("apellido_paciente");
        $dni_paciente = $request->get("dni_paciente");
        $telefono_paciente = $request->get("telefono_paciente");
        $correo_paciente = $request->get("correo_paciente");
        $nombre_producto = $request->get("nombre_producto");
        $cantidad = $request->input("cantidad");
        $forma_farmaceutica = $request->get("forma_farmaceutica");
        $fecha_registro = $request->get("fecha_registro");
        $comentarios = $request->get("comentarios");

        $response = Http::post(env('API_URL', 'http://localhost:3002').'/insert_registro', [
            'id_tipo_registro' => $request->input('registro'),
            'id_farmacia' => $request->input('farmacia'),
            'id_paciente' => $request->input('paciente'),
            'id_producto' => $request->input('producto'),
            'cantidad' => $cantidad,
            'id_estado_canje' => $request->input('estadocanje'),
            'comentarios' => $request->input('comentarios'),
        ]);

        $usuario_logueado = $response->body();
        $mpdf = new Mpdf();
        $html = view('pdfs.comprobante', compact(
            'nombre_farmacia',
            'rtn_farmacia',
            'usuario_logueado',
            'nombre_paciente',
            'apellido_paciente',
            'dni_paciente',
            'telefono_paciente',
            'correo_paciente',
            'nombre_producto',
            'cantidad',
            'forma_farmaceutica',
            'fecha_registro',
            'comentarios'
        ))->render();

        $mpdf->WriteHTML($html);
        $pdfPath = storage_path('app/public/canje.pdf');
        $mpdf->Output($pdfPath, 'F');

        $email = $request->get("email");
        $producto = $request->get("productoNombre");
        $paciente = $request->get("pacienteNombre");

        $mail = new PHPMailer(true);

        try {
            $mail->isSMTP();
            $mail->Host = 'smtp.gmail.com';
            $mail->SMTPAuth = true;
            $mail->Username = 'canjeproyecto@gmail.com';
            $mail->Password = 'wwpcooprtwtkrljd';
            $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
            $mail->Port = 587;
            $mail->setFrom('canjeproyecto@gmail.com', 'Sistema');
            $mail->addAddress($email, 'Paciente');
            $mail->isHTML(true);
            $mail->Subject = 'Confirmacion de Canje';
            $mail->addAttachment(
                $pdfPath,
                'canje.pdf',
            );
            $mail->Body = '<html>
            <head>
                <style>
                    body {
                        font-family: Arial, sans-serif;
                        color: #333;
                        background-color: #f9f9f9;
                        padding: 20px;
                    }
                    .container {
                        background-color: #ffffff;
                        border-radius: 8px;
                        padding: 20px;
                        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                    }
                    .header {
                        text-align: center;
                        color: #4CAF50;
                        font-size: 24px;
                        margin-bottom: 20px;
                    }
                    .content {
                        font-size: 16px;
                        line-height: 1.5;
                    }
                    .highlight {
                        font-weight: bold;
                        color: #4CAF50;
                    }
                    .footer {
                        text-align: center;
                        margin-top: 20px;
                        font-size: 12px;
                        color: #aaa;
                    }
                </style>
            </head>
            <body>
                ¡Felicidades! El canje se ha realizado con éxito.
                <div class="container">
                    <div class="header">
                        <h2>Confirmación de Canje</h2>
                    </div>
                    <div class="content">
                        Estimado(a) cliente: ' . strtoupper($paciente) . ',
                        Te confirmamos que tu producto (' . strtoupper($producto) . ') ha sido canjeado con éxito. Nos alegra saber que has aprovechado los
                        beneficios de nuestro programa de recompensas.
                        Si necesitas más información sobre tus próximos canjes o tienes alguna consulta, no dudes en contactarnos. Estamos aquí para
                        ayudarte.
                        Gracias por elegirnos y ser parte de nuestro programa. ¡Esperamos seguir ofreciéndote más beneficios en el futuro!
                    </div>
                    <div class="footer">
                        <p>Este es un correo automático, por favor no responda.</p>
                    </div>
                </div>
            </body>
            </html>';

            $mail->send();
        } catch (Exception $e) {
            echo "No se pudo enviar el correo. Error: {$mail->ErrorInfo}";
        }
        if ($response->successful()) {
            if (Storage::exists('data.json')) {
                Storage::delete('data.json');
            }
            return redirect('Canjes')->with('status_message', 'Canje realizado con exito');
        } else {
            return redirect('Canjes')->with('status_message', 'Error al realizar el canje:' . $response->body());
        }
    }

    public function finalizar_canje()
    {
        if (Storage::exists('data.json')) {
            Storage::delete('data.json');
        }
        return redirect('Canjes');
    }

    // Nueva funcionalidad: Exportar a Excel
    public function exportToExcel(Request $request)
    {
        $canjes = json_decode($request->input('canjes', '[]'), true);
        $desde = $request->input('desde');
        $hasta = $request->input('hasta');

        if (empty($canjes) || !$desde || !$hasta) {
            return redirect()->back()->with('status_message', 'No hay datos para exportar o faltan fechas.');
        }

        $filename = "Canjes_{$desde}_al_{$hasta}.xls";
        header("Content-Type: application/vnd.ms-excel");
        header("Content-Disposition: attachment; filename=\"$filename\"");

        echo "Código\tFecha Registro\tTipo Registro\tRTN Farmacia\tNombre Farmacia\tDNI Paciente\tNombre Paciente\tApellido Paciente\tNombre Producto\tCantidad\tEstado Canje\tComentarios\tFecha Creación\tCreado Por\n";
        foreach ($canjes as $canje) {
            if (!is_array($canje)) continue;
            $fecha = isset($canje['fecha_registro']) ? \Carbon\Carbon::parse($canje['fecha_registro'])->format('Y-m-d') : '';
            if ($desde && $hasta && ($fecha < $desde || $fecha > $hasta)) {
                continue;
            }
            $codigo = $canje['id_registro'] ?? '';
            $fechaRegistro = isset($canje['fecha_registro']) ? \Carbon\Carbon::parse($canje['fecha_registro'])->format('d/m/Y H:i:s') : '';
            $tipoRegistro = $canje['tipo_registro'] ?? '';
            $rtnFarmacia = $canje['rtn_farmacia'] ?? '';
            $nombreFarmacia = $canje['nombre_farmacia'] ?? '';
            $dniPaciente = $canje['dni_paciente'] ?? '';
            $nombrePaciente = $canje['nombre_paciente'] ?? '';
            $apellidoPaciente = $canje['apellido_paciente'] ?? '';
            $nombreProducto = $canje['nombre_producto'] ?? '';
            $cantidad = $canje['cantidad'] ?? '';
            $estadoCanje = $canje['estado_canje'] ?? '';
            $comentarios = $canje['comentarios'] ?? '';
            $fechaCreacion = $canje['fecha_creacion'] ?? '';
            $creadoPor = $canje['creado_por'] ?? '';
            echo "$codigo\t$fechaRegistro\t$tipoRegistro\t$rtnFarmacia\t$nombreFarmacia\t$dniPaciente\t$nombrePaciente\t$apellidoPaciente\t$nombreProducto\t$cantidad\t$estadoCanje\t$comentarios\t$fechaCreacion\t$creadoPor\n";
        }
        exit;
    }

    // Nueva funcionalidad: Exportar a PDF
    public function exportToPdf(Request $request)
    {
        Log::info('ExportToPdf called', $request->all());

        $canjes = json_decode($request->input('canjes', '[]'), true);
        $desde = $request->input('desde');
        $hasta = $request->input('hasta');

        if (empty($canjes) || !$desde || !$hasta) {
            Log::warning('Datos incompletos para exportar a PDF', ['canjes' => $canjes, 'desde' => $desde, 'hasta' => $hasta]);
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
        $totalItems = count(array_filter($canjes, function ($canje) use ($desde, $hasta) {
            if (!is_array($canje)) return false;
            $fecha = isset($canje['fecha_registro']) ? \Carbon\Carbon::parse($canje['fecha_registro'])->format('Y-m-d') : '';
            return $fecha >= $desde && $fecha <= $hasta;
        }));
        $totalPages = ceil($totalItems / $itemsPerPage);

        foreach ($canjes as $canje) {
            if (!is_array($canje)) continue;
            $fecha = isset($canje['fecha_registro']) ? \Carbon\Carbon::parse($canje['fecha_registro'])->format('Y-m-d') : '';
            if ($desde && $hasta && ($fecha < $desde || $fecha > $hasta)) {
                continue;
            }

            if ($itemCount == 0) {
                $pdfContent .= "<div class='header'>";
                $pdfContent .= "<img src='" . public_path('dist/img/Foto_perfil.png') . "' alt='AdminLTE Logo' style='opacity: .8; border-radius: 50%; width: 100px; height: 100px;'>";
                $pdfContent .= "<h1>LISTA DE CANJES</h1>";
                $pdfContent .= "</div>";
                $pdfContent .= "<p>Fechas: Desde $desde hasta $hasta</p>";
                $pdfContent .= "<table><tr><th>Código</th><th>Fecha Registro</th><th>Tipo Registro</th><th>RTN Farmacia</th><th>Nombre Farmacia</th><th>DNI Paciente</th><th>Nombre Paciente</th><th>Apellido Paciente</th><th>Nombre Producto</th><th>Cantidad</th><th>Estado Canje</th><th>Comentarios</th><th>Fecha Creación</th><th>Creado Por</th></tr>";
            }

            $codigo = $canje['id_registro'] ?? 'N/A';
            $fechaRegistro = isset($canje['fecha_registro']) ? \Carbon\Carbon::parse($canje['fecha_registro'])->format('d/m/Y H:i:s') : 'N/A';
            $tipoRegistro = $canje['tipo_registro'] ?? 'N/A';
            $rtnFarmacia = $canje['rtn_farmacia'] ?? 'N/A';
            $nombreFarmacia = $canje['nombre_farmacia'] ?? 'N/A';
            $dniPaciente = $canje['dni_paciente'] ?? 'N/A';
            $nombrePaciente = $canje['nombre_paciente'] ?? 'N/A';
            $apellidoPaciente = $canje['apellido_paciente'] ?? 'N/A';
            $nombreProducto = $canje['nombre_producto'] ?? 'N/A';
            $cantidad = $canje['cantidad'] ?? 'N/A';
            $estadoCanje = $canje['estado_canje'] ?? 'N/A';
            $comentarios = $canje['comentarios'] ?? 'N/A';
            $fechaCreacion = $canje['fecha_creacion'] ?? 'N/A';
            $creadoPor = $canje['creado_por'] ?? 'N/A';
            $pdfContent .= "<tr><td>$codigo</td><td>$fechaRegistro</td><td>$tipoRegistro</td><td>$rtnFarmacia</td><td>$nombreFarmacia</td><td>$dniPaciente</td><td>$nombrePaciente</td><td>$apellidoPaciente</td><td>$nombreProducto</td><td>$cantidad</td><td>$estadoCanje</td><td>$comentarios</td><td>$fechaCreacion</td><td>$creadoPor</td></tr>";

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
            $pdf = Pdf::loadHTML($pdfContent)->setPaper('letter', 'portrait');
            return $pdf->download("Canjes_{$desde}_al_{$hasta}.pdf");
        } catch (\Exception $e) {
            Log::error('Error al generar PDF', ['message' => $e->getMessage()]);
            return redirect()->back()->with('status_message', 'Error al generar el PDF: ' . $e->getMessage());
        }
    }

    // Nueva funcionalidad: Imprimir
    public function print(Request $request)
    {
        $canjes = json_decode($request->input('canjes', '[]'), true);
        $desde = $request->input('desde');
        $hasta = $request->input('hasta');

        if (empty($canjes) || !$desde || !$hasta) {
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
        $totalItems = count(array_filter($canjes, function ($canje) use ($desde, $hasta) {
            if (!is_array($canje)) return false;
            $fecha = isset($canje['fecha_registro']) ? \Carbon\Carbon::parse($canje['fecha_registro'])->format('Y-m-d') : '';
            return $fecha >= $desde && $fecha <= $hasta;
        }));
        $totalPages = ceil($totalItems / $itemsPerPage);

        foreach ($canjes as $canje) {
            if (!is_array($canje)) continue;
            $fecha = isset($canje['fecha_registro']) ? \Carbon\Carbon::parse($canje['fecha_registro'])->format('Y-m-d') : '';
            if ($desde && $hasta && ($fecha < $desde || $fecha > $hasta)) {
                continue;
            }

            if ($itemCount == 0) {
                $htmlContent .= "<div class='header'>";
                $htmlContent .= "<img src='" . public_path('dist/img/Foto_perfil.png') . "' alt='AdminLTE Logo' style='opacity: .8; border-radius: 50%; width: 100px; height: 100px;'>";
                $htmlContent .= "<h1>LISTA DE CANJES</h1>";
                $htmlContent .= "</div>";
                $htmlContent .= "<p>Fechas: Desde $desde hasta $hasta</p>";
                $htmlContent .= "<table><tr><th>Código</th><th>Fecha Registro</th><th>Tipo Registro</th><th>RTN Farmacia</th><th>Nombre Farmacia</th><th>DNI Paciente</th><th>Nombre Paciente</th><th>Apellido Paciente</th><th>Nombre Producto</th><th>Cantidad</th><th>Estado Canje</th><th>Comentarios</th><th>Fecha Creación</th><th>Creado Por</th></tr>";
            }

            $codigo = $canje['id_registro'] ?? 'N/A';
            $fechaRegistro = isset($canje['fecha_registro']) ? \Carbon\Carbon::parse($canje['fecha_registro'])->format('d/m/Y H:i:s') : 'N/A';
            $tipoRegistro = $canje['tipo_registro'] ?? 'N/A';
            $rtnFarmacia = $canje['rtn_farmacia'] ?? 'N/A';
            $nombreFarmacia = $canje['nombre_farmacia'] ?? 'N/A';
            $dniPaciente = $canje['dni_paciente'] ?? 'N/A';
            $nombrePaciente = $canje['nombre_paciente'] ?? 'N/A';
            $apellidoPaciente = $canje['apellido_paciente'] ?? 'N/A';
            $nombreProducto = $canje['nombre_producto'] ?? 'N/A';
            $cantidad = $canje['cantidad'] ?? 'N/A';
            $estadoCanje = $canje['estado_canje'] ?? 'N/A';
            $comentarios = $canje['comentarios'] ?? 'N/A';
            $fechaCreacion = $canje['fecha_creacion'] ?? 'N/A';
            $creadoPor = $canje['creado_por'] ?? 'N/A';
            $htmlContent .= "<tr><td>$codigo</td><td>$fechaRegistro</td><td>$tipoRegistro</td><td>$rtnFarmacia</td><td>$nombreFarmacia</td><td>$dniPaciente</td><td>$nombrePaciente</td><td>$apellidoPaciente</td><td>$nombreProducto</td><td>$cantidad</td><td>$estadoCanje</td><td>$comentarios</td><td>$fechaCreacion</td><td>$creadoPor</td></tr>";

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