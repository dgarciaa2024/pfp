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
                    <!-- Tarjeta de Bienvenida -->
                    <div class="card shadow-sm border-0">
                        <!-- Cabecera de la Tarjeta -->
                        <div class="card-header bg-white border-bottom-0 text-center">
                            <h1 class="card-title text-primary">Bienvenido al Portal de Fidelización</h1>
                        </div>
                        <!-- Cuerpo de la Tarjeta -->
                        <div class="card-body">
                            <div class="text-center">
                                <h2 class="text-dark">Hola, {{ auth()->user()->nombre_usuario }}.</h2>
                                <p class="lead text-muted">La salud de nuestros pacientes es lo más importante. Con nuestro Portal de Fidelización de Pacientes, obtén tus medicamentos de forma segura y sin contratiempos.</p>
                                <br><br>

                                <!-- Iconos de Acceso Rápido -->
                                <div class="row justify-content-center">
                                    @if(auth()->user()->id_rol == 1) <!-- Administrador -->
                                        <!-- Usuarios -->
                                        <div class="col-md-2 mb-4">
                                            <div class="card h-100 shadow-sm border-0">
                                                <a href="{{ url('/Usuarios') }}" class="text-decoration-none">
                                                    <div class="card-body text-center">
                                                        <i class="fas fa-users fa-3x text-primary mb-3"></i>
                                                        <h5 class="card-title text-secondary">Usuarios</h5>
                                                    </div>
                                                </a>
                                            </div>
                                        </div>

                                        <!-- Backup -->
                                        <div class="col-md-2 mb-4">
                                            <div class="card h-100 shadow-sm border-0">
                                                <a href="{{ url('/Backup_Restore') }}" class="text-decoration-none">
                                                    <div class="card-body text-center">
                                                        <i class="fas fa-database fa-3x text-warning mb-3"></i>
                                                        <h5 class="card-title text-secondary">Backup</h5>
                                                    </div>
                                                </a>
                                            </div>
                                        </div>

                                        <!-- Permisos -->
                                        <div class="col-md-2 mb-4">
                                            <div class="card h-100 shadow-sm border-0">
                                                <a href="{{ url('/Permisos') }}" class="text-decoration-none">
                                                    <div class="card-body text-center">
                                                        <i class="fas fa-key fa-3x text-danger mb-3"></i>
                                                        <h5 class="card-title text-secondary">Permisos</h5>
                                                    </div>
                                                </a>
                                            </div>
                                        </div>

                                    @elseif(auth()->user()->id_rol == 2) <!-- Laboratorio -->
                                        <!-- Farmacias -->
                                        <div class="col-md-2 mb-4">
                                            <div class="card h-100 shadow-sm border-0">
                                                <a href="{{ url('/Farmacias') }}" class="text-decoration-none">
                                                    <div class="card-body text-center">
                                                        <i class="fas fa-clinic-medical fa-3x text-primary mb-3"></i>
                                                        <h5 class="card-title text-secondary">Farmacias</h5>
                                                    </div>
                                                </a>
                                            </div>
                                        </div>

                                        <!-- Facturas -->
                                        <div class="col-md-2 mb-4">
                                            <div class="card h-100 shadow-sm border-0">
                                                <a href="{{ url('/Facturas') }}" class="text-decoration-none">
                                                    <div class="card-body text-center">
                                                        <i class="fas fa-file-invoice fa-3x text-danger mb-3"></i>
                                                        <h5 class="card-title text-secondary">Facturas</h5>
                                                    </div>
                                                </a>
                                            </div>
                                        </div>

                                        <!-- Canjes -->
                                        <div class="col-md-2 mb-4">
                                            <div class="card h-100 shadow-sm border-0">
                                                <a href="{{ url('/Canjes') }}" class="text-decoration-none">
                                                    <div class="card-body text-center">
                                                        <i class="fas fa-exchange-alt fa-3x text-success mb-3"></i>
                                                        <h5 class="card-title text-secondary">Canjes</h5>
                                                    </div>
                                                </a>
                                            </div>
                                        </div>

                                        <!-- Productos -->
                                        <div class="col-md-2 mb-4">
                                            <div class="card h-100 shadow-sm border-0">
                                                <a href="{{ url('/Productos') }}" class="text-decoration-none">
                                                    <div class="card-body text-center">
                                                        <i class="fas fa-pills fa-3x text-info mb-3"></i>
                                                        <h5 class="card-title text-secondary">Productos</h5>
                                                    </div>
                                                </a>
                                            </div>
                                        </div>

                                    @elseif(auth()->user()->id_rol == 4) <!-- Distribuidor -->
                                        <!-- Canjes -->
                                        <div class="col-md-2 mb-4">
                                            <div class="card h-100 shadow-sm border-0">
                                                <a href="{{ url('/Canjes') }}" class="text-decoration-none">
                                                    <div class="card-body text-center">
                                                        <i class="fas fa-exchange-alt fa-3x text-success mb-3"></i>
                                                        <h5 class="card-title text-secondary">Canjes</h5>
                                                    </div>
                                                </a>
                                            </div>
                                        </div>

                                        <!-- Productos -->
                                        <div class="col-md-2 mb-4">
                                            <div class="card h-100 shadow-sm border-0">
                                                <a href="{{ url('/Productos') }}" class="text-decoration-none">
                                                    <div class="card-body text-center">
                                                        <i class="fas fa-pills fa-3x text-info mb-3"></i>
                                                        <h5 class="card-title text-secondary">Productos</h5>
                                                    </div>
                                                </a>
                                            </div>
                                        </div>

                                    @elseif(auth()->user()->id_rol == 5) <!-- Farmacia -->
                                        <!-- Pacientes -->
<div class="col-md-2 mb-4">
    <div class="card h-100 shadow-sm border-0">
        <a href="{{ url('/Pacientes') }}" class="text-decoration-none">
            <div class="card-body text-center">
                <i class="fas fa-user fa-3x text-primary mb-3"></i> <!-- Icono de usuario -->
                <h5 class="card-title text-secondary">Pacientes</h5>
            </div>
        </a>
    </div>
</div>
                                        <!-- Facturas -->
                                        <div class="col-md-2 mb-4">
                                            <div class="card h-100 shadow-sm border-0">
                                                <a href="{{ url('/Facturas') }}" class="text-decoration-none">
                                                    <div class="card-body text-center">
                                                        <i class="fas fa-file-invoice fa-3x text-danger mb-3"></i>
                                                        <h5 class="card-title text-secondary">Facturas</h5>
                                                    </div>
                                                </a>
                                            </div>
                                        </div>

                                        <!-- Canjes -->
                                        <div class="col-md-2 mb-4">
                                            <div class="card h-100 shadow-sm border-0">
                                                <a href="{{ url('/Canjes') }}" class="text-decoration-none">
                                                    <div class="card-body text-center">
                                                        <i class="fas fa-exchange-alt fa-3x text-success mb-3"></i>
                                                        <h5 class="card-title text-secondary">Canjes</h5>
                                                    </div>
                                                </a>
                                            </div>
                                        </div>

                                    @elseif(auth()->user()->id_rol == 3) <!-- Cliente -->
                                        <!-- Canjes -->
                                        <div class="col-md-2 mb-4">
                                            <div class="card h-100 shadow-sm border-0">
                                                <a href="{{ url('/Canjes') }}" class="text-decoration-none">
                                                    <div class="card-body text-center">
                                                        <i class="fas fa-exchange-alt fa-3x text-success mb-3"></i>
                                                        <h5 class="card-title text-secondary">Canjes</h5>
                                                    </div>
                                                </a>
                                            </div>
                                        </div>

                                        <!-- Facturas -->
                                        <div class="col-md-2 mb-4">
                                            <div class="card h-100 shadow-sm border-0">
                                                <a href="{{ url('/Facturas') }}" class="text-decoration-none">
                                                    <div class="card-body text-center">
                                                        <i class="fas fa-file-invoice fa-3x text-danger mb-3"></i>
                                                        <h5 class="card-title text-secondary">Facturas</h5>
                                                    </div>
                                                </a>
                                            </div>
                                        </div>
                                    @endif
                                </div>

                                <!-- Mensaje Motivacional -->
                                <div class="row justify-content-center mt-4">
                                    <div class="col-md-8">
                                        <div class="card bg-light border-0 shadow-sm">
                                            <div class="card-body text-center">
                                                <p class="h5 text-muted">¡Gracias por confiar en nosotros! Tu salud es nuestra prioridad.</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Fin de la Tarjeta de Bienvenida -->
                </div>
            </div>
        </div>
    </section>
@endsection