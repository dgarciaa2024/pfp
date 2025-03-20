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
              <h1 class="card-title">LISTA DE PARAMETROS</h1>
              <div class="card-tools">
                  <!-- Botón NUEVO condicionado a permiso de inserción -->
                  @if ($permiso_insercion == 1)
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-default">+ NUEVO</button>
                            @endif
                            <a href="{{ url('inicio') }}" class="btn btn-secondary">VOLVER</a>
              </div>
            </div>

            <!-- /.INICIO DE LA TABLA -->
            <div class="card-body table-responsive">
              <table id="example2" class="table table-bordered table-striped table-hover table-sm text-center">
                <thead class="bg-danger text-white">
                  <tr>
                    <th>Codigo</th>
                    <th>Parametro</th>
                    <th>Valor</th>
                    <th>Usuario</th>
                    <th>Fecha Creacion</th>
                    <th>Creado Por</th>
                    <th>Accion</th>
                  </tr>
                </thead>
                <tbody>
                  @foreach ($Parametros as $Parametro)
                  <tr>
                    <td>{{ $Parametro['id_parametro'] }}</td>
                    <td>{{ $Parametro['parametro'] }}</td>
                    <td>{{ $Parametro['valor'] }}</td>
                    <td>{{ $Parametro['nombre_usuario'] }}</td>
                    <td>{{ $Parametro['fecha_creacion'] }}</td>
                    <td>{{ $Parametro['creado_por'] }}</td>

                    <th>
                      <div class="btn-group" role="group" aria-label="Basic example">
                      @if ($permiso_actualizacion == 1)
                                                    <a type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-editor-{{ $Parametro['id_parametro'] }}">
                                                        <i class="bi bi-pencil-fill"></i> ACTUALIZAR
                                                    </a>
                                                    @endif
                        <!-- Botón de eliminar -->
                        <a type="button" class="btn btn-danger" data-toggle="modal" data-target="#modal-delete-{{$Parametro['id_parametro']}}">Eliminar <i class="bi bi-trash-fill"></i> </a>
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


  <!-- MODAL EDITAR LABORATORIO -->



  <!--MODAL EDITAR-->
  @foreach ($Parametros as $Parametro)
  <div class="modal fade" id="modal-editor-{{$Parametro['id_parametro']}}">
    <div class="modal-dialog">
      <div class="modal-content">

        <div class="modal-header">
          <h4 class="modal-title">Actualizar Parametro</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>

        <form action="editar_parametro" method="post">
          @csrf
          @method('PUT')
          <div class="modal-body">
            <div class="row">
              <input type="hidden" id="cod" name="cod" class="form-control" value="{{ $Parametro['id_parametro']}}" required>

              <div class="col-12">
                <div class="form-group">
                  <label for="">Parametro</label>
                  <input type="text" id="par" name="par" class="form-control" value="{{$Parametro['parametro']}}" required>
                </div>
              </div>

              <div class="col-12">
                <div class="form-group">
                  <label for="">Valor</label>
                  <input type="text" id="val" name="val" class="form-control" value="{{$Parametro['valor']}}" required>
                </div>
              </div>

            
              <div class="col-12">
                <div class="form-group">
                  <label for="">Usuario</label>
                  <select id="usuario" name="usuario" class="form-control" requied>
                    @foreach ($tblusuario as $tbl)
                    <option value="{{ $tbl['id_usuario']}}" selected >{{$tbl["nombre_usuario"]}}</option>
                    @endforeach
                  </select>
                </div>
              </div>


            </div>
          </div>
          <div class="modal-footer justify-content-between">
            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
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

  

  <!-- Modal para Eliminar Objeto -->
  @foreach ($Parametros as $Parametro)
  <div class="modal fade" id="modal-delete-{{$Parametro['id_parametro']}}">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">Eliminar Parametro</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>

        <!-- Formulario de eliminación -->
        <form action="{{ url('eliminar_parametro', $Parametro['id_parametro']) }}" method="POST">
          @csrf
          @method('DELETE')
          <div class="modal-body">
            <p>¿Estás seguro de que deseas eliminar el objeto "{{ $Parametro['parametro'] }}"?</p>
          </div>
          <div class="modal-footer justify-content-between">
            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
            <button type="submit" class="btn btn-danger">Eliminar</button>
          </div>
        </form>
      </div>
    </div>
  </div>
  @endforeach

  <!-- Modal para Agregar Nuevo Objeto -->
  <div class="modal fade" id="modal-default">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">AGREGAR UN NUEVO PARAMETRO</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>


      

        <!-- Formulario para Agregar parametro-->
        <form action="agregar_parametro" method="post">
          @csrf
          <div class="modal-body">
            <div class="row">

              <div class="col-12">
                <div class="form-group">
                  <label for="">Parametro</label>
                  <input type="text" id="par" name="par" class="form-control" required>
                </div>
              </div>

              <div class="col-12">
                <div class="form-group">
                  <label for="">Valor</label>
                  <input type="text" id="val" name="val" class="form-control" required>
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

                
            </div>
          </div>
          <div class="modal-footer justify-content-between">
            <button type="button" class="btn btn-default" data-dismiss="modal">CANCELAR</button>
            <button type="submit" class="btn btn-primary">AGREGAR</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
@if(session('success'))
<script>
    $(document).ready(function() {
        $('#modal-success').modal('show');
    });
</script>
@endif
@endsection
