@extends ('layouts.principal')

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
                            <button type="button" class="btn btn-primary">Crear Backup</button>
                        </div>
                    </div>

                    <!-- Sección de Restore -->
                    <div class="mb-5">
                        <div class="d-flex flex-column align-items-center">
                            <h4>
                                <i class="fas fa-undo"></i> Restaurar Backup
                            </h4>
                            <p>Selecciona un archivo de respaldo para restaurar la base de datos.</p>
                            <form style="max-width: 400px;">
                                <div class="form-group">
                                    <label for="backup_file">Seleccionar archivo</label>
                                    <input type="file" class="form-control-file" id="backup_file" name="backup_file">
                                </div>
                                <button type="button" class="btn btn-danger">Restaurar Backup</button>
                            </form>
                        </div>
                    </div>

                    <!-- Sección de Lista de Backups -->
                    <!-- Esta sección está comentada en tu código original -->
                    <!--
                    <div class="mb-5">
                        <h4>Backups Disponibles</h4>
                        <p>Listado de backups existentes.</p>
                        <table class="table table-bordered mx-auto" style="max-width: 600px;">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Nombre del Backup</th>
                                    <th>Fecha de Creación</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>1</td>
                                    <td>backup_2024_08_20.sql</td>
                                    <td>20/08/2024</td>
                                    <td>
                                        <button type="button" class="btn btn-info">Descargar</button>
                                        <button type="button" class="btn btn-danger">Eliminar</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td>backup_2024_07_15.sql</td>
                                    <td>15/07/2024</td>
                                    <td>
                                        <button type="button" class="btn btn-info">Descargar</button>
                                        <button type="button" class="btn btn-danger">Eliminar</button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    -->
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
