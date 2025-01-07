@extends ('layouts.principal')
@section('content')
<div class="container-fluid py-4">
  <section class="content">
    <div class="container-fluid">
      <div class="row">
        <div class="col-12">
          <!-- Tarjeta -->
          <div class="card">
            <!-- Tarjeta Cabeza -->
            <div class="card-header">
              <h1 class="card-title">CONTACTOS</h1>
              <div class="card-tools">


              @if ($permiso_insercion == 1)
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-default">+ NUEVO</button>
                            @endif

                <!-- <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-default">Nuevo +</button>-->
                <a href="{{ url('inicio') }}" class="btn btn-secondary">VOLVER</a>

              </div>
            </div>

            <!-- /.INICIO DE LA TABLA -->
            <div class="card-body table-responsive">
              <table id="example1" class="table table-bordered table-striped table-hover table-sm text-center">
                <thead class="bg-danger text-white">
                  <tr>
                    <th>Id </th>
                    <th>Nombre</th>
                    <th>Usuario</th>
                    <th>Tipo Contacto</th>
                    <th>Telefono 1</th>
                    <th>Telefono 2</th>
                    <th>Email</th>
                    <th>Estado</th>
                    <th>Fecha Creacion</th>
                    <th>Creado Por</th>
                    <th>Accion</th>
                  </tr>
                </thead>
                <tbody>
                  @foreach ($Contactos as $Contacto)
                  <tr>
                    <td>{{ $Contacto['id_contacto'] }}</td>
                    <td>{{ $Contacto['nombre_contacto'] }}</td>
                    <td>{{ $Contacto['nombre_usuario'] }}</td>
                    <td>{{ $Contacto['tipo_contacto'] }}</td>
                    <td>{{ $Contacto['telefono_1'] }}</td>
                    <td>{{ $Contacto['telefono_2'] }}</td>
                    <td>{{ $Contacto['email'] }}</td>
                    <td>{{ $Contacto['estado'] }}</td>
                    <td>{{ $Contacto['fecha_creacion'] }}</td>
                    <td>{{ $Contacto['creado_por'] }}</td>
                                                              <th>
                      <div class="btn-group" role="group" aria-label="Basic example">
                      @if ($permiso_actualizacion == 1)
                                                    <a type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-editor-{{ $Contacto['id_contacto'] }}">
                                                        <i class="bi bi-pencil-fill"></i> ACTUALIZAR
                                                    </a>
                                                @endif
                      </div>
                    </th>

                  </tr>
                  @endforeach
                </tbody>
              </table>
            </div>
            <!-- FIN de la tabla -->
          </div>
          <!-- FIN de la tarjeta -->
        </div>
      </div>
    </div>
  </section>
</div>


<!-- MODAL EDITAR -->
@foreach ($Contactos as $Contacto)
<div class="modal fade" id="modal-editor-{{$Contacto['id_contacto']}}" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">Actualizar CONTACTO</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <!-- Formulario -->
      <form action="editar_contacto" method="post">
        @csrf
        @method('PUT')
        <div class="modal-body">
          <input type="hidden" id="cod" name="cod" value="{{ $Contacto['id_contacto'] }}" required>

          <div class="row">
            <!-- Campo Contacto -->
            <div class="col-12">
              <div class="form-group">
                <label for="">Contacto</label>
                <input type="text" id="nom_contacto" name="nom_contacto" class="form-control" value="{{ $Contacto['nombre_contacto'] }}" required>
              </div>
            </div>

            <!-- Campo Usuario -->
            <div class="col-12">
              <div class="form-group">
                <label for="">Usuario</label>
                <select id="usuario" name="usuario" class="form-control" required>
                  @foreach ($tblusuario as $tbl)
                  <option value="{{ $tbl['id_usuario'] }}">{{ $tbl['nombre_usuario'] }}</option>
                  @endforeach
                </select>
              </div>
            </div>

            <!-- Campo Tipo de Contacto -->
            <div class="col-12">
              <div class="form-group">
                <label for="">Tipo Contacto</label>
                <select id="tipo" name="tipo" class="form-control" required>
                  @foreach ($tbltipo as $tbl)
                  <option value="{{ $tbl['id_tipo_contacto'] }}">{{ $tbl['tipo_contacto'] }}</option>
                  @endforeach
                </select>
              </div>
            </div>

            <!-- Campo Teléfono 1 -->
            <div class="col-12">
              <div class="form-group">
                <label for="">Telefono 1</label>
                <input type="text" id="telefono_1" name="telefono_1" class="form-control" value="{{ $Contacto['telefono_1'] }}" required>
              </div>
            </div>

            <!-- Campo Teléfono 2 -->
            <div class="col-12">
              <div class="form-group">
                <label for="">Telefono 2</label>
                <input type="text" id="telefono_2" name="telefono_2" class="form-control" value="{{ $Contacto['telefono_2'] }}" required>
              </div>
            </div>

            <!-- Campo Email -->
            <div class="col-12">
              <div class="form-group">
                <label for="">Email</label>
                <input type="email" id="email" name="email" class="form-control" value="{{ $Contacto['email'] }}" required>
              </div>
            </div>

            <!-- Campo Estado -->
            <div class="col-12">
              <div class="form-group">
                <label for="">Estado</label>
                <select id="estdo" name="estdo" class="form-control" required>
                  @foreach ($tblestado as $tbl)
                  <option value="{{ $tbl['id_estado'] }}">{{ $tbl['estado'] }}</option>
                  @endforeach
                </select>
              </div>
            </div>
          </div>
        </div>

        <!-- Modal Footer -->
        <div class="modal-footer justify-content-between">
          <button type="button" class="btn btn-default" data-dismiss="modal">CANCELAR</button>
          <button type="submit" class="btn btn-primary">Actualizar</button>
        </div>
      </form>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
@endforeach





<!--AGREGAR TIPO  CONTACTO-->
<div class="modal fade" id="modal-default">
  <div class="modal-dialog">
    <div class="modal-content">


      <div class="modal-header">
        <h4 class="modal-title">AGREGAR CONTACTO</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <form action="agregar_contacto" method="post">
        @csrf
        <div class="modal-body">
          <div class="row">

            <div class="col-12">
              <div class="form-group">
                <label>Nombre Contacto</label>
                <input type="text" id="nom_contacto" name="nom_contacto" class="form-control" required>
              </div>
            </div>


            <div class="col-12">
              <div class="form-group">
                <label for="">Usuario</label>
                <select id="usuario" name="usuario" class="form-control" requied>
                  <option>SELECCIONA</option>
                  @foreach ($tblusuario as $tbl)
                  <option value="{{ $tbl['id_usuario']}}">{{$tbl["nombre_usuario"]}}</option>
                  @endforeach
                </select>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Tipo Contacto</label>
                <select id="tipo" name="tipo" class="form-control" requied>
                  <option>SELECCIONA</option>
                  @foreach ($tbltipo as $tbl)
                  <option value="{{ $tbl['id_tipo_contacto']}}">{{$tbl["tipo_contacto"]}}</option>
                  @endforeach
                </select>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Telefono</label>
                <input type="text" id="telefono_1" name="telefono_1" class="form-control" required>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Telefono 2</label>
                <input type="text" id="telefono_2" name="telefono_2" class="form-control" required>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Email </label>
                <input type="text" id="email" name="email" class="form-control" required>
              </div>
            </div>


            <div class="col-12">
              <div class="form-group">
                <label for="">Estado</label>
                <select id="estdo" name="estdo" class="form-control" requied>
                  <option>SELECCIONA</option>
                  @foreach ($tblestado as $tbl)
                  <option value="{{ $tbl['id_estado']}}">{{$tbl["estado"]}}</option>
                  @endforeach
                </select>
              </div>
            </div>

          </div>
        </div>
        <div class="modal-footer justify-content-between">
          <button type="button" class="btn btn-default" data-dismiss="modal">CANCELAR</button>
          <button type="submit" class="btn btn-primary">AGREGAR</button>
        </div>
      </form>

    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</div>
<!-- /.modal -->



@endsection()
