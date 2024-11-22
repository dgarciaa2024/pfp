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
              <h1 class="card-title">LISTA DE LABORATORIOS</h1>
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
                    <th>Id Laboratorio</th>
                    <th>Rtn</th>
                    <th>Nombre Laboratorio</th>
                    <th>Pais</th>
                    <th>Entidad</th>
                    <th>Usuario</th>
                    <th>Contacto</th>
                    <th>Estado</th>
                    <th>Fecha Creacion</th>
                    <th>Creado Por</th>

                    <th>Accion</th>
                  </tr>
                </thead>
                <tbody>
                  @foreach ($Laboratorios as $Laboratorio)
                  <tr>
                    <td>{{ $Laboratorio['id_laboratorio'] }}</td>
                    <td>{{ $Laboratorio['rtn_laboratorio'] }}</td>
                    <td>{{ $Laboratorio['nombre_laboratorio'] }}</td>
                    <td>{{ $Laboratorio['nombre_pais'] }}</td>
                    <td>{{ $Laboratorio['tipo_entidad'] }}</td>
                    <td>{{ $Laboratorio['nombre_usuario'] }}</td>
                    <td>{{ $Laboratorio['nombre_contacto'] }}</td>
                    <td>{{ $Laboratorio['estado'] }}</td>
                    <td>{{ $Laboratorio['fecha_creacion'] }}</td>
                    <td>{{ $Laboratorio['creado_por'] }}</td>

                    <th>
                      <div class="btn-group" role="group" aria-label="Basic example">

                        <a type="button" class="btn btn-success" data-toggle="modal" data-target="#modal-editor-{{$Laboratorio['id_laboratorio']}}">Actualizar <i class="bi bi-pencil-fill"></i> </a>

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
  @foreach ($Laboratorios as $Laboratorio)
  <div class="modal fade" id="modal-editor-{{$Laboratorio['id_laboratorio']}}">
    <div class="modal-dialog">
      <div class="modal-content">

        <div class="modal-header">
          <h4 class="modal-title">Actualizar LABORATORIO</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>

        <form action="editar_laboratorio" method="post">
          @csrf
          @method('PUT')
          <div class="modal-body">
            <div class="row">
              <input type="hidden" id="cod" name="cod" class="form-control" value="{{ $Laboratorio['id_laboratorio']}}" required>

              <div class="col-12">
                <div class="form-group">
                  <label for="">Rtn</label>
                  <input type="text" id="rtn" name="rtn" class="form-control" value="{{$Laboratorio['rtn_laboratorio']}}" required>
                </div>
              </div>

              <div class="col-12">
                <div class="form-group">
                  <label for="">Laboratorio</label>
                  <input type="text" id="laboratorio" name="laboratorio" class="form-control" value="{{$Laboratorio['nombre_laboratorio']}}" required>
                </div>
              </div>

              <div class="col-12">
                <div class="form-group">
                  <label for="">Pais</label>
                  <select id="pais" name="pais" class="form-control" requied>
                    @foreach ($tblpais as $tbl)
                    <option value="{{ $tbl['id_pais']}}">{{$tbl["nombre_pais"]}}</option>
                    @endforeach
                  </select>
                </div>
              </div>

              <div class="col-12">
                <div class="form-group">
                  <label>Tipo Entidad</label>
                  <select id="entidad" name="entidad" class="form-control" requied>
                    @foreach ($tblentidad as $tbl)
                    <option value="{{ $tbl['id_tipo_entidad']}}">{{$tbl["tipo_entidad"]}}</option>
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
                  <label for="">Contacto</label>
                  <select id="contacto" name="contacto" class="form-control" requied>
                    @foreach ($tblcontacto as $tbl)
                    <option value="{{ $tbl['id_contacto']}}">{{$tbl["nombre_contacto"]}}</option>
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
          <h4 class="modal-title">AGREGAR UN NUEVO LABORATORIO</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>

        <form action="agregar_laboratorio" method="post">
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
                  <label for="">Laboratorio</label>
                  <input type="text" id="laboratorio" name="laboratorio" class="form-control" required>
                </div>
              </div>

              <div class="col-12">
                <div class="form-group">
                  <label for="">Pais</label>
                  <select id="pais" name="pais" class="form-control" requied>
                    <option>SELECCIONA</option>
                    @foreach ($tblpais as $tbl)
                    <option value="{{ $tbl['id_pais']}}">{{$tbl["nombre_pais"]}}</option>
                    @endforeach
                  </select>
                </div>
              </div>

              <div class="col-12">
                <div class="form-group">
                  <label>Tipo Entidad</label>
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
                  <label for="">Contacto</label>
                  <select id="contacto" name="contacto" class="form-control" requied>
                    <option>SELECCIONA</option>
                    @foreach ($tblcontacto as $tbl)
                    <option value="{{ $tbl['id_contacto']}}">{{$tbl["nombre_contacto"]}}</option>
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

  @endsection
