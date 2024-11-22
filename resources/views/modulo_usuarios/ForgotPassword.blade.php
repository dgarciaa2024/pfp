@extends('layouts.app')


<div class="container">
    <h2>Recuperación de Contraseña</h2>
    <form action="{{ route('password.sendResetLink') }}" method="POST">
        @csrf
        <div class="form-group">
            <label for="usuario">Ingrese su usuario para enviar un correo electronico de recuperación de contraseña</label>
            <input type="text" name="usuario" id="usuario" class="form-control" required minlength="{{ config('database.usuario_length') }}" maxlength="{{ config('database.usuario_length') }}" style="text-transform: uppercase;">
            @error('usuario')
                <div class="alert alert-danger">{{ $message }}</div>
            @enderror
        </div>
        <button type="submit" class="btn btn-primary">Enviar</button>
    </form>
</div>
