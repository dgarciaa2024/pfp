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
              <h1 class="card-title">LISTA DE FARMACIASSSSSSS 09012025---</h1>
              <div class="card-tools">
              @if($permiso_insercion == 1)
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-default">+NUEVO</button>
                            @endif
                <a href="{{ url('inicio') }}" class="btn btn-secondary">VOLVER</a>

              </div>
            </div>

            <!-- /.INICIO DE LA TABLA -->
            <div class="card-body table-responsive">
              <table id="example1" class="table table-bordered table-striped table-hover table-sm text-center">
                <thead class="bg-danger text-white">
                  <tr>
                    <th>Id</th>
                    <th>Rtn Farmacia</th>
                    <th>Nombre Farmacia</th>
                    <th>Sucursal</th>
                    <th>Usuario</th>
                    <th>Entidad</th>
                    <th>Estado</th>
                    <th>Contacto</th>
                    <th>Fecha Creacion</th>
                    <th>Creado Por</th>
                    <th>Accion</th>
                  </tr>
                </thead>
                <tbody>
                  @foreach ($Farmacias as $Farmacia)
                  <tr>
                    <td>{{ $Farmacia['id_farmacia'] }}</td>
                    <td>{{ $Farmacia['rtn_farmacia'] }}</td>
                    <td>{{ $Farmacia['nombre_farmacia'] }}</td>
                    <td>{{ $Farmacia['nombre_sucursal'] }}</td>
                    <td>{{ $Farmacia['nombre_usuario'] }}</td>
                    <td>{{ $Farmacia['tipo_entidad'] }}</td>
                    <td>{{ $Farmacia['estado'] }}</td>
                    <td>{{ $Farmacia['nombre_contacto'] }}</td>
                    <td>{{ $Farmacia['fecha_creacion'] }}</td>
                    <td>{{ $Farmacia['creado_por'] }}</td>
                    <th>
                      <div class="btn-group" role="group" aria-label="Basic example">

                      @if($permiso_actualizacion == 1)
                                                    <a type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-editor-{{$Farmacia['id_farmacia']}}">
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


<!--MODAL EDITAR-->
@foreach ($Farmacias as $Farmacia)
<div class="modal fade" id="modal-editor-{{$Farmacia['id_farmacia']}}">
  <div class="modal-dialog">
    <div class="modal-content">

      <div class="modal-header">
        <h4 class="modal-title">Actualizar FARMACIA</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <form action="editar_farmacia" method="post">
        @csrf
        @method('PUT')
        <div class="modal-body">
          <div class="row">
            <input type="hidden" id="cod" name="cod" class="form-control" value="{{ $Farmacia['id_farmacia']}}" required>

            <div class="col-12">
              <div class="form-group">
                <label for="">Rtn</label>
                <input type="text" id="rtn" name="rtn" class="form-control" value="{{$Farmacia['rtn_farmacia']}}" required>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Farmacia</label>
                <input type="text" id="nombre" name="nombre" class="form-control" value="{{$Farmacia['nombre_farmacia']}}" required>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Sucursal</label>
                <select id="sucursal" name="sucursal" class="form-control" requied>
                  @foreach ($tblsucursal as $tbl)
                  <option value="{{ $tbl['id_sucursal']}}">{{$tbl["nombre_sucursal"]}}</option>
                  @endforeach
                </select>
              </div>
            </div>


            <div class="col-12">
              <div class="form-group">
                <label for="">Usuario</label>
                <select id="usuario" name="usuario" class="form-control" requied>
                  @foreach ($tblusuario as $tbl)
                  <option value="{{ $tbl['id_usuario']}}">{{$tbl["nombre_usuario"]}}</option>
                  @endforeach
                </select>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Entidad</label>
                <select id="entidad" name="entidad" class="form-control" requied>
                  @foreach ($tblentidad as $tbl)
                  <option value="{{ $tbl['id_tipo_entidad']}}">{{$tbl["tipo_entidad"]}}</option>
                  @endforeach
                </select>
              </div>
            </div>


            <div class="col-12">
              <div class="form-group">
                <label for="">Estado</label>
                <select id="estdo" name="estdo" class="form-control" requied>
                  @foreach ($tblestado as $tbl)
                  <option value="{{ $tbl['id_estado']}}">{{$tbl["estado"]}}</option>
                  @endforeach
                </select>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Contacto</label>
                <select id="contacto" name="contacto" class="form-control" requied>
                  @foreach ($tblcontacto as $tbl)
                  <option value="{{ $tbl['id_contacto']}}">{{$tbl["nombre_contacto"]}}</option>
                  @endforeach
                </select>
              </div>
            </div>

          </div>
        </div>
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

<!--AGREGAR TIPO ENTIDAD-->



<div class="modal fade" id="modal-default">
  <div class="modal-dialog">
    <div class="modal-content">


      <div class="modal-header">
        <h4 class="modal-title">AGREGAR UN NUEVO FARMACIA</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <form action="agregar_farmacia" method="post">
        @csrf
        <div class="modal-body">
          <div class="row">


            <div class="col-12">
              <div class="form-group">
                <label for="">Rtn</label>
                <input type="text" id="rtn" name="rtn" class="form-control" required>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Farmacia</label>
                <input type="text" id="nombre" name="nombre" class="form-control" required>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Sucursal</label>
                <select id="sucursal" name="sucursal" class="form-control" requied>
                  <option>SELECCIONA</option>
                  @foreach ($tblsucursal as $tbl)
                  <option value="{{ $tbl['id_sucursal']}}">{{$tbl["nombre_sucursal"]}}</option>
                  @endforeach
                </select>
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
                <label for="">Entidad</label>
                <select id="entidad" name="entidad" class="form-control" requied>
                  <option>SELECCIONA</option>
                  @foreach ($tblentidad as $tbl)
                  <option value="{{ $tbl['id_tipo_entidad']}}">{{$tbl["tipo_entidad"]}}</option>
                  @endforeach
                </select>
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

            <div class="col-12">
              <div class="form-group">
                <label for="">Contacto</label>
                <select id="contacto" name="contacto" class="form-control" requied>
                  <option>SELECCIONA</option>
                  @foreach ($tblcontacto as $tbl)
                  <option value="{{ $tbl['id_contacto']}}">{{$tbl["nombre_contacto"]}}</option>
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
