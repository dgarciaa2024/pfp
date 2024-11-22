<?php

namespace App\Http\Controllers;

// Importar la clase Request
use Illuminate\Http\Request;
use Mpdf\Mpdf;

class PdfController extends Controller
{
  public function createPDF(Request $request)
  {

    $dni_paciente = $request->input('dni_paciente');
    $nombre_paciente = $request->input('nombre_paciente');
    $apellido_paciente = $request->input('apellido_paciente');
    $nombre_farmacia = $request->input('nombre_farmacia');
    $rtn_farmacia = $request->input('rtn_farmacia');
    $nombre_producto = $request->input('nombre_producto');
    $cantidad = $request->input('cantidad');
    $fecha_registro = $request->input('fecha_registro');
    $comentarios = $request->input('comentarios');

    // Crear una nueva instancia de mPDF
    $mpdf = new Mpdf();

    // Cargar el HTML que se usará para el contenido del PDF
    $html = view('pdfs.canjes', compact(
      'dni_paciente',
      'nombre_paciente',
      'apellido_paciente',
      'nombre_farmacia',
      'rtn_farmacia',
      'nombre_producto',
      'cantidad',
      'fecha_registro',
      'comentarios'
    ))->render();

    // Escribir el contenido HTML en el PDF
    $mpdf->WriteHTML($html);

    // Descargar el archivo PDF
    return $mpdf->Output('canje.pdf', 'D');
  }

  public function createPDF2(Request $request)
  {

    $factura = $request->input('factura');
    $dni_paciente = $request->input('dni_paciente');
    $nombre_paciente = $request->input('nombre_paciente');
    $apellido_paciente = $request->input('apellido_paciente');
    $nombre_producto = $request->input('nombre_producto');
    $cantidad_producto = $request->input('cantidad_producto');
    $dni_paciente = $request->input('dni_paciente');
    $fecha_registro = $request->input('fecha');


    // Crear una nueva instancia de mPDF
    $mpdf = new Mpdf();

    // Cargar el HTML que se usará para el contenido del PDF
    $html = view('pdfs.facturas', compact(
      'factura',
      'dni_paciente',
      'nombre_paciente',
      'apellido_paciente',
      'nombre_producto',
      'cantidad_producto',
      'dni_paciente',
      'fecha_registro'
    ))->render();

    // Escribir el contenido HTML en el PDF
    $mpdf->WriteHTML($html);

    // Descargar el archivo PDF
    return $mpdf->Output('factura.pdf', 'D');
  }
}
