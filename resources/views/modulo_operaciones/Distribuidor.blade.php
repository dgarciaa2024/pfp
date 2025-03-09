@extends ('layouts.principal')
@section('content')

<br>
<div value="{{$con=0}}"></div>
<section class="content">
  <div class="container-fluid">
    <div class="row">
      <div class="col-12">
        <!--Tarjeta-->
        <div class="card">
          <!--Tarjeta_CABEZA-->
          <div class="card-header">
            <h1 class="card-title">LISTA DE DISTRIBUIDORES</h1>
            <div class="card-tools">
             <!-- Botón NUEVO condicionado a permiso de inserción -->
             @if($permiso_insercion == 1)
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-default">+NUEVO</button>
             @endif
             <a href="{{ url('inicio') }}" class="btn btn-secondary">VOLVER</a>
            </div>
          </div>

          <div class="card-body">
            <!--Tarjeta_BODY-->
            <!--Tabla-->
            <table id="example2" class="table table-bordered table-striped  ">
              <!--Tabla_CABEZA-->
              <thead class=" text-center bg-danger blue text-white ">
                <tr>
                  <th>Codigo</th>
                  <th>RTN</th>
                  <th>Nombre Distribuidor</th>
                  <th>Pais</th>
                  <th>Tipo Entidad</th>
                  <th>Usuario</th>
                  <th>Contacto</th>
                  <th>Estado</th>
                  <th>Fecha Creacion</th>
                  <th>Creado Por</th>
                  <th>Accion</th>
                </tr>
              </thead>
              <!--Tabla_BODY-->
              <tbody>
                @foreach ($Distribuidores as $Distribuidor)
                <tr>
                  <td>{{ $Distribuidor["id_distribuidor"]}}</td>
                  <td>{{ $Distribuidor["rtn_distribuidor"]}}</td>
                  <td>{{ $Distribuidor["nombre_distribuidor"]}}</td>
                  <td>{{ $Distribuidor["nombre_pais"]}}</td>
                  <td>{{ $Distribuidor["tipo_entidad"]}}</td>
                  <td>{{ $Distribuidor["nombre_usuario"]}}</td>
                  <td>{{ $Distribuidor["nombre_contacto"]}}</td>
                  <td>{{ $Distribuidor["estado"]}}</td>
                  <td>{{ $Distribuidor["fecha_creacion"]}}</td>
                  <td>{{ $Distribuidor["creado_por"]}}</td>
                  <th>
                    <div class="btn-group" role="group" aria-label="Basic example">
                        <!-- Botón ACTUALIZAR condicionado a permiso de edición -->
                        @if($permiso_actualizacion == 1)
                            <a type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-editor-{{$Distribuidor['id_distribuidor']}}">
                                <i class="bi bi-pencil-fill"></i> ACTUALIZAR
                            </a>
                        @endif
                     
                    </div>
                  </th>
                </tr>
                @endforeach
              </tbody>
            </table>
            <!--FIN_Tabla-->
          </div>
        </div>
        <!--FIN_Tarjeta-->
      </div>
    </div>
  </div>
</section>

<!--MODAL EDITAR-->
@foreach ($Distribuidores as $Distribuidor)
<div class="modal fade" id="modal-editor-{{$Distribuidor['id_distribuidor']}}">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">Actualizar Distribuidor</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">×</span>
        </button>
      </div>

      <form action="editar_distribuidor" method="post" x-data="{ rtn: '{{$Distribuidor['rtn_distribuidor']}}', rtnLength: {{$rtnLength}} }">
        @csrf
        @method('PUT')
        <div class="modal-body">
          <div class="row">
            <input type="hidden" id="cod" name="cod" class="form-control" value="{{ $Distribuidor['id_distribuidor']}}" required>

            <div class="col-12">
              <div class="form-group">
                <label for="">RTN</label>
                <input type="text" id="rtn" name="rtn" class="form-control" value="{{$Distribuidor['rtn_distribuidor']}}" required maxlength="{{ $rtnLength }}" pattern="[0-9]{1,{{ $rtnLength }}}" title="Ingrese el RTN sin espacios ni guiones, solo números (máximo {{ $rtnLength }} caracteres)" placeholder="Ingrese el RTN sin espacios ni guiones" x-model="rtn">
                <div x-show="rtn.length < rtnLength" class="text-primary">El RTN debe tener exactamente {{ $rtnLength }} caracteres.</div>
                @error('rtn')
                  <div class="text-danger">{{ $message }}</div>
                @enderror
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label>Nombre Distribuidor</label>
                <input type="text" id="nombre" name="nombre" class="form-control" value="{{$Distribuidor['nombre_distribuidor']}}" required>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Pais</label>
                <select id="pais" name="pais" class="form-control" requied>
                  @foreach ($tblpais as $tbl)
                  <option value="{{ $tbl['id_pais']}}" selected> {{$tbl["nombre_pais"]}}</option>
                  @endforeach
                </select>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Tipo Entidad</label>
                <input type="text" id="entidad" name="entidad" class="form-control" value="DISTRIBUIDOR" readonly>
                <input type="hidden" name="entidad" value="2">
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
                <a href="{{ route('Usuarios') }}" class="mb-2 d-block">Agregar nuevo usuario</a>
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
                <a href="{{ route('Contacto') }}" class="mb-2 d-block">Agregar nuevo contacto</a>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Estado</label>
                <select id="estdo" name="estdo" class="form-control" requied>
                  @foreach ($tblestado as $tbl)
                  <option value="{{ $tbl['id_estado'] }}" selected>{{$tbl["estado"]}}</option>
                  @endforeach
                </select>
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer justify-content-between">
          <button type="button" class="btn btn-default" data-dismiss="modal">CANCELAR</button>
          <button type="submit" class="btn btn-primary" :disabled="rtn.length < rtnLength">Actualizar</button>
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
        <h4 class="modal-title">AGREGAR UN NUEVO DISTRIBUIDOR</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">×</span>
        </button>
      </div>

      <form action="agregar_distribuidor" method="post" x-data="{ rtn: '', rtnLength: {{$rtnLength}} }">
        @csrf
        <div class="modal-body">
          <div class="row">
            <div class="col-12">
              <div class="form-group">
                <label for="">RTN</label>
                <input type="text" id="rtn" name="rtn" class="form-control" required maxlength="{{ $rtnLength }}" pattern="[0-9]{1,{{ $rtnLength }}}" title="Ingrese el RTN sin espacios ni guiones, solo números (máximo {{ $rtnLength }} caracteres)" placeholder="Ingrese el RTN sin espacios ni guiones" x-model="rtn">
                <div x-show="rtn.length > 0 && rtn.length < rtnLength" class="text-primary">El RTN debe tener exactamente {{ $rtnLength }} caracteres.</div>
                @error('rtn')
                  <div class="text-danger">{{ $message }}</div>
                @enderror
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label>Nombre Distribuidor</label>
                <input type="text" id="nombre" name="nombre" class="form-control" required>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Pais</label>
                <select id="pais" name="pais" class="form-control" requied>
                <option>Selecciona</option>
                  @foreach ($tblpais as $tbl)
                  <option value="{{ $tbl['id_pais']}}" selected> {{$tbl["nombre_pais"]}}</option>
                  @endforeach
                </select>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Tipo Entidad</label>
                <input type="text" id="entidad" name="entidad" class="form-control" value="DISTRIBUIDOR" readonly>
                <input type="hidden" name="entidad" value="2">
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Usuario</label>
                
                <select id="usuario" name="usuario" class="form-control" requied>
                <option>Selecciona</option>
                  @foreach ($tblusuario as $tbl)
                  <option value="{{ $tbl['id_usuario']}}">{{$tbl["nombre_usuario"]}}</option>
                  @endforeach
                </select>
                <a href="{{ route('Usuarios') }}" class="mb-2 d-block">Agregar nuevo usuario</a>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Contacto</label>
                <select id="contacto" name="contacto" class="form-control" requied>
                <option>Selecciona</option>
                  @foreach ($tblcontacto as $tbl)
                  <option value="{{ $tbl['id_contacto']}}">{{$tbl["nombre_contacto"]}}</option>
                  @endforeach
                </select>
                <a href="{{ route('Contacto') }}" class="mb-2 d-block">Agregar nuevo contacto</a>
              </div>
            </div>

            <div class="col-6">
              <div class="form-group">
                <label for="">Estado</label>
                <select id="estdo" name="estdo" class="form-control" requied>
                  <option>Selecciona</option>
                  @foreach ($tblestado as $tbl)
                  <option value="{{ $tbl['id_estado']}}">{{$tbl["estado"]}}</option>
                  @endforeach
                </select>
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer justify-content-between">
          <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
          <button type="submit" class="btn btn-primary" :disabled="rtn.length < rtnLength">Agregar</button>
        </div>
      </form>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
@endsection()