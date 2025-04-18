<?php

use App\Http\Controllers\FacturaController;
use App\Http\Controllers\CanjeController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\LoginController;
use App\Http\Controllers\AdministrarPerfilController;
use App\Http\Controllers\Backup_RestoreController;
use App\Http\Controllers\BitacoraController;
use App\Http\Controllers\ManualController;
use App\Http\Controllers\ManualTecnicoController;

//RUTAS DEL SISTEMA 

// Ruta pública
Route::get('/', function () {
    return view('layouts.Login');
});

// Ruta de verificación de login
Route::post('/login_verificar', [LoginController::class, 'verificar_Login']);
// middleware auth
Route::middleware(['auth'])->group(function () {
    Route::get('/inicio', function () {
        return view('inicio');
    });



    //MODULO DE SEGURIDAD CORRECTO


    Route::get('CambiarContrasena', [App\Http\Controllers\CambiarContrasenaController::class, 'index']);
    Route::get('AdministrarPerfil', [App\Http\Controllers\AdministrarPerfilController::class, 'index']);



    //MODULO DE CANJES



    //  ´-------------------1-----------Estado TERMINADO  
    Route::get('Estado', [App\Http\Controllers\EstadoController::class, 'index']);
    Route::post('Agregar_Estado', [App\Http\Controllers\EstadoController::class, 'store']);
    Route::put('/EditarEstado', [App\Http\Controllers\EstadoController::class, 'update']);

    //---------------------2------------PAIS  TERMINADO
    Route::get('Pais', [App\Http\Controllers\PaisController::class, 'index']);
    Route::post('agregar_pais', [App\Http\Controllers\PaisController::class, 'store']);
    Route::put('editar_pais', [App\Http\Controllers\PaisController::class, 'update']);

    //.....................3..............ESTADO_CANJE  NO ME AGREGAR  
    Route::get('Estado_Canje', [App\Http\Controllers\EstadoCanjeController::class, 'index']);
    Route::post('agregar_estado_canje', [App\Http\Controllers\EstadoCanjeController::class, 'store']);
    Route::put('editar_estado_canje', [App\Http\Controllers\EstadoCanjeController::class, 'update']);

    //------------------4------------TIPO ENTIDAD TERMINADO
    Route::get('TipoEntidad', [App\Http\Controllers\TipoEntidadController::class, 'index']);
    Route::post('agregar_entidad', [App\Http\Controllers\TipoEntidadController::class, 'store']);
    Route::put('editar_entidad', [App\Http\Controllers\TipoEntidadController::class, 'update']);

    //--------------------5-----------TIPO REGISTRO  TERMINADO
    Route::get('TipoRegistro', [App\Http\Controllers\TipoRegistroController::class, 'index']);
    Route::post('agregar_registro', [App\Http\Controllers\TipoRegistroController::class, 'store']);
    Route::put('editar_registro', [App\Http\Controllers\TipoRegistroController::class, 'update']);


    //--------------6-----------------------UNIDAD MEDIDA TERMINADO
    Route::get('UnidadMedida', [App\Http\Controllers\UnidadMedidaController::class, 'index']);
    Route::post('agregar_unimedida', [App\Http\Controllers\UnidadMedidaController::class, 'store']);
    Route::put('editar_unimedida', [App\Http\Controllers\UnidadMedidaController::class, 'update']);

    //-------------------7------------UNIDAD ROLES TERMINADO CON EXITO
    Route::get('Roles', [App\Http\Controllers\RolController::class, 'index']);
    Route::post('agregar_rol', [App\Http\Controllers\RolController::class, 'store']);
    Route::put('editar_rol', [App\Http\Controllers\RolController::class, 'update']);

    //----------8------------------UNIDAD VIA_ADMINISTRACION TERMINADO CON EXITO
    Route::get('ViaAdministracion', [App\Http\Controllers\ViaAdministracionController::class, 'index']);
    Route::post('agregar_viadmin', [App\Http\Controllers\ViaAdministracionController::class, 'store']);
    Route::put('editar_viadmin', [App\Http\Controllers\ViaAdministracionController::class, 'update']);

    //-----------------9------------UNIDAD TERMINADO CON EXITO
    Route::get('Zona', [App\Http\Controllers\ZonaController::class, 'index']);
    Route::post('agregar_zona', [App\Http\Controllers\ZonaController::class, 'store']);
    Route::put('editar_zona', [App\Http\Controllers\ZonaController::class, 'update']);

    //----------------------10--------------------UNIDAD DEPARTAMENTO TERMINADO CON EXITO
    Route::get('Departamento', [App\Http\Controllers\DepartamentoController::class, 'index']);
    Route::post('agregar_depto', [App\Http\Controllers\DepartamentoController::class, 'store']);
    Route::put('editar_depto', [App\Http\Controllers\DepartamentoController::class, 'update']);

    //----------------------11--------------------UNIDAD MUNICIPIO TERMINADO CON EXITO

    Route::get('Municipio', [App\Http\Controllers\MunicipioController::class, 'index']);
    Route::post('agregar_municipio', [App\Http\Controllers\MunicipioController::class, 'store']);
    Route::put('editar_municipio', [App\Http\Controllers\MunicipioController::class, 'update']);

    //----------------------12--------------------UNIDAD MUNICIPIO TERMINADO CON EXITO
    Route::get('Especialidad', [App\Http\Controllers\EspecialidadController::class, 'index']);
    Route::post('agregar_especialidad', [App\Http\Controllers\EspecialidadController::class, 'store']);
    Route::put('editar_especialidad', [App\Http\Controllers\EspecialidadController::class, 'update']);


    //----------------------13--------------------UNIDAD MUNICIPIO TERMINADO CON EXITO
    Route::get('FormaFarmaceutica', [App\Http\Controllers\FormaFarmaceuticaController::class, 'index']);
    Route::post('agregar_farmaceutica', [App\Http\Controllers\FormaFarmaceuticaController::class, 'store']);
    Route::put('editar_farmaceutica', [App\Http\Controllers\FormaFarmaceuticaController::class, 'update']);

    //----------------------14--------------------UNIDAD MUNICIPIO TERMINADO CON EXITO
    Route::get('Usuarios', [App\Http\Controllers\UsuarioController::class, 'index']);
    Route::post('agregar_usuario', [App\Http\Controllers\UsuarioController::class, 'store']);
    Route::put('editar_usuario', [App\Http\Controllers\UsuarioController::class, 'update']);
    // 
    Route::get('/usuarios', [UsuarioController::class, 'index'])->name('usuarios.index');
    Route::get('Usuarios', [App\Http\Controllers\UsuarioController::class, 'index'])->name('Usuarios');

    //-------------------------------------TBLA PACIENTES

    Route::get('Pacientes', [App\Http\Controllers\PacientesController::class, 'index']);
    Route::post('agregar_paciente', [App\Http\Controllers\PacientesController::class, 'store']);
    Route::put('editar_paciente', [App\Http\Controllers\PacientesController::class, 'update']);

    //exportar reportes de pacientes
    Route::post('/Pacientes/exportToExcel', [PacientesController::class, 'exportToExcel'])->name('Pacientes.exportToExcel');
    Route::post('/Pacientes/exportToPdf', [PacientesController::class, 'exportToPdf'])->name('Pacientes.exportToPdf');
    Route::post('/Pacientes/print', [PacientesController::class, 'print'])->name('Pacientes.print');



    //-------------------------------------TBLA Productos
    Route::get('Productos', [App\Http\Controllers\ProductosController::class, 'index']);
    Route::post('agregar_producto', [App\Http\Controllers\ProductosController::class, 'store']);
    Route::put('editar_producto', [App\Http\Controllers\ProductosController::class, 'update']);

    //----------------------WILLIAN--------------------UNIDAD MARCAS COMPLETADO
    Route::get('Marca', [App\Http\Controllers\MarcaProductoController::class, 'index']);
    Route::post('agregar_marca', [App\Http\Controllers\MarcaProductoController::class, 'store']);
    Route::put('editar_marca', [App\Http\Controllers\MarcaProductoController::class, 'update']);

    //----------------------14--------------------TIPO CONTADO TERMINADO
    Route::get('TipoContacto', [App\Http\Controllers\TipoContactoController::class, 'index']);
    Route::post('agregar_tipo_contacto', [App\Http\Controllers\TipoContactoController::class, 'store']);
    Route::put('editar_tipo_contacto', [App\Http\Controllers\TipoContactoController::class, 'update']);


    //----------------------WILI--------------------UNIDAD LABORATORIOs
    Route::get('Laboratorios', [App\Http\Controllers\LaboratoriosController::class, 'index']);
    Route::post('agregar_laboratorio', [App\Http\Controllers\LaboratoriosController::class, 'store']);
    Route::put('editar_laboratorio', [App\Http\Controllers\LaboratoriosController::class, 'update']);


    //----------------------WILLI--------------------UNIDAD FARMACIAS
    Route::get('Farmacias', [App\Http\Controllers\FarmaciasController::class, 'index']);
    Route::post('agregar_farmacia', [App\Http\Controllers\FarmaciasController::class, 'store']);
    Route::put('editar_farmacia', [App\Http\Controllers\FarmaciasController::class, 'update']);

    //----------------------14--------------------CONTACTO 
    Route::get('Contacto', [App\Http\Controllers\ContactosController::class, 'index']);
    Route::post('agregar_contacto', [App\Http\Controllers\ContactosController::class, 'store']);
    Route::put('editar_contacto', [App\Http\Controllers\ContactosController::class, 'update']);
    Route::get('Contacto', [App\Http\Controllers\ContactosController::class, 'index'])->name('Contacto');

    //------------------------------------------- SUCURSAL
    Route::get('Sucursal', [App\Http\Controllers\SucursalesController::class, 'index']);
    Route::post('agregar_sucursal', [App\Http\Controllers\SucursalesController::class, 'store']);
    Route::put('editar_sucursal', [App\Http\Controllers\SucursalesController::class, 'update']);
    Route::get('Sucursal', [App\Http\Controllers\SucursalesController::class, 'index'])->name('Sucursal');

    //------------------------------------------- FACTURAS
    Route::get('Facturas', [App\Http\Controllers\FacturaController::class, 'index']);
    Route::post('agregar_factura', [App\Http\Controllers\FacturaController::class, 'store']);
    Route::post('/facturas/export-to-excel', [FacturaController::class, 'exportToExcel'])->name('facturas.exportToExcel');
    Route::post('/facturas/export-to-pdf', [FacturaController::class, 'exportToPdf'])->name('facturas.exportToPdf');

    // Ruta para mostrar la lista de facturas (index)
Route::get('/facturas', [FacturaController::class, 'index'])->name('facturas.index');

// Ruta para guardar una nueva factura (store)
Route::post('/facturas/store', [FacturaController::class, 'store'])->name('facturas.store');

// Ruta para exportar facturas a Excel
Route::post('/facturas/export/excel', [FacturaController::class, 'exportToExcel'])->name('facturas.export.excel');

// Ruta para exportar facturas a PDF
Route::post('/facturas/export/pdf', [FacturaController::class, 'exportToPdf'])->name('facturas.export.pdf');

// Ruta para imprimir facturas
Route::post('/facturas/print', [FacturaController::class, 'print'])->name('facturas.print');

    //-------------------------------------------CANJES
    
    Route::get('Canjes', [App\Http\Controllers\CanjeController::class, 'index']);
    Route::post('agregar_registrocanje', [App\Http\Controllers\CanjeController::class, 'store']);
    Route::post('finalizar_canje', [App\Http\Controllers\CanjeController::class, 'finalizar_canje']);

    //exportar canjes a excel y pdf
    
// Ruta para mostrar la lista de canjes (index)
Route::get('/canjes', [CanjeController::class, 'index'])->name('canjes.index');

// Ruta para guardar un nuevo canje (store)
Route::post('/canjes/store', [CanjeController::class, 'store'])->name('canjes.store');

// Ruta para finalizar un canje y eliminar data.json
Route::get('/canjes/finalizar', [CanjeController::class, 'finalizar_canje'])->name('canjes.finalizar');

// Ruta para exportar canjes a Excel
Route::post('/canjes/export/excel', [CanjeController::class, 'exportToExcel'])->name('canjes.export.excel');

// Ruta para exportar canjes a PDF
Route::post('/canjes/export/pdf', [CanjeController::class, 'exportToPdf'])->name('canjes.export.pdf');

// Ruta para imprimir canjes
Route::post('/canjes/print', [CanjeController::class, 'print'])->name('canjes.print');
    Route::post('/Canjes/exportToExcel', [CanjeController::class, 'exportToExcel'])->name('Canjes.exportToExcel');
    Route::post('/Canjes/exportToPdf', [CanjeController::class, 'exportToPdf'])->name('Canjes.exportToPdf');
    Route::post('/Canjes/print', [CanjeController::class, 'print'])->name('Canjes.print');



    //MODULO DE OTRAS PAGINAS

    Route::get('acerca', [App\Http\Controllers\acercaController::class, 'index']);
    Route::get('terminos', [App\Http\Controllers\terminosController::class, 'index']);
    Route::get('politica_privacidad', [App\Http\Controllers\politica_privacidadController::class, 'index']);

    //-------------------------------------------PARAMETRO
    Route::get('Parametros', [App\Http\Controllers\ParametroController::class, 'index']);
    Route::post('agregar_parametro', [App\Http\Controllers\ParametroController::class, 'store']);
    Route::put('editar_parametro', [App\Http\Controllers\ParametroController::class, 'update']);
    Route::delete('eliminar_parametro/{id_parametro}', [App\Http\Controllers\ParametroController::class, 'destroy']);


    //-----------------BACKUP RESTORE






    // Ruta para acceder a la vista de Backup y Restore
    Route::get('/Backup_Restore', function () {
        return view('modulo_usuarios.Backup_Restore');
    })->name('backup.restore.view');

    // Ruta para crear un backup
    Route::post('/Backup_Restore/create', [Backup_RestoreController::class, 'backup'])->name('backup.restore.create');
    Route::post('/backup/download', [Backup_RestoreController::class, 'generateAndDownloadBackup'])->name('backup.download');
    // Ruta para restaurar un backup
    Route::post('/Backup_Restore/restore', [Backup_RestoreController::class, 'restoreDatabase'])->name('backup.restore');


    Route::get('/backup-restore', [Backup_RestoreController::class, 'index'])->name('backup.index');
    Route::post('/backup-create', [Backup_RestoreController::class, 'createBackup'])->name('backup.create');


    //-----------------BITACORA




    Route::get('/Bitacora', [BitacoraController::class, 'index'])->name('bitacora.index');
    Route::get('/Bitacora', [BitacoraController::class, 'index'])->name('bitacora.index');
    //Route::get('/bbitacora', [BitacoraController::class, 'index'])->middleware('log.route');
//Route::get('/log', [BitacoraController::class, 'method'])->name('log.route');


    //-------------------------------------------OBJETOS
    Route::get('Objetos', [App\Http\Controllers\ObjetoController::class, 'index']);
    Route::post('agregar_objeto', [App\Http\Controllers\ObjetoController::class, 'store']);
    Route::put('editar_objeto', [App\Http\Controllers\ObjetoController::class, 'update']);
    Route::delete('eliminar_objeto/{id_objeto}', [App\Http\Controllers\ObjetoController::class, 'destroy']);


    //-------------------------------------------permiso
    Route::get('Permisos', [App\Http\Controllers\PermisoController::class, 'index']);
    Route::post('agregar_permiso', [App\Http\Controllers\PermisoController::class, 'store']);
    Route::put('editar_permiso', [App\Http\Controllers\PermisoController::class, 'update']);
    Route::delete('eliminar_permiso/{id_permiso}', [App\Http\Controllers\PermisoController::class, 'destroy']);


    //-----------------------------------------Distribuidor
    Route::get('Distribuidor', [App\Http\Controllers\DistribuidorController::class, 'index']);
    Route::post('agregar_distribuidor', [App\Http\Controllers\DistribuidorController::class, 'store']);
    Route::put('editar_distribuidor', [App\Http\Controllers\DistribuidorController::class, 'update']);



}); //aqui termina middleware auth dega


use App\Http\Controllers\PdfController;

Route::get('/crear-pdf', function () {
    return view('crear-pdf');
});

// Ruta con parámetros GET
Route::get('/descargar-pdf', [PdfController::class, 'createPDF'])->name('pdf.download');
Route::get('/descargar-pdf-factura', [PdfController::class, 'createPDF2'])->name('pdf.downloadfactura');


// Ruta para cerrar sesión
Route::post('/logout', [LoginController::class, 'logout'])->name('logout');

//cambiar contraseña
use App\Http\Controllers\CambiarContrasenaController;
use App\Http\Controllers\CambiarContrasenaNewController;

// Rutas para cambiar contraseña voluntariamente (usuarios existentes)
Route::get('/cambiar-contrasena', [CambiarContrasenaController::class, 'index'])
    ->name('cambiar-contrasena.index')
    ->middleware('auth');

Route::post('/cambiar-contrasena', [CambiarContrasenaController::class, 'store'])
    ->name('cambiar-contrasena.store')
    ->middleware('auth');

// Rutas para cambiar contraseña para nuevos usuarios
Route::get('/cambiar-contrasena-new', [CambiarContrasenaNewController::class, 'index'])
    ->name('cambiar-contrasena-new.index')
    ->middleware('auth');

Route::post('/cambiar-contrasena-new', [CambiarContrasenaNewController::class, 'store'])
    ->name('cambiar-contrasena-new.store')
    ->middleware('auth');

Route::get('/cambiar-contrasena', [CambiarContrasenaController::class, 'showFormWithLiveFeedback']);
Route::post('/cambiar-contrasena/evaluate', [CambiarContrasenaController::class, 'evaluatePasswordStrengthLive']);
Route::post('/cambiar-contrasena/submit', [CambiarContrasenaController::class, 'handleFormSubmission']);
Route::post('/cambiar-contrasena/update-strength', [CambiarContrasenaController::class, 'updatePasswordStrengthLive']);


//rutas admin perfil




Route::get('/administrar-perfil', [AdministrarPerfilController::class, 'index'])
    ->name('administrarPerfil.index')
    ->middleware('auth'); // Asegúrate de que el usuario esté autenticado

// Ruta para actualizar datos del perfil
Route::put('/administrar-perfil/actualizar', [AdministrarPerfilController::class, 'actualizarDatos'])
    ->name('administrarPerfil.actualizarDatos')
    ->middleware('auth'); // Protege esta ruta con autenticación

// Ruta para cambiar la contraseña (opcional, si no está configurada aún)
Route::get('/administrar-perfil/cambiar-contrasena', [AdministrarPerfilController::class, 'CambiarContrasena'])
    ->name('administrarPerfil.cambiarContrasena')
    ->middleware('auth'); // Protege esta ruta también

Route::get('/perfil', [PerfilController::class, 'edit'])->name('administrar.perfil');

// Ruta para actualizar el perfil
Route::put('/perfil/update', [PerfilController::class, 'update'])->name('administrar.perfil.update');


Route::get('/administrar-perfil', [AdministrarPerfilController::class, 'index'])->name('AdministrarPerfil');
Route::get('/AdministrarPerfil', [AdministrarPerfilController::class, 'index'])->name('administrarPerfil');

//manuales

// Ruta para el Manual Técnico
Route::get('/manual-tecnico', [ManualController::class, 'tecnico'])->name('manual.tecnico');

// Ruta para el Manual de Usuario
Route::get('/manual-usuario', [ManualController::class, 'usuario'])->name('manual.usuario');

// Ruta para el Manual de Instalación
Route::get('/manual-instalacion', [ManualController::class, 'instalacion'])->name('manual.instalacion');


//fin rutas admin perfil




//rutas DEGA


Route::get('/login', [LoginController::class, 'showLoginForm'])->name('login');
Route::post('/login', [LoginController::class, 'login']);
Route::post('/Login', [LoginController::class, 'login'])->name('login.perform'); // Acción Login






Route::post('/reset-password', [PasswordController::class, 'resetPassword'])->name('password.reset');




//  Administrar perfil"

use App\Http\Controllers\ForgotPasswordController;



Route::get('/ForgotPassword', [ForgotPasswordController::class, 'showForgotPasswordForm'])
//    ->middleware(['cors', 'csp'])
    ->name('password.request');

Route::post('/ForgotPassword', [ForgotPasswordController::class, 'sendResetLink'])
   // ->middleware(['cors', 'csp'])
    ->name('password.sendResetLink');



Route::post('/logout', [LoginController::class, 'logout'])->name('logout');



//errores

Route::get('/403', function () {
    abort(403, 'Acceso prohibido');
});
Route::get('/404', function () {
    abort(404, 'Página no encontrada');
});
Route::get('/500', function () {
    throw new \Exception('Error interno');
});
