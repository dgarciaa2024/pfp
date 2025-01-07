@extends('layouts.app')

@section('content')
<div class="container mt-5">
    <h1>¿Olvidó su contraseña?</h1>
    <form action="{{ route('password.sendResetLink') }}" method="POST">
        @csrf
        <div class="form-group">
            <label for="usuario">Ingrese su usuario para enviar un correo electrónico de recuperación de contraseña</label>
            <input type="text" 
                   name="usuario" 
                   id="usuario" 
                   class="form-control" 
                   required 
                   minlength="{{ config('database.usuario_length') }}" 
                   maxlength="{{ config('database.usuario_length') }}" 
                   style="text-transform: uppercase;">
            @error('usuario')
                <div class="alert alert-danger">{{ $message }}</div>
            @enderror
        </div>
        <button type="submit" class="btn btn-primary">Enviar</button>
    </form>
</div>
@endsection