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
            <h1 class="card-title">LISTA DE PACIENTES</h1>
            <div class="card-tools">
              <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-default">Nuevo +</button>
              <a href="{{ url('inicio') }}" class="btn btn-secondary">VOLVER</a>

            </div>
          </div>


          <div class="card-body">
            <!--Tarjeta_BODY-->
            <!--Tabla-->
            <table id="example1" class="table table-bordered table-striped  ">
              <!--Tabla_CABEZA-->
              <thead class=" text-center bg-danger blue text-white ">
                <tr>
                   
                  <th>Codigo</th>
                  <th>Dni</th>
                  <th>Nombres</th>
                  <th>Apellidos</th>
                  <th>Fecha Nacimiento</th>
                  <th>Email</th>
                  <th>Direccion</th>
                  <th>Celular</th>
                  <th>Tratamiento Medico</th>
                  <th>Nombre Usuario</th>
                  <th>Estado</th>
                  <th>Fecha Creacion</th>
                  <th>Creado Por</th>
                  <th>Genero</th>
                  <th>Accion</th>

                </tr>
              </thead>
              <!--Tabla_BODY-->
              <tbody>
                @foreach ($Pacientes as $Paciente)
                <tr>
                   
                  <td>{{ $Paciente["id_paciente"]}}</td>
                  <td>{{ $Paciente["dni_paciente"]}}</td>
                  <td>{{ $Paciente["nombre_paciente"]}}</td>
                  <td>{{ $Paciente["apellido_paciente"]}}</td>
                  <td>{{ $Paciente["fecha_nacimiento"]}}</td>
                  <td>{{ $Paciente["email"]}}</td>
                  <td>{{ $Paciente["direccion"]}}</td>
                  <td>{{ $Paciente["celular"]}}</td>
                  <td>{{ $Paciente["tratamiento_medico"]}}</td>
                  <td>{{ $Paciente["nombre_usuario"]}}</td>
                  <td>{{ $Paciente["estado"]}}</td>
                  <td>{{ $Paciente["fecha_creacion"]}}</td>
                  <td>{{ $Paciente["creado_por"]}}</td>
                  <td>{{ $Paciente["genero"]}}</td>
                  <th>
                    <div class="btn-group" role="group" aria-label="Basic example">

                      <a type="button" class="btn btn-success" data-toggle="modal" data-target="#modal-editor-{{$Paciente['id_paciente']}}">Actualizar <i class="bi bi-pencil-fill"></i> </a>

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
@foreach ($Pacientes as $Paciente)
<div class="modal fade" id="modal-editor-{{$Paciente['id_paciente']}}">
  <div class="modal-dialog">
    <div class="modal-content">

      <div class="modal-header">
        <h4 class="modal-title">Actualizar PACIENTE</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <form action="editar_paciente" method="post">
        @csrf
        @method('PUT')
        <div class="modal-body">
          <div class="row">
            <input type="hidden" id="cod" name="cod" class="form-control" value="{{ $Paciente['id_paciente']}}" required>

            <div class="col-12">
              <div class="form-group">
                <label for="">Dni</label>
                <input type="text" id="dni" name="dni" class="form-control" value="{{$Paciente['dni_paciente']}}" required>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Nombre</label>
                <input type="text" id="nombre" name="nombre" class="form-control" value="{{$Paciente['nombre_paciente']}}" required>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Apellidos</label>
                <input type="text" id="apellido" name="apellido" class="form-control" value="{{$Paciente['apellido_paciente']}}" required>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label>Fecha Nacimiento</label>
                <input type="date" id="nacimiento" name="nacimiento" class="form-control" value="{{$Paciente['fecha_nacimiento']}}" required>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Email</label>
                <input type="text" id="email" name="email" class="form-control" value="{{$Paciente['email']}}" required>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Direccion</label>
                <input type="text" id="direccion" name="direccion" class="form-control" value="{{$Paciente['direccion']}}" required>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Celular</label>
                <input type="text" id="celular" name="celular" class="form-control" value="{{$Paciente['celular']}}" required>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Tratamiento Medico</label>
                <input type="text" id="tratamiento" name="tratamiento" class="form-control" value="{{$Paciente['tratamiento_medico']}}" required>
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
                <label for="">Genero</label>
                <input type="text" id="genero" name="genero" class="form-control" value="{{$Paciente['genero']}}" required>
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
        <h4 class="modal-title">AGREGAR UN NUEVO PACIENTE</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <form action="agregar_paciente" method="post">
        @csrf
        <div class="modal-body">
          <div class="row">

            <div class="col-12">
              <div class="form-group">
                <label for="">Dni</label>
                <input type="text" id="dni" name="dni" class="form-control" required>
              </div>
            </div>


            <div class="col-12">
              <div class="form-group">
                <label for="">Nombre</label>
                <input type="text" id="nombre" name="nombre" class="form-control" required>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Apellidos</label>
                <input type="text" id="apellido" name="apellido" class="form-control" required>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label>Fecha Nacimiento</label>
                <input type="date" id="nacimiento" name="nacimiento" class="form-control" required>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Email</label>
                <input type="text" id="email" name="email" class="form-control" required>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Direccion</label>
                <input type="text" id="direccion" name="direccion" class="form-control" required>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Celular</label>
                <input type="text" id="celular" name="celular" class="form-control" required>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Tratamiento Medico</label>
                <input type="text" id="tratamiento" name="tratamiento" class="form-control" required>
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
                <label for="">Genero</label>
                <input type="text" id="genero" name="genero" class="form-control" required>
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
