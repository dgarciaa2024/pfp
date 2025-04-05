@extends ('layouts.principal')
@section('content')

-->
<div x-data='dataHandler(@json($facturas),@json($productos))'>
  <br>
  <div value="{{$con=0}}"></div>
  <section class="content">
    <div class="container-fluid">
      <div class="row">
        <div class="col-12">
          <div class="card">
            <div class="card-header">
              <h1 class="card-title">LISTA DE PACIENTE</h1>
              <div class="card-tools">
                @if ($permiso_insercion == 1)
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-default">+ NUEVO</button>
                @endif
                <a href="{{ url('inicio') }}" class="btn btn-secondary">VOLVER</a>
              </div>
            </div>

            <div class="card-body">
              <table id="example2" class="table table-bordered table-striped  ">
                <thead class=" text-center bg-danger blue text-white ">
                  <tr>
                    <th>Codigo</th>
                    <th>Nombre Usuario</th>
                    <th>DNI</th>
                    <th>Nombres</th>
                    <th>Apellidos</th>
                    <th>Fecha Nacimiento</th>
                    <th>Genero</th>
                    <th>Tratamiento Medico</th>
                    <th>Email</th>
                    <th>Celular</th>
                    <th>Direccion</th>
                    <th>Estado</th>
                    <th>Fecha Creacion</th>
                    <th>Creado Por</th>
                    <th>Accion</th>
                  </tr>
                </thead>
                <tbody>
                  @foreach ($Pacientes as $Paciente)
                  <tr>
                    <td>{{ $Paciente["id_paciente"]}}</td>
                    <td>{{ $Paciente["nombre_usuario"]}}</td>
                    <td>{{ $Paciente["dni_paciente"]}}</td>
                    <td>{{ $Paciente["nombre_paciente"]}}</td>
                    <td>{{ $Paciente["apellido_paciente"]}}</td>
                    <td>{{ $Paciente["fecha_nacimiento"]}}</td>
                    <td>{{ $Paciente["genero"]}}</td>
                    <td>{{ $Paciente["tratamiento_medico"]}}</td>
                    <td>{{ $Paciente["email"]}}</td>
                    <td>{{ $Paciente["celular"]}}</td>
                    <td>{{ $Paciente["direccion"]}}</td>
                    <td>{{ $Paciente["estado"]}}</td>
                    <td>{{ $Paciente["fecha_creacion"]}}</td>
                    <td>{{ $Paciente["creado_por"]}}</td>
                    <th>
                      <div>
                        <div class="btn-group" role="group" aria-label="Basic example">
                          @if ($permiso_actualizacion == 1)
                          <a type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-editor-{{ isset($Paciente) ? $Paciente['id_paciente']: '0' }}">
                            <i class="bi bi-pencil-fill"></i> ACTUALIZAR
                          </a>
                          @endif
                          <a type="button" class="btn btn-info" data-toggle="modal" data-target="#modal-historial" @click='pacienteSeleccionado={{$Paciente["dni_paciente"]}}'>Historial <i class="bi bi-clipboard"></i> </a>
                        </div>
                    </th>
                  </tr>
                  @endforeach
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  @foreach ($Pacientes as $Paciente)
  <div class="modal fade" id="modal-editor-{{$Paciente['id_paciente']}}">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">Actualizar PACIENTE</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>

        <form action="editar_paciente" method="post" x-data="{ dni: '{{$Paciente['dni_paciente']}}', email: '{{$Paciente['email']}}', genero: '{{$Paciente['genero']}}', celular: '{{$Paciente['celular']}}', dniLength: {{$dniLength}}, emailPattern: /^[\w\.-]+@[\w\.-]+\.\w{2,4}$/, generoPattern: /^[MFX]$/, celularLength: {{$celularLength}} }">
          @csrf
          @method('PUT')
          <div class="modal-body">
            <div class="row">
              <input type="hidden" id="cod" name="cod" class="form-control" value="{{ $Paciente['id_paciente']}}" required>

              <!-- Usuario -->
              <div class="col-12">
                <div class="form-group">
                  <label for="">Usuario</label>
                  <select id="usuario" name="usuario" class="form-control" requied>
                    @foreach ($tblusuario as $tbl)
                    <option value="{{ $tbl['id_usuario'] }}" @selected($Paciente['nombre_usuario'] == $tbl['nombre_usuario'])> {{$tbl["nombre_usuario"]}}</option>
                    @endforeach
                  </select>
                  <a href="{{ route('Usuarios') }}" class="mb-2 d-block">Agregar nuevo usuario</a>
                </div>
              </div>

              <!-- DNI -->
              <div class="col-12">
                <div class="form-group">
                  <label for="">Dni</label>
                  <input type="text" id="dni" name="dni" class="form-control" value="{{$Paciente['dni_paciente']}}" required maxlength="{{ $dniLength }}" pattern="[0-9]{1,{{ $dniLength }}}" title="Ingrese el DNI sin espacios ni guiones, solo números (máximo {{ $dniLength }} caracteres)" placeholder="Ingrese el DNI sin espacios ni guiones" x-model="dni">
                  <div x-show="dni.length < dniLength" class="text-primary">El DNI debe tener exactamente {{ $dniLength }} caracteres.</div>
                  @error('dni')
                    <div class="text-danger">{{ $message }}</div>
                  @enderror
                </div>
              </div>

              <!-- Nombre -->
              <div class="col-12">
                <div class="form-group">
                  <label for="">Nombre</label>
                  <input type="text" id="nombre" name="nombre" class="form-control" value="{{$Paciente['nombre_paciente']}}" required>
                </div>
              </div>

              <!-- Apellido -->
              <div class="col-12">
                <div class="form-group">
                  <label for="">Apellidos</label>
                  <input type="text" id="apellido" name="apellido" class="form-control" value="{{$Paciente['apellido_paciente']}}" required>
                </div>
              </div>

              <!-- Fecha de Nacimiento -->
              <div class="col-12">
                <div class="form-group">
                  <label>Fecha Nacimiento</label>
                  <input type="date" id="nacimiento" name="nacimiento" class="form-control" value="{{$Paciente['fecha_nacimiento']}}" required>
                </div>
              </div>

              <!-- Género -->
              <div class="col-12">
                <div class="form-group">
                  <label for="">Genero</label>
                  <input type="text" id="genero" name="genero" class="form-control" value="{{$Paciente['genero']}}" required maxlength="1" pattern="[MFX]" title="Solo se permite 'M', 'F' o 'X'" placeholder="Ingrese la letra M (Masculino), F (Femenino) o X (Prefiero no decirlo)" x-model="genero">
                  <div x-show="genero && !generoPattern.test(genero)" class="text-primary">El género debe ser 'M' (Masculino), 'F' (Femenino) o 'X' (Prefiere no especificar).</div>
                  @error('genero')
                    <div class="text-danger">{{ $message }}</div>
                  @enderror
                </div>
              </div>

              <!-- Tratamiento Médico -->
              <div class="col-12">
                <div class="form-group">
                  <label for="">Tratamiento Medico</label>
                  <input type="text" id="tratamiento" name="tratamiento" class="form-control" value="{{$Paciente['tratamiento_medico']}}" required>
                </div>
              </div>

              <!-- Email -->
              <div class="col-12">
                <div class="form-group">
                  <label for="">Email</label>
                  <input type="text" id="email" name="email" class="form-control" value="{{$Paciente['email']}}" required x-model="email">
                  <div x-show="email && !emailPattern.test(email)" class="text-primary">El formato del correo electrónico es incorrecto. Debe seguir el patrón: ejemplo@dominio.com</div>
                  @error('email')
                    <div class="text-danger">{{ $message }}</div>
                  @enderror
                </div>
              </div>

              <!-- Celular -->
              <div class="col-12">
                <div class="form-group">
                  <label for="">Celular</label>
                  <input type="text" id="celular" name="celular" class="form-control" value="{{$Paciente['celular']}}" required maxlength="{{ $celularLength }}" pattern="[0-9]{1,{{ $celularLength }}}" title="Ingrese el número de celular sin espacios ni guiones, solo números (exactamente {{ $celularLength }} caracteres)" placeholder="Ingrese el número de celular sin espacios ni guiones" x-model="celular">
                  <div x-show="celular.length !== celularLength" class="text-primary">El número de celular debe tener exactamente {{ $celularLength }} caracteres.</div>
                  @error('celular')
                    <div class="text-danger">{{ $message }}</div>
                  @enderror
                </div>
              </div>

              <!-- Dirección -->
              <div class="col-12">
                <div class="form-group">
                  <label for="">Direccion</label>
                  <input type="text" id="direccion" name="direccion" class="form-control" value="{{$Paciente['direccion']}}" required>
                </div>
              </div>

              <!-- Estado -->
              <div class="col-12">
                <div class="form-group">
                  <label for="">Estado</label>
                  <select id="estdo" name="estdo" class="form-control" requied>
                    @foreach ($tblestado as $tbl)
                    <option value="{{ $tbl['id_estado'] }}" @selected($Paciente['estado'] == $tbl['estado'])> {{$tbl["estado"]}}</option>
                    @endforeach
                  </select>
                </div>
              </div>

            </div>
          </div>
          <div class="modal-footer justify-content-between">
            <button type="button" class="btn btn-default" data-dismiss="modal">CANCELAR</button>
            <button type="submit" class="btn btn-primary" :disabled="dni.length < dniLength || !emailPattern.test(email) || !generoPattern.test(genero) || celular.length !== celularLength">Actualizar</button>
          </div>
        </form>
      </div>
    </div>
  </div>
  @endforeach

  <div class="modal fade" id="modal-historial">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">HISTORIAL DE COMPRAS</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        @csrf
        <div class="modal-body">
          <table id="example2" class="table table-bordered table-responsive">
            <thead class="text-center bg-danger text-white">
              <tr>
                <th>Nombre Paciente</th>
                <th>Dni Paciente</th>
                <th>Nombre Producto</th>
                <th>Cantidad Producto</th>
                <th>Fecha</th>
                <th>Canje disponible</th>
              </tr>
            </thead>
            <tbody>
              <template x-for="row in facturas">
                <tr x-show="row.dni_paciente == pacienteSeleccionado">
                  <td x-text="row.nombre_paciente+ ' ' + row.apellido_paciente"></td>
                  <td x-text="row.dni_paciente"></td>
                  <td x-text="row.nombre_producto"></td>
                  <td x-text="row.cantidad_producto"></td>
                  <td x-text="row.fecha_creacion.split('T')[0]"></td>
                  <td :class="{'bg-success':row.canje,'bg-warning text-white':!row.canje}" x-text="row.canje?'Disponible':'No disponible'"></td>
                </tr>
              </template>
              @foreach ($facturas as $Factura)
              <tr>
              </tr>
              @endforeach
            </tbody>
          </table>
        </div>
        <div class="modal-footer justify-content-between">
          <button type="button" class="btn btn-default" data-dismiss="modal">CERRAR</button>
        </div>
      </div>
    </div>
  </div>

  <div class="modal fade" id="modal-default">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">AGREGAR UN NUEVO PACIENTE</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>

        <form action="agregar_paciente" method="post" x-data="{ dni: '', email: '', genero: '', celular: '', dniLength: {{$dniLength}}, emailPattern: /^[\w\.-]+@[\w\.-]+\.\w{2,4}$/, generoPattern: /^[MFX]$/, celularLength: {{$celularLength}} }">
          @csrf
          <div class="modal-body">
            <div class="row">

              <!-- Usuario -->
              <div class="col-12">
                <div class="form-group">
                  <label for="">Usuario</label>
                  <select id="usuario" name="usuario" class="form-control" requied>
                    <option>SELECCIONA</option>
                    @foreach ($tblusuario as $tbl)
                    <option value="{{ $tbl['id_usuario']}}">{{$tbl["nombre_usuario"]}}</option>
                    @endforeach
                  </select>
                  <a href="{{ route('Usuarios') }}" class="mb-2 d-block">Agregar nuevo usuario</a>
                </div>
              </div>

              <!-- DNI -->
              <div class="col-12">
                <div class="form-group">
                  <label for="">Dni</label>
                  <input type="text" id="dni" name="dni" class="form-control" required maxlength="{{ $dniLength }}" pattern="[0-9]{1,{{ $dniLength }}}" title="Ingrese el DNI sin espacios ni guiones, solo números (máximo {{ $dniLength }} caracteres)" placeholder="Ingrese el DNI sin espacios ni guiones" x-model="dni">
                  <div x-show="dni.length > 0 && dni.length < dniLength" class="text-primary">El DNI debe tener exactamente {{ $dniLength }} caracteres.</div>
                  @error('dni')
                    <div class="text-danger">{{ $message }}</div>
                  @enderror
                </div>
              </div>

              <!-- Nombre -->
              <div class="col-12">
                <div class="form-group">
                  <label for="">Nombre</label>
                  <input type="text" id="nombre" name="nombre" class="form-control" required>
                </div>
              </div>

              <!-- Apellido -->
              <div class="col-12">
                <div class="form-group">
                  <label for="">Apellidos</label>
                  <input type="text" id="apellido" name="apellido" class="form-control" required>
                </div>
              </div>

              <!-- Fecha de Nacimiento -->
              <div class="col-12">
                <div class="form-group">
                  <label>Fecha Nacimiento</label>
                  <input type="date" id="nacimiento" name="nacimiento" class="form-control" required>
                </div>
              </div>

              <!-- Género -->
              <div class="col-12">
                <div class="form-group">
                  <label for="">Genero</label>
                  <input type="text" id="genero" name="genero" class="form-control" required maxlength="1" pattern="[MFX]" title="Solo se permite 'M', 'F' o 'X'" placeholder="Ingrese la letra M (Masculino), F (Femenino) o X (Prefiero no decirlo)" x-model="genero">
                  <div x-show="genero && !generoPattern.test(genero)" class="text-primary">El género debe ser 'M' (Masculino), 'F' (Femenino) o 'X' (Prefiere no especificar).</div>
                  @error('genero')
                    <div class="text-danger">{{ $message }}</div>
                  @enderror
                </div>
              </div>

              <!-- Tratamiento Médico -->
              <div class="col-12">
                <div class="form-group">
                  <label for="">Tratamiento Medico</label>
                  <input type="text" id="tratamiento" name="tratamiento" class="form-control" required>
                </div>
              </div>

              <!-- Email -->
              <div class="col-12">
                <div class="form-group">
                  <label for="">Email</label>
                  <input type="text" id="email" name="email" class="form-control" required x-model="email">
                  <div x-show="email && !emailPattern.test(email)" class="text-primary">El formato del correo electrónico es incorrecto. Debe seguir el patrón: ejemplo@dominio.com</div>
                  @error('email')
                    <div class="text-danger">{{ $message }}</div>
                  @enderror
                </div>
              </div>

              <!-- Celular -->
              <div class="col-12">
                <div class="form-group">
                  <label for="">Celular</label>
                  <input type="text" id="celular" name="celular" class="form-control" required maxlength="{{ $celularLength }}" pattern="[0-9]{1,{{ $celularLength }}}" title="Ingrese el número de celular sin espacios ni guiones, solo números (exactamente {{ $celularLength }} caracteres)" placeholder="Ingrese el numero de celular sin espacios ni guiones" x-model="celular">
                  <div x-show="celular.length > 0 && celular.length !== celularLength" class="text-primary">El número de celular debe tener exactamente {{ $celularLength }} caracteres.</div>
                  @error('celular')
                    <div class="text-danger">{{ $message }}</div>
                  @enderror
                </div>
              </div>

              <!-- Dirección -->
              <div class="col-12">
                <div class="form-group">
                  <label for="">Direccion</label>
                  <input type="text" id="direccion" name="direccion" class="form-control" required>
                </div>
              </div>

              <!-- Estado -->
              <div class="col-12">
                <div class="form-group">
                  <label for="">Estado</label>
                  <select id="estdo" name="estdo" class="form-control" required>
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
            <button type="submit" class="btn btn-primary" :disabled="dni.length < dniLength || !emailPattern.test(email) || !generoPattern.test(genero) || celular.length !== celularLength">AGREGAR</button>
          </div>
        </form>
      </div>
    </div>
  </div>

  <script>
    function dataHandler(facturas, productos) {
    const formatFacturas = Object.values(facturas.reduce((acumulador, item) => {
        const clave = `${item.nombre_paciente}-${item.apellido_paciente}-${item.nombre_producto}`; // Corregido con comillas invertidas
        if (!acumulador[clave]) {
            acumulador[clave] = {
                ...item,
                cantidad_producto: 0
            };
        }
        acumulador[clave].cantidad_producto += item.cantidad_producto;
        return acumulador;
    }, {})).map(item => {
        const producto = productos.find(producto => producto.nombre_producto === item.nombre_producto);
        return {
            ...item,
            canje: item.cantidad_producto > producto.escala
        }
    });
    console.log(formatFacturas);
    return {
        facturas: formatFacturas,
        pacienteSeleccionado: ''
    }
}
  </script>
</div>
@if(session('success'))
<script>
    $(document).ready(function() {
        $('#modal-success').modal('show');
    });
</script>
@endif
@endsection()