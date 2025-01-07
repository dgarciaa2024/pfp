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
              <h1 class="card-title">LISTA DE PERMISOS</h1>
              <div class="card-tools">
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-default">Nuevo</button>
                <a href="{{ url('inicio') }}" class="btn btn-secondary">VOLVER</a>
              </div>
            </div>

            <!-- /.INICIO DE LA TABLA -->
            <div class="card-body table-responsive">
              <table id="example1" class="table table-bordered table-striped table-hover table-sm text-center">
                <thead class="bg-danger text-white">
                  <tr>
                    <th>Codigo</th>
                    <th>Rol</th>
                    <th>objeto</th>
                    <th>Permiso Creacion</th>
                    <th>Permiso Actualizacion</th>
                    <th>Permiso Eliminacion</th>
                    <th>Permiso Consultar</th>
                    <th>Estado</th>
                    <th>fecha creacion</th>
                    <th>Creado Por</th>
                    <th>Accion</th>
                  </tr>
                </thead>
                <tbody>
                  @foreach ($permisos as $permiso)
                  <tr>
    <td>{{ $permiso['id_permiso'] }}</td>
    <td>{{ $permiso['rol'] }}</td>
    <td>{{ $permiso['objeto'] }}</td>
    <td>{{ $permiso['permiso_creacion'] ? '1' : '0' }}</td>
    <td>{{ $permiso['permiso_actualizacion'] ? '1' : '0' }}</td>
    <td>{{ $permiso['permiso_eliminacion'] ? '1' : '0' }}</td>
    <td>{{ $permiso['permiso_consultar'] ? '1' : '0' }}</td>
    <td>{{ $permiso['estado'] }}</td>
    <td>{{ $permiso['fecha_creacion'] }}</td>
    <td>{{ $permiso['creado_por'] }}</td>

    <td> 
                      <div class="btn-group" role="group" aria-label="Basic example">
                        <a type="button" class="btn btn-success" data-toggle="modal" data-target="#modal-editor-{{$permiso['id_permiso']}}">Actualizar <i class="bi bi-pencil-fill"></i> </a>
                        <!-- Botón de eliminar -->
                        <a type="button" class="btn btn-danger" data-toggle="modal" data-target="#modal-delete-{{$permiso['id_permiso']}}">Eliminar <i class="bi bi-trash-fill"></i> </a>
                      </div>
                      </td>
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
  @foreach ($permisos as $permiso)
  <div class="modal fade" id="modal-editor-{{$permiso['id_permiso']}}">
    <div class="modal-dialog">
      <div class="modal-content">

        <div class="modal-header">
          <h4 class="modal-title">Actualizar Permiso</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>

        <form action="editar_permiso" method="post">
          @csrf
          @method('PUT')
          <div class="modal-body">
            <div class="row">
              <input type="hidden" id="cod" name="cod" class="form-control" value="{{$permiso['id_permiso']}}" required>

              <div class="col-12">
              <div class="form-group">
                <label for="">Rol</label>
                <select id="rol" name="rol" class="form-control" requied>
                  @foreach ($tblrol as $tbl)
                  <option value="{{ $tbl['id_rol']}}"   selected>  {{$tbl["rol"]}}</option>
                  @endforeach
                </select>
              </div>
            </div>


            <div class="col-12">
              <div class="form-group">
                <label for="">Objeto</label>
                <select id="objeto" name="objeto" class="form-control" requied>
                  @foreach ($tblobjeto as $tbl)
                  <option value="{{ $tbl['id_objeto']}}"   selected>  {{$tbl["nombre_objeto"]}}</option>
                  @endforeach
                </select>
              </div>
            </div>



              <div class="col-12">
                <div class="form-group">
                  <label for="">Permiso Creacion</label>
                  <input type="text" id="permiso_creacion" name="permiso_creacion" class="form-control" value="{{$permiso['permiso_creacion']}}" >
                </div>
              </div>

              <div class="col-12">
                <div class="form-group">
                  <label for="">Permiso Actualizacion</label>
                  <input type="text" id="permiso_actualizacion" name="permiso_actualizacion" class="form-control" value="{{$permiso['permiso_actualizacion']}}" >
                </div>
              </div>
              
              <div class="col-12">
                <div class="form-group">
                  <label for="">Permiso Eliminacion</label>
                  <input type="text" id="permiso_eliminacion" name="permiso_eliminacion" class="form-control" value="{{$permiso['permiso_eliminacion']}}" >
                </div>
              </div>

              <div class="col-12">
                <div class="form-group">
                  <label for="">Permiso Consultar</label>
                  <input type="text" id="permiso_consultar" name="permiso_consultar" class="form-control" value="{{$permiso['permiso_consultar']}}" >
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
  @foreach ($permisos as $permiso)
  <div class="modal fade" id="modal-delete-{{$permiso['id_permiso']}}">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">Eliminar Permiso</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>

        <!-- Formulario de eliminación -->
        <form action="{{ url('eliminar_permiso', $permiso['id_permiso']) }}" method="POST">
          @csrf
          @method('DELETE')
          <div class="modal-body">
            <p>¿Estás seguro de que deseas eliminar el permiso "{{ $permiso['id_permiso'] }}"?</p>
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
          <h4 class="modal-title">AGREGAR UN NUEVO PERMISO</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>


      

        <!-- Formulario para Agregar permiso-->
        <form action="agregar_permiso" method="post">
          @csrf
          <div class="modal-body">
            <div class="row">

            <div class="col-12">
              <div class="form-group">
                <label for="">Rol</label>
                <select id="rol" name="rol" class="form-control" requied>
                <option>SELECCIONA</option>
                  @foreach ($tblrol as $tbl)
                  <option value="{{ $tbl['id_rol']}}" selected> {{$tbl["rol"]}}</option>
                  @endforeach
                </select>
              </div>
            </div>


            <div class="col-12">
              <div class="form-group">
                <label for="">Objeto</label>
                <select id="objeto" name="objeto" class="form-control" requied>
                <option>SELECCIONA</option>
                  @foreach ($tblobjeto as $tbl)
                  <option value="{{ $tbl['id_objeto']}}" selected> {{$tbl["nombre_objeto"]}}</option>
                  @endforeach
                </select>
              </div>
            </div>



              <div class="col-12">
                <div class="form-group">
                  <label for="">Permiso Creacion</label>
                  <input type="text" id="permiso_creacion" name="permiso_creacion" class="form-control">
                </div>
              </div>

              <div class="col-12">
                <div class="form-group">
                  <label for="">Permiso Actualizacion</label>
                  <input type="text" id="permiso_actualizacion" name="permiso_actualizacion" class="form-control" >
                </div>
              </div>
              
              <div class="col-12">
                <div class="form-group">
                  <label for="">Permiso Eliminacion</label>
                  <input type="text" id="permiso_eliminacion" name="permiso_eliminacion" class="form-control" >
                </div>
              </div>

              <div class="col-12">
                <div class="form-group">
                  <label for="">Permiso Consultar</label>
                  <input type="text" id="permiso_consultar" name="permiso_consultar" class="form-control" >
                </div>
              </div>

             
              <div class="col-12">
                <div class="form-group">
                  <label for="">Estado</label>
                  <select id="estdo" name="estdo" class="form-control" requied>
                  <option>SELECCIONA</option>
                    @foreach ($tblestado as $tbl)
                    <option value="{{ $tbl['id_estado']}}" selected>{{$tbl["estado"]}}</option>
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
