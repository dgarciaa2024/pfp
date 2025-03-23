@extends('layouts.principal')
@section('content')

<div value="{{ $con = 0 }}"></div>
<section class="content">
  <div class="container-fluid">
    <div class="row">
      <div class="col-12">
        <!-- Tarjeta -->
<div class="card">
  <!-- Cabecera de la tarjeta -->
  <div class="card-header">
    <div class="d-flex justify-content-between align-items-center mb-2">
      <h1 class="card-title mb-0">LISTA DE FACTURAS DE PRODUCTOS CANJEABLES</h1>
      @if ($permiso_insercion == 1)
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-default">+ NUEVO</button>
      @endif
    </div>
    <!-- Fila inferior: Filtros y botones de exportación -->
    <div class="row">
      <div class="col d-flex align-items-center flex-wrap">
        <form id="filterForm" method="GET" action="{{ url('facturas') }}" style="display: inline; margin-right: 10px;">
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
          <!-- Cuerpo de la tarjeta -->
          <div class="card-body">
            <script>
              function mostrarImagen(img) {
                document.getElementById('modal-img').src = img.src;
              }

              function exportToExcel() {
                const desde = document.getElementById('desde').value;
                const hasta = document.getElementById('hasta').value;
                if (!desde || !hasta) {
                  alert('Por favor seleccione un rango de fechas.');
                  return;
                }
                const facturas = @json($FacturasFiltradas);
                console.log('Facturas para Excel:', facturas);
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '{{ route("facturas.exportToExcel") }}';
                form.innerHTML = `
                  <input type="hidden" name="_token" value="{{ csrf_token() }}">
                  <input type="hidden" name="facturas" value='${JSON.stringify(facturas)}'>
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
                const facturas = @json($FacturasFiltradas);
                console.log('Facturas para PDF:', facturas);
                console.log('Desde:', desde, 'Hasta:', hasta);
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '{{ route("facturas.exportToPdf") }}';
                form.innerHTML = `
                  <input type="hidden" name="_token" value="{{ csrf_token() }}">
                  <input type="hidden" name="facturas" value='${JSON.stringify(facturas)}'>
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
  const facturas = @json($FacturasFiltradas);
  let tableHTML = `
    <table>
      <thead>
        <tr>
          <th>Numero</th>
          <th>DNI Paciente</th>
          <th>Nombre y Apellido</th>
          <th>Nombre Producto</th>
          <th>Cantidad</th>
          <th>Fecha</th>
        </tr>
      </thead>
      <tbody>
  `;
  facturas.forEach(factura => {
    const fecha = factura.fecha_creacion ? new Date(factura.fecha_creacion).toLocaleString('es-ES', { day: '2-digit', month: '2-digit', year: 'numeric', hour: '2-digit', minute: '2-digit', second: '2-digit' }) : '';
    tableHTML += `
      <tr>
        <td>${factura.numero_factura || ''}</td>
        <td>${factura.dni_paciente || ''}</td>
        <td>${(factura.nombre_paciente || '') + ' ' + (factura.apellido_paciente || '')}</td>
        <td>${factura.nombre_producto || ''}</td>
        <td>${factura.cantidad_producto || ''}</td>
        <td>${fecha}</td>
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
        <title>Imprimir Facturas</title>
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
          <h1>LISTA DE FACTURAS DE PRODUCTOS CANJEABLES</h1>
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
            <div class="modal fade" id="imageModal" tabindex="-1" aria-labelledby="imageModalLabel">
              <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title" id="imageModalLabel">Imagen en tamaño completo</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">×</span>
                    </button>
                  </div>
                  <div class="modal-body text-center">
                    <img id="modal-img" class="img-fluid" alt="Imagen ampliada">
                  </div>
                </div>
              </div>
            </div>
            <!-- Tabla -->
            <table id="TablaCanje" class="table table-bordered table-striped table-responsive">
              <thead class="text-center bg-danger text-white">
                <tr>
                  <th>Correlativos</th>
                  <th>Numero</th>
                  <th>Factura</th>
                  <th>Dni Paciente</th>
                  <th>Nombre Paciente</th>
                  <th>Apellido Paciente</th>
                  <th>Nombre Producto</th>
                  <th>Cantidad Producto</th>
                  <th>Fecha</th>
                  <th>Atendio</th>
                </tr>
              </thead>
              <tbody>
                @foreach ($FacturasFiltradas as $Factura)
                <tr>
                <td>C{{ str_pad($Factura['id_factura'],5,'0',STR_PAD_LEFT) }}</td>
                  
                  <td>{{ $Factura['numero_factura'] ?? '' }}</td>
                  <td><img src="{{ $Factura['factura'] ?? '' }}" class="img-thumbnail mt-3" style="width: 200px; cursor: pointer;" data-toggle="modal" data-target="#imageModal" onclick="mostrarImagen(this)" /></td>
                  <td>{{ $Factura['dni_paciente'] ?? '' }}</td>
                  <td>{{ $Factura['nombre_paciente'] ?? '' }}</td>
                  <td>{{ $Factura['apellido_paciente'] ?? '' }}</td>
                  <td>{{ $Factura['nombre_producto'] ?? '' }}</td>
                  <td>{{ $Factura['cantidad_producto'] ?? '' }}</td>
                  <td>{{ isset($Factura['fecha_creacion']) ? \Carbon\Carbon::parse($Factura['fecha_creacion'])->format('d/m/Y H:i:s') : '' }}</td>
                  <td>{{ $Factura['creado_por'] ?? '' }}</td>
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
@if (session('mensaje_canje_habilitado'))
<div class="modal fade" id="statusModal" tabindex="-1" role="dialog" aria-labelledby="statusModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">Agregar Un Nuevo Registro Canje</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">×</span>
        </button>
      </div>
      <p class="text-center">
        {{ session('mensaje_canje_habilitado') }}
        en caso de que no desee canjear, solo cierre el modal
      </p>
      <form action="agregar_registrocanje" method="post">
        @csrf
        <div class="modal-body">
          <div class="row">
            <div class="col-12">
              <div class="form-group">
                <label for="">Tipo Registro</label>
                <select id="registro" name="registro" class="form-control" @change='registroSeleccionado = true' required>
                  @foreach ($tblregistro as $tbl)
                  <option value="{{ $tbl['id_tipo_registro'] ?? '' }}">{{ $tbl['tipo_registro'] ?? '' }}</option>
                  @endforeach
                </select>
              </div>
            </div>
            <div class="col-12">
              <div class="form-group">
                <label for="">Farmacia</label>
                <select x-model="farmaciaId" id="farmacia" name="farmacia" class="form-control" @change='farmaciaSeleccionada = true' required readonly>
                  <option>SELECCIONA</option>
                  @foreach ($tblfarmacia as $tbl)
                  <option value="{{ $tbl['id_farmacia'] ?? '' }}" {{ $tbl['id_farmacia'] == session('oldIdFarmacia') ? 'selected' : '' }}>{{ $tbl['rtn_farmacia'] ?? '' }} - {{ $tbl['nombre_farmacia'] ?? '' }}</option>
                  @endforeach
                </select>
              </div>
            </div>
            <div class="col-12">
              <div class="form-group">
                <label for="">Paciente</label>
                <select id="paciente" name="paciente" x-model="pacienteId" class="form-control" required readonly>
                  <option>SELECCIONA</option>
                  @foreach ($tblpaciente as $tbl)
                  <option value="{{ $tbl['id_paciente'] ?? '' }}" {{ $tbl['id_paciente'] == session('oldIdPaciente') ? 'selected' : '' }}>{{ $tbl['dni_paciente'] ?? '' }} - {{ $tbl['nombre_paciente'] ?? '' }} {{ $tbl['apellido_paciente'] ?? '' }}</option>
                  @endforeach
                </select>
              </div>
            </div>
            <div class="col-12">
              <div class="form-group">
                <label for="">Producto</label>
                <select :disabled="!pacienteSeleccionado" id="producto" name="producto" class="form-control" x-model="productoId" required readonly>
                  <option>SELECCIONA</option>
                  @foreach ($tblproducto as $tbl)
                  <option value="{{ $tbl['id_producto'] ?? '' }}" {{ $tbl['id_producto'] == session('oldIdProducto') ? 'selected' : '' }}>{{ $tbl['nombre_producto'] ?? '' }}</option>
                  @endforeach
                </select>
              </div>
            </div>
            <div class="col-12">
              <div :class="{'alert alert-warning w-full': !canjeHabilitado, 'alert alert-success w-full': canjeHabilitado}" role="alert" x-text="canjeMensaje" :hidden="!canjeMensaje"></div>
            </div>
            <div class="col-12">
              <div class="form-group">
                <label for="">Cantidad</label>
                <input type="text" value="{{ session('oldCantidad') ?? '' }}" id="cantidad" name="cantidad" class="form-control" x-model="cantidadCanjes" required readonly>
              </div>
            </div>
            <input type="hidden" id="email" name="email" class="form-control" value="{{ session('email') ?? '' }}">
            <input type="hidden" id="productoNombre" name="productoNombre" class="form-control" value="{{ session('productoNombre') ?? '' }}">
            <input type="hidden" id="pacienteNombre" name="pacienteNombre" class="form-control" value="{{ session('pacienteNombre') ?? '' }}">
            <input type="hidden" id="nombre_farmacia" name="nombre_farmacia" value="{{ session('nombre_farmacia') ?? '' }}">
            <input type="hidden" id="rtn_farmacia" name="rtn_farmacia" value="{{ session('rtn_farmacia') ?? '' }}">
            <input type="hidden" id="nombre_paciente" name="nombre_paciente" value="{{ session('nombre_paciente') ?? '' }}">
            <input type="hidden" id="apellido_paciente" name="apellido_paciente" value="{{ session('apellido_paciente') ?? '' }}">
            <input type="hidden" id="dni_paciente" name="dni_paciente" value="{{ session('dni_paciente') ?? '' }}">
            <input type="hidden" id="telefono_paciente" name="telefono_paciente" value="{{ session('telefono_paciente') ?? '' }}">
            <input type="hidden" id="correo_paciente" name="correo_paciente" value="{{ session('correo_paciente') ?? '' }}">
            <input type="hidden" id="nombre_producto" name="nombre_producto" value="{{ session('nombre_producto') ?? '' }}">
            <input type="hidden" id="forma_farmaceutica" name="forma_farmaceutica" value="{{ session('forma_farmaceutica') ?? '' }}">
            <input type="hidden" id="fecha_registro" name="fecha_registro" value="{{ session('fecha_registro') ?? '' }}">
            <input type="hidden" id="comentarios" name="comentarios" value="{{ session('comentarios') ?? '' }}">
            <div class="col-12">
              <div class="form-group">
                <label for="">Estado Canje</label>
                <select id="estadocanje" name="estadocanje" class="form-control" @change="estadocanjeSeleccionado = true" required>
                  @foreach ($tblestadocanje as $tbl)
                  <option value="{{ $tbl['id_estado_canje'] ?? '' }}">{{ $tbl['estado_canje'] ?? '' }}</option>
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
          <button type="submit" class="btn btn-primary" :disabled="!canjeHabilitado || !registroSeleccionado || !farmaciaSeleccionada || !estadocanjeSeleccionado">AGREGAR</button>
        </div>
      </form>
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
<div x-data='dataHandler(@json($Facturas),@json($tblpaciente), @json($tblproducto), @json($Canjes), @json($tblfarmacia),@json($canjeDirecto))'>
  <script>
    function dataHandler(facturas, pacientes, productos, canjes, farmacias, canjeDirecto) {
      console.log(261, canjeDirecto);
      console.log(facturas, pacientes, productos, canjes, farmacias);
      return {
        numero: '',
        mensajeCanje: '',
        productoSeleccionado: '',
        nombrePaciente: '',
        idPaciente: '',
        idProducto: '',
        idFarmacia: '',
        nombreProducto: '',
        canjeHabilitado: false,
        registroSeleccionado: false,
        farmaciaSeleccionada: false,
        obs: 'NINGUNO',
        pacienteSeleccionado: false,
        estadoCanjeSeleccionado: false,
        comentariosSeleccionado: false,
        cantidadCanjes: 0,
        canjeMensaje: '',
        farmaciaId: '',
        pacienteId: '',
        productoId: '',
        productoNombre: '',
        pacienteNombre: '',
        emailPaciente: '',
        nombre_farmacia: '',
        rtn_farmacia: '',
        nombre_paciente: '',
        apellido_paciente: '',
        dni_paciente: '',
        telefono_paciente: '',
        correo_paciente: '',
        nombre_producto: '',
        cantidadProducto: '',
        cantidad: '',
        forma_farmaceutica: '',
        fecha_registro: '',
        comentarios: '',
        verificarCanje: function(pacienteId, productoId, farmaciaId, cantidad) {
          if (pacienteId && productoId) {
            const pacienteSeleccionado = pacientes.find(p => p.id_paciente == pacienteId) || {};
            const productoSeleccionado = productos.find(p => p.id_producto == productoId) || {};
            const { escala = 0, canjes_max_anual = 0, canje = 0 } = productoSeleccionado;
            this.emailPaciente = pacienteSeleccionado.email ? pacienteSeleccionado.email.toLowerCase() : '';
            this.pacienteNombre = (pacienteSeleccionado.nombre_paciente || '') + ' ' + (pacienteSeleccionado.apellido_paciente || '');
            this.productoNombre = productoSeleccionado.nombre_producto || '';
            const facturasSeleccionada = facturas.filter(f => f.dni_paciente == pacienteSeleccionado.dni_paciente && f.nombre_producto == productoSeleccionado.nombre_producto);
            const productosComprados = facturasSeleccionada.reduce((acc, v) => acc + (v.cantidad_producto || 0), 0) + (parseInt(cantidad) || 0);
            if (!productosComprados) {
              this.canjeHabilitado = false;
              this.canjeMensaje = 'El paciente no ha comprado el producto, no puede canjear';
              return;
            }
            const canjesPaciente = canjes.filter(c => c.dni_paciente == pacienteSeleccionado.dni_paciente && c.nombre_producto == productoSeleccionado.nombre_producto).length;
            const farmaciaSeleccionada = farmacias.find(f => f.id_farmacia == farmaciaId) || {};
            if (farmaciaSeleccionada) {
              this.nombre_farmacia = farmaciaSeleccionada.nombre_farmacia || '';
              this.rtn_farmacia = farmaciaSeleccionada.rtn_farmacia || '';
            }
            this.nombre_paciente = pacienteSeleccionado.nombre_paciente || '';
            this.apellido_paciente = pacienteSeleccionado.apellido_paciente || '';
            this.dni_paciente = pacienteSeleccionado.dni_paciente || '';
            this.telefono_paciente = pacienteSeleccionado.celular || '';
            this.correo_paciente = pacienteSeleccionado.email || '';
            this.nombre_producto = productoSeleccionado.nombre_producto || '';
            this.cantidad = canje;
            this.forma_farmaceutica = productoSeleccionado.forma_farmaceutica || '';
            this.fecha_registro = (new Date()).toISOString().split('T')[0].split('-').reverse().join('/');
            this.comentarios = this.obs;
            if (canjesPaciente >= canjes_max_anual) {
              this.canjeMensaje = 'El paciente ya alcanzó el máximo de canjes';
              return;
            }
            const productosCanjeados = canjesPaciente * escala;
            const productosRestantes = productosComprados - productosCanjeados;
            if (productosRestantes < escala) {
              this.canjeHabilitado = false;
              this.canjeMensaje = 'El paciente no puede canjear, le faltan ' + (escala - productosRestantes) + ' unidades';
              return;
            }
            if (productosRestantes >= escala) {
              this.canjeHabilitado = true;
              this.canjeMensaje = 'El paciente puede canjear';
              this.cantidadCanjes = canje;
              return;
            }
          }
        },
        canjeLabel: function(productoSeleccionado) {
          const producto = productos.find(p => p.id_producto == productoSeleccionado);
          this.mensajeCanje = producto ? 'El producto seleccionado es: ' + producto.nombre_producto : 'Producto no encontrado';
        },
        seleccionarPaciente: function(idPaciente, nombrePaciente) {
          document.getElementById('searchInput1').value = '';
          filterTable && filterTable();
          this.idPaciente = idPaciente;
          this.nombrePaciente = nombrePaciente;
        },
        seleccionarProducto: function(idProducto, nombreProducto) {
          document.getElementById('searchInput2').value = '';
          filterTable2 && filterTable2();
          this.idProducto = idProducto;
          this.nombreProducto = nombreProducto;
        },
        formatInput() {
          let formatted = '';
          let digits = this.numero.replace(/\D/g, '');
          if (digits.length > 16) digits = digits.slice(0, 16);
          if (digits.length > 0) formatted += digits.substring(0, Math.min(3, digits.length));
          if (digits.length > 3) formatted += '-' + digits.substring(3, Math.min(6, digits.length));
          if (digits.length > 6) formatted += '-' + digits.substring(6, Math.min(8, digits.length));
          if (digits.length > 8) formatted += '-' + digits.substring(8);
          this.numero = formatted;
        }
      }
    }
  </script>
  <div class="modal fade" id="modal-default">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">AGREGAR UNA FACTURA</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <form action="agregar_factura" method="post" enctype="multipart/form-data">
          @csrf
          <div class="modal-body">
            <div class="row">
              <div class="col-12">
                <div class="form-group">
                  <label for="image">Subir imagen:</label>
                  <input type="file" id="factura" name="factura" accept="image/*" required>
                </div>
              </div>
              <div class="col-12">
                <div class="form-group">
                  <label for="numero">Numero de factura: </label>
                  <input class="form-control" x-model="numero" x-on:input="formatInput" maxlength="19" type="text" id="numero" name="numero" placeholder="000-000-00-00000000" required>
                </div>
              </div>
              <div class="col-12">
                <div class="form-group">
                  <label for="">Farmacia</label>
                  <select x-model="idFarmacia" @change="farmaciaId = $event.target.value" id="farmacia" name="farmacia" class="form-control" required>
                    <option value="">SELECCIONA</option>
                    @foreach ($tblfarmacia as $tbl)
                    <option value="{{ $tbl['id_farmacia'] ?? '' }}">{{ $tbl['rtn_farmacia'] ?? '' }} - {{ $tbl['nombre_farmacia'] ?? '' }}</option>
                    @endforeach
                  </select>
                </div>
              </div>
              <div class="col-12">
                <div class="form-group">
                  <label for="">Paciente</label>
                  <input type="hidden" x-model="idPaciente" id="paciente" name="paciente" class="form-control" required>
                  <div class="row">
                    <div class="col">
                      <input type="text" x-model="nombrePaciente" class="form-control" readonly>
                    </div>
                    <a class="btn btn-info" data-toggle="modal" data-target="#modal-pacientes">Seleccionar Paciente</a>
                  </div>
                </div>
              </div>
              <div class="col-12">
                <div class="form-group">
                  <label for="">Producto</label>
                  <input type="hidden" x-model="idProducto" id="producto" name="producto" class="form-control" required>
                  <div class="row">
                    <div class="col">
                      <input type="text" x-model="nombreProducto" class="form-control" readonly>
                    </div>
                    <a class="btn btn-info" data-toggle="modal" data-target="#modal-productos">Seleccionar Producto</a>
                  </div>
                </div>
              </div>
              <div class="col-12">
                <div class="form-group">
                  <label>Cantidad Producto</label>
                  <input x-model="cantidadProducto" type="number" id="cantidad" name="cantidad" class="form-control" required>
                </div>
              </div>
              <input id="cantidadCanjes" name="cantidadCanjes" type="hidden" x-model="cantidadCanjes">
              <input id="canjeHabilitado" name="canjeHabilitado" type="hidden" x-model="canjeHabilitado">
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
              <input type="hidden" id="forma_farmaceutica" name="forma_farmaceutica" x-model="forma_farmaceutica">
              <input type="hidden" id="fecha_registro" name="fecha_registro" x-model="fecha_registro">
              <input type="hidden" id="comentarios" name="comentarios" x-model="comentarios">
            </div>
          </div>
          <div x-effect="verificarCanje(idPaciente, idProducto, idFarmacia, cantidadProducto)"></div>
          <div class="modal-footer justify-content-between">
            <button type="button" class="btn btn-default" data-dismiss="modal">CANCELAR</button>
            <button type="submit" class="btn btn-primary">AGREGAR</button>
          </div>
        </form>
      </div>
    </div>
  </div>

  <div class="modal fade" id="modal-pacientes">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">PACIENTES</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        @csrf
        <div class="modal-body">
          <div class="card">
            <script>
              function filterTable() {
                const input = document.getElementById('searchInput1');
                const filter = input.value.toLowerCase();
                const table = document.getElementById('myTable');
                const rows = table.getElementsByTagName('tr');
                for (let i = 1; i < rows.length; i++) {
                  const cells = rows[i].getElementsByTagName('td');
                  let match = false;
                  for (let j = 0; j < cells.length; j++) {
                    if (cells[j].textContent.toLowerCase().includes(filter)) {
                      match = true;
                      break;
                    }
                  }
                  rows[i].style.display = match ? '' : 'none';
                }
              }
            </script>
            <input class="form-control mb-2" type="search" id="searchInput1" placeholder="Buscar..." onkeyup="filterTable()">
            <table id="myTable" class="table table-bordered table-responsive table-hover">
              <thead class="text-center bg-danger blue text-white">
                <tr>
                  <th>Codigo</th>
                  <th>Dni</th>
                  <th>Nombres</th>
                  <th>Apellidos</th>
                  <th>Celular</th>
                  <th>Email</th>
                </tr>
              </thead>
              <tbody>
                @foreach ($tblpaciente as $Paciente)
                <tr @click="seleccionarPaciente('{{ $Paciente['id_paciente'] ?? '' }}', '{{ $Paciente['nombre_paciente'] ?? '' }}'+' '+'{{ $Paciente['apellido_paciente'] ?? '' }}');" data-dismiss="modal">
                  <td>{{ $Paciente['id_paciente'] ?? '' }}</td>
                  <td>{{ $Paciente['dni_paciente'] ?? '' }}</td>
                  <td>{{ $Paciente['nombre_paciente'] ?? '' }}</td>
                  <td>{{ $Paciente['apellido_paciente'] ?? '' }}</td>
                  <td>{{ $Paciente['celular'] ?? '' }}</td>
                  <td>{{ $Paciente['email'] ?? '' }}</td>
                </tr>
                @endforeach
              </tbody>
            </table>
          </div>
        </div>
        <div class="modal-footer justify-content-between">
          <button type="button" class="btn btn-default" data-dismiss="modal">CANCELAR</button>
        </div>
      </div>
    </div>
  </div>

  <div class="modal fade" id="modal-productos">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">PRODUCTOS</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        @csrf
        <div class="modal-body d-flex mx-auto">
          <div class="card">
            <script>
              function filterTable2() {
                const input = document.getElementById('searchInput2');
                const filter = input.value.toLowerCase();
                const table = document.getElementById('myTable2');
                const rows = table.getElementsByTagName('tr');
                for (let i = 1; i < rows.length; i++) {
                  const cells = rows[i].getElementsByTagName('td');
                  let match = false;
                  for (let j = 0; j < cells.length; j++) {
                    if (cells[j].textContent.toLowerCase().includes(filter)) {
                      match = true;
                      break;
                    }
                  }
                  rows[i].style.display = match ? '' : 'none';
                }
              }
            </script>
            <input class="form-control mb-2" type="search" id="searchInput2" placeholder="Buscar..." onkeyup="filterTable2()">
            <table id="myTable2" class="table table-bordered table-responsive table-hover">
              <thead class="text-center bg-danger blue text-white">
                <tr>
                  <th>Codigo</th>
                  <th>Nombre Producto</th>
                  <th>Forma Farmaceutica</th>
                  <th>Marca</th>
                  <th>Unidad De Medida</th>
                </tr>
              </thead>
              <tbody>
                @foreach ($tblproducto as $Producto)
                <tr @click="seleccionarProducto('{{ $Producto['id_producto'] ?? '' }}', '{{ $Producto['nombre_producto'] ?? '' }}');" data-dismiss="modal">
                  <td>{{ $Producto['id_producto'] ?? '' }}</td>
                  <td>{{ $Producto['nombre_producto'] ?? '' }}</td>
                  <td>{{ $Producto['forma_farmaceutica'] ?? '' }}</td>
                  <td>{{ $Producto['marca_producto'] ?? '' }}</td>
                  <td>{{ $Producto['unidad_medida'] ?? '' }}</td>
                </tr>
                @endforeach
              </tbody>
            </table>
          </div>
        </div>
        <div class="modal-footer justify-content-between">
          <button type="button" class="btn btn-default" data-dismiss="modal">CANCELAR</button>
        </div>
      </div>
    </div>
  </div>
</div>
@endsection