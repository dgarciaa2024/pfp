@extends('layouts.principal')

@section('content')
    @if (session('error'))
        <div class="alert alert-danger">
            {{ session('error') }}
        </div>
    @endif
    <br>
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <!-- Tarjeta de Manual Instalación -->
                    <div class="card shadow-sm border-0">
                        <!-- Cabecera de la Tarjeta -->
                        <div class="card-header bg-white border-bottom-0 d-flex justify-content-between align-items-center">
                            <h1 class="card-title text-primary">Manual Instalación</h1>
                            <div class="card-tools">
                                <a href="{{ url('inicio') }}" class="btn btn-secondary">Volver</a>
                            </div>
                        </div>
                        <!-- Cuerpo de la Tarjeta -->
                        <div class="card-body">
                            @if(isset($enlaceCompleto) && !empty($enlaceCompleto))
                                <div class="embed-responsive embed-responsive-16by9">
                                    <iframe class="embed-responsive-item" 
                                            src="{{ $enlaceCompleto }}" 
                                            style="border: none;" 
                                            allowfullscreen>
                                        Este navegador no soporta PDFs. Por favor, descarga el archivo: 
                                        <a href="{{ $enlaceCompleto }}" class="text-primary">Descargar PDF</a>
                                    </iframe>
                                </div>
                            @else
                                <p class="text-danger">No se pudo cargar el manual de instalación.</p>
                            @endif
                        </div>
                    </div>
                    <!-- Fin de la Tarjeta -->
                </div>
            </div>
        </div>
    </section>
@endsection