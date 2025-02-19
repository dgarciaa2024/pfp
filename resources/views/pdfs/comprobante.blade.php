<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Información del Canje</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 30px;
      padding: 0;
      background-color: #f9f9f9;
    }

    .container {
      width: 100%;
      max-width: 800px;
      margin: auto;
      background-color: #fff;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    h1 {
      text-align: center;
      color: #333;
    }

    .section {
      margin: 20px 0;
    }

    .section h2 {
      background-color: #4CAF50;
      color: white;
      padding: 10px;
      border-radius: 5px;
    }

    .section p {
      font-size: 16px;
      line-height: 1.5;
      margin: 10px 0;
    }

    .table {
      width: 100%;
      border-collapse: collapse;
      margin: 20px 0;
    }

    .table,
    .table th,
    .table td {
      border: 1px solid #ddd;
    }

    .table th,
    .table td {
      padding: 12px;
      text-align: left;
    }

    .table th {
      background-color: #f2f2f2;
      font-weight: bold;
    }

    .footer {
      text-align: center;
      margin-top: 30px;
      font-size: 14px;
    }

    .footer p {
      margin: 5px 0;
    }

    /* Estilo para impresión */
    @media print {
      body {
        margin: 0;
        padding: 0;
      }

      .container {
        box-shadow: none;
        margin: 0;
        padding: 0;
        page-break-before: always;
      }

      .section h2 {
        background-color: #4CAF50;
        color: white;
        padding: 10px;
      }

      .footer {
        font-size: 12px;
      }

      h1 {
        font-size: 24px;
      }
    }

  </style>
</head>
<body>
  <div>
    <h1>Información de canje</h1>

    <div class="section">
      <h2>Datos Farmacia</h2>
      <p><strong>Farmacia:</strong> {{ $nombre_farmacia }}</p>
      <p><strong>RTN:</strong> {{ $rtn_farmacia }}</p>
      <p><strong>Atendio:</strong> {{ $usuario_logueado }}</p>
    </div>

    <!-- Datos Personales -->
    <div class="section">
      <h2>Datos Cliente</h2>
      <p><strong>Nombre:</strong> {{ $nombre_paciente }} {{ $apellido_paciente }}</p>
      <p><strong>DNI:</strong> {{ $dni_paciente }}</p>
      <p><strong>Telefono:</strong> {{ $telefono_paciente }}</p>
      <p><strong>Correo:</strong> {{ $correo_paciente }}</p>
    </div>

    <!-- Historia Clínica -->
    <div class="section">
      <h2>Información de Canje</h2>

      <p><strong>Producto:</strong> {{ $nombre_producto }}</p>
      <p><strong>Cantidad Canjeada:</strong> {{ $cantidad }}</p>
      <p><strong>Forma Farmaceutica:</strong> {{ $forma_farmaceutica }}</p>
      <p><strong>Fecha Canje:</strong> {{ $fecha_registro }}</p>
    </div>

    <!-- Signos Vitales -->

    <!-- Observaciones -->
    <div class="section">
      <h2>Comentarios</h2>
      <p>{{ $comentarios }}</p>
    </div>

    <div class="footer">
      <p>Documento generado el {{ now()->format('d-m-Y H:i') }}</p>
    </div>
  </div>

</body>
</html>
