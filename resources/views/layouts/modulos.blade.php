@php
    $id_rol = auth()->check() ? auth()->user()->id_rol : null;

    // Obtener permisos activos y objetos permitidos para el rol actual
    $permisos = \App\Models\Permiso::where('id_rol', $id_rol)
                ->where('permiso_consultar', 1) // Verificar permiso de consulta
                ->get();

    $objetosPermitidos = $permisos->pluck('id_objeto')->toArray();

    // Menús y Submenús
    $menuGrupos = [
        'Seguridad' => [
            11 => ['nombre' => 'Usuarios', 'icono' => 'fas fa-users'],
            7 => ['nombre' => 'Backup/Restore', 'icono' => 'fas fa-database'],
            6 => ['nombre' => 'Bitácora', 'icono' => 'fas fa-clipboard-list'],
            5 => ['nombre' => 'Objeto', 'icono' => 'fas fa-cubes'],
            3 => ['nombre' => 'Parámetro', 'icono' => 'fas fa-sliders-h'],
            4 => ['nombre' => 'Permisos', 'icono' => 'fas fa-key'],
            2 => ['nombre' => 'Roles', 'icono' => 'fas fa-user-tag'],
        ],
        'Operaciones' => [
            32 => ['nombre' => 'Distribuidor', 'icono' => 'fas fa-truck'],
            34 => ['nombre' => 'Sucursal', 'icono' => 'fas fa-store'],
            13 => ['nombre' => 'Farmacias', 'icono' => 'fas fa-prescription-bottle-alt'],
            12 => ['nombre' => 'Laboratorios', 'icono' => 'fas fa-vials'],
            15 => ['nombre' => 'Pacientes', 'icono' => 'fas fa-procedures'],
            14 => ['nombre' => 'Productos', 'icono' => 'fas fa-box-open'],
            33 => ['nombre' => 'Contacto', 'icono' => 'fas fa-address-book'],
            26 => ['nombre' => 'Tipo Contacto', 'icono' => 'fas fa-address-card'],
            25 => ['nombre' => 'Tipo Entidad', 'icono' => 'fas fa-building'],
        ],
        'Canjes' => [
            10 => ['nombre' => 'Canjes', 'icono' => 'fas fa-exchange-alt'],
            18 => ['nombre' => 'Devoluciones', 'icono' => 'fas fa-undo'],
            17 => ['nombre' => 'Facturas', 'icono' => 'fas fa-file-invoice'],
            16 => ['nombre' => 'Estado Canje', 'icono' => 'fas fa-check-circle'],
            24 => ['nombre' => 'Tipo Registro', 'icono' => 'fas fa-clipboard'],
        ],
        'Mantenimiento' => [
            29 => ['nombre' => 'Departamento', 'icono' => 'fas fa-map-marked-alt'],
            23 => ['nombre' => 'Especialidad', 'icono' => 'fas fa-user-md'],
            1 => ['nombre' => 'Estado', 'icono' => 'fas fa-toggle-on'],
            20 => ['nombre' => 'Forma Farmacéutica', 'icono' => 'fas fa-pills'],
            19 => ['nombre' => 'Marca', 'icono' => 'fas fa-tags'],
            30 => ['nombre' => 'Municipio', 'icono' => 'fas fa-city'],
            27 => ['nombre' => 'País', 'icono' => 'fas fa-flag'],
            22 => ['nombre' => 'Unidad de Medida', 'icono' => 'fas fa-ruler'],
            21 => ['nombre' => 'Vía Administración', 'icono' => 'fas fa-syringe'],
            28 => ['nombre' => 'Zona', 'icono' => 'fas fa-map'],
            36 => ['nombre' => 'REVISAR CUAL ES SOLICITADO EN PERMISO', 'icono' => 'fas fa-map'],
        ],
    ];

    // Asociar cada id_objeto con una URL específica
    $urlsPorObjeto = [
        11 => 'Usuarios',
        7 => 'Backup_Restore',
        6 => 'Bitacora',
        5 => 'Objetos',
        3 => 'Parametros',
        4 => 'Permisos',
        2 => 'Roles',
        32 => 'Distribuidor',
        34 => 'Sucursal',
        13 => 'Farmacias',
        12 => 'Laboratorios',
        15 => 'Pacientes',
        14 => 'Productos',
        33 => 'Contacto',
        26 => 'TipoContacto',
        25 => 'TipoEntidad',
        10 => 'Canjes',
        18 => 'Devoluciones',
        17 => 'Facturas',
        16 => 'EstadoCanje',
        24 => 'TipoRegistro',
        29 => 'Departamento',
        23 => 'Especialidad',
        1 => 'Estado',
        20 => 'FormaFarmaceutica',
        19 => 'Marca',
        30 => 'Municipio',
        27 => 'Pais',
        22 => 'UnidadMedida',
        21 => 'ViaAdministracion',
        28 => 'Zona',
        36 => 'Revisar',
    ];
@endphp

<!-- Generación Dinámica de Menús -->
@foreach($menuGrupos as $grupo => $items)
    @php
        // Filtrar items por permisos disponibles
        $itemsPermitidos = array_filter($items, fn($item, $id) => in_array($id, $objetosPermitidos), ARRAY_FILTER_USE_BOTH);
    @endphp

    @if(count($itemsPermitidos) > 0)
        <li class="nav-item">
            <a href="#" class="nav-link">
                <i class="nav-icon fas fa-folder"></i>
                <p>
                    {{ $grupo }}
                    <i class="right fas fa-angle-left"></i>
                </p>
            </a>
            <ul class="nav nav-treeview">
                @foreach($itemsPermitidos as $id_objeto => $item)
                    <li class="nav-item">
                        <a href="{{ url($urlsPorObjeto[$id_objeto] ?? '#') }}" class="nav-link">
                            <i class="{{ $item['icono'] }} nav-icon"></i>
                            <p>{{ $item['nombre'] }}</p>
                        </a>
                    </li>
                @endforeach
            </ul>
        </li>
    @endif
@endforeach
