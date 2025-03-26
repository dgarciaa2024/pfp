@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">Recuperar Contraseña</div>
                <div class="card-body">
                    @if (session('error'))
                        <div class="alert alert-danger">{{ session('error') }}</div>
                    @endif
                    @if (session('success'))
                        <div class="alert alert-success">{{ session('success') }}</div>
                    @endif
                    <form method="POST" action="{{ route('forgot.password') }}">
                        @csrf
                        <div class="form-group">
                            <label for="usuario">Usuario</label>
                            <input type="text" id="usuario" name="usuario" class="form-control" required autofocus>
                        </div>
                        <button type="submit" class="btn btn-primary mt-3">Enviar Correo de Recuperación</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection