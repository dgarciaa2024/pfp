<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Session;

class LogoutController extends Controller
{
    /**
     * Log out account user.
     *
     
     */
    //public function perform()
    //{
       // Session::flush();
      //  Auth::logout();

    //    return redirect()->route('layouts.Login'); // Asegúrate de que la ruta está definida correctamente
  //  }
//}



public function logout(Request $request)
{
    Auth::logout();
    $request->session()->invalidate();
    $request->session()->regenerateToken();

    return redirect()->route('login.show');
}}