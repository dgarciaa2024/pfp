@extends('layouts.principal')

@section('title', 'Cambiar Contraseña')

@section('content')
<div class="container-fluid d-flex justify-content-center align-items-center" style="height: 100vh;">
    <div class="col-md-8 col-lg-6">
        <div class="card shadow-sm">
            <div class="card-header text-center bg-primary text-white">
                <h4>Cambiar Contraseña</h4>
            </div>

            <div class="card-body">
                <!-- Mensajes de éxito -->
                @if(session('success'))
                    <div class="alert alert-success">{{ session('success') }}</div>
                @endif

                <!-- Mensajes de error -->
                @if($errors->any())
                    <div class="alert alert-danger">
                        <ul>
                            @foreach($errors->all() as $error)
                                <li>{{ $error }}</li>
                            @endforeach
                        </ul>
                    </div>
                @endif

                <!-- Formulario -->
                <form action="{{ route('cambiar-contrasena.store') }}" method="POST">
                    @csrf

                    <div class="row mb-3 justify-content-center">
                        <div class="col-md-8">
                            <label for="contrasena_actual" class="d-block text-center">Contraseña Actual:</label>
                            <div class="input-group">
                                <input type="password" name="contrasena_actual" id="contrasena_actual" class="form-control form-control-sm" required>
                                <span class="input-group-text">
                                    <i class="fa fa-lock text-primary"></i>
                                </span>
                            </div>
                            @error('contrasena_actual')
                                <small class="text-danger d-block text-center">{{ $message }}</small>
                            @enderror
                        </div>
                    </div>

                    <div class="row mb-3 justify-content-center">
                        <div class="col-md-8">
                            <label for="nueva_contrasena" class="d-block text-center">Nueva Contraseña:</label>
                            <div class="input-group">
                                <input type="password" name="nueva_contrasena" id="nueva_contrasena" class="form-control form-control-sm" required>
                                <span class="input-group-text">
                                    <i class="fa fa-lock text-primary"></i>
                                </span>
                            </div>
                            @error('nueva_contrasena')
                                <small class="text-danger d-block text-center">{{ $message }}</small>
                            @enderror
                        </div>
                    </div>

                    <div class="row mb-3 justify-content-center">
                        <div class="col-md-8">
                            <label for="confirmar_contrasena" class="d-block text-center">Confirmar Nueva Contraseña:</label>
                            <div class="input-group">
                                <input type="password" name="confirmar_contrasena" id="confirmar_contrasena" class="form-control form-control-sm" required>
                                <span class="input-group-text">
                                    <i class="fa fa-lock text-primary"></i>
                                </span>
                            </div>
                            @error('confirmar_contrasena')
                                <small class="text-danger d-block text-center">{{ $message }}</small>
                            @enderror
                        </div>
                    </div>

                    <div class="text-center mt-4">
                        <button type="submit" class="btn btn-primary btn-sm">Cambiar Contraseña</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
@endsection
