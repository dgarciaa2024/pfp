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
            <h1 class="card-title">LISTA DE MUNICIPIOS</h1>
            <div class="card-tools">
            @if($permiso_insercion == 1)
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-default">+NUEVO</button>
              @endif
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
                  <th>Departamento</th>
                  <th>Municipio</th>
                  <th>Estado</th>
                  <th>Fecha Creacion</th>
                  <th>Creado Por</th>
                  <th>Accion</th>

                </tr>
              </thead>
              <!--Tabla_BODY-->
              <tbody>
                @foreach ($Municipios as $Municipio)
                <tr>
                   
                  <td>{{ $Municipio["id_municipio"]}}</td>
                  <td>{{ $Municipio["nombre_departamento"]}}</td>
                  <td>{{ $Municipio["nombre_municipio"]}}</td>
                  <td>{{ $Municipio["estado"]}}</td>
                  <td>{{ $Municipio["fecha_creacion"]}}</td>
                  <td>{{ $Municipio["creado_por"]}}</td>
                                                        <th>
                    <div class="btn-group" role="group" aria-label="Basic example">

                      <a type="button" class="btn btn-success" data-toggle="modal" data-target="#modal-editor-{{$Municipio['id_municipio']}}">Actualizar <i class="bi bi-pencil-fill"></i> </a>

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
@foreach ($Municipios as $Municipio)
<div class="modal fade" id="modal-editor-{{$Municipio['id_municipio']}}">
  <div class="modal-dialog">
    <div class="modal-content">

      <div class="modal-header">
        <h4 class="modal-title">Actualizar MUNICIPIO</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <form action="editar_municipio" method="post">
        @csrf
        @method('PUT')
        <div class="modal-body">
          <div class="row">
            <input type="hidden" id="cod" name="cod" class="form-control" value="{{ $Municipio['id_municipio']}}" required>

            <div class="col-12">
              <div class="form-group">
                <label for="">Departamento</label>
                <select id="depto" name="depto" class="form-control" requied>
                  @foreach ($tbldepto as $tbl)
                  <option value="{{ $tbl['id_departamento']}}">{{$tbl["nombre_departamento"]}}</option>
                  @endforeach
                </select>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Municipio</label>
                <input type="text" id="municipio" name="municipio" class="form-control" value="{{$Municipio['nombre_municipio']}}" required>
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
        <h4 class="modal-title">AGREGAR UN NUEVO MUNICIPIO</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <form action="agregar_municipio" method="post">
        @csrf
        <div class="modal-body">
          <div class="row">

            <div class="col-12">
              <div class="form-group">
                <label for="">Departamento</label>
                <select id="depto" name="depto" class="form-control" requied>
                  <option>SELECCIONA</option>
                  @foreach ($tbldepto as $tbl)
                  <option value="{{ $tbl['id_departamento']}}">{{$tbl["nombre_departamento"]}}</option>
                  @endforeach
                </select>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Municipio</label>
                <input type="text" id="municipio" name="municipio" class="form-control" required>
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
