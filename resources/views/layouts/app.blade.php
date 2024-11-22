<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Portal de Fidelización</title>

  <!-- Fuentes y Estilos -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="dist/css/adminlte.min.css">

  <!-- Estilos Personalizados -->
  <style>
    .navbar {
      background-color: #800020;
    }
    .navbar a {
      color: #fff;
    }
    .navbar a:hover {
      color: #ffd700;
    }
    .main-footer {
      background-color: #800020;
      color: #fff;
    }
    .main-footer a {
      color: #ffd700;
    }
    .content-wrapper {
      min-height: calc(100vh - 100px);
    }
  </style>
</head>
<body class="hold-transition layout-top-nav">
  <div class="wrapper">

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
      <a class="navbar-brand" href="{{ url('/') }}">Portal de Fidelización</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
          @guest
            <li class="nav-item">
              <a class="nav-link" href="{{ route('login') }}">Iniciar Sesión</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="{{ route('register') }}">Registrarse</a>
            </li>
          @else
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                {{ Auth::user()->nombre_usuario }}
              </a>
              <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                <a class="dropdown-item" href="AdministrarPerfil">Perfil</a>
                <form action="{{ route('logout') }}" method="POST" class="d-inline">
                  @csrf
                  <button type="submit" class="dropdown-item">Cerrar Sesión</button>
                </form>
              </div>
            </li>
          @endguest
        </ul>
      </div>
    </nav>
    <!-- End Navbar -->

    <!-- Main Content -->
    <div class="content-wrapper">
      <div class="content-header text-center mt-5">
        <img src="dist/img/AcercaDe.png" alt="Portal de Fidelización" class="img-fluid mb-4" style="max-width: 400px;">
        <h1 class="text-gray">¡Bienvenido al Portal de Fidelización!</h1>
        <p class="text-gray">
          Estamos dedicados a ofrecer una experiencia de atención excepcional, brindando a nuestros pacientes y colaboradores una plataforma confiable y fácil de usar para gestionar todos sus procesos de manera eficiente y segura.
        </p>
      </div>
    </div>
    <!-- End Main Content -->

    <!-- Footer -->
    <footer class="main-footer text-center">
      <strong>Derechos Reservados &copy; 2024 <a href="https://www.unah.edu.hn/">UNAH</a>.</strong>
      <div class="float-right d-none d-sm-inline-block">
        <b>Versión</b> 0.1
      </div>
    </footer>
    <!-- End Footer -->

  </div>
  <!-- End Wrapper -->

  <!-- Scripts -->
  <script src="plugins/jquery/jquery.min.js"></script>
  <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="dist/js/adminlte.min.js"></script>
</body>
</html>
