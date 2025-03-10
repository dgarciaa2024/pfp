@extends('layouts.principal')
@section('content')

<div class="mt-4"></div> <!-- Reemplazo de <br> por margen superior -->

<section class="content">
  <div class="container-fluid">
    <div class="row justify-content-center">
      <div class="col-12 col-md-10 col-lg-8">
        <!-- Centrado y responsive -->
        <div class="card shadow-sm">
          <!-- Sombra sutil -->
          <!-- Card Header -->
          <div class="card-header bg-primary text-white">
            <!-- Fondo azul -->
            <div class="d-flex justify-content-between align-items-center">
              <h1 class="card-title mb-0">
                <i class="fas fa-database mr-2"></i> <!-- Icono de base de datos -->
                Backup y Restore de Base de Datos
              </h1>
              <a href="{{ url('inicio') }}" class="btn btn-light btn-sm">
                <i class="fas fa-arrow-left mr-2"></i>Volver
              </a>
            </div>
          </div>

          <!-- Card Body -->
          <div class="card-body">
            <!-- Mensajes -->
            @if (session('success'))
            <div class="alert alert-success alert-dismissible fade show" role="alert">
              <i class="fas fa-check-circle mr-2"></i>
              {{ session('success') }}
              <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            @endif

            @if (session('error'))
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
              <i class="fas fa-exclamation-circle mr-2"></i>
              {{ session('error') }}
              <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            @endif

            <!-- Sección Backup -->
            <div class="mb-5 p-3 bg-light rounded">
              <!-- Fondo claro y espaciado -->
              <h3 class="text-primary">
                <i class="fas fa-download mr-2"></i>Crear Backup
              </h3>
              <form action="{{ route('backup.download') }}" method="POST">
                @csrf
                <p class="text-muted mb-3">
                  El backup se generará y descargará automáticamente. Podrás elegir dónde guardarlo en tu computadora.
                </p>
                <button type="submit" class="btn btn-primary btn-lg">
                  <i class="fas fa-file-download mr-2"></i>Crear y Descargar
                </button>
              </form>
            </div>

            <!-- Sección Restore -->
            <div class="p-3 bg-light rounded">
              <h3 class="text-success">
                <i class="fas fa-upload mr-2"></i>Restaurar Backup
              </h3>
              <form action="{{ route('backup.restore') }}" method="POST" enctype="multipart/form-data">
                @csrf
                <div class="mb-3">
                  <label for="backup_file" class="form-label">Selecciona el archivo de backup</label>
                  <input class="form-control" type="file" id="backup_file" name="backup_file" accept=".sql" required>
                </div>
                <button type=" submit" class="btn btn-success btn-lg">
                  <i class="fas fa-sync-alt mr-2"></i>Restaurar Backup
                </button>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

@endsection
