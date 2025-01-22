@extends('layouts.principal')

@section('content')

<div class="container-fluid">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header text-center">
                    <h5 class="card-title">Crear Backup y Restaurar</h5>
                </div>

                <div class="card-body text-center">
                    <!-- Sección de Backup -->
                    <div class="mb-5">
                        <h4>Crear Backup / Restaurar</h4>
                        <br></br>

                        <div class="d-flex flex-column align-items-center">
                            <h4>
                                <i class="fas fa-database"></i> Crear Backup
                            </h4>
                            <p>Puedes crear un respaldo de la base de datos desde aquí.</p>
                            <form action="{{ route('backup.create') }}" method="POST">
    @csrf
    <button type="submit" class="btn btn-primary">Crear Backup</button>
</form> 
                        </div>
                    </div>

                    <!-- Sección de Restore -->
                    <div class="mb-5">
                        <div class="d-flex flex-column align-items-center">
                            <h4>
                                <i class="fas fa-undo"></i> Restaurar Backup
                            </h4>
                            <p>Selecciona un archivo de respaldo para restaurar la base de datos.</p>
                            <form action="{{ route('backup.restore') }}" method="POST" enctype="multipart/form-data">
                                @csrf
                                <div class="form-group">
                                    <label for="backup_file">Seleccionar archivo</label>
                                    <input type="file" class="form-control-file" id="backup_file" name="backup_file">
                                </div>
                                <button type="submit" class="btn btn-danger">Restaurar Backup</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
