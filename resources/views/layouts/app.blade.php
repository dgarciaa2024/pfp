<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>@yield('title', 'Portal Fidelización')</title>
    
    <!-- Enlace a CSS de Bootstrap -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    <!-- Fuente personalizada -->
    <link rel="preconnect" href="https://fonts.bunny.net">
    <link href="https://fonts.bunny.net/css?family=figtree:400,600&display=swap" rel="stylesheet" />

    <!-- Estilos personalizados -->
    <style>
        body {
            font-family: 'Figtree', ui-sans-serif, system-ui, sans-serif;
            font-size: 14px; /* Reducimos el tamaño general */
            background: linear-gradient(to bottom, #ffffff, #f3f4f6);
            color: #333;
            line-height: 1.5;
        }
        .navbar {
            background-color: #800020;
        }
        .navbar-brand, .nav-link {
            color: #fff !important;
            font-weight: 600;
            font-size: 16px; /* Tamaño de fuente más pequeño para la barra de navegación */
        }
        .navbar-brand:hover, .nav-link:hover {
            color: #FFD700 !important;
        }
        .container {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 2rem;
        }
        h1 {
            font-size: 22px; /* Reducimos el tamaño del título principal */
        }
        .btn-primary {
            background-color: #800020;
            border-color: #FF2D20;
        }
        .btn-primary:hover {
            background-color: #e0241d;
            border-color: #e0241d;
        }
        .alert-success {
            background-color: #d1fae5;
            color: #065f46;
            border-color: #a7f3d0;
            font-size: 13px; /* Tamaño más pequeño para las alertas */
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

        <!-- Aquí inyectamos el contenido de otras vistas -->
        @yield('content')
        

    <!-- Scripts de JavaScript -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    @stack('scripts')
   

</body>

</html>
