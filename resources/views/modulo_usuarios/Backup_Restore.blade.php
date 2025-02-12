@extends ('layouts.principal')
@section('content')

<br>
<div value="{{$con=0}}"></div>
<section class="content">
  <div class="container-fluid">
    <div class="row">
      <div class="col-12">
        <!-- Tarjeta -->
        <div class="card">
          <!-- Tarjeta_CABEZA -->
          <div class="card-header">
            <h1 class="card-title">Backup y Restore de Base de Datos</h1>
            <div class="card-tools">
              <a href="{{ url('inicio') }}" class="btn btn-secondary">VOLVER</a>
            </div>
          </div>

          <div class="card-body">
            <!-- Mensajes de éxito o error -->
            @if (session('success'))
              <div class="alert alert-success" role="alert">
                {{ session('success') }}
              </div>
            @endif

            @if (session('error'))
              <div class="alert alert-danger" role="alert">
                {{ session('error') }}
              </div>
            @endif

            <!-- Crear Backup -->
            <div class="mb-4">
              <h3>Crear Backup</h3>
              <form action="{{ route('backup.restore.create') }}" method="POST">
                @csrf
                <button type="submit" class="btn btn-primary">Crear Backup</button>
              </form>
            </div>

            <!-- Restaurar Backup -->
            <div>
              <h3>Restaurar Backup</h3>
              <form action="{{ route('backup.restore.restore') }}" method="POST" enctype="multipart/form-data">
                @csrf
                <div class="form-group">
                  <label for="backup_file">Seleccionar Archivo</label>
                  <input type="file" name="backup_file" id="backup_file" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-success">Restaurar Backup</button>
              </form>
            </div>
          </div>
        </div>
        <!-- FIN_Tarjeta -->
      </div>
    </div>
  </div>
</section>
@endsection
