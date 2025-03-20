<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>500 - Error Interno del Servidor</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .error-container {
            text-align: center;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            font-size: 72px;
            color: #e74c3c;
            margin: 0;
        }
        p {
            font-size: 18px;
            color: #333;
        }
        a {
            color: #3498db;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
        .error-details {
            font-size: 14px;
            color: #666;
            margin-top: 20px;
            display: none; /* Cambia a "block" si quieres mostrar detalles */
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h1>500</h1>
        <p>Error Interno del Servidor</p>
        <p>Ocurrió un problema inesperado. Por favor, intenta de nuevo más tarde.</p>
        <!-- <p><a href="{{ url('/') }}">Volver al inicio</a></p> -->
        @if(isset($exception))
            <div class="error-details">
                <p>Error: {{ $exception->getMessage() }}</p>
                <p>Archivo: {{ $exception->getFile() }} (Línea: {{ $exception->getLine() }})</p>
            </div>
        @endif
    </div>
</body>
</html>