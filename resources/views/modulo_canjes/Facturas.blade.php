@extends ('layouts.principal')
@section('content')
<br>
<div value="{{ $con = 0 }}"></div>
<section class="content">
  <div class="container-fluid">
    <div class="row">
      <div class="col-12">
        <!-- Tarjeta -->
        <div class="card">
          <!-- Cabecera de la tarjeta -->
          <div class="card-header">
            <h1 class="card-title">LISTA DE FACTURAS DE PRODUCTOS CANJEABLES</h1>
            <div class="card-tools">
              <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-default">+ NUEVO</button>
              <a href="{{ url('inicio') }}" class="btn btn-secondary">VOLVER</a>
            </div>
          </div>
          <!-- Cuerpo de la tarjeta -->
          <div class="card-body">
            <!-- Tabla -->
            <table id="example1" class="table table-bordered table-striped table-responsive">
              <thead class="text-center bg-danger text-white">
                <tr>
                  <th>Factura</th>
                  <th>Dni Paciente</th>
                  <th>Nombre Paciente</th>
                  <th>Apellido Paciente</th>
                  <th>Nombre Producto</th>
                  <th>Cantidad Producto</th>
                  <th>Fecha</th>
                  <th>Atendio</th>
                  <th>Accion</th>
                </tr>
              </thead>
              <tbody>
                @foreach ($Facturas as $Factura)
                <tr>
                  <td>{{ $Factura['factura'] }}</td>
                  <td>{{ $Factura['dni_paciente'] }}</td>
                  <td>{{ $Factura['nombre_paciente'] }}</td>
                  <td>{{ $Factura['apellido_paciente'] }}</td>
                  <td>{{ $Factura['nombre_producto'] }}</td>
                  <td>{{ $Factura['cantidad_producto'] }}</td>
                  <td>{{ \Carbon\Carbon::parse($Factura["fecha_creacion"])->format('d/m/Y H:i:s'); }}</td>
                  <td>{{ $Factura['creado_por'] }}</td>
                  <td>
                    <a class="btn btn-info" href="{{
                  route('pdf.downloadfactura',               
                  [
                  'factura'=>$Factura['factura'],
                  'dni_paciente'=>$Factura['dni_paciente'],
                  'nombre_paciente'=>$Factura['nombre_paciente'],
                  'apellido_paciente'=>$Factura['apellido_paciente'],
                  'nombre_producto'=>$Factura['nombre_producto'],
                  'cantidad_producto'=>$Factura['cantidad_producto'],
                  'fecha'=>\Carbon\Carbon::parse($Factura["fecha_creacion"])->format('d/m/Y H:i:s')
                  ]) 
                  }}" class="btn">Descargar PDF</a></td>
                </tr>
                @endforeach
              </tbody>
            </table>
          </div>
        </div>
        <!-- Fin tarjeta -->
      </div>
    </div>
  </div>
</section>



<!-- Modal de notificación de canje -->
@if (session('status_message'))
<div class="modal fade" id="statusModal" tabindex="-1" role="dialog" aria-labelledby="statusModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="statusModalLabel">Notificación</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        {{ session('status_message') }}
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
      </div>
    </div>
  </div>
</div>
@endif
<script>
  $(document).ready(function() {
    if ($('#statusModal').length) {
      $('#statusModal').modal('show');
    }
  });

</script>


<!-- Modal para agregar una factura -->
<div x-data='dataHandler(@json($tblproducto), @json($Facturas))'>
  <div class="modal fade" id="modal-default">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">AGREGAR UNA FACTURA</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>

        <form action="agregar_factura" method="post">
          @csrf
          <div class="modal-body">
            <div class="row">
              <div class="col-12">
                <div class="form-group">
                  <label for="">Factura</label>
                  <input type="text" id="factura" name="factura" class="form-control" required>
                </div>
              </div>

              <div class="col-12">
                <div class="form-group">
                  <label for="">Paciente</label>
                  <select id="paciente" name="paciente" class="form-control" required>
                    <option>SELECCIONA</option>
                    @foreach ($tblpaciente as $tbl)
                    <option value="{{ $tbl['id_paciente'] }}">{{ $tbl['dni_paciente'] }}
                    </option>
                    @endforeach
                  </select>
                </div>
              </div>

              <div class="col-12">
                <div class="form-group">
                  <label for="">Producto</label>
                  <select id="producto" name="producto" class="form-control" x-model="productoSeleccionado" @change="canjeLabel(productoSeleccionado)" required>
                    <option>SELECCIONA</option>
                    @foreach ($tblproducto as $tbl)
                    <option value="{{ $tbl['id_producto'] }}">{{ $tbl['nombre_producto'] }}
                    </option>
                    @endforeach
                  </select>
                </div>
              </div>
              <div class="col-12">
                <div class="form-group">
                  <label>Cantidad Producto</label>
                  <input type="number" id="cantidad" name="cantidad" class="form-control" required>
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
  <script>
    function dataHandler(productos, facturas) {
      console.log(productos, facturas);
      return {
        mensajeCanje: ''
        , productoSeleccionado: ''
        , canjeLabel: function(productoSeleccionado) {
          this.mensajeCanje = 'El producto seleccionado es: ' + productos.find(p => p.id_producto == productoSeleccionado).nombre_producto
        }
      }
    }

  </script>
</div>
@endsection
