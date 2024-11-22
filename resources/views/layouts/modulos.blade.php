<!--MODULO USUARIOS-->
<li class="nav-item">
  <a href="#" class="nav-link">
    <i class="nav-icon fas fa-lock"></i>
    <p>
      Seguridad
      <i class="right fas fa-angle-left"></i>
    </p>
  </a>
  <ul class="nav nav-treeview">
    <li class="nav-item">
      <a href="{{ url('Usuarios') }}" class="nav-link">
        <i class="far fa-user nav-icon"></i>
        <p>Usuarios</p>
      </a>
    </li>
    <li class="nav-item">
      <a href="{{ url('Roles') }}" class="nav-link">
        <i class="fas fa-user-cog nav-icon"></i>
        <p>Roles</p>
      </a>
    </li>

    <li class="nav-item">
      <a href="{{ url('Permisos') }}" class="nav-link">
        <i class="fas fa-key nav-icon"></i>
        <p>Permisos</p>
      </a>
    </li>
    <li class="nav-item">
      <a href="{{ url('Parametros') }}" class="nav-link">
        <i class="fas fa-cog nav-icon"></i>
        <p>Parametros</p>
      </a>
    </li>

    <li class="nav-item">
      <a href="{{ url('Bitacora') }}" class="nav-link">
        <i class="fas fa-book nav-icon"></i>
        <p>Bitacora</p>
      </a>
    </li>
    <li class="nav-item">
      <a href="{{ url('Objeto') }}" class="nav-link">
        <i class="fas fa-box nav-icon"></i>
        <p>Objeto</p>
      </a>
    </li>
    <li class="nav-item">
      <a href="{{ url('Backup_Restore') }}" class="nav-link">
        <i class="fas fa-database"></i>

        <p>Backup / Restaurar</p>
      </a>
    </li>


  </ul>
</li>

<!-- FIN DEL MODULO USARIO-->



<!--MODULO DE OPERACIONES-->
<li class="nav-item">
  <a href="#" class="nav-link">
    <i class="nav-icon fas fa-edit"></i>
    <p>
      Registro
      <i class="fas fa-angle-left right"></i>
    </p>
  </a>
  <ul class="nav nav-treeview">
    <li class="nav-item">
      <a href="{{ url('Laboratorios') }}" class="nav-link">
        <i class="fas fa-flask nav-icon"></i>
        <p>Laboratorios</p>
      </a>
    </li>
    <li class="nav-item">
      <a href="{{ url('Farmacias') }}" class="nav-link">
        <i class="fas fa-clinic-medical nav-icon"></i>
        <p>Farmacias</p>
      </a>
    </li>
    <li class="nav-item">
      <a href="{{ url('Productos') }}" class="nav-link">
        <i class="fas fa-capsules nav-icon"></i>
        <p>Productos</p>
      </a>
    </li>
    <li class="nav-item">
      <a href="{{ url('Pacientes') }}" class="nav-link">
        <i class="fas fa-user-injured nav-icon"></i>
        <p>Pacientes</p>
      </a>
    </li>
  </ul>
</li><!-- FIN DEL MODULO OPERACIONES-->




<!-- MODULO FACTURAS Y CANJES-->
<li class="nav-item">
  <a href="#" class="nav-link">
    <i class="nav-icon fas fa-table"></i>
    <p>
      Ventas
      <i class="fas fa-angle-left right"></i>
    </p>
  </a>
  <ul class="nav nav-treeview">
    <li class="nav-item">
      <a href="{{ url('Facturas') }}" class="nav-link">
        <i class="fas fa-file-invoice nav-icon"></i>
        <p>Facturas</p>
      </a>
    </li>
    <li class="nav-item">
      <a href="{{ url('Canjes') }}" class="nav-link">
        <i class="fas fa-exchange-alt nav-icon"></i>
        <p>Canjes</p>
      </a>
    </li>


    <li class="nav-item">
      <a href="{{ url('Devoluciones') }}" class="nav-link">
        <i class="fas fa-sync-alt nav-icon"></i>
        <p>Devoluciones</p>
      </a>
    </li>
  </ul>
</li><!-- FIN DEL MODULO FACTURAS Y CANJES-->


<!-- MODULO MANTENIMIENTO-->
<li class="nav-item">
  <a href="#" class="nav-link">
    <i class="fas fa-wrench nav-icon"></i>
    <p>
      Datos Maestros
      <i class="fas fa-angle-left right"></i>
    </p>
  </a>
  <ul class="nav nav-treeview">
    <li class="nav-item">
      <a href="{{ url('Marca') }}" class="nav-link">
        <i class="fas fa-tag nav-icon"></i>
        <p>Marca Producto</p>
      </a>
    </li>
    <li class="nav-item">
      <a href="{{ url('FormaFarmaceutica') }}" class="nav-link">
        <i class="fas fa-archive nav-icon"></i>
        <p>Forma Farmaceutica</p>
      </a>
    </li>
    <li class="nav-item">
      <a href="{{ url('Estado_Canje') }}" class="nav-link">
        <i class="fas fa-spinner nav-icon"></i>
        <p>Estado Canje</p>
      </a>
    </li>
    <li class="nav-item">
      <a href="{{ url('ViaAdministracion') }}" class="nav-link">
        <i class="fas fa-syringe nav-icon"></i>
        <p>Via Administracion</p>
      </a>
    </li>

    <li class="nav-item">
      <a href="{{ url('UnidadMedida') }}" class="nav-link">
        <i class="fas fa-balance-scale"></i>

        <p>Unidad de Medida</p>
      </a>
    </li>

    <li class="nav-item">
      <a href="{{ url('Especialidad') }}" class="nav-link">
        <i class="fas fa-stethoscope"></i>

        <p>Especialidad</p>
      </a>
    </li>

    <li class="nav-item">
      <a href="{{ url('TipoRegistro') }}" class="nav-link">
        <i class="fas fa-file-alt nav-icon"></i>
        <p>Tipo Registro</p>
      </a>
    </li>

    <li class="nav-item">
      <a href="{{ url('TipoEntidad') }}" class="nav-link">
        <i class="fas fa-building nav-icon"></i>
        <p>Tipo Entidad</p>
      </a>
    </li>

    <li class="nav-item">
      <a href="{{ url('TipoContacto') }}" class="nav-link">
        <i class="fas fa-address-book nav-icon"></i>
        <p>Tipo Contacto</p>
      </a>
    </li>

    <li class="nav-item">
      <a href="{{ url('Estado') }}" class="nav-link">
        <i class="fas fa-toggle-on nav-icon"></i> <!-- Alternar encendido/apagado -->
        <p>Estado</p>
      </a>
    </li>

    <li class="nav-item">
      <a href="{{ url('Pais') }}" class="nav-link">
        <i class="fas fa-map nav-icon"></i>
        <p>Pais</p>
      </a>
    </li>
    <li class="nav-item">
      <a href="{{ url('Zona') }}" class="nav-link">
        <i class="fas fa-map-pin nav-icon"></i>
        <p>zona</p>
      </a>
    </li>
    <li class="nav-item">
      <a href="{{ url('Departamento') }}" class="nav-link">
        <i class="fas fa-map-marked-alt nav-icon"></i>
        <p>Departamento</p>
      </a>
    </li>

    <li class="nav-item">
      <a href="{{ url('Municipio') }}" class="nav-link">
        <i class="fas fa-landmark nav-icon"></i>
        <p>Municipio</p>
      </a>
    </li>
    <li class="nav-item">
      <a href="{{ url('Contacto') }}" class="nav-link">
        <i class="fas fa-phone nav-icon"></i>
        <p>Contacto</p>
      </a>
    </li>

    <li class="nav-item">
      <a href="{{ url('Sucursal') }}" class="nav-link">
        <i class="fas fa-map-marker-alt nav-icon"></i>
        <p>Sucursal</p>
      </a>
    </li>

  </ul>
</li><!-- FIN DEL MODULO mantenimiento-->
