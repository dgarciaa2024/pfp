<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Reporte - Portal de Fidelización</title>

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

    /* Estilo para el pie de página */
    .footer {
      position: fixed;
      bottom: 10px;
      left: 10px;
      font-size: 0.8rem;
      color: #333;
      width: 100%;
      text-align: left;
    }

    /* Ajustar el tamaño de la tabla para impresión */
    @media print {
      .invoice {
        width: 100%;
        margin: 0;
      }
      
      .table-responsive {
        max-width: 100%;
        overflow: hidden;
      }
      
      .table {
        width: 100%;
        table-layout: fixed;
      }

      .footer {
        position: fixed;
        bottom: 10px;
        left: 10px;
        width: 100%;
        text-align: left;
      }

      @page {
        margin: 20mm;
      }
    }
  </style>
</head>

<body>
  <div class="invoice">
    <div class="row">
      <div class="col-12 text-center">
        <h2 class="page-header">
          <img src="dist/img/foto_perfil.png" alt="Logo" style="max-width: 50px;">
          Portal de Fidelización
          <br>
          <small>Fecha: 21/08/2024</small>
        </h2>
      </div>
    </div>
    
    <!-- Info row -->
    <div class="reporte-titulo">
      REPORTE DE LA LISTA DE LOS USUARIOS
    </div>

    <!-- Exportar a Excel button -->
    <div class="row mb-4">
      <div class="col-12 text-right">
        <button type="button" class="btn btn-success">
          <i class="fas fa-file-excel"></i> Exportar a Excel
        </button>
      </div>
    </div>

    <!-- Table row -->
    <div class="row">
      <div class="col-12 table-responsive">
        <table id="example1" class="table table-bordered table-striped table-sm">
          <thead class="text-center bg-danger text-white">
            <tr>
              <th>CODIGO</th>
              <th>NOMBRE</th>
              <th>ESTADO</th>
              <th>CONTRASEÑA</th>
              <th>ROL</th>
              <th>CORREO</th>
              <th>CREADO POR</th>
              <th>FECHA CREACIÓN</th>
              <th>MODIFICADO POR</th>
              <th>FECHA MODIFICACIÓN</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>1</td>
              <td>ENMA NAJAVY LOPEZ RODRIGUEZ</td>
              <td>ACTIVO</td>
              <td>N5EG3DYU</td>
              <td>PACIENTE</td>
              <td>enlop@gmail.com</td>
              <td>WILLIAN JOSUE LOPEZ</td>
              <td>12/08/2024</td>
              <td>NINGUNO</td>
              <td>....</td>
            </tr>
            <tr>
              <td>2</td>
              <td>JUNIOR ADALID GARCIA MARTINEZ</td>
              <td>ACTIVO</td>
              <td>J87TG3W</td>
              <td>LABORATORIO</td>
              <td>enlop@gmail.com</td>
              <td>WILLIAN JOSUE LOPEZ</td>
              <td>12/08/2024</td>
              <td>NINGUNO</td>
              <td>....</td>
            </tr>
            <tr>
              <td>3</td>
              <td>WILLIAN JOSUE LOPEZ LOPEZ</td>
              <td>INACTIVO</td>
              <td>WJ45ERTY</td>
              <td>FARMACIA</td>
              <td>enlop@gmail.com</td>
              <td>WILLIAN JOSUE LOPEZ</td>
              <td>12/08/2024</td>
              <td>NINGUNO</td>
              <td>....</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    
    <!-- Footer -->
    <div class="footer">
      Página <script>
        document.write(window.printPageNumber);
      </script>
    </div>
  </div>
</body>

</html>
