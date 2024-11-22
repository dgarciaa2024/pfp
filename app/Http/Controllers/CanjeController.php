<?php

namespace App\Http\Controllers;
//incluimos Http
use Illuminate\Support\Facades\Http;
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;
use Illuminate\Http\Request;
class CanjeController extends Controller
{


    public function index()
    {
        $response = Http::get('http://localhost:3000/get_registro');
        $tabla_estadocanje = Http::get('http://localhost:3000/get_estado_canje');
        $tabla_producto = Http::get('http://localhost:3000/get_producto');
        $tabla_paciente = Http::get('http://localhost:3000/get_pacientes');
        $tabla_farmacia = Http::get('http://localhost:3000/get_farmacias');
        $tabla_registro = Http::get('http://localhost:3000/get_tipo_registro');
        $facturas = Http::get('http://localhost:3000/get_facturas');


        return view('modulo_canjes.Canjes')->with([
            'tblestadocanje' => json_decode($tabla_estadocanje, true),
            'tblproducto' => json_decode($tabla_producto, true),
            'tblpaciente' => json_decode($tabla_paciente, true),
            'tblfarmacia' => json_decode($tabla_farmacia, true),
            'tblregistro' => json_decode($tabla_registro, true),
            'Canjes' => json_decode($response, true),
            'Facturas' => json_decode($facturas, true),
        ]);
    }



    public function store(Request $request)
    {

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
                <div class="container">
                    <div class="header">
                        <h2>Confirmación de Canje</h2>
                    </div>
                    <div class="content">
                        <p>Hola <span class="highlight">' . $paciente . '</span>,</p>
                        <p>Este correo confirma que el <span class="highlight">canje del medicamento <b>' . $producto . '</b></span> para ti fue <span class="highlight">exitoso</span>.</p>
                        <p>Gracias por tu preferencia y atención.</p>
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
        $response = Http::post('http://localhost:3000/insert_registro', [
            'id_tipo_registro' => $request->get('registro'),
            'id_farmacia' => $request->get('farmacia'),
            'id_paciente' => $request->get('paciente'),
            'id_producto' => $request->get('producto'),
            'cantidad' => $request->get('cantidad'),
            'id_estado_canje' => $request->get('estadocanje'),
            'comentarios' => $request->get('comentarios'),

        ]);

        return redirect('Canjes');

    }

}