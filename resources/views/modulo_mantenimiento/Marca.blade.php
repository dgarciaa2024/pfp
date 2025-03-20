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
              <h1 class="card-title">MARCA DE PRODUCTOS</h1>
              <div class="card-tools">
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
                    <th>Id </th>
                    <th>Marca</th>
                    <th>Estado</th>
                    <th>Fecha Creacion</th>
                    <th>Creado Por</th>
                    <th>Accion</th>
                  </tr>
                </thead>
                <tbody>
                  @foreach ($Marcas as $Marca)
                  <tr>
                    <td>{{ $Marca['id_marca_producto'] }}</td>
                    <td>{{ $Marca['marca_producto'] }}</td>
                    <td>{{ $Marca['estado'] }}</td>
                    <td>{{ $Marca['fecha_creacion'] }}</td>
                    <td>{{ $Marca['creado_por'] }}</td>
                                                              <th>
                      <div class="btn-group" role="group" aria-label="Basic example">

                      @if ($permiso_actualizacion == 1)
                                                    <a type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-editor-{{ $Marca['id_marca_producto'] }}">
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
@foreach ($Marcas as $Marca)
<div class="modal fade" id="modal-editor-{{$Marca['id_marca_producto']}}">
  <div class="modal-dialog">
    <div class="modal-content">

      <div class="modal-header">
        <h4 class="modal-title">Actualizar MARCA</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <form action="editar_marca" method="post">
        @csrf
        @method('PUT')
        <div class="modal-body">
          <div class="row">
            <input type="hidden" id="cod" name="cod" class="form-control" value="{{ $Marca['id_marca_producto']}}" required>


            <div class="col-12">
              <div class="form-group">
                <label for="">Marca</label>
                <input type="text" id="marca" name="marca" class="form-control" value="{{$Marca['marca_producto']}}" required>
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


<!--AGREGAR LABORATORIO-->
<div class="modal fade" id="modal-default">
  <div class="modal-dialog">
    <div class="modal-content">


      <div class="modal-header">
        <h4 class="modal-title">AGREGAR UN NUEVO LABORATORIO </h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <form action="agregar_marca" method="post">
        @csrf
        <div class="modal-body">
          <div class="row">

            <div class="col-12">
              <div class="form-group">
                <label>Nombre Marca</label>
                <input type="text" id="marca" name="marca" class="form-control" required>
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

@if(session('success'))
<script>
    $(document).ready(function() {
        $('#modal-success').modal('show');
    });
</script>
@endif
@endsection
