<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>@yield('title', 'Portal Fidelización')</title>
    
    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback&v=2">

    <!-- Enlace a CSS de Bootstrap -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    <!-- Estilos personalizados -->
    <style>
        body {
            font-family: 'Source Sans Pro', sans-serif;
            font-size: 14px;
            background: #f4f6f9; /* Light background similar to AdminLTE */
            color: #333;
            line-height: 1.5;
        }
        .navbar {
            background-color: #dc3545; /* Wine red from the second template */
        }
        .navbar-brand, .nav-link {
            color: #fff !important;
            font-weight: 400; /* Adjusted to match Source Sans Pro lighter weights */
            font-size: 16px;
        }
        .navbar-brand:hover, .nav-link:hover {
            color: #d1d1d1 !important; /* Light gray hover effect similar to AdminLTE */
        }
        .container {
            background-color: #fff;
            border-radius: 0.25rem; /* Softer radius like AdminLTE */
            box-shadow: 0 0 1px rgba(0,0,0,.125), 0 1px 3px rgba(0,0,0,.2); /* AdminLTE shadow */
            padding: 1.5rem; /* Reduced padding slightly */
            width: auto; /* Let it adjust to content */
            max-width: 500px; /* Optional: cap the width for proportionality */
            margin: 0 auto; /* Center the container */
        }
        h1 {
            font-size: 22px;
            color: #333;
        }
        .btn-primary {
            background-color: #dc3545; /* Wine red */
            border-color: #dc3545;
        }
        .btn-primary:hover {
            background-color: #c82333; /* Slightly darker red on hover */
            border-color: #c82333;
        }
        .alert-success {
            background-color: #d4edda; /* Success green from AdminLTE */
            color: #155724;
            border-color: #c3e6cb;
            font-size: 13px;
        }
    </style>

    @stack('styles')
</head>
<body>

    <!-- Barra de navegación -->
    <nav class="navbar navbar-expand-lg">
        <a class="navbar-brand" href="{{ url('/') }}">Portal de Fidelización de Pacientes</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                @guest
                    <li class="nav-item">
                        <a class="nav-link" href="{{ route('login') }}">Iniciar Sesión</a>
                    </li>
                @else
                    <li class="nav-item">
                        <a class="nav-link" href="{{ route('logout') }}" onclick="event.preventDefault(); document.getElementById('logout-form').submit();">
                            Cerrar Sesión
                        </a>
                        <form id="logout-form" action="{{ route('logout') }}" method="POST" style="display: none;">
                            @csrf
                        </form>
                    </li>
                @endguest
            </ul>
        </div>
    </nav>

    <!-- Contenedor principal -->
    <div class="container mt-4">
        <!-- Título visible siempre -->
        <h1 class="mb-4 text-center">@yield('title', 'Recuperación de Contraseña')</h1>

        @if (session('status'))
            <div class="alert alert-success" role="alert">
                {{ session('status') }}
            </div>
        @endif

        <!-- Ejemplo de contenido: formulario de email -->
        @yield('content', '
            <form method="POST" action="{{ route(\'password.email\') }}">
                @csrf
                <div class="form-group">
                    <label for="email">Correo Electrónico</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>
                <button type="submit" class="btn btn-primary btn-block">Enviar Enlace de Recuperación</button>
            </form>
        ')
    </div>

    <!-- Scripts de JavaScript -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" 
        integrity="sha384-rb69xq0bN5D8vF65vlF5AqXvHvu8w+D7OMQfcmBv28hboJ8yjwWpIisghxg9wGi5" 
        crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.10/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.10/vfs_fonts.min.js"></script>

    @stack('scripts')
</body>
</html>