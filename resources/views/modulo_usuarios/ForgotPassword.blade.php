@extends('layouts.app')

@section('content')
<div class="container mt-5">
    <h1>¿Olvidó su contraseña?</h1>
    <form action="{{ route('password.sendResetLink') }}" method="POST">
        @csrf
        <div class="form-group">
            <label for="email">Ingrese su email para enviar un correo electrónico de recuperación de contraseña</label>
            <input type="text" 
                   name="email" 
                   id="email" 
                   class="form-control" 
                   required 
                   minlength="{{ config('database.email_length') }}" 
                   maxlength="{{ config('database.email_length') }}" >
                   
            @error('email')
                <div class="alert alert-danger">{{ $message }}</div>
            @enderror
        </div>
        <button type="submit" class="btn btn-primary">Enviar</button>
    </form>
</div>
@endsection
