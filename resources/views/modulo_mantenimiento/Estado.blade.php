@extends ('layouts.principal')

@section('content')

<br>

<!-- BOTON AGREGA -->
<section class="content">
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <h1 class="card-title">LISTA DE ESTADOS</h1>
                    <div class="card-tools">
                    @if($permiso_insercion == 1)
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#model_agregar">AGREGAR</button>
                            @endif
                    <a href="{{ url('inicio') }}" class="btn btn-secondary">Volver</a>
                   
                    </div>
                    </div>
  
                <!-- TABLA CONTENIDO -->
                <!-- cuerpo -->
                <div class="card-body">
                    <!-- tabla -->
                    <table id="example1" class="table table-bordered table-striped table-sm">                   
                    <thead class=" text-center bg-danger blue text-white">


                    <tr>
                        <th>CODIGO</th>
                        <th>ESTADO</th>
                        <th>ACCION</th>

                  </tr>

                        </thead>
                        <tbody>

                            @foreach ($Estados as $Estado)

                                <tr>
                                    <td>{{ $Estado["id_estado"]}}</td>
                                    <td>{{ $Estado["estado"]}}</td>

                                    <td class="project-actions text-right">
                                    @if ($permiso_actualizacion == 1)
                                                    <a type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-editor-{{ $Estado['id_estado'] }}">
                                                        <i class="bi bi-pencil-fill"></i> ACTUALIZAR
                                                    </a>
                                                @endif
                      </td>
                                </tr>
                            @endforeach

                        </tbody>
                    </table>
                    <!-- tabla -->

                </div>
    </section>
<!-- TABLA CONTENIDO PRINCIPAL -->


<!-- MODAL DE EDITAR -->

@foreach ($Estados as $Estado)
<!-- Modal EDITAR -->

<div class="modal fade" id="model_editar-{{ $Estado['id_estado']}}" role="dialog">
<div class="modal-dialog modal-lg">

<!-- Modal content-->
<div class="modal-content">
    <!-- cabeza-->
    <div class="modal-header">
    </div>
    <!-- cuerpo-->
    <div class="modal-body">

        <!-- contenido cuerpo-->
        <div class="row">



    <!--    SECCION    -->
    <div class="row">
        <div class="col-md-12">
        <div class="card card-outline card-primary">
            <!--    cabeza    -->
            <div class="card-header">
                <h3 class="card-title">Actualizar Estado</h3>
            </div>
            <!--    Cuerpo    -->
            <div class="card-body" style="display: block;">
                <!--    formulario    -->
                <form action="EditarEstado" method="post">
                    @csrf
                    @method('PUT')
                    <!--    SECCION    -->
                    <div class="row">
                        <!--    CODIGO    -->

                            <input type="hidden" id="cod" name="cod" class="form-control" value="{{ $Estado['id_estado']}}" required>
                        <!--    NOMBRE    -->
                        <div class="col-12">
                        <div class="form-group">
                        <label for="">Estado</label>
                        <input type="text" id="estado" name="estado" class="form-control" value="{{ $Estado['estado']}}" required>
                         </div>
                        </div>

                        </div>
                  
             
                         <div class="row">
                        <div class="col-md-4">
                        <div class="form-group">
                            <button type="submit" class="btn btn-primary">Actualizar</button>
                           
                        </div>
                        </div>
                    </div>
           
                    
                </form>
            </div>
        </div>
        </div>
    </div>
    <!--    /SECCION    -->


    </div>
        <!-- /contenido cuerpo-->
    </div>
    <!-- suelo-->
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">CANCELAR</button>
    </div>
</div>
<!-- /Modal content-->

</div>
</div>
<!-- Modal termina editar Estado-->
@endforeach



<!--------------------------------------------------------------------------------------------->
<!-- Modal agregar Estado-->
<div class="modal fade" id="model_agregar" role="dialog">
<div class="modal-dialog modal-lg">

    <!-- Modal content-->
    <div class="modal-content">
        <!-- cabeza-->
        <div class="modal-header">
            <h4 class="modal-title">Agregar un nuevo Estado</h4>
        </div>
        <!-- cuerpo-->
        <div class="modal-body">

            
            <!-- contenido cuerpo-->
                <form action='Agregar_Estado' method="post">
                            @csrf
                        <div class="row">
                                <div class="col-12">
                                <div class="form-group">
                                        <label for="">Estado</label>
                                        <input type="text" id="estado" name="estado" class="form-control" required>
                                </div>
                                </div>

                        </div>

                        <div class="row">
                                <div class="col-md-4">
                                <div class="form-group">
                                        <button type="submit" class="btn btn-primary">AGREGAR</button>
                                </div>
                                </div>
                        </div>
                </form>



            <!-- /contenido cuerpo-->
            <!-- suelo-->
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">CANCELAR</button>

        </div>
    </div>
    <!-- /Modal content-->

</div>
</div>
<!-- Modal termina agregar Estado-->






@endsection()