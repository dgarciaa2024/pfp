@extends('layouts.principal')
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
            <h1 class="card-title">LISTA DE USUARIOS</h1>
            <div class="card-tools">
              <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-default">Nuevo +</button>
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
                  <th>Usuario</th>
                  <th>Nombre Usuario</th>
                  <th>Contraseña</th>
                  <th>Rol</th>
                  <th>Fecha Ultima_conexion</th>
                  <th>Fecha Vencimiento</th>
                  <th>Email</th>
                  <!-- <th>Primer Ingreso</th> --> <!-- Comentado para no mostrarlo -->
                  <th>Estado</th>
                  <th>Fecha Creacion</th>
                  <th>Creado Por</th>
                  <th>Accion</th>
                </tr>
              </thead>
              <!--Tabla_BODY-->
              <tbody>
                @foreach ($Usuarios as $Usuario)
                <tr>
                  <td>{{ $Usuario["id_usuario"]}}</td>
                  <td>{{ $Usuario["usuario"]}}</td>
                  <td>{{ $Usuario["nombre_usuario"]}}</td>
                  <td>********</td> <!-- Contraseña oculta -->
                  <td>{{ $Usuario["rol"]}}</td>
                  <td>{{ $Usuario["fecha_ultima_conexion"]}}</td>
                  <td>{{ $Usuario["fecha_vencimiento"]}}</td>
                  <td>{{ $Usuario["email"]}}</td>
                  <!-- <td>{{ $Usuario["primer_ingreso"]}}</td> --> <!-- Comentado para no mostrarlo -->
                  <td>{{ $Usuario["estado"]}}</td>
                  <td>{{ $Usuario["fecha_creacion"]}}</td>
                  <td>{{ $Usuario["creado_por"]}}</td>
                  <th>
                    <div class="btn-group" role="group" aria-label="Basic example">
                      <a type="button" class="btn btn-success" data-toggle="modal" data-target="#modal-editor-{{$Usuario['id_usuario']}}">Actualizar <i class="bi bi-pencil-fill"></i> </a>
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
@foreach ($Usuarios as $Usuario)
<div class="modal fade" id="modal-editor-{{$Usuario['id_usuario']}}">
  <div class="modal-dialog">
    <div class="modal-content">

      <div class="modal-header">
        <h4 class="modal-title">Actualizar USUARIO</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">×</span>
        </button>
      </div>

      <form action="editar_usuario" method="post" x-data="{ email: '{{$Usuario['email']}}', emailPattern: /^[\w\.-]+@[\w\.-]+\.\w{2,4}$/ }">
        @csrf
        @method('PUT')
        <div class="modal-body">
          <div class="row">
            <input type="hidden" id="cod" name="cod" class="form-control" value="{{ $Usuario['id_usuario']}}" required>

            <div class="col-12">
              <div class="form-group">
                <label for="">Usuario</label>
                <input type="text" id="usu" name="usu" class="form-control" value="{{$Usuario['usuario']}}" required>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label>Nombre Usuario</label>
                <input type="text" id="nom_usu" name="nom_usu" class="form-control" value="{{$Usuario['nombre_usuario']}}" required>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Contraseña</label>
                <input type="password" id="contra" name="contra" class="form-control" value="{{$Usuario['contrasena']}}" required readonly>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Rol</label>
                <select id="rol" name="rol" class="form-control" required>
                  @foreach ($tblrol as $tbl)
                  <option value="{{ $tbl['id_rol']}}" selected> {{$tbl["rol"]}}</option>
                  @endforeach
                </select>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Email</label>
                <input type="text" id="correo" name="correo" class="form-control" value="{{$Usuario['email']}}" required x-model="email">
                <div x-show="email && !emailPattern.test(email)" class="text-primary">El formato del correo electrónico es incorrecto. Debe seguir el patrón: ejemplo@dominio.com</div>
                @error('correo')
                  <div class="text-danger">{{ $message }}</div>
                @enderror
              </div>
            </div>

            <!-- Primer Ingreso eliminado de la vista pero se mantiene en el controlador -->
            <!--
            <div class="col-12">
              <div class="form-group">
                <label>Primer Ingreso</label>
                <input type="text" id="ingreso" name="ingreso" class="form-control" value="{{$Usuario['primer_ingreso']}}" required>
              </div>
            </div>
            -->

            <div class="col-12">
              <div class="form-group">
                <label for="">Estado</label>
                <select id="estdo" name="estdo" class="form-control" required>
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
          <button type="submit" class="btn btn-primary" :disabled="!emailPattern.test(email)">Actualizar</button>
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
        <h4 class="modal-title">AGREGAR UN NUEVO USUARIO</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">×</span>
        </button>
      </div>

      <form action="agregar_usuario" method="post" x-data="{ email: '', emailPattern: /^[\w\.-]+@[\w\.-]+\.\w{2,4}$/ }">
        @csrf
        <div class="modal-body">
          <div class="row">

            <div class="col-12">
              <div class="form-group">
                <label for="">Usuario</label>
                <input type="text" id="usu" name="usu" class="form-control" required>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Nombres</label>
                <input type="text" id="nom_usu" name="nom_usu" class="form-control" required>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Contraseña</label>
                <input type="password" id="contra" name="contra" class="form-control" readonly value="Generada automáticamente" required>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Rol</label>
                <select id="rol" name="rol" class="form-control" required>
                  <option>Selecciona</option>
                  @foreach ($tblrol as $tbl)
                  <option value="{{ $tbl['id_rol']}}">{{$tbl["rol"]}}</option>
                  @endforeach
                </select>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Email</label>
                <input type="text" id="correo" name="correo" class="form-control" required x-model="email">
                <div x-show="email && !emailPattern.test(email)" class="text-primary">El formato del correo electrónico es incorrecto. Debe seguir el patrón: ejemplo@dominio.com</div>
                @error('correo')
                  <div class="text-danger">{{ $message }}</div>
                @enderror
              </div>
            </div>

            <!-- Primer Ingreso eliminado de la vista pero se mantiene en el controlador -->
            <!--
            <div class="col-6">
              <div class="form-group">
                <label for="">Primer Ingreso</label>
                <input type="text" id="ingreso" name="ingreso" class="form-control" required>
              </div>
            </div>
            -->

            <div class="col-6">
              <div class="form-group">
                <label for="">Estado</label>
                <select id="estdo" name="estdo" class="form-control" required>
                  <option value="2" selected>Pendiente</option>
                </select>
              </div>
            </div>

          </div>
        </div>
        <div class="modal-footer justify-content-between">
          <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
          <button type="submit" class="btn btn-primary" :disabled="!emailPattern.test(email)">Agregar</button>
        </div>
      </form>

    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
@endsection()