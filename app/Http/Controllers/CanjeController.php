<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;
use Mpdf\Mpdf;
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;
use Illuminate\Http\Request;
use App\Http\Controllers\PdfController;
use Illuminate\Support\Facades\DB;

class CanjeController extends Controller
{


    /*************  ✨ Codeium Command ⭐  *************/
    /**
     * Muestra la vista de canjes con los datos de los canjes, estado de canje, productos, pacientes, farmacias y tipo de registro.
     *
     * @return \Illuminate\View\View
     */
    /******  aecce278-3983-4453-8e1b-9f35ce65d2bc  *******/
    public function index()
    {
        $response = Http::get('http://localhost:3000/get_registro');
        $tabla_estadocanje = Http::get('http://localhost:3000/get_estado_canje');
        $tabla_producto = Http::get('http://localhost:3000/get_producto');
        $tabla_paciente = Http::get('http://localhost:3000/get_pacientes');
        $tabla_farmacia = Http::get('http://localhost:3000/get_farmacias');
        $tabla_registro = Http::get('http://localhost:3000/get_tipo_registro');
        $facturas = Http::get('http://localhost:3000/get_facturas');
 // Manejo de sesión y permisos
 $usuario = session('usuario'); // Obtener usuario desde la sesión

 // Permisos predeterminados
 $permiso_insercion = 2;
 $permiso_actualizacion = 2;
 $permiso_eliminacion = 2;

 if ($usuario) {
     $idRolUsuario = $usuario['id_rol']; // Obtener el rol del usuario desde la sesión

     // Consultar permisos en la base de datos para el rol y objeto  (canjes)
     $permisos = DB::table('pfp_schema.tbl_permiso')
         ->where('id_rol', $idRolUsuario)
         ->where('id_objeto', 10) // ID del objeto que corresponde a "canjes"
         ->first();

     // Si se encuentran permisos para este rol y objeto, asignarlos
     if ($permisos) {
         $permiso_insercion = $permisos->permiso_creacion;
         $permiso_actualizacion = $permisos->permiso_actualizacion;
         $permiso_eliminacion = $permisos->permiso_eliminacion;
     }
 }


        return view('modulo_canjes.Canjes')->with([
            'tblestadocanje' => json_decode($tabla_estadocanje, true),
            'tblproducto' => json_decode($tabla_producto, true),
            'tblpaciente' => json_decode($tabla_paciente, true),
            'tblfarmacia' => json_decode($tabla_farmacia, true),
            'tblregistro' => json_decode($tabla_registro, true),
            'Canjes' => json_decode($response, true),
            'Facturas' => json_decode($facturas, true),
            'permiso_insercion' => $permiso_insercion,
            'permiso_actualizacion' => $permiso_actualizacion,
            'permiso_eliminacion' => $permiso_eliminacion,
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


        $response = Http::post('http://localhost:3000/insert_registro', [
            'id_tipo_registro' => $request->input('registro'),
            'id_farmacia' => $request->input('farmacia'),
            'id_paciente' => $request->input('paciente'),
            'id_producto' => $request->input('producto'),
            'cantidad' => $cantidad,
            'id_estado_canje' => $request->input('estadocanje'),
            'comentarios' => $request->input('comentarios'),

        ]);


        $mpdf = new Mpdf();
        $html = view('pdfs.comprobante', compact(
            'nombre_farmacia',
            'rtn_farmacia',
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
            return redirect('Canjes')->with('status_message', 'Canje realizado con exito');
        } else {
            return redirect('Canjes')->with('status_message', 'Error al realizar el canje:' . $response->body());
        }


    }

}