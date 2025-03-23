@php
use Illuminate\Support\Facades\Auth; // Importa la clase Auth
@endphp
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Portal de Fidelización</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">

  <!-- iconos de bootstrap -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

  <!-- DataTables -->
  <link rel="stylesheet" href="../../plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
  <link rel="stylesheet" href="../../plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
  <link rel="stylesheet" href="../../plugins/datatables-buttons/css/buttons.bootstrap4.min.css">

  <!--Jquier-->
  <script src="{{asset('/plugins/jquery/jquery.js')}} "></script>

  <!-- Theme style -->
  <link rel="stylesheet" href="dist/css/adminlte.min.css">

  <!--cosas del modal-->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

  <!-- Tempusdominus Bootstrap 4 -->
  <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
  <!-- iCheck -->
  <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <!-- JQVMap -->
  <link rel="stylesheet" href="plugins/jqvmap/jqvmap.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="dist/css/adminlte.min.css">
  <!-- overlayScrollbars -->
  <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
  <!-- Daterange picker -->
  <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
  <!-- summernote -->
  <link rel="stylesheet" href="plugins/summernote/summernote-bs4.min.css">

  <!-- Select2 CSS -->
  <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />

  <script src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js" defer></script>

  <!--input type="text" class="form-control" style="text-transform: uppercase;" oninput="this.value = this.value.toUpperCase();"-->

  <style>
    /* Estilo personalizado para aplicar el color rojo vino (#DC3545)  .main-header.navbar {
      background-color: #DC3545;
    } */

    /*  body {
      background-color: #DC3545;
    }*/

    .main-sidebar {
      background-color: #800020;
      position: fixed; /* Fija el sidebar */
      height: 100vh; /* Ocupa toda la altura de la ventana */
      overflow-y: auto; /* Permite el desplazamiento vertical si es necesario */
    }

    .content-wrapper {
      margin-left: 250px; /* Ajusta el margen izquierdo para el sidebar */
      min-height: 100vh; /* Asegura que el contenido ocupe toda la altura */
      padding-bottom: 60px; /* Espacio para el footer */
    }

    .main-footer {
      margin-left: 250px; /* Ajusta el margen izquierdo para el sidebar */
    }
  </style>
</head>

<body class="hold-transition sidebar-mini">
  <!-- Preloader -->
  <div class="preloader flex-column justify-content-center align-items-center">
    <img class="animation__shake" src="dist/img/AdminLTELogo.png" alt="AdminLTELogo" height="60" width="60">
  </div>

  <!--TODO LO DEL MENU -->
  <!-- Navbar FONDO BLACO DEL MENU-->
  <nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
      </li>
    </ul>

    <!-- Despliega un formulario de búsqueda -->
    <!-- Right navbar links-->
    <ul class="navbar-nav ml-auto">
      <!-- Ícono de ayuda (MOVIDO AQUÍ) -->
      <li class="nav-item dropdown">
        <a class="nav-link" data-toggle="dropdown" href="#" role="button">
          <i class="fas fa-question-circle"> Centro de Ayuda</i>
        </a>
        <div class="dropdown-menu dropdown-menu-right">
          <a href="{{ url('/manual-usuario') }}" class="dropdown-item">Ver Manual de Usuario</a>
          
          @php
            $user = Auth::user();
            $mostrarTodos = $user && $user->id_rol == 1;
          @endphp
          
          @if($mostrarTodos)
            <div class="dropdown-divider"></div>
            <a href="{{ url('/manual-tecnico') }}" class="dropdown-item">Ver Manual Técnico</a>
            <a href="{{ url('/manual-instalacion') }}" class="dropdown-item">Ver Manual de Instalación</a>
          @endif
        </div>
      </li>

      <!--Menú desplegable de mensajes en la barra de navegación -->
      <li class="nav-item dropdown user-menu">
        <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">
          <img src="../../dist/img/Foto_perfil.png" class="user-image img-circle elevation-2" alt="User Image">
        </a>
        <ul class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
          <!-- User image -->
          <li class="user-header bg-primary">
            <img src="../../dist/img/Foto_perfil.png" class="img-circle elevation-2" alt="User Image">
            <p>
              <small>{{ Auth::check() ? Auth::user()->nombre_usuario : 'Invitado' }}</small>
            </p>
          </li>
          <!-- Menu Body -->
          <li class="user-body">
            <div class="row">
              <div class="col-4 text-center">
                <a href="#">Mensajes</a>
              </div>
            </div>
            <!-- /.row -->
          </li>
          <!-- Menu Footer-->
          <li class="user-footer">
            <a href="AdministrarPerfil" class="btn btn-default btn-flat">PERFIL</a>

            <!-- Boton Logout o cierre de sesión-->
            <form action="{{ route('logout') }}" method="POST" style="display: inline;">
              @csrf
              <button type="submit" class="btn btn-default btn-flat">CERRAR SESIÓN</button>
            </form>
          </li>
        </ul>
      </li>

      <li class="nav-item">
        <a class="nav-link" data-widget="fullscreen" href="#" role="button">
          <i class="fas fa-expand-arrows-alt"></i>
        </a>
      </li>
    </ul>
  </nav>
  <!-- /.navbar -->

  <!-- /FIN DEL MENU DE MENSAJES, NOTIFICACIONES -->

  <!-- /FIN DEL MENU DE MENSAJES, NOTIFICACIONES -->

  <!-- /BARRA DEL MENU LADO IZQUIERDO -->
  <!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- NO TE OLVIDES QUE AQUI VA EL COLOR-->
    <!-- Brand Logo -->
    <a href="{{ url('/inicio') }}" class="brand-link"> <!-- Redirige a la página de inicio -->
      <img src="dist/img/Foto_perfil.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
      <span class="brand-text font-weight-light">CONEXSA</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
      <!-- LOS MODULOS -->
      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
          @include('layouts.modulos')
        </ul>
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /FIN DEN MENU -->
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- contenido para los modulos por si se quiere agregar  @yield('content')  -->
    <!-- /.content-wrapper -->
    <!-- Content Header (Page header) -->
    <!--<div class="container text-center mt-5">
    <img src="dist/img/AcercaDe.png" alt="Portal de Fidelización" class="img-fluid mb-4" style="max-width: 400px;">
    <h1 class="text-rgay">¡Bienvenido al Portal de Fidelización!</h1>
    <p class="text-gray">
      Estamos dedicados a ofrecer una experiencia de atención excepcional, brindando a nuestros pacientes y colaboradores una plataforma confiable y fácil de usar para gestionar todos sus procesos de manera eficiente y segura. Juntos, construimos un entorno de salud más accesible y colaborativo
    </p>
    
  </div>-->
  </div>

  <!--ESTE ES EL FINAL -->
  <!-- /.content-wrapper -->
  <footer class="main-footer">
    <strong>Derechos Reservados © 2024 <a href="https://www.unah.edu.hn/">UNAH</a></strong>
    <div class="float-right d-none d-sm-inline-block">
      <b>Version</b> 0.1
    </div>
  </footer>

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->

  <!-- Modal de éxito agregado aquí, justo antes de los scripts -->
  <div class="modal fade" id="modal-success">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header bg-success">
          <h4 class="modal-title">¡Éxito!</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">
          <p>La operación se realizó exitosamente.</p>
        </div>
        <div class="modal-footer justify-content-end">
          <button type="button" class="btn btn-primary" data-dismiss="modal">Aceptar</button>
        </div>
      </div>
      <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
  </div>
  <!-- /.modal -->

  <!-- ./wrapper -->
  <!-- jQuery -->
  <script src="plugins/jquery/jquery.min.js"></script>
  <!-- jQuery UI 1.11.4 -->
  <script src="plugins/jquery-ui/jquery-ui.min.js"></script>
  <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
  <script>
    $.widget.bridge('uibutton', $.ui.button)
  </script>
  <!-- Bootstrap 4 -->
  <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
  <!-- ChartJS -->
  <script src="plugins/chart.js/Chart.min.js"></script>
  <!-- Sparkline -->
  <script src="plugins/sparklines/sparkline.js"></script>
  <!-- JQVMap -->
  <script src="plugins/jqvmap/jquery.vmap.min.js"></script>
  <script src="plugins/jqvmap/maps/jquery.vmap.usa.js"></script>
  <!-- jQuery Knob Chart -->
  <script src="plugins/jquery-knob/jquery.knob.min.js"></script>
  <!-- daterangepicker -->
  <script src="plugins/moment/moment.min.js"></script>
  <script src="plugins/daterangepicker/daterangepicker.js"></script>
  <!-- Tempusdominus Bootstrap 4 -->
  <script src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
  <!-- Summernote -->
  <script src="plugins/summernote/summernote-bs4.min.js"></script>
  <!-- overlayScrollbars -->
  <script src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
  <!-- AdminLTE App -->
  <script src="dist/js/adminlte.js"></script>
  <!-- AdminLTE for demo purposes -->
  <!--<script src="dist/js/demo.js"></script>-->
  <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
  <script src="dist/js/pages/dashboard.js"></script>

  <!-- DataTables  & Plugins -->
  <script src="../../plugins/datatables/jquery.dataTables.min.js"></script>
  <script src="../../plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
  <script src="../../plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
  <script src="../../plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
  <script src="../../plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
  <script src="../../plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
  <script src="../../plugins/jszip/jszip.min.js"></script>
  <script src="../../plugins/pdfmake/pdfmake.min.js"></script>
  <script src="../../plugins/pdfmake/vfs_fonts.js"></script>
  <script src="../../plugins/datatables-buttons/js/buttons.html5.min.js"></script>
  <script src="../../plugins/datatables-buttons/js/buttons.print.min.js"></script>
  <script src="../../plugins/datatables-buttons/js/buttons.colVis.min.js"></script>

  <!-- Select2 JS -->
  <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

  <!-- Page specific script -->
  <script>
    $(function() {
      $('#example2').DataTable({
        "responsive": true,
        "lengthChange": true, // Permite cambiar el número de registros por página
        "autoWidth": true, // Ajusta el ancho de la tabla automáticamente
        "info": true, // Muestra la información de paginación
        "buttons": false, // Desactiva los botones (si no los usas)
        "language": {
          "decimal": ",",
          "thousands": ".",
          "lengthMenu": "Mostrar _MENU_ registros por página", // Placeholder dinámico
          "zeroRecords": "No se encontraron resultados",
          "info": "Mostrando _START_ a _END_ de _TOTAL_ registros", // Placeholders dinámicos
          "infoEmpty": "No hay registros disponibles",
          "infoFiltered": "(filtrado de _MAX_ registros totales)", // Placeholder dinámico
          "search": "Buscar:",
          "paginate": {
            "first": "Primero",
            "last": "Último",
            "next": "Siguiente",
            "previous": "Anterior"
          }
        }
      });

      // Configuración idéntica para TablaCanje
      $("#TablaCanje").DataTable({
        "responsive": true,
        "lengthChange": true, // Permite cambiar el número de registros por página
        "autoWidth": true, // Ajusta el ancho de la tabla automáticamente
        "info": true, // Muestra la información de paginación
        "buttons": false, // Desactiva los botones (si no los usas)
        "language": {
          "decimal": ",",
          "thousands": ".",
          "lengthMenu": "Mostrar _MENU_ registros por página", // Placeholder dinámico
          "zeroRecords": "No se encontraron resultados",
          "info": "Mostrando _START_ a _END_ de _TOTAL_ registros", // Placeholders dinámicos
          "infoEmpty": "No hay registros disponibles",
          "infoFiltered": "(filtrado de _MAX_ registros totales)", // Placeholder dinámico
          "search": "Buscar:",
          "paginate": {
            "first": "Primero",
            "last": "Último",
            "next": "Siguiente",
            "previous": "Anterior"
          }
        }
      });
    });
  </script>
</body>
</html>