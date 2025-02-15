// Constante para el paquete de PostgreSQL
require("dotenv").config();
const { Pool } = require("pg");
const bodyParser = require("body-parser");
// Constante para el paquete Express
const express = require("express");
// Variable para los métodos de Express
var app = express();
// Constante para el paquete body-parser
const bp = require("body-parser");
// Enviando los datos JSON a NodeJS API
app.use(bp.json());
app.use(bodyParser.json({ limit: "600mb" })); // Para JSON
app.use(bodyParser.urlencoded({ limit: "600mb", extended: true }));
// Conectar a la base de datos (PostgreSQL)

// Ejecutar el server en un puerto específico
app.listen(3000, () =>
    console.log(
        "Server Running en el puerto:3000, y conectado a la bd: " +
            process.env.DB_NAME
    )
);

const pgClient = new Pool({
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    database: process.env.DB_NAME,
    password: process.env.DB_PASSWORD,
    port: process.env.DB_PORT,
    ssl: {
        rejectUnauthorized: false,
    },
});

// Test de conexión a base de datos
pgClient
    .connect()
    .then(() => console.log("✅ Conectado a PostgreSQL en Amazon RDS"))
    .catch((err) => console.error("❌ Error de conexión a PostgreSQL:", err));

// Procedimiento para obtener todos los estados
app.get("/estados", (req, res) => {
    pgClient.query("SELECT * FROM pfp_schema.get_estados()", (err, result) => {
        if (!err) {
            res.status(200).json(result.rows); // Devuelve los resultados como JSON
        } else {
            console.log(err);
            res.status(500).send("Error al ejecutar la función");
        }
    });
});

// Procedimiento para insertar un nuevo estado
app.post("/insert_estado", (req, res) => {
    const { estado } = req.body; // Capturamos el valor del estado desde el cuerpo de la solicitud

    if (!estado) {
        return res.status(400).send("El estado es requerido");
    }

    const query = "CALL pfp_schema.INSERT_ESTADO($1)"; // Llamada al procedimiento almacenado
    const values = [estado];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Estado insertado exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al insertar el estado");
        }
    });
});

// Ruta para actualizar el estado en la tabla tbl_estado
app.put("/update_estado", (req, res) => {
    const { id_estado, estado } = req.body;

    // Llamar al procedimiento almacenado update_estado
    const query = "CALL pfp_schema.update_estado($1, $2)";

    pgClient.query(query, [id_estado, estado], (err, result) => {
        if (!err) {
            res.status(200).send("Estado actualizado correctamente");
        } else {
            console.log(err);
            res.status(500).send("Error al actualizar el estado");
        }
    });
});

// Endpoint para obtener todos los registros de la tabla TBL_PAIS
app.get("/get_paises", (req, res) => {
    const query = "SELECT * FROM pfp_schema.get_paises()"; // Llama a la función almacenada

    // Ejecuta la consulta en la base de datos
    pgClient.query(query, (err, result) => {
        if (!err) {
            res.status(200).json(result.rows); // Envía los datos como JSON
        } else {
            console.error("Error al obtener los países:", err);
            res.status(500).send("Error al obtener los datos de países");
        }
    });
});

// Procedimiento para insertar un nuevo país
app.post("/insert_pais", (req, res) => {
    const { nombre_pais, id_estado } = req.body; // Capturamos los valores del cuerpo de la solicitud

    if (!nombre_pais || !id_estado) {
        return res
            .status(400)
            .send("El nombre del país y el ID del estado son requeridos");
    }

    const query = "CALL pfp_schema.insert_pais($1, $2)"; // Llamada al procedimiento almacenado
    const values = [nombre_pais, id_estado];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("País insertado exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al insertar el país");
        }
    });
});

// Procedimiento para actualizar un registro en la tabla TBL_PAIS
app.put("/update_pais", (req, res) => {
    const { id_pais, nombre_pais, id_estado } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (!id_pais || !nombre_pais || !id_estado) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (id_pais, nombre_pais, id_estado)"
            );
    }

    const query = "CALL pfp_schema.update_pais($1, $2, $3)"; // Llamada al procedimiento almacenado
    const values = [id_pais, nombre_pais, id_estado];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("País actualizado exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al actualizar el país");
        }
    });
});

// Endpoint para obtener todos los registros de la tabla TBL_ESTADO_CANJE
app.get("/get_estado_canje", (req, res) => {
    const query = "SELECT * FROM pfp_schema.get_estado_canje()"; // Llama a la función almacenada

    // Ejecuta la consulta en la base de datos
    pgClient.query(query, (err, result) => {
        if (!err) {
            res.status(200).json(result.rows); // Envía los datos como JSON
        } else {
            console.error("Error al obtener el estado de canje:", err);
            res.status(500).send(
                "Error al obtener los datos de estado de canje"
            );
        }
    });
});

// Procedimiento para insertar un nuevo estado de canje
app.post("/insert_estado_canje", (req, res) => {
    const { estado_canje } = req.body; // Capturamos el valor del cuerpo de la solicitud

    if (!estado_canje) {
        return res.status(400).send("El estado de canje es requerido");
    }

    const query = "CALL pfp_schema.insert_estado_canje($1)"; // Llamada al procedimiento almacenado
    const values = [estado_canje];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Estado de canje insertado exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al insertar el estado de canje");
        }
    });
});

// Procedimiento para actualizar un registro en la tabla TBL_ESTADO_CANJE
app.put("/update_estado_canje", (req, res) => {
    const { id_estado_canje, estado_canje } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (!id_estado_canje || !estado_canje) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (id_estado_canje, estado_canje)"
            );
    }

    const query = "CALL pfp_schema.update_estado_canje($1, $2)"; // Llamada al procedimiento almacenado
    const values = [id_estado_canje, estado_canje];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Estado de canje actualizado exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al actualizar el estado de canje");
        }
    });
});

// Endpoint para obtener todos los registros de la tabla TBL_TIPO_ENTIDAD
app.get("/get_tipo_entidad", (req, res) => {
    const query = "SELECT * FROM pfp_schema.get_tipo_entidad()"; // Llama a la función almacenada

    // Ejecuta la consulta en la base de datos
    pgClient.query(query, (err, result) => {
        if (!err) {
            res.status(200).json(result.rows); // Envía los datos como JSON
        } else {
            console.error("Error al obtener el tipo de entidad:", err);
            res.status(500).send(
                "Error al obtener los datos de tipo de entidad"
            );
        }
    });
});

// Procedimiento para insertar un nuevo tipo de entidad
app.post("/insert_tipo_entidad", (req, res) => {
    const { tipo_entidad, id_estado } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (!tipo_entidad || !id_estado) {
        return res
            .status(400)
            .send("Todos los campos son requeridos (tipo_entidad, id_estado)");
    }

    const query = "CALL pfp_schema.insert_tipo_entidad($1, $2)"; // Llamada al procedimiento almacenado
    const values = [tipo_entidad, id_estado];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Tipo de entidad insertado exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al insertar el tipo de entidad");
        }
    });
});

// Procedimiento para actualizar un registro en la tabla TBL_TIPO_ENTIDAD
app.put("/update_tipo_entidad", (req, res) => {
    const { id_tipo_entidad, tipo_entidad, id_estado } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (!id_tipo_entidad || !tipo_entidad || !id_estado) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (id_tipo_entidad, tipo_entidad, id_estado)"
            );
    }

    const query = "CALL pfp_schema.update_tipo_entidad($1, $2, $3)"; // Llamada al procedimiento almacenado
    const values = [id_tipo_entidad, tipo_entidad, id_estado];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Tipo de entidad actualizado exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al actualizar el tipo de entidad");
        }
    });
});

// Endpoint para obtener todos los registros de la tabla TBL_TIPO_REGISTRO
app.get("/get_tipo_registro", (req, res) => {
    const query = "SELECT * FROM pfp_schema.get_tipo_registro()"; // Llama a la función almacenada

    // Ejecuta la consulta en la base de datos
    pgClient.query(query, (err, result) => {
        if (!err) {
            res.status(200).json(result.rows); // Envía los datos como JSON
        } else {
            console.error("Error al obtener el tipo de registro:", err);
            res.status(500).send(
                "Error al obtener los datos de tipo de registro"
            );
        }
    });
});

// Procedimiento para insertar un nuevo registro en la tabla TBL_TIPO_REGISTRO
app.post("/insert_tipo_registro", (req, res) => {
    const { tipo_registro } = req.body; // Capturamos el valor desde el cuerpo de la solicitud

    // Validamos que el campo requerido esté presente
    if (!tipo_registro) {
        return res.status(400).send("El tipo de registro es requerido");
    }

    const query = "CALL pfp_schema.insert_tipo_registro($1)"; // Llamada al procedimiento almacenado
    const values = [tipo_registro];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Tipo de registro insertado exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al insertar el tipo de registro");
        }
    });
});

// Procedimiento para actualizar un registro en la tabla TBL_TIPO_REGISTRO
app.put("/update_tipo_registro", (req, res) => {
    const { id_tipo_registro, tipo_registro } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (!id_tipo_registro || !tipo_registro) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (id_tipo_registro, tipo_registro)"
            );
    }

    const query = "CALL pfp_schema.update_tipo_registro($1, $2)"; // Llamada al procedimiento almacenado
    const values = [id_tipo_registro, tipo_registro];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Tipo de registro actualizado exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al actualizar el tipo de registro");
        }
    });
});

// Endpoint para obtener todos los registros de la tabla TBL_UNIDAD_MEDIDA
app.get("/get_unidad_medida", (req, res) => {
    const query = "SELECT * FROM pfp_schema.get_unidad_medida()"; // Llama a la función almacenada

    // Ejecuta la consulta en la base de datos
    pgClient.query(query, (err, result) => {
        if (!err) {
            res.status(200).json(result.rows); // Envía los datos como JSON
        } else {
            console.error("Error al obtener la unidad de medida:", err);
            res.status(500).send(
                "Error al obtener los datos de unidad de medida"
            );
        }
    });
});

// Procedimiento para insertar un nuevo registro en la tabla TBL_UNIDAD_MEDIDA
app.post("/insert_unidad_medida", (req, res) => {
    const { unidad_medida, id_estado } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (!unidad_medida || !id_estado) {
        return res
            .status(400)
            .send("Todos los campos son requeridos (unidad_medida, id_estado)");
    }

    const query = "CALL pfp_schema.insert_unidad_medida($1, $2)"; // Llamada al procedimiento almacenado
    const values = [unidad_medida, id_estado];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Unidad de medida insertada exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al insertar la unidad de medida");
        }
    });
});

// Procedimiento para actualizar un registro en la tabla TBL_UNIDAD_MEDIDA
app.put("/update_unidad_medida", (req, res) => {
    const { id_unidad_medida, unidad_medida, id_estado } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (!id_unidad_medida || !unidad_medida || !id_estado) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (id_unidad_medida, unidad_medida, id_estado)"
            );
    }

    const query = "CALL pfp_schema.update_unidad_medida($1, $2, $3)"; // Llamada al procedimiento almacenado
    const values = [id_unidad_medida, unidad_medida, id_estado];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Unidad de medida actualizada exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al actualizar la unidad de medida");
        }
    });
});

// Endpoint para obtener todos los registros de la tabla TBL_ROL
app.get("/get_roles", (req, res) => {
    const query = "SELECT * FROM pfp_schema.get_roles()"; // Llama a la función almacenada

    // Ejecuta la consulta en la base de datos
    pgClient.query(query, (err, result) => {
        if (!err) {
            res.status(200).json(result.rows); // Envía los datos como JSON
        } else {
            console.error("Error al obtener los roles:", err);
            res.status(500).send("Error al obtener los datos de roles");
        }
    });
});

// Procedimiento para insertar un nuevo registro en la tabla TBL_ROL
app.post("/insert_rol", (req, res) => {
    const { rol, descripcion, id_estado } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (!rol || !descripcion || !id_estado) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (rol, descripcion, id_estado)"
            );
    }

    const query = "CALL pfp_schema.insert_rol($1, $2, $3)"; // Llamada al procedimiento almacenado
    const values = [rol, descripcion, id_estado];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Rol insertado exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al insertar el rol");
        }
    });
});

// Procedimiento para actualizar un registro en la tabla TBL_ROL
app.put("/update_rol", (req, res) => {
    const { id_rol, rol, descripcion, id_estado } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (!id_rol || !rol || !descripcion || !id_estado) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (id_rol, rol, descripcion, id_estado)"
            );
    }

    const query = "CALL pfp_schema.update_rol($1, $2, $3, $4)"; // Llamada al procedimiento almacenado
    const values = [id_rol, rol, descripcion, id_estado];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Rol actualizado exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al actualizar el rol");
        }
    });
});

// Endpoint para obtener todos los registros de la tabla TBL_VIA_ADMINISTRACION
app.get("/get_via_administracion", (req, res) => {
    const query = "SELECT * FROM pfp_schema.get_via_administracion()"; // Llama a la función almacenada

    // Ejecuta la consulta en la base de datos
    pgClient.query(query, (err, result) => {
        if (!err) {
            res.status(200).json(result.rows); // Envía los datos como JSON
        } else {
            console.error("Error al obtener la vía de administración:", err);
            res.status(500).send(
                "Error al obtener los datos de vía de administración"
            );
        }
    });
});

// Procedimiento para insertar un nuevo registro en la tabla TBL_VIA_ADMINISTRACION
app.post("/insert_via_administracion", (req, res) => {
    const { via_administracion, id_estado } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (!via_administracion || !id_estado) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (via_administracion, id_estado)"
            );
    }

    const query = "CALL pfp_schema.insert_via_administracion($1, $2)"; // Llamada al procedimiento almacenado
    const values = [via_administracion, id_estado];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send(
                "Vía de administración insertada exitosamente"
            );
        } else {
            console.log(err);
            res.status(500).send("Error al insertar la vía de administración");
        }
    });
});

// Procedimiento para actualizar un registro en la tabla TBL_VIA_ADMINISTRACION
app.put("/update_via_administracion", (req, res) => {
    const { id_via_administracion, via_administracion, id_estado } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (!id_via_administracion || !via_administracion || !id_estado) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (id_via_administracion, via_administracion, id_estado)"
            );
    }

    const query = "CALL pfp_schema.update_via_administracion($1, $2, $3)"; // Llamada al procedimiento almacenado
    const values = [id_via_administracion, via_administracion, id_estado];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send(
                "Vía de administración actualizada exitosamente"
            );
        } else {
            console.log(err);
            res.status(500).send(
                "Error al actualizar la vía de administración"
            );
        }
    });
});

// Endpoint para obtener todos los registros de la tabla TBL_ZONA
app.get("/get_zonas", (req, res) => {
    const query = "SELECT * FROM pfp_schema.get_zonas()"; // Llama a la función almacenada

    // Ejecuta la consulta en la base de datos
    pgClient.query(query, (err, result) => {
        if (!err) {
            res.status(200).json(result.rows); // Envía los datos como JSON
        } else {
            console.error("Error al obtener zonas:", err);
            res.status(500).send("Error al obtener los datos de zonas");
        }
    });
});

// Procedimiento para insertar un nuevo registro en la tabla TBL_ZONA
app.post("/insert_zona", (req, res) => {
    const { id_pais, zona, id_estado } = req.body; // Capturamos los valores del cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (!id_pais || !zona || !id_estado) {
        return res
            .status(400)
            .send(
                "El ID del país, el nombre de la zona y el ID del estado son requeridos"
            );
    }

    const query = "CALL pfp_schema.insert_zona($1, $2, $3)"; // Llamada al procedimiento almacenado
    const values = [id_pais, zona, id_estado];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Zona insertada exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al insertar la zona");
        }
    });
});

// Procedimiento para actualizar un registro en la tabla TBL_ZONA
app.put("/update_zona", (req, res) => {
    const { id_zona, id_pais, zona, id_estado } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (!id_zona || !id_pais || !zona || !id_estado) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (id_pais, id_zona, zona, id_estado)"
            );
    }

    const query = "CALL pfp_schema.update_zona($1, $2, $3, $4)"; // Llamada al procedimiento almacenado con id_pais primero
    const values = [id_zona, id_pais, zona, id_estado];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Zona actualizada exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al actualizar la zona");
        }
    });
});

// Endpoint para obtener todos los registros de la tabla TBL_DEPARTAMENTO
app.get("/get_departamentos", (req, res) => {
    const query = "SELECT * FROM pfp_schema.get_departamentos()"; // Llama a la función almacenada

    // Ejecuta la consulta en la base de datos
    pgClient.query(query, (err, result) => {
        if (!err) {
            res.status(200).json(result.rows); // Envía los datos como JSON
        } else {
            console.error("Error al obtener departamentos:", err);
            res.status(500).send("Error al obtener los datos de departamentos");
        }
    });
});

// Procedimiento para insertar un nuevo departamento
app.post("/insert_departamento", (req, res) => {
    const { id_zona, nombre_departamento, id_estado } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (!id_zona || !nombre_departamento || !id_estado) {
        return res
            .status(400)
            .send(
                "El ID de la zona, el nombre del departamento y el ID del estado son requeridos"
            );
    }

    const query = "CALL pfp_schema.insert_departamento($1, $2, $3)"; // Llamada al procedimiento almacenado
    const values = [id_zona, nombre_departamento, id_estado];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Departamento insertado exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al insertar el departamento");
        }
    });
});

// Procedimiento para actualizar un registro en la tabla TBL_DEPARTAMENTO
app.put("/update_departamento", (req, res) => {
    const { id_zona, id_departamento, nombre_departamento, id_estado } =
        req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (!id_zona || !id_departamento || !nombre_departamento || !id_estado) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (id_zona, id_departamento, nombre_departamento, id_estado)"
            );
    }

    const query = "CALL pfp_schema.update_departamento($1, $2, $3, $4)"; // Llamada al procedimiento almacenado
    const values = [id_zona, id_departamento, nombre_departamento, id_estado];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Departamento actualizado exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al actualizar el departamento");
        }
    });
});

// Endpoint para obtener todos los registros de la tabla TBL_MUNICIPIO
app.get("/get_municipios", (req, res) => {
    const query = "SELECT * FROM pfp_schema.get_municipios()"; // Llama a la función almacenada

    // Ejecuta la consulta en la base de datos
    pgClient.query(query, (err, result) => {
        if (!err) {
            res.status(200).json(result.rows); // Envía los datos como JSON
        } else {
            console.error("Error al obtener municipios:", err);
            res.status(500).send("Error al obtener los datos de municipios");
        }
    });
});

// Procedimiento para insertar un nuevo municipio
app.post("/insert_municipio", (req, res) => {
    const { id_departamento, municipio, id_estado } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (!id_departamento || !municipio || !id_estado) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (id_departamento, municipio, id_estado)"
            );
    }

    const query = "CALL pfp_schema.insert_municipio($1, $2, $3)"; // Llamada al procedimiento almacenado
    const values = [id_departamento, municipio, id_estado];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Municipio insertado exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al insertar el municipio");
        }
    });
});

// Procedimiento para actualizar un registro en la tabla TBL_MUNICIPIO
app.put("/update_municipio", (req, res) => {
    const { id_departamento, id_municipio, municipio, id_estado } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (!id_departamento || !id_municipio || !municipio || !id_estado) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (id_departamento, id_municipio, municipio, id_estado)"
            );
    }

    const query = "CALL pfp_schema.update_municipio($1, $2, $3, $4)"; // Llamada al procedimiento almacenado
    const values = [id_departamento, id_municipio, municipio, id_estado];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Municipio actualizado exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al actualizar el municipio");
        }
    });
});

// Endpoint para obtener todos los registros de la tabla TBL_ESPECIALIDAD
app.get("/get_especialidad", (req, res) => {
    const query = "SELECT * FROM pfp_schema.get_especialidad()"; // Llama a la función almacenada

    // Ejecuta la consulta en la base de datos
    pgClient.query(query, (err, result) => {
        if (!err) {
            res.status(200).json(result.rows); // Envía los datos como JSON
        } else {
            console.error("Error al obtener especialidades:", err);
            res.status(500).send("Error al obtener los datos de especialidad");
        }
    });
});

// Procedimiento para insertar un registro en la tabla TBL_ESPECIALIDAD
app.post("/insert_especialidad", (req, res) => {
    const { nombre_especialidad, id_estado } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (!nombre_especialidad || !id_estado) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (nombre_especialidad, id_estado)"
            );
    }

    const query = "CALL pfp_schema.insert_especialidad($1, $2)"; // Llamada al procedimiento almacenado
    const values = [nombre_especialidad, id_estado];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(201).send("Especialidad insertada exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al insertar la especialidad");
        }
    });
});

// Procedimiento para actualizar un registro en la tabla TBL_ESPECIALIDAD
app.put("/update_especialidad", (req, res) => {
    const { id_especialidad, nombre_especialidad, id_estado } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (!id_especialidad || !nombre_especialidad || !id_estado) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (id_especialidad, nombre_especialidad, id_estado)"
            );
    }

    const query = "CALL pfp_schema.update_especialidad($1, $2, $3)"; // Llamada al procedimiento almacenado
    const values = [id_especialidad, nombre_especialidad, id_estado];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Especialidad actualizada exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al actualizar la especialidad");
        }
    });
});

// Endpoint para obtener todos los registros de la tabla TBL_FORMA_FARMACEUTICA
app.get("/get_forma_farmaceutica", (req, res) => {
    const query = "SELECT * FROM pfp_schema.get_forma_farmaceutica()"; // Llama a la función almacenada

    // Ejecuta la consulta en la base de datos
    pgClient.query(query, (err, result) => {
        if (!err) {
            res.status(200).json(result.rows); // Envía los datos como JSON
        } else {
            console.error("Error al obtener formas farmacéuticas:", err);
            res.status(500).send(
                "Error al obtener los datos de forma farmacéutica"
            );
        }
    });
});

// Procedimiento para insetar un registro en la tabla TBL_FORMA_FARMACEUTICA
app.post("/insert_forma_farmaceutica", (req, res) => {
    const { forma_farmaceutica, id_estado } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (!forma_farmaceutica || !id_estado) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (forma_farmaceutica, id_estado)"
            );
    }

    const query = "CALL pfp_schema.insert_forma_farmaceutica($1, $2)"; // Llamada al procedimiento almacenado
    const values = [forma_farmaceutica, id_estado];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Forma farmacéutica insertada exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al insertar la forma farmacéutica");
        }
    });
});

// Procedimiento para actualizar un registro en la tabla TBL_FORMA_FARMACEUTICA
app.put("/update_forma_farmaceutica", (req, res) => {
    const { id_forma_farmaceutica, forma_farmaceutica, id_estado } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (!id_forma_farmaceutica || !forma_farmaceutica || !id_estado) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (id_forma_farmaceutica, forma_farmaceutica, id_estado)"
            );
    }

    const query = "CALL pfp_schema.update_forma_farmaceutica($1, $2, $3)"; // Llamada al procedimiento almacenado
    const values = [id_forma_farmaceutica, forma_farmaceutica, id_estado];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Forma farmacéutica actualizada exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al actualizar la forma farmacéutica");
        }
    });
});

// Procedimiento para SELECCIONAR  registrosen la tabla TBL_TIPO_CONTACTO
app.get("/get_tipo_contacto", (req, res) => {
    const query = "SELECT * FROM pfp_schema.get_tipo_contacto()"; // Llama a la función almacenada

    // Ejecuta la consulta en la base de datos
    pgClient.query(query, (err, result) => {
        if (!err) {
            res.status(200).json(result.rows); // Envía los datos como JSON
        } else {
            console.error("Error al obtener tipos de contacto:", err);
            res.status(500).send(
                "Error al obtener los datos de tipo de contacto"
            );
        }
    });
});

// Procedimiento para insertar un registro en la tabla TBL_TIPO_CONTACTO
app.post("/insert_tipo_contacto", (req, res) => {
    const { tipo_contacto, id_estado } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (!tipo_contacto || !id_estado) {
        return res
            .status(400)
            .send("Todos los campos son requeridos (tipo_contacto, id_estado)");
    }

    const query = "CALL pfp_schema.insert_tipo_contacto($1, $2)"; // Llamada al procedimiento almacenado
    const values = [tipo_contacto, id_estado];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Tipo de contacto insertado exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al insertar el tipo de contacto");
        }
    });
});

// Procedimiento para actualizar un registro en la tabla TBL_TIPO_CONTACTO
app.put("/update_tipo_contacto", (req, res) => {
    const { id_tipo_contacto, tipo_contacto, id_estado } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (!id_tipo_contacto || !tipo_contacto || !id_estado) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (id_tipo_contacto, tipo_contacto, id_estado)"
            );
    }

    const query = "CALL pfp_schema.update_tipo_contacto($1, $2, $3)"; // Llamada al procedimiento almacenado
    const values = [id_tipo_contacto, tipo_contacto, id_estado];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Tipo de contacto actualizado exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al actualizar el tipo de contacto");
        }
    });
});

// Procedimiento para seleccionar  registros en la tabla TBL_MARCA_PRODUCTO
app.get("/get_marca_producto", (req, res) => {
    const query = "SELECT * FROM pfp_schema.get_marca_producto()"; // Llama a la función almacenada

    // Ejecuta la consulta en la base de datos
    pgClient.query(query, (err, result) => {
        if (!err) {
            res.status(200).json(result.rows); // Envía los datos como JSON
        } else {
            console.error("Error al obtener marcas de producto:", err);
            res.status(500).send(
                "Error al obtener los datos de marca de producto"
            );
        }
    });
});

// Procedimiento para insertar un registro en la tabla TBL_MARCA_PRODUCTO
app.post("/insert_marca_producto", (req, res) => {
    const { marca_producto, id_estado } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (!marca_producto || !id_estado) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (marca_producto, id_estado)"
            );
    }

    const query = "CALL pfp_schema.insert_marca_producto($1, $2)"; // Llamada al procedimiento almacenado
    const values = [marca_producto, id_estado];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Marca de producto insertada exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al insertar la marca de producto");
        }
    });
});

// Procedimiento para actualizar un registro en la tabla TBL_MARCA_PRODUCTO
app.put("/update_marca_producto", (req, res) => {
    const { id_marca_producto, marca_producto, id_estado } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (!id_marca_producto || !marca_producto || !id_estado) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (id_marca_producto, marca_producto, id_estado)"
            );
    }

    const query = "CALL pfp_schema.update_marca_producto($1, $2, $3)"; // Llamada al procedimiento almacenado
    const values = [id_marca_producto, marca_producto, id_estado];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Marca de producto actualizada exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al actualizar la marca de producto");
        }
    });
});

// Procedimiento para SELECIONAR  registros en la tabla TBL_PRODUCTO
app.get("/get_producto", (req, res) => {
    const query = "SELECT * FROM pfp_schema.get_producto()"; // Llama a la función almacenada

    // Ejecuta la consulta en la base de datos
    pgClient.query(query, (err, result) => {
        if (!err) {
            res.status(200).json(result.rows); // Envía los datos como JSON
        } else {
            console.error("Error al obtener productos:", err);
            res.status(500).send("Error al obtener los datos de producto");
        }
    });
});

// Procedimiento para insertar un registro en la tabla TBL_PRODUCTO
app.post("/insert_producto", (req, res) => {
    const {
        codigo_barra,
        nombre_producto,
        id_forma_farmaceutica,
        id_especialidad,
        id_marca_producto,
        id_unidad_medida,
        id_via_administracion,
        id_estado,
        id_laboratorio,
        escala,
        canje,
        contenido_neto,
        consumo_diario,
        consumo_max_anual,
        canjes_max_anual,
    } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (
        !codigo_barra ||
        !nombre_producto ||
        !id_forma_farmaceutica ||
        !id_especialidad ||
        !id_marca_producto ||
        !id_unidad_medida ||
        !id_via_administracion ||
        !id_estado ||
        !id_laboratorio ||
        !escala ||
        !canje ||
        !contenido_neto ||
        !consumo_diario ||
        !consumo_max_anual ||
        !canjes_max_anual
    ) {
        return res.status(400).send("Todos los campos son requeridos");
    }

    const query =
        "CALL pfp_schema.insert_producto($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15)"; // Llamada al procedimiento almacenado
    const values = [
        codigo_barra,
        nombre_producto,
        id_forma_farmaceutica,
        id_especialidad,
        id_marca_producto,
        id_unidad_medida,
        id_via_administracion,
        id_estado,
        id_laboratorio,
        escala,
        canje,
        contenido_neto,
        consumo_diario,
        consumo_max_anual,
        canjes_max_anual,
    ];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Producto insertado exitosamente");
        } else {
            console.error(err);
            res.status(500).send("Error al insertar el producto");
        }
    });
});

// Procedimiento para actualizar un registro en la tabla TBL_PRODUCTO
app.put("/update_producto", (req, res) => {
    const {
        id_producto,
        codigo_barra,
        nombre_producto,
        id_forma_farmaceutica,
        id_especialidad,
        id_marca_producto,
        id_unidad_medida,
        id_via_administracion,
        id_estado,
        id_laboratorio,
        escala,
        canje,
        contenido_neto,
        consumo_diario,
        consumo_max_anual,
        canjes_max_anual,
    } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (
        !id_producto ||
        !codigo_barra ||
        !nombre_producto ||
        !id_forma_farmaceutica ||
        !id_especialidad ||
        !id_marca_producto ||
        !id_unidad_medida ||
        !id_via_administracion ||
        !id_estado ||
        !id_laboratorio ||
        !escala ||
        !canje ||
        !contenido_neto ||
        !consumo_diario ||
        !consumo_max_anual ||
        !canjes_max_anual
    ) {
        return res.status(400).send("Todos los campos son requeridos");
    }

    const query =
        "CALL pfp_schema.update_producto($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16)"; // Llamada al procedimiento almacenado
    const values = [
        id_producto,
        codigo_barra,
        nombre_producto,
        id_forma_farmaceutica,
        id_especialidad,
        id_marca_producto,
        id_unidad_medida,
        id_via_administracion,
        id_estado,
        id_laboratorio,
        escala,
        canje,
        contenido_neto,
        consumo_diario,
        consumo_max_anual,
        canjes_max_anual,
    ];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Producto actualizado exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al actualizar el producto");
        }
    });
});

// Procedimiento para seleccionar un registro en la tabla TBL_LOTE_PRODUCTO
app.get("/get_lote_producto", (req, res) => {
    const query = "SELECT * FROM pfp_schema.get_lote_producto()"; // Llama a la función almacenada

    // Ejecuta la consulta en la base de datos
    pgClient.query(query, (err, result) => {
        if (!err) {
            res.status(200).json(result.rows); // Envía los datos como JSON
        } else {
            console.error("Error al obtener lotes de producto:", err);
            res.status(500).send(
                "Error al obtener los datos de lote de producto"
            );
        }
    });
});

// Procedimiento para insertar un registro en la tabla TBL_LOTE_PRODUCTO
app.post("/insert_lote_producto", (req, res) => {
    const { lote_producto, id_producto, fecha_vencimiento, id_estado } =
        req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (!lote_producto || !id_producto || !fecha_vencimiento || !id_estado) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (lote_producto, id_producto, fecha_vencimiento, id_estado)"
            );
    }

    const query = "CALL pfp_schema.insert_lote_producto($1, $2, $3, $4)"; // Llamada al procedimiento almacenado
    const values = [lote_producto, id_producto, fecha_vencimiento, id_estado];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Lote de producto insertado exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al insertar el lote de producto");
        }
    });
});

// Procedimiento para actualizar un registro en la tabla TBL_LOTE_PRODUCTO
app.put("/update_lote_producto", (req, res) => {
    const {
        id_lote_producto,
        lote_producto,
        id_producto,
        fecha_vencimiento,
        id_estado,
    } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (
        !id_lote_producto ||
        !lote_producto ||
        !id_producto ||
        !fecha_vencimiento ||
        !id_estado
    ) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (id_lote_producto, lote_producto, id_producto, fecha_vencimiento, id_estado)"
            );
    }

    const query = "CALL pfp_schema.update_lote_producto($1, $2, $3, $4, $5)"; // Llamada al procedimiento almacenado
    const values = [
        id_lote_producto,
        lote_producto,
        id_producto,
        fecha_vencimiento,
        id_estado,
    ];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Lote de producto actualizado exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al actualizar el lote de producto");
        }
    });
});

// Procedimiento para seleccionar un registro en la tabla TBL_PREGUNTAS
app.get("/get_preguntas", (req, res) => {
    const query = "SELECT * FROM pfp_schema.get_preguntas()"; // Llama a la función almacenada

    // Ejecuta la consulta en la base de datos
    pgClient.query(query, (err, result) => {
        if (!err) {
            res.status(200).json(result.rows); // Envía los datos como JSON
        } else {
            console.error("Error al obtener preguntas:", err);
            res.status(500).send("Error al obtener los datos de preguntas");
        }
    });
});

// Procedimiento para insertar un registro en la tabla TBL_PREGUNTAS
app.post("/insert_pregunta", (req, res) => {
    const { pregunta } = req.body; // Capturamos el valor desde el cuerpo de la solicitud

    // Validamos que el campo requerido esté presente
    if (!pregunta) {
        return res.status(400).send('El campo "pregunta" es requerido');
    }

    const query = "CALL pfp_schema.insert_pregunta($1)"; // Llamada al procedimiento almacenado
    const values = [pregunta];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Pregunta insertada exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al insertar la pregunta");
        }
    });
});

// Procedimiento para actualizar un registro en la tabla TBL_PREGUNTAS
app.put("/update_pregunta", (req, res) => {
    const { id_pregunta, pregunta } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (!id_pregunta || !pregunta) {
        return res
            .status(400)
            .send("Todos los campos son requeridos (id_pregunta, pregunta)");
    }

    const query = "CALL pfp_schema.update_pregunta($1, $2)"; // Llamada al procedimiento almacenado
    const values = [id_pregunta, pregunta];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Pregunta actualizada exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al actualizar la pregunta");
        }
    });
});

// Procedimiento para  seleccionar  registro en la tabla TBL_SUCURSAL
app.get("/get_sucursales", (req, res) => {
    const query = "SELECT * FROM pfp_schema.get_sucursales()"; // Llama a la función almacenada

    // Ejecuta la consulta en la base de datos
    pgClient.query(query, (err, result) => {
        if (!err) {
            res.status(200).json(result.rows); // Envía los datos como JSON
        } else {
            console.error("Error al obtener detalles de sucursales:", err);
            res.status(500).send(
                "Error al obtener los datos de detalles de sucursales"
            );
        }
    });
});

// Procedimiento para insertar un registro en la tabla TBL_SUCURSAL
app.post("/insert_sucursal", (req, res) => {
    const { id_municipio, nombre_sucursal, id_estado } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (!id_municipio || !nombre_sucursal || !id_estado) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (id_municipio, nombre_sucursal, id_estado)"
            );
    }

    const query = "CALL pfp_schema.insert_sucursal($1, $2, $3)"; // Llamada al procedimiento almacenado
    const values = [id_municipio, nombre_sucursal, id_estado]; // 'ADMINISTRADOR' como valor por defecto

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(201).send("Sucursal insertada exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al insertar la sucursal");
        }
    });
});

// Procedimiento para actualizar un registro en la tabla TBL_SUCURSAL
app.put("/update_sucursal", (req, res) => {
    const { id_sucursal, id_municipio, nombre_sucursal, id_estado } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (!id_sucursal || !id_municipio || !nombre_sucursal || !id_estado) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (id_sucursal, id_municipio, nombre_sucursal, id_estado)"
            );
    }

    const query = "CALL pfp_schema.update_sucursal($1, $2, $3, $4)"; // Llamada al procedimiento almacenado
    const values = [id_municipio, id_sucursal, nombre_sucursal, id_estado]; // Ajustamos el orden de los valores

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Sucursal actualizada exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al actualizar la sucursal");
        }
    });
});

// Procedimiento para seleccionar  registros en la tabla TBL_USUARIO
app.get("/get_usuarios", (req, res) => {
    const query = "SELECT * FROM pfp_schema.get_usuarios()"; // Llama a la función almacenada

    // Ejecuta la consulta en la base de datos
    pgClient.query(query, (err, result) => {
        if (!err) {
            res.status(200).json(result.rows); // Envía los datos como JSON
        } else {
            console.error("Error al obtener usuarios:", err);
            res.status(500).send("Error al obtener los datos de usuarios");
        }
    });
});

// Procedimiento para insertar un registro en la tabla TBL_USUARIO
app.post("/insert_usuario", (req, res) => {
    const {
        usuario,
        nombre_usuario,
        contrasena,
        id_rol,
        email,
        primer_ingreso,
        id_estado,
    } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (
        !usuario ||
        !nombre_usuario ||
        !contrasena ||
        !id_rol ||
        !email ||
        primer_ingreso === undefined ||
        !id_estado
    ) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (usuario, nombre_usuario, contrasena, id_rol, email, primer_ingreso, id_estado)"
            );
    }

    const query = "CALL pfp_schema.insert_usuario($1, $2, $3, $4, $5, $6, $7)"; // Llamada al procedimiento almacenado
    const values = [
        usuario,
        nombre_usuario,
        contrasena,
        id_rol,
        email,
        primer_ingreso,
        id_estado,
    ]; // Parámetros de entrada

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(201).send("Usuario insertado exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al insertar el usuario");
        }
    });
});

// Procedimiento para actualizar un registro en la tabla TBL_USUARIO
app.put("/update_usuario", (req, res) => {
    const {
        id_usuario,
        usuario,
        nombre_usuario,
        contrasena,
        id_rol,
        email,
        primer_ingreso,
        id_estado,
    } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (
        !id_usuario ||
        !usuario ||
        !nombre_usuario ||
        !contrasena ||
        !id_rol ||
        !email ||
        primer_ingreso === undefined ||
        !id_estado
    ) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (id_usuario, usuario, nombre_usuario, contrasena, id_rol, email, primer_ingreso, id_estado)"
            );
    }

    const query =
        "CALL pfp_schema.update_usuario($1, $2, $3, $4, $5, $6, $7, $8)"; // Llamada al procedimiento almacenado
    const values = [
        id_usuario,
        usuario,
        nombre_usuario,
        contrasena,
        id_rol,
        email,
        primer_ingreso,
        id_estado,
    ]; // Parámetros de entrada

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Usuario actualizado exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al actualizar el usuario");
        }
    });
});

// Procedimiento para seleccionar  registro en la tabla TBL_CONTACTO
app.get("/get_contactos", (req, res) => {
    const query = "SELECT * FROM pfp_schema.get_contactos()"; // Llama a la función almacenada

    // Ejecuta la consulta en la base de datos
    pgClient.query(query, (err, result) => {
        if (!err) {
            res.status(200).json(result.rows); // Envía los datos como JSON
        } else {
            console.error("Error al obtener detalles de contactos:", err);
            res.status(500).send(
                "Error al obtener los datos de detalles de contactos"
            );
        }
    });
});

// Procedimiento para insertar un registro en la tabla TBL_CONTACTO
app.post("/insert_contacto", (req, res) => {
    const {
        nombre_contacto,
        id_usuario,
        id_tipo_contacto,
        telefono_1,
        telefono_2,
        email,
        id_estado,
    } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (
        !nombre_contacto ||
        !id_usuario ||
        !id_tipo_contacto ||
        !telefono_1 ||
        !email ||
        !id_estado
    ) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (nombre_contacto, id_usuario, id_tipo_contacto, telefono_1, email, id_estado)"
            );
    }

    const query = "CALL pfp_schema.insert_contacto($1, $2, $3, $4, $5, $6, $7)"; // Llamada al procedimiento almacenado
    const values = [
        nombre_contacto,
        id_usuario,
        id_tipo_contacto,
        telefono_1,
        telefono_2,
        email,
        id_estado,
    ]; // Valores a insertar

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(201).send("Contacto insertado exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al insertar el contacto");
        }
    });
});

// Procedimiento para actualizar un registro en la tabla TBL_CONTACTO
app.put("/update_contacto", (req, res) => {
    const {
        id_contacto,
        nombre_contacto,
        id_usuario,
        id_tipo_contacto,
        telefono_1,
        telefono_2,
        email,
        id_estado,
    } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (
        !id_contacto ||
        !nombre_contacto ||
        !id_usuario ||
        !id_tipo_contacto ||
        !telefono_1 ||
        !telefono_2 ||
        !email ||
        !id_estado
    ) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (id_contacto, nombre_contacto, id_usuario, id_tipo_contacto, telefono_1, telefono_2, email, id_estado)"
            );
    }

    const query =
        "CALL pfp_schema.update_contacto($1, $2, $3, $4, $5, $6, $7, $8)"; // Llamada al procedimiento almacenado
    const values = [
        id_contacto,
        nombre_contacto,
        id_usuario,
        id_tipo_contacto,
        telefono_1,
        telefono_2,
        email,
        id_estado,
    ]; // Parámetros de entrada

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Contacto actualizado exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al actualizar el contacto");
        }
    });
});

// Procedimiento para seleccionar un registro en la tabla TBL_DISTRIBUIDOR
app.get("/get_distribuidores", (req, res) => {
    const query = "SELECT * FROM pfp_schema.get_distribuidores()";

    // Ejecuta la consulta en la base de datos
    pgClient.query(query, (err, result) => {
        if (!err) {
            res.status(200).json(result.rows); // Envía los datos como JSON
        } else {
            console.error("Error al obtener detalles de distribuidores:", err);
            res.status(500).send(
                "Error al obtener los datos de detalles de distribuidores"
            );
        }
    });
});

// Procedimiento para insertar un registro en la tabla TBL_DISTRIBUIDOR
app.post("/insert_distribuidor", (req, res) => {
    const {
        rtn_distribuidor,
        nombre_distribuidor,
        id_pais,
        id_tipo_entidad,
        id_usuario,
        id_contacto,
        id_estado,
    } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (
        !rtn_distribuidor ||
        !nombre_distribuidor ||
        !id_pais ||
        !id_tipo_entidad ||
        !id_usuario ||
        !id_contacto ||
        !id_estado
    ) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (rtn_distribuidor, nombre_distribuidor, id_pais, id_tipo_entidad, id_usuario, id_contacto, id_estado)"
            );
    }

    const query =
        "CALL pfp_schema.insert_distribuidor($1, $2, $3, $4, $5, $6, $7)"; // Llamada al procedimiento almacenado
    const values = [
        rtn_distribuidor,
        nombre_distribuidor,
        id_pais,
        id_tipo_entidad,
        id_usuario,
        id_contacto,
        id_estado,
    ]; // Valores a insertar

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(201).send("Distribuidor insertado exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al insertar el distribuidor");
        }
    });
});

// Procedimiento para actualizar un registro en la tabla TBL_DISTRIBUIDOR
app.put("/update_distribuidor", (req, res) => {
    const {
        id_distribuidor,
        rtn_distribuidor,
        nombre_distribuidor,
        id_pais,
        id_tipo_entidad,
        id_usuario,
        id_contacto,
        id_estado,
    } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (
        !id_distribuidor ||
        !rtn_distribuidor ||
        !nombre_distribuidor ||
        !id_pais ||
        !id_tipo_entidad ||
        !id_usuario ||
        !id_contacto ||
        !id_estado
    ) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (id_distribuidor, rtn_distribuidor, nombre_distribuidor, id_pais, id_tipo_entidad, id_usuario, id_contacto, id_estado)"
            );
    }

    const query =
        "CALL pfp_schema.update_distribuidor($1, $2, $3, $4, $5, $6, $7, $8)"; // Llamada al procedimiento almacenado
    const values = [
        id_distribuidor,
        rtn_distribuidor,
        nombre_distribuidor,
        id_pais,
        id_tipo_entidad,
        id_usuario,
        id_contacto,
        id_estado,
    ]; // Parámetros de entrada

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Distribuidor actualizado exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al actualizar el distribuidor");
        }
    });
});

// Procedimiento para seleccionar  registros en la tabla TBL_LABORATORIO
app.get("/get_laboratorios", (req, res) => {
    const query = "SELECT * FROM pfp_schema.get_laboratorios()";

    // Ejecuta la consulta en la base de datos
    pgClient.query(query, (err, result) => {
        if (!err) {
            res.status(200).json(result.rows); // Envía los datos como JSON
        } else {
            console.error("Error al obtener detalles de laboratorios:", err);
            res.status(500).send(
                "Error al obtener los datos de detalles de laboratorios"
            );
        }
    });
});

// Procedimiento para insertar un registro en la tabla TBL_LABORATORIO
app.post("/insert_laboratorio", (req, res) => {
    const {
        rtn_laboratorio,
        nombre_laboratorio,
        id_pais,
        id_tipo_entidad,
        id_usuario,
        id_contacto,
        id_estado,
    } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (
        !rtn_laboratorio ||
        !nombre_laboratorio ||
        !id_pais ||
        !id_tipo_entidad ||
        !id_usuario ||
        !id_contacto ||
        !id_estado
    ) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (rtn_laboratorio, nombre_laboratorio, id_pais, id_tipo_entidad, id_usuario, id_contacto, id_estado)"
            );
    }

    const query =
        "CALL pfp_schema.insert_laboratorio($1, $2, $3, $4, $5, $6, $7)"; // Llamada al procedimiento almacenado
    const values = [
        rtn_laboratorio,
        nombre_laboratorio,
        id_pais,
        id_tipo_entidad,
        id_usuario,
        id_contacto,
        id_estado,
    ]; // Parámetros de entrada

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(201).send("Laboratorio insertado exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al insertar el laboratorio");
        }
    });
});

// Procedimiento para actualizar un registro en la tabla TBL_LABORATORIO
app.put("/update_laboratorio", (req, res) => {
    const {
        id_laboratorio,
        rtn_laboratorio,
        nombre_laboratorio,
        id_pais,
        id_tipo_entidad,
        id_usuario,
        id_contacto,
        id_estado,
    } = req.body;

    // Validación de campos
    if (
        !id_laboratorio ||
        !rtn_laboratorio ||
        !nombre_laboratorio ||
        !id_pais ||
        !id_tipo_entidad ||
        !id_usuario ||
        !id_contacto ||
        !id_estado
    ) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (id_laboratorio, rtn_laboratorio, nombre_laboratorio, id_pais, id_tipo_entidad, id_usuario, id_contacto, id_estado)"
            );
    }

    const query =
        "CALL pfp_schema.update_laboratorio($1, $2, $3, $4, $5, $6, $7, $8)";
    const values = [
        id_laboratorio,
        rtn_laboratorio,
        nombre_laboratorio,
        id_pais,
        id_tipo_entidad,
        id_usuario,
        id_contacto,
        id_estado,
    ];

    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Laboratorio actualizado exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al actualizar el laboratorio");
        }
    });
});

// Procedimiento para seleccionar  registros en la tabla TBL_PACIENTE
app.get("/get_pacientes", (req, res) => {
    const query = "SELECT * FROM pfp_schema.get_pacientes()";

    // Ejecuta la consulta en la base de datos
    pgClient.query(query, (err, result) => {
        if (!err) {
            res.status(200).json(result.rows); // Envía los datos como JSON
        } else {
            console.error("Error al obtener detalles de pacientes:", err);
            res.status(500).send(
                "Error al obtener los datos de detalles de pacientes"
            );
        }
    });
});

// Procedimiento para insertar un registro en la tabla TBL_PACIENTE
app.post("/insert_paciente", (req, res) => {
    const {
        dni_paciente,
        nombre_paciente,
        apellido_paciente,
        fecha_nacimiento,
        email,
        direccion,
        celular,
        tratamiento_medico,
        id_usuario,
        id_estado,
        genero,
    } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (
        !dni_paciente ||
        !nombre_paciente ||
        !apellido_paciente ||
        !fecha_nacimiento ||
        !email ||
        !direccion ||
        !celular ||
        !tratamiento_medico ||
        !id_usuario ||
        !id_estado ||
        !genero
    ) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (dni_paciente, nombre_paciente, apellido_paciente, fecha_nacimiento, email, direccion, celular, tratamiento_medico, id_usuario, id_estado, genero)"
            );
    }

    const query =
        "CALL pfp_schema.insert_paciente($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)"; // Llamada al procedimiento almacenado
    const values = [
        dni_paciente,
        nombre_paciente,
        apellido_paciente,
        fecha_nacimiento,
        email,
        direccion,
        celular,
        tratamiento_medico,
        id_usuario,
        id_estado,
        genero,
    ]; // Valores a insertar

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(201).send("Paciente insertado exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al insertar el paciente");
        }
    });
});

// Procedimiento para actualizar un registro en la tabla TBL_PACIENTE
app.put("/update_paciente", (req, res) => {
    const {
        id_paciente,
        dni_paciente,
        nombre_paciente,
        apellido_paciente,
        fecha_nacimiento,
        email,
        direccion,
        celular,
        tratamiento_medico,
        id_usuario,
        id_estado,
        genero,
    } = req.body;

    // Validación de campos
    if (
        !id_paciente ||
        !dni_paciente ||
        !nombre_paciente ||
        !apellido_paciente ||
        !fecha_nacimiento ||
        !email ||
        !direccion ||
        !celular ||
        !tratamiento_medico ||
        !id_usuario ||
        !id_estado ||
        !genero
    ) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (id_paciente, dni_paciente, nombre_paciente, apellido_paciente, fecha_nacimiento, email, direccion, celular, tratamiento_medico, id_usuario, id_estado, genero)"
            );
    }

    const query =
        "CALL pfp_schema.update_paciente($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12)";
    const values = [
        id_paciente,
        dni_paciente,
        nombre_paciente,
        apellido_paciente,
        fecha_nacimiento,
        email,
        direccion,
        celular,
        tratamiento_medico,
        id_usuario,
        id_estado,
        genero,
    ];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Paciente actualizado exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al actualizar el paciente");
        }
    });
});

// Procedimiento para actualizar  registro en la tabla TBL_FACTURA
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Procedimiento para actualizar  registro en la tabla TBL_FACTURA
app.get("/get_facturas", (req, res) => {
    const query = "SELECT * FROM pfp_schema.get_factura()";

    pgClient.query(query, (err, result) => {
        if (!err) {
            res.status(200).json(result.rows); // Devolver el resultado en formato JSON
        } else {
            console.log(err);
            res.status(500).send(
                "Error al obtener los datos de facturas y pacientes"
            );
        }
    });
});

// Procedimiento para insertar un registro en la tabla TBL_FACTURA
app.post("/insert_factura", (req, res) => {
    console.log(req.body);
    const { factura, id_paciente, id_producto, cantidad_producto } = req.body;
    // Validación de los campos
    if (!factura || !id_paciente || !id_producto || !cantidad_producto) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (factura, id_paciente, id_producto, cantidad_producto)"
            );
    }

    // Modificamos la consulta para recibir el mensaje de salida
    const query = "CALL pfp_schema.insert_factura($1, $2, $3, $4, $5)";
    const values = [factura, id_paciente, id_producto, cantidad_producto, null];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            const mensaje =
                result.rows[0]?.mensaje || "Factura insertada exitosamente";
            res.status(201).send(mensaje);
        } else {
            console.log(err);
            res.status(500).send("Error al insertar la factura");
        }
    });
});

// Procedimiento para actualizar un registro en la tabla TBL_FACTURA
app.put("/update_factura", (req, res) => {
    const { id_factura, factura, id_paciente, id_producto, cantidad_producto } =
        req.body;

    // Validación de campos
    if (
        !id_factura ||
        !factura ||
        !id_paciente ||
        !id_producto ||
        !cantidad_producto
    ) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (id_factura, factura, id_paciente, id_producto, cantidad_producto)"
            );
    }

    const query = "CALL pfp_schema.update_factura($1, $2, $3, $4, $5)";
    const values = [
        id_factura,
        factura,
        id_paciente,
        id_producto,
        cantidad_producto,
    ];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Factura actualizada exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al actualizar la factura");
        }
    });
});

// Procedimiento para SELECCIONAR registroS en la tabla TBL_FARMACIA
app.get("/get_farmacias", (req, res) => {
    const query = "SELECT * FROM pfp_schema.get_farmacias()";

    // Ejecuta la consulta en la base de datos
    pgClient.query(query, (err, result) => {
        if (!err) {
            res.status(200).json(result.rows); // Envía los datos como JSON
        } else {
            console.error("Error al obtener detalles de farmacias:", err);
            res.status(500).send(
                "Error al obtener los datos de detalles de farmacias"
            );
        }
    });
});

// Procedimiento para insertar un registro en la tabla TBL_FARMACIA
app.post("/insert_farmacia", (req, res) => {
    const {
        rtn_farmacia,
        nombre_farmacia,
        id_sucursal,
        id_usuario,
        id_tipo_entidad,
        id_estado,
        id_contacto,
    } = req.body; // Capturamos los valores desde el cuerpo de la solicitud

    // Validamos que todos los campos requeridos estén presentes
    if (
        !rtn_farmacia ||
        !nombre_farmacia ||
        !id_sucursal ||
        !id_usuario ||
        !id_tipo_entidad ||
        !id_estado ||
        !id_contacto
    ) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (rtn_farmacia, nombre_farmacia, id_sucursal, id_usuario, id_tipo_entidad, id_estado, id_contacto)"
            );
    }

    const query = "CALL pfp_schema.insert_farmacia($1, $2, $3, $4, $5, $6, $7)"; // Llamada al procedimiento almacenado
    const values = [
        rtn_farmacia,
        nombre_farmacia,
        id_sucursal,
        id_usuario,
        id_tipo_entidad,
        id_estado,
        id_contacto,
    ]; // Valores a insertar

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(201).send("Farmacia insertada exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al insertar la farmacia");
        }
    });
});

// Procedimiento para actualizar un registro en la tabla TBL_FARMACIA
app.put("/update_farmacia", (req, res) => {
    const {
        id_farmacia,
        rtn_farmacia,
        nombre_farmacia,
        id_sucursal,
        id_usuario,
        id_tipo_entidad,
        id_estado,
        id_contacto,
    } = req.body;

    // Validación de campos
    if (
        !id_farmacia ||
        !rtn_farmacia ||
        !nombre_farmacia ||
        !id_sucursal ||
        !id_usuario ||
        !id_tipo_entidad ||
        !id_estado ||
        !id_contacto
    ) {
        return res
            .status(400)
            .send(
                "Todos los campos son requeridos (id_farmacia, rtn_farmacia, nombre_farmacia, id_sucursal, id_usuario, id_tipo_entidad, id_estado, id_contacto)"
            );
    }

    const query =
        "CALL pfp_schema.update_farmacia($1, $2, $3, $4, $5, $6, $7, $8)";
    const values = [
        id_farmacia,
        rtn_farmacia,
        nombre_farmacia,
        id_sucursal,
        id_usuario,
        id_tipo_entidad,
        id_estado,
        id_contacto,
    ];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Farmacia actualizada exitosamente");
        } else {
            console.log(err);
            res.status(500).send("Error al actualizar la farmacia");
        }
    });
});

// Endpoint para obtener todos los registros de la tabla TBL_REGISTRO
app.get("/get_registro", (req, res) => {
    const query = "SELECT * FROM pfp_schema.get_registro()"; // Llama a la función almacenada

    // Ejecuta la consulta en la base de datos
    pgClient.query(query, (err, result) => {
        if (err) {
            console.error("Error al obtener los registros:", err);
            res.status(500).send("Error al obtener los registros");
        } else {
            res.status(200).json(result.rows); // Envía los datos como JSON
        }
    });
});

// Endpoint para insertar un registro en la tabla TBL_REGISTRO
app.post("/insert_registro", (req, res) => {
    console.log("insert_registro", req.body);
    const {
        id_tipo_registro,
        id_farmacia,
        id_paciente,
        id_producto,
        cantidad,
        id_estado_canje,
        comentarios,
    } = req.body; // Datos enviados en el cuerpo de la solicitud

    const query = `CALL pfp_schema.insert_registro( $1, $2, $3, $4, $5, $6, $7 ) `; // Llama al procedimiento almacenado para insertar

    // Ejecuta la consulta en la base de datos
    pgClient.query(
        query,
        [
            id_tipo_registro,
            id_farmacia,
            id_paciente,
            id_producto,
            cantidad,
            id_estado_canje,
            comentarios,
        ],
        (err, result) => {
            if (err) {
                console.error("Error al insertar el registro:", err);
                res.status(500).send("Error al insertar el registro");
            } else {
                res.status(200).send("Registro insertado exitosamente");
            }
        }
    );
});

// Endpoint para insertar
app.post("/insert_parametro", (req, res) => {
    const { parametro, valor, id_usuario } = req.body;

    if (!parametro || !valor || !id_usuario) {
        return res.status(400).send("Todos los campos son obligatorios");
    }

    const query = "CALL pfp_schema.insert_parametro($1, $2, $3)";
    const values = [parametro, valor, id_usuario];

    pgClient.query(query, values, (err) => {
        if (!err) {
            res.status(200).send("Parámetro insertado exitosamente");
        } else {
            console.error(err);
            res.status(500).send("Error al insertar el parámetro");
        }
    });
});

// Endpoint para seleccionar
app.get("/get_parametros", (req, res) => {
    const query = "SELECT * FROM pfp_schema.get_parametro()";

    pgClient.query(query, (err, result) => {
        if (!err) {
            res.status(200).json(result.rows);
        } else {
            console.error(err);
            res.status(500).send("Error al obtener los parámetros");
        }
    });
});

// Endpoint para actualizar
app.put("/update_parametro", (req, res) => {
    const { id_parametro, parametro, valor, id_usuario } = req.body;

    if (!id_parametro || !parametro || !valor || !id_usuario) {
        return res.status(400).send("Todos los campos son obligatorios");
    }

    const query = "CALL pfp_schema.update_parametro($1, $2, $3, $4)";
    const values = [id_parametro, parametro, valor, id_usuario];

    pgClient.query(query, values, (err) => {
        if (!err) {
            res.status(200).send("Parámetro actualizado exitosamente");
        } else {
            console.error(err);
            res.status(500).send("Error al actualizar el parámetro");
        }
    });
});

// Endpoint para eliminar
app.delete("/delete_parametro", (req, res) => {
    const { id_parametro } = req.body;

    if (!id_parametro) {
        return res.status(400).send("El ID del parámetro es obligatorio");
    }

    const query = "CALL pfp_schema.delete_parametro($1)";
    const values = [id_parametro];

    pgClient.query(query, values, (err) => {
        if (!err) {
            res.status(200).send("Parámetro eliminado exitosamente");
        } else {
            console.error(err);
            if (err.message.includes("no existe")) {
                res.status(404).send(err.message);
            } else {
                res.status(500).send("Error al eliminar el parámetro");
            }
        }
    });
});

// Endpoint para insertar un nuevo objeto
app.post("/insert_objeto", (req, res) => {
    const { nombre, descripcion, id_estado } = req.body; // Capturar datos del cuerpo de la solicitud

    if (!nombre || !id_estado) {
        return res
            .status(400)
            .send("El nombre y el ID del estado son requeridos");
    }

    const query = "CALL pfp_schema.insert_objeto($1, $2, $3)"; // Llamar al procedimiento almacenado
    const values = [nombre, descripcion, id_estado];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Objeto insertado exitosamente");
        } else {
            console.error(err);
            res.status(500).send("Error al insertar el objeto");
        }
    });
});

// Endpoint para seleccionar un nuevo objeto
app.get("/get_objetos", (req, res) => {
    const query = "SELECT * FROM pfp_schema.get_objetos()"; // Llamada a la función

    pgClient.query(query, (err, result) => {
        if (!err) {
            res.status(200).json(result.rows); // Devolver los datos en formato JSON
        } else {
            console.error(err);
            res.status(500).send("Error al obtener los datos de objetos");
        }
    });
});

// Endpoint para actualizar un nuevo objeto
app.put("/update_objeto", (req, res) => {
    const { id_objeto, nombre, descripcion, id_estado } = req.body; // Capturamos los datos del cuerpo

    if (!id_objeto) {
        return res.status(400).send("El ID del objeto es obligatorio");
    }

    const query = "CALL pfp_schema.update_objeto($1, $2, $3, $4)";
    const values = [
        id_objeto,
        nombre || null,
        descripcion || null,
        id_estado || null,
    ];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Objeto actualizado exitosamente");
        } else {
            console.error(err);
            res.status(500).send("Error al actualizar el objeto");
        }
    });
});

// Endpoint para eliminar un nuevo objeto
app.delete("/delete_objeto", (req, res) => {
    const { id_objeto } = req.body; // Capturamos el ID del objeto desde el cuerpo

    if (!id_objeto) {
        return res.status(400).send("El ID del objeto es obligatorio");
    }

    const query = "CALL pfp_schema.delete_objeto($1)";
    const values = [id_objeto];

    // Ejecutar la consulta
    pgClient.query(query, values, (err, result) => {
        if (!err) {
            res.status(200).send("Objeto eliminado exitosamente");
        } else {
            console.error(err);
            if (err.message.includes("no existe")) {
                res.status(404).send(err.message);
            } else {
                res.status(500).send("Error al eliminar el objeto");
            }
        }
    });
});

// Endpoint para insertar
app.post("/insert_permiso", (req, res) => {
    const {
        id_rol,
        id_objeto,
        permiso_creacion,
        permiso_actualizacion,
        permiso_eliminacion,
        permiso_consultar,
        id_estado,
    } = req.body;

    if (
        !id_rol ||
        !id_objeto ||
        !permiso_creacion ||
        !permiso_actualizacion ||
        !permiso_eliminacion ||
        !permiso_consultar ||
        !id_estado
    ) {
        return res.status(400).send("Todos los campos son obligatorios");
    }

    const query = "CALL pfp_schema.insert_permiso($1, $2, $3, $4, $5, $6, $7)";
    const values = [
        id_rol,
        id_objeto,
        permiso_creacion,
        permiso_actualizacion,
        permiso_eliminacion,
        permiso_consultar,
        id_estado,
    ];

    pgClient.query(query, values, (err) => {
        if (!err) {
            res.status(200).send("Permiso insertado exitosamente");
        } else {
            console.error(err);
            res.status(500).send("Error al insertar el permiso");
        }
    });
});

// Endpoint para seleccionar
app.get("/get_permisos", (req, res) => {
    const query = "SELECT * FROM pfp_schema.get_permiso()";

    pgClient.query(query, (err, result) => {
        if (!err) {
            res.status(200).json(result.rows);
        } else {
            console.error(err);
            res.status(500).send("Error al obtener los permisos");
        }
    });
});

// Endpoint para actualizar
app.put("/update_permiso", (req, res) => {
    const {
        id_permiso,
        id_rol,
        id_objeto,
        permiso_creacion,
        permiso_actualizacion,
        permiso_eliminacion,
        permiso_consultar,
        id_estado,
    } = req.body;

    if (
        !id_permiso ||
        !id_rol ||
        !id_objeto ||
        !permiso_creacion ||
        !permiso_actualizacion ||
        !permiso_eliminacion ||
        !permiso_consultar ||
        !id_estado
    ) {
        return res.status(400).send("Todos los campos son obligatorios");
    }

    const query =
        "CALL pfp_schema.update_permiso($1, $2, $3, $4, $5, $6, $7, $8)";
    const values = [
        id_permiso,
        id_rol,
        id_objeto,
        permiso_creacion,
        permiso_actualizacion,
        permiso_eliminacion,
        permiso_consultar,
        id_estado,
    ];

    pgClient.query(query, values, (err) => {
        if (!err) {
            res.status(200).send("Permiso actualizado exitosamente");
        } else {
            console.error(err);
            res.status(500).send("Error al actualizar el permiso");
        }
    });
});

// Endpoint para eliminar
app.delete("/delete_permiso", (req, res) => {
    const { id_permiso } = req.body;

    if (!id_permiso) {
        return res.status(400).send("El ID del permiso es obligatorio");
    }

    const query = "CALL pfp_schema.delete_permiso($1)";
    const values = [id_permiso];

    pgClient.query(query, values, (err) => {
        if (!err) {
            res.status(200).send("Permiso eliminado exitosamente");
        } else {
            console.error(err);
            if (err.message.includes("no existe")) {
                res.status(404).send(err.message);
            } else {
                res.status(500).send("Error al eliminar el permiso");
            }
        }
    });
});
