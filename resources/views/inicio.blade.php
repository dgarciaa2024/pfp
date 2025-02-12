@extends('layouts.principal')

@section('content')
    <h1>Bienvenido al Portal de fidelización, {{ auth()->user()->nombre_usuario }}.</h1>

    
@endsection