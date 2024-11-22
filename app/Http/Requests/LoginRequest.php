<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Contracts\Validation\Factory as ValidationFactory;

class LoginRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            //'nombre_usuario' => 'required',
            //'contrasena' => 'required'

            'nombre_usuario' => 'required|string',
        'contrasena' => 'required|string',
        ];
    }

    /**
     * Get the needed authorization credentials from the request.
     *
     * @return array
     * @throws \Illuminate\Contracts\Container\BindingResolutionException
     */
    public function getCredentials()
    {
        // The form field for providing nombre_usuario or contraseña
        // have name of "nombre_usuario", however, in order to support
        // logging users in with both (nombre_usuario and email)
        // we have to check if user has entered one or another
        $nombre_usuario = $this->get('nombre_usuario');

        if ($this->isEmail($nombre_usuario)) {
            return [
                'email' => $nombre_usuario,
                'contrasena' => $this->get('contrasena')
            ];
        }

        return $this->only('nombre_usuario', 'contrasena');
    }

    /**
     * Validate if provided parameter is valid email.
     *
     * @param $param
     * @return bool
     * @throws \Illuminate\Contracts\Container\BindingResolutionException
     */
    private function isEmail($param)
    {
        $factory = $this->container->make(ValidationFactory::class);

        return ! $factory->make(
            ['nombre_usuario' => $param],
            ['nombre_usuario' => 'email']
        )->fails();
    }
}