<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Portal Fidelización - Iniciar Sesión</title>

  @include('layouts.partials.messages')

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">

  <style>
    body {
      background-color: #ffffff;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
      font-family: 'Source Sans Pro', sans-serif;
      color: #333;
    }

    .login-box {
      background-color: #fff;
      padding: 40px;
      border-radius: 10px;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
      text-align: center;
      width: 400px;
      border: 2px solid #dc3545; /* Bordes rojos */
    }

    .card-header {
      font-size: 2rem;
      font-weight: bold;
      margin-bottom: 30px;
      color: #dc3545; /* Rojo */
    }

    .card-header a {
      color: #dc3545;
      text-decoration: none;
    }

    .form-control {
      background-color: #ffffff;
      border: 1px solid #ddd;
      color: #333;
      margin-bottom: 15px;
    }

    .form-control::placeholder {
      color: #aaa;
    }

    .form-control:focus {
      box-shadow: none;
      border-color: #dc3545;
    }

    .input-group-text {
      background-color: #dc3545;
      border: none;
      color: #fff;
    }

    .btn-primary {
      background-color: #dc3545;
      border: none;
      width: 100%;
      padding: 10px;
      font-size: 1.1rem;
      margin-top: 20px;
      transition: background-color 0.3s ease;
    }

    .btn-primary:hover {
      background-color: #c82333;
    }

    .icheck-primary label {
      color: #333;
    }

    .icheck-primary input:checked + label::before {
      background-color: #dc3545;
      border-color: #dc3545;
    }

    a {
      color: #dc3545;
      margin-top: 15px;
      transition: color 0.3s ease;
    }

    a:hover {
      color: #c82333;
    }

    .login-box-msg {
      font-size: 1.2rem;
      margin-bottom: 30px;
      color: #333;
    }

    .error-message {
      color: #dc3545;
      font-size: 1rem;
      margin-top: 15px;
    }
  </style>
</head>

<body class="hold-transition login-page">
  <div class="login-box">
    <div class="card-header">
      <a href="../../Principal"><b>Portal de</b> Fidelización</a>
    </div>
    <div class="card-body">
      <p class="login-box-msg">Iniciar sesión</p>

      <form method="POST" action="{{ route('login.perform') }}">
        @csrf

        <div class="input-group mb-3">
          <input type="text" name="nombre_usuario" class="form-control" value="{{ old('nombre_usuario') }}" placeholder="Nombre de usuario" required autofocus>
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-user"></span>
            </div>
          </div>
        </div>
        @if ($errors->has('nombre_usuario'))
          <span class="text-danger text-left">{{ $errors->first('nombre_usuario') }}</span>
        @endif

        <div class="input-group mb-3">
          <input type="password" name="contrasena" class="form-control" value="{{ old('contrasena') }}" placeholder="Contraseña" required>
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-lock"></span>
            </div>
          </div>
        </div>
        @if ($errors->has('contrasena'))
          <span class="text-danger text-left">{{ $errors->first('contrasena') }}</span>
        @endif

        <div class="row mb-3">
          <div class="col-12 text-center">
            <div class="icheck-primary">
              <input type="checkbox" id="remember" name="remember">
              <label for="remember">Recordar mi nombre de usuario</label>
            </div>
          </div>
        </div>

        <div class="row">
          <div class="col-12">
            <button type="submit" class="btn btn-primary btn-block">Acceder</button>
          </div>
        </div>

        @if (isset($mensaje) && $mensaje != null)
          <div class="d-flex align-items-center justify-content-center pb-4">
            <p style="color:red;" class="mb-0 me-2">{{$mensaje}}</p>
          </div>
        @endif
      </form>

      <br><a href="forgot-password">Olvide mi usuario o contraseña</a>
      <p class="mb-1">
        
      </p>
    </div>
  </div>

  <!-- jQuery -->
  <script src="../../plugins/jquery/jquery.min.js"></script>
  <!-- Bootstrap 4 -->
  <script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
  <!-- AdminLTE App -->
  <script src="../../dist/js/adminlte.min.js"></script>
</body>

</html>
