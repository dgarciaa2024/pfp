@extends('layouts.principal')
@section('content')

<br>
<div value="{{$con=0}}"></div>
@if (session('status_message'))
<div class="modal fade" id="statusModal" tabindex="-1" role="dialog" aria-labelledby="statusModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="statusModalLabel">Notificación</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">×</span>
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
<section class="content">
  <div class="container-fluid">
    <div class="row">
      <div class="col-12">
        <!--Tarjeta-->
        <div class="card">
          <!--Tarjeta_CABEZA-->
          <div class="card-header">
            <div class="d-flex justify-content-between align-items-center mb-2">
              <h1 class="card-title mb-0">LISTA DE CANJES</h1>
              @if ($permiso_insercion == 1)
              <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-default">Nuevo +</button>
              @endif
            </div>
            <!-- Fila inferior: Filtros y botones de exportación -->
            <div class="row">
              <div class="col d-flex align-items-center flex-wrap">
                <form id="filterForm" method="GET" action="{{ url('Canjes') }}" style="display: inline; margin-right: 10px;">
                  <label for="desde">Desde:</label>
                  <input type="date" name="desde" id="desde" value="{{ $desde ?? '' }}" required>
                  <label for="hasta">Hasta:</label>
                  <input type="date" name="hasta" id="hasta" value="{{ $hasta ?? '' }}" required>
                  <button type="submit" class="btn btn-info">Filtrar</button>
                </form>
                <button class="btn btn-success mr-2" onclick="exportToExcel()">Exportar a Excel</button>
                <button class="btn btn-danger mr-2" onclick="exportToPdf()">Exportar a PDF</button>
                <button class="btn btn-secondary mr-2" onclick="printTable()">Imprimir</button>
                <a href="{{ url('inicio') }}" class="btn btn-secondary">VOLVER</a>
              </div>
            </div>
          </div>

          <div class="card-body">
            <!--Tarjeta_BODY-->
            <!-- Scripts para exportación e impresión -->
            <script>
              function exportToExcel() {
                const desde = document.getElementById('desde').value;
                const hasta = document.getElementById('hasta').value;
                if (!desde || !hasta) {
                  alert('Por favor seleccione un rango de fechas.');
                  return;
                }
                const canjes = @json($CanjesFiltrados);
                console.log('Canjes para Excel:', canjes);
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '{{ route("Canjes.exportToExcel") }}';
                form.innerHTML = `
                  <input type="hidden" name="_token" value="{{ csrf_token() }}">
                  <input type="hidden" name="canjes" value='${JSON.stringify(canjes)}'>
                  <input type="hidden" name="desde" value="${desde}">
                  <input type="hidden" name="hasta" value="${hasta}">
                `;
                document.body.appendChild(form);
                form.submit();
                document.body.removeChild(form);
              }

              function exportToPdf() {
                const desde = document.getElementById('desde').value;
                const hasta = document.getElementById('hasta').value;
                if (!desde || !hasta) {
                  alert('Por favor seleccione un rango de fechas.');
                  return;
                }
                const canjes = @json($CanjesFiltrados);
                console.log('Canjes para PDF:', canjes);
                console.log('Desde:', desde, 'Hasta:', hasta);
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '{{ route("Canjes.exportToPdf") }}';
                form.innerHTML = `
                  <input type="hidden" name="_token" value="{{ csrf_token() }}">
                  <input type="hidden" name="canjes" value='${JSON.stringify(canjes)}'>
                  <input type="hidden" name="desde" value="${desde}">
                  <input type="hidden" name="hasta" value="${hasta}">
                `;
                document.body.appendChild(form);
                form.submit();
                document.body.removeChild(form);
              }

              function printTable() {
                const desde = document.getElementById('desde').value;
                const hasta = document.getElementById('hasta').value;
                if (!desde || !hasta) {
                  alert('Por favor seleccione un rango de fechas.');
                  return;
                }
                const canjes = @json($CanjesFiltrados);
                let tableHTML = `
                  <table>
                    <thead>
                      <tr>
                        <th>Código</th>
                        <th>Fecha Registro</th>
                        <th>Tipo Registro</th>
                        <th>RTN Farmacia</th>
                        <th>Nombre Farmacia</th>
                        <th>DNI Paciente</th>
                        <th>Nombre Paciente</th>
                        <th>Apellido Paciente</th>
                        <th>Nombre Producto</th>
                        <th>Cantidad</th>
                        <th>Estado Canje</th>
                        <th>Comentarios</th>
                        <th>Fecha Creación</th>
                        <th>Creado Por</th>
                      </tr>
                    </thead>
                    <tbody>
                `;
                canjes.forEach(canje => {
                  const fechaRegistro = canje.fecha_registro ? new Date(canje.fecha_registro).toLocaleString('es-ES', { day: '2-digit', month: '2-digit', year: 'numeric', hour: '2-digit', minute: '2-digit', second: '2-digit' }) : '';
                  tableHTML += `
                    <tr>
                      <td>${canje.id_registro || ''}</td>
                      <td>${fechaRegistro}</td>
                      <td>${canje.tipo_registro || ''}</td>
                      <td>${canje.rtn_farmacia || ''}</td>
                      <td>${canje.nombre_farmacia || ''}</td>
                      <td>${canje.dni_paciente || ''}</td>
                      <td>${canje.nombre_paciente || ''}</td>
                      <td>${canje.apellido_paciente || ''}</td>
                      <td>${canje.nombre_producto || ''}</td>
                      <td>${canje.cantidad || ''}</td>
                      <td>${canje.estado_canje || ''}</td>
                      <td>${canje.comentarios || ''}</td>
                      <td>${canje.fecha_creacion || ''}</td>
                      <td>${canje.creado_por || ''}</td>
                    </tr>
                  `;
                });
                tableHTML += `
                    </tbody>
                  </table>
                `;
                const printWindow = window.open('', '_blank');
                printWindow.document.write(`
                  <html>
                    <head>
                      <title>Imprimir Canjes</title>
                      <style>
                        body { font-family: Arial, sans-serif; margin: 20px; }
                        .header { display: flex; align-items: center; margin-bottom: 20px; }
                        .header img { width: 80px; height: 80px; margin-right: 20px; }
                        .header h1 { font-size: 18px; margin: 0; }
                        p { font-size: 14px; margin: 5px 0; }
                        table { border-collapse: collapse; width: 100%; }
                        th, td { border: 1px solid black; padding: 8px; text-align: left; }
                        th { background-color: #f2f2f2; }
                      </style>
                    </head>
                    <body>
                      <div class="header">
                        <img src="{{ asset('dist/img/Foto_perfil.png') }}" alt="Logo">
                        <h1>LISTA DE CANJES</h1>
                      </div>
                      <p>Fechas: Desde ${desde} hasta ${hasta}</p>
                      ${tableHTML}
                    </body>
                  </html>
                `);
                printWindow.document.close();
                printWindow.print();
              }
            </script>
            <!--Tabla-->
            <table id="TablaCanje" class="table table-bordered table-striped table-responsive">
              <!--Tabla_CABEZA-->
              <thead class="text-center bg-danger blue text-white">
                <tr>
                  <th>Codigo</th>
                  <th>Fecha Registro</th>
                  <th>Tipo Registro</th>
                  <th>Rtn Registro</th>
                  <th>Nombre Farmacia</th>
                  <th>Dni Paciente</th>
                  <th>Nombre Paciente</th>
                  <th>Apellido Paciente</th>
                  <th>Nombre Producto</th>
                  <th>Cantidad</th>
                  <th>Estado Canje</th>
                  <th>Comentarios</th>
                  <th>Fecha Creacion</th>
                  <th>Creado Por</th>
                  <th>Acciones</th>
                </tr>
              </thead>
              <!--Tabla_BODY-->
              <tbody>
                @foreach ($CanjesFiltrados as $Canje)
                <tr>
                <td>C{{ str_pad($Canje['id_registro'], 5, '0', STR_PAD_LEFT) }}</td>
                  <td>{{ \Carbon\Carbon::parse($Canje["fecha_registro"])->format('d/m/Y H:i:s');}}</td>
                  <td>{{ $Canje["tipo_registro"]}}</td>
                  <td>{{ $Canje["rtn_farmacia"]}}</td>
                  <td>{{ $Canje["nombre_farmacia"]}}</td>
                  <td>{{ $Canje["dni_paciente"]}}</td>
                  <td>{{ $Canje["nombre_paciente"]}}</td>
                  <td>{{ $Canje["apellido_paciente"]}}</td>
                  <td>{{ $Canje["nombre_producto"]}}</td>
                  <td>{{ $Canje["cantidad"]}}</td>
                  <td>{{ $Canje["estado_canje"]}}</td>
                  <td>{{ $Canje["comentarios"]}}</td>
                  <td>{{ $Canje["fecha_creacion"]}}</td>
                  <td>{{ $Canje["creado_por"]}}</td>
                  <td> <a class="btn btn-info" href="{{
                  route('pdf.download',               
                  ['title'=>'PDF Canje',
                  'id_registro'=>$Canje["id_registro"],
                  'fecha_registro'=>\Carbon\Carbon::parse($Canje["fecha_registro"])->format('d/m/Y H:i:s'),
                  'tipo_registro'=>$Canje["tipo_registro"],
                  'rtn_farmacia'=>$Canje["rtn_farmacia"],
                  'nombre_farmacia'=>$Canje["nombre_farmacia"],
                  'dni_paciente'=>$Canje["dni_paciente"],
                  'nombre_paciente'=>$Canje["nombre_paciente"],
                  'apellido_paciente'=>$Canje["apellido_paciente"],
                  'nombre_producto'=>$Canje["nombre_producto"],
                  'cantidad'=>$Canje["cantidad"],
                  'estado_canje'=>$Canje["estado_canje"],
                  'comentarios'=>$Canje["comentarios"],
                  'fecha_creacion'=>$Canje["fecha_creacion"],
                  'creado_por'=>$Canje["creado_por"]]) 
                  }}" class="btn">Descargar PDF</a></td>
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
<div x-data='dataHandler(@json($storedCanjeData),@json($Facturas),@json($tblpaciente), @json($tblproducto), @json($Canjes), @json($tblfarmacia))'>
  <script>
    function dataHandler(_canjeGuardado, facturas, pacientes, productos, canjes, farmacias) {
      console.log(_canjeGuardado)
      const canjeGuardado = _canjeGuardado || {}
      return {
        canjeHabilitado: !!_canjeGuardado
        , registroSeleccionado: false
        , farmaciaSeleccionada: !!canjeGuardado.savedIdFarmacia
        , obs: 'NINGUNO'
        , pacienteSeleccionado: !!canjeGuardado.savedIdPaciente
        , estadoCanjeSeleccionado: false
        , comentariosSeleccionado: canjeGuardado.comentarios
        , cantidadCanjes: canjeGuardado.savedCantidad || 0
        , canjeMensaje: ''
        , farmaciaId: canjeGuardado.savedIdFarmacia || ''
        , pacienteId: canjeGuardado.savedIdPaciente || ''
        , productoId: canjeGuardado.savedIdProducto || ''
        , productoNombre: canjeGuardado.productoNombre || ''
        , pacienteNombre: canjeGuardado.pacienteNombre || ''
        , emailPaciente: canjeGuardado.email || ''
        , nombre_farmacia: canjeGuardado.nombre_farmacia
        , rtn_farmacia: canjeGuardado.rtn_farmacia
        , nombre_paciente: canjeGuardado.nombre_paciente || ''
        , apellido_paciente: canjeGuardado.apellido_paciente || ''
        , dni_paciente: canjeGuardado.dni_paciente || ''
        , telefono_paciente: canjeGuardado.telefono_paciente || ''
        , correo_paciente: canjeGuardado.correo_paciente || ''
        , nombre_producto: canjeGuardado.nombre_producto || ''
        , cantidad: canjeGuardado.savedCantidad || ''
        , forma_farmaceutica: canjeGuardado.forma_farmaceutica || ''
        , fecha_registro: canjeGuardado.fecha_registro || ''
        , comentarios: canjeGuardado.comentarios || ''
        , canjesDisponibles: ''
        , verificarCanje: function() {
          const pacienteSeleccionado = pacientes.find(p => p.id_paciente == this.pacienteId);
          const productoSeleccionado = productos.find(p => p.id_producto == this.productoId);
          const {
            escala = 0, canjes_max_anual = 0, canje = 0
          } = productoSeleccionado
          this.emailPaciente = pacienteSeleccionado.email.toLowerCase();
          this.pacienteNombre = pacienteSeleccionado.nombre_paciente + ' ' + pacienteSeleccionado.apellido_paciente
          this.productoNombre = productoSeleccionado.nombre_producto
          const facturasSeleccionada = facturas.filter(f => f.dni_paciente == pacienteSeleccionado.dni_paciente && f.nombre_producto == productoSeleccionado.nombre_producto);
          const productosComprados = facturasSeleccionada.reduce((acc, v) => {
            return acc + v.cantidad_producto
          }, 0)
          if (!productosComprados) {
            this.canjeHabilitado = false;
            this.canjesDisponibles = 'Canjes disponibles: ' + canjes_max_anual
            this.canjeMensaje = 'El paciente no ha comprado el producto, no puede canjear';
            return
          }
          const canjesPaciente = canjes.filter(c => c.dni_paciente == pacienteSeleccionado.dni_paciente && c.nombre_producto == productoSeleccionado.nombre_producto).length;
          const farmaciaSeleccionada = farmacias.find(f => f.id_farmacia == this.farmaciaId);
          this.nombre_farmacia = farmaciaSeleccionada.nombre_farmacia
          this.rtn_farmacia = farmaciaSeleccionada.rtn_farmacia
          this.nombre_paciente = pacienteSeleccionado.nombre_paciente
          this.apellido_paciente = pacienteSeleccionado.apellido_paciente
          this.dni_paciente = pacienteSeleccionado.dni_paciente
          this.telefono_paciente = pacienteSeleccionado.celular
          this.correo_paciente = pacienteSeleccionado.email
          this.nombre_producto = productoSeleccionado.nombre_producto
          this.cantidad = canje
          this.forma_farmaceutica = productoSeleccionado.forma_farmaceutica
          this.fecha_registro = (new Date).toISOString().split('T')[0].split('-').reverse().join('/')
          this.comentarios = this.obs
          this.canjesDisponibles = 'Canjes disponibles: ' + (canjes_max_anual - canjesPaciente)
          if (canjesPaciente >= canjes_max_anual) {
            this.canjeMensaje = 'El paciente ya alcanzo el maximo de canjes';
            return;
          }
          const productosCanjeados = canjesPaciente * escala
          const productosRestantes = productosComprados - productosCanjeados;
          if (productosRestantes < escala) {
            this.canjeHabilitado = false;
            this.canjeMensaje = 'El paciente no puede canjear, le faltan ' + (escala - productosRestantes) + ' unidades';
            return
          }
          if (productosRestantes >= escala) {
            this.canjeHabilitado = true;
            this.canjeMensaje = 'El paciente puede canjear';
            this.cantidadCanjes = canje
            return;
          }
        }
      }
    }
  </script>
  <div class="modal fade" id="modal-default">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">Agregar Un Nuevo Registro Canje</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        @if (isset($storedCanjeData))
        <div class="row justify-content-center">
          <div>
            Tiene un canje pendiente, si desea agregar otro, finalice el canje actual o elimine los datos guardados
          </div>
          <form action="finalizar_canje" method="post">
            @csrf
            <Button type="submit" class="btn btn-primary">Finalizar canje</Button>
          </form>
        </div>
        @endif
        <form action="agregar_registrocanje" method="post">
          @csrf
          <div class="modal-body">
            <div class="row">
              <div class="col-12">
                <div class="form-group">
                  <label for="">Tipo Registro</label>
                  <select id="registro" name="registro" class="form-control" @change='registroSeleccionado = true' required>
                    <option>SELECCIONA</option>
                    @foreach ($tblregistro as $tbl)
                    <option value="{{ $tbl['id_tipo_registro']}}">{{$tbl["tipo_registro"]}}</option>
                    @endforeach
                  </select>
                </div>
              </div>

              <div class="col-12">
                <div class="form-group">
                  <label for="">Farmacia</label>
                  <select x-model="farmaciaId" id="farmacia" name="farmacia" class="form-control" @change='farmaciaSeleccionada = true' required>
                    <option>SELECCIONA</option>
                    @foreach ($tblfarmacia as $tbl)
                    <option value="{{ $tbl['id_farmacia']}}">{{$tbl["nombre_farmacia"]}}</option>
                    @endforeach
                  </select>
                </div>
              </div>

              <div class="col-12">
                <div class="form-group">
                  <label for="">Paciente</label>
                  <select id="paciente" name="paciente" x-model="pacienteId" class="form-control" @change='pacienteSeleccionado = true; productoId && verificarCanje();' required>
                    <option>SELECCIONA</option>
                    @foreach ($tblpaciente as $tbl)
                    <option value="{{ $tbl['id_paciente']}}">{{$tbl["dni_paciente"]}} - {{explode(" ",$tbl["nombre_paciente"])[0]}} {{$tbl["apellido_paciente"]}}</option>
                    @endforeach
                  </select>
                </div>
              </div>

              <div class="col-12">
                <div class="form-group">
                  <label for="">Producto</label>
                  <select :disabled="!pacienteSeleccionado" id="producto" name="producto" class="form-control" x-model="productoId" @change='verificarCanje()' required>
                    <option>SELECCIONA</option>
                    @foreach ($tblproducto as $tbl)
                    <option value="{{ $tbl['id_producto']}}">{{$tbl["nombre_producto"]}}</option>
                    @endforeach
                  </select>
                </div>
              </div>
              <div class="col-12">
                <div class="alert alert-info w-full" role="alert" x-text="canjesDisponibles" :hidden="!canjesDisponibles"></div>
              </div>
              <div class="col-12">
                <div :class="{'alert alert-warning w-full': !canjeHabilitado, 'alert alert-success w-full': canjeHabilitado}" role="alert" x-text="canjeMensaje" :hidden="!canjeMensaje"></div>
              </div>
              <div class="col-12">
                <div class="form-group">
                  <label for="">Cantidad</label>
                  <input type="text" id="cantidad" name="cantidad" class="form-control" x-model="cantidadCanjes" required readonly>
                </div>
              </div>

              <input type="hidden" id="email" name="email" class="form-control" x-model="emailPaciente">
              <input type="hidden" id="productoNombre" name="productoNombre" class="form-control" x-model="productoNombre">
              <input type="hidden" id="pacienteNombre" name="pacienteNombre" class="form-control" x-model="pacienteNombre">
              <input type="hidden" id="nombre_farmacia" name="nombre_farmacia" x-model="nombre_farmacia">
              <input type="hidden" id="rtn_farmacia" name="rtn_farmacia" x-model="rtn_farmacia">
              <input type="hidden" id="nombre_paciente" name="nombre_paciente" x-model="nombre_paciente">
              <input type="hidden" id="apellido_paciente" name="apellido_paciente" x-model="apellido_paciente">
              <input type="hidden" id="dni_paciente" name="dni_paciente" x-model="dni_paciente">
              <input type="hidden" id="telefono_paciente" name="telefono_paciente" x-model="telefono_paciente">
              <input type="hidden" id="correo_paciente" name="correo_paciente" x-model="correo_paciente">
              <input type="hidden" id="nombre_producto" name="nombre_producto" x-model="nombre_producto">
              <input type="hidden" id="cantidad" name="cantidad" x-model="cantidad">
              <input type="hidden" id="forma_farmaceutica" name="forma_farmaceutica" x-model="forma_farmaceutica">
              <input type="hidden" id="fecha_registro" name="fecha_registro" x-model="fecha_registro">
              <input type="hidden" id="comentarios" name="comentarios" x-model="comentarios">

              <div class="col-12">
                <div class="form-group">
                  <label for="">Estado Canje</label>
                  <select id="estadocanje" name="estadocanje" class="form-control" @change="estadocanjeSeleccionado = true" required>
                    <option>SELECCIONA</option>
                    @foreach ($tblestadocanje as $tbl)
                    <option value="{{ $tbl['id_estado_canje']}}">{{$tbl["estado_canje"]}}</option>
                    @endforeach
                  </select>
                </div>
              </div>

              <div class="col-12">
                <div class="form-group">
                  <label for="">Comentarios</label>
                  <input type="text" id="comentarios" name="comentarios" x-model="obs" class="form-control" required>
                </div>
              </div>
            </div>
          </div>
          <div class="modal-footer justify-content-between">
            <button type="button" class="btn btn-default" data-dismiss="modal">CANCELAR</button>
            <button type="submit" class="btn btn-primary" :disabled="!canjeHabilitado || !registroSeleccionado || !farmaciaSeleccionada">AGREGAR</button>
          </div>
        </form>
      </div>
      <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
  </div>
</div>
<!-- /.modal -->

<script>
  $(document).ready(function() {
    if ($('#statusModal').length) {
      $('#statusModal').modal('show');
    }
  });
</script>

@endsection()