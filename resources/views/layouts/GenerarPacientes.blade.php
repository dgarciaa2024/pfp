<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Lista de Pacientes - Portal de Fidelización</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">

  <style>
    body {
      background-color: #f4f6f9;
      font-family: 'Source Sans Pro', sans-serif;
    }

    .invoice {
      background: #fff;
      padding: 30px;
      margin: 20px auto;
      max-width: 800px;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
      border-radius: 10px;
    }

    .page-header {
      font-size: 1.8rem;
      margin-bottom: 20px;
    }

    .invoice-col {
      margin-bottom: 20px;
    }

    .table-responsive {
      margin-top: 20px;
    }

    .table th, .table td {
      font-size: 0.7rem;
      padding: 3px;
    }

    .bg-danger {
      background-color: #dc3545 !important;
    }

    .text-white {
      color: #fff !important;
    }
    
    .table-bordered th,
    .table-bordered td {
      border: 1px solid #dee2e6;
    }

    .reporte-titulo {
      text-align: center;
      font-size: 1.5rem;
      margin-bottom: 10px;
      font-weight: bold;
    }

    /* Configuración del contador de páginas */
    @page {
      margin: 20mm;
      counter-increment: page;
    }

    .footer {
      position: fixed;
      bottom: 10px;
      left: 10px;
      font-size: 0.8rem;
      color: #333;
      width: 100%;
      text-align: right;
    }

    .footer::after {
      content: "Página " counter(page);
    }
  </style>
</head>

<body>
  <div class="wrapper">
    <!-- Main content -->
    <section class="invoice">
      <!-- Title row -->
      <div class="row">
        <div class="col-12 text-center">
          <h2 class="page-header">
            <img src="dist/img/foto_perfil.png" alt="Logo" style="max-width: 50px;">
            Portal de Fidelización
            <br>
            <small>Fecha: 2/10/2014</small>
          </h2>
        </div>
      </div>
      
      <!-- Info row -->
      <div class="reporte-titulo">
        REPORTE DE LA LISTA DE PACIENTES
      </div>

      <!-- Table row -->
      <div class="row">
        <div class="col-12 table-responsive">
          <table id="example1" class="table table-bordered table-striped table-sm">
            <thead class="text-center bg-danger text-white">
              <tr>
                    <th>ID_PACIENTE</th>
                    <th>DNI PACIENTE</th>
                    <th>NOMBRE </th>
                    <th>FECHA NACIMIENTO</th>
                    <th>GENERO</th>
                    <th>EMAIL</th>
                    <th>DIRECCION</th>
                    <th>TELEFONO</th>
                    <th>TRATAMIENTO MEDICO</th>
                    <th>USUARIO</th>
                    <th>ESTADO</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                    <th>1</th>
                    <th>050119900030</th>
                    <th>EDGAR AVILA</th>
                    <th>15/08/1990</th>
                    <th>MASCULINO</th>
                    <th>EDGARAVILA@GMAIL.COM</th>
                    <th>TEGUCIGALA MDC</th>
                    <th>32303540</th>
                    <th>MIGRAÑA</th>
                    <th>PACIENTE</th>
                    <th>ACTIVO</th>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </section>
    <!-- Footer -->
    <div class="footer"></div>
  </div>

  <!-- Page specific script -->
  <script>
    window.addEventListener("load", function () {
      window.print();
    });
  </script>
</body>

</html>
