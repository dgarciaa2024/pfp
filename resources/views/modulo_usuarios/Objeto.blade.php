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
              <h1 class="card-title">LISTA DE OBJETOS</h1>
              <div class="card-tools">
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-default">Nuevo +</button>
                <a href="{{ url('inicio') }}" class="btn btn-secondary">VOLVER</a>
              </div>
            </div>

            <!-- /.INICIO DE LA TABLA -->
            <div class="card-body table-responsive">
              <table id="example1" class="table table-bordered table-striped table-hover table-sm text-center">
                <thead class="bg-danger text-white">
                  <tr>
                    <th>Codigo</th>
                    <th>Nombre Objeto</th>
                    <th>Descripcion</th>
                    <th>Estado</th>
                    <th>fecha creacion</th>
                    <th>Creado Por</th>
                    <th>Accion</th>
                  </tr>
                </thead>
                <tbody>
                  @foreach ($Objetos as $Objeto)
                  <tr>
                    <td>{{ $Objeto['id_objeto'] }}</td>
                    <td>{{ $Objeto['nombre_objeto'] }}</td>
                    <td>{{ $Objeto['descripcion'] }}</td>
                    <td>{{ $Objeto['estado_objeto'] }}</td>
                    <td>{{ $Objeto['fecha_creacion'] }}</td>
                    <td>{{ $Objeto['creado_por'] }}</td>

                    <th>
                      <div class="btn-group" role="group" aria-label="Basic example">
                        <a type="button" class="btn btn-success" data-toggle="modal" data-target="#modal-editor-{{$Objeto['id_objeto']}}">Actualizar <i class="bi bi-pencil-fill"></i> </a>
                        
                        <!-- Botón de eliminar -->
                        <a type="button" class="btn btn-danger" data-toggle="modal" data-target="#modal-delete-{{$Objeto['id_objeto']}}">Eliminar <i class="bi bi-trash-fill"></i> </a>
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
  @foreach ($Objetos as $Objeto)
  <div class="modal fade" id="modal-editor-{{$Objeto['id_objeto']}}">
    <div class="modal-dialog">
      <div class="modal-content">

        <div class="modal-header">
          <h4 class="modal-title">Actualizar Objeto</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>

        <form action="editar_objeto" method="post">
          @csrf
          @method('PUT')
          <div class="modal-body">
            <div class="row">
              <input type="hidden" id="cod" name="cod" class="form-control" value="{{ $Objeto['id_objeto']}}" required>

              <div class="col-12">
                <div class="form-group">
                  <label for="">Nombre</label>
                  <input type="text" id="nom" name="nom" class="form-control" value="{{$Objeto['nombre_objeto']}}" required>
                </div>
              </div>

              <div class="col-12">
                <div class="form-group">
                  <label for="">Descripcion</label>
                  <input type="text" id="des" name="des" class="form-control" value="{{$Objeto['descripcion']}}" required>
                </div>
              </div>

            
              <div class="col-12">
                <div class="form-group">
                  <label for="">Estado</label>
                  <select id="estdo" name="estdo" class="form-control" requied>
                    @foreach ($tblestado as $tbl)
                    <option value="{{ $tbl['id_estado']}}" selected>{{$tbl["estado"]}}</option>
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
  @foreach ($Objetos as $Objeto)
  <div class="modal fade" id="modal-delete-{{$Objeto['id_objeto']}}">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">Eliminar Objeto</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>

        <!-- Formulario de eliminación -->
        <form action="{{ url('eliminar_objeto', $Objeto['id_objeto']) }}" method="POST">
          @csrf
          @method('DELETE')
          <div class="modal-body">
            <p>¿Estás seguro de que deseas eliminar el objeto "{{ $Objeto['nombre_objeto'] }}"?</p>
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
          <h4 class="modal-title">AGREGAR UN NUEVO OBJETO</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>


      

        <!-- Formulario para Agregar Objeto -->
        <form action="agregar_objeto" method="post">
          @csrf
          <div class="modal-body">
            <div class="row">
              <div class="col-12">
                <div class="form-group">
                  <label for="">Nombre</label>
                  <input type="text" id="nom" name="nom" class="form-control" required>
                </div>
              </div>

              <div class="col-12">
                <div class="form-group">
                  <label for="">Descripcion</label>
                  <input type="text" id="des" name="des" class="form-control" required>
                </div>
              </div>

              <div class="col-12">
                <div class="form-group">
                  <label for="">Estado</label>
                  <select id="estdo" name="estdo" class="form-control" required>
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
    </div>
  </div>
</div>
@endsection
