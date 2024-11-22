
@extends ('layouts.principal')
@section('content')
<br>
                <!-- TABLA CONTENIDO CENTRAL -->
                <div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <h1 class="card-title">LISTA DE BITACORA</h1>
                    <div class="card-tools">
                    </div>
                    </div>
        
              <!-- /.INICIO DE LA TABLA -->
              <div class="card-body">
              <table id="example1" class="table table-bordered table-striped table-sm">
              <thead class=" text-center bg-danger blue text-white">

                  <tr>
                    <th>CODIGO</th>
                    <th>FECHA</th>
                    <th>USUARIO</th>
                    <th>OBJETO</th>
                    <th>ACCION </th>
                    <th>DESCRIPCION</th>
                  </tr>
                  </thead>
                  <tbody>
                 
                    <!-- CONTENIDO QUE VA TENER LA TABLA  -->
                
                  <tr>
                    <td>1</td>
                    <td>...</td>
                    <td>...</td>
                    <td>...</td>
                    <td>...</td>
                    <td>...</td>
                  </tr>
                  <tr>
                    <td>2</td>
                    <td>...</td>
                    <td>...</td>
                    <td>...</td>
                    <td>...</td>
                    <td>...</td>
                  </tr>
                 
                  </tfoot>
                </table>
              </div>
              <!-- /.CIERRE -->
            </div>
            <!-- /carta -->

        </div>
        </div>
        </div>
    </section>
<!-- TABLA CONTENIDO CENTRAL -->

<!-- MODAL DE ELIMINAR-->


<div class="modal fade" id="modal-danger">
        <div class="modal-dialog">
          <div class="modal-content bg-danger">
            <div class="modal-header">
              <h4 class="modal-title">ELIMINAR PARAMETRO</h4>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <p>¿ESTA SEGURO QUE DESEAS ELIMINAR?&hellip;</p>
            </div>
            <div class="modal-footer justify-content-between">
              <button type="button" class="btn btn-outline-light" data-dismiss="modal">CANCELAR</button>
              <button type="button" class="btn btn-outline-light">CONFIRMAR</button>
            </div>
          </div>
          <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
      </div>
      <!-- /.modal -->



@endsection()
