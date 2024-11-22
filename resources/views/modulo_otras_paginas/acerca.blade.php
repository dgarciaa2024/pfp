@extends ('layouts.principal')
@section('content')
<br>
                <!-- TABLA CONTENIDO CENTRAL -->
                <div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                <h4>ACERCA DE</h4>
                
      <div class="row mt-5">
        <div class="col-md-12 text-center">
               <br>
               <br>
                <!-- Imagen -->
                <img src="{{ asset('dist/img/AcercaDe.png') }}" alt="Descripción de la imagen" class="img-fluid mb-4" style="width: 50%;">

                            

                    <P> 
            </p>
            <h3>Valores</h3>
            <ul class="list-unstyled">
                <li>Innovación</li>
                <li>Compromiso</li>
                <li>Integridad</li>
                <li>Excelencia</li>
                <li>Sostenibilidad</li>
          

                <br>
                <br>
            <h3>Nuestra Historia</h3>
            <p>
                Nuestra empresa ha crecido de un pequeño negocio familiar a una organización global con presencia en múltiples países. 
                A lo largo de los años, hemos mantenido nuestro enfoque en la innovación y la calidad, adaptándonos a los cambios del mercado y 
                las necesidades de nuestros clientes.
            </p>
        </div>
    </div>

    <div class="row mt-5">
        <div class="col-md-12 text-center">
            <h3>Contáctanos</h3>
            <p>
                Si tienes alguna pregunta o deseas más información sobre nuestro programa, no dudes en contactarnos.
            </p>
            <p>
                <strong>Email:</strong> email@conexsa.com<br>
                <strong>Teléfono:</strong> +504 2222-0000
            </p>
        </div>
    

                    
                    </div>
                    </div>
        
                 
                  </tfoot>
                
              </div>
              <!-- /.CIERRE -->
            </div>
            


                  
            <!-- /.card -->
            </div>
          </div>
          <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
      </div>
      <!-- /.modal -->
@endsection()
