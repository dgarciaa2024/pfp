@extends ('layouts.principal')
@section('content')
<div class="container-fluid d-flex justify-content-center align-items-center" style="height: 100vh;">
    <div class="col-md-8 col-lg-6">
        <div class="card shadow-sm">
            <div class="card-header text-center bg-primary text-white">
                <h4>ADMINISTRAR PERFIL</h4>
            </div>

            <div class="card-body text-center">
                <!-- Imagen de perfil con ícono para cambiarla -->
                <div class="text-center mb-4 position-relative">
                    <img src="{{ asset('../../dist/img/Foto_perfil.png') }}" alt="Imagen de Perfil" class="rounded-circle img-thumbnail" style="width: 120px; height: 120px;">
                    <a href="#" class="position-absolute" style="bottom: 5px; right: 5px; background-color: rgba(0, 0, 0, 0.6); border-radius: 50%; padding: 5px;" onclick="document.getElementById('profile_image').click();">
                     <!--    <i class="fa fa-camera text-white" style="font-size: 18px;"></i>-->
                    </a>
                </div>

                <!-- Botón Cambiar Contraseña -->
                <div class="text-center mb-4">
                    <a href="CambiarContrasena" class="btn btn-primary btn-sm">Cambiar Contraseña</a>
                </div>

                <!-- Formulario de perfil -->
                <form action="{{ route('administrarPerfil.actualizarDatos') }}" method="POST">
                    @csrf
                    @method('PUT')

                    <!-- Campos bloqueados -->
                    <div class="row mb-3 justify-content-center">
                        <div class="col-md-4">
                            <label for="nombre" class="d-block text-center">Nombre:</label>
                            <input type="text" id="nombre" class="form-control form-control-sm" value="{{ $paciente->nombre_paciente ?? '' }}" readonly>
                        </div>

                        <div class="col-md-4">
                            <label for="apellido" class="d-block text-center">Apellido:</label>
                            <input type="text" id="apellido" class="form-control form-control-sm" value="{{ $paciente->apellido_paciente ?? '' }}" readonly>
                        </div>

                        <div class="col-md-4">
                            <label for="dni" class="d-block text-center">DNI:</label>
                            <input type="text" id="dni" class="form-control form-control-sm" value="{{ $paciente->dni_paciente ?? '' }}" readonly>
                        </div>
                    </div>

                    <div class="row mb-3 justify-content-center">
                        <div class="col-md-4">
                            <label for="fecha_nacimiento" class="d-block text-center">Fecha de Nacimiento:</label>
                            <input type="text" id="fecha_nacimiento" class="form-control form-control-sm" value="{{ $paciente->fecha_nacimiento ?? '' }}" readonly>
                        </div>

                        <div class="col-md-4">
                            <label for="genero" class="d-block text-center">Género:</label>
                            <input type="text" id="genero" class="form-control form-control-sm" value="{{ $paciente->genero ?? '' }}" readonly>
                        </div>
                    </div>

                    <!-- Campos editables con íconos -->
                    <div class="row mb-3 justify-content-center">
                        <div class="col-md-4">
                            <label for="celular" class="d-block text-center">Celular:</label>
                            <div class="input-group">
                                <input type="text" id="celular" name="celular" class="form-control form-control-sm" value="{{ $paciente->celular ?? '' }}" maxlength="15">
                                <span class="input-group-text">
                                    <i class="fa fa-pencil-alt text-primary"></i>
                                </span>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <label for="email" class="d-block text-center">Email:</label>
                            <div class="input-group">
                                <input type="email" id="email" name="email" class="form-control form-control-sm" value="{{ $paciente->email ?? '' }}" readonly>
                                <span class="input-group-text">
                                   <!--  <i class="fa fa-pencil-alt text-primary"></i> -->
                                </span>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <label for="direccion" class="d-block text-center">Dirección:</label>
                            <div class="input-group">
                                <input type="text" id="direccion" name="direccion" class="form-control form-control-sm" value="{{ $paciente->direccion ?? '' }}" maxlength="255">
                                <span class="input-group-text">
                                    <i class="fa fa-pencil-alt text-primary"></i>
                                </span>
                            </div>
                        </div>
                    </div>

                    <!-- Botón Actualizar Información -->
                    <div class="text-center mt-4">
                        <button type="submit" class="btn btn-success btn-sm">Actualizar mi Información</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- NUEVO MODAL DE ÉXITO -->
<div class="modal fade" id="modal-success">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header bg-success">
        <h4 class="modal-title">¡Éxito!</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">×</span>
        </button>
      </div>
      <div class="modal-body">
        <p>La información se ha actualizado exitosamente.</p>
      </div>
      <div class="modal-footer justify-content-end">
        <button type="button" class="btn btn-primary" data-dismiss="modal">Aceptar</button>
      </div>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<!-- Script para mostrar el modal de éxito -->
@if(session('success'))
<script>
    $(document).ready(function() {
        $('#modal-success').modal('show');
    });
</script>
@endif

@endsection