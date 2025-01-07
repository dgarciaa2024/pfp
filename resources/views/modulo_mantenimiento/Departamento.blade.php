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
            <h1 class="card-title">LISTA DE DEPARTAMENTOS</h1>
            <div class="card-tools">
            @if ($permiso_insercion == 1)
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-default">+ NUEVO</button>
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
                  <th>Zona</th>
                  <th>Departamento</th>
                  <th>Estado</th>
                  <th>Fecha Creacion</th>
                  <th>Creado Por</th>
                  <th>Accion</th>

                </tr>
              </thead>
              <!--Tabla_BODY-->
              <tbody>
                @foreach ($Departamentos as $Departamento)
                <tr>
                   
                  <td>{{ $Departamento["id_departamento"]}}</td>
                  <td>{{ $Departamento["nombre_zona"]}}</td>
                  <td>{{ $Departamento["nombre_departamento"]}}</td>
                  <td>{{ $Departamento["estado"]}}</td>
                  <td>{{ $Departamento["fecha_creacion"]}}</td>
                  <td>{{ $Departamento["creado_por"]}}</td>
                                      
                  <th>
                    <div class="btn-group" role="group" aria-label="Basic example">
                    @if ($permiso_actualizacion == 1)
                                                    <a type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-editor-{{ $Departamento['id_departamento'] }}">
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
@foreach ($Departamentos as $Departamento)
<div class="modal fade" id="modal-editor-{{$Departamento['id_departamento']}}">
  <div class="modal-dialog">
    <div class="modal-content">

      <div class="modal-header">
        <h4 class="modal-title">Actualizar DEPARTAMENTO</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <form action="editar_depto" method="post">
        @csrf
        @method('PUT')
        <div class="modal-body">
          <div class="row">
            <input type="hidden" id="cod" name="cod" class="form-control" value="{{ $Departamento['id_departamento']}}" required>

            <div class="col-12">
              <div class="form-group">
                <label for="">Zona</label>
                <select id="zona" name="zona" class="form-control" requied>
                  @foreach ($tblzona as $tbl)
                  <option value="{{ $tbl['id_zona']}}">{{$tbl["zona"]}}</option>
                  @endforeach
                </select>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Departamento</label>
                <input type="text" id="depto" name="depto" class="form-control" value="{{$Departamento['nombre_departamento']}}" required>
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
        <h4 class="modal-title">AGREGAR UN NUEVO DEPARTAMENTO</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <form action="agregar_depto" method="post">
        @csrf
        <div class="modal-body">
          <div class="row">

            <div class="col-12">
              <div class="form-group">
                <label for="">Zona</label>
                <select id="zona" name="zona" class="form-control" requied>
                  <option>SELECCIONA</option>
                  @foreach ($tblzona as $tbl)
                  <option value="{{ $tbl['id_zona']}}">{{$tbl["zona"]}}</option>
                  @endforeach
                </select>
              </div>
            </div>

            <div class="col-12">
              <div class="form-group">
                <label for="">Departamento</label>
                <input type="text" id="depto" name="depto" class="form-control" required>
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
