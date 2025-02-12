@extends('layouts.principal')

@section('content')
<div class="container-fluid py-4">
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <!-- Tarjeta -->
                    <div class="card">
                        <!-- Tarjeta Cabeza -->
                        <div class="card-header">
                            <h1 class="card-title">BITÁCORA DE ACTIVIDADES</h1>
                            <div class="card-tools">
                                <a href="{{ url('inicio') }}" class="btn btn-secondary">VOLVER</a>
                            </div>
                        </div>

                        <!-- Cuerpo de la Tarjeta -->
                        <div class="card-body table-responsive">
                            <!-- Tabla para mostrar los logs -->
                            <table id="bitacoraTable" class="table table-bordered table-striped table-hover table-sm text-center">
                                <thead class="bg-danger text-white">
                                    <tr>
                                        <th>ID Bitácora</th>
                                        <th>Fecha</th>
                                        <th>ID Usuario</th>
                                        <th>Acción</th>
                                        <th>Descripción</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @forelse ($logs as $log)
                                        <tr>
                                            <td>{{ $log->id_bitacora }}</td>
                                            <td>{{ $log->fecha }}</td>
                                            <td>{{ $log->id_usuario }}</td>
                                            <td>{{ $log->accion }}</td>
                                            <td>{{ $log->descripcion }}</td>
                                        </tr>
                                    @empty
                                        <tr>
                                            <td colspan="5" class="text-center">No hay registros en la bitácora.</td>
                                        </tr>
                                    @endforelse
                                </tbody>
                            </table>
                            <!-- Paginación (si aplica) -->
                            @if (method_exists($logs, 'links'))
                                <div class="d-flex justify-content-center mt-3">
                                    {{ $logs->links() }}
                                </div>
                            @endif
                        </div>
                        <!-- FIN de la tabla -->
                    </div>
                    <!-- FIN de la tarjeta -->
                </div>
            </div>
        </div>
    </section>
</div>
@endsection
