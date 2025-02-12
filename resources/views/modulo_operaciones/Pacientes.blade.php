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
              <table id="example1" class="table table-bordered table-striped  ">
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
                      <div>
                      <div class="btn-group" role="group" aria-label="Basic example">
                    @if ($permiso_actualizacion == 1)
                                                    <a type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-editor-{{ $Medida['id_unidad_medida'] }}">
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
    </div>
  </div>
  @endforeach




  <div class="modal fade" id="modal-historial">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">HISTORIAL DE COMPRAS</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        @csrf
        <div class="modal-body">
          <table id="example1" class="table table-bordered table-responsive">
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
                  <select id="estdo" name="estdo" class="form-control" required>
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
    </div>
  </div>

  <script>
    function dataHandler(facturas, productos) {
      const formatFacturas = Object.values(facturas.reduce((acumulador, item) => {
        const clave = `${item.nombre_paciente}-${item.apellido_paciente}-${item.nombre_producto}`;
        if (!acumulador[clave]) {
          acumulador[clave] = {
            ...item
            , cantidad_producto: 0
          };
        }
        acumulador[clave].cantidad_producto += item.cantidad_producto;

        return acumulador;
      }, {})).map(item => {
        const producto = productos.find(producto => producto.nombre_producto === item.nombre_producto);
        return {
          ...item
          , canje: item.cantidad_producto > producto.escala
        }
      })
      console.log(formatFacturas)
      return {
        facturas: formatFacturas
        , pacienteSeleccionado: ''
      }
    }

  </script>
</div>
@endsection()
