PGDMP  +    8                }            PFP    17.0    17.0 �               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false                       1262    26277    PFP    DATABASE     {   CREATE DATABASE "PFP" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Honduras.1252';
    DROP DATABASE "PFP";
                  	   admin_pfp    false                        2615    26278 
   pfp_schema    SCHEMA        CREATE SCHEMA pfp_schema;
    DROP SCHEMA pfp_schema;
                  	   admin_pfp    false            g           1255    27025    delete_objeto(integer) 	   PROCEDURE     �  CREATE PROCEDURE pfp_schema.delete_objeto(IN p_id_objeto integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Verificar si el ID del objeto existe
    IF EXISTS (SELECT 1 FROM pfp_schema.tbl_objeto WHERE id_objeto = p_id_objeto) THEN
        -- Eliminar el objeto
        DELETE FROM pfp_schema.tbl_objeto
        WHERE id_objeto = p_id_objeto;
    ELSE
        RAISE EXCEPTION 'El objeto con ID % no existe', p_id_objeto;
    END IF;
END;
$$;
 A   DROP PROCEDURE pfp_schema.delete_objeto(IN p_id_objeto integer);
    
   pfp_schema            	   admin_pfp    false    6            m           1255    27029    delete_parametro(integer) 	   PROCEDURE     �  CREATE PROCEDURE pfp_schema.delete_parametro(IN p_id_parametro integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM pfp_schema.tbl_parametro WHERE id_parametro = p_id_parametro) THEN
        DELETE FROM pfp_schema.tbl_parametro
        WHERE id_parametro = p_id_parametro;
    ELSE
        RAISE EXCEPTION 'El parÃ¡metro con ID % no existe', p_id_parametro;
    END IF;
END;
$$;
 G   DROP PROCEDURE pfp_schema.delete_parametro(IN p_id_parametro integer);
    
   pfp_schema            	   admin_pfp    false    6            L           1255    27033    delete_permiso(integer) 	   PROCEDURE     |  CREATE PROCEDURE pfp_schema.delete_permiso(IN p_id_permiso integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM pfp_schema.tbl_permiso WHERE id_permiso = p_id_permiso) THEN
        DELETE FROM pfp_schema.tbl_permiso
        WHERE id_permiso = p_id_permiso;
    ELSE
        RAISE EXCEPTION 'El permiso con ID % no existe', p_id_permiso;
    END IF;
END;
$$;
 C   DROP PROCEDURE pfp_schema.delete_permiso(IN p_id_permiso integer);
    
   pfp_schema            	   admin_pfp    false    6            8           1255    27003    get_contactos()    FUNCTION     �  CREATE FUNCTION pfp_schema.get_contactos() RETURNS TABLE(id_contacto integer, nombre_contacto character varying, nombre_usuario text, tipo_contacto character varying, telefono_1 character varying, telefono_2 character varying, email character varying, estado character varying, fecha_creacion date, creado_por text, fecha_modificacion date, modificado_por text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        c.id_contacto,
        c.nombre_contacto,
        u.nombre_usuario,
        tc.tipo_contacto,
        c.telefono_1,
        c.telefono_2,
        c.email,
        e.estado,
        c.fecha_creacion,
        c.creado_por,
        c.fecha_modificacion,
        c.modificado_por
    FROM 
        pfp_schema.tbl_contacto AS c
    JOIN 
        pfp_schema.tbl_usuario AS u ON c.id_usuario = u.id_usuario
    JOIN 
        pfp_schema.tbl_tipo_contacto AS tc ON c.id_tipo_contacto = tc.id_tipo_contacto
    JOIN 
        pfp_schema.tbl_estado AS e ON c.id_estado = e.id_estado;
END;
$$;
 *   DROP FUNCTION pfp_schema.get_contactos();
    
   pfp_schema            	   admin_pfp    false    6            .           1255    26976    get_departamentos()    FUNCTION     �  CREATE FUNCTION pfp_schema.get_departamentos() RETURNS TABLE(id_departamento integer, nombre_zona character varying, nombre_departamento character varying, estado character varying, fecha_creacion date, creado_por text, fecha_modificacion date, modificado_por text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        d.id_departamento,
	z.zona AS nombre_zona,
        d.nombre_departamento,
        e.estado,
        d.fecha_creacion,
        d.creado_por,
        d.fecha_modificacion,
        d.modificado_por
    FROM 
        pfp_schema.tbl_departamento AS d
    JOIN 
        pfp_schema.tbl_zona AS z ON d.id_zona = z.id_zona
    JOIN 
        pfp_schema.tbl_estado AS e ON d.id_estado = e.id_estado;
END;
$$;
 .   DROP FUNCTION pfp_schema.get_departamentos();
    
   pfp_schema            	   admin_pfp    false    6                       1255    27006    get_distribuidores()    FUNCTION     �  CREATE FUNCTION pfp_schema.get_distribuidores() RETURNS TABLE(id_distribuidor integer, rtn_distribuidor character varying, nombre_distribuidor character varying, nombre_pais character varying, tipo_entidad character varying, nombre_usuario text, nombre_contacto character varying, estado character varying, fecha_creacion date, creado_por text, fecha_modificacion date, modificado_por text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        d.id_distribuidor,
        d.rtn_distribuidor,
        d.nombre_distribuidor,
        p.nombre_pais,
        te.tipo_entidad,
        u.nombre_usuario,
        c.nombre_contacto,
        e.estado,
        d.fecha_creacion,
        d.creado_por,
        d.fecha_modificacion,
        d.modificado_por
    FROM 
        pfp_schema.tbl_distribuidor AS d
    JOIN 
        pfp_schema.tbl_pais AS p ON d.id_pais = p.id_pais
    JOIN 
        pfp_schema.tbl_tipo_entidad AS te ON d.id_tipo_entidad = te.id_tipo_entidad
    JOIN 
        pfp_schema.tbl_usuario AS u ON d.id_usuario = u.id_usuario
    JOIN 
        pfp_schema.tbl_contacto AS c ON d.id_contacto = c.id_contacto
    JOIN 
        pfp_schema.tbl_estado AS e ON d.id_estado = e.id_estado;
END;
$$;
 /   DROP FUNCTION pfp_schema.get_distribuidores();
    
   pfp_schema            	   admin_pfp    false    6            [           1255    26967    get_especialidad()    FUNCTION     i  CREATE FUNCTION pfp_schema.get_especialidad() RETURNS TABLE(id_especialidad integer, nombre_especialidad character varying, estado character varying, fecha_creacion date, creado_por text, fecha_modificacion date, modificado_por text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        e.id_especialidad,
        e.nombre_especialidad,
        es.estado,
        e.fecha_creacion,
        e.creado_por,
        e.fecha_modificacion,
        e.modificado_por
    FROM 
        pfp_schema.tbl_especialidad AS e
    JOIN 
        pfp_schema.tbl_estado AS es ON e.id_estado = es.id_estado;
END;
$$;
 -   DROP FUNCTION pfp_schema.get_especialidad();
    
   pfp_schema            	   admin_pfp    false    6            y           1255    26949    get_estado_canje()    FUNCTION     �  CREATE FUNCTION pfp_schema.get_estado_canje() RETURNS TABLE(id_estado_canje integer, estado_canje character varying, fecha_creacion date, creado_por text, fecha_modificacion date, modificado_por text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        ec.ID_ESTADO_CANJE,
        ec.ESTADO_CANJE,
        ec.FECHA_CREACION,
        ec.CREADO_POR,
        ec.FECHA_MODIFICACION,
        ec.MODIFICADO_POR
    FROM 
        PFP_SCHEMA.TBL_ESTADO_CANJE ec;
END;
$$;
 -   DROP FUNCTION pfp_schema.get_estado_canje();
    
   pfp_schema            	   admin_pfp    false    6            ,           1255    26943    get_estados()    FUNCTION     t  CREATE FUNCTION pfp_schema.get_estados() RETURNS TABLE(id_estado integer, estado character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Seleccionar todos los registros de la tabla TBL_ESTADO
    RETURN QUERY
    SELECT t.id_estado, t.estado  -- AsegÃºrate de especificar el alias de la tabla
    FROM pfp_schema.tbl_estado AS t;  -- Alias para la tabla
END;
$$;
 (   DROP FUNCTION pfp_schema.get_estados();
    
   pfp_schema            	   admin_pfp    false    6            W           1255    27034    get_factura()    FUNCTION     �  CREATE FUNCTION pfp_schema.get_factura() RETURNS TABLE(id_factura integer, factura text, dni_paciente character varying, nombre_paciente character varying, apellido_paciente character varying, nombre_producto character varying, cantidad_producto integer, fecha_creacion date, creado_por text, fecha_modificacion date, modificado_por text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        f.id_factura,
        f.factura,
        p.dni_paciente,
        p.nombre_paciente,
        p.apellido_paciente,
        pr.nombre_producto,
        f.cantidad_producto,
        f.fecha_creacion,
        f.creado_por,
        f.fecha_modificacion,
        f.modificado_por
    FROM 
        pfp_schema.tbl_factura AS f
    INNER JOIN 
        pfp_schema.tbl_paciente AS p 
    ON 
        f.id_paciente = p.id_paciente
    INNER JOIN 
        pfp_schema.tbl_producto AS pr
    ON 
        f.id_producto = pr.id_producto;
END;
$$;
 (   DROP FUNCTION pfp_schema.get_factura();
    
   pfp_schema            	   admin_pfp    false    6            G           1255    27017    get_farmacias()    FUNCTION     �  CREATE FUNCTION pfp_schema.get_farmacias() RETURNS TABLE(id_farmacia integer, rtn_farmacia character varying, nombre_farmacia character varying, nombre_sucursal character varying, nombre_usuario text, tipo_entidad character varying, estado character varying, nombre_contacto character varying, fecha_creacion date, creado_por text, fecha_modificacion date, modificado_por text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        f.ID_FARMACIA,
        f.RTN_FARMACIA,
        f.NOMBRE_FARMACIA,
        s.NOMBRE_SUCURSAL,
        u.NOMBRE_USUARIO,
        t.TIPO_ENTIDAD,
        e.ESTADO,
        c.NOMBRE_CONTACTO,
    	f.FECHA_CREACION,
        f.CREADO_POR,
        f.FECHA_MODIFICACION,
        f.MODIFICADO_POR
    FROM 
        PFP_SCHEMA.TBL_FARMACIA f
    JOIN 
        PFP_SCHEMA.TBL_SUCURSAL s ON f.ID_SUCURSAL = s.ID_SUCURSAL
    JOIN 
        PFP_SCHEMA.TBL_USUARIO u ON f.ID_USUARIO = u.ID_USUARIO
    JOIN 
        PFP_SCHEMA.TBL_TIPO_ENTIDAD t ON f.ID_TIPO_ENTIDAD = t.ID_TIPO_ENTIDAD
    JOIN 
        PFP_SCHEMA.TBL_ESTADO e ON f.ID_ESTADO = e.ID_ESTADO
    JOIN 
        PFP_SCHEMA.TBL_CONTACTO c ON f.ID_CONTACTO = c.ID_CONTACTO;
END;
$$;
 *   DROP FUNCTION pfp_schema.get_farmacias();
    
   pfp_schema            	   admin_pfp    false    6            6           1255    26970    get_forma_farmaceutica()    FUNCTION     |  CREATE FUNCTION pfp_schema.get_forma_farmaceutica() RETURNS TABLE(id_forma_farmaceutica integer, forma_farmaceutica character varying, estado character varying, fecha_creacion date, creado_por text, fecha_modificacion date, modificado_por text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        f.id_forma_farmaceutica,
        f.forma_farmaceutica,
        e.estado,
        f.fecha_creacion,
        f.creado_por,
        f.fecha_modificacion,
        f.modificado_por
    FROM 
        pfp_schema.tbl_forma_farmaceutica AS f
    JOIN 
        pfp_schema.tbl_estado AS e ON f.id_estado = e.id_estado;
END;
$$;
 3   DROP FUNCTION pfp_schema.get_forma_farmaceutica();
    
   pfp_schema            	   admin_pfp    false    6            \           1255    27009    get_laboratorios()    FUNCTION     �  CREATE FUNCTION pfp_schema.get_laboratorios() RETURNS TABLE(id_laboratorio integer, rtn_laboratorio character varying, nombre_laboratorio character varying, nombre_pais character varying, tipo_entidad character varying, nombre_usuario text, nombre_contacto character varying, estado character varying, fecha_creacion date, creado_por text, fecha_modificacion date, modificado_por text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        l.id_laboratorio,
        l.rtn_laboratorio,
        l.nombre_laboratorio,
        p.nombre_pais,
        te.tipo_entidad,
        u.nombre_usuario,
        c.nombre_contacto,
        e.estado,
        l.fecha_creacion,
        l.creado_por,
        l.fecha_modificacion,
        l.modificado_por
    FROM 
        pfp_schema.tbl_laboratorio AS l
    JOIN 
        pfp_schema.tbl_pais AS p ON l.id_pais = p.id_pais
    JOIN 
        pfp_schema.tbl_tipo_entidad AS te ON l.id_tipo_entidad = te.id_tipo_entidad
    JOIN 
        pfp_schema.tbl_usuario AS u ON l.id_usuario = u.id_usuario
    JOIN 
        pfp_schema.tbl_contacto AS c ON l.id_contacto = c.id_contacto
    JOIN 
        pfp_schema.tbl_estado AS e ON l.id_estado = e.id_estado;
END;
$$;
 -   DROP FUNCTION pfp_schema.get_laboratorios();
    
   pfp_schema            	   admin_pfp    false    6            4           1255    26991    get_lote_producto()    FUNCTION     .  CREATE FUNCTION pfp_schema.get_lote_producto() RETURNS TABLE(id_lote_producto integer, lote_producto character varying, nombre_producto character varying, fecha_vencimiento date, estado character varying, fecha_creacion date, creado_por text, fecha_modificacion date, modificado_por text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        lp.id_lote_producto,
        lp.lote_producto,
        p.nombre_producto,
        lp.fecha_vencimiento,
        es.estado,
        lp.fecha_creacion,
        lp.creado_por,
        lp.fecha_modificacion,
        lp.modificado_por
    FROM 
        pfp_schema.tbl_lote_producto AS lp
    JOIN 
        pfp_schema.tbl_producto AS p ON lp.id_producto = p.id_producto
    JOIN 
        pfp_schema.tbl_estado AS es ON lp.id_estado = es.id_estado;
END;
$$;
 .   DROP FUNCTION pfp_schema.get_lote_producto();
    
   pfp_schema            	   admin_pfp    false    6            ?           1255    26985    get_marca_producto()    FUNCTION     l  CREATE FUNCTION pfp_schema.get_marca_producto() RETURNS TABLE(id_marca_producto integer, marca_producto character varying, estado character varying, fecha_creacion date, creado_por text, fecha_modificacion date, modificado_por text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        mp.id_marca_producto,
        mp.marca_producto,
        e.estado,
        mp.fecha_creacion,
        mp.creado_por,
        mp.fecha_modificacion,
        mp.modificado_por
    FROM 
        pfp_schema.tbl_marca_producto AS mp
    JOIN 
        pfp_schema.tbl_estado AS e ON mp.id_estado = e.id_estado;
END;
$$;
 /   DROP FUNCTION pfp_schema.get_marca_producto();
    
   pfp_schema            	   admin_pfp    false    6            V           1255    26979    get_municipios()    FUNCTION       CREATE FUNCTION pfp_schema.get_municipios() RETURNS TABLE(id_municipio integer, nombre_departamento character varying, nombre_municipio character varying, estado character varying, fecha_creacion date, creado_por text, fecha_modificacion date, modificado_por text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        m.id_municipio,
		d.nombre_departamento AS nombre_departamento,
        m.municipio ,
        e.estado,
        m.fecha_creacion,
        m.creado_por,
        m.fecha_modificacion,
        m.modificado_por
    FROM 
        pfp_schema.tbl_municipio AS m
    JOIN 
        pfp_schema.tbl_departamento AS d ON m.id_departamento = d.id_departamento
    JOIN 
        pfp_schema.tbl_estado AS e ON m.id_estado = e.id_estado;
END;
$$;
 +   DROP FUNCTION pfp_schema.get_municipios();
    
   pfp_schema            	   admin_pfp    false    6            T           1255    27039    get_objetos()    FUNCTION     �  CREATE FUNCTION pfp_schema.get_objetos() RETURNS TABLE(id_objeto integer, nombre_objeto text, descripcion text, estado_objeto character varying, fecha_creacion timestamp without time zone, creado_por text, fecha_modificacion timestamp without time zone, modificado_por text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        o.id_objeto,
        o.nombre AS nombre_objeto,
        o.descripcion,
        e.estado AS estado_objeto,
        o.fecha_creacion,
        o.creado_por,
        o.fecha_modificacion,
        o.modificado_por
    FROM 
        pfp_schema.tbl_objeto AS o
    LEFT JOIN 
        pfp_schema.tbl_estado AS e
    ON 
        o.id_estado = e.id_estado;
END;
$$;
 (   DROP FUNCTION pfp_schema.get_objetos();
    
   pfp_schema            	   admin_pfp    false    6                       1255    27012    get_pacientes()    FUNCTION     a  CREATE FUNCTION pfp_schema.get_pacientes() RETURNS TABLE(id_paciente integer, dni_paciente character varying, nombre_paciente character varying, apellido_paciente character varying, fecha_nacimiento date, email character varying, direccion character varying, celular character varying, tratamiento_medico character varying, nombre_usuario text, estado character varying, fecha_creacion date, creado_por text, fecha_modificacion date, modificado_por text, genero character)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.ID_PACIENTE,
        p.DNI_PACIENTE,
        p.NOMBRE_PACIENTE,
        p.APELLIDO_PACIENTE,
        p.FECHA_NACIMIENTO,
        p.EMAIL,
        p.DIRECCION,
        p.CELULAR,
        p.TRATAMIENTO_MEDICO,
        u.NOMBRE_USUARIO,
        e.ESTADO,
        p.FECHA_CREACION,
        p.CREADO_POR,
        p.FECHA_MODIFICACION,
        p.MODIFICADO_POR,
        p.GENERO
    FROM 
        PFP_SCHEMA.TBL_PACIENTE p
    JOIN 
        PFP_SCHEMA.TBL_USUARIO u ON p.ID_USUARIO = u.ID_USUARIO
    JOIN 
        PFP_SCHEMA.TBL_ESTADO e ON p.ID_ESTADO = e.ID_ESTADO;
END;
$$;
 *   DROP FUNCTION pfp_schema.get_pacientes();
    
   pfp_schema            	   admin_pfp    false    6                       1255    26946    get_paises()    FUNCTION     2  CREATE FUNCTION pfp_schema.get_paises() RETURNS TABLE(id_pais integer, nombre_pais character varying, estado character varying, fecha_creacion date, creado_por text, fecha_modificacion date, modificado_por text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.ID_PAIS,
        p.NOMBRE_PAIS,
        e.ESTADO,
        p.FECHA_CREACION,
        p.CREADO_POR,
        p.FECHA_MODIFICACION,
        p.MODIFICADO_POR
    FROM 
        PFP_SCHEMA.TBL_PAIS p
    JOIN 
        PFP_SCHEMA.TBL_ESTADO e ON p.ID_ESTADO = e.ID_ESTADO;
END;
$$;
 '   DROP FUNCTION pfp_schema.get_paises();
    
   pfp_schema            	   admin_pfp    false    6            |           1255    27027    get_parametro()    FUNCTION     b  CREATE FUNCTION pfp_schema.get_parametro() RETURNS TABLE(id_parametro integer, parametro text, valor text, nombre_usuario text, fecha_creacion date, creado_por text, fecha_modificacion date, modificado_por text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.id_parametro,
        p.parametro,
        p.valor,
        u.nombre_usuario,
        p.fecha_creacion,
        p.creado_por,
        p.fecha_modificacion,
        p.modificado_por
    FROM 
        pfp_schema.tbl_parametro AS p
    INNER JOIN 
        pfp_schema.tbl_usuario AS u ON p.id_usuario = u.id_usuario;
END;
$$;
 *   DROP FUNCTION pfp_schema.get_parametro();
    
   pfp_schema            	   admin_pfp    false    6            A           1255    27037    get_permiso()    FUNCTION     �  CREATE FUNCTION pfp_schema.get_permiso() RETURNS TABLE(id_permiso integer, rol character varying, objeto text, permiso_creacion text, permiso_actualizacion text, permiso_eliminacion text, permiso_consultar text, estado character varying, fecha_creacion date, creado_por text, fecha_modificacion date, modificado_por text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.id_permiso,
        r.rol,
        o.nombre AS objeto,
        p.permiso_creacion,
        p.permiso_actualizacion,
        p.permiso_eliminacion,
        p.permiso_consultar,
        e.estado,
        p.fecha_creacion,
        p.creado_por,
        p.fecha_modificacion,
        p.modificado_por
    FROM 
        pfp_schema.tbl_permiso AS p
    INNER JOIN 
        pfp_schema.tbl_rol AS r ON p.id_rol = r.id_rol
    INNER JOIN 
        pfp_schema.tbl_objeto AS o ON p.id_objeto = o.id_objeto
    INNER JOIN 
        pfp_schema.tbl_estado AS e ON p.id_estado = e.id_estado;
END;
$$;
 (   DROP FUNCTION pfp_schema.get_permiso();
    
   pfp_schema            	   admin_pfp    false    6            _           1255    26994    get_preguntas()    FUNCTION       CREATE FUNCTION pfp_schema.get_preguntas() RETURNS TABLE(id_pregunta integer, pregunta text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.id_pregunta,
        p.pregunta
    FROM 
        pfp_schema.tbl_preguntas AS p;
END;
$$;
 *   DROP FUNCTION pfp_schema.get_preguntas();
    
   pfp_schema            	   admin_pfp    false    6            z           1255    26988    get_producto()    FUNCTION     #  CREATE FUNCTION pfp_schema.get_producto() RETURNS TABLE(id_producto integer, codigo_barra character varying, nombre_producto character varying, forma_farmaceutica character varying, especialidad character varying, marca_producto character varying, unidad_medida character varying, via_administracion character varying, estado character varying, nombre_laboratorio character varying, escala integer, canje integer, contenido_neto integer, consumo_diario integer, consumo_max_anual integer, canjes_max_anual integer, fecha_creacion date, creado_por text, fecha_modificacion date, modificado_por text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        p.id_producto,
        p.codigo_barra,
        p.nombre_producto,
        ff.forma_farmaceutica,
        e.nombre_especialidad,
        mp.marca_producto,
        um.unidad_medida,
        va.via_administracion,
        es.estado,
        l.nombre_laboratorio,
        p.escala,
        p.canje,
        p.contenido_neto,
        p.consumo_diario,
        p.consumo_max_anual,
        p.canjes_max_anual,
        p.fecha_creacion,
        p.creado_por,
        p.fecha_modificacion,
        p.modificado_por
    FROM
        pfp_schema.tbl_producto p
    JOIN pfp_schema.tbl_forma_farmaceutica ff ON p.id_forma_farmaceutica = ff.id_forma_farmaceutica
    JOIN pfp_schema.tbl_especialidad e ON p.id_especialidad = e.id_especialidad
    JOIN pfp_schema.tbl_marca_producto mp ON p.id_marca_producto = mp.id_marca_producto
    JOIN pfp_schema.tbl_unidad_medida um ON p.id_unidad_medida = um.id_unidad_medida
    JOIN pfp_schema.tbl_via_administracion va ON p.id_via_administracion = va.id_via_administracion
    JOIN pfp_schema.tbl_estado es ON p.id_estado = es.id_estado
    JOIN pfp_schema.tbl_laboratorio l ON p.id_laboratorio = l.id_laboratorio;
END;
$$;
 )   DROP FUNCTION pfp_schema.get_producto();
    
   pfp_schema            	   admin_pfp    false    6            @           1255    27020    get_registro()    FUNCTION     �  CREATE FUNCTION pfp_schema.get_registro() RETURNS TABLE(id_registro integer, fecha_registro timestamp without time zone, tipo_registro character varying, rtn_farmacia character varying, nombre_farmacia character varying, dni_paciente character varying, nombre_paciente character varying, apellido_paciente character varying, nombre_producto character varying, cantidad integer, estado_canje character varying, comentarios character varying, fecha_creacion date, creado_por text, fecha_modificacion date, modificado_por text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        r.id_registro,
        r.fecha_registro,
        tr.tipo_registro,
        f.rtn_farmacia,
        f.nombre_farmacia,
        p.dni_paciente,
        p.nombre_paciente,
        p.apellido_paciente,
        pr.nombre_producto,
        r.cantidad,
        ec.estado_canje,
        r.comentarios,
        r.fecha_creacion,
        r.creado_por,
        r.fecha_modificacion,
        r.modificado_por
    FROM 
        pfp_schema.tbl_registro AS r
    INNER JOIN 
        pfp_schema.tbl_tipo_registro AS tr ON r.id_tipo_registro = tr.id_tipo_registro
    INNER JOIN 
        pfp_schema.tbl_farmacia AS f ON r.id_farmacia = f.id_farmacia
    INNER JOIN 
        pfp_schema.tbl_paciente AS p ON r.id_paciente = p.id_paciente
    INNER JOIN 
        pfp_schema.tbl_producto AS pr ON r.id_producto = pr.id_producto
    INNER JOIN 
        pfp_schema.tbl_estado_canje AS ec ON r.id_estado_canje = ec.id_estado_canje;
END;
$$;
 )   DROP FUNCTION pfp_schema.get_registro();
    
   pfp_schema            	   admin_pfp    false    6            R           1255    26961    get_roles()    FUNCTION     �  CREATE FUNCTION pfp_schema.get_roles() RETURNS TABLE(id_rol integer, rol character varying, descripcion character varying, fecha_creacion date, creado_por text, fecha_modificacion date, modificado_por text, id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Seleccionar todos los registros de la tabla TBL_ROL
    RETURN QUERY
    SELECT 
        r.id_rol, 
        r.rol, 
        r.descripcion, 
        r.fecha_creacion, 
        r.creado_por, 
        r.fecha_modificacion, 
        r.modificado_por, 
        r.id_estado  -- AsegÃºrate de especificar el alias de la tabla
    FROM pfp_schema.tbl_rol AS r;  -- Alias para la tabla TBL_ROL
END;
$$;
 &   DROP FUNCTION pfp_schema.get_roles();
    
   pfp_schema            	   admin_pfp    false    6            M           1255    26997    get_sucursales()    FUNCTION     �  CREATE FUNCTION pfp_schema.get_sucursales() RETURNS TABLE(id_sucursal integer, municipio character varying, nombre_sucursal character varying, estado character varying, fecha_creacion date, creado_por text, fecha_modificacion date, modificado_por text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        s.id_sucursal,
		m.municipio,
        s.nombre_sucursal,
        e.estado,
        s.fecha_creacion,
        s.creado_por,
        s.fecha_modificacion,
        s.modificado_por
    FROM 
        pfp_schema.tbl_sucursal AS s
    JOIN 
        pfp_schema.tbl_municipio AS m ON s.id_municipio = m.id_municipio
    JOIN 
        pfp_schema.tbl_estado AS e ON s.id_estado = e.id_estado;
END;
$$;
 +   DROP FUNCTION pfp_schema.get_sucursales();
    
   pfp_schema            	   admin_pfp    false    6            1           1255    26982    get_tipo_contacto()    FUNCTION     f  CREATE FUNCTION pfp_schema.get_tipo_contacto() RETURNS TABLE(id_tipo_contacto integer, tipo_contacto character varying, estado character varying, fecha_creacion date, creado_por text, fecha_modificacion date, modificado_por text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        tc.id_tipo_contacto,
        tc.tipo_contacto,
        e.estado,
        tc.fecha_creacion,
        tc.creado_por,
        tc.fecha_modificacion,
        tc.modificado_por
    FROM 
        pfp_schema.tbl_tipo_contacto AS tc
    JOIN 
        pfp_schema.tbl_estado AS e ON tc.id_estado = e.id_estado;
END;
$$;
 .   DROP FUNCTION pfp_schema.get_tipo_contacto();
    
   pfp_schema            	   admin_pfp    false    6            h           1255    26952    get_tipo_entidad()    FUNCTION     Z  CREATE FUNCTION pfp_schema.get_tipo_entidad() RETURNS TABLE(id_tipo_entidad integer, tipo_entidad character varying, estado character varying, fecha_creacion date, creado_por text, fecha_modificacion date, modificado_por text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        te.ID_TIPO_ENTIDAD,
        te.TIPO_ENTIDAD,
        e.ESTADO,
        te.FECHA_CREACION,
        te.CREADO_POR,
        te.FECHA_MODIFICACION,
        te.MODIFICADO_POR
    FROM 
        PFP_SCHEMA.TBL_TIPO_ENTIDAD te
    JOIN 
        PFP_SCHEMA.TBL_ESTADO e ON te.ID_ESTADO = e.ID_ESTADO;
END;
$$;
 -   DROP FUNCTION pfp_schema.get_tipo_entidad();
    
   pfp_schema            	   admin_pfp    false    6            o           1255    26955    get_tipo_registro()    FUNCTION     |  CREATE FUNCTION pfp_schema.get_tipo_registro() RETURNS TABLE(id_tipo_registro integer, tipo_registro character varying, fecha_creacion date, creado_por text, fecha_modificacion date, modificado_por text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Seleccionar todos los registros de la tabla TBL_TIPO_REGISTRO
    RETURN QUERY
    SELECT 
        t.id_tipo_registro, 
        t.tipo_registro, 
        t.fecha_creacion, 
        t.creado_por, 
        t.fecha_modificacion, 
        t.modificado_por  -- Campos de la tabla TBL_TIPO_REGISTRO
    FROM pfp_schema.tbl_tipo_registro AS t;  -- Alias para la tabla TBL_TIPO_REGISTRO
END;
$$;
 .   DROP FUNCTION pfp_schema.get_tipo_registro();
    
   pfp_schema            	   admin_pfp    false    6            f           1255    26958    get_unidad_medida()    FUNCTION     `  CREATE FUNCTION pfp_schema.get_unidad_medida() RETURNS TABLE(id_unidad_medida integer, unidad_medida character varying, estado character varying, fecha_creacion date, creado_por text, fecha_modificacion date, modificado_por text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        um.ID_UNIDAD_MEDIDA,
        um.UNIDAD_MEDIDA,
        e.ESTADO,
        um.FECHA_CREACION,
        um.CREADO_POR,
        um.FECHA_MODIFICACION,
        um.MODIFICADO_POR
    FROM 
        PFP_SCHEMA.TBL_UNIDAD_MEDIDA um
    JOIN 
        PFP_SCHEMA.TBL_ESTADO e ON um.ID_ESTADO = e.ID_ESTADO;
END;
$$;
 .   DROP FUNCTION pfp_schema.get_unidad_medida();
    
   pfp_schema            	   admin_pfp    false    6                        1255    27000    get_usuarios()    FUNCTION     �  CREATE FUNCTION pfp_schema.get_usuarios() RETURNS TABLE(id_usuario integer, usuario text, nombre_usuario text, contrasena text, rol character varying, fecha_ultima_conexion date, fecha_vencimiento date, email character varying, primer_ingreso integer, estado character varying, fecha_creacion date, creado_por text, fecha_modificacion date, modificado_por text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        u.id_usuario,
        u.usuario,
        u.nombre_usuario,
        u.contrasena,
        r.rol,
        u.fecha_ultima_conexion,
        u.fecha_vencimiento,
        u.email,
        u.primer_ingreso,
        e.estado,
        u.fecha_creacion,
        u.creado_por,
        u.fecha_modificacion,
        u.modificado_por
    FROM 
        pfp_schema.tbl_usuario AS u
    JOIN 
        pfp_schema.tbl_rol AS r ON u.id_rol = r.id_rol
    JOIN 
        pfp_schema.tbl_estado AS e ON u.id_estado = e.id_estado;
END;
$$;
 )   DROP FUNCTION pfp_schema.get_usuarios();
    
   pfp_schema            	   admin_pfp    false    6            F           1255    26964    get_via_administracion()    FUNCTION     ~  CREATE FUNCTION pfp_schema.get_via_administracion() RETURNS TABLE(id_via_administracion integer, via_administracion character varying, estado character varying, fecha_creacion date, creado_por text, fecha_modificacion date, modificado_por text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        va.ID_VIA_ADMINISTRACION,
        va.VIA_ADMINISTRACION,
        e.ESTADO,
        va.FECHA_CREACION,
        va.CREADO_POR,
        va.FECHA_MODIFICACION,
        va.MODIFICADO_POR
    FROM 
        PFP_SCHEMA.TBL_VIA_ADMINISTRACION va
    JOIN 
        PFP_SCHEMA.TBL_ESTADO e ON va.ID_ESTADO = e.ID_ESTADO;
END;
$$;
 3   DROP FUNCTION pfp_schema.get_via_administracion();
    
   pfp_schema            	   admin_pfp    false    6            U           1255    26973    get_zonas()    FUNCTION     �  CREATE FUNCTION pfp_schema.get_zonas() RETURNS TABLE(id_zona integer, nombre_pais character varying, zona character varying, estado character varying, fecha_creacion date, creado_por text, fecha_modificacion date, modificado_por text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        z.ID_ZONA,
        p.NOMBRE_PAIS,
        z.ZONA,
        e.ESTADO,
        z.FECHA_CREACION,
        z.CREADO_POR,
        z.FECHA_MODIFICACION,
        z.MODIFICADO_POR
    FROM 
        PFP_SCHEMA.TBL_ZONA z
    JOIN 
        PFP_SCHEMA.TBL_PAIS p ON z.ID_PAIS = p.ID_PAIS
    JOIN 
        PFP_SCHEMA.TBL_ESTADO e ON z.ID_ESTADO = e.ID_ESTADO;
END;
$$;
 &   DROP FUNCTION pfp_schema.get_zonas();
    
   pfp_schema            	   admin_pfp    false    6            K           1255    27004 v   insert_contacto(character varying, integer, integer, character varying, character varying, character varying, integer) 	   PROCEDURE     g  CREATE PROCEDURE pfp_schema.insert_contacto(IN p_nombre_contacto character varying, IN p_id_usuario integer, IN p_id_tipo_contacto integer, IN p_telefono_1 character varying, IN p_telefono_2 character varying, IN p_email character varying, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insertar en la tabla TBL_CONTACTO
    INSERT INTO pfp_schema.tbl_contacto (
        nombre_contacto,
        id_usuario,
        id_tipo_contacto,
        telefono_1,
        telefono_2,
        email,
        id_estado,
        fecha_creacion,                -- FECHA_CREACION con valor por defecto
        creado_por,
        fecha_modificacion,
        modificado_por
    ) VALUES (
        p_nombre_contacto,
        p_id_usuario,
        p_id_tipo_contacto,
        p_telefono_1,
        p_telefono_2,
        p_email,
        p_id_estado,
        CURRENT_DATE,                  -- FECHA_CREACION establecida a la fecha actual
        'ADMINISTRADOR',               -- CREADO_POR
        CURRENT_DATE,                  -- FECHA_MODIFICACION
        'SIN MODIFICAR'                -- MODIFICADO_POR
    );
END;
$$;
   DROP PROCEDURE pfp_schema.insert_contacto(IN p_nombre_contacto character varying, IN p_id_usuario integer, IN p_id_tipo_contacto integer, IN p_telefono_1 character varying, IN p_telefono_2 character varying, IN p_email character varying, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            D           1255    26977 8   insert_departamento(integer, character varying, integer) 	   PROCEDURE     H  CREATE PROCEDURE pfp_schema.insert_departamento(IN p_id_zona integer, IN p_nombre_departamento character varying, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insertar en la tabla TBL_DEPARTAMENTO con fecha de creación actual y creado por 'ADMINISTRADOR'
    INSERT INTO pfp_schema.tbl_departamento (id_zona, nombre_departamento, fecha_creacion, creado_por, fecha_modificacion, id_estado, modificado_por)
    VALUES (
        p_id_zona,  -- ID de la zona
        p_nombre_departamento,  -- Nombre del departamento
        CURRENT_DATE,  -- Fecha de creación actual
        'ADMINISTRADOR',  -- Creador por defecto
        CURRENT_DATE,  -- Fecha de modificación igual a la de creación
        p_id_estado,  -- ID del estado
        'SIN MODIFICAR'  -- Inicialmente modificado por igual al creador
    );
END;
$$;
 �   DROP PROCEDURE pfp_schema.insert_departamento(IN p_id_zona integer, IN p_nombre_departamento character varying, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            w           1255    27007 f   insert_distribuidor(character varying, character varying, integer, integer, integer, integer, integer) 	   PROCEDURE     y  CREATE PROCEDURE pfp_schema.insert_distribuidor(IN p_rtn_distribuidor character varying, IN p_nombre_distribuidor character varying, IN p_id_pais integer, IN p_id_tipo_entidad integer, IN p_id_usuario integer, IN p_id_contacto integer, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insertar en la tabla TBL_DISTRIBUIDOR
    INSERT INTO pfp_schema.tbl_distribuidor (
        rtn_distribuidor,
        nombre_distribuidor,
        id_pais,
        id_tipo_entidad,
        id_usuario,
        id_contacto,
        id_estado,
        fecha_creacion,              -- FECHA_CREACION con valor por defecto
        creado_por,
        fecha_modificacion,
        modificado_por
    ) VALUES (
        p_rtn_distribuidor,
        p_nombre_distribuidor,
        p_id_pais,
        p_id_tipo_entidad,
        p_id_usuario,
        p_id_contacto,
        p_id_estado,
        CURRENT_DATE,                -- FECHA_CREACION establecida a la fecha actual
        'ADMINISTRADOR',             -- CREADO_POR
        CURRENT_DATE,                -- FECHA_MODIFICACION
        'SIN MODIFICAR'              -- MODIFICADO_POR
    );
END;
$$;
   DROP PROCEDURE pfp_schema.insert_distribuidor(IN p_rtn_distribuidor character varying, IN p_nombre_distribuidor character varying, IN p_id_pais integer, IN p_id_tipo_entidad integer, IN p_id_usuario integer, IN p_id_contacto integer, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            a           1255    26968 /   insert_especialidad(character varying, integer) 	   PROCEDURE     �  CREATE PROCEDURE pfp_schema.insert_especialidad(IN p_nombre_especialidad character varying, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insertar en la tabla TBL_ESPECIALIDAD
    INSERT INTO pfp_schema.tbl_especialidad (
        nombre_especialidad,
        id_estado,
        fecha_creacion,
        creado_por,
        fecha_modificacion,
        modificado_por
    ) VALUES (
        p_nombre_especialidad,
        p_id_estado,
        CURRENT_DATE,  -- Fecha de creación actual
        'ADMINISTRADOR',  -- Establece "Administrador" como el creador por defecto
        CURRENT_DATE,  -- Inicialmente fecha de modificación igual a la de creación
        'SIN MODIFICAR'  -- Inicialmente el modificado por igual al creador
    );
END;
$$;
 s   DROP PROCEDURE pfp_schema.insert_especialidad(IN p_nombre_especialidad character varying, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            #           1255    26944     insert_estado(character varying) 	   PROCEDURE     �   CREATE PROCEDURE pfp_schema.insert_estado(IN p_estado character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insertar un nuevo estado en la tabla TBL_ESTADO
    INSERT INTO pfp_schema.tbl_estado (estado)
    VALUES (p_estado);
END;
$$;
 H   DROP PROCEDURE pfp_schema.insert_estado(IN p_estado character varying);
    
   pfp_schema            	   admin_pfp    false    6            2           1255    26950 &   insert_estado_canje(character varying) 	   PROCEDURE     �  CREATE PROCEDURE pfp_schema.insert_estado_canje(IN estado_canje character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insertar en la tabla TBL_ESTADO_CANJE con fecha de creación actual y creado por 'Administrador'
    INSERT INTO pfp_schema.tbl_estado_canje (estado_canje, fecha_creacion, creado_por, fecha_modificacion, modificado_por)
    VALUES (
        estado_canje, 
        CURRENT_DATE,  -- Fecha de creación actual (automática)
        'ADMINISTRADOR',  -- Establece "Administrador" como el creador por defecto
        CURRENT_DATE,  -- Inicialmente fecha de modificación igual a la de creación
        'SIN MODIFICAR'  -- Inicialmente el modificado por igual al creador
    );
END;
$$;
 R   DROP PROCEDURE pfp_schema.insert_estado_canje(IN estado_canje character varying);
    
   pfp_schema            	   admin_pfp    false    6            v           1255    27811 <   insert_factura(character varying, integer, integer, integer) 	   PROCEDURE     H  CREATE PROCEDURE pfp_schema.insert_factura(IN p_factura character varying, IN p_id_paciente integer, IN p_id_producto integer, IN p_cantidad_producto integer, OUT mensaje character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE
    escala_actual INT;
    contador INT;
BEGIN
    -- Insertar en la tabla TBL_FACTURA
    INSERT INTO pfp_schema.tbl_factura (
        factura,
        id_paciente,
        id_producto,
        cantidad_producto,
        fecha_creacion,
        creado_por,
        fecha_modificacion,
        modificado_por
    ) VALUES (
        p_factura,
        p_id_paciente,
        p_id_producto,
        p_cantidad_producto,
        CURRENT_DATE,
        'ADMINISTRADOR',
        CURRENT_DATE,
        'SIN MODIFICAR'
    );

    -- Obtener el valor de ESCALA para el producto actual
    SELECT escala INTO escala_actual
    FROM pfp_schema.tbl_producto
    WHERE id_producto = p_id_producto;

    -- Contar el número de facturas para el paciente y producto actual
    SELECT COUNT(*) INTO contador
    FROM pfp_schema.tbl_factura
    WHERE id_paciente = p_id_paciente
      AND id_producto = p_id_producto;

    -- Si el número de facturas es igual al valor de ESCALA
    IF contador = escala_actual THEN
        mensaje := 'Listo para canje';
    ELSE
        mensaje := 'Factura insertada exitosamente';
    END IF;
END;
$$;
 �   DROP PROCEDURE pfp_schema.insert_factura(IN p_factura character varying, IN p_id_paciente integer, IN p_id_producto integer, IN p_cantidad_producto integer, OUT mensaje character varying);
    
   pfp_schema            	   admin_pfp    false    6            (           1255    27018 b   insert_farmacia(character varying, character varying, integer, integer, integer, integer, integer) 	   PROCEDURE     O  CREATE PROCEDURE pfp_schema.insert_farmacia(IN p_rtn_farmacia character varying, IN p_nombre_farmacia character varying, IN p_id_sucursal integer, IN p_id_usuario integer, IN p_id_tipo_entidad integer, IN p_id_estado integer, IN p_id_contacto integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insertar en la tabla TBL_FARMACIA
    INSERT INTO pfp_schema.tbl_farmacia (
        rtn_farmacia,
        nombre_farmacia,
        id_sucursal,
        id_usuario,
        id_tipo_entidad,
        id_estado,
        id_contacto,
        fecha_creacion,
        creado_por,
        fecha_modificacion,
        modificado_por
    ) VALUES (
        p_rtn_farmacia,
        p_nombre_farmacia,
        p_id_sucursal,
        p_id_usuario,
        p_id_tipo_entidad,
        p_id_estado,
        p_id_contacto,
        CURRENT_DATE,      -- FECHA_CREACION: Fecha actual
        'ADMINISTRADOR',   -- CREADO_POR: Usuario que crea el registro
        CURRENT_DATE,      -- FECHA_MODIFICACION: Fecha actual como inicial
        'SIN MODIFICAR'    -- MODIFICADO_POR: Estado inicial sin modificación
    );
END;
$$;
 �   DROP PROCEDURE pfp_schema.insert_farmacia(IN p_rtn_farmacia character varying, IN p_nombre_farmacia character varying, IN p_id_sucursal integer, IN p_id_usuario integer, IN p_id_tipo_entidad integer, IN p_id_estado integer, IN p_id_contacto integer);
    
   pfp_schema            	   admin_pfp    false    6                       1255    26971 5   insert_forma_farmaceutica(character varying, integer) 	   PROCEDURE     �  CREATE PROCEDURE pfp_schema.insert_forma_farmaceutica(IN p_forma_farmaceutica character varying, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insertar en la tabla TBL_FORMA_FARMACEUTICA con fecha de creación actual y creado por 'ADMINISTRADOR'
    INSERT INTO pfp_schema.tbl_forma_farmaceutica (
        forma_farmaceutica, id_estado, fecha_creacion, creado_por, fecha_modificacion, modificado_por
    ) VALUES (
        p_forma_farmaceutica,
        p_id_estado,
        CURRENT_DATE,  -- Fecha de creación actual
        'ADMINISTRADOR',  -- Valor por defecto para creado_por
        CURRENT_DATE,  -- Fecha de modificación inicial igual a la de creación
        'SIN MODIFICAR'  -- Valor por defecto para modificado_por
    );
END;
$$;
 x   DROP PROCEDURE pfp_schema.insert_forma_farmaceutica(IN p_forma_farmaceutica character varying, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            X           1255    27010 e   insert_laboratorio(character varying, character varying, integer, integer, integer, integer, integer) 	   PROCEDURE     R  CREATE PROCEDURE pfp_schema.insert_laboratorio(IN p_rtn_laboratorio character varying, IN p_nombre_laboratorio character varying, IN p_id_pais integer, IN p_id_tipo_entidad integer, IN p_id_usuario integer, IN p_id_contacto integer, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insertar en la tabla TBL_LABORATORIO
    INSERT INTO pfp_schema.tbl_laboratorio (
        rtn_laboratorio,
        nombre_laboratorio,
        id_pais,
        id_tipo_entidad,
		id_usuario,
		id_contacto,
        id_estado,
        fecha_creacion,
        creado_por,
        fecha_modificacion,
        modificado_por
    ) VALUES (
        p_rtn_laboratorio,
        p_nombre_laboratorio,
        p_id_pais,
        p_id_tipo_entidad,
		p_id_usuario,
		p_id_contacto,
        p_id_estado,
        CURRENT_DATE,      -- FECHA_CREACION: Fecha actual
        'ADMINISTRADOR',        -- CREADO_POR: Usuario que crea el registro
        CURRENT_DATE,      -- FECHA_MODIFICACION: Fecha actual como inicial
        'SIN MODIFICAR'     -- MODIFICADO_POR: Usuario que realiza la modificaciÃ³n
    );
END;
$$;
    DROP PROCEDURE pfp_schema.insert_laboratorio(IN p_rtn_laboratorio character varying, IN p_nombre_laboratorio character varying, IN p_id_pais integer, IN p_id_tipo_entidad integer, IN p_id_usuario integer, IN p_id_contacto integer, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            i           1255    26992 ?   insert_lote_producto(character varying, integer, date, integer) 	   PROCEDURE     �  CREATE PROCEDURE pfp_schema.insert_lote_producto(IN p_lote_producto character varying, IN p_id_producto integer, IN p_fecha_vencimiento date, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insertar en la tabla TBL_LOTE_PRODUCTO con fecha de creación actual y creado por 'ADMINISTRADOR'
    INSERT INTO pfp_schema.tbl_lote_producto (
        lote_producto, id_producto, fecha_vencimiento, id_estado, fecha_creacion, creado_por, fecha_modificacion, modificado_por
    ) VALUES (
        p_lote_producto,
        p_id_producto,
        p_fecha_vencimiento,
        p_id_estado,
        CURRENT_DATE,           -- Fecha de creación actual
        'ADMINISTRADOR',        -- Valor por defecto para creado_por
        CURRENT_DATE,           -- Fecha de modificación inicial igual a la de creación
        'SIN MODIFICAR'         -- Valor por defecto para modificado_por
    );
END;
$$;
 �   DROP PROCEDURE pfp_schema.insert_lote_producto(IN p_lote_producto character varying, IN p_id_producto integer, IN p_fecha_vencimiento date, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            <           1255    26986 1   insert_marca_producto(character varying, integer) 	   PROCEDURE     �  CREATE PROCEDURE pfp_schema.insert_marca_producto(IN p_marca_producto character varying, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insertar en la tabla TBL_MARCA_PRODUCTO con fecha de creación actual y creado por 'ADMINISTRADOR'
    INSERT INTO pfp_schema.tbl_marca_producto (
        marca_producto, id_estado, fecha_creacion, creado_por, fecha_modificacion, modificado_por
    ) VALUES (
        p_marca_producto,
        p_id_estado,
        CURRENT_DATE,         -- Fecha de creación actual
        'ADMINISTRADOR',      -- Valor por defecto para creado_por
        CURRENT_DATE,         -- Fecha de modificación inicial igual a la de creación
        'SIN MODIFICAR'       -- Valor por defecto para modificado_por
    );
END;
$$;
 p   DROP PROCEDURE pfp_schema.insert_marca_producto(IN p_marca_producto character varying, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            +           1255    26980 5   insert_municipio(integer, character varying, integer) 	   PROCEDURE     N  CREATE PROCEDURE pfp_schema.insert_municipio(IN p_id_departamento integer, IN p_municipio character varying, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insertar en la tabla TBL_MUNICIPIO con fecha de creación actual y creado por 'ADMINISTRADOR'
    INSERT INTO pfp_schema.tbl_municipio (
        id_departamento,
        municipio,
        id_estado,
        fecha_creacion,
        creado_por,
        fecha_modificacion,
        modificado_por
    )
    VALUES (
        p_id_departamento,
        p_municipio,
        p_id_estado,
        CURRENT_DATE,         -- Fecha de creación actual
        'ADMINISTRADOR',      -- Creador por defecto
        CURRENT_DATE,         -- Fecha de modificación igual a la de creación
        'SIN MODIFICAR'       -- Inicialmente modificado por igual al creador
    );
END;
$$;
 �   DROP PROCEDURE pfp_schema.insert_municipio(IN p_id_departamento integer, IN p_municipio character varying, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            %           1255    27022 /   insert_objeto(character varying, text, integer) 	   PROCEDURE     �  CREATE PROCEDURE pfp_schema.insert_objeto(IN p_nombre character varying, IN p_descripcion text, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insertar en la tabla TBL_OBJETO con fecha de creaciÃ³n actual y los valores proporcionados
    INSERT INTO pfp_schema.tbl_objeto (
        nombre, 
        descripcion, 
        id_estado, 
        fecha_creacion, 
        creado_por, 
        fecha_modificacion, 
        modificado_por
    )
    VALUES (
        p_nombre, 
        p_descripcion, 
        p_id_estado, 
        CURRENT_DATE,               
        'ADMINISTRACION',     
        CURRENT_DATE,               
        'SIN MODIFICAR'        
    );
END;
$$;
 w   DROP PROCEDURE pfp_schema.insert_objeto(IN p_nombre character varying, IN p_descripcion text, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            }           1255    27013 �   insert_paciente(character varying, character varying, character varying, date, character varying, character varying, character varying, character varying, integer, integer, character) 	   PROCEDURE     �  CREATE PROCEDURE pfp_schema.insert_paciente(IN p_dni_paciente character varying, IN p_nombre_paciente character varying, IN p_apellido_paciente character varying, IN p_fecha_nacimiento date, IN p_email character varying, IN p_direccion character varying, IN p_celular character varying, IN p_tratamiento_medico character varying, IN p_id_usuario integer, IN p_id_estado integer, IN p_genero character)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insertar en la tabla TBL_PACIENTE
    INSERT INTO pfp_schema.tbl_paciente (
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
        fecha_creacion,
        creado_por,
        fecha_modificacion,
        modificado_por,
        genero
    ) VALUES (
        p_dni_paciente,
        p_nombre_paciente,
        p_apellido_paciente,
        p_fecha_nacimiento,
        p_email,
        p_direccion,
        p_celular,
        p_tratamiento_medico,
        p_id_usuario,
        p_id_estado,
        CURRENT_DATE,      -- FECHA_CREACION: Fecha actual
        'ADMINISTRADOR',   -- CREADO_POR: Usuario que crea el registro
        CURRENT_DATE,      -- FECHA_MODIFICACION: Fecha actual como inicial
        'SIN MODIFICAR',   -- MODIFICADO_POR: Usuario que realiza la modificaciÃ³n
        p_genero           -- GÃ©nero del paciente
    );
END;
$$;
 �  DROP PROCEDURE pfp_schema.insert_paciente(IN p_dni_paciente character varying, IN p_nombre_paciente character varying, IN p_apellido_paciente character varying, IN p_fecha_nacimiento date, IN p_email character varying, IN p_direccion character varying, IN p_celular character varying, IN p_tratamiento_medico character varying, IN p_id_usuario integer, IN p_id_estado integer, IN p_genero character);
    
   pfp_schema            	   admin_pfp    false    6            Y           1255    26947 '   insert_pais(character varying, integer) 	   PROCEDURE     �  CREATE PROCEDURE pfp_schema.insert_pais(IN nombre_pais character varying, IN id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insertar en la tabla TBL_PAIS con fecha de creación actual y creado por 'Administrador'
    INSERT INTO pfp_schema.tbl_pais (nombre_pais, id_estado, fecha_creacion, creado_por, fecha_modificacion, modificado_por)
    VALUES (
        nombre_pais, 
        id_estado, 
        CURRENT_DATE, -- La fecha actual del sistema
        'Administrador', -- Establece "Administrador" como el creador por defecto
        CURRENT_DATE,  -- Proporcionar una fecha por defecto (mismo valor que la fecha de creación)
        'Sin modificar' -- Proporcionar un valor por defecto para el campo modificado por
    );
END;
$$;
 _   DROP PROCEDURE pfp_schema.insert_pais(IN nombre_pais character varying, IN id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            !           1255    27026 %   insert_parametro(text, text, integer) 	   PROCEDURE       CREATE PROCEDURE pfp_schema.insert_parametro(IN p_parametro text, IN p_valor text, IN p_id_usuario integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO pfp_schema.tbl_parametro (
        parametro, 
        valor, 
        id_usuario, 
        fecha_creacion, 
        creado_por, 
        fecha_modificacion, 
        modificado_por
    )
    VALUES (
        p_parametro, 
        p_valor, 
        p_id_usuario, 
        CURRENT_DATE, 
        'ADMINISTRADOR', 
        CURRENT_DATE, 
        'SIN MODIFICAR'
    );
END;
$$;
 k   DROP PROCEDURE pfp_schema.insert_parametro(IN p_parametro text, IN p_valor text, IN p_id_usuario integer);
    
   pfp_schema            	   admin_pfp    false    6            $           1255    27030 A   insert_permiso(integer, integer, text, text, text, text, integer) 	   PROCEDURE     r  CREATE PROCEDURE pfp_schema.insert_permiso(IN p_id_rol integer, IN p_id_objeto integer, IN p_permiso_creacion text, IN p_permiso_actualizacion text, IN p_permiso_eliminacion text, IN p_permiso_consultar text, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO pfp_schema.tbl_permiso (
        id_rol,
        id_objeto,
        permiso_creacion,
        permiso_actualizacion,
        permiso_eliminacion,
        permiso_consultar,
        id_estado,
        fecha_creacion,
        creado_por,
        fecha_modificacion,
        modificado_por
    )
    VALUES (
        p_id_rol,
        p_id_objeto,
        p_permiso_creacion,
        p_permiso_actualizacion,
        p_permiso_eliminacion,
        p_permiso_consultar,
        p_id_estado,
        CURRENT_DATE,
        'ADMINISTRADOR',
        CURRENT_DATE,
        'SIN MODIFICAR'
    );
END;
$$;
 �   DROP PROCEDURE pfp_schema.insert_permiso(IN p_id_rol integer, IN p_id_objeto integer, IN p_permiso_creacion text, IN p_permiso_actualizacion text, IN p_permiso_eliminacion text, IN p_permiso_consultar text, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            d           1255    26995    insert_pregunta(text) 	   PROCEDURE     �   CREATE PROCEDURE pfp_schema.insert_pregunta(IN p_pregunta text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insertar en la tabla TBL_PREGUNTAS
    INSERT INTO pfp_schema.tbl_preguntas (
        pregunta
    ) VALUES (
        p_pregunta
    );
END;
$$;
 ?   DROP PROCEDURE pfp_schema.insert_pregunta(IN p_pregunta text);
    
   pfp_schema            	   admin_pfp    false    6                       1255    26989 �   insert_producto(character varying, character varying, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer) 	   PROCEDURE     2  CREATE PROCEDURE pfp_schema.insert_producto(IN p_codigo_barra character varying, IN p_nombre_producto character varying, IN p_id_forma_farmaceutica integer, IN p_id_especialidad integer, IN p_id_marca_producto integer, IN p_id_unidad_medida integer, IN p_id_via_administracion integer, IN p_id_estado integer, IN p_id_laboratorio integer, IN p_escala integer, IN p_canje integer, IN p_contenido_neto integer, IN p_consumo_diario integer, IN p_consumo_max_anual integer, IN p_canjes_max_anual integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insertar en la tabla TBL_PRODUCTO con valores específicos para fechas y creado/modificado por
    INSERT INTO pfp_schema.tbl_producto (
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
        fecha_creacion,
        creado_por,
        fecha_modificacion,
        modificado_por
    ) VALUES (
        p_codigo_barra,
        p_nombre_producto,
        p_id_forma_farmaceutica,
        p_id_especialidad,
        p_id_marca_producto,
        p_id_unidad_medida,
        p_id_via_administracion,
        p_id_estado,
        p_id_laboratorio,
        p_escala,
        p_canje,
        p_contenido_neto,
        p_consumo_diario,
        p_consumo_max_anual,
        p_canjes_max_anual,
        CURRENT_DATE,       -- Fecha de creación actual
        'ADMINISTRADOR',     -- Valor por defecto para creado_por
        CURRENT_DATE,        -- Fecha de modificación inicial igual a la de creación
        'SIN MODIFICAR'      -- Valor por defecto para modificado_por
    );
END;
$$;
 �  DROP PROCEDURE pfp_schema.insert_producto(IN p_codigo_barra character varying, IN p_nombre_producto character varying, IN p_id_forma_farmaceutica integer, IN p_id_especialidad integer, IN p_id_marca_producto integer, IN p_id_unidad_medida integer, IN p_id_via_administracion integer, IN p_id_estado integer, IN p_id_laboratorio integer, IN p_escala integer, IN p_canje integer, IN p_contenido_neto integer, IN p_consumo_diario integer, IN p_consumo_max_anual integer, IN p_canjes_max_anual integer);
    
   pfp_schema            	   admin_pfp    false    6            E           1255    27021 X   insert_registro(integer, integer, integer, integer, integer, integer, character varying) 	   PROCEDURE     E  CREATE PROCEDURE pfp_schema.insert_registro(IN p_id_tipo_registro integer, IN p_id_farmacia integer, IN p_id_paciente integer, IN p_id_producto integer, IN p_cantidad integer, IN p_id_estado_canje integer, IN p_comentarios character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insertar en la tabla TBL_REGISTRO
    INSERT INTO pfp_schema.tbl_registro (
        id_tipo_registro,
        id_farmacia,
        id_paciente,
        id_producto,
        cantidad,
        id_estado_canje,
        comentarios,
        fecha_creacion,
        creado_por,
        fecha_modificacion,
        modificado_por
    ) VALUES (
        p_id_tipo_registro,
        p_id_farmacia,
        p_id_paciente,
        p_id_producto,
        p_cantidad,
        p_id_estado_canje,
        p_comentarios,
        CURRENT_DATE,      -- FECHA_CREACION: Fecha actual
        'ADMINISTRADOR',   -- CREADO_POR: Usuario que crea el registro
        CURRENT_DATE,      -- FECHA_MODIFICACION: Fecha actual como inicial
        'SIN MODIFICAR'    -- MODIFICADO_POR: Estado inicial sin modificación
    );
END;
$$;
 �   DROP PROCEDURE pfp_schema.insert_registro(IN p_id_tipo_registro integer, IN p_id_farmacia integer, IN p_id_paciente integer, IN p_id_producto integer, IN p_cantidad integer, IN p_id_estado_canje integer, IN p_comentarios character varying);
    
   pfp_schema            	   admin_pfp    false    6            u           1255    26962 9   insert_rol(character varying, character varying, integer) 	   PROCEDURE     x  CREATE PROCEDURE pfp_schema.insert_rol(IN p_rol character varying, IN p_descripcion character varying, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insertar en la tabla TBL_ROL con fecha de creaciÃ³n actual y creado por 'Administrador'
    INSERT INTO pfp_schema.tbl_rol (
        rol, 
        descripcion,
        id_estado,
        fecha_creacion, 
        creado_por, 
        fecha_modificacion, 
        modificado_por
    )
    VALUES (
        p_rol, 
        p_descripcion, 
        p_id_estado,  -- ID de estado proporcionado
        CURRENT_DATE,  -- Fecha de creaciÃ³n actual
        'ADMINISTRADOR',  -- Establecer 'Administrador' como el creador por defecto
        CURRENT_DATE,  -- Inicialmente fecha de modificaciÃ³n igual a la de creaciÃ³n
        'SIN MODIFICAR'  -- Inicialmente el modificado por serÃ¡ 'SIN MODIFICAR'
    );
END;
$$;
 ~   DROP PROCEDURE pfp_schema.insert_rol(IN p_rol character varying, IN p_descripcion character varying, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            0           1255    26998 4   insert_sucursal(integer, character varying, integer) 	   PROCEDURE     e  CREATE PROCEDURE pfp_schema.insert_sucursal(IN p_id_municipio integer, IN p_nombre_sucursal character varying, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insertar en la tabla TBL_SUCURSAL
    INSERT INTO pfp_schema.tbl_sucursal (
        id_municipio,
        nombre_sucursal,
        id_estado,
        fecha_creacion,
        creado_por,
        fecha_modificacion,
        modificado_por
    ) VALUES (
        p_id_municipio,
        p_nombre_sucursal,
        p_id_estado,
        CURRENT_DATE,
         'AMINISTRADOR', 
        CURRENT_DATE,
        'SIN MODIFICAR'
    );
END;
$$;
 �   DROP PROCEDURE pfp_schema.insert_sucursal(IN p_id_municipio integer, IN p_nombre_sucursal character varying, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            ~           1255    26983 0   insert_tipo_contacto(character varying, integer) 	   PROCEDURE     �  CREATE PROCEDURE pfp_schema.insert_tipo_contacto(IN p_tipo_contacto character varying, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insertar en la tabla TBL_TIPO_CONTACTO con fecha de creación actual y creado por 'ADMINISTRADOR'
    INSERT INTO pfp_schema.tbl_tipo_contacto (
        tipo_contacto, id_estado, fecha_creacion, creado_por, fecha_modificacion, modificado_por
    ) VALUES (
        p_tipo_contacto,
        p_id_estado,
        CURRENT_DATE,          -- Fecha de creación actual
        'ADMINISTRADOR',       -- Valor por defecto para creado_por
        CURRENT_DATE,          -- Fecha de modificación inicial igual a la de creación
        'SIN MODIFICAR'        -- Valor por defecto para modificado_por
    );
END;
$$;
 n   DROP PROCEDURE pfp_schema.insert_tipo_contacto(IN p_tipo_contacto character varying, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            r           1255    26953 /   insert_tipo_entidad(character varying, integer) 	   PROCEDURE     �  CREATE PROCEDURE pfp_schema.insert_tipo_entidad(IN tipo_entidad character varying, IN id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insertar en la tabla TBL_TIPO_ENTIDAD con fecha de creación actual y creado por 'Administrador'
    INSERT INTO pfp_schema.tbl_tipo_entidad (tipo_entidad, id_estado, fecha_creacion, creado_por, fecha_modificacion, modificado_por)
    VALUES (
        tipo_entidad, 
        id_estado, 
        CURRENT_DATE,  -- Fecha de creación actual (automática)
        'ADMINISTRADOR',  -- Establece "Administrador" como el creador por defecto
        CURRENT_DATE,  -- Inicialmente fecha de modificación igual a la de creación
        'SIN MODIFICAR'  -- Inicialmente el modificado por igual al creador
    );
END;
$$;
 h   DROP PROCEDURE pfp_schema.insert_tipo_entidad(IN tipo_entidad character varying, IN id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            j           1255    26956 '   insert_tipo_registro(character varying) 	   PROCEDURE     �  CREATE PROCEDURE pfp_schema.insert_tipo_registro(IN p_tipo_registro character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insertar en la tabla TBL_TIPO_REGISTRO con fecha de creación y modificado por defecto
    INSERT INTO pfp_schema.tbl_tipo_registro (
        tipo_registro, 
        fecha_creacion, 
        creado_por, 
        fecha_modificacion, 
        modificado_por
    )
    VALUES (
        p_tipo_registro, 
        CURRENT_DATE,  -- Fecha de creación actual
        'ADMINISTRADOR',  -- Creador por defecto
        CURRENT_DATE,  -- Fecha de modificación actual
        'SIN MODIFICAR'  -- Valor por defecto para modificado por
    );
END;
$$;
 V   DROP PROCEDURE pfp_schema.insert_tipo_registro(IN p_tipo_registro character varying);
    
   pfp_schema            	   admin_pfp    false    6            ;           1255    26959 0   insert_unidad_medida(character varying, integer) 	   PROCEDURE     <  CREATE PROCEDURE pfp_schema.insert_unidad_medida(IN p_unidad_medida character varying, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insertar en la tabla TBL_UNIDAD_MEDIDA con fecha de creación actual y creado por 'Administrador'
    INSERT INTO pfp_schema.tbl_unidad_medida (
        unidad_medida, 
        id_estado, 
        fecha_creacion, 
        creado_por, 
        fecha_modificacion, 
        modificado_por
    )
    VALUES (
        p_unidad_medida, 
        p_id_estado, 
        CURRENT_DATE,  -- Fecha de creación actual
        'ADMINISTRADOR',  -- Establecer 'Administrador' como el creador por defecto
        CURRENT_DATE,  -- Inicialmente fecha de modificación igual a la de creación
        'SIN MODIFICAR'  -- Inicialmente el modificado por será 'SIN MODIFICAR'
    );
END;
$$;
 n   DROP PROCEDURE pfp_schema.insert_unidad_medida(IN p_unidad_medida character varying, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            )           1255    27001 N   insert_usuario(text, text, text, integer, character varying, integer, integer) 	   PROCEDURE     `  CREATE PROCEDURE pfp_schema.insert_usuario(IN p_usuario text, IN p_nombre_usuario text, IN p_contrasena text, IN p_id_rol integer, IN p_email character varying, IN p_primer_ingreso integer, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insertar en la tabla TBL_USUARIO
    INSERT INTO pfp_schema.tbl_usuario (
        usuario,
        nombre_usuario,
        contrasena,
        id_rol,
        fecha_ultima_conexion,
        fecha_vencimiento,
        email,
        primer_ingreso,
        id_estado,
        creado_por,
        fecha_modificacion,
        modificado_por
    ) VALUES (
        p_usuario,
        p_nombre_usuario,
        p_contrasena,
        p_id_rol,
        CURRENT_DATE,                    -- FECHA_ULTIMA_CONEXION inicial
        CURRENT_DATE + INTERVAL '1 year', -- FECHA_VENCIMIENTO un año desde la fecha actual
        p_email,
        p_primer_ingreso,
        p_id_estado,
        'ADMINISTRADOR',                 -- CREADO_POR
        CURRENT_DATE,                    -- FECHA_MODIFICACION
        'SIN MODIFICAR'                  -- MODIFICADO_POR
    );
END;
$$;
 �   DROP PROCEDURE pfp_schema.insert_usuario(IN p_usuario text, IN p_nombre_usuario text, IN p_contrasena text, IN p_id_rol integer, IN p_email character varying, IN p_primer_ingreso integer, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            q           1255    26965 5   insert_via_administracion(character varying, integer) 	   PROCEDURE     Z  CREATE PROCEDURE pfp_schema.insert_via_administracion(IN p_via_administracion character varying, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insertar en la tabla TBL_VIA_ADMINISTRACION con fecha de creación actual y creado por 'Administrador'
    INSERT INTO pfp_schema.tbl_via_administracion (
        via_administracion, 
        id_estado, 
        fecha_creacion, 
        creado_por, 
        fecha_modificacion, 
        modificado_por
    )
    VALUES (
        p_via_administracion, 
        p_id_estado, 
        CURRENT_DATE,  -- Fecha de creación actual
        'ADMINISTRADOR',  -- Establecer 'Administrador' como el creador por defecto
        CURRENT_DATE,  -- Inicialmente fecha de modificación igual a la de creación
        'SIN MODIFICAR'  -- Inicialmente el modificado por será 'SIN MODIFICAR'
    );
END;
$$;
 x   DROP PROCEDURE pfp_schema.insert_via_administracion(IN p_via_administracion character varying, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            '           1255    26974 0   insert_zona(integer, character varying, integer) 	   PROCEDURE       CREATE PROCEDURE pfp_schema.insert_zona(IN p_id_pais integer, IN p_zona character varying, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insertar en la tabla TBL_ZONA con fecha de creación actual y creado por 'ADMINISTRADOR'
    INSERT INTO pfp_schema.tbl_zona (id_pais, zona, fecha_creacion, creado_por, fecha_modificacion, modificado_por, id_estado)
    VALUES (
        p_id_pais,
        p_zona,
        CURRENT_DATE,  -- Fecha de creación actual (automática)
        'ADMINISTRADOR',  -- Establece "ADMINISTRADOR" como el creador por defecto
        CURRENT_DATE,  -- Inicialmente fecha de modificación igual a la de creación
        'SIN MODIFICAR',  -- Inicialmente el modificado por igual al creador
        p_id_estado
    );
END;
$$;
 r   DROP PROCEDURE pfp_schema.insert_zona(IN p_id_pais integer, IN p_zona character varying, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            s           1255    27005    update_contacto(integer, character varying, integer, integer, character varying, character varying, character varying, integer) 	   PROCEDURE     �  CREATE PROCEDURE pfp_schema.update_contacto(IN p_id_contacto integer, IN p_nombre_contacto character varying, IN p_id_usuario integer, IN p_id_tipo_contacto integer, IN p_telefono_1 character varying, IN p_telefono_2 character varying, IN p_email character varying, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Actualizar en la tabla TBL_CONTACTO
    UPDATE pfp_schema.tbl_contacto
    SET 
        nombre_contacto = p_nombre_contacto,
        id_usuario = p_id_usuario,
        id_tipo_contacto = p_id_tipo_contacto,
        telefono_1 = p_telefono_1,
        telefono_2 = p_telefono_2,
        email = p_email,
        id_estado = p_id_estado,
        fecha_modificacion = CURRENT_DATE,  -- Actualizamos la fecha de modificaciÃ³n
        modificado_por = 'ADMINISTRADOR'     -- Valor por defecto para quien modifica
    WHERE id_contacto = p_id_contacto;     -- Filtrar por el ID del contacto
END;
$$;
 !  DROP PROCEDURE pfp_schema.update_contacto(IN p_id_contacto integer, IN p_nombre_contacto character varying, IN p_id_usuario integer, IN p_id_tipo_contacto integer, IN p_telefono_1 character varying, IN p_telefono_2 character varying, IN p_email character varying, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            "           1255    26978 A   update_departamento(integer, integer, character varying, integer) 	   PROCEDURE     �  CREATE PROCEDURE pfp_schema.update_departamento(IN p_id_zona integer, IN p_id_departamento integer, IN p_nombre_departamento character varying, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Actualizar el registro correspondiente en la tabla TBL_DEPARTAMENTO
    UPDATE pfp_schema.tbl_departamento
    SET 
        id_zona = p_id_zona,  -- ID de la zona
        nombre_departamento = p_nombre_departamento,  -- Nombre del departamento
        id_estado = p_id_estado,  -- ID del estado
        fecha_modificacion = CURRENT_DATE,  -- Fecha de modificación actual
        modificado_por = 'ADMINISTRADOR'  -- Modificado por defecto
    WHERE 
        id_departamento = p_id_departamento;  -- Filtrar por ID del departamento

    -- Verificar si se actualizó alguna fila
    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontró el departamento con ID %', p_id_departamento;
    END IF;
END;
$$;
 �   DROP PROCEDURE pfp_schema.update_departamento(IN p_id_zona integer, IN p_id_departamento integer, IN p_nombre_departamento character varying, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            =           1255    27008 o   update_distribuidor(integer, character varying, character varying, integer, integer, integer, integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE pfp_schema.update_distribuidor(IN p_id_distribuidor integer, IN p_rtn_distribuidor character varying, IN p_nombre_distribuidor character varying, IN p_id_pais integer, IN p_id_tipo_entidad integer, IN p_id_usuario integer, IN p_id_contacto integer, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Actualizar en la tabla TBL_DISTRIBUIDOR
    UPDATE pfp_schema.tbl_distribuidor
    SET 
        rtn_distribuidor = p_rtn_distribuidor,
        nombre_distribuidor = p_nombre_distribuidor,
        id_pais = p_id_pais,
        id_tipo_entidad = p_id_tipo_entidad,
        id_usuario = p_id_usuario,
        id_contacto = p_id_contacto,
        id_estado = p_id_estado,
        fecha_modificacion = CURRENT_DATE,  -- Actualizamos la fecha de modificaciÃ³n
        modificado_por = 'ADMINISTRADOR'    -- Valor por defecto para quien modifica
    WHERE id_distribuidor = p_id_distribuidor;  -- Filtrar por el ID del distribuidor
END;
$$;
 !  DROP PROCEDURE pfp_schema.update_distribuidor(IN p_id_distribuidor integer, IN p_rtn_distribuidor character varying, IN p_nombre_distribuidor character varying, IN p_id_pais integer, IN p_id_tipo_entidad integer, IN p_id_usuario integer, IN p_id_contacto integer, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            x           1255    26969 8   update_especialidad(integer, character varying, integer) 	   PROCEDURE       CREATE PROCEDURE pfp_schema.update_especialidad(IN p_id_especialidad integer, IN p_nombre_especialidad character varying, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Actualizar el registro correspondiente en la tabla TBL_ESPECIALIDAD
    UPDATE pfp_schema.tbl_especialidad
    SET 
        nombre_especialidad = p_nombre_especialidad,
        id_estado = p_id_estado,
        fecha_modificacion = CURRENT_DATE,  -- Establecer la fecha de modificación actual
        modificado_por = 'ADMINISTRADOR'  -- Valor por defecto
    WHERE 
        id_especialidad = p_id_especialidad;  -- Filtrar por ID

    -- Verificar si se actualizó alguna fila
    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontró la especialidad con ID %', p_id_especialidad;
    END IF;
END;
$$;
 �   DROP PROCEDURE pfp_schema.update_especialidad(IN p_id_especialidad integer, IN p_nombre_especialidad character varying, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            5           1255    26945 )   update_estado(integer, character varying) 	   PROCEDURE     	  CREATE PROCEDURE pfp_schema.update_estado(IN p_id_estado integer, IN p_estado character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Actualizar el campo estado en la tabla TBL_ESTADO donde el id_estado sea igual al parÃ¡metro
    UPDATE pfp_schema.tbl_estado
    SET estado = p_estado
    WHERE id_estado = p_id_estado;

    -- Verificar si se actualizÃ³ algÃºn registro
    IF NOT FOUND THEN
        RAISE NOTICE 'No se encontrÃ³ ningÃºn registro con el id_estado %', p_id_estado;
    END IF;
END;
$$;
 `   DROP PROCEDURE pfp_schema.update_estado(IN p_id_estado integer, IN p_estado character varying);
    
   pfp_schema            	   admin_pfp    false    6            I           1255    26951 /   update_estado_canje(integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE pfp_schema.update_estado_canje(IN p_id_estado_canje integer, IN p_estado_canje character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Actualizar el registro correspondiente en la tabla TBL_ESTADO_CANJE
    UPDATE pfp_schema.tbl_estado_canje
    SET 
        estado_canje = p_estado_canje,
        fecha_modificacion = CURRENT_DATE,  -- Establecer la fecha de modificación actual
        modificado_por = 'ADMINISTRADOR'  -- Valor por defecto
    WHERE 
        id_estado_canje = p_id_estado_canje;  -- Filtrar por ID

    -- Verificar si se actualizó alguna fila
    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontró el estado de canje con ID %', p_id_estado_canje;
    END IF;
END;
$$;
 r   DROP PROCEDURE pfp_schema.update_estado_canje(IN p_id_estado_canje integer, IN p_estado_canje character varying);
    
   pfp_schema            	   admin_pfp    false    6            e           1255    27019 k   update_farmacia(integer, character varying, character varying, integer, integer, integer, integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE pfp_schema.update_farmacia(IN p_id_farmacia integer, IN p_rtn_farmacia character varying, IN p_nombre_farmacia character varying, IN p_id_sucursal integer, IN p_id_usuario integer, IN p_id_tipo_entidad integer, IN p_id_estado integer, IN p_id_contacto integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Actualizar en la tabla TBL_FARMACIA
    UPDATE pfp_schema.tbl_farmacia
    SET 
        rtn_farmacia = p_rtn_farmacia,
        nombre_farmacia = p_nombre_farmacia,
        id_sucursal = p_id_sucursal,
        id_usuario = p_id_usuario,
        id_tipo_entidad = p_id_tipo_entidad,
        id_estado = p_id_estado,
        id_contacto = p_id_contacto,
        fecha_modificacion = CURRENT_DATE,  -- Actualizamos la fecha de modificación
        modificado_por = 'ADMINISTRADOR'    -- Valor por defecto para quien modifica
    WHERE id_farmacia = p_id_farmacia;      -- Filtrar por el ID de la farmacia
END;
$$;
   DROP PROCEDURE pfp_schema.update_farmacia(IN p_id_farmacia integer, IN p_rtn_farmacia character varying, IN p_nombre_farmacia character varying, IN p_id_sucursal integer, IN p_id_usuario integer, IN p_id_tipo_entidad integer, IN p_id_estado integer, IN p_id_contacto integer);
    
   pfp_schema            	   admin_pfp    false    6            l           1255    26972 >   update_forma_farmaceutica(integer, character varying, integer) 	   PROCEDURE     L  CREATE PROCEDURE pfp_schema.update_forma_farmaceutica(IN p_id_forma_farmaceutica integer, IN p_forma_farmaceutica character varying, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Actualizar el registro correspondiente en la tabla TBL_FORMA_FARMACEUTICA
    UPDATE pfp_schema.tbl_forma_farmaceutica
    SET 
        forma_farmaceutica = p_forma_farmaceutica,
        id_estado = p_id_estado,
        fecha_modificacion = CURRENT_DATE,  -- Establecer la fecha de modificación actual
        modificado_por = 'ADMINISTRADOR'  -- Valor por defecto
    WHERE 
        id_forma_farmaceutica = p_id_forma_farmaceutica;  -- Filtrar por ID

    -- Verificar si se actualizó alguna fila
    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontró la forma farmacéutica con ID %', p_id_forma_farmaceutica;
    END IF;
END;
$$;
 �   DROP PROCEDURE pfp_schema.update_forma_farmaceutica(IN p_id_forma_farmaceutica integer, IN p_forma_farmaceutica character varying, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            k           1255    27011 n   update_laboratorio(integer, character varying, character varying, integer, integer, integer, integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE pfp_schema.update_laboratorio(IN p_id_laboratorio integer, IN p_rtn_laboratorio character varying, IN p_nombre_laboratorio character varying, IN p_id_pais integer, IN p_id_tipo_entidad integer, IN p_id_usuario integer, IN p_id_contacto integer, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Actualizar en la tabla TBL_LABORATORIO
    UPDATE pfp_schema.tbl_laboratorio
    SET 
        rtn_laboratorio = p_rtn_laboratorio,
        nombre_laboratorio = p_nombre_laboratorio,
        id_pais = p_id_pais,
        id_tipo_entidad = p_id_tipo_entidad,
        id_usuario = p_id_usuario,
        id_contacto = p_id_contacto,
        id_estado = p_id_estado,
        fecha_modificacion = CURRENT_DATE,  -- Actualizamos la fecha de modificaciÃ³n
        modificado_por = 'ADMINISTRADOR'    -- Valor por defecto para quien modifica
    WHERE id_laboratorio = p_id_laboratorio;  -- Filtrar por el ID del laboratorio
END;
$$;
   DROP PROCEDURE pfp_schema.update_laboratorio(IN p_id_laboratorio integer, IN p_rtn_laboratorio character varying, IN p_nombre_laboratorio character varying, IN p_id_pais integer, IN p_id_tipo_entidad integer, IN p_id_usuario integer, IN p_id_contacto integer, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            O           1255    26993 H   update_lote_producto(integer, character varying, integer, date, integer) 	   PROCEDURE     �  CREATE PROCEDURE pfp_schema.update_lote_producto(IN p_id_lote_producto integer, IN p_lote_producto character varying, IN p_id_producto integer, IN p_fecha_vencimiento date, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Actualizar el registro correspondiente en la tabla TBL_LOTE_PRODUCTO
    UPDATE pfp_schema.tbl_lote_producto
    SET 
        lote_producto = p_lote_producto,
        id_producto = p_id_producto,
        fecha_vencimiento = p_fecha_vencimiento,
        id_estado = p_id_estado,
        fecha_modificacion = CURRENT_DATE,  -- Establecer la fecha de modificación actual
        modificado_por = 'ADMINISTRADOR'  -- Valor por defecto para modificado_por
    WHERE 
        id_lote_producto = p_id_lote_producto;  -- Filtrar por ID

    -- Verificar si se actualizó alguna fila
    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontró el lote de producto con ID %', p_id_lote_producto;
    END IF;
END;
$$;
 �   DROP PROCEDURE pfp_schema.update_lote_producto(IN p_id_lote_producto integer, IN p_lote_producto character varying, IN p_id_producto integer, IN p_fecha_vencimiento date, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            3           1255    26987 :   update_marca_producto(integer, character varying, integer) 	   PROCEDURE     $  CREATE PROCEDURE pfp_schema.update_marca_producto(IN p_id_marca_producto integer, IN p_marca_producto character varying, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Actualizar el registro correspondiente en la tabla TBL_MARCA_PRODUCTO
    UPDATE pfp_schema.tbl_marca_producto
    SET 
        marca_producto = p_marca_producto,
        id_estado = p_id_estado,
        fecha_modificacion = CURRENT_DATE,  -- Establecer la fecha de modificación actual
        modificado_por = 'ADMINISTRADOR'    -- Valor por defecto
    WHERE 
        id_marca_producto = p_id_marca_producto;  -- Filtrar por ID

    -- Verificar si se actualizó alguna fila
    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontró la marca de producto con ID %', p_id_marca_producto;
    END IF;
END;
$$;
 �   DROP PROCEDURE pfp_schema.update_marca_producto(IN p_id_marca_producto integer, IN p_marca_producto character varying, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            C           1255    26981 >   update_municipio(integer, integer, character varying, integer) 	   PROCEDURE     �  CREATE PROCEDURE pfp_schema.update_municipio(IN p_id_departamento integer, IN p_id_municipio integer, IN p_municipio character varying, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Actualizar el registro correspondiente en la tabla TBL_MUNICIPIO
    UPDATE pfp_schema.tbl_municipio
    SET 
        id_departamento = p_id_departamento,  -- ID del departamento
        municipio = p_municipio,               -- Nombre del municipio
        id_estado = p_id_estado,               -- ID del estado
        fecha_modificacion = CURRENT_DATE,     -- Fecha de modificación actual
        modificado_por = 'ADMINISTRADOR'       -- Modificado por defecto
    WHERE 
        id_municipio = p_id_municipio;         -- Filtrar por ID del municipio

    -- Verificar si se actualizó alguna fila
    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontró el municipio con ID %', p_id_municipio;
    END IF;
END;
$$;
 �   DROP PROCEDURE pfp_schema.update_municipio(IN p_id_departamento integer, IN p_id_municipio integer, IN p_municipio character varying, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            -           1255    27024 8   update_objeto(integer, character varying, text, integer) 	   PROCEDURE     f  CREATE PROCEDURE pfp_schema.update_objeto(IN p_id_objeto integer, IN p_nombre character varying, IN p_descripcion text, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Actualizar en la tabla TBL_OBJETO
    UPDATE pfp_schema.tbl_objeto
    SET 
        nombre = p_nombre,
        descripcion = p_descripcion,
        id_estado = p_id_estado,
        fecha_modificacion = CURRENT_DATE,  -- Fecha actual del sistema
        modificado_por = 'ADMINISTRADOR'    -- Valor por defecto para quien modifica
    WHERE 
        id_objeto = p_id_objeto;            -- Filtrar por el ID del objeto
END;
$$;
 �   DROP PROCEDURE pfp_schema.update_objeto(IN p_id_objeto integer, IN p_nombre character varying, IN p_descripcion text, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            S           1255    27014 �   update_paciente(integer, character varying, character varying, character varying, date, character varying, character varying, character varying, character varying, integer, integer, character) 	   PROCEDURE     �  CREATE PROCEDURE pfp_schema.update_paciente(IN p_id_paciente integer, IN p_dni_paciente character varying, IN p_nombre_paciente character varying, IN p_apellido_paciente character varying, IN p_fecha_nacimiento date, IN p_email character varying, IN p_direccion character varying, IN p_celular character varying, IN p_tratamiento_medico character varying, IN p_id_usuario integer, IN p_id_estado integer, IN p_genero character)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Actualizar en la tabla TBL_PACIENTE
    UPDATE pfp_schema.tbl_paciente
    SET 
        dni_paciente = p_dni_paciente,
        nombre_paciente = p_nombre_paciente,
        apellido_paciente = p_apellido_paciente,
        fecha_nacimiento = p_fecha_nacimiento,
        email = p_email,
        direccion = p_direccion,
        celular = p_celular,
        tratamiento_medico = p_tratamiento_medico,
        id_usuario = p_id_usuario,
        id_estado = p_id_estado,
        genero = p_genero,
        fecha_modificacion = CURRENT_DATE,   -- Actualizamos la fecha de modificaciÃ³n
        modificado_por = 'ADMINISTRADOR'     -- Valor por defecto para quien modifica
    WHERE id_paciente = p_id_paciente;       -- Filtrar por el ID del paciente
END;
$$;
 �  DROP PROCEDURE pfp_schema.update_paciente(IN p_id_paciente integer, IN p_dni_paciente character varying, IN p_nombre_paciente character varying, IN p_apellido_paciente character varying, IN p_fecha_nacimiento date, IN p_email character varying, IN p_direccion character varying, IN p_celular character varying, IN p_tratamiento_medico character varying, IN p_id_usuario integer, IN p_id_estado integer, IN p_genero character);
    
   pfp_schema            	   admin_pfp    false    6            /           1255    26948 0   update_pais(integer, character varying, integer) 	   PROCEDURE     g  CREATE PROCEDURE pfp_schema.update_pais(IN p_id_pais integer, IN p_nombre_pais character varying, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Actualizar los campos nombre_pais y id_estado de la tabla TBL_PAIS
    UPDATE pfp_schema.tbl_pais
    SET 
        nombre_pais = p_nombre_pais,
        id_estado = p_id_estado,
        fecha_modificacion = CURRENT_DATE,  -- Actualiza la fecha de modificación
        modificado_por = 'Administrador'    -- Asigna un valor para el campo modificado_por
    WHERE id_pais = p_id_pais;  -- Condición para identificar el registro a actualizar
END;
$$;
 y   DROP PROCEDURE pfp_schema.update_pais(IN p_id_pais integer, IN p_nombre_pais character varying, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            Q           1255    27028 .   update_parametro(integer, text, text, integer) 	   PROCEDURE     �  CREATE PROCEDURE pfp_schema.update_parametro(IN p_id_parametro integer, IN p_parametro text, IN p_valor text, IN p_id_usuario integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE pfp_schema.tbl_parametro
    SET 
        parametro = p_parametro,
        valor = p_valor,
        id_usuario = p_id_usuario,
        fecha_modificacion = CURRENT_DATE,
        modificado_por = 'ADMINISTRADOR'
    WHERE id_parametro = p_id_parametro;
END;
$$;
 �   DROP PROCEDURE pfp_schema.update_parametro(IN p_id_parametro integer, IN p_parametro text, IN p_valor text, IN p_id_usuario integer);
    
   pfp_schema            	   admin_pfp    false    6            Z           1255    27032 J   update_permiso(integer, integer, integer, text, text, text, text, integer) 	   PROCEDURE     �  CREATE PROCEDURE pfp_schema.update_permiso(IN p_id_permiso integer, IN p_id_rol integer, IN p_id_objeto integer, IN p_permiso_creacion text, IN p_permiso_actualizacion text, IN p_permiso_eliminacion text, IN p_permiso_consultar text, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE pfp_schema.tbl_permiso
    SET 
        id_rol = p_id_rol,
        id_objeto = p_id_objeto,
        permiso_creacion = p_permiso_creacion,
        permiso_actualizacion = p_permiso_actualizacion,
        permiso_eliminacion = p_permiso_eliminacion,
        permiso_consultar = p_permiso_consultar,
        id_estado = p_id_estado,
        fecha_modificacion = CURRENT_DATE,
        modificado_por = 'ADMINISTRADOR'
    WHERE id_permiso = p_id_permiso;
END;
$$;
   DROP PROCEDURE pfp_schema.update_permiso(IN p_id_permiso integer, IN p_id_rol integer, IN p_id_objeto integer, IN p_permiso_creacion text, IN p_permiso_actualizacion text, IN p_permiso_eliminacion text, IN p_permiso_consultar text, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            P           1255    26996    update_pregunta(integer, text) 	   PROCEDURE     �  CREATE PROCEDURE pfp_schema.update_pregunta(IN p_id_pregunta integer, IN p_pregunta text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Actualizar el registro correspondiente en la tabla TBL_PREGUNTAS
    UPDATE pfp_schema.tbl_preguntas
    SET 
        pregunta = p_pregunta
    WHERE 
        id_pregunta = p_id_pregunta;

    -- Verificar si se actualizó alguna fila
    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontró la pregunta con ID %', p_id_pregunta;
    END IF;
END;
$$;
 Y   DROP PROCEDURE pfp_schema.update_pregunta(IN p_id_pregunta integer, IN p_pregunta text);
    
   pfp_schema            	   admin_pfp    false    6            ]           1255    26990 �   update_producto(integer, character varying, character varying, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE pfp_schema.update_producto(IN p_id_producto integer, IN p_codigo_barra character varying, IN p_nombre_producto character varying, IN p_id_forma_farmaceutica integer, IN p_id_especialidad integer, IN p_id_marca_producto integer, IN p_id_unidad_medida integer, IN p_id_via_administracion integer, IN p_id_estado integer, IN p_id_laboratorio integer, IN p_escala integer, IN p_canje integer, IN p_contenido_neto integer, IN p_consumo_diario integer, IN p_consumo_max_anual integer, IN p_canjes_max_anual integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Actualizar el registro correspondiente en la tabla TBL_PRODUCTO
    UPDATE pfp_schema.tbl_producto
    SET 
        codigo_barra = p_codigo_barra,
        nombre_producto = p_nombre_producto,
        id_forma_farmaceutica = p_id_forma_farmaceutica,
        id_especialidad = p_id_especialidad,
        id_marca_producto = p_id_marca_producto,
        id_unidad_medida = p_id_unidad_medida,
        id_via_administracion = p_id_via_administracion,
        id_estado = p_id_estado,
        id_laboratorio = p_id_laboratorio,
        escala = p_escala,
        canje = p_canje,
        contenido_neto = p_contenido_neto,
        consumo_diario = p_consumo_diario,
        consumo_max_anual = p_consumo_max_anual,
        canjes_max_anual = p_canjes_max_anual,
        fecha_modificacion = CURRENT_DATE,  -- Fecha de modificación actual
        modificado_por = 'ADMINISTRADOR'    -- Valor por defecto para modificado_por
    WHERE 
        id_producto = p_id_producto;  -- Filtrar por ID

    -- Verificar si se actualizó alguna fila
    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontró el producto con ID %', p_id_producto;
    END IF;
END;
$$;
   DROP PROCEDURE pfp_schema.update_producto(IN p_id_producto integer, IN p_codigo_barra character varying, IN p_nombre_producto character varying, IN p_id_forma_farmaceutica integer, IN p_id_especialidad integer, IN p_id_marca_producto integer, IN p_id_unidad_medida integer, IN p_id_via_administracion integer, IN p_id_estado integer, IN p_id_laboratorio integer, IN p_escala integer, IN p_canje integer, IN p_contenido_neto integer, IN p_consumo_diario integer, IN p_consumo_max_anual integer, IN p_canjes_max_anual integer);
    
   pfp_schema            	   admin_pfp    false    6            *           1255    26963 B   update_rol(integer, character varying, character varying, integer) 	   PROCEDURE     �  CREATE PROCEDURE pfp_schema.update_rol(IN p_id_rol integer, IN p_rol character varying, IN p_descripcion character varying, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Actualizar el registro correspondiente en la tabla TBL_ROL
    UPDATE pfp_schema.tbl_rol
    SET 
        rol = p_rol,
        descripcion = p_descripcion,
        id_estado = p_id_estado,
        fecha_modificacion = CURRENT_DATE,  -- Establecer la fecha de modificaciÃ³n actual
        modificado_por = 'ADMINISTRADOR'  -- Valor por defecto
    WHERE 
        id_rol = p_id_rol;  -- Filtrar por ID

    -- Verificar si se actualizÃ³ alguna fila
    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontrÃ³ el rol con ID %', p_id_rol;
    END IF;
END;
$$;
 �   DROP PROCEDURE pfp_schema.update_rol(IN p_id_rol integer, IN p_rol character varying, IN p_descripcion character varying, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            t           1255    26999 =   update_sucursal(integer, integer, character varying, integer) 	   PROCEDURE     8  CREATE PROCEDURE pfp_schema.update_sucursal(IN p_id_municipio integer, IN p_id_sucursal integer, IN p_nombre_sucursal character varying, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Actualizar en la tabla TBL_SUCURSAL
    UPDATE pfp_schema.tbl_sucursal
    SET
        id_municipio = p_id_municipio,
        nombre_sucursal = p_nombre_sucursal,
        id_estado = p_id_estado,
        fecha_modificacion = CURRENT_DATE,
        modificado_por = 'ADMINISTRADOR'  -- Asignar valor automáticamente
    WHERE id_sucursal = p_id_sucursal;
END;
$$;
 �   DROP PROCEDURE pfp_schema.update_sucursal(IN p_id_municipio integer, IN p_id_sucursal integer, IN p_nombre_sucursal character varying, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6                       1255    26984 9   update_tipo_contacto(integer, character varying, integer) 	   PROCEDURE       CREATE PROCEDURE pfp_schema.update_tipo_contacto(IN p_id_tipo_contacto integer, IN p_tipo_contacto character varying, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Actualizar el registro correspondiente en la tabla TBL_TIPO_CONTACTO
    UPDATE pfp_schema.tbl_tipo_contacto
    SET 
        tipo_contacto = p_tipo_contacto,
        id_estado = p_id_estado,
        fecha_modificacion = CURRENT_DATE,  -- Establecer la fecha de modificación actual
        modificado_por = 'ADMINISTRADOR'    -- Valor por defecto
    WHERE 
        id_tipo_contacto = p_id_tipo_contacto;  -- Filtrar por ID

    -- Verificar si se actualizó alguna fila
    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontró el tipo de contacto con ID %', p_id_tipo_contacto;
    END IF;
END;
$$;
 �   DROP PROCEDURE pfp_schema.update_tipo_contacto(IN p_id_tipo_contacto integer, IN p_tipo_contacto character varying, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            7           1255    26954 8   update_tipo_entidad(integer, character varying, integer) 	   PROCEDURE       CREATE PROCEDURE pfp_schema.update_tipo_entidad(IN p_id_tipo_entidad integer, IN p_tipo_entidad character varying, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Actualizar el registro correspondiente en la tabla TBL_TIPO_ENTIDAD
    UPDATE pfp_schema.tbl_tipo_entidad
    SET 
        tipo_entidad = p_tipo_entidad,
        id_estado = p_id_estado,
        fecha_modificacion = CURRENT_DATE,  -- Establecer la fecha de modificación actual
        modificado_por = 'ADMINISTRADOR'  -- Valor por defecto
    WHERE 
        id_tipo_entidad = p_id_tipo_entidad;  -- Filtrar por ID

    -- Verificar si se actualizó alguna fila
    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontró el tipo de entidad con ID %', p_id_tipo_entidad;
    END IF;
END;
$$;
 �   DROP PROCEDURE pfp_schema.update_tipo_entidad(IN p_id_tipo_entidad integer, IN p_tipo_entidad character varying, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            `           1255    26957 0   update_tipo_registro(integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE pfp_schema.update_tipo_registro(IN p_id_tipo_registro integer, IN p_tipo_registro character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Actualizar el registro correspondiente en la tabla TBL_TIPO_REGISTRO
    UPDATE pfp_schema.tbl_tipo_registro
    SET 
        tipo_registro = p_tipo_registro,
        fecha_modificacion = CURRENT_DATE,  -- Establecer la fecha de modificación actual
        modificado_por = 'ADMINISTRADOR'  -- Valor por defecto
    WHERE 
        id_tipo_registro = p_id_tipo_registro;  -- Filtrar por ID

    -- Verificar si se actualizó alguna fila
    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontró el tipo de registro con ID %', p_id_tipo_registro;
    END IF;
END;
$$;
 u   DROP PROCEDURE pfp_schema.update_tipo_registro(IN p_id_tipo_registro integer, IN p_tipo_registro character varying);
    
   pfp_schema            	   admin_pfp    false    6            H           1255    26960 9   update_unidad_medida(integer, character varying, integer) 	   PROCEDURE       CREATE PROCEDURE pfp_schema.update_unidad_medida(IN p_id_unidad_medida integer, IN p_unidad_medida character varying, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Actualizar el registro correspondiente en la tabla TBL_UNIDAD_MEDIDA
    UPDATE pfp_schema.tbl_unidad_medida
    SET 
        unidad_medida = p_unidad_medida,
        id_estado = p_id_estado,
        fecha_modificacion = CURRENT_DATE,  -- Establecer la fecha de modificación actual
        modificado_por = 'ADMINISTRADOR'  -- Valor por defecto
    WHERE 
        id_unidad_medida = p_id_unidad_medida;  -- Filtrar por ID

    -- Verificar si se actualizó alguna fila
    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontró la unidad de medida con ID %', p_id_unidad_medida;
    END IF;
END;
$$;
 �   DROP PROCEDURE pfp_schema.update_unidad_medida(IN p_id_unidad_medida integer, IN p_unidad_medida character varying, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            9           1255    27002 W   update_usuario(integer, text, text, text, integer, character varying, integer, integer) 	   PROCEDURE     n  CREATE PROCEDURE pfp_schema.update_usuario(IN p_id_usuario integer, IN p_usuario text, IN p_nombre_usuario text, IN p_contrasena text, IN p_id_rol integer, IN p_email character varying, IN p_primer_ingreso integer, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Actualizar en la tabla TBL_USUARIO
    UPDATE pfp_schema.tbl_usuario
    SET 
        usuario = p_usuario,
        nombre_usuario = p_nombre_usuario,
        contrasena = p_contrasena,
        id_rol = p_id_rol,
        fecha_ultima_conexion = CURRENT_DATE,                   -- Actualiza a la fecha actual
        fecha_vencimiento = CURRENT_DATE + INTERVAL '1 year',  -- Actualiza a un año desde la fecha actual
        email = p_email,
        primer_ingreso = p_primer_ingreso,
        id_estado = p_id_estado,
        fecha_modificacion = CURRENT_DATE,                       -- Actualiza la fecha de modificación
        modificado_por = 'ADMINISTRADOR'                        -- Puede ser el usuario que realiza la modificación
    WHERE 
        id_usuario = p_id_usuario;                               -- Filtrar por ID de usuario
END;
$$;
 �   DROP PROCEDURE pfp_schema.update_usuario(IN p_id_usuario integer, IN p_usuario text, IN p_nombre_usuario text, IN p_contrasena text, IN p_id_rol integer, IN p_email character varying, IN p_primer_ingreso integer, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            {           1255    26966 >   update_via_administracion(integer, character varying, integer) 	   PROCEDURE     P  CREATE PROCEDURE pfp_schema.update_via_administracion(IN p_id_via_administracion integer, IN p_via_administracion character varying, IN p_id_estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Actualizar el registro correspondiente en la tabla TBL_VIA_ADMINISTRACION
    UPDATE pfp_schema.tbl_via_administracion
    SET 
        via_administracion = p_via_administracion,
        id_estado = p_id_estado,
        fecha_modificacion = CURRENT_DATE,  -- Establecer la fecha de modificación actual
        modificado_por = 'ADMINISTRADOR'  -- Valor por defecto
    WHERE 
        id_via_administracion = p_id_via_administracion;  -- Filtrar por ID

    -- Verificar si se actualizó alguna fila
    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontró la vía de administración con ID %', p_id_via_administracion;
    END IF;
END;
$$;
 �   DROP PROCEDURE pfp_schema.update_via_administracion(IN p_id_via_administracion integer, IN p_via_administracion character varying, IN p_id_estado integer);
    
   pfp_schema            	   admin_pfp    false    6            ^           1255    26975 9   update_zona(integer, character varying, integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE pfp_schema.update_zona(IN p_id_zona integer, IN p_zona character varying, IN p_id_estado integer, IN p_id_pais integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Actualizar el registro correspondiente en la tabla TBL_ZONA
    UPDATE pfp_schema.tbl_zona
    SET 
        id_pais = p_id_pais,
        zona = p_zona,
        id_estado = p_id_estado,
        fecha_modificacion = CURRENT_DATE,  -- Establecer la fecha de modificación actual
        modificado_por = 'ADMINISTRADOR'  -- Valor por defecto
    WHERE 
        id_zona = p_id_zona;  -- Filtrar por ID

    -- Verificar si se actualizó alguna fila
    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontró la zona con ID %', p_id_zona;
    END IF;
END;
$$;
 �   DROP PROCEDURE pfp_schema.update_zona(IN p_id_zona integer, IN p_zona character varying, IN p_id_estado integer, IN p_id_pais integer);
    
   pfp_schema            	   admin_pfp    false    6                       1259    26586    tbl_bitacora    TABLE     �   CREATE TABLE pfp_schema.tbl_bitacora (
    id_bitacora integer NOT NULL,
    fecha date NOT NULL,
    id_usuario integer NOT NULL,
    id_objeto integer NOT NULL,
    accion text NOT NULL,
    descripcion text NOT NULL
);
 $   DROP TABLE pfp_schema.tbl_bitacora;
    
   pfp_schema         heap r    	   admin_pfp    false    6                       1259    26585    tbl_bitacora_id_bitacora_seq    SEQUENCE     �   CREATE SEQUENCE pfp_schema.tbl_bitacora_id_bitacora_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE pfp_schema.tbl_bitacora_id_bitacora_seq;
    
   pfp_schema            	   admin_pfp    false    6    275                       0    0    tbl_bitacora_id_bitacora_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE pfp_schema.tbl_bitacora_id_bitacora_seq OWNED BY pfp_schema.tbl_bitacora.id_bitacora;
       
   pfp_schema            	   admin_pfp    false    274                       1259    26492    tbl_contacto    TABLE       CREATE TABLE pfp_schema.tbl_contacto (
    id_contacto integer NOT NULL,
    nombre_contacto character varying(80) NOT NULL,
    id_usuario integer NOT NULL,
    id_tipo_contacto integer NOT NULL,
    telefono_1 character varying(40) NOT NULL,
    telefono_2 character varying(40),
    email character varying(150) NOT NULL,
    id_estado integer NOT NULL,
    fecha_creacion date DEFAULT CURRENT_DATE NOT NULL,
    creado_por text NOT NULL,
    fecha_modificacion date DEFAULT CURRENT_DATE NOT NULL,
    modificado_por text NOT NULL
);
 $   DROP TABLE pfp_schema.tbl_contacto;
    
   pfp_schema         heap r    	   admin_pfp    false    6                       1259    26491    tbl_contacto_id_contacto_seq    SEQUENCE     �   CREATE SEQUENCE pfp_schema.tbl_contacto_id_contacto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE pfp_schema.tbl_contacto_id_contacto_seq;
    
   pfp_schema            	   admin_pfp    false    6    259                       0    0    tbl_contacto_id_contacto_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE pfp_schema.tbl_contacto_id_contacto_seq OWNED BY pfp_schema.tbl_contacto.id_contacto;
       
   pfp_schema            	   admin_pfp    false    258            �            1259    26395    tbl_departamento    TABLE     {  CREATE TABLE pfp_schema.tbl_departamento (
    id_zona integer NOT NULL,
    id_departamento integer NOT NULL,
    nombre_departamento character varying(80) NOT NULL,
    id_estado integer NOT NULL,
    fecha_creacion date DEFAULT CURRENT_DATE NOT NULL,
    creado_por text NOT NULL,
    fecha_modificacion date DEFAULT CURRENT_DATE NOT NULL,
    modificado_por text NOT NULL
);
 (   DROP TABLE pfp_schema.tbl_departamento;
    
   pfp_schema         heap r    	   admin_pfp    false    6            �            1259    26394 $   tbl_departamento_id_departamento_seq    SEQUENCE     �   CREATE SEQUENCE pfp_schema.tbl_departamento_id_departamento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ?   DROP SEQUENCE pfp_schema.tbl_departamento_id_departamento_seq;
    
   pfp_schema            	   admin_pfp    false    241    6                       0    0 $   tbl_departamento_id_departamento_seq    SEQUENCE OWNED BY     u   ALTER SEQUENCE pfp_schema.tbl_departamento_id_departamento_seq OWNED BY pfp_schema.tbl_departamento.id_departamento;
       
   pfp_schema            	   admin_pfp    false    240                       1259    26503    tbl_distribuidor    TABLE       CREATE TABLE pfp_schema.tbl_distribuidor (
    id_distribuidor integer NOT NULL,
    rtn_distribuidor character varying(30) NOT NULL,
    nombre_distribuidor character varying(150) NOT NULL,
    id_pais integer NOT NULL,
    id_tipo_entidad integer NOT NULL,
    id_usuario integer NOT NULL,
    id_contacto integer NOT NULL,
    id_estado integer NOT NULL,
    fecha_creacion date DEFAULT CURRENT_DATE NOT NULL,
    creado_por text NOT NULL,
    fecha_modificacion date DEFAULT CURRENT_DATE NOT NULL,
    modificado_por text NOT NULL
);
 (   DROP TABLE pfp_schema.tbl_distribuidor;
    
   pfp_schema         heap r    	   admin_pfp    false    6                       1259    26502 $   tbl_distribuidor_id_distribuidor_seq    SEQUENCE     �   CREATE SEQUENCE pfp_schema.tbl_distribuidor_id_distribuidor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ?   DROP SEQUENCE pfp_schema.tbl_distribuidor_id_distribuidor_seq;
    
   pfp_schema            	   admin_pfp    false    6    261                       0    0 $   tbl_distribuidor_id_distribuidor_seq    SEQUENCE OWNED BY     u   ALTER SEQUENCE pfp_schema.tbl_distribuidor_id_distribuidor_seq OWNED BY pfp_schema.tbl_distribuidor.id_distribuidor;
       
   pfp_schema            	   admin_pfp    false    260            �            1259    26364    tbl_especialidad    TABLE     3  CREATE TABLE pfp_schema.tbl_especialidad (
    id_especialidad integer NOT NULL,
    nombre_especialidad character varying(80) NOT NULL,
    id_estado integer NOT NULL,
    fecha_creacion date NOT NULL,
    creado_por text NOT NULL,
    fecha_modificacion date NOT NULL,
    modificado_por text NOT NULL
);
 (   DROP TABLE pfp_schema.tbl_especialidad;
    
   pfp_schema         heap r    	   admin_pfp    false    6            �            1259    26363 $   tbl_especialidad_id_especialidad_seq    SEQUENCE     �   CREATE SEQUENCE pfp_schema.tbl_especialidad_id_especialidad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ?   DROP SEQUENCE pfp_schema.tbl_especialidad_id_especialidad_seq;
    
   pfp_schema            	   admin_pfp    false    235    6                       0    0 $   tbl_especialidad_id_especialidad_seq    SEQUENCE OWNED BY     u   ALTER SEQUENCE pfp_schema.tbl_especialidad_id_especialidad_seq OWNED BY pfp_schema.tbl_especialidad.id_especialidad;
       
   pfp_schema            	   admin_pfp    false    234            �            1259    26280 
   tbl_estado    TABLE     r   CREATE TABLE pfp_schema.tbl_estado (
    id_estado integer NOT NULL,
    estado character varying(15) NOT NULL
);
 "   DROP TABLE pfp_schema.tbl_estado;
    
   pfp_schema         heap r    	   admin_pfp    false    6            �            1259    26298    tbl_estado_canje    TABLE     6  CREATE TABLE pfp_schema.tbl_estado_canje (
    id_estado_canje integer NOT NULL,
    estado_canje character varying(20) NOT NULL,
    fecha_creacion date DEFAULT CURRENT_DATE NOT NULL,
    creado_por text NOT NULL,
    fecha_modificacion date DEFAULT CURRENT_DATE NOT NULL,
    modificado_por text NOT NULL
);
 (   DROP TABLE pfp_schema.tbl_estado_canje;
    
   pfp_schema         heap r    	   admin_pfp    false    6            �            1259    26297 $   tbl_estado_canje_id_estado_canje_seq    SEQUENCE     �   CREATE SEQUENCE pfp_schema.tbl_estado_canje_id_estado_canje_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ?   DROP SEQUENCE pfp_schema.tbl_estado_canje_id_estado_canje_seq;
    
   pfp_schema            	   admin_pfp    false    223    6            	           0    0 $   tbl_estado_canje_id_estado_canje_seq    SEQUENCE OWNED BY     u   ALTER SEQUENCE pfp_schema.tbl_estado_canje_id_estado_canje_seq OWNED BY pfp_schema.tbl_estado_canje.id_estado_canje;
       
   pfp_schema            	   admin_pfp    false    222            �            1259    26279    tbl_estado_id_estado_seq    SEQUENCE     �   CREATE SEQUENCE pfp_schema.tbl_estado_id_estado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE pfp_schema.tbl_estado_id_estado_seq;
    
   pfp_schema            	   admin_pfp    false    6    219            
           0    0    tbl_estado_id_estado_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE pfp_schema.tbl_estado_id_estado_seq OWNED BY pfp_schema.tbl_estado.id_estado;
       
   pfp_schema            	   admin_pfp    false    218                       1259    26541    tbl_factura    TABLE     �  CREATE TABLE pfp_schema.tbl_factura (
    id_factura integer NOT NULL,
    factura text NOT NULL,
    id_paciente integer NOT NULL,
    id_producto integer NOT NULL,
    cantidad_producto integer NOT NULL,
    fecha_creacion date DEFAULT CURRENT_DATE NOT NULL,
    creado_por text NOT NULL,
    fecha_modificacion date DEFAULT CURRENT_DATE NOT NULL,
    modificado_por text NOT NULL
);
 #   DROP TABLE pfp_schema.tbl_factura;
    
   pfp_schema         heap r    	   admin_pfp    false    6            
           1259    26540    tbl_factura_id_factura_seq    SEQUENCE     �   CREATE SEQUENCE pfp_schema.tbl_factura_id_factura_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE pfp_schema.tbl_factura_id_factura_seq;
    
   pfp_schema            	   admin_pfp    false    6    267                       0    0    tbl_factura_id_factura_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE pfp_schema.tbl_factura_id_factura_seq OWNED BY pfp_schema.tbl_factura.id_factura;
       
   pfp_schema            	   admin_pfp    false    266                       1259    26552    tbl_farmacia    TABLE       CREATE TABLE pfp_schema.tbl_farmacia (
    id_farmacia integer NOT NULL,
    rtn_farmacia character varying(30) NOT NULL,
    nombre_farmacia character varying(150) NOT NULL,
    id_sucursal integer NOT NULL,
    id_usuario integer NOT NULL,
    id_tipo_entidad integer NOT NULL,
    id_estado integer NOT NULL,
    id_contacto integer NOT NULL,
    fecha_creacion date DEFAULT CURRENT_DATE NOT NULL,
    creado_por text NOT NULL,
    fecha_modificacion date DEFAULT CURRENT_DATE NOT NULL,
    modificado_por text NOT NULL
);
 $   DROP TABLE pfp_schema.tbl_farmacia;
    
   pfp_schema         heap r    	   admin_pfp    false    6                       1259    26551    tbl_farmacia_id_farmacia_seq    SEQUENCE     �   CREATE SEQUENCE pfp_schema.tbl_farmacia_id_farmacia_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE pfp_schema.tbl_farmacia_id_farmacia_seq;
    
   pfp_schema            	   admin_pfp    false    6    269                       0    0    tbl_farmacia_id_farmacia_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE pfp_schema.tbl_farmacia_id_farmacia_seq OWNED BY pfp_schema.tbl_farmacia.id_farmacia;
       
   pfp_schema            	   admin_pfp    false    268            �            1259    26373    tbl_forma_farmaceutica    TABLE     h  CREATE TABLE pfp_schema.tbl_forma_farmaceutica (
    id_forma_farmaceutica integer NOT NULL,
    forma_farmaceutica character varying(70) NOT NULL,
    id_estado integer NOT NULL,
    fecha_creacion date DEFAULT CURRENT_DATE NOT NULL,
    creado_por text NOT NULL,
    fecha_modificacion date DEFAULT CURRENT_DATE NOT NULL,
    modificado_por text NOT NULL
);
 .   DROP TABLE pfp_schema.tbl_forma_farmaceutica;
    
   pfp_schema         heap r    	   admin_pfp    false    6            �            1259    26372 0   tbl_forma_farmaceutica_id_forma_farmaceutica_seq    SEQUENCE     �   CREATE SEQUENCE pfp_schema.tbl_forma_farmaceutica_id_forma_farmaceutica_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 K   DROP SEQUENCE pfp_schema.tbl_forma_farmaceutica_id_forma_farmaceutica_seq;
    
   pfp_schema            	   admin_pfp    false    237    6                       0    0 0   tbl_forma_farmaceutica_id_forma_farmaceutica_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE pfp_schema.tbl_forma_farmaceutica_id_forma_farmaceutica_seq OWNED BY pfp_schema.tbl_forma_farmaceutica.id_forma_farmaceutica;
       
   pfp_schema            	   admin_pfp    false    236                       1259    26516    tbl_laboratorio    TABLE       CREATE TABLE pfp_schema.tbl_laboratorio (
    id_laboratorio integer NOT NULL,
    rtn_laboratorio character varying(30) NOT NULL,
    nombre_laboratorio character varying(150) NOT NULL,
    id_pais integer NOT NULL,
    id_tipo_entidad integer NOT NULL,
    id_usuario integer NOT NULL,
    id_contacto integer NOT NULL,
    id_estado integer NOT NULL,
    fecha_creacion date DEFAULT CURRENT_DATE NOT NULL,
    creado_por text NOT NULL,
    fecha_modificacion date DEFAULT CURRENT_DATE NOT NULL,
    modificado_por text NOT NULL
);
 '   DROP TABLE pfp_schema.tbl_laboratorio;
    
   pfp_schema         heap r    	   admin_pfp    false    6                       1259    26515 "   tbl_laboratorio_id_laboratorio_seq    SEQUENCE     �   CREATE SEQUENCE pfp_schema.tbl_laboratorio_id_laboratorio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 =   DROP SEQUENCE pfp_schema.tbl_laboratorio_id_laboratorio_seq;
    
   pfp_schema            	   admin_pfp    false    263    6                       0    0 "   tbl_laboratorio_id_laboratorio_seq    SEQUENCE OWNED BY     q   ALTER SEQUENCE pfp_schema.tbl_laboratorio_id_laboratorio_seq OWNED BY pfp_schema.tbl_laboratorio.id_laboratorio;
       
   pfp_schema            	   admin_pfp    false    262            �            1259    26450    tbl_lote_producto    TABLE     �  CREATE TABLE pfp_schema.tbl_lote_producto (
    id_lote_producto integer NOT NULL,
    lote_producto character varying(80) NOT NULL,
    id_producto integer NOT NULL,
    fecha_vencimiento date NOT NULL,
    id_estado integer NOT NULL,
    fecha_creacion date DEFAULT CURRENT_DATE NOT NULL,
    creado_por text NOT NULL,
    fecha_modificacion date DEFAULT CURRENT_DATE NOT NULL,
    modificado_por text NOT NULL
);
 )   DROP TABLE pfp_schema.tbl_lote_producto;
    
   pfp_schema         heap r    	   admin_pfp    false    6            �            1259    26449 &   tbl_lote_producto_id_lote_producto_seq    SEQUENCE     �   CREATE SEQUENCE pfp_schema.tbl_lote_producto_id_lote_producto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 A   DROP SEQUENCE pfp_schema.tbl_lote_producto_id_lote_producto_seq;
    
   pfp_schema            	   admin_pfp    false    251    6                       0    0 &   tbl_lote_producto_id_lote_producto_seq    SEQUENCE OWNED BY     y   ALTER SEQUENCE pfp_schema.tbl_lote_producto_id_lote_producto_seq OWNED BY pfp_schema.tbl_lote_producto.id_lote_producto;
       
   pfp_schema            	   admin_pfp    false    250            �            1259    26428    tbl_marca_producto    TABLE     \  CREATE TABLE pfp_schema.tbl_marca_producto (
    id_marca_producto integer NOT NULL,
    marca_producto character varying(80) NOT NULL,
    id_estado integer NOT NULL,
    fecha_creacion date DEFAULT CURRENT_DATE NOT NULL,
    creado_por text NOT NULL,
    fecha_modificacion date DEFAULT CURRENT_DATE NOT NULL,
    modificado_por text NOT NULL
);
 *   DROP TABLE pfp_schema.tbl_marca_producto;
    
   pfp_schema         heap r    	   admin_pfp    false    6            �            1259    26427 (   tbl_marca_producto_id_marca_producto_seq    SEQUENCE     �   CREATE SEQUENCE pfp_schema.tbl_marca_producto_id_marca_producto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 C   DROP SEQUENCE pfp_schema.tbl_marca_producto_id_marca_producto_seq;
    
   pfp_schema            	   admin_pfp    false    247    6                       0    0 (   tbl_marca_producto_id_marca_producto_seq    SEQUENCE OWNED BY     }   ALTER SEQUENCE pfp_schema.tbl_marca_producto_id_marca_producto_seq OWNED BY pfp_schema.tbl_marca_producto.id_marca_producto;
       
   pfp_schema            	   admin_pfp    false    246            �            1259    26406    tbl_municipio    TABLE     s  CREATE TABLE pfp_schema.tbl_municipio (
    id_departamento integer NOT NULL,
    id_municipio integer NOT NULL,
    municipio character varying(80) NOT NULL,
    id_estado integer NOT NULL,
    fecha_creacion date DEFAULT CURRENT_DATE NOT NULL,
    creado_por text NOT NULL,
    fecha_modificacion date DEFAULT CURRENT_DATE NOT NULL,
    modificado_por text NOT NULL
);
 %   DROP TABLE pfp_schema.tbl_municipio;
    
   pfp_schema         heap r    	   admin_pfp    false    6            �            1259    26405    tbl_municipio_id_municipio_seq    SEQUENCE     �   CREATE SEQUENCE pfp_schema.tbl_municipio_id_municipio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE pfp_schema.tbl_municipio_id_municipio_seq;
    
   pfp_schema            	   admin_pfp    false    243    6                       0    0    tbl_municipio_id_municipio_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE pfp_schema.tbl_municipio_id_municipio_seq OWNED BY pfp_schema.tbl_municipio.id_municipio;
       
   pfp_schema            	   admin_pfp    false    242                       1259    26595 
   tbl_objeto    TABLE     �  CREATE TABLE pfp_schema.tbl_objeto (
    id_objeto integer NOT NULL,
    nombre text NOT NULL,
    descripcion text NOT NULL,
    id_estado integer NOT NULL,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_DATE NOT NULL,
    creado_por text NOT NULL,
    fecha_modificacion timestamp without time zone DEFAULT CURRENT_DATE NOT NULL,
    modificado_por text NOT NULL
);
 "   DROP TABLE pfp_schema.tbl_objeto;
    
   pfp_schema         heap r    	   admin_pfp    false    6                       1259    26594    tbl_objeto_id_objeto_seq    SEQUENCE     �   CREATE SEQUENCE pfp_schema.tbl_objeto_id_objeto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE pfp_schema.tbl_objeto_id_objeto_seq;
    
   pfp_schema            	   admin_pfp    false    6    277                       0    0    tbl_objeto_id_objeto_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE pfp_schema.tbl_objeto_id_objeto_seq OWNED BY pfp_schema.tbl_objeto.id_objeto;
       
   pfp_schema            	   admin_pfp    false    276            	           1259    26529    tbl_paciente    TABLE     @  CREATE TABLE pfp_schema.tbl_paciente (
    id_paciente integer NOT NULL,
    dni_paciente character varying(30) NOT NULL,
    nombre_paciente character varying(80) NOT NULL,
    apellido_paciente character varying(80) NOT NULL,
    fecha_nacimiento date NOT NULL,
    email character varying(150) NOT NULL,
    direccion character varying(200) NOT NULL,
    celular character varying(15) NOT NULL,
    tratamiento_medico character varying(150) NOT NULL,
    id_usuario integer NOT NULL,
    id_estado integer NOT NULL,
    fecha_creacion date DEFAULT CURRENT_DATE NOT NULL,
    creado_por text NOT NULL,
    fecha_modificacion date DEFAULT CURRENT_DATE NOT NULL,
    modificado_por text NOT NULL,
    genero character(1) NOT NULL,
    CONSTRAINT tbl_paciente_genero_check CHECK ((genero = ANY (ARRAY['F'::bpchar, 'M'::bpchar])))
);
 $   DROP TABLE pfp_schema.tbl_paciente;
    
   pfp_schema         heap r    	   admin_pfp    false    6                       1259    26528    tbl_paciente_id_paciente_seq    SEQUENCE     �   CREATE SEQUENCE pfp_schema.tbl_paciente_id_paciente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE pfp_schema.tbl_paciente_id_paciente_seq;
    
   pfp_schema            	   admin_pfp    false    6    265                       0    0    tbl_paciente_id_paciente_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE pfp_schema.tbl_paciente_id_paciente_seq OWNED BY pfp_schema.tbl_paciente.id_paciente;
       
   pfp_schema            	   admin_pfp    false    264            �            1259    26287    tbl_pais    TABLE     F  CREATE TABLE pfp_schema.tbl_pais (
    id_pais integer NOT NULL,
    nombre_pais character varying(100) NOT NULL,
    id_estado integer NOT NULL,
    fecha_creacion date DEFAULT CURRENT_DATE NOT NULL,
    creado_por text NOT NULL,
    fecha_modificacion date DEFAULT CURRENT_DATE NOT NULL,
    modificado_por text NOT NULL
);
     DROP TABLE pfp_schema.tbl_pais;
    
   pfp_schema         heap r    	   admin_pfp    false    6            �            1259    26286    tbl_pais_id_pais_seq    SEQUENCE     �   CREATE SEQUENCE pfp_schema.tbl_pais_id_pais_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE pfp_schema.tbl_pais_id_pais_seq;
    
   pfp_schema            	   admin_pfp    false    221    6                       0    0    tbl_pais_id_pais_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE pfp_schema.tbl_pais_id_pais_seq OWNED BY pfp_schema.tbl_pais.id_pais;
       
   pfp_schema            	   admin_pfp    false    220                       1259    26606    tbl_parametro    TABLE     V  CREATE TABLE pfp_schema.tbl_parametro (
    id_parametro integer NOT NULL,
    parametro text NOT NULL,
    valor text NOT NULL,
    id_usuario integer NOT NULL,
    fecha_creacion date DEFAULT CURRENT_DATE NOT NULL,
    creado_por text NOT NULL,
    fecha_modificacion date DEFAULT CURRENT_DATE NOT NULL,
    modificado_por text NOT NULL
);
 %   DROP TABLE pfp_schema.tbl_parametro;
    
   pfp_schema         heap r    	   admin_pfp    false    6                       1259    26605    tbl_parametro_id_parametro_seq    SEQUENCE     �   CREATE SEQUENCE pfp_schema.tbl_parametro_id_parametro_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE pfp_schema.tbl_parametro_id_parametro_seq;
    
   pfp_schema            	   admin_pfp    false    279    6                       0    0    tbl_parametro_id_parametro_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE pfp_schema.tbl_parametro_id_parametro_seq OWNED BY pfp_schema.tbl_parametro.id_parametro;
       
   pfp_schema            	   admin_pfp    false    278                       1259    26617    tbl_permiso    TABLE     �  CREATE TABLE pfp_schema.tbl_permiso (
    id_permiso integer NOT NULL,
    id_rol integer NOT NULL,
    id_objeto integer NOT NULL,
    permiso_creacion text NOT NULL,
    permiso_actualizacion text NOT NULL,
    permiso_eliminacion text NOT NULL,
    permiso_consultar text NOT NULL,
    id_estado integer NOT NULL,
    fecha_creacion date DEFAULT CURRENT_DATE NOT NULL,
    creado_por text NOT NULL,
    fecha_modificacion date DEFAULT CURRENT_DATE NOT NULL,
    modificado_por text NOT NULL
);
 #   DROP TABLE pfp_schema.tbl_permiso;
    
   pfp_schema         heap r    	   admin_pfp    false    6                       1259    26616    tbl_permiso_id_permiso_seq    SEQUENCE     �   CREATE SEQUENCE pfp_schema.tbl_permiso_id_permiso_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE pfp_schema.tbl_permiso_id_permiso_seq;
    
   pfp_schema            	   admin_pfp    false    6    281                       0    0    tbl_permiso_id_permiso_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE pfp_schema.tbl_permiso_id_permiso_seq OWNED BY pfp_schema.tbl_permiso.id_permiso;
       
   pfp_schema            	   admin_pfp    false    280            �            1259    26461    tbl_preguntas    TABLE     h   CREATE TABLE pfp_schema.tbl_preguntas (
    id_pregunta integer NOT NULL,
    pregunta text NOT NULL
);
 %   DROP TABLE pfp_schema.tbl_preguntas;
    
   pfp_schema         heap r    	   admin_pfp    false    6            �            1259    26460    tbl_preguntas_id_pregunta_seq    SEQUENCE     �   CREATE SEQUENCE pfp_schema.tbl_preguntas_id_pregunta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE pfp_schema.tbl_preguntas_id_pregunta_seq;
    
   pfp_schema            	   admin_pfp    false    6    253                       0    0    tbl_preguntas_id_pregunta_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE pfp_schema.tbl_preguntas_id_pregunta_seq OWNED BY pfp_schema.tbl_preguntas.id_pregunta;
       
   pfp_schema            	   admin_pfp    false    252                       1259    26577    tbl_preguntas_usuario    TABLE     �   CREATE TABLE pfp_schema.tbl_preguntas_usuario (
    id_pregunta_usuario integer NOT NULL,
    id_usuario integer NOT NULL,
    respuesta text NOT NULL
);
 -   DROP TABLE pfp_schema.tbl_preguntas_usuario;
    
   pfp_schema         heap r    	   admin_pfp    false    6                       1259    26576 -   tbl_preguntas_usuario_id_pregunta_usuario_seq    SEQUENCE     �   CREATE SEQUENCE pfp_schema.tbl_preguntas_usuario_id_pregunta_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 H   DROP SEQUENCE pfp_schema.tbl_preguntas_usuario_id_pregunta_usuario_seq;
    
   pfp_schema            	   admin_pfp    false    273    6                       0    0 -   tbl_preguntas_usuario_id_pregunta_usuario_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE pfp_schema.tbl_preguntas_usuario_id_pregunta_usuario_seq OWNED BY pfp_schema.tbl_preguntas_usuario.id_pregunta_usuario;
       
   pfp_schema            	   admin_pfp    false    272            �            1259    26439    tbl_producto    TABLE     G  CREATE TABLE pfp_schema.tbl_producto (
    id_producto integer NOT NULL,
    codigo_barra character varying(20) NOT NULL,
    nombre_producto character varying(100) NOT NULL,
    id_forma_farmaceutica integer NOT NULL,
    id_especialidad integer NOT NULL,
    id_marca_producto integer NOT NULL,
    id_unidad_medida integer NOT NULL,
    id_via_administracion integer NOT NULL,
    id_estado integer NOT NULL,
    id_laboratorio integer NOT NULL,
    escala integer NOT NULL,
    canje integer NOT NULL,
    contenido_neto integer NOT NULL,
    consumo_diario integer NOT NULL,
    consumo_max_anual integer NOT NULL,
    canjes_max_anual integer NOT NULL,
    fecha_creacion date DEFAULT CURRENT_DATE NOT NULL,
    creado_por text NOT NULL,
    fecha_modificacion date DEFAULT CURRENT_DATE NOT NULL,
    modificado_por text NOT NULL
);
 $   DROP TABLE pfp_schema.tbl_producto;
    
   pfp_schema         heap r    	   admin_pfp    false    6            �            1259    26438    tbl_producto_id_producto_seq    SEQUENCE     �   CREATE SEQUENCE pfp_schema.tbl_producto_id_producto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE pfp_schema.tbl_producto_id_producto_seq;
    
   pfp_schema            	   admin_pfp    false    249    6                       0    0    tbl_producto_id_producto_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE pfp_schema.tbl_producto_id_producto_seq OWNED BY pfp_schema.tbl_producto.id_producto;
       
   pfp_schema            	   admin_pfp    false    248                       1259    26565    tbl_registro    TABLE     J  CREATE TABLE pfp_schema.tbl_registro (
    id_registro integer NOT NULL,
    fecha_registro timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    id_tipo_registro integer NOT NULL,
    id_farmacia integer NOT NULL,
    id_paciente integer NOT NULL,
    id_producto integer NOT NULL,
    cantidad integer NOT NULL,
    id_estado_canje integer NOT NULL,
    comentarios character varying(200),
    fecha_creacion date DEFAULT CURRENT_DATE NOT NULL,
    creado_por text NOT NULL,
    fecha_modificacion date DEFAULT CURRENT_DATE NOT NULL,
    modificado_por text NOT NULL
);
 $   DROP TABLE pfp_schema.tbl_registro;
    
   pfp_schema         heap r    	   admin_pfp    false    6                       1259    26564    tbl_registro_id_registro_seq    SEQUENCE     �   CREATE SEQUENCE pfp_schema.tbl_registro_id_registro_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE pfp_schema.tbl_registro_id_registro_seq;
    
   pfp_schema            	   admin_pfp    false    271    6                       0    0    tbl_registro_id_registro_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE pfp_schema.tbl_registro_id_registro_seq OWNED BY pfp_schema.tbl_registro.id_registro;
       
   pfp_schema            	   admin_pfp    false    270            �            1259    26342    tbl_rol    TABLE     l  CREATE TABLE pfp_schema.tbl_rol (
    id_rol integer NOT NULL,
    rol character varying(30) NOT NULL,
    descripcion character varying(150) NOT NULL,
    id_estado integer NOT NULL,
    fecha_creacion date DEFAULT CURRENT_DATE NOT NULL,
    creado_por text NOT NULL,
    fecha_modificacion date DEFAULT CURRENT_DATE NOT NULL,
    modificado_por text NOT NULL
);
    DROP TABLE pfp_schema.tbl_rol;
    
   pfp_schema         heap r    	   admin_pfp    false    6            �            1259    26341    tbl_rol_id_rol_seq    SEQUENCE     �   CREATE SEQUENCE pfp_schema.tbl_rol_id_rol_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE pfp_schema.tbl_rol_id_rol_seq;
    
   pfp_schema            	   admin_pfp    false    6    231                       0    0    tbl_rol_id_rol_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE pfp_schema.tbl_rol_id_rol_seq OWNED BY pfp_schema.tbl_rol.id_rol;
       
   pfp_schema            	   admin_pfp    false    230            �            1259    26470    tbl_sucursal    TABLE     t  CREATE TABLE pfp_schema.tbl_sucursal (
    id_municipio integer NOT NULL,
    id_sucursal integer NOT NULL,
    nombre_sucursal character varying(80) NOT NULL,
    id_estado integer NOT NULL,
    fecha_creacion date DEFAULT CURRENT_DATE NOT NULL,
    creado_por text NOT NULL,
    fecha_modificacion date DEFAULT CURRENT_DATE NOT NULL,
    modificado_por text NOT NULL
);
 $   DROP TABLE pfp_schema.tbl_sucursal;
    
   pfp_schema         heap r    	   admin_pfp    false    6            �            1259    26469    tbl_sucursal_id_sucursal_seq    SEQUENCE     �   CREATE SEQUENCE pfp_schema.tbl_sucursal_id_sucursal_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE pfp_schema.tbl_sucursal_id_sucursal_seq;
    
   pfp_schema            	   admin_pfp    false    6    255                       0    0    tbl_sucursal_id_sucursal_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE pfp_schema.tbl_sucursal_id_sucursal_seq OWNED BY pfp_schema.tbl_sucursal.id_sucursal;
       
   pfp_schema            	   admin_pfp    false    254            �            1259    26417    tbl_tipo_contacto    TABLE     Y  CREATE TABLE pfp_schema.tbl_tipo_contacto (
    id_tipo_contacto integer NOT NULL,
    tipo_contacto character varying(30) NOT NULL,
    id_estado integer NOT NULL,
    fecha_creacion date DEFAULT CURRENT_DATE NOT NULL,
    creado_por text NOT NULL,
    fecha_modificacion date DEFAULT CURRENT_DATE NOT NULL,
    modificado_por text NOT NULL
);
 )   DROP TABLE pfp_schema.tbl_tipo_contacto;
    
   pfp_schema         heap r    	   admin_pfp    false    6            �            1259    26416 &   tbl_tipo_contacto_id_tipo_contacto_seq    SEQUENCE     �   CREATE SEQUENCE pfp_schema.tbl_tipo_contacto_id_tipo_contacto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 A   DROP SEQUENCE pfp_schema.tbl_tipo_contacto_id_tipo_contacto_seq;
    
   pfp_schema            	   admin_pfp    false    6    245                       0    0 &   tbl_tipo_contacto_id_tipo_contacto_seq    SEQUENCE OWNED BY     y   ALTER SEQUENCE pfp_schema.tbl_tipo_contacto_id_tipo_contacto_seq OWNED BY pfp_schema.tbl_tipo_contacto.id_tipo_contacto;
       
   pfp_schema            	   admin_pfp    false    244            �            1259    26309    tbl_tipo_entidad    TABLE     V  CREATE TABLE pfp_schema.tbl_tipo_entidad (
    id_tipo_entidad integer NOT NULL,
    tipo_entidad character varying(80) NOT NULL,
    id_estado integer NOT NULL,
    fecha_creacion date DEFAULT CURRENT_DATE NOT NULL,
    creado_por text NOT NULL,
    fecha_modificacion date DEFAULT CURRENT_DATE NOT NULL,
    modificado_por text NOT NULL
);
 (   DROP TABLE pfp_schema.tbl_tipo_entidad;
    
   pfp_schema         heap r    	   admin_pfp    false    6            �            1259    26308 $   tbl_tipo_entidad_id_tipo_entidad_seq    SEQUENCE     �   CREATE SEQUENCE pfp_schema.tbl_tipo_entidad_id_tipo_entidad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ?   DROP SEQUENCE pfp_schema.tbl_tipo_entidad_id_tipo_entidad_seq;
    
   pfp_schema            	   admin_pfp    false    6    225                       0    0 $   tbl_tipo_entidad_id_tipo_entidad_seq    SEQUENCE OWNED BY     u   ALTER SEQUENCE pfp_schema.tbl_tipo_entidad_id_tipo_entidad_seq OWNED BY pfp_schema.tbl_tipo_entidad.id_tipo_entidad;
       
   pfp_schema            	   admin_pfp    false    224            �            1259    26320    tbl_tipo_registro    TABLE     9  CREATE TABLE pfp_schema.tbl_tipo_registro (
    id_tipo_registro integer NOT NULL,
    tipo_registro character varying(30) NOT NULL,
    fecha_creacion date DEFAULT CURRENT_DATE NOT NULL,
    creado_por text NOT NULL,
    fecha_modificacion date DEFAULT CURRENT_DATE NOT NULL,
    modificado_por text NOT NULL
);
 )   DROP TABLE pfp_schema.tbl_tipo_registro;
    
   pfp_schema         heap r    	   admin_pfp    false    6            �            1259    26319 &   tbl_tipo_registro_id_tipo_registro_seq    SEQUENCE     �   CREATE SEQUENCE pfp_schema.tbl_tipo_registro_id_tipo_registro_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 A   DROP SEQUENCE pfp_schema.tbl_tipo_registro_id_tipo_registro_seq;
    
   pfp_schema            	   admin_pfp    false    6    227                       0    0 &   tbl_tipo_registro_id_tipo_registro_seq    SEQUENCE OWNED BY     y   ALTER SEQUENCE pfp_schema.tbl_tipo_registro_id_tipo_registro_seq OWNED BY pfp_schema.tbl_tipo_registro.id_tipo_registro;
       
   pfp_schema            	   admin_pfp    false    226            �            1259    26331    tbl_unidad_medida    TABLE     X  CREATE TABLE pfp_schema.tbl_unidad_medida (
    id_unidad_medida integer NOT NULL,
    unidad_medida character varying(5) NOT NULL,
    id_estado integer NOT NULL,
    fecha_creacion date DEFAULT CURRENT_DATE NOT NULL,
    creado_por text NOT NULL,
    fecha_modificacion date DEFAULT CURRENT_DATE NOT NULL,
    modificado_por text NOT NULL
);
 )   DROP TABLE pfp_schema.tbl_unidad_medida;
    
   pfp_schema         heap r    	   admin_pfp    false    6            �            1259    26330 &   tbl_unidad_medida_id_unidad_medida_seq    SEQUENCE     �   CREATE SEQUENCE pfp_schema.tbl_unidad_medida_id_unidad_medida_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 A   DROP SEQUENCE pfp_schema.tbl_unidad_medida_id_unidad_medida_seq;
    
   pfp_schema            	   admin_pfp    false    6    229                        0    0 &   tbl_unidad_medida_id_unidad_medida_seq    SEQUENCE OWNED BY     y   ALTER SEQUENCE pfp_schema.tbl_unidad_medida_id_unidad_medida_seq OWNED BY pfp_schema.tbl_unidad_medida.id_unidad_medida;
       
   pfp_schema            	   admin_pfp    false    228                       1259    26481    tbl_usuario    TABLE     1  CREATE TABLE pfp_schema.tbl_usuario (
    id_usuario integer NOT NULL,
    usuario text NOT NULL,
    nombre_usuario text NOT NULL,
    contrasena text NOT NULL,
    id_rol integer NOT NULL,
    fecha_ultima_conexion date NOT NULL,
    fecha_vencimiento date NOT NULL,
    email character varying(150) NOT NULL,
    primer_ingreso integer NOT NULL,
    id_estado integer NOT NULL,
    fecha_creacion date DEFAULT CURRENT_DATE NOT NULL,
    creado_por text NOT NULL,
    fecha_modificacion date DEFAULT CURRENT_DATE NOT NULL,
    modificado_por text NOT NULL
);
 #   DROP TABLE pfp_schema.tbl_usuario;
    
   pfp_schema         heap r    	   admin_pfp    false    6                        1259    26480    tbl_usuario_id_usuario_seq    SEQUENCE     �   CREATE SEQUENCE pfp_schema.tbl_usuario_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE pfp_schema.tbl_usuario_id_usuario_seq;
    
   pfp_schema            	   admin_pfp    false    257    6            !           0    0    tbl_usuario_id_usuario_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE pfp_schema.tbl_usuario_id_usuario_seq OWNED BY pfp_schema.tbl_usuario.id_usuario;
       
   pfp_schema            	   admin_pfp    false    256            �            1259    26353    tbl_via_administracion    TABLE     h  CREATE TABLE pfp_schema.tbl_via_administracion (
    id_via_administracion integer NOT NULL,
    via_administracion character varying(70) NOT NULL,
    id_estado integer NOT NULL,
    fecha_creacion date DEFAULT CURRENT_DATE NOT NULL,
    creado_por text NOT NULL,
    fecha_modificacion date DEFAULT CURRENT_DATE NOT NULL,
    modificado_por text NOT NULL
);
 .   DROP TABLE pfp_schema.tbl_via_administracion;
    
   pfp_schema         heap r    	   admin_pfp    false    6            �            1259    26352 0   tbl_via_administracion_id_via_administracion_seq    SEQUENCE     �   CREATE SEQUENCE pfp_schema.tbl_via_administracion_id_via_administracion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 K   DROP SEQUENCE pfp_schema.tbl_via_administracion_id_via_administracion_seq;
    
   pfp_schema            	   admin_pfp    false    6    233            "           0    0 0   tbl_via_administracion_id_via_administracion_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE pfp_schema.tbl_via_administracion_id_via_administracion_seq OWNED BY pfp_schema.tbl_via_administracion.id_via_administracion;
       
   pfp_schema            	   admin_pfp    false    232            �            1259    26384    tbl_zona    TABLE     \  CREATE TABLE pfp_schema.tbl_zona (
    id_pais integer NOT NULL,
    id_zona integer NOT NULL,
    zona character varying(80) NOT NULL,
    id_estado integer NOT NULL,
    fecha_creacion date DEFAULT CURRENT_DATE NOT NULL,
    creado_por text NOT NULL,
    fecha_modificacion date DEFAULT CURRENT_DATE NOT NULL,
    modificado_por text NOT NULL
);
     DROP TABLE pfp_schema.tbl_zona;
    
   pfp_schema         heap r    	   admin_pfp    false    6            �            1259    26383    tbl_zona_id_zona_seq    SEQUENCE     �   CREATE SEQUENCE pfp_schema.tbl_zona_id_zona_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE pfp_schema.tbl_zona_id_zona_seq;
    
   pfp_schema            	   admin_pfp    false    239    6            #           0    0    tbl_zona_id_zona_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE pfp_schema.tbl_zona_id_zona_seq OWNED BY pfp_schema.tbl_zona.id_zona;
       
   pfp_schema            	   admin_pfp    false    238            �           2604    52430    tbl_bitacora id_bitacora    DEFAULT     �   ALTER TABLE ONLY pfp_schema.tbl_bitacora ALTER COLUMN id_bitacora SET DEFAULT nextval('pfp_schema.tbl_bitacora_id_bitacora_seq'::regclass);
 K   ALTER TABLE pfp_schema.tbl_bitacora ALTER COLUMN id_bitacora DROP DEFAULT;
    
   pfp_schema            	   admin_pfp    false    275    274    275            �           2604    52431    tbl_contacto id_contacto    DEFAULT     �   ALTER TABLE ONLY pfp_schema.tbl_contacto ALTER COLUMN id_contacto SET DEFAULT nextval('pfp_schema.tbl_contacto_id_contacto_seq'::regclass);
 K   ALTER TABLE pfp_schema.tbl_contacto ALTER COLUMN id_contacto DROP DEFAULT;
    
   pfp_schema            	   admin_pfp    false    259    258    259            k           2604    52432     tbl_departamento id_departamento    DEFAULT     �   ALTER TABLE ONLY pfp_schema.tbl_departamento ALTER COLUMN id_departamento SET DEFAULT nextval('pfp_schema.tbl_departamento_id_departamento_seq'::regclass);
 S   ALTER TABLE pfp_schema.tbl_departamento ALTER COLUMN id_departamento DROP DEFAULT;
    
   pfp_schema            	   admin_pfp    false    241    240    241            �           2604    52433     tbl_distribuidor id_distribuidor    DEFAULT     �   ALTER TABLE ONLY pfp_schema.tbl_distribuidor ALTER COLUMN id_distribuidor SET DEFAULT nextval('pfp_schema.tbl_distribuidor_id_distribuidor_seq'::regclass);
 S   ALTER TABLE pfp_schema.tbl_distribuidor ALTER COLUMN id_distribuidor DROP DEFAULT;
    
   pfp_schema            	   admin_pfp    false    260    261    261            d           2604    52434     tbl_especialidad id_especialidad    DEFAULT     �   ALTER TABLE ONLY pfp_schema.tbl_especialidad ALTER COLUMN id_especialidad SET DEFAULT nextval('pfp_schema.tbl_especialidad_id_especialidad_seq'::regclass);
 S   ALTER TABLE pfp_schema.tbl_especialidad ALTER COLUMN id_especialidad DROP DEFAULT;
    
   pfp_schema            	   admin_pfp    false    234    235    235            N           2604    52435    tbl_estado id_estado    DEFAULT     �   ALTER TABLE ONLY pfp_schema.tbl_estado ALTER COLUMN id_estado SET DEFAULT nextval('pfp_schema.tbl_estado_id_estado_seq'::regclass);
 G   ALTER TABLE pfp_schema.tbl_estado ALTER COLUMN id_estado DROP DEFAULT;
    
   pfp_schema            	   admin_pfp    false    219    218    219            R           2604    52436     tbl_estado_canje id_estado_canje    DEFAULT     �   ALTER TABLE ONLY pfp_schema.tbl_estado_canje ALTER COLUMN id_estado_canje SET DEFAULT nextval('pfp_schema.tbl_estado_canje_id_estado_canje_seq'::regclass);
 S   ALTER TABLE pfp_schema.tbl_estado_canje ALTER COLUMN id_estado_canje DROP DEFAULT;
    
   pfp_schema            	   admin_pfp    false    223    222    223            �           2604    52437    tbl_factura id_factura    DEFAULT     �   ALTER TABLE ONLY pfp_schema.tbl_factura ALTER COLUMN id_factura SET DEFAULT nextval('pfp_schema.tbl_factura_id_factura_seq'::regclass);
 I   ALTER TABLE pfp_schema.tbl_factura ALTER COLUMN id_factura DROP DEFAULT;
    
   pfp_schema            	   admin_pfp    false    266    267    267            �           2604    52438    tbl_farmacia id_farmacia    DEFAULT     �   ALTER TABLE ONLY pfp_schema.tbl_farmacia ALTER COLUMN id_farmacia SET DEFAULT nextval('pfp_schema.tbl_farmacia_id_farmacia_seq'::regclass);
 K   ALTER TABLE pfp_schema.tbl_farmacia ALTER COLUMN id_farmacia DROP DEFAULT;
    
   pfp_schema            	   admin_pfp    false    269    268    269            e           2604    52439 ,   tbl_forma_farmaceutica id_forma_farmaceutica    DEFAULT     �   ALTER TABLE ONLY pfp_schema.tbl_forma_farmaceutica ALTER COLUMN id_forma_farmaceutica SET DEFAULT nextval('pfp_schema.tbl_forma_farmaceutica_id_forma_farmaceutica_seq'::regclass);
 _   ALTER TABLE pfp_schema.tbl_forma_farmaceutica ALTER COLUMN id_forma_farmaceutica DROP DEFAULT;
    
   pfp_schema            	   admin_pfp    false    236    237    237            �           2604    52440    tbl_laboratorio id_laboratorio    DEFAULT     �   ALTER TABLE ONLY pfp_schema.tbl_laboratorio ALTER COLUMN id_laboratorio SET DEFAULT nextval('pfp_schema.tbl_laboratorio_id_laboratorio_seq'::regclass);
 Q   ALTER TABLE pfp_schema.tbl_laboratorio ALTER COLUMN id_laboratorio DROP DEFAULT;
    
   pfp_schema            	   admin_pfp    false    262    263    263            z           2604    52441 "   tbl_lote_producto id_lote_producto    DEFAULT     �   ALTER TABLE ONLY pfp_schema.tbl_lote_producto ALTER COLUMN id_lote_producto SET DEFAULT nextval('pfp_schema.tbl_lote_producto_id_lote_producto_seq'::regclass);
 U   ALTER TABLE pfp_schema.tbl_lote_producto ALTER COLUMN id_lote_producto DROP DEFAULT;
    
   pfp_schema            	   admin_pfp    false    250    251    251            t           2604    52442 $   tbl_marca_producto id_marca_producto    DEFAULT     �   ALTER TABLE ONLY pfp_schema.tbl_marca_producto ALTER COLUMN id_marca_producto SET DEFAULT nextval('pfp_schema.tbl_marca_producto_id_marca_producto_seq'::regclass);
 W   ALTER TABLE pfp_schema.tbl_marca_producto ALTER COLUMN id_marca_producto DROP DEFAULT;
    
   pfp_schema            	   admin_pfp    false    247    246    247            n           2604    52443    tbl_municipio id_municipio    DEFAULT     �   ALTER TABLE ONLY pfp_schema.tbl_municipio ALTER COLUMN id_municipio SET DEFAULT nextval('pfp_schema.tbl_municipio_id_municipio_seq'::regclass);
 M   ALTER TABLE pfp_schema.tbl_municipio ALTER COLUMN id_municipio DROP DEFAULT;
    
   pfp_schema            	   admin_pfp    false    243    242    243            �           2604    52444    tbl_objeto id_objeto    DEFAULT     �   ALTER TABLE ONLY pfp_schema.tbl_objeto ALTER COLUMN id_objeto SET DEFAULT nextval('pfp_schema.tbl_objeto_id_objeto_seq'::regclass);
 G   ALTER TABLE pfp_schema.tbl_objeto ALTER COLUMN id_objeto DROP DEFAULT;
    
   pfp_schema            	   admin_pfp    false    277    276    277            �           2604    52445    tbl_paciente id_paciente    DEFAULT     �   ALTER TABLE ONLY pfp_schema.tbl_paciente ALTER COLUMN id_paciente SET DEFAULT nextval('pfp_schema.tbl_paciente_id_paciente_seq'::regclass);
 K   ALTER TABLE pfp_schema.tbl_paciente ALTER COLUMN id_paciente DROP DEFAULT;
    
   pfp_schema            	   admin_pfp    false    264    265    265            O           2604    52446    tbl_pais id_pais    DEFAULT     |   ALTER TABLE ONLY pfp_schema.tbl_pais ALTER COLUMN id_pais SET DEFAULT nextval('pfp_schema.tbl_pais_id_pais_seq'::regclass);
 C   ALTER TABLE pfp_schema.tbl_pais ALTER COLUMN id_pais DROP DEFAULT;
    
   pfp_schema            	   admin_pfp    false    221    220    221            �           2604    52447    tbl_parametro id_parametro    DEFAULT     �   ALTER TABLE ONLY pfp_schema.tbl_parametro ALTER COLUMN id_parametro SET DEFAULT nextval('pfp_schema.tbl_parametro_id_parametro_seq'::regclass);
 M   ALTER TABLE pfp_schema.tbl_parametro ALTER COLUMN id_parametro DROP DEFAULT;
    
   pfp_schema            	   admin_pfp    false    279    278    279            �           2604    52448    tbl_permiso id_permiso    DEFAULT     �   ALTER TABLE ONLY pfp_schema.tbl_permiso ALTER COLUMN id_permiso SET DEFAULT nextval('pfp_schema.tbl_permiso_id_permiso_seq'::regclass);
 I   ALTER TABLE pfp_schema.tbl_permiso ALTER COLUMN id_permiso DROP DEFAULT;
    
   pfp_schema            	   admin_pfp    false    281    280    281            }           2604    52449    tbl_preguntas id_pregunta    DEFAULT     �   ALTER TABLE ONLY pfp_schema.tbl_preguntas ALTER COLUMN id_pregunta SET DEFAULT nextval('pfp_schema.tbl_preguntas_id_pregunta_seq'::regclass);
 L   ALTER TABLE pfp_schema.tbl_preguntas ALTER COLUMN id_pregunta DROP DEFAULT;
    
   pfp_schema            	   admin_pfp    false    253    252    253            �           2604    52450 )   tbl_preguntas_usuario id_pregunta_usuario    DEFAULT     �   ALTER TABLE ONLY pfp_schema.tbl_preguntas_usuario ALTER COLUMN id_pregunta_usuario SET DEFAULT nextval('pfp_schema.tbl_preguntas_usuario_id_pregunta_usuario_seq'::regclass);
 \   ALTER TABLE pfp_schema.tbl_preguntas_usuario ALTER COLUMN id_pregunta_usuario DROP DEFAULT;
    
   pfp_schema            	   admin_pfp    false    272    273    273            w           2604    52451    tbl_producto id_producto    DEFAULT     �   ALTER TABLE ONLY pfp_schema.tbl_producto ALTER COLUMN id_producto SET DEFAULT nextval('pfp_schema.tbl_producto_id_producto_seq'::regclass);
 K   ALTER TABLE pfp_schema.tbl_producto ALTER COLUMN id_producto DROP DEFAULT;
    
   pfp_schema            	   admin_pfp    false    249    248    249            �           2604    52452    tbl_registro id_registro    DEFAULT     �   ALTER TABLE ONLY pfp_schema.tbl_registro ALTER COLUMN id_registro SET DEFAULT nextval('pfp_schema.tbl_registro_id_registro_seq'::regclass);
 K   ALTER TABLE pfp_schema.tbl_registro ALTER COLUMN id_registro DROP DEFAULT;
    
   pfp_schema            	   admin_pfp    false    270    271    271            ^           2604    52453    tbl_rol id_rol    DEFAULT     x   ALTER TABLE ONLY pfp_schema.tbl_rol ALTER COLUMN id_rol SET DEFAULT nextval('pfp_schema.tbl_rol_id_rol_seq'::regclass);
 A   ALTER TABLE pfp_schema.tbl_rol ALTER COLUMN id_rol DROP DEFAULT;
    
   pfp_schema            	   admin_pfp    false    230    231    231            ~           2604    52454    tbl_sucursal id_sucursal    DEFAULT     �   ALTER TABLE ONLY pfp_schema.tbl_sucursal ALTER COLUMN id_sucursal SET DEFAULT nextval('pfp_schema.tbl_sucursal_id_sucursal_seq'::regclass);
 K   ALTER TABLE pfp_schema.tbl_sucursal ALTER COLUMN id_sucursal DROP DEFAULT;
    
   pfp_schema            	   admin_pfp    false    254    255    255            q           2604    52455 "   tbl_tipo_contacto id_tipo_contacto    DEFAULT     �   ALTER TABLE ONLY pfp_schema.tbl_tipo_contacto ALTER COLUMN id_tipo_contacto SET DEFAULT nextval('pfp_schema.tbl_tipo_contacto_id_tipo_contacto_seq'::regclass);
 U   ALTER TABLE pfp_schema.tbl_tipo_contacto ALTER COLUMN id_tipo_contacto DROP DEFAULT;
    
   pfp_schema            	   admin_pfp    false    244    245    245            U           2604    52456     tbl_tipo_entidad id_tipo_entidad    DEFAULT     �   ALTER TABLE ONLY pfp_schema.tbl_tipo_entidad ALTER COLUMN id_tipo_entidad SET DEFAULT nextval('pfp_schema.tbl_tipo_entidad_id_tipo_entidad_seq'::regclass);
 S   ALTER TABLE pfp_schema.tbl_tipo_entidad ALTER COLUMN id_tipo_entidad DROP DEFAULT;
    
   pfp_schema            	   admin_pfp    false    225    224    225            X           2604    52457 "   tbl_tipo_registro id_tipo_registro    DEFAULT     �   ALTER TABLE ONLY pfp_schema.tbl_tipo_registro ALTER COLUMN id_tipo_registro SET DEFAULT nextval('pfp_schema.tbl_tipo_registro_id_tipo_registro_seq'::regclass);
 U   ALTER TABLE pfp_schema.tbl_tipo_registro ALTER COLUMN id_tipo_registro DROP DEFAULT;
    
   pfp_schema            	   admin_pfp    false    227    226    227            [           2604    52458 "   tbl_unidad_medida id_unidad_medida    DEFAULT     �   ALTER TABLE ONLY pfp_schema.tbl_unidad_medida ALTER COLUMN id_unidad_medida SET DEFAULT nextval('pfp_schema.tbl_unidad_medida_id_unidad_medida_seq'::regclass);
 U   ALTER TABLE pfp_schema.tbl_unidad_medida ALTER COLUMN id_unidad_medida DROP DEFAULT;
    
   pfp_schema            	   admin_pfp    false    229    228    229            �           2604    52459    tbl_usuario id_usuario    DEFAULT     �   ALTER TABLE ONLY pfp_schema.tbl_usuario ALTER COLUMN id_usuario SET DEFAULT nextval('pfp_schema.tbl_usuario_id_usuario_seq'::regclass);
 I   ALTER TABLE pfp_schema.tbl_usuario ALTER COLUMN id_usuario DROP DEFAULT;
    
   pfp_schema            	   admin_pfp    false    257    256    257            a           2604    52460 ,   tbl_via_administracion id_via_administracion    DEFAULT     �   ALTER TABLE ONLY pfp_schema.tbl_via_administracion ALTER COLUMN id_via_administracion SET DEFAULT nextval('pfp_schema.tbl_via_administracion_id_via_administracion_seq'::regclass);
 _   ALTER TABLE pfp_schema.tbl_via_administracion ALTER COLUMN id_via_administracion DROP DEFAULT;
    
   pfp_schema            	   admin_pfp    false    233    232    233            h           2604    52461    tbl_zona id_zona    DEFAULT     |   ALTER TABLE ONLY pfp_schema.tbl_zona ALTER COLUMN id_zona SET DEFAULT nextval('pfp_schema.tbl_zona_id_zona_seq'::regclass);
 C   ALTER TABLE pfp_schema.tbl_zona ALTER COLUMN id_zona DROP DEFAULT;
    
   pfp_schema            	   admin_pfp    false    238    239    239            �          0    26586    tbl_bitacora 
   TABLE DATA           j   COPY pfp_schema.tbl_bitacora (id_bitacora, fecha, id_usuario, id_objeto, accion, descripcion) FROM stdin;
 
   pfp_schema            	   admin_pfp    false    275    \      �          0    26492    tbl_contacto 
   TABLE DATA           �   COPY pfp_schema.tbl_contacto (id_contacto, nombre_contacto, id_usuario, id_tipo_contacto, telefono_1, telefono_2, email, id_estado, fecha_creacion, creado_por, fecha_modificacion, modificado_por) FROM stdin;
 
   pfp_schema            	   admin_pfp    false    259   \      �          0    26395    tbl_departamento 
   TABLE DATA           �   COPY pfp_schema.tbl_departamento (id_zona, id_departamento, nombre_departamento, id_estado, fecha_creacion, creado_por, fecha_modificacion, modificado_por) FROM stdin;
 
   pfp_schema            	   admin_pfp    false    241   ]      �          0    26503    tbl_distribuidor 
   TABLE DATA           �   COPY pfp_schema.tbl_distribuidor (id_distribuidor, rtn_distribuidor, nombre_distribuidor, id_pais, id_tipo_entidad, id_usuario, id_contacto, id_estado, fecha_creacion, creado_por, fecha_modificacion, modificado_por) FROM stdin;
 
   pfp_schema            	   admin_pfp    false    261   �]      �          0    26364    tbl_especialidad 
   TABLE DATA           �   COPY pfp_schema.tbl_especialidad (id_especialidad, nombre_especialidad, id_estado, fecha_creacion, creado_por, fecha_modificacion, modificado_por) FROM stdin;
 
   pfp_schema            	   admin_pfp    false    235   �]      �          0    26280 
   tbl_estado 
   TABLE DATA           ;   COPY pfp_schema.tbl_estado (id_estado, estado) FROM stdin;
 
   pfp_schema            	   admin_pfp    false    219   x^      �          0    26298    tbl_estado_canje 
   TABLE DATA           �   COPY pfp_schema.tbl_estado_canje (id_estado_canje, estado_canje, fecha_creacion, creado_por, fecha_modificacion, modificado_por) FROM stdin;
 
   pfp_schema            	   admin_pfp    false    223   �^      �          0    26541    tbl_factura 
   TABLE DATA           �   COPY pfp_schema.tbl_factura (id_factura, factura, id_paciente, id_producto, cantidad_producto, fecha_creacion, creado_por, fecha_modificacion, modificado_por) FROM stdin;
 
   pfp_schema            	   admin_pfp    false    267   _      �          0    26552    tbl_farmacia 
   TABLE DATA           �   COPY pfp_schema.tbl_farmacia (id_farmacia, rtn_farmacia, nombre_farmacia, id_sucursal, id_usuario, id_tipo_entidad, id_estado, id_contacto, fecha_creacion, creado_por, fecha_modificacion, modificado_por) FROM stdin;
 
   pfp_schema            	   admin_pfp    false    269   ��      �          0    26373    tbl_forma_farmaceutica 
   TABLE DATA           �   COPY pfp_schema.tbl_forma_farmaceutica (id_forma_farmaceutica, forma_farmaceutica, id_estado, fecha_creacion, creado_por, fecha_modificacion, modificado_por) FROM stdin;
 
   pfp_schema            	   admin_pfp    false    237   E�      �          0    26516    tbl_laboratorio 
   TABLE DATA           �   COPY pfp_schema.tbl_laboratorio (id_laboratorio, rtn_laboratorio, nombre_laboratorio, id_pais, id_tipo_entidad, id_usuario, id_contacto, id_estado, fecha_creacion, creado_por, fecha_modificacion, modificado_por) FROM stdin;
 
   pfp_schema            	   admin_pfp    false    263   ��      �          0    26450    tbl_lote_producto 
   TABLE DATA           �   COPY pfp_schema.tbl_lote_producto (id_lote_producto, lote_producto, id_producto, fecha_vencimiento, id_estado, fecha_creacion, creado_por, fecha_modificacion, modificado_por) FROM stdin;
 
   pfp_schema            	   admin_pfp    false    251   $�      �          0    26428    tbl_marca_producto 
   TABLE DATA           �   COPY pfp_schema.tbl_marca_producto (id_marca_producto, marca_producto, id_estado, fecha_creacion, creado_por, fecha_modificacion, modificado_por) FROM stdin;
 
   pfp_schema            	   admin_pfp    false    247   A�      �          0    26406    tbl_municipio 
   TABLE DATA           �   COPY pfp_schema.tbl_municipio (id_departamento, id_municipio, municipio, id_estado, fecha_creacion, creado_por, fecha_modificacion, modificado_por) FROM stdin;
 
   pfp_schema            	   admin_pfp    false    243   ��      �          0    26595 
   tbl_objeto 
   TABLE DATA           �   COPY pfp_schema.tbl_objeto (id_objeto, nombre, descripcion, id_estado, fecha_creacion, creado_por, fecha_modificacion, modificado_por) FROM stdin;
 
   pfp_schema            	   admin_pfp    false    277   K�      �          0    26529    tbl_paciente 
   TABLE DATA           	  COPY pfp_schema.tbl_paciente (id_paciente, dni_paciente, nombre_paciente, apellido_paciente, fecha_nacimiento, email, direccion, celular, tratamiento_medico, id_usuario, id_estado, fecha_creacion, creado_por, fecha_modificacion, modificado_por, genero) FROM stdin;
 
   pfp_schema            	   admin_pfp    false    265   �      �          0    26287    tbl_pais 
   TABLE DATA           �   COPY pfp_schema.tbl_pais (id_pais, nombre_pais, id_estado, fecha_creacion, creado_por, fecha_modificacion, modificado_por) FROM stdin;
 
   pfp_schema            	   admin_pfp    false    221   ��      �          0    26606    tbl_parametro 
   TABLE DATA           �   COPY pfp_schema.tbl_parametro (id_parametro, parametro, valor, id_usuario, fecha_creacion, creado_por, fecha_modificacion, modificado_por) FROM stdin;
 
   pfp_schema            	   admin_pfp    false    279   0�      �          0    26617    tbl_permiso 
   TABLE DATA           �   COPY pfp_schema.tbl_permiso (id_permiso, id_rol, id_objeto, permiso_creacion, permiso_actualizacion, permiso_eliminacion, permiso_consultar, id_estado, fecha_creacion, creado_por, fecha_modificacion, modificado_por) FROM stdin;
 
   pfp_schema            	   admin_pfp    false    281   ��      �          0    26461    tbl_preguntas 
   TABLE DATA           B   COPY pfp_schema.tbl_preguntas (id_pregunta, pregunta) FROM stdin;
 
   pfp_schema            	   admin_pfp    false    253   7�      �          0    26577    tbl_preguntas_usuario 
   TABLE DATA           _   COPY pfp_schema.tbl_preguntas_usuario (id_pregunta_usuario, id_usuario, respuesta) FROM stdin;
 
   pfp_schema            	   admin_pfp    false    273   T�      �          0    26439    tbl_producto 
   TABLE DATA           i  COPY pfp_schema.tbl_producto (id_producto, codigo_barra, nombre_producto, id_forma_farmaceutica, id_especialidad, id_marca_producto, id_unidad_medida, id_via_administracion, id_estado, id_laboratorio, escala, canje, contenido_neto, consumo_diario, consumo_max_anual, canjes_max_anual, fecha_creacion, creado_por, fecha_modificacion, modificado_por) FROM stdin;
 
   pfp_schema            	   admin_pfp    false    249   q�      �          0    26565    tbl_registro 
   TABLE DATA           �   COPY pfp_schema.tbl_registro (id_registro, fecha_registro, id_tipo_registro, id_farmacia, id_paciente, id_producto, cantidad, id_estado_canje, comentarios, fecha_creacion, creado_por, fecha_modificacion, modificado_por) FROM stdin;
 
   pfp_schema            	   admin_pfp    false    271   =�      �          0    26342    tbl_rol 
   TABLE DATA           �   COPY pfp_schema.tbl_rol (id_rol, rol, descripcion, id_estado, fecha_creacion, creado_por, fecha_modificacion, modificado_por) FROM stdin;
 
   pfp_schema            	   admin_pfp    false    231   �      �          0    26470    tbl_sucursal 
   TABLE DATA           �   COPY pfp_schema.tbl_sucursal (id_municipio, id_sucursal, nombre_sucursal, id_estado, fecha_creacion, creado_por, fecha_modificacion, modificado_por) FROM stdin;
 
   pfp_schema            	   admin_pfp    false    255   ��      �          0    26417    tbl_tipo_contacto 
   TABLE DATA           �   COPY pfp_schema.tbl_tipo_contacto (id_tipo_contacto, tipo_contacto, id_estado, fecha_creacion, creado_por, fecha_modificacion, modificado_por) FROM stdin;
 
   pfp_schema            	   admin_pfp    false    245   ��      �          0    26309    tbl_tipo_entidad 
   TABLE DATA           �   COPY pfp_schema.tbl_tipo_entidad (id_tipo_entidad, tipo_entidad, id_estado, fecha_creacion, creado_por, fecha_modificacion, modificado_por) FROM stdin;
 
   pfp_schema            	   admin_pfp    false    225   �      �          0    26320    tbl_tipo_registro 
   TABLE DATA           �   COPY pfp_schema.tbl_tipo_registro (id_tipo_registro, tipo_registro, fecha_creacion, creado_por, fecha_modificacion, modificado_por) FROM stdin;
 
   pfp_schema            	   admin_pfp    false    227   ��      �          0    26331    tbl_unidad_medida 
   TABLE DATA           �   COPY pfp_schema.tbl_unidad_medida (id_unidad_medida, unidad_medida, id_estado, fecha_creacion, creado_por, fecha_modificacion, modificado_por) FROM stdin;
 
   pfp_schema            	   admin_pfp    false    229   ��      �          0    26481    tbl_usuario 
   TABLE DATA           �   COPY pfp_schema.tbl_usuario (id_usuario, usuario, nombre_usuario, contrasena, id_rol, fecha_ultima_conexion, fecha_vencimiento, email, primer_ingreso, id_estado, fecha_creacion, creado_por, fecha_modificacion, modificado_por) FROM stdin;
 
   pfp_schema            	   admin_pfp    false    257   P�      �          0    26353    tbl_via_administracion 
   TABLE DATA           �   COPY pfp_schema.tbl_via_administracion (id_via_administracion, via_administracion, id_estado, fecha_creacion, creado_por, fecha_modificacion, modificado_por) FROM stdin;
 
   pfp_schema            	   admin_pfp    false    233   ��      �          0    26384    tbl_zona 
   TABLE DATA           �   COPY pfp_schema.tbl_zona (id_pais, id_zona, zona, id_estado, fecha_creacion, creado_por, fecha_modificacion, modificado_por) FROM stdin;
 
   pfp_schema            	   admin_pfp    false    239   \�      $           0    0    tbl_bitacora_id_bitacora_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('pfp_schema.tbl_bitacora_id_bitacora_seq', 276, true);
       
   pfp_schema            	   admin_pfp    false    274            %           0    0    tbl_contacto_id_contacto_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('pfp_schema.tbl_contacto_id_contacto_seq', 3, true);
       
   pfp_schema            	   admin_pfp    false    258            &           0    0 $   tbl_departamento_id_departamento_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('pfp_schema.tbl_departamento_id_departamento_seq', 4, true);
       
   pfp_schema            	   admin_pfp    false    240            '           0    0 $   tbl_distribuidor_id_distribuidor_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('pfp_schema.tbl_distribuidor_id_distribuidor_seq', 1, true);
       
   pfp_schema            	   admin_pfp    false    260            (           0    0 $   tbl_especialidad_id_especialidad_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('pfp_schema.tbl_especialidad_id_especialidad_seq', 3, true);
       
   pfp_schema            	   admin_pfp    false    234            )           0    0 $   tbl_estado_canje_id_estado_canje_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('pfp_schema.tbl_estado_canje_id_estado_canje_seq', 1, true);
       
   pfp_schema            	   admin_pfp    false    222            *           0    0    tbl_estado_id_estado_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('pfp_schema.tbl_estado_id_estado_seq', 1, false);
       
   pfp_schema            	   admin_pfp    false    218            +           0    0    tbl_factura_id_factura_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('pfp_schema.tbl_factura_id_factura_seq', 13, true);
       
   pfp_schema            	   admin_pfp    false    266            ,           0    0    tbl_farmacia_id_farmacia_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('pfp_schema.tbl_farmacia_id_farmacia_seq', 2, true);
       
   pfp_schema            	   admin_pfp    false    268            -           0    0 0   tbl_forma_farmaceutica_id_forma_farmaceutica_seq    SEQUENCE SET     b   SELECT pg_catalog.setval('pfp_schema.tbl_forma_farmaceutica_id_forma_farmaceutica_seq', 3, true);
       
   pfp_schema            	   admin_pfp    false    236            .           0    0 "   tbl_laboratorio_id_laboratorio_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('pfp_schema.tbl_laboratorio_id_laboratorio_seq', 3, true);
       
   pfp_schema            	   admin_pfp    false    262            /           0    0 &   tbl_lote_producto_id_lote_producto_seq    SEQUENCE SET     Y   SELECT pg_catalog.setval('pfp_schema.tbl_lote_producto_id_lote_producto_seq', 1, false);
       
   pfp_schema            	   admin_pfp    false    250            0           0    0 (   tbl_marca_producto_id_marca_producto_seq    SEQUENCE SET     Z   SELECT pg_catalog.setval('pfp_schema.tbl_marca_producto_id_marca_producto_seq', 5, true);
       
   pfp_schema            	   admin_pfp    false    246            1           0    0    tbl_municipio_id_municipio_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('pfp_schema.tbl_municipio_id_municipio_seq', 3, true);
       
   pfp_schema            	   admin_pfp    false    242            2           0    0    tbl_objeto_id_objeto_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('pfp_schema.tbl_objeto_id_objeto_seq', 4, true);
       
   pfp_schema            	   admin_pfp    false    276            3           0    0    tbl_paciente_id_paciente_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('pfp_schema.tbl_paciente_id_paciente_seq', 7, true);
       
   pfp_schema            	   admin_pfp    false    264            4           0    0    tbl_pais_id_pais_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('pfp_schema.tbl_pais_id_pais_seq', 4, true);
       
   pfp_schema            	   admin_pfp    false    220            5           0    0    tbl_parametro_id_parametro_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('pfp_schema.tbl_parametro_id_parametro_seq', 5, true);
       
   pfp_schema            	   admin_pfp    false    278            6           0    0    tbl_permiso_id_permiso_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('pfp_schema.tbl_permiso_id_permiso_seq', 27, true);
       
   pfp_schema            	   admin_pfp    false    280            7           0    0    tbl_preguntas_id_pregunta_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('pfp_schema.tbl_preguntas_id_pregunta_seq', 1, false);
       
   pfp_schema            	   admin_pfp    false    252            8           0    0 -   tbl_preguntas_usuario_id_pregunta_usuario_seq    SEQUENCE SET     `   SELECT pg_catalog.setval('pfp_schema.tbl_preguntas_usuario_id_pregunta_usuario_seq', 1, false);
       
   pfp_schema            	   admin_pfp    false    272            9           0    0    tbl_producto_id_producto_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('pfp_schema.tbl_producto_id_producto_seq', 4, true);
       
   pfp_schema            	   admin_pfp    false    248            :           0    0    tbl_registro_id_registro_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('pfp_schema.tbl_registro_id_registro_seq', 5, true);
       
   pfp_schema            	   admin_pfp    false    270            ;           0    0    tbl_rol_id_rol_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('pfp_schema.tbl_rol_id_rol_seq', 7, true);
       
   pfp_schema            	   admin_pfp    false    230            <           0    0    tbl_sucursal_id_sucursal_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('pfp_schema.tbl_sucursal_id_sucursal_seq', 4, true);
       
   pfp_schema            	   admin_pfp    false    254            =           0    0 &   tbl_tipo_contacto_id_tipo_contacto_seq    SEQUENCE SET     X   SELECT pg_catalog.setval('pfp_schema.tbl_tipo_contacto_id_tipo_contacto_seq', 4, true);
       
   pfp_schema            	   admin_pfp    false    244            >           0    0 $   tbl_tipo_entidad_id_tipo_entidad_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('pfp_schema.tbl_tipo_entidad_id_tipo_entidad_seq', 4, true);
       
   pfp_schema            	   admin_pfp    false    224            ?           0    0 &   tbl_tipo_registro_id_tipo_registro_seq    SEQUENCE SET     X   SELECT pg_catalog.setval('pfp_schema.tbl_tipo_registro_id_tipo_registro_seq', 1, true);
       
   pfp_schema            	   admin_pfp    false    226            @           0    0 &   tbl_unidad_medida_id_unidad_medida_seq    SEQUENCE SET     X   SELECT pg_catalog.setval('pfp_schema.tbl_unidad_medida_id_unidad_medida_seq', 3, true);
       
   pfp_schema            	   admin_pfp    false    228            A           0    0    tbl_usuario_id_usuario_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('pfp_schema.tbl_usuario_id_usuario_seq', 35, true);
       
   pfp_schema            	   admin_pfp    false    256            B           0    0 0   tbl_via_administracion_id_via_administracion_seq    SEQUENCE SET     b   SELECT pg_catalog.setval('pfp_schema.tbl_via_administracion_id_via_administracion_seq', 2, true);
       
   pfp_schema            	   admin_pfp    false    232            C           0    0    tbl_zona_id_zona_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('pfp_schema.tbl_zona_id_zona_seq', 6, true);
       
   pfp_schema            	   admin_pfp    false    238            �           2606    26593    tbl_bitacora tbl_bitacora_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY pfp_schema.tbl_bitacora
    ADD CONSTRAINT tbl_bitacora_pkey PRIMARY KEY (id_bitacora);
 L   ALTER TABLE ONLY pfp_schema.tbl_bitacora DROP CONSTRAINT tbl_bitacora_pkey;
    
   pfp_schema              	   admin_pfp    false    275            �           2606    26501    tbl_contacto tbl_contacto_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY pfp_schema.tbl_contacto
    ADD CONSTRAINT tbl_contacto_pkey PRIMARY KEY (id_contacto);
 L   ALTER TABLE ONLY pfp_schema.tbl_contacto DROP CONSTRAINT tbl_contacto_pkey;
    
   pfp_schema              	   admin_pfp    false    259            �           2606    26404 &   tbl_departamento tbl_departamento_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY pfp_schema.tbl_departamento
    ADD CONSTRAINT tbl_departamento_pkey PRIMARY KEY (id_departamento);
 T   ALTER TABLE ONLY pfp_schema.tbl_departamento DROP CONSTRAINT tbl_departamento_pkey;
    
   pfp_schema              	   admin_pfp    false    241            �           2606    26512 &   tbl_distribuidor tbl_distribuidor_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY pfp_schema.tbl_distribuidor
    ADD CONSTRAINT tbl_distribuidor_pkey PRIMARY KEY (id_distribuidor);
 T   ALTER TABLE ONLY pfp_schema.tbl_distribuidor DROP CONSTRAINT tbl_distribuidor_pkey;
    
   pfp_schema              	   admin_pfp    false    261            �           2606    26514 6   tbl_distribuidor tbl_distribuidor_rtn_distribuidor_key 
   CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_distribuidor
    ADD CONSTRAINT tbl_distribuidor_rtn_distribuidor_key UNIQUE (rtn_distribuidor);
 d   ALTER TABLE ONLY pfp_schema.tbl_distribuidor DROP CONSTRAINT tbl_distribuidor_rtn_distribuidor_key;
    
   pfp_schema              	   admin_pfp    false    261            �           2606    26371 &   tbl_especialidad tbl_especialidad_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY pfp_schema.tbl_especialidad
    ADD CONSTRAINT tbl_especialidad_pkey PRIMARY KEY (id_especialidad);
 T   ALTER TABLE ONLY pfp_schema.tbl_especialidad DROP CONSTRAINT tbl_especialidad_pkey;
    
   pfp_schema              	   admin_pfp    false    235            �           2606    26307 &   tbl_estado_canje tbl_estado_canje_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY pfp_schema.tbl_estado_canje
    ADD CONSTRAINT tbl_estado_canje_pkey PRIMARY KEY (id_estado_canje);
 T   ALTER TABLE ONLY pfp_schema.tbl_estado_canje DROP CONSTRAINT tbl_estado_canje_pkey;
    
   pfp_schema              	   admin_pfp    false    223            �           2606    26285    tbl_estado tbl_estado_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY pfp_schema.tbl_estado
    ADD CONSTRAINT tbl_estado_pkey PRIMARY KEY (id_estado);
 H   ALTER TABLE ONLY pfp_schema.tbl_estado DROP CONSTRAINT tbl_estado_pkey;
    
   pfp_schema              	   admin_pfp    false    219            �           2606    26550    tbl_factura tbl_factura_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY pfp_schema.tbl_factura
    ADD CONSTRAINT tbl_factura_pkey PRIMARY KEY (id_factura);
 J   ALTER TABLE ONLY pfp_schema.tbl_factura DROP CONSTRAINT tbl_factura_pkey;
    
   pfp_schema              	   admin_pfp    false    267            �           2606    26561    tbl_farmacia tbl_farmacia_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY pfp_schema.tbl_farmacia
    ADD CONSTRAINT tbl_farmacia_pkey PRIMARY KEY (id_farmacia);
 L   ALTER TABLE ONLY pfp_schema.tbl_farmacia DROP CONSTRAINT tbl_farmacia_pkey;
    
   pfp_schema              	   admin_pfp    false    269            �           2606    26563 *   tbl_farmacia tbl_farmacia_rtn_farmacia_key 
   CONSTRAINT     q   ALTER TABLE ONLY pfp_schema.tbl_farmacia
    ADD CONSTRAINT tbl_farmacia_rtn_farmacia_key UNIQUE (rtn_farmacia);
 X   ALTER TABLE ONLY pfp_schema.tbl_farmacia DROP CONSTRAINT tbl_farmacia_rtn_farmacia_key;
    
   pfp_schema              	   admin_pfp    false    269            �           2606    26382 2   tbl_forma_farmaceutica tbl_forma_farmaceutica_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_forma_farmaceutica
    ADD CONSTRAINT tbl_forma_farmaceutica_pkey PRIMARY KEY (id_forma_farmaceutica);
 `   ALTER TABLE ONLY pfp_schema.tbl_forma_farmaceutica DROP CONSTRAINT tbl_forma_farmaceutica_pkey;
    
   pfp_schema              	   admin_pfp    false    237            �           2606    26525 $   tbl_laboratorio tbl_laboratorio_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY pfp_schema.tbl_laboratorio
    ADD CONSTRAINT tbl_laboratorio_pkey PRIMARY KEY (id_laboratorio);
 R   ALTER TABLE ONLY pfp_schema.tbl_laboratorio DROP CONSTRAINT tbl_laboratorio_pkey;
    
   pfp_schema              	   admin_pfp    false    263            �           2606    26527 3   tbl_laboratorio tbl_laboratorio_rtn_laboratorio_key 
   CONSTRAINT     }   ALTER TABLE ONLY pfp_schema.tbl_laboratorio
    ADD CONSTRAINT tbl_laboratorio_rtn_laboratorio_key UNIQUE (rtn_laboratorio);
 a   ALTER TABLE ONLY pfp_schema.tbl_laboratorio DROP CONSTRAINT tbl_laboratorio_rtn_laboratorio_key;
    
   pfp_schema              	   admin_pfp    false    263            �           2606    26459 (   tbl_lote_producto tbl_lote_producto_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY pfp_schema.tbl_lote_producto
    ADD CONSTRAINT tbl_lote_producto_pkey PRIMARY KEY (id_lote_producto);
 V   ALTER TABLE ONLY pfp_schema.tbl_lote_producto DROP CONSTRAINT tbl_lote_producto_pkey;
    
   pfp_schema              	   admin_pfp    false    251            �           2606    26437 *   tbl_marca_producto tbl_marca_producto_pkey 
   CONSTRAINT     {   ALTER TABLE ONLY pfp_schema.tbl_marca_producto
    ADD CONSTRAINT tbl_marca_producto_pkey PRIMARY KEY (id_marca_producto);
 X   ALTER TABLE ONLY pfp_schema.tbl_marca_producto DROP CONSTRAINT tbl_marca_producto_pkey;
    
   pfp_schema              	   admin_pfp    false    247            �           2606    26415     tbl_municipio tbl_municipio_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY pfp_schema.tbl_municipio
    ADD CONSTRAINT tbl_municipio_pkey PRIMARY KEY (id_municipio);
 N   ALTER TABLE ONLY pfp_schema.tbl_municipio DROP CONSTRAINT tbl_municipio_pkey;
    
   pfp_schema              	   admin_pfp    false    243            �           2606    26604    tbl_objeto tbl_objeto_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY pfp_schema.tbl_objeto
    ADD CONSTRAINT tbl_objeto_pkey PRIMARY KEY (id_objeto);
 H   ALTER TABLE ONLY pfp_schema.tbl_objeto DROP CONSTRAINT tbl_objeto_pkey;
    
   pfp_schema              	   admin_pfp    false    277            �           2606    26539    tbl_paciente tbl_paciente_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY pfp_schema.tbl_paciente
    ADD CONSTRAINT tbl_paciente_pkey PRIMARY KEY (id_paciente);
 L   ALTER TABLE ONLY pfp_schema.tbl_paciente DROP CONSTRAINT tbl_paciente_pkey;
    
   pfp_schema              	   admin_pfp    false    265            �           2606    26296    tbl_pais tbl_pais_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY pfp_schema.tbl_pais
    ADD CONSTRAINT tbl_pais_pkey PRIMARY KEY (id_pais);
 D   ALTER TABLE ONLY pfp_schema.tbl_pais DROP CONSTRAINT tbl_pais_pkey;
    
   pfp_schema              	   admin_pfp    false    221            �           2606    26615     tbl_parametro tbl_parametro_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY pfp_schema.tbl_parametro
    ADD CONSTRAINT tbl_parametro_pkey PRIMARY KEY (id_parametro);
 N   ALTER TABLE ONLY pfp_schema.tbl_parametro DROP CONSTRAINT tbl_parametro_pkey;
    
   pfp_schema              	   admin_pfp    false    279            �           2606    26626    tbl_permiso tbl_permiso_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY pfp_schema.tbl_permiso
    ADD CONSTRAINT tbl_permiso_pkey PRIMARY KEY (id_permiso);
 J   ALTER TABLE ONLY pfp_schema.tbl_permiso DROP CONSTRAINT tbl_permiso_pkey;
    
   pfp_schema              	   admin_pfp    false    281            �           2606    26468     tbl_preguntas tbl_preguntas_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY pfp_schema.tbl_preguntas
    ADD CONSTRAINT tbl_preguntas_pkey PRIMARY KEY (id_pregunta);
 N   ALTER TABLE ONLY pfp_schema.tbl_preguntas DROP CONSTRAINT tbl_preguntas_pkey;
    
   pfp_schema              	   admin_pfp    false    253            �           2606    26584 0   tbl_preguntas_usuario tbl_preguntas_usuario_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_preguntas_usuario
    ADD CONSTRAINT tbl_preguntas_usuario_pkey PRIMARY KEY (id_pregunta_usuario);
 ^   ALTER TABLE ONLY pfp_schema.tbl_preguntas_usuario DROP CONSTRAINT tbl_preguntas_usuario_pkey;
    
   pfp_schema              	   admin_pfp    false    273            �           2606    26448    tbl_producto tbl_producto_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY pfp_schema.tbl_producto
    ADD CONSTRAINT tbl_producto_pkey PRIMARY KEY (id_producto);
 L   ALTER TABLE ONLY pfp_schema.tbl_producto DROP CONSTRAINT tbl_producto_pkey;
    
   pfp_schema              	   admin_pfp    false    249            �           2606    26575    tbl_registro tbl_registro_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY pfp_schema.tbl_registro
    ADD CONSTRAINT tbl_registro_pkey PRIMARY KEY (id_registro);
 L   ALTER TABLE ONLY pfp_schema.tbl_registro DROP CONSTRAINT tbl_registro_pkey;
    
   pfp_schema              	   admin_pfp    false    271            �           2606    26351    tbl_rol tbl_rol_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY pfp_schema.tbl_rol
    ADD CONSTRAINT tbl_rol_pkey PRIMARY KEY (id_rol);
 B   ALTER TABLE ONLY pfp_schema.tbl_rol DROP CONSTRAINT tbl_rol_pkey;
    
   pfp_schema              	   admin_pfp    false    231            �           2606    26479    tbl_sucursal tbl_sucursal_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY pfp_schema.tbl_sucursal
    ADD CONSTRAINT tbl_sucursal_pkey PRIMARY KEY (id_sucursal);
 L   ALTER TABLE ONLY pfp_schema.tbl_sucursal DROP CONSTRAINT tbl_sucursal_pkey;
    
   pfp_schema              	   admin_pfp    false    255            �           2606    26426 (   tbl_tipo_contacto tbl_tipo_contacto_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY pfp_schema.tbl_tipo_contacto
    ADD CONSTRAINT tbl_tipo_contacto_pkey PRIMARY KEY (id_tipo_contacto);
 V   ALTER TABLE ONLY pfp_schema.tbl_tipo_contacto DROP CONSTRAINT tbl_tipo_contacto_pkey;
    
   pfp_schema              	   admin_pfp    false    245            �           2606    26318 &   tbl_tipo_entidad tbl_tipo_entidad_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY pfp_schema.tbl_tipo_entidad
    ADD CONSTRAINT tbl_tipo_entidad_pkey PRIMARY KEY (id_tipo_entidad);
 T   ALTER TABLE ONLY pfp_schema.tbl_tipo_entidad DROP CONSTRAINT tbl_tipo_entidad_pkey;
    
   pfp_schema              	   admin_pfp    false    225            �           2606    26329 (   tbl_tipo_registro tbl_tipo_registro_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY pfp_schema.tbl_tipo_registro
    ADD CONSTRAINT tbl_tipo_registro_pkey PRIMARY KEY (id_tipo_registro);
 V   ALTER TABLE ONLY pfp_schema.tbl_tipo_registro DROP CONSTRAINT tbl_tipo_registro_pkey;
    
   pfp_schema              	   admin_pfp    false    227            �           2606    26340 (   tbl_unidad_medida tbl_unidad_medida_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY pfp_schema.tbl_unidad_medida
    ADD CONSTRAINT tbl_unidad_medida_pkey PRIMARY KEY (id_unidad_medida);
 V   ALTER TABLE ONLY pfp_schema.tbl_unidad_medida DROP CONSTRAINT tbl_unidad_medida_pkey;
    
   pfp_schema              	   admin_pfp    false    229            �           2606    26490    tbl_usuario tbl_usuario_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY pfp_schema.tbl_usuario
    ADD CONSTRAINT tbl_usuario_pkey PRIMARY KEY (id_usuario);
 J   ALTER TABLE ONLY pfp_schema.tbl_usuario DROP CONSTRAINT tbl_usuario_pkey;
    
   pfp_schema              	   admin_pfp    false    257            �           2606    26362 2   tbl_via_administracion tbl_via_administracion_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_via_administracion
    ADD CONSTRAINT tbl_via_administracion_pkey PRIMARY KEY (id_via_administracion);
 `   ALTER TABLE ONLY pfp_schema.tbl_via_administracion DROP CONSTRAINT tbl_via_administracion_pkey;
    
   pfp_schema              	   admin_pfp    false    233            �           2606    26393    tbl_zona tbl_zona_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY pfp_schema.tbl_zona
    ADD CONSTRAINT tbl_zona_pkey PRIMARY KEY (id_zona);
 D   ALTER TABLE ONLY pfp_schema.tbl_zona DROP CONSTRAINT tbl_zona_pkey;
    
   pfp_schema              	   admin_pfp    false    239            �           2606    36010    tbl_paciente validar_duplicados 
   CONSTRAINT     v   ALTER TABLE ONLY pfp_schema.tbl_paciente
    ADD CONSTRAINT validar_duplicados UNIQUE (dni_paciente, email, celular);
 M   ALTER TABLE ONLY pfp_schema.tbl_paciente DROP CONSTRAINT validar_duplicados;
    
   pfp_schema              	   admin_pfp    false    265    265    265                       2606    26887    tbl_factura fk_factura_producto    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_factura
    ADD CONSTRAINT fk_factura_producto FOREIGN KEY (id_producto) REFERENCES pfp_schema.tbl_producto(id_producto);
 M   ALTER TABLE ONLY pfp_schema.tbl_factura DROP CONSTRAINT fk_factura_producto;
    
   pfp_schema            	   admin_pfp    false    5061    249    267            �           2606    26752 $   tbl_producto fk_producto_laboratorio    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_producto
    ADD CONSTRAINT fk_producto_laboratorio FOREIGN KEY (id_laboratorio) REFERENCES pfp_schema.tbl_laboratorio(id_laboratorio);
 R   ALTER TABLE ONLY pfp_schema.tbl_producto DROP CONSTRAINT fk_producto_laboratorio;
    
   pfp_schema            	   admin_pfp    false    5077    263    249            &           2606    26712 #   tbl_bitacora fk_tbl_bitacora_objeto    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_bitacora
    ADD CONSTRAINT fk_tbl_bitacora_objeto FOREIGN KEY (id_objeto) REFERENCES pfp_schema.tbl_objeto(id_objeto);
 Q   ALTER TABLE ONLY pfp_schema.tbl_bitacora DROP CONSTRAINT fk_tbl_bitacora_objeto;
    
   pfp_schema            	   admin_pfp    false    277    5097    275            '           2606    26707 $   tbl_bitacora fk_tbl_bitacora_usuario    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_bitacora
    ADD CONSTRAINT fk_tbl_bitacora_usuario FOREIGN KEY (id_usuario) REFERENCES pfp_schema.tbl_usuario(id_usuario);
 R   ALTER TABLE ONLY pfp_schema.tbl_bitacora DROP CONSTRAINT fk_tbl_bitacora_usuario;
    
   pfp_schema            	   admin_pfp    false    275    257    5069            
           2606    26777 #   tbl_contacto fk_tbl_contacto_estado    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_contacto
    ADD CONSTRAINT fk_tbl_contacto_estado FOREIGN KEY (id_estado) REFERENCES pfp_schema.tbl_estado(id_estado);
 Q   ALTER TABLE ONLY pfp_schema.tbl_contacto DROP CONSTRAINT fk_tbl_contacto_estado;
    
   pfp_schema            	   admin_pfp    false    5031    259    219                       2606    26772 *   tbl_contacto fk_tbl_contacto_tipo_contacto    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_contacto
    ADD CONSTRAINT fk_tbl_contacto_tipo_contacto FOREIGN KEY (id_tipo_contacto) REFERENCES pfp_schema.tbl_tipo_contacto(id_tipo_contacto);
 X   ALTER TABLE ONLY pfp_schema.tbl_contacto DROP CONSTRAINT fk_tbl_contacto_tipo_contacto;
    
   pfp_schema            	   admin_pfp    false    259    245    5057                       2606    26767 $   tbl_contacto fk_tbl_contacto_usuario    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_contacto
    ADD CONSTRAINT fk_tbl_contacto_usuario FOREIGN KEY (id_usuario) REFERENCES pfp_schema.tbl_usuario(id_usuario);
 R   ALTER TABLE ONLY pfp_schema.tbl_contacto DROP CONSTRAINT fk_tbl_contacto_usuario;
    
   pfp_schema            	   admin_pfp    false    5069    259    257            �           2606    26647 +   tbl_departamento fk_tbl_departamento_estado    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_departamento
    ADD CONSTRAINT fk_tbl_departamento_estado FOREIGN KEY (id_estado) REFERENCES pfp_schema.tbl_estado(id_estado);
 Y   ALTER TABLE ONLY pfp_schema.tbl_departamento DROP CONSTRAINT fk_tbl_departamento_estado;
    
   pfp_schema            	   admin_pfp    false    5031    219    241            �           2606    26642 )   tbl_departamento fk_tbl_departamento_zona    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_departamento
    ADD CONSTRAINT fk_tbl_departamento_zona FOREIGN KEY (id_zona) REFERENCES pfp_schema.tbl_zona(id_zona);
 W   ALTER TABLE ONLY pfp_schema.tbl_departamento DROP CONSTRAINT fk_tbl_departamento_zona;
    
   pfp_schema            	   admin_pfp    false    241    5051    239                       2606    26797 -   tbl_distribuidor fk_tbl_distribuidor_contacto    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_distribuidor
    ADD CONSTRAINT fk_tbl_distribuidor_contacto FOREIGN KEY (id_contacto) REFERENCES pfp_schema.tbl_contacto(id_contacto);
 [   ALTER TABLE ONLY pfp_schema.tbl_distribuidor DROP CONSTRAINT fk_tbl_distribuidor_contacto;
    
   pfp_schema            	   admin_pfp    false    5071    261    259                       2606    26802 +   tbl_distribuidor fk_tbl_distribuidor_estado    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_distribuidor
    ADD CONSTRAINT fk_tbl_distribuidor_estado FOREIGN KEY (id_estado) REFERENCES pfp_schema.tbl_estado(id_estado);
 Y   ALTER TABLE ONLY pfp_schema.tbl_distribuidor DROP CONSTRAINT fk_tbl_distribuidor_estado;
    
   pfp_schema            	   admin_pfp    false    5031    261    219                       2606    26782 )   tbl_distribuidor fk_tbl_distribuidor_pais    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_distribuidor
    ADD CONSTRAINT fk_tbl_distribuidor_pais FOREIGN KEY (id_pais) REFERENCES pfp_schema.tbl_pais(id_pais);
 W   ALTER TABLE ONLY pfp_schema.tbl_distribuidor DROP CONSTRAINT fk_tbl_distribuidor_pais;
    
   pfp_schema            	   admin_pfp    false    221    5033    261                       2606    26787 1   tbl_distribuidor fk_tbl_distribuidor_tipo_entidad    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_distribuidor
    ADD CONSTRAINT fk_tbl_distribuidor_tipo_entidad FOREIGN KEY (id_tipo_entidad) REFERENCES pfp_schema.tbl_tipo_entidad(id_tipo_entidad);
 _   ALTER TABLE ONLY pfp_schema.tbl_distribuidor DROP CONSTRAINT fk_tbl_distribuidor_tipo_entidad;
    
   pfp_schema            	   admin_pfp    false    225    5037    261                       2606    26792 ,   tbl_distribuidor fk_tbl_distribuidor_usuario    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_distribuidor
    ADD CONSTRAINT fk_tbl_distribuidor_usuario FOREIGN KEY (id_usuario) REFERENCES pfp_schema.tbl_usuario(id_usuario);
 Z   ALTER TABLE ONLY pfp_schema.tbl_distribuidor DROP CONSTRAINT fk_tbl_distribuidor_usuario;
    
   pfp_schema            	   admin_pfp    false    257    5069    261            �           2606    26692 +   tbl_especialidad fk_tbl_especialidad_estado    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_especialidad
    ADD CONSTRAINT fk_tbl_especialidad_estado FOREIGN KEY (id_estado) REFERENCES pfp_schema.tbl_estado(id_estado);
 Y   ALTER TABLE ONLY pfp_schema.tbl_especialidad DROP CONSTRAINT fk_tbl_especialidad_estado;
    
   pfp_schema            	   admin_pfp    false    235    5031    219                       2606    26882 #   tbl_factura fk_tbl_factura_paciente    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_factura
    ADD CONSTRAINT fk_tbl_factura_paciente FOREIGN KEY (id_paciente) REFERENCES pfp_schema.tbl_paciente(id_paciente);
 Q   ALTER TABLE ONLY pfp_schema.tbl_factura DROP CONSTRAINT fk_tbl_factura_paciente;
    
   pfp_schema            	   admin_pfp    false    267    5081    265                       2606    26912 %   tbl_farmacia fk_tbl_farmacia_contacto    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_farmacia
    ADD CONSTRAINT fk_tbl_farmacia_contacto FOREIGN KEY (id_contacto) REFERENCES pfp_schema.tbl_contacto(id_contacto);
 S   ALTER TABLE ONLY pfp_schema.tbl_farmacia DROP CONSTRAINT fk_tbl_farmacia_contacto;
    
   pfp_schema            	   admin_pfp    false    5071    259    269                       2606    26907 #   tbl_farmacia fk_tbl_farmacia_estado    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_farmacia
    ADD CONSTRAINT fk_tbl_farmacia_estado FOREIGN KEY (id_estado) REFERENCES pfp_schema.tbl_estado(id_estado);
 Q   ALTER TABLE ONLY pfp_schema.tbl_farmacia DROP CONSTRAINT fk_tbl_farmacia_estado;
    
   pfp_schema            	   admin_pfp    false    5031    269    219                       2606    26892 %   tbl_farmacia fk_tbl_farmacia_sucursal    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_farmacia
    ADD CONSTRAINT fk_tbl_farmacia_sucursal FOREIGN KEY (id_sucursal) REFERENCES pfp_schema.tbl_sucursal(id_sucursal);
 S   ALTER TABLE ONLY pfp_schema.tbl_farmacia DROP CONSTRAINT fk_tbl_farmacia_sucursal;
    
   pfp_schema            	   admin_pfp    false    269    5067    255                       2606    26902 )   tbl_farmacia fk_tbl_farmacia_tipo_entidad    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_farmacia
    ADD CONSTRAINT fk_tbl_farmacia_tipo_entidad FOREIGN KEY (id_tipo_entidad) REFERENCES pfp_schema.tbl_tipo_entidad(id_tipo_entidad);
 W   ALTER TABLE ONLY pfp_schema.tbl_farmacia DROP CONSTRAINT fk_tbl_farmacia_tipo_entidad;
    
   pfp_schema            	   admin_pfp    false    5037    269    225                       2606    26897 $   tbl_farmacia fk_tbl_farmacia_usuario    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_farmacia
    ADD CONSTRAINT fk_tbl_farmacia_usuario FOREIGN KEY (id_usuario) REFERENCES pfp_schema.tbl_usuario(id_usuario);
 R   ALTER TABLE ONLY pfp_schema.tbl_farmacia DROP CONSTRAINT fk_tbl_farmacia_usuario;
    
   pfp_schema            	   admin_pfp    false    5069    269    257            �           2606    26697 7   tbl_forma_farmaceutica fk_tbl_forma_farmaceutica_estado    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_forma_farmaceutica
    ADD CONSTRAINT fk_tbl_forma_farmaceutica_estado FOREIGN KEY (id_estado) REFERENCES pfp_schema.tbl_estado(id_estado);
 e   ALTER TABLE ONLY pfp_schema.tbl_forma_farmaceutica DROP CONSTRAINT fk_tbl_forma_farmaceutica_estado;
    
   pfp_schema            	   admin_pfp    false    5031    219    237                       2606    26822 +   tbl_laboratorio fk_tbl_laboratorio_contacto    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_laboratorio
    ADD CONSTRAINT fk_tbl_laboratorio_contacto FOREIGN KEY (id_contacto) REFERENCES pfp_schema.tbl_contacto(id_contacto);
 Y   ALTER TABLE ONLY pfp_schema.tbl_laboratorio DROP CONSTRAINT fk_tbl_laboratorio_contacto;
    
   pfp_schema            	   admin_pfp    false    259    263    5071                       2606    26827 )   tbl_laboratorio fk_tbl_laboratorio_estado    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_laboratorio
    ADD CONSTRAINT fk_tbl_laboratorio_estado FOREIGN KEY (id_estado) REFERENCES pfp_schema.tbl_estado(id_estado);
 W   ALTER TABLE ONLY pfp_schema.tbl_laboratorio DROP CONSTRAINT fk_tbl_laboratorio_estado;
    
   pfp_schema            	   admin_pfp    false    219    263    5031                       2606    26807 '   tbl_laboratorio fk_tbl_laboratorio_pais    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_laboratorio
    ADD CONSTRAINT fk_tbl_laboratorio_pais FOREIGN KEY (id_pais) REFERENCES pfp_schema.tbl_pais(id_pais);
 U   ALTER TABLE ONLY pfp_schema.tbl_laboratorio DROP CONSTRAINT fk_tbl_laboratorio_pais;
    
   pfp_schema            	   admin_pfp    false    5033    263    221                       2606    26812 /   tbl_laboratorio fk_tbl_laboratorio_tipo_entidad    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_laboratorio
    ADD CONSTRAINT fk_tbl_laboratorio_tipo_entidad FOREIGN KEY (id_tipo_entidad) REFERENCES pfp_schema.tbl_tipo_entidad(id_tipo_entidad);
 ]   ALTER TABLE ONLY pfp_schema.tbl_laboratorio DROP CONSTRAINT fk_tbl_laboratorio_tipo_entidad;
    
   pfp_schema            	   admin_pfp    false    5037    263    225                       2606    26817 *   tbl_laboratorio fk_tbl_laboratorio_usuario    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_laboratorio
    ADD CONSTRAINT fk_tbl_laboratorio_usuario FOREIGN KEY (id_usuario) REFERENCES pfp_schema.tbl_usuario(id_usuario);
 X   ALTER TABLE ONLY pfp_schema.tbl_laboratorio DROP CONSTRAINT fk_tbl_laboratorio_usuario;
    
   pfp_schema            	   admin_pfp    false    257    5069    263                       2606    26837 -   tbl_lote_producto fk_tbl_lote_producto_estado    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_lote_producto
    ADD CONSTRAINT fk_tbl_lote_producto_estado FOREIGN KEY (id_estado) REFERENCES pfp_schema.tbl_estado(id_estado);
 [   ALTER TABLE ONLY pfp_schema.tbl_lote_producto DROP CONSTRAINT fk_tbl_lote_producto_estado;
    
   pfp_schema            	   admin_pfp    false    219    251    5031                       2606    26832 /   tbl_lote_producto fk_tbl_lote_producto_producto    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_lote_producto
    ADD CONSTRAINT fk_tbl_lote_producto_producto FOREIGN KEY (id_producto) REFERENCES pfp_schema.tbl_producto(id_producto);
 ]   ALTER TABLE ONLY pfp_schema.tbl_lote_producto DROP CONSTRAINT fk_tbl_lote_producto_producto;
    
   pfp_schema            	   admin_pfp    false    249    251    5061            �           2606    26702 /   tbl_marca_producto fk_tbl_marca_producto_estado    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_marca_producto
    ADD CONSTRAINT fk_tbl_marca_producto_estado FOREIGN KEY (id_estado) REFERENCES pfp_schema.tbl_estado(id_estado);
 ]   ALTER TABLE ONLY pfp_schema.tbl_marca_producto DROP CONSTRAINT fk_tbl_marca_producto_estado;
    
   pfp_schema            	   admin_pfp    false    5031    219    247            �           2606    26652 +   tbl_municipio fk_tbl_municipio_departamento    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_municipio
    ADD CONSTRAINT fk_tbl_municipio_departamento FOREIGN KEY (id_departamento) REFERENCES pfp_schema.tbl_departamento(id_departamento);
 Y   ALTER TABLE ONLY pfp_schema.tbl_municipio DROP CONSTRAINT fk_tbl_municipio_departamento;
    
   pfp_schema            	   admin_pfp    false    5053    241    243            �           2606    26657 %   tbl_municipio fk_tbl_municipio_estado    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_municipio
    ADD CONSTRAINT fk_tbl_municipio_estado FOREIGN KEY (id_estado) REFERENCES pfp_schema.tbl_estado(id_estado);
 S   ALTER TABLE ONLY pfp_schema.tbl_municipio DROP CONSTRAINT fk_tbl_municipio_estado;
    
   pfp_schema            	   admin_pfp    false    219    243    5031            (           2606    26717    tbl_objeto fk_tbl_objeto_estado    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_objeto
    ADD CONSTRAINT fk_tbl_objeto_estado FOREIGN KEY (id_estado) REFERENCES pfp_schema.tbl_estado(id_estado);
 M   ALTER TABLE ONLY pfp_schema.tbl_objeto DROP CONSTRAINT fk_tbl_objeto_estado;
    
   pfp_schema            	   admin_pfp    false    5031    219    277                       2606    26847 #   tbl_paciente fk_tbl_paciente_estado    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_paciente
    ADD CONSTRAINT fk_tbl_paciente_estado FOREIGN KEY (id_estado) REFERENCES pfp_schema.tbl_estado(id_estado);
 Q   ALTER TABLE ONLY pfp_schema.tbl_paciente DROP CONSTRAINT fk_tbl_paciente_estado;
    
   pfp_schema            	   admin_pfp    false    265    5031    219                       2606    26842 $   tbl_paciente fk_tbl_paciente_usuario    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_paciente
    ADD CONSTRAINT fk_tbl_paciente_usuario FOREIGN KEY (id_usuario) REFERENCES pfp_schema.tbl_usuario(id_usuario);
 R   ALTER TABLE ONLY pfp_schema.tbl_paciente DROP CONSTRAINT fk_tbl_paciente_usuario;
    
   pfp_schema            	   admin_pfp    false    257    265    5069            �           2606    26627    tbl_pais fk_tbl_pais_estado    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_pais
    ADD CONSTRAINT fk_tbl_pais_estado FOREIGN KEY (id_estado) REFERENCES pfp_schema.tbl_estado(id_estado);
 I   ALTER TABLE ONLY pfp_schema.tbl_pais DROP CONSTRAINT fk_tbl_pais_estado;
    
   pfp_schema            	   admin_pfp    false    219    5031    221            )           2606    26852 &   tbl_parametro fk_tbl_parametro_usuario    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_parametro
    ADD CONSTRAINT fk_tbl_parametro_usuario FOREIGN KEY (id_usuario) REFERENCES pfp_schema.tbl_usuario(id_usuario);
 T   ALTER TABLE ONLY pfp_schema.tbl_parametro DROP CONSTRAINT fk_tbl_parametro_usuario;
    
   pfp_schema            	   admin_pfp    false    257    279    5069            *           2606    26857 !   tbl_permiso fk_tbl_permiso_estado    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_permiso
    ADD CONSTRAINT fk_tbl_permiso_estado FOREIGN KEY (id_estado) REFERENCES pfp_schema.tbl_estado(id_estado);
 O   ALTER TABLE ONLY pfp_schema.tbl_permiso DROP CONSTRAINT fk_tbl_permiso_estado;
    
   pfp_schema            	   admin_pfp    false    219    281    5031            +           2606    26867 !   tbl_permiso fk_tbl_permiso_objeto    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_permiso
    ADD CONSTRAINT fk_tbl_permiso_objeto FOREIGN KEY (id_objeto) REFERENCES pfp_schema.tbl_objeto(id_objeto);
 O   ALTER TABLE ONLY pfp_schema.tbl_permiso DROP CONSTRAINT fk_tbl_permiso_objeto;
    
   pfp_schema            	   admin_pfp    false    281    5097    277            ,           2606    26862    tbl_permiso fk_tbl_permiso_rol    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_permiso
    ADD CONSTRAINT fk_tbl_permiso_rol FOREIGN KEY (id_rol) REFERENCES pfp_schema.tbl_rol(id_rol);
 L   ALTER TABLE ONLY pfp_schema.tbl_permiso DROP CONSTRAINT fk_tbl_permiso_rol;
    
   pfp_schema            	   admin_pfp    false    5043    281    231            %           2606    26682 6   tbl_preguntas_usuario fk_tbl_preguntas_usuario_usuario    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_preguntas_usuario
    ADD CONSTRAINT fk_tbl_preguntas_usuario_usuario FOREIGN KEY (id_usuario) REFERENCES pfp_schema.tbl_usuario(id_usuario);
 d   ALTER TABLE ONLY pfp_schema.tbl_preguntas_usuario DROP CONSTRAINT fk_tbl_preguntas_usuario_usuario;
    
   pfp_schema            	   admin_pfp    false    257    273    5069            �           2606    26727 )   tbl_producto fk_tbl_producto_especialidad    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_producto
    ADD CONSTRAINT fk_tbl_producto_especialidad FOREIGN KEY (id_especialidad) REFERENCES pfp_schema.tbl_especialidad(id_especialidad);
 W   ALTER TABLE ONLY pfp_schema.tbl_producto DROP CONSTRAINT fk_tbl_producto_especialidad;
    
   pfp_schema            	   admin_pfp    false    249    5047    235            �           2606    26747 #   tbl_producto fk_tbl_producto_estado    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_producto
    ADD CONSTRAINT fk_tbl_producto_estado FOREIGN KEY (id_estado) REFERENCES pfp_schema.tbl_estado(id_estado);
 Q   ALTER TABLE ONLY pfp_schema.tbl_producto DROP CONSTRAINT fk_tbl_producto_estado;
    
   pfp_schema            	   admin_pfp    false    5031    249    219                        2606    26722 /   tbl_producto fk_tbl_producto_forma_farmaceutica    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_producto
    ADD CONSTRAINT fk_tbl_producto_forma_farmaceutica FOREIGN KEY (id_forma_farmaceutica) REFERENCES pfp_schema.tbl_forma_farmaceutica(id_forma_farmaceutica);
 ]   ALTER TABLE ONLY pfp_schema.tbl_producto DROP CONSTRAINT fk_tbl_producto_forma_farmaceutica;
    
   pfp_schema            	   admin_pfp    false    249    237    5049                       2606    26732 +   tbl_producto fk_tbl_producto_marca_producto    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_producto
    ADD CONSTRAINT fk_tbl_producto_marca_producto FOREIGN KEY (id_marca_producto) REFERENCES pfp_schema.tbl_marca_producto(id_marca_producto);
 Y   ALTER TABLE ONLY pfp_schema.tbl_producto DROP CONSTRAINT fk_tbl_producto_marca_producto;
    
   pfp_schema            	   admin_pfp    false    5059    249    247                       2606    26737 *   tbl_producto fk_tbl_producto_unidad_medida    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_producto
    ADD CONSTRAINT fk_tbl_producto_unidad_medida FOREIGN KEY (id_unidad_medida) REFERENCES pfp_schema.tbl_unidad_medida(id_unidad_medida);
 X   ALTER TABLE ONLY pfp_schema.tbl_producto DROP CONSTRAINT fk_tbl_producto_unidad_medida;
    
   pfp_schema            	   admin_pfp    false    229    249    5041                       2606    26742 /   tbl_producto fk_tbl_producto_via_administracion    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_producto
    ADD CONSTRAINT fk_tbl_producto_via_administracion FOREIGN KEY (id_via_administracion) REFERENCES pfp_schema.tbl_via_administracion(id_via_administracion);
 ]   ALTER TABLE ONLY pfp_schema.tbl_producto DROP CONSTRAINT fk_tbl_producto_via_administracion;
    
   pfp_schema            	   admin_pfp    false    5045    249    233                        2606    26937 )   tbl_registro fk_tbl_registro_estado_canje    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_registro
    ADD CONSTRAINT fk_tbl_registro_estado_canje FOREIGN KEY (id_estado_canje) REFERENCES pfp_schema.tbl_estado_canje(id_estado_canje);
 W   ALTER TABLE ONLY pfp_schema.tbl_registro DROP CONSTRAINT fk_tbl_registro_estado_canje;
    
   pfp_schema            	   admin_pfp    false    5035    223    271            !           2606    26922 %   tbl_registro fk_tbl_registro_farmacia    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_registro
    ADD CONSTRAINT fk_tbl_registro_farmacia FOREIGN KEY (id_farmacia) REFERENCES pfp_schema.tbl_farmacia(id_farmacia);
 S   ALTER TABLE ONLY pfp_schema.tbl_registro DROP CONSTRAINT fk_tbl_registro_farmacia;
    
   pfp_schema            	   admin_pfp    false    271    269    5087            "           2606    26927 %   tbl_registro fk_tbl_registro_paciente    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_registro
    ADD CONSTRAINT fk_tbl_registro_paciente FOREIGN KEY (id_paciente) REFERENCES pfp_schema.tbl_paciente(id_paciente);
 S   ALTER TABLE ONLY pfp_schema.tbl_registro DROP CONSTRAINT fk_tbl_registro_paciente;
    
   pfp_schema            	   admin_pfp    false    271    265    5081            #           2606    26932 %   tbl_registro fk_tbl_registro_producto    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_registro
    ADD CONSTRAINT fk_tbl_registro_producto FOREIGN KEY (id_producto) REFERENCES pfp_schema.tbl_producto(id_producto);
 S   ALTER TABLE ONLY pfp_schema.tbl_registro DROP CONSTRAINT fk_tbl_registro_producto;
    
   pfp_schema            	   admin_pfp    false    249    5061    271            $           2606    26917 *   tbl_registro fk_tbl_registro_tipo_registro    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_registro
    ADD CONSTRAINT fk_tbl_registro_tipo_registro FOREIGN KEY (id_tipo_registro) REFERENCES pfp_schema.tbl_tipo_registro(id_tipo_registro);
 X   ALTER TABLE ONLY pfp_schema.tbl_registro DROP CONSTRAINT fk_tbl_registro_tipo_registro;
    
   pfp_schema            	   admin_pfp    false    271    5039    227            �           2606    26677    tbl_rol fk_tbl_rol_estado    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_rol
    ADD CONSTRAINT fk_tbl_rol_estado FOREIGN KEY (id_estado) REFERENCES pfp_schema.tbl_estado(id_estado);
 G   ALTER TABLE ONLY pfp_schema.tbl_rol DROP CONSTRAINT fk_tbl_rol_estado;
    
   pfp_schema            	   admin_pfp    false    231    219    5031                       2606    26877 #   tbl_sucursal fk_tbl_sucursal_estado    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_sucursal
    ADD CONSTRAINT fk_tbl_sucursal_estado FOREIGN KEY (id_estado) REFERENCES pfp_schema.tbl_estado(id_estado);
 Q   ALTER TABLE ONLY pfp_schema.tbl_sucursal DROP CONSTRAINT fk_tbl_sucursal_estado;
    
   pfp_schema            	   admin_pfp    false    219    255    5031                       2606    26872 &   tbl_sucursal fk_tbl_sucursal_municipio    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_sucursal
    ADD CONSTRAINT fk_tbl_sucursal_municipio FOREIGN KEY (id_municipio) REFERENCES pfp_schema.tbl_municipio(id_municipio);
 T   ALTER TABLE ONLY pfp_schema.tbl_sucursal DROP CONSTRAINT fk_tbl_sucursal_municipio;
    
   pfp_schema            	   admin_pfp    false    243    5055    255            �           2606    26662 -   tbl_tipo_contacto fk_tbl_tipo_contacto_estado    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_tipo_contacto
    ADD CONSTRAINT fk_tbl_tipo_contacto_estado FOREIGN KEY (id_estado) REFERENCES pfp_schema.tbl_estado(id_estado);
 [   ALTER TABLE ONLY pfp_schema.tbl_tipo_contacto DROP CONSTRAINT fk_tbl_tipo_contacto_estado;
    
   pfp_schema            	   admin_pfp    false    219    5031    245            �           2606    26667 +   tbl_tipo_entidad fk_tbl_tipo_entidad_estado    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_tipo_entidad
    ADD CONSTRAINT fk_tbl_tipo_entidad_estado FOREIGN KEY (id_estado) REFERENCES pfp_schema.tbl_estado(id_estado);
 Y   ALTER TABLE ONLY pfp_schema.tbl_tipo_entidad DROP CONSTRAINT fk_tbl_tipo_entidad_estado;
    
   pfp_schema            	   admin_pfp    false    219    5031    225            �           2606    26672 -   tbl_unidad_medida fk_tbl_unidad_medida_estado    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_unidad_medida
    ADD CONSTRAINT fk_tbl_unidad_medida_estado FOREIGN KEY (id_estado) REFERENCES pfp_schema.tbl_estado(id_estado);
 [   ALTER TABLE ONLY pfp_schema.tbl_unidad_medida DROP CONSTRAINT fk_tbl_unidad_medida_estado;
    
   pfp_schema            	   admin_pfp    false    219    229    5031                       2606    26762 !   tbl_usuario fk_tbl_usuario_estado    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_usuario
    ADD CONSTRAINT fk_tbl_usuario_estado FOREIGN KEY (id_estado) REFERENCES pfp_schema.tbl_estado(id_estado);
 O   ALTER TABLE ONLY pfp_schema.tbl_usuario DROP CONSTRAINT fk_tbl_usuario_estado;
    
   pfp_schema            	   admin_pfp    false    5031    219    257            	           2606    26757    tbl_usuario fk_tbl_usuario_rol    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_usuario
    ADD CONSTRAINT fk_tbl_usuario_rol FOREIGN KEY (id_rol) REFERENCES pfp_schema.tbl_rol(id_rol);
 L   ALTER TABLE ONLY pfp_schema.tbl_usuario DROP CONSTRAINT fk_tbl_usuario_rol;
    
   pfp_schema            	   admin_pfp    false    257    5043    231            �           2606    26687 7   tbl_via_administracion fk_tbl_via_administracion_estado    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_via_administracion
    ADD CONSTRAINT fk_tbl_via_administracion_estado FOREIGN KEY (id_estado) REFERENCES pfp_schema.tbl_estado(id_estado);
 e   ALTER TABLE ONLY pfp_schema.tbl_via_administracion DROP CONSTRAINT fk_tbl_via_administracion_estado;
    
   pfp_schema            	   admin_pfp    false    233    219    5031            �           2606    26637    tbl_zona fk_tbl_zona_estado    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_zona
    ADD CONSTRAINT fk_tbl_zona_estado FOREIGN KEY (id_estado) REFERENCES pfp_schema.tbl_estado(id_estado);
 I   ALTER TABLE ONLY pfp_schema.tbl_zona DROP CONSTRAINT fk_tbl_zona_estado;
    
   pfp_schema            	   admin_pfp    false    5031    219    239            �           2606    26632    tbl_zona fk_tbl_zona_pais    FK CONSTRAINT     �   ALTER TABLE ONLY pfp_schema.tbl_zona
    ADD CONSTRAINT fk_tbl_zona_pais FOREIGN KEY (id_pais) REFERENCES pfp_schema.tbl_pais(id_pais);
 G   ALTER TABLE ONLY pfp_schema.tbl_zona DROP CONSTRAINT fk_tbl_zona_pais;
    
   pfp_schema            	   admin_pfp    false    221    239    5033            �      x������ � �      �   �   x����j�0��y��X����N��M��]�.^�5��)mw���c��`��/�k:j��ʸੴ����o���/��}��P1a�"瘗��PG�{gl�����]�L�6Ե;PP��\U�D�t]A�/S����/���V��*�k��3�@;�D�p�k��Z-Dڅ�����<~��GN�~?A��<G��
��e��ҒƱǂ1�SQ�      �      x���A
�@EיSx��&��.Ì�g��P��9A,ݸ����0�$-顨�ߨ�>"FB�\�J[���n��rn�'��y���0�΋���	�T��e��/Cz�W.�͏{���?�!��{<�      �   Z   x�M�=
� @�9��Xb��cP v)���c���F�	�茔"ԧ�<{�,��A��"��a.]��[�L��%��Y��j������      �   l   x���A
�0��ur
/С�z�`�<��D�s�s�ƅ0���KT�aB�n�5���H�!I�#�T쇫5�XhR7��-З;jW�a�e���:���~1������3��.�      �   >   x�3�tt���2���2�9�|�C]]��L8\�\<]�B\�L�J\\�<�<�1z\\\ ˀ;      �   @   x�3�t�	ruwt��4202�54�50�tt����	�!K{�)���x�y:;q��qqq ��      �      x���ג�̲�y=ς1�V�U	$T&���Lh������y8c$m�}��V��׷���_Y������o����&�S��]y�n�����c���~���%%�#�>��)�/x�B�Ǽ)e�>`���r���΄�����
e���Ѓ/�䑑���Kl��IeNG��s��2��X��l��b���O�����W�����c�*ζƁ��y�yY.���Ԋ�м���{TC��w^!�#�Hqn�?��,Q��E��B봡y�t�O�۰:�ʖ���B�Z�^�����lz��)_7e�}	ߧ�z�<�<m�fn���/��-3��}�oIx
�|�Q��/8���n��)��]�ox�9?t�["��yf^H�ibgZ%=��I��G�}�7���$�ޒ���hdvT轣��$�m�G�"�&�bܨ�/����RKڅ�ݶ'ս��&H���WҠ�����A��w�R3AFDv��.�R�K"P��Cn�a�N9���Dv��c��/n�'7��D��()?W�#���|�^>��p���4�o'���{\���nS�_��M�+��NK�c�F�43���51�L<b�����>2�U��@�5���C�$���^��%�/7�ӟ�������؃�`�Ȭ(��d��c�]8G5��`���h�n�&�˚�|���#�B��8�f���81�$Ķ�zglp{n:�������J�Kl[���Ŏ�W��2�aeJx��)��e��&���m'4��d�.k$I�Z�3U-P��[P�	��[���եk�o�@��ʶ\#���mZ�b��pe�A���T�d�侰���M3	���{�J�t��ڲ�?�T�X�;�pg�Y���=A�����ꯧ"*������%5��n��`纠�1Fڞ�d}O�g�|���uR'�W���N���Ej=���=B����ѝ|�Z{k@2/��tE���]��xU$�4W��O�ڲ੍͉���,��l��>BY�@���͘s�h�:&���Է��+���hޯ�h���u]{+���eN���_GA�P1��E���!V�x�D�uc�Ms�߇I�p
'��c��bs�[��zw@�T����8Ϙw�R�9�"Hf}2p�Y����w��*��Mf�0���wl7e����q�ss��k����}�#�J�|��|P�!,�j�6wٶ��E�%�Y��y�,*���l����{;���jڗ1�g��ڣ׀X��a������%Ih���ִ �bS�ŝ=�����P��(��tw�x+�s�1Ƿ��{w�]��&��oeBղ1:[�9������w�=TS+R|q���~-�߹`�.��`���}���ѶR��e��Y(� �t!�>H�i���AqN�$K%7MQ��N��hI\(�8O�4��'&�!5����iz`+UO�	1�����^�Y��O��{�=��<{.�_l��<85Sr�"�/1��%��S>Z{Q���	��9���l����|q�iI��,�m�jr�z=�b��m�9=2v������U|M���BWC���_B�6{��=�ִ��+KQ�)H[a4���Pt�Gq)�
��F��������f�J��>��񱄅���R5�:�7*˷�J��3J���Ej�P�0MM7�uo��3(D��|�m}}RP�W�k�"+7/6~���$qE���#OB �����IQD�ʲ��w���ݗW������6{�A���=�K�}�"����#gt:I�Rs��dH:m&1�Fi��g�����iM���h���1:���E@�òL�`�u�;P�M{?s��=� %��7�U[�<<j�տ��㳠�=�Pn	�!:�^>�m���#!7*�V_�"�d}$��x
�41�i�7`�!f�a����}ț�-X�{~�򪍒bx�d���t~/���~��[\��p�&�Qr��﫲n=d��C�^;���V��U����-�����g�'S�'��_$R73:����:���|��$�Ӊ��ݛ]l�ƜP�ד��;����&rx��J�(:�K«6ޖ�3~����.�4E"�� %��ʑ����|���M�-��\�nX�%�p�]bAP����A��~��=?�H��@�!�4#m`�w�<�}��O��֏6U�݀_8����k��eqN{�s�4��KL(^17�!�n�O�ֳ��Y:�H�O�s�1�B��,\�c�^mt]�"}���[�}U&�MfN�)���H}8�'��,�����w�Ԡ��)�4�C�	hu���]1�6:Q�u-���lO;�D�_�ԫV@�1F/*�pP���8`S���P�g �q��o�	��ؾ4� .�k�>L�<:��k��J�m��֐P�f��6�w~z}�~�Ŵ��cb���$�DIg�WL6�K*^��턛�C��cN��3i��T.�x0�p/�ŵ��!gP+G��-�[7ee��T*�)�dT/�23y~�4���yg��O����r�`�PHg��8�<���(ۂSi�[rDQ��-�L�z~�@g�%h�D�V��+֋oh�hmfmW������:�	^�S x�O�b��;�x`���FW�m�|z=�b�$۸1#�6,}V�칫8A{�0�D�P���A"+e�=֬E��s')6Q�*x�� ���_t&���)˪����$y{ �s0���X�J:%|v�Y�?t�l���/��"��5������'�cZ�ҫR�V���:n��|/��p���0�3Uh�7��ƀ�������T5�P(���
*�o넙���<{l���6���G�����	-�$Ѭ�2��ڳ�	�~���\A��	��84�ce1p��ht�.�^j%����!.����v���1�]#9���)��O�����F3����2i��qB>y;i��B��n�w�$ьYd�C�������X,���h�7��8��jKi	ʠ�0;+��75�h�L6�ѓ��9Ts�L�S�n�2����
d���i5�͙#y�K���3
��|y�xq��b&�a��l�Ϝ^>��RY�炔�O��&D�˕�SO��M<�U;n�����x�(�Z�t¾��L�7 0d=�s`H[ ��1F���/_��"�:]�'�.�nc�qwf��!0�k��I���5}h׻
3@w;;�m����ޠq�[��j0����pz��̸�5�F�Q˃+����G�a\�
��A���Wq%��CV�h��̓�K��O�U� �� x��5 �i��k�&e�ܝ�!���yX��
Z�;��nc5R{��[Z	��P�!i�ց�A����N��Ƣ��������Y�U�5���$��iT��zib����-Fahs����܊�ur�c'3r��7h�g�Z��z��&�W�����Z	:3�����C�' ��Zʓ\jNVzJ��3�Y]��z��t2c�|a�&�u���n4r5���apω��V^(�����0�nH�7Yl��^��O��:Ϯ��x��l��hv�X:V9�1A^
�>�	�'ޝE���uĦ`wa+�_��M+P�@џ�ѳY��^}���������¸�Ç@��t���ro�$�'�@�.s>�5���\�f10�F�=���Z�0y��정ѦE�q�����G��ҭ�GC���=���1��8��L�GsФ�Q�1��Ƅ�ϛ_�/a�	�p0N*�y������Kb��`t
mI��`��T�eܷ`ާ�T ��O�b6�l��S���k�R��JI�`rs�<�<u�>���@奃��7J^���-��'�~<J?;���FyC�W�=�u��_$V�g��j����٩۬����|��e?��BW㫮��mb�E�'�3i��Q��離�z�,Dv�O.
N^�ıa�������c�T%^��B�Ə�	��֩5d8�g2Z�S[�j�n��J��ݗ\5WnB�0�K�}mS� Gh�A�<���2r�G��{˷W��4�I<h��v�O�EI�k��:�yKs�S8�\�ox��Ea����wl�.!��O�    /�>;<0 :�!w� m�����26�C�ڹ��e���\�#L�vf��)(���-�z��j��	3[쌡��~�т�_57vyՄڳn�����"V�_�bO�y�o���ڝ���V�����w��+0��w+�>RQ��9j\�3���S�{��wh#tG�<C�z��]�硯����FDD�Lj��L(�ѣ�R~"x>5O�ŋ�`�7˺]MT�l<T~�Bl��%H+���zN�E�+���+�F�FX���M����wR����d��f%dA}�=��f���`:�� Xl���g̳�A[�����I+	l���e"�!I:W�vp�Р��kͦ�g����U)޵R������¥d��;ݜ�x�(�g���ƾY��eg�v���t��><d��� ���Bh�����}MN��&;�^s��P�{F�^�H�84ޑ��0��dd��h��|ʾ�\��y�Ns�_HN�z��z���Z�PD�E�-|�q�.0�b�7e��d+r�6i�.",�e�l���
�����#�,������C�M��q��hӸMt�F�c��;�3�#���t��JF?Z*ǼK�Z��^^�Bk��\�I>��}�L<�]� wlfzQ��N�C�?(�*@%�_֊i�H�.-��k�G�������i]�<S������)�^���e449���զ�a�	��*� m�#fPB�lUn.-��C��0u_7md9�A��G=�Gg�S��.wx=7dfc��{{6���d�(W�ih�Ҫ5�O����z*i#8�E�Gj=����caV�n�#���B,U$�zU�l6FS2B�6ugr0i g
|��k܃��"��斊��A����l�?�� j�j��y1c�R�'����w��k<�V����jp�(`����*ӻ �I�(2�S����4����]&\��U��Y	�vx�w�D�.���[����ţ�D�U{�BOĳ�(���S1��Y�������Q�p0�˝�+�6��T��־.	Vm@��~��?o�l�Vv����Bi;���w�L�tx2������Nl<�N��2�4���0S ���  �ގFsq"@{�/6�x�u�WZ?:���2�l~I��.G�Q&Ώ�T]��	�ȟ�(��������M�F���-~��䉲��yb�Ɗ6��.2���Cx�F}H<�ć2vqю�&������ȓ;(w�
�5�60��V[3�\�'�U<�ЏR�Q
*J��Hnm�A��B����Rɋ<Xfy���55�-e������h|Z����|�	�h�� �� ~h�ǡ��w���u���WXm`��V�b�pXhQ�wJ9z��<���s��.p�$SV����Ҹ���w���<�若��T� �vU�����Q:�+k
�7]b:c�� ���J����f=��O�6�foF�p~�`��߹K���"CcfQ�h���N�b �E��
I~��wP��-��	�/�Q9���z�m �"(�徿�����<�9�Y�Q=x3����}Z��q�q�dY�	�5:`av��Q���!���KjM7��� <J&,���qz�������G�l��9�@�2���H~u"r����ϲB�ĺO5M����`�;�g��+�a��y��(L�K��B�y5���/2vzb��N/���r�K�H�_�I�a 1H��p�� �RK��`�:=�zW�o&T�	�8 ��%b4�N2��_�y��O�P��p�<J���~��a/1�n�V�S�Ӡ?�����+2��#�ۂqqfGY(Sv�!�w5۪$�T���c\�=�X�^�F�rD~R�O�bRvSk�C+TL�#a��e�$Z����"Dx��pÌ(v�e�����w���
�ן��HIkE�P��On�uŦ���?6[�q�O�Q�B�HD��D�K1�~� j?��oʡ�<� �kk�3�av����\��u��,#M5Â�E�O�`�އ�c���������>�שOjn��`�8����8S�HAb_t�d���=� 1��}����J�6�{�*�������QlN��������СB�nC+�����oxYn2�Uޑ�j�;��PM�o)�m�/�C���`���g���T�� h��q3uL�3TNUuL5õ�T�
}��9��@�i�=(\"�;�PI?�N���gH�\�Q�]U
�T���_^�C��<���7L��:?&$��|@�;�4�"�+���Ljo�׳�C�_�@$��2�;���yS�F����2��#����A�c�Yio����_��~�?>��w����?�{���{��%AQ�ߺ(�ɯ;�L�4�8�KgjsC�
�<�����(Ͽ�4V�d�Tc'�F,;�o+R�����j,i�j����L"�eQ�h�/o3��b�*4#2Y1�s�9w�h�͉N���b׶gcV)����3݁�����&`�J��Ru��}]t1Y�n:�F��o���C�'����$���ˢ���<��J���ד�kh��Q�����>����T8��+6�ׯw
�񖞥y���3�%���;zw�L��g�ϣ��e`�\���v�'4�ZSx��K������=�j���b�(�ǋf�@;	ה��^��WU�b6�$_��g�����̍�ׇ���"W�ڋ��a?���	�dV��;�����ϫΜ��?*3�h�Zw���/�ڥȿ�ousA��	�"�T}�?��z�O��5o�ɊFpe�'>J��$J�P�ԛ�U1ң7�M����L&�[����7�{+B>	D�-��sGO�L M�+"h�`����[�рP���>j152�b����A�O�σL�@�#�^ψ��h������E�r�%JK�$�łq!�T���Z5nIG��5<������:؏u<�FҶ�h�6m�)Ȭ5I%|o��cs8�?�H*u�cq��=��D�S����vl~V�(p�Z������գ���Vr��$���\���r�c����W���`��J��P��b��2;l�L��<��b�2�Q4�d�)y*{f�AD�q��'kp����E:��4���H˥R�
8�y�V�����>�U�
pl 0;��U���_�n������
D;�S��h�����h�<�LF�����$��6�!���.����ʮ����#���*��""Yv�W���G�~�FP�&Á�l�а��ƏE�Ir�'��b����O��;��|���݂��?��(�dҳ:�&��ۇL�v5qs��Sn/2k�5,�����̕z�uG�.?����Y̟O�3]g�.���Kh�Oz+�i�ǯ�5�a�pU��k:r���1+��q3��r)�!�q�'da��� ��xu��T�R��_O$�7��ֽ���!�w��ЮiG�_=��7��������>e;��#��g��DI�Z<�7
��U@�9u�!�3T�y	��<)x�1N�����Σ�⍫����S�A|�(�P���Ιu$����;��2(�&҅oZ;ĶoD&x�����1�r��������%^��J+�|;/��PӶ���2��?41��[����`�7�7a�Jn;Y�(k0��'�7�e���6\�WZr�Է�������C�S�S3��vu^�Q Ԅ��Z� x�7 �V/��#<�.>�q�g	�����;Ad��(��id:yc �9+(�d��/��B��L�\�[}���;��V�ڹ��00~���]v ���d��T�o��5&���u;P��A� �馉��,K�.�ɾϓJ��DFۃ�8?�5��g��Ed�E9�M��b(���$`͂�÷��[_'��z^��J^��>*3����%��c&�X�����#4�����)[��޲��ً̒��E�F�)�8�7י0�����;I���83Pf���;�|�_離����}�X����h%�o� m���$� D�*r��57płt�^W�{S�1��ҏ�oZ3����Lx�o5w�S��~���D�3J��U��    ��{�E�W��N��0K[#�9����X�݊�	����y뫴���k����AA"]3�2}�~ݎ*�y�ʼ����8����$�l� 2�ڂ=�,�i&�:"U_��	2�q�`�y 4" �����1<�Gs��8P-�����H��c(zB���(��<W�k�ߵ�6q�o���)ڟ���Ϯ˽��L��I�z`t������X��v��9�c�Đ�x$(��R�����;����J1{�"ͷK�%e�#�#�$_��>�}� ��у��3	Q]}�}�R�F(r��?.8:�@�h������2��U}�z�N�w!�lmCv:��1��泧���
�v	 NbvH���]]<�Ƴ�-�?�?)%�K����cqD�Iï���� ���)�u��»�}̒]�SG��c��-�s�hn���y������z�y�Rx"^�Ո�!���<�86R(���u��m˺��v5�1��lO��B���B����(��kU�W:K��]��x��ΌFt��M"Ǒ��S��H5����-�����T"4�(�J%�E��H�ޝ�ṇ��.���g�o�J��sD��_�4-Z�2͈�HT�cTy��s��C���~��U$?���<��b}Idt�G�	�/k�L6))�P}�baJI�j�o-�I���y{��C_��Pf��}.��+���
:^�cl�\��l�󶼿�F6������R����,�g�f�`�ƇO�@�O�ܖc��>@]��y�[��
��;c ��<d,U��Ț���ᬬk��w��D|�K���ȟ��C&�Z�N�uf�H��.��]���i��C�fQ��E,�^}?����idϊc��X|-����f/ p��*Kn3Yv�FC~gc��;�b�����@D�H��h���H@�7����j���(�xK�� �3.R�89N&n8�ѝ��$
�:������@���;��%���l�ŀ���e�G��u�[��q�����#V�)�]��%.ȡ�7���'����P���Oy�"U;Ń���7}�L�H�@C�?bK����xu8Ƨ���O���x�K8���>_�,��?O��C������"p��RS�M4z>n�۔q(�Y;|WhM��ֈ=�Q�<b8�2�A�Qs&4���S�J &yQ��CbW�&�'u����	�a�r�=f
���P:��1����t'�[3�=�[��ą�fz��r�! 3�4%�gq��ˣ�.r�]��z	�cH�4�M>�����x�����C��Ei���m��v�˱:MV�}$��Kr܏�����)� y�L���j�o�{#�;h�m��e�2uQ��шh��d�(D[b�@�m5zJ��_�J���q.�@1���g�4;O��-5��o���~}Z�Ե���aI��%�ѯ���
E���n�:7�T/���/ڷq�t��5���bt�A�k�4����HY~	���.P2)��V�ܞ��-p^����1ĭ�ù�4gHľIGj~M��b���cD*��6L'��Z����v�;��w'�+Z_w�.����|Cp���w=�Pȷ�wG%��	�/�eD�.�N[�w���&�y���e@c��;�煡��$X?pg�-g�m�6+	.	I6�Դcl��h�V|�]�����o�V�5�}g���(M� �U��Ǒ�\�<�֏Vl��~4�Ak+�B*��3'�-HB~�����im���}�����'3�u�����|OxG�:c`��q�݄���H�y��`�:�ζ��5q��om���߻����y�<?�;�ţk�Y�~�8��{�:�ޯW�������ij��lCCI�?�������{��l>CE��L�0��s	�p����^ǣ��=y�l�ۦ����⟿3�t+��͢z=��$�W:G�5����̡���*�`���H�҃�5��#s�������iє��]�9F�/�z�a�2f�n9�Qb���{�/{�R[�~�xᔬ��z�x��rV�Ӝ��Q��A��5�f�ͫ &'V��;�+J��>���DS���s0�䆘�@��	s��\VB.����P^�썌��
�9�$��q.2�zm��=�f�\�xo��*�|V�I�n����'�����;�ne�j�#�S�a��?̧E���Ǌ��2��8��g5����Um���k3��zu�{ߴ.f�~�&3��|6)���b=�J���t[n6�]����-����-�S�*�u�ϯH$�C��0I���w��&\�������azP�/\	آi���9y�n�2��ےɈ/�WP�[�">���F�٨��ʯ=LM�$lHR� ��(�q	���8�q5�2J8�� ��*q���1�~g�k�H"��D�@C(Qd�]��j��y�z���2�/��|o��
�{�AD��J�w���H�����7��}̑?��jB��.
�2 �D����� ����_����v��{�� 6�<�!���>B��;�lBN��́Ï�����T`�՗���3T;�>��d6!:��6R�Kx�p_�������1�c�Fw.s���&^/�z42�ͩ�K�E����-nx2aeiq]�����$�&B{. $Ks�]zz�Y�G��!<�9�����R�p�v� ��V���'�:#�f {V���5C	��̵20v�l	������Tl���G;���9[X_�2�%�GA3�Q\�מ��6O�:'Z����^ht�]�De�Ѱ�ֻ?!��O��Õ�X&mJQ������Z󡉟ߙ^��%B�mO�ӏ'�*�B����V�	M��R�ܖ�z�6�6"6`Z9����\;�����PT�x"O�)�Nփ`�O�ȪiBO��N��ʔ%��gq3���9�Yc�k;~3��V�����9���EJ��s�=}�6� ���ؽ��k�t;�[׀J�� y^냿>�4�֒,�]�)W�f�Wq����D�
�J���B������w�}�d����K�#W3?s{��d5��/����9�i���+�믽�����h�	��;eT�� ,�I�5�.�V�,���lly[��1}e����(V��{��z>� ����G`S�zʹ͵;~�|V�n����4��5v�9��5��������׏�N%Q��\}J�����7�W	��]+ѹ2�=�i�~�~�B�{7����%�L�f�K˧������X*�gY�9��NA��md�/T{��)�_U��}}��ҥ(�Nr�`>à�ɨ�ކ��H���!���׷B
���N�`����z�^|3��W�q_�y�_�^|E��^g�ݫ0Z,� h���0�I0yk��܉{<���gw%��{�1A��Ѽx�"����=���T)f6�m̐$�Q&ل�w��e��c� 5]���p�(0�d�ƞֲ!'W�3ޠ�\im��{��JAM&����17��	��������86b��(�m��@��'6�����Z����kV�j�g�v'43�������cx�޵ƽX�gc�k��e���ouB�(�����1h�����E�=B ��e$��N�0췊���أ9�^�O��A\�C�U�}W�����EO��������~;�'�7�^�X�-�>��d=)Xp�{���@r!���qE*f5\�G�SIn�������7$ ����p�:����/cE����ߤ���T!���mo�j��z~r2E�7��꼻;��4I�a�Z�� ޸hg��1�'�yq�CYv����ah��_5����[��yQv����Z��b�l�M"�!�JV]�(y^�7]��N����Xd��HA�SL�3��9<R���%�j��[�V�6�wډ�!D;i�}�k!Zk���#���אT�,�;M��[�?K�~dc�����ŀ���'�����'`y�/%U���\@=Ά�sǠ턝n��{��Ϟ��\W�jUH�jr�Bt�&.D�E�Q�m��j�k�-�v�;1�j�JwWN�>��2�;SqX��2���П�D���G8��f7�݀K    z��gZ,NG[m�0LjUsgU�o��̠��O��/Es"-�������K�F�-/
h��	22^�ꀡ\�>��t)[a�dN�P�N�߳�w�0s,V��3��B!B�2|Ii��W��E��}xc���X����ٵyat�ln!��EO�^x��}�|��L��$D��g�,�3u3�	�k��5����k��#�%��(���Ǩ�����q<߁H9d8bƫVD0�q��څ��.9C3�8ֵ��҄R�^ݚt2i�/`�һ	SH���.�3Y�ˏ��g�t��w��^�Ey#B%J ȄOvS�".g�o�hv���CGe����Δ(L���@i��"�$УN��0mq�9*�l�ǃ�2%�_�n�T���)��`l�'`V}�u�om�`(�x�]Շ�fI��(��F$�����صvw��<�{�������0`Y�4��Ԭg��|#%��I�Dڿ�+�����K��ۚ�?�������b��GKc�p�9\l�T�R`�dV��5ߞ~=i_�i�l�=��;ZP��������K<�� ?#a��l�w�Ec6�o-����gBbG�h�������j�[�-��L��`�
������|&��yFpU_b�G�4]��5n��JPAd�
�� ic����R[.�i�����V��=���H��<w�"��{Ñ�| Wd	��:�J?n����=o6���{�(�%�ו���d�d$�k�^"��E�N�j���O���!D&w��-��w�!^@����,S���9�Q]��3But����8?6�F*�6�|�pIw:
W�2U(_5�-����{�
�5�����_��Lg�z�
�fX�����-�lUp��b�[$Ifi���z�^�'-�r���6�4<�|�~�(T�����oW�w�0��J��OTr�LǏ��w?�j^�.w���|&'��g�>Dkն��p�䏗�������u�a޷7Y�lA25�����W4�t~Q�s����R���,�z�Y��`�zNߖ$�IrF�V~-���N2�~a��GֻS��󼙓%�yT�����2NX��a�)��*>�a%*�
����/��-ͅ)4n*����0i�]� ��	������7@�����Ŭ+ȣ9{	�x{�)!��d<�|�����+Jؕk�N��%��'#"I߉H�C��7��Φ��@��8
����qr3��=����*�3p�����|E��1C�Gp�J$�8;���\��� �o�h����2�L�}�_ߊ�|¿8����~��R\��=$_�u�j��~�>|�����^k�b˲�q���=Н�	a��{���s.��Y���뫮�$#3"32�7������8^��,d;Nu�{�s��?���Djxb�"��,�	T{���� ▞��~za�G���wA$�Y\��T�����G����W�LᏐv�,ݒ��P9�XN�a��.�f��~D����G揧�Ŝ������c��/���~�"'uBn�{^8��T?��T�}��-)�%�q�fA Ĩo��\h���ݛT�to�m��p��}tzpc�������](���8v$�!��utށ�9��3���q���eE�J �]��3�+(޳������VO�Ib���������œ�?R��ro>��y��9��t�*�.iD��1M��d�G�:�"Wob#j*��q��n�ϩL����q�bh���s(���N�tymc�w��Ŧ��ԝDQXҷ"��m|�]u���8X��s�t��)��d�R{�������>�&��p�r��h�a���3g���󨻚��x���^�a`��͒{��\���ê�l���ڞJ���DF$uE��i̞4<.I��?��i�KۏF��B���b�,e(�Ձ��-����P�F�hƼ��AV-�b�7�s�*�+�����n>j��5��q~*}�w�|D��*���$�����j�ʓ���aP�3�羽j#���-¿�����'_�*w*A���U����z�I&7��?5k�����ķ��
hc�#�<�%z��j���n�^g�O�����1!�D�U\�h�����a!^������ P��8��d���Z����++/X&0���$�����0)?Ax;]y��6�3�̚����0�����ה	}|S�E�{��t&)��3�(���|J[_@�x ���KKI_�~��'.3�e�u�t�`�����)~1�#�0�)�����/u"\n�����[ ���I���H�_�=�=ٮ>̨���:M�\\�]ŚG<��7{��,����tW'�6��W��t����0����;��X�.�sq���ϱb���z�TY�?=y�]�2��k�[H�q؁e�A]�\����֨���񢨉L�ιC�]9�?&ѣ�@�!>�t�̅����q�w��_kI�n�X�f���k(Mm��a��������I1E�� ����2�m;����$o�
���'�����/�'��/��|��w���n��'IT[����h�T��r�ey鵏����0r��F�^��a��� >�?�LJ}o4<��}.���PL�>Lpy<���J�(� �-�֖�V_������g����Z��D>o����.��#z4��Ț�d
��\)�p��ų��bIke�w ���\���8g"
���S�3(�T��@�˟����2/�摆C��S#Yǋ�$8)*C"�`�4'[{�B�&Zc��>r*>c��4g�i�� 
��/�
���l�B�e����6�SKH<����w[���p�T�.A"�S�H(���?�ವ a�4�:8��%�����t�Z4���=���ՁX���A��WO:��Us�/�}���P��Rs����^}i�rl�^*�S̭p;�]��>U�_z�'�Yc���gP��Nw8���U.3��/�+d�A>B���3�"�8�#�ԩJ�:�����q<o�6�,�M�I��]�x���̵��{��9fc��&��x1�?�fOJ�'�{��pը4����%.Ù	5\9 �> 'D���d���z��icU'm���Zh���!?�5�7'0��R����|tDL�	��-� x��sQ\4���)�%I�����{u� �<��
�u��tޥ^���C�=�p>!�;���g��J� �gha�������)���$��v:ܖg�	뚲�~"�t�B����+f1�k&��k�bS��b�L�nT/|��H!2��fx/C�/l�%�������g�F���=�s8 ���hw���T�z�Z�q=�z���VG���,f.]ï�+��Csh���n�[ژc���3-qc͇����܆`�"9�[r��\�������֥B-�5"�	�{}����m���K�1��Հ�H�Y ��a��D1����3W��ǳ*Z�\�u���mʒl�fTW� �zA�`Ԟ��)�c�c /�0.M��,`��o��Yq_��[vO�<+��Tbjb�ȴ���	����6-�~���ӑ���@�{��{���A��%������V����82�}��fIm�/��|�?%[�8'��*;^���+�g��$�~E/)�i���d�6����;) �Ί�� ���ڟ9u�"Cb�q��UW�"{�OC�%46rO��g��j�E�8?�%}t�����"�J49��d���@c�(���y���X�9�ҡ�dһt ,�,)���$��ۛ��E��k�Aڗ�
����#��r���
�o��à�)��yŊZ9�ʶ
���;R0�B��� Z�'<I�R ���Ͽ.�ɀ��e�N�M�]��	���&���]��ڞr)�gaP�2N�Lp����}P������ ��JW�^9čR�Sی}�;�r����ã�x!��U�U�qy�q�k��R,ڿ�BeQ9�Li�;%G�V��&JVvC���9���Lu5���Ay�z,�GE�U$n�ۼ��!"��W_�|�[�&v
��    ���]��"V�xpd�ZNOv�&��s "��1g<�� O��D������k0�GIN��M�w7�=�n(`�髶���7���<}�L�,��#8��>��	7WiZ��iI��
�M{�E��F�5�w��3
ݟf3^·�l�Ą��b�ƩMG�6أ�}�~_���������"� �zΩ�K/{� �!��?C�ÞO��=����*K�v�f-)�y��U�t���:v��=��D�ec��s�L=Y�x�*
~�C�X��KC�9r���F|'�BTX����M)�[�⼝��7qIۘ0^���k�6�%�Di��3%#C�2=ʚ���G���*�L�ca���|tJ�7�/��#��.���̀�m���1-���8��O���:�֪ U�ԥ,lw`����9��9?y���������7�
͝I����`0/v�*]s��9�!ݼ�Ko��#�i�l��Sv��^x��~���������w�h�)۪�>p2�L��A��Lx�6l�Yv��������>�V@��C�6�{���;<�pKw�<���o�0�3��}|wV����#T�Bl�=C��`��:�f�T�n^�?-cSt��}�T};WɄzA�0�����z�cMe�h���\�;�Q��{6��7 z����(dw@:X#�aG�}{���%x�#�/܅�;���;��o��(dI:]Zc
N{�e��P}�t��B�������5�P�Gx�1g�P@�w�m`�;*���tc�s��`:}�>_MFwi�:�4����-G
E�e�e�R41_�	�Q���b�*�MJ瑨�=�H�Rg�)1���>��씗�>]N��޺c����K��պ��NųK4� ��pQ`(Jz՞��5+1���P���"�����^u���L����[����̗�YB~o?��\^�/.�^��Yhz�~�f�I�݅v�_�^��z�s�T���G��?������i�#B5/�j@.V���_?|uϞ���tQjS�a�����C�-�����L��������f������|t�A)�0��3|�ڰ����i��pu��[����~Ӆ�on�o�ˏ�O��	�⧫��Xw �z�w��s�h��C+�u�7Lit ,��̏;���Ia��,ous$�Wy �����o��z ^����Z��f�q�f����2�9�������c���U#H��4�_Ʉ������y ��F�h�ǉ$���? �UҾ�߈-�|N�>c��u���(���A�,Yz���h��J	�)�2��x�ϗ�_v����	ĺ���[J����^�P�<��;u?)�9�2Ԝ��E�*4��Zk��$fC�T����6�o����F��w��i����o��ʭ���8�4��O9���vZA��	�zf�����vzzxyè�x2�Z����r��3<t�<Hs��w�v�/�?��)�d��3*b��ܽ��qVe���N��-�^���oܣ�?;�����7�b�P��ۨV�GRռO�B}�r�����Ç�6&�H'���$o�UU�:���&�F+9s�,�_�|�Qjm�}.٦�O�9 H^��s#��!��H|b�|�`�T[� y廡&�����3yW��S$S:e�3��+2�ƒ�,������k�|�h1��YV��4��8��(iY�����{#Ǒ�繾-�}o�!5_m���+� �߲��q
�;
�ߖ��oa���S��F�o�'�k��냽(6�q�7_q��6��M�E����]�ڒ+<�2�����!l�3�����z�H>k�9�T
>�A��1����l�-   =Y�]��G{�����n��*����54�m� �<� PK����c�ـ��������ϯ<�Υ<���O��h��9�f,�Z��xS����nk��ó��h
w�h�ۃ��B-��D�n��_9��F||� ����;΍wݤj�Ҹ��|�<@��_����1Z�v���Y\��h9�u�a� )Π`Z�LY�����$�U2.غ��eYc����z�קSU~���z�\X� �A~&���KpX+�us�� �0t���s{������,%c.V]Ӿ�ı���}�$�[F��{���0�Ԁs��ʻ���b�u�U[��)��	�ɭ����{wBKl�f�-����<��i�χ�護CZ�6��^��iSy�Ѧ���U7b���E���=��@$%)y�6?��#��@.c�<}@2�H���H�jl���G�l����u�:=�F
�k�s���?}P�3 ���c�7OU�P>��]u���(-9��:��������8�>�/���~�}>rc��hh��-�Oo����A�z�x��:�8�4Vnv�4�9��8����W��1�����Զ��%���_��먆��r�΅uG�Q �/���X���m���T?��R�9���rm�v7�i�_�Ff�&���ǵ�h��rF%��� �z��x��#�Z�y�\�֪+R1T�Sd��/�.kV�`�E�8�S��<3bw��9ƾ�Ќ�~&��.�LmmH|��o����,��<��9f���t��� ���"�/7t�Y�1�_[�,�怚g����0ꀬGi(P��W�\ μ�8�x�<zƑ~�O&GDSA3��X�N���'�>�Z�������]o�Zo25#�^���U`�%G̮�Mȑ��5u����CѨ)�z�̉�� ���0�����=of����F6�o�������g� ୒�#����m���t
���e-���#�6�y�0�Xv8��']���K����-��=��̋����7[+���$$w_�H���駻��]ףQ��]w���=6��71W5;8�ñ�'Nt͒��I��v� <�{45��L$��5�����ϻ�7�=�%�����+>T�z燙�#B���қf�a0|��0�ǋ87�)��}L�	�Eq��PxNv���P%�7����Om�F���� �p��{"g/�A�'�2�u�������-���Ud�yK�&�'��$��Ѳ��P�Z�󍁠�yѬ��.d���-���|��p���@6��|/^�h�:�K�ԈgknԥB{Adv����D����f��n�Uur�LUiװ2h�F���,��`6Հ]������n+�����6 E����g�P+Pe]SM)�/�h�r����� ���d�}E�f5����Q���ӈ�����U�w��Hi�<�'�}j=�_��?M�!8y�>S~��R����Ur���rxt*�GZ$����l���y���ǂGk����y"�`�4 ���ss�=��c}}xé�q�{��"�0ow���(������>%��Z����9���-_�3�Y�������vS���8�nU�uK�C?�z���(�7t��`|���~/ˣ�V�����K$\"r]��k	�����z�ﳀb@��K�uR�~K0�i��o ϡix/|G���be��:#�F���،e ��(L���D���dy]^��E�`�͠o����m��BD󠏗���Y�a�8�(ғvp�955�m�!�G� ����Ѷ,���������
�����`����AA��x
��`�N��Y7^Z���:����d��:� �����|��%I�N8t�s��o���3����zX���w4�������/������3��h�mo ��/���s��ɮ;=U��%0/��u19����n�Ӳ{�j�P|y��s#�f��r�3O ���Q�z� ���b�d<n����5��Ԇj��;�᮱�<�ynv�&5C�jD�K#[�?}��C>L2���굓E�:��������^�������to钸0�󧎊δ�M �N�z�g�γ�˺ҲK{yO�]��F�\��.�,4���k3�?X]�_��*��d��e��f�py] !zey�{�!bI>����S��	d�Ld��oE��͖� Ѷ�<�^~Pr0�ꨃ��bͺ����_�` ��'.    >9������G9����u��u����S�Q�&��3JŴ��4rdu�����l�.b���x�����򃀞�}�W�?�.�^D��/�x�80I�����G��q�+��<��9�[�_<�i����3�>})�q�R�E(��p�R��L�~� `�����K_K�y
u݉7Lݰoٍ�xTGd���:��e�ҙ���z�z����Sl��{j��]�JeZ��.�Y1��/�O��0�#8����v��%+�>O�Hy����Ҽ3��C�^��q~��d�e�n q;�q�v�|�V�Y�A�fQ�X�I��Ӳ��d���
.��X���5q}?�>x����(qx� �`���8�|5�_�\��m�⵻0�nX�0�g�#+�eLb�8)�I�i*��,��P� �7���O��^>M�eu�	o�r��%�P��!d����q�դ�n�q�������rW�9"��*Q�wL,p��	�%<lU��N��۳tz�|j��y֊���#�N�s^�N?d
8A��x����3zO8En�z��;yeg��vN�8�l��XI��t�+F�	 sG`D��{n��O���-��J6��I[Y'P��h�y��՚;�cPv���wX�1�<��<=㈗dm}�z�ٻ]~�?�3^�k;&�r�C����b���$]z p�ݺC�� ��'�����'�/��x|,�fr�����ur1�yo�?��k���@�,�m��퍡�V�����~��'�zW��;_���)�?r(O\EB��G<���e��Ө$Yh�}UD�U�Z6�Z�J^��c��ދ�c<�+����m�^/��@~��ɯ�C"�q�����xb�4>@>?E���;�@jB���|�DG�$&���otO���wo,�d��{RA�Xp[�GAek:� ��2��je�/4߽rM�\�<��|��l�A����h�*���{�8dsS�7��L��п�;����)W�ƻKw��T�>�NClA��ͧ|1W�2����7�x���`��@��?3�81�D�v�6Ŵ�  VH��P�5;j�rYh�g��6�?��u�eh} L�=L�L�.O?�g
����(3I>���)EU�pm�\q��N���oo�]�rV�Y�~��.�(�����3\	48���3�逆1_�8j3ћ�������q�4AL'̅T|��w�[�&��HJ��S��UvO��e�}3�C������s��m�#ʮ:(�O��O�.�W��큏0\�#�aLq����%8��r��o�2��1�vBp�W�����2�y��A�Q#x��kN��r�g�n���U�R�4�PPQ�(�da�Ĳy�g[��
I�o����$�hc�N?�}�Q�
��b>Ͼ'�.k[U��2�Fq�
��u�;�O��"}�A3.�G?�m8�?��6� �����̎m����|���ѝ���G9�l���b_q�N����8y|�Xw_�u���-�����#���B�)1'S�^��9�#�ZoN_����|�%�~�ith�ol<YF�ݪ*��{"��}�$.gZ���7	�[n@�9�,B.���\�����ˋfQi �7��J[���=�V=�*�uV���L�%�7Max�1�'�f}�zS3�n�J��r�'<��k��:�i�K6�0
6�� �Ske��F�-o��Sl��[��]�c�F<��!4zY�8���8�L]�]�X�^�Ub�UY=��.���Z�h��*���Ӗ��m����IT��¬T�ѕ����V�r\�X�G�_�T�}�\����
�ZgB/�i�kd9.6f�G���,��|��r����b��("�'�Y���0��݅���Dq�d(_b��}�J�Y$��`��S֥�[+W4I�J�(���c	E�!jd^B
ϥ���2��@P}�;y�b�{I0f0W�\,d�.�#'�C�;�z��.�g��3��+��9X��a߮�����������}qJ���v~��]N^�~́zSG%T*�Ǐvo�¬�-^����u&8�s*S#��آwF�,v��-hȦev���L��xRH7�f(V�/����j�+#�S��=ϔq���W$��Z;��U��&�?���,�]�Dy��̶*�o}���Q���s���df� />J�[�#ε��?�U�U�-x�5X�ξfUt��)@<��i�3��,%W@��P	#����BW���	A��6��Q�%�� �/�F/5�җG]���*S���"֚�#M�SW37��;���t�m�	�y�\L}�#�*���7q5�3")��scN�͑��$������_��n-��Dg�.{֣=���6XTl�3�T��^5l@�_�P>+�*9m�	 P�b�X�=A�GB���́Tޓ$s^��Nmx�_�<^���"�Q�D�`xGr�Y���(҆5�}Z��{&S���n>����eOhN�<��hBÿQ�-l��cs���Xv��N�_��h�/K�9E����Ct��G%���7�W��)�S_}�i2yu��tv9�ܭ��~�4�&XA�v��z�����2epٷ؃���m�a~	�uS����Y݉�B3�\�!>�����v��I��u�;Jw��bXy���pʣ��r���8�'��}h�-u,hǆ��R#�MJ�z�����aNT��w��7�~\�?ի�b��g���͑0�>��_b��ؙ��د�/y�|�O���(�N)�*�>g��o��ս��?G���۵Fd;pG�{�B�Zk��Sx̰j���D�zA�d�᜵�8`X�S��|d2�v�|BD��p���G���ok�f�<�<v3��(��3�/BNO_�k�ZY�����tA:[h�_���8B�?�i��m� r�N]ڛ�� �ѷ/ߪW����2�����V5��u��������� ?<��Ҹ�y:��A��k|I�q�f�����d�aP�U�ԣ��	��0�0�t��y�k�5��Ժ?y�-֓Ks���N�!@��	�G^�볿�l��g�$���0����J���w+��m^n����xDL�
5B���c����F޳5VO�X;�.����O����*7��k�>��M_�e'�����ܸS(r�)K���H��t�~�N���G =�'�m3����1�Y>50 N��ގ�m���E/�8FF���ô����XjAW�s��g�8_L��T�~�Ę<  �I@���h�ȱ> πOt�ޑw�_��� 7vs�0]�ڥ�>#��`X�";q��f)�B�e'�����Vӥ�y;LL)�=��{!�J1����r��'�$�%"���.^�����rn�s���s#}f����ҫ���ão���Yv�����H���j�ᩁp���7���5�5=ۍد����ytxyI�#'��P��B���}g�y�N��E�x�&�'�#��{D�Y�������q�L !�Z혋
��x ����}2e�\�&� * ��\=8q5�؍0'�w�dJj��q��ޙ%��{�j�r����<�2D��
��S���y�D��S^ð���_f=�:�au?hr\;��iH���ƴޫ�\��I��Sr|�u����ꇩ6��!ȶlg�����Y�u�L1ɠun��}-����.��qM���5H	�^ݮ�/Lx3�k'[��E�*B-�wt??L����m�d�7�9=��9�]Mމ��k:��eA%1i����Vn��+_k@K'/b]��Qtzb৾&QP��K���ŗ��P��΀�݉�&1`����Rn ��on���mEvw�#]&�my>�oq9/��VŤH!�X��4'e��V��3�zZ��w�Zؑ �Y�{HkR��bދ�4��=hJ{��W/�����fr�Z�*v�Z���ǭ�T���0����6��E���_�I'����px��W4�vh��郩|�b��ݍ۝���v*'I]s�g���~`z�/^�d��!���3�`�8�0���`����J�*� �*���?ߔ%9��+�K��o�¿���*�p���7x�;���2M���'��٫�9�с    �آȐ^����!|T)�_�
��ƻSK�����w��X������9��=�޿f������}��p+Zn.]9\���|��/�ʁ�5�L��t����� �P[�O��5��ͳ���E�s|�_l�v\��]`��l�ǭ%o���U����/��/8j��䬬����2�$��(�v�\)h�yc�xZJk�)ֈu_�8��
���1�{<�m�W�Bd ����Ԉ�a+KwX�G�d���j�.�҇Ji�v������N��k�����Q��k�{/��ӰṀJz3g�<lq�+2��
��b�k?ܣ.�V'�>=��>6�M�n�x�e�F	��?w�t�̋�ߺ�G>� �U0��]������� ��y�f�q[�W����3-�3S3��U�%�%�˖�A*��r�Q8��;�zd[��G,?Y&,��M��v��%~wvű�q�S;b�X��eX�X�h~��韛���ߏ۵���Ea��}��/+y�S���(]5�<�>�pX�����o�_�D�s4\�q8��ٞ��{�E�ri	�i ��|���V���%����2n[�#UT�*���!���E�H��*��{�Vl�?>{�WO4�bp9)�S���_7*�8C�Y�d�����㍒Zw&�����_�G�lŐ' 9W��Ҹ��rE����Mx�>Щb�G�d��H����>�D/�e���H倗�Es5޼X��g6z8�ދ��GD�;�kȒ�4�p�`y��^-r�nYB���k���*F֦�ś�r ����A�W�m�L"R����yԖv���U�d՘V���g��y͡�5CӪL� ]a��^�c�`NK�	� |����W�(8��y|F�������KR��}<��[���}���x�֟� ���fnˆ�p�3�#�/D���kܵ�	��K�4ih:Ec�&��+�L�ag���VR�[�٢�]��m)�ٻ �`J�J##�!,���f�W����E������
�'�4� ������lT��f��po���8�q���AE�cWC�XE#���Ӆ/�Ζ D�I��x@\A<[�dB��
7*ha�č���g��?M��n��v{"����8��X���Ɖ|$��7��<������k �k��o�"wʺln"�ڳ��6��gb-�׍���_��@T~�7�� ���/�H�U�{#e�Q��a=R�<�-%_��W��o���f}a��3eՆ<�y:<\}U��3~zLt�_;V�K�p�x���(�S�:���X���p�.茒�N�|��|��D]�����TG�>��@/ݡ�*\��6��K�b�j�^f&Җ����V ��l5��a��*9D�?�~+���oI�}#[h#��g#ކ�L�z���ۧB��0�F-�>X�5c����Ã���?�)ԟǽ|(_N�' !ܒ��$��&��X3q�!b�*���Ҹ:T�{���X9��o~=����AMӬ��o����m����A�b?��@ܔy��(X�V��L�+�}�yGW�����h�W��L����}� $�jH�����׎�I5��yڂ�؎��/3�5�v�Kj�PFb�e�h )z��1~�K�*ϾIO�<�u��a�~#�5펶�I����8v��(՜^FR�%H�u�p$>N����j�5� *vs'do<:T-�g��3�Ͻ�Y���m̑��2���R�0�!��)Π�Y�	:��{�X)�B�Yڪ��ܵ�ߪ@h�����*�Y�,���:���{�4��!V����N(J2�vyM3U=��3@l��[�*)�av#���]T�N��>ږ"��K�{�8�௹׿먧H\uTƦ��-��>���	A3���P���]���P�8'p���:����%��֦�1�EU�)C��`��N*�*/����+�}4�=H�Z(���4�4d�U)����Y�W��{������v����"Y�]3�%p����ա)�O��z����:�g�T����;i�G%������٘��3QM� ��as9�ԇ�>EF�ܛ�4��MT_z���f:9�;L�%��5����)-�а_f�!�@@�`��J��U\�;����;���߻;3�OG�m%�?r�{��a��߻
�O����˫������?�����������g(ZR��g��53����?�O�V�!� d�Lϯ�l]��=���,i'��6�r�Q"Q��A�5�v�YV>1���I���<�|��g�$h�>� Gns�-s�&<wU5��]e�ŞKl�|��Fj�I�j� �	C�+�D���&�	h9�Km�Dm��	��-�OQ(r���,�5�� l	C-���K����%����^��Z�5��d���`�gɿ��Sn�GZ7�L��0�V1�Hό�X:�FT6���9�y���R�������?s2����G�(�DPͩ���T���~~�^yA>�t"�J�_v:G׾+��o��͝ȋ��/��cƭ�{^� �&�b�&�!%���`�m�y�^�pݞB���їΡh]���Wl���(���0j��g�l�ʵ�S��f|�����Z�7��͉�B��
]4$����:*��RUK��u4�,�i<5P��c 7�b��w���F�TZۧ{A���T����M"(},��I��.S�?�����m�2�����ǅ�����`��33F�j;���[�d�WK�`�y���>>'qwi(9P�Y,�f�h��xQ��K>k��}LW����
(ch��KM��-���t�Y�p����'7�bި~멣9��mnR8���`p�J�*Ĺj#��g+Y�+��7��"�� ������@��=�������^ƽ4_�{���J>�5�qy��WUKJ���T�V����3ұ���vF.?M�X'�k��%�g�����?lEn�*�O]�܃���
�t�-s���c��&S^�����n����7�C�8��4�L�u<1E~�����%���6��~��6��;&afV�s'^�OPx����o7B�ﴃB1sB���r�ҋ�pT}���M�����#D��eh7�ީ�l��}%����=oYi�[j�|K�z�Η~]:�^_�6z�I��m*�J�(
�[٦���2L�u^Kk.�e�D����n8���C��o/̵7�ҮA��=��%。-��g��J;����
����;=�̖D�7�����~�r�I�ܣE�ъp���ߒr�)���(�>&��Σh�^��W}���[�M��������F�6[,.b�v��^�|K�]r�l�QT��8~\����u����3`�c�.��8�!�M��k2͙��`��;�}�,��j�#�I]*�����7p�Y��##�_^�ys�X]��&��t�^�Û_���^�q�KԤ�s�0/}�Y��λ��]�r��aA�e�{��P��bl\Rt�Hp�WS�1_N,�΂�a�=����Tt'8�]{i(-#4 ��A�M�]->�h���a��x����m��Yn�j����3'r��������%��ܰ�+��õ�U��>��!H�k�d^*E��j>aM���e�O��o�-޴�c_���W���Րo�k��i��!���s�X{�eW�(K��~��Ύz�o%��D'z��{�o:+++##\�q/'�֖�b�9ǘ͘?�P&:��E��#��c��-��7ݎ&?����
���%S���WXn�n7Qr޵ϗM��<��� �d��6��|F o�1d�uڎw ��B���0�A2D���{�~hTb��c�B���]������BH�P�wK��Hb]���eb_�Bx�O�Q[�+��-?}]b\�e�2��TA0�k�d���VU� f>�GUU��@P�2���J/�G:�i0M��~y ��'<�ڑ˙f� �2�K��:"C���a�>�1j�[���Zy:��W'vsk��3<���9 �$�q�!W^ʷɪP����h�vł�>�[k)��LKtO�陔w��~3 ���Y
ߡ���*�5�
�"��9�@4��8:y�    �r�mM /zr+�AS�`�T�86����m����Ɵ���k>xT���'����# �^��'����>����0��`������X˷^�!���V�ا5�<U�)���J��� �(X�3T�5	�N��F��P菲�`Y]`�O�$x�^di��e~�1�l��Yy���(MI��������;��CH�V��ߒC�ǆcrǅRī�'���"�~��r��#N���v���v�O�����q_���^�r���aGi�0;<o�%w�.��Y�8^wR�[���_��_��?#�O�?��p�C{j������x��X�&k��o�yek�5}V��w���<[J��?����1�j�?���T�oa�'M���P܇z�����hǼ����N���5�ϱ3����R�������^d������z�ˇj]��=�(��%���k+��y�ؗ!�u=6�f,�`��&�*���B�����6]�G-�B���}*�[�紫�Y"������J������m�_h�h"���//
�w��7�=?���ZM;�d�G �MϷd�׋� �m����5b��)獫�DT�U��.�e91��&�2Cy'��Fz|s��(^]G����<�1T�����)ʄJu�_S��&�rX�Χ�d��%���1�)�T#������h�"d����]� h����v:x;�g|I���a���� ��*�G�/��ȴ �?T��Ɉ�w$�/0�M��5�v~�8��+}h��#zؕ&f)��
1Ȝ�Y��?[�=��J����:����FN��Fk�|C:�L&A�(�����]�۪���RC|@e2o9"�u�s�
c eZ?���.�������@E\+]�<�Թ�|缁�9���^��=77�7���s��o���:>Εa���}	kY�U���dt�X��|�տ �OI_��˿�˂Y�6��pG���}�
��R�z�m�3�Y��V&�o��g��R���7�\,S��M���Q��,)��j��=�]U�Ah��b	�_��3�X+;��N���i�!-6P�4n�!���?��)�f��N�3��d���Mx�!��rw1o��6S�P������y��A$�O�v%�m�	K�eH���,�/]���ou�^��;i6J�H؆4]z��vFiD�Ȁ��2W�MO��� x:��|�r$|� ������~�������`������-7B�8&-��޿|Rl���ꅼ�&�����b.^M�����:\SҬ���s�6[�bl��&�|�k֜ӐH���WI�1��Q���T���������T⒇*x�n�;#\�w�u��B��I{pμ?y�m���b^�������	խ��F{��������ʡ�7���q�
�$I�$�����/A�"�EYP�L_"�^��U�-A8JM�r�����!��ś&i7��B`_P'8cV�]j�!E��O\� BRei
�Ɩ�q�7p��Ǹ괷p�_��"�zԚ,�x�0����1(��_zy��Ѭ_�'1?C|a�py��kN蕛T��փJ�6��I �s.��^HE���S�vs� �E�pF3L���X���ix�pa�mk����8�O���l-i���3����T}�J��Q�-���lش����J��nn�"�S��bH��wb��PI78��'83��p(���;?w#g�ጮ�ѯ�qGO�R��Bpm�,>���Oӓ����р�=��'��������O�U^�.�k奙�.��N�x_1)�����g�>?2� 1��]����9��C	ۯ�k�v3t���!K�-ɼ��>q�K�tF�$n�14-���.�`�4��ĵ�m�������Oޢ����]�"�ٹ��s���]%ac���c�_�ڮ�e=����v'ўͰ�^��<?���L6�W
�C�H�I�������B��BɊ�=k:�=��g�3]�-���8\����́����7��;��w��tq#_��Uu,l�3�d��P�oh+��i�ȟ£o;�)�o�K�i<K���\�A���|�\��c� ;}��c>����������`�7`x_�P��q�J����{�:�!��F.r�f:�]���ӳ#�O�*��w'��Ng����q�uמ�AA��B���o��;t��'`_j�Qs淹6Cs]@���\���٫��Ɖu'O㡑ȧ���5�6���3��y��+NS�l�|f_�H��P��~��]�+�?<w�S�
þ��IhԂ>����R!�m�� �w �7�b�l��3�1ñ5��~ANh����]�nd�,�ss5��-�����h�ǧ�l+���۶(��/��87��܃($�I�{���jC0�Ou�"Z� 8�#����)�K�Ͽ����(�xz��8�)�(|�:��mҫhx��/�i����.߃' ��r��vqClz{'�����R^Q"$Yw	d��8-~Ԩ���-�s��F.vJ�1�r�w�m�9}9Cf9MQe�������G�O/[%z�����b��X�]��?���5�ȷI*+���L�q�����q�����%��zR�&7Z8��ׄ���P�S��l��y��a�10��s$���ϟ8�r,�����t����'�+�����YY��#n.�Gȷ�R�Y���ּB�/��/6�R�*��+��E&6Ɔ�In{'ͣ6�����P�ɻ����l���c��g���d�F%�i��g�)��޷��*���t���##������G�[߸E��"�^�E����;�qG;S+6�?�"�E?�a�*6�eG<�K�4 g?5���&�T'�[%G O�ٷ��S۩"���-[�r���ь2��+�����1E��mQO8u�Ϗ�{b{��M������I�5������}����H�v��n)f�M��i��U}Ů�$�v�J�8��F�����xQ��t틅�IO����C,<�S]l����u�	ˣ-�8J�������-	
	}3�T>�)�N<����e�-�"|dU�1�R��{3k��4�Ѥ�uS?���R��]=�> �_�x�S��y��?�����2�c�QVq�iqTl��L]ͧ�l���<�y�É*�G�{���0[Y�z�Fԝ�'5����B��G��&J�\4eH�)��V�:���^�=L�H�k}�J06�y��s�a���lb�|����4ף�lA��U��0d],��|-�OX�UP�~���Tg�����%t���Y�\ǬjR���}�㎺	����=��4%��m�8�3p��T�����aH�?>T�^Ƙ&U5�ӑ�#�<��é��9��o|��>R� 2� LSb�/׃bR=��T]�Rހ�P�������uu��p;Nʜ�s^�|��;�Z�~y�P��<�.�
���v���9-�yՎȤO^ܸ����΍o�o绵���=�`�e�)�Ս�=��[#TAig��%�N2Y_������0L�0�[lLE�Z������E�X��9Y��~��c���Jz@-ɇIppae6���
�����\������@�M��������C�~t�p͝ln��q��u�t��3GUjf1��J���m�Շ*I胕D⯐x��R �swid����ށ����:���T�� ����ހ�f��ԏO�L2[8�,�\)��qp���$,_�un~t�^\$B��[�?�'��[:��`-�_�:a$�հC���A��XrOa�_�D����e�;��e3hN�a�.l�0��k�S�Zq:֍>m�ꊔo0ߕ31��,�"�-�6a��SN]���}ܢ�g���%̇�bA��[���f����.3J�Ne��@��=�a�?i�0��3�i5���oU/.l�	Flò��LAoL� 4e��G�ɂ�`�=wl�#�缴��������G�< 1p�=�s�N(_E�z��b�����`�h)#3j�zGܫ.�cڍ	֎��}�
��O��3�~�>��%��v��|�]I��˵�d�B��!&W&�ɶߞ}q�a���/=2h�n��Z�7g��N�<�    ɫ��d6E�)m��_�Q |[�1�^�{[���Vz �x6�W�SEc��}�Y�ӧ	��<�����I�ov���Zy+a�9�C�G�kYX8~��|۟�h�!���V"��4���."x�����Rkh
%��W�	6%�=�u�[p�yHf�Ue�?����<�]j�괮V� ���	5y	�h��"�z�.U]�"2�uF��N��ͳ�uů&:AH�2��Rh�(��kK������lh��*��k�Hb6�M�o�����VC����������W�� �Iw�g���z��ע/�
��D�SQ'VPi7��6�M���Z�3��{�=��|2�VK�/�Wj�Dk
��o�P�pO7�C��~��sO�������ۘ�$�/�dC��f* @�9���R}�к�����O�SKjwR6 ����_|3X6�������(��1�V���}�
 ̴��ţ��T��g�����:�?_-���.�\�-����W��6|iv�X��zV���o�'��z��>"C�uN��j�
P�{2�-�h�\�t��x��W�g�I��{�C{�M�6wH�k��x�S�|�g��(��2]Z�� �;������2��k�0��C�5?��+��YP�� �(�k����HF��_���{�����0�}�O �c2:�0M!��D�YuÓj�5{�{	ރ�<t��H���Yd�rΚ6N��5]��vs�������C��/rM�-ϔ�w�6(�c�Y�F���;�+f�f�f>�5;�[��S(���BT�M���U'�Cx�'Y ��ņ?D)R�)�&����^t��זS�r� �ypS���?�b����6�'>r7-�@m���A���U���h Cx��H���Q�@T�搙����H���3�}~�� �	��HN�%�@�+/� qU$��c)�%�c�x�MH�z�̐���%��-�+����%ӯ����E��{������w]`z��� �� �TG���\��J:��@������k�miDT�(pͥg�C���K��RKC���)��r0x/�mp�|�kfű^�]һ�J}���{{�v7�s�U�;���r�78J�|%�y�u�MA|	3��8���o�kv��N,�Hl�ZR?���rxm�B~��s��O����kZ�6�?`��wFI�����'���{'�N<~����3���g�>����QJoIӊ{R�� �ՉZ�?:��ɦ2<pEA��5� ��I^��lđ�]6Y�[7�k��7zM�Ud�"(�ʟD� h�I��״(*˾�O���Y�%�-tcI��sb���f�Xs�]�c�2���F����h��a�f�~+g3�e�_��X�eL)��q�ܟƨ�����0Ձ��X�E	��j�RY��jX�w�[������I��Ro��?{��3 �ᶡ�����y7�u���?�(��4B��|�#Q�.�5X �n�]�ՅT:\|��A~?����S����w���7j�����(ˌа��<�D����?�6��~mݮ�m��to�o�@�76�U����֪�_���n��W��'���ř�M������ɩ��Uo��A3�0���W��"D�-�Zf���@Y��z�Px�Zw�v�v8ũ~��=�!�;���q��vc�K;��?����&=�7Jg��~�B
dDI��:_�䃒|�N�goFT�Eg�^߫oP��=�?� ���3����d�>O���!��)�����U��4?#��	h?�J7[� E�kY�|���ˀ��_�����Q�c#��@���W�D�������cg�	������c�%r�7�#�?�ad!�5��h�2 ����H��괐�>�{mO#K	|!wd*��E�=��3�$.&����yCK�{�|ؒ4���+���[��#��J=g@�������2��ϢS�5��4&�����Pc�O��e�(I@��^(�$L�+8T�ց�!|�i�y�=�y��n�I�
E�7�|�nQ\o��EH�[��	�%��-V�%��fn�Kfj����|��GX�O��3}o�鿦q[�
L�^�Hٙ��q�ғ��� ��%�:B��E�]`���tsz��/҄�=p)?h��ϯ:n��'���<�.�Д����20�ͥ6�Ni{��U��B��E1e��4˵*˜҆Sn�U�.��>[p�;��J/��Ԩ���O�y�}��:�A�����[��R���ņ��$y�����`
ӧP9��_��2�!��_Q�y�~S�f�{8�w�����[|�Xğ�>��ߢ�c���k�F*;Qd�wHS��B�W�)e����L	�B�~y�m۲��E�
����ލ�����U�o�g���1@s0�X�.}p���X��O��n�n^W�+��fp�K�i�����������Gg�o��7u��o�1P�������.���c�k���V7�O]���J���Tq+X�`ٺ߱� �	���{��p�r$6�y��L���	8��~5y�?��J!?
�)]�!�R;��м��S��H;S�~�<���3�ʀ/�ʧT�"�������E��=���^e��n�<��WH�w�N�M��b��,ټ���ba�j�ZK��-k�6�-v*���P��?޻A=����E��Ǳ��Iol����ax�Q!d��i�� �t�l�λ.�Q��:�L��DIl�c�[���x�x�ګ�G+R�N��6+a������~�Ɛ�?y�����%E�!���Q�=�$"n�
�cl�7�?�3���G��-.+iz��,�%� ��k�/���}"�oMU[s�C{��+xW"h��#���݀�Vm�z�>�B���� ����@"Ap|z�#[T�ND�)/��Z��"zڗ�I��X�4s>����Oo�@���&N^��s��V(�8'E
M��[�W$��,�RH�*�I���Ǐ	&ΆX��eU�i�H�ۣ������n�l��e뻡���䍥�磠�ps����\Ë�w�Ɗzw��zz�_��d����������T���M?�o�Z�����G��$X8�;�� /E����	�أ���^z�Iy+�ў�!�=Ip�u��(��E(߷���Ts�D��*+3�II������u�,�"�b$!U�y)>J�܈�;�����q�"��G�Ǭ��w����	</E$d�6E]t�a� #©�n�h��GA`o7r�qy����8����a?�
�〔+�F��mHlhr��=2�m��U;GfqS��fYZ�'�`���^��*���W�-e�ۼ�՜>��y}�]��E����"�࿉%^1A��8��w?�����YM�_���' �J|I���� �ؠ����B#��'����cvNO�4�1�����KP �[�»��/@��y���j���4���>A
��W��{v��~�_cC�s0�D�]8�͐�|�[�GnuϠ.TGx��7^��&�q�Y�n	�� � <���bn���5���l`��[��	��n�&6���f .�Z3��W�>�O�]�e���͝��6��b�n� HSÏp�x�[�9�^:��O�v,���o-΁S������pE�Sҍϯ�ܖ�_^v����>;��h�X*pL4���E�ٜ�7�E���|N��U|��{bc�v�O۞:֕������s>r���,�J$�Pk�C�'�o��gX�trϖADit�Mp�eb���d�9����K�?�::>aϚ�N������?�5���~�3^�Y?4I$�"�o�4�,3=&E|�mH�``�X���MX't:��0d�}� c��M���[{*�@�I�n̓�_��馺JP�;����_�>��1����k|�������w)����Dw]}	����׈�Η޶\�a�n�t���;������q®a����#"��{(���pB�e� w�f�E��`���,W��Y�O��
�g��D�1����;��?�m��������a ? ���1O�7\���C����>��($�s� �u�ӕ;��_0�;��o�0�>%5z    ��/�W�1�66pE��Uq�}���ER��L_����/7Ҍ�`sq���-B]F��&�f ���_�q0��&��%�}�/ߵO�k�ةmn�-���Ts��7�>����i�7��r��G�l*�'����|�4�1�d���������7y?{y �w4N)�Jv���p��6⻤�l&ɏ#@��=�7��]N
�6n���!��B��	^��Oh)͝�a�@�w�K�-Ϋ�$��b�A`̧]���E7mQ
�1k�N1�*0;N�$�"˔=�c`��Z+�q�D�� ����b�"���#`m��AaX�T���H�(���HT8I���� ��|�s�~Z??V���yb}cR��)���B�����2$9:�H��b�LE\��]�\�#~�k=��E����p�1��@cD&߮J#��L6n��9I�܏sj�kƆ@��n���%c����%�A0����;|9�_6RM�����~ (��� ���$�Dh\q�0���zJ�!����`?p��N�#�ָ�1�#��lF����	��j�~G?�OHҢ=����
9�0�>z�6�KD5���������+������Q�]���B���5o"����D	�c!~�����o��P�5'����`���>�s�e\�[�2���{��T a�t��.[p�$UX��93��^�@6�����?�����MڳEi�' Q'�ܧ�M
p��.��>��8�Ba=�a{*���@_V�x� ���e�O䌼uZ��H	������m6�Xm�~����N�b��������8���sH�
Y\�� �ǟ?7h3���Ҳ���ޒ������Ĺ�2���r�~�w���?��<3���F�������L��[^��G3� ��%�H���Eu癑q�Sj�vIZ=h���˱Q��3+ʋ�w��ڍ����y�i��?�v�N��A���o�4VJF��B�'�8��Nd
��b�#Z�<�1p����l:8P\, A�Z��ڗl�B2w�&�q���P�]j����[�����F�a�O�ӭ�I� v ��na� VQ��l��MD4�zf%�BEd�J�L�]�m���`eX�E�Rȹ�;~k��/��9Q��5WCH3�9\M�������\�S����"�I߶j��]��2�&Mq0m>�|l�g�ڝ��=_>~:e���\䦋-ƢS	|�a�1���J$��uĨBfh{�w�����d��tA���ң�|��'w? �@��'���p�_��y�
Ke���#���ߜY�JS ��E	~�6l�?X��n��8��ԃ�_1��w�#���o<R�2����I��
��[C�a1L��bz� �ϊ��#y4�$tU�����/`{��!�Fn�e�\�w=آSw���U>�� �����_�D3 C㑌�f"<��<o�?/�:D-Ǉ�~�C'��y�lw�����|L���)7�"ڃ�y��d��eT�"D��!�P_o�X</��;��(��ے��O�Yݢ�������E� �6h��@�e՚i� sL���l�0��[��-I ���⺤�J�'`42�u+�o;OS6� -ij�"��|[t�cj<�F�������)�9G�l�m���Aq�t���{`@���;�<�nݽ׆��h�93����
��2�#Qq�}>�r�]�%Ozi0�t~�)B����y�De�k�(�E������ ���݂�^(:>�F�y�'{�h�?�/I*a,��_s��R����\�ඥ���X}��r�f(>ʇ�0S��!�����7��S��K<p��x0<��Q�q)�7}"Ρc�d���0�I~0o|�l����u\�k��Z��0zys8���YMd�ߔ��!�S����3���!������� ��:B�����8����43	�\��
��=�;e�����^��79#�b�?54[]m~��m�c�͆kz�x�M�_-#6bNEj�6Gg����{Έ�S��-�zt��k��L��/��מּu�^	�SD��|�Pmĭڞ�>����Ϯ�z�Y���%��"s>fF�h�5�c�Gk
����d������"�&ɖ�-;J���ό,�"���W2�{��|��tw}k��^ҵ���� � ��eiD	�>�j)tc�ͮف;���6�b���$�����+7Kw��%4�1C惛�^�������iA�&����|.�	:^ȑ2Dq=7�^�Ia�lz=�wp��02)��{��;�Q��\���(yfB��ʄ/
c�(��Q���/|EP�j�$�~�{T%=�=���=��Ӿ5�Z����CZbG3��"#	�'�8*η)���Jv�_ؼ��j�CdcWV�"L?�����MO�]��z����׷�Om��Y���|�0�^я�4(�Ŵ!�N��ryͽ�����U|���B`���P$y"[�迵T�ŸK������s�! ���Pd�|��跻����|���\�	�	}o���
b�P�C{��W�k	����\_롯c�ണ�	���-����:�Q]�"0�$P7=G�M�ZJ�c�A��qƀ~m��>`E���yB��U������Ĕ���u�v��Oڠ[�w�P3Tq}��6�J�΋zq��-!˅�F_�_����Ty�t}�p����^�0�I��g}��m,��l��-�=.֩������ ^�N�`�<]ď����*��k7��9�X��s@!���|:j��
�H�u�&���W�c��7��� ��Ŕ����0�mSK�׏�6ܗ|?�����e��&O�^��G<:2T��m�t{IC���%���/��)��b~~�P����+��j��/�4�%�f���� _��.��M
�l�E��H�+�WǱX��,�M��J��w 9u�����JU�W9�ڏ���2Z��i
�^���Y.��8��#D��!��uu��r�e��'���w��QwL��m士C�K�A܃�X�Df�n̩?�[�8+1������]W|��L4
�����(`hv2|ȥo��Zg|g,O�����~B9�OL���t���3�����'#��!k1�5�#�.?�]! �o �}1�Ĝ���|�#��"`����	Ͷ.�B �#;��zw�=��@ZKu�4R*0��֥��oP��8�U&�~7�{K�Rk��iM͏�$��,~���M���3,�`m�XH�u���wBY�59�/�0c�,h���$G	�?�Ѷ;�Y��������o�?y�����d�"��N�/��'yk8u��HG�nB��_��g��S-C �Ԁ
Eh
u\J�}c�� ��}K��O�MQ�X�I�{�zu�M-&�� 鷂!+*�{��X���Ϫ���\�u�Fm�w1��-��-eQ����2��`� 0n����<w�@��e,N�yjC0�5|��k'.m�L����DOA2�c���|��g��U����
�{zȟp]��3���}N��J,���1ӯ��[�k��LK�[-�G�VC����i��Ĝ~�oyΏ��q���K�>9��Z_����1�9���e�-��f�F]��l6�op���Qƹ�î����O}�d��\�kW�m�YN ՙ����,�w ��;m�2z������󞻤a��}�4$U]M�S+�}n�f #��!x'�"
��D�2����O~Z�s�a���C�� �$'%G�k�Wt���W�b䳋��h},�6��zF��?�&��!�3,�[� �j�F��P?^�A�D�������ȼ|E���ǼI��~�3�TԖ���Up��3�z����`-��*H�S�Z�I&2P+�YM�M~8e^=���_�7�ΒM#�,B���M҄�BӝG�;� S��B�s��������1E ���J��q�o1����L�����7Ȣ6�H~��k�S�w�����?�h�9�A��I��	}�%�P��Nn���&���G很���'����"���6$�_I��<�i���h��׶������=��el    3@	�䚙�h���@(��Z��vYק9Aߴj��p߇�?�q��j��sZ��a�y&�,��1��]V>�M����Ţ�9]:���J>�q;�2J:�Y��>by6E؍iX��~����3�|u�ބ{�:��O)XC�#�\ōld9o�Qk�N�>#3�߿���H�D���赿���[3�,oG���A�em��9��J�9���5�/�,�:����J�Qt<�����o�aw��84Fq�6, H�up���;iQ�w��Go��&2_�8	x�SRV��=F`��p/�E3{6��o�}CF[�&9p��؆�'q�1Rjn �|��"�� ��%��o�?b�W���5��-��8w>�ɕ���$�}�#<%��~E���ǹ�A-�U��56x,,zB�p�ɕd��$~?g8X�L}L��k��h��e75x�ד�t���+
�V�۶L����J�5
8m?yCXB��r$?����]�L���׍A�Z%OЈ�� �"C���5�[� vQ*����;fJt���AO��F��%,���<_���Y~�>0����8͓sȪ&ќ�X�x�L���i�V̽#��}���[�]ɻ�g�W�ª�Q��'���us����/��t�f��T�K:9d��W����Ϝ{k_����˙<"�m�!Q�\T��~��K��5]pn���~{�0�2l{�a��#I�:�Q=�R��R�.�h[90�*a��@�N�}��!B=��Ȏ~�,p9?J}|�AU
9}��p��	�v/7�Y�F��yq��>]q��>^�ƪ����w����(w���JE5K.���x�II�9��X��w@.��3�]���p�,�>��/!��&(�B<Q��:~ɂ��d-��I�	z�i�1�k�`��H�{$,}h� ���,ܹ �n�]���e���f{�ƑH*y���� 6���hI���퇝b�6ð����7w-X�׬�%_��ìG$6q�a�g
�Vطݝ��k�ݫ��AW�YX�]p��W[�� �R��`�N�Tq"��;��W���x��f��5Y3�ì�~,*W�q5=���k���4�Y#?Q�i�	�)�Ї24�ͤ��W�w���y�$��p)�FPZW��ϝ�]5�������&¤��PX6�އ3���p�9�e�6/�O��%���ܭ���} >P��,�[�=^��h\���`��ݞ�霚[Tq�~l#3����� w3��46�Aj�,��w�h ��@�F��Y� �ݍ�"���U�ft��}M���!��p�J��Z���t�^y{$�����di�fwBۡzƣ`�f���f[���3���o�����|�MQy����"D��&H��y�Z�
^�ի��:�k���Ο*�� \���i}�d�^E�&^��|u�G�Kz�_�yM?<
�*��K�[/u�?%�(�;^���c��CC#���������w���,{Jl�����~V4��ң���G6��c��
���y�5&��/���u=�ʢYD>-r��l�����U�e�q���p0h$ri��E#�@΋���+;`������K��:5M�OR��E�T�v�ڗ�2�1�L�.1�i,~M��h�Ď.���C����§�l�b��������a�=�eG�$���-A,��@,���p�ի�.�����I��7�n�jn��{���tu�`N�_f|C?�X29�y_�N�
�1�X�l}����>���o����C@@5�����Rc��U��T���Y�{U96A}|�:�g[���@H�U���#�\Ls��i���A񥹥��2.}B���}����'�U���E��׀�p.����B�x��e��e��sF�NILvM}Rq���)�ʴd=�2�����U�/x�������1�a��|h�NdB���i�]H�#��MԠl�7�8��MS����V7�r��OT�Bƶ|�σ���>�V!�z�M��x¾ި�,�×�(�#d����쎑^��~�P�G��;�l���j{����=��
�%Ë@�̀ x\�2 u���i�} �!G^1Ξ�z��R�n���v���Ț�"v󞸒�X��7}��4��n�
��b�\3�W���{�\)	s����
�V�(s��(�ܷI��?�7�$dU���ow��ν��]ys�Gh�ν�a?K�~�����dCG�`_�q?1��"�o��yI>;�R^��*l)�z�n��{1Kkʽ�o�����{^�=L��+�>^����D
��sPRAU�+;�>�.r�N�o*��q�I����@��/Y�Ls�T�1QU���ժ��2C�xF�'̺����`'���4}3�M?\,�_¬93����1@yb������
-��͂�ʹ��3���A�O�0'�/#�u������bw���u_��W������������8�O=���'�Jh2U�Tу;)�,��e3��/S�Tm. )~�͚��MKݔ�;������"�%e�<�ƎY�=�t^9G��V����SXX):'�Q�A�	a�Z��*�XZ�����HW=��&��t����Ŀj��OQ�Ѽ���Ny��g/�]�sO����	���l~�O����0_���������߸�����6"���+�	b�0����&���Y����|ݧ�����'��w�з+��
q���4i�4q�T?��iBBɝb�~��12D���RVJԪ��.A�,c����aM����\�[��9�3��V�3��'S�f
����oǣs QUGD��!���������q>�Wo�ɒj�cD[����FH�@)6�:����'n��hf!�]`�Y�O.�f���C#�R���w����|�s?m�����n0�s��~O�IE1-Bػ#�s'>jD��[��B����1���������$5��UMO>��^�� ��6^�i=F�/tqRݣ���h���J/��P��?�#��E��.[�t�7��K\%-s56!~�>2�i'V��q��]���1ˑO��F����{��/��S�D~Dj[��o ���|�W4#���g���d.<0ݛ	��E-�>����� Y8�3A�F����{������?�*����R����޾@}��t�|� 0z7�r��#�Z�SG��%�������P��_*z�W%|l�aJDm�FǗV����ι�	{���}Y+�6��#"<%����g��H�H w�E3|���v�������P)WO)�	���/Ϟy�%dՠ��r�zj�;ͩ�ΐJu��N�,"CA?�a��?T�ш�e	��%�	:57�5
	������)h8�N�I�1�-�*ҏq���tШ���ʝT�%�a W�1�dL�����0:��6,�j�T���I�
b�1߶'��z(�0؟����Y��}�y�﷼���(��&�����V�y����m	K����]��N�<"�S���o����\Y��v�o���p,8���U]'q;�J����Y����ܮ��;���Kv��^�Vc�^��S�.ߤv���o.z<,t�գ9��O�<f��}|��0��`�frЀJ���~�~��t��"wI�}�#{��J������A��w1n�B��U=؟������6x��G�z����pc�0��[L�#���!d/�6����5�����=���h��.<��+;h�>��W�����c?s�%�xL���w�~Q%B���g�Z�Ŭ��ws�o���Z�֧b����j��{C|��G`���ܒ���J ����L���L}����'�H�ȿ�2��C.rt��\�i�?�n0s��~�e�I��w��LY従�Ql���	x�kK��w����IGƄ�FG"�$��M!�0:���#2�=\�À0(��g�W�_�@f��p��6�Ʋx3���xHy�͝f0*/��9�x�o/eE�*C�X~�'�8�Xo������1]g?1�o�li�^<����"sa��h�aE�}�w�_ұ�iQ�po��d>�#��^Î�?�"���a�.3}�i�"�0�N�_����N^D��x�$��� iŶ��`l�mu��y=}���i��2ˤI�{���<ƎW��R    }J�4�S�V���7͡\�./�"�
�?C+a�)ed�C��e� S��%n���c�W밬�27�C�k�gi�)�����.��sf��͋t��w��U5�9�57v�+�Y_Qa[zu�ս�����Ĩt��7�/	�(��!IR{���	�ryL1��V��_�q2�!~���b�����ky���1���i�vI��-w��#Ni��0~mqwXٳ���֊~ t���cts���%}��4�{�s�4��Ж,��
5=FzL��7?�F?5�G_o`6z���?�b���^���(��_������#�|��C��P��P�D�
�b9�������>���a\^}����YV�~�X�z�k�?���r!3=3��!9�N`��0t�� 4�FJ����}z;�i���ׯ��IC+�♿@��2���,ZZǽV"k�|=.(������3���V.�+���I�R�3��%�d�4�F�_`���yS#>��p~sC���H7�>�4���6�!ULгsuB;X����?$���3�K���/
�s�xX��QcM�x�Q�>�p����K-n��=���4ـb?Q�:�F 64M*�01axT �V��x
{J,]���:;rȁ�M$�+:��7|��O�٩P'��FI��8�h#�}��x�����F�0�lOM㺆r2�ƃd��į�����t��̪�6O�V�$���k��x@���0��
M$N�5��o�C�8���\_��&�����W���ȿ&<+��;��E��y��M|*׽�� D�X|��z.&^��t�E� �(
��=ީ���l}.�����X�z�J{C}B�Sl[���َ�W��4�A��Kp�!�*���1ʵ��n;�q��9 ?@�\�Q���nu)w@I33���!]:���1�~��3�zg���lՒ�2[a˔(
Bձ�g��������	`���M�F���ڲ��V�F4M?�p'�qs{����v ���>�❸��'.�pJ:��28�9O�m����.Y�c�Y�o>T@�:���3r��Q�v~Aw�Z#��~���y���>�پZ-��C���g�"��j/�ĕ�=�?JmY���fE�X���G�@�N��&��4a	���ل8�����e��L��̘�?{�~}��С]]��/�c�E�����=*7}�C�ж��2^<�r�X�������r8Z�S���:�׻<����vTD9ʼ��c�{H�����d��qK�n�tc�ɔN&�0olrm�܄�����B��+�bw=�Bz���Ew�k�x�(u}I�� ��l[S��ʒ�,_�<h�]
EI�y�\Qo6���������$��_��	�_����}��+6u�R�ɣ�3>F���~J7獶�:��K�GQ�Ƴڟ��3w)#����e�%�0m���ˌQ=D��|��q��9�x傭�#m�ۧ}�����R�zG�'���m���(���C]6-�=(,�	l�7@D$IܧN��>'q�0>v,n6���8�l��q�!ʑdOW���	֫��!�N�h��O��>
X���(��M���+&&�fJ.U�� 
t�8�w�M?X���3G�!Kܷƞ���A�fL�f'l(_,3���E@ӍV��/�8��_�cd2z���雷�U��{$��W]&ӧ�-b�՞+v��5�#�B�z�ZM�9�^�ʶ ��b�ױ���f�����i�#	�mͦj�u�oT�o?�V�{��d�Hm��$��"�ߛ���t"`�r��m}}Tn��/�הEZn^t̼���8vFa?��#�B ����C�IQD�Ȳ	x���.�m~�掞K~� �7-1�a=�Tqd>��"�N���~3�O�x�ީ�J�1xH�:i&֛Fi`#��'�:�����K�I�D?�I��Ā��,S.�a����M{;r��={�C*���s1�L�����c>������b�.dʾ|"[�ѵLnT𭾔�f������D51�?�7M�̬ ���vy���,�5�?�j�$h\Y§!����݊���.���r_�����Kiv���-����� ��x�Mc�������?��
����Ռ����F�Lh�3�����S:'�y���ѐcj���)���om"��s�p��6���$�j3�lI8�)@�\A��p�����P�?."ʞ����x��o~��r�E�%����9E� N��]���Y����TT��>��Z3m�&�����Ǖm�~����i��/�xyXo\؝�� �f��ah�5���@rsy\�ʌ��6'�D���b��H�ۿ>����2�m<s">$�v�"����Pc�:�h�Nj�P��RL���X�I@@�4��b>��A����/K̮f{ڎ&
��$w�j(b�$R���8��@�l�{Q0ʷ�P| �q�o�
��X�$5C.,K�>H<��ka�GK�m���� �f��:�W�cz}��v�Ÿ,!3���g��P¸���3ƛ�)�CX7��۾��!'��5li*e
N�%��v ��j�]�&hK���l]�꼲��HF����r?$����'a�[A�;"@w}��a^K����7�@:"�F	�Hs�ңl��Q�o�~&>,�L���c�H��y����Hvq�����f��&�v����	��N����	��I;���y��~NK~��6i>��X3�Vv��J���z�"��V9�6�2�bFk�HKY@#̒�0x�(�&���po|T�/<�Z�ʄeUT�Ao�$y[ rS0����H�J~J��裺���!3j�LH|i��g�ƕ;&8.�:����/�ԱU���!��G!_3:)�&O�C�3Up�7���7��wƽR?�j�WP��ܦ�3�h��jb.SA9z_��Ů��M%
�ǟi�s7J$�,��������K�(g*]B]���HY�,��n�E�I��v|�䠂�4i�	|��C/�5��Ȯ��H���d�m4�/�lv"��Fx璷�-�ߥtN�$�1�Լkh8#�Y?�*fK�W?Z�7��0�jKiy�Au�6Z��ojQ/�t��&S�����>�d��6"�j�T�j0�5�$�����g5�|fZ��Zظ�6��#�D�(�9��gm��(@N.[��;����_��z�m�H��P���W�ǳG�|�#��->I�t ������m X0~�1���'p��r���B=�wp�W��QS����l�C&&;xn�䮝�N(� ��l��@�?��^co�Zgg��Y���#�H7�fBe��V|�P�]!86�D����0��;p;�*��\|��́��9�t���Z�����Ρ�n �B��Ҥ���է��x��ɤ�������:T�ei����f�&BPںu`�@�Su�5����n$;vrEr`��mm��\J��F�;��FZ��<_cV���̭h_F��7<C ���y'z���,�n�K�~Ui�aH����gF��^�A��߈�8���皕���/��dV����R:�!L� ^��;���o0gp5��E5c`Ǌ��VN(�����O�7^���^n��2y�p4;�Z��К� �@i_���	�pR���O��?r�$��� Y�ltg:�"�ܴ�nT �g�׈o��*�W��5�|c?l��dH%�د�p9�A:WW`��p壴�o�:�Do����a�G3�v���_׉'-O�<{D�wRlR����7~D�RA�K��k�ٜ��_��dSUMA�
�JT�@\�.�#��l_�v?���s�[��O��W��yIL�,��-I�aTї*�X�u	��}
V���������oS7;;�+*��N��R))���.en�G���{�LO�(/�>4�J�3Q�"�濘�ӏG�g�^	����V&Y����b�KTC5��F\f����NHm6��8]���+�{��z�E���g�B�S�P��OU��LX4؋t�"X����c�$���QH���	U������1��`�j?����F���>[�Zi���6�%W�Ƙ    �`!H�Rz��XP��GP'��_Q+CW�iq��7;� hOCy�!�O��]��z�c�fJO��7oi
9ũ�?���(�����{�z�K@}��'��r?40n\�,W]# �qMɂQe��ܴc��z[>�4��Ș�������x��b���	Z����~���_576yфڳ.����""Z�^�l��z��ٷ�;G,�M���~�H7i��KY���*$�a�<�1�m��t�!����i"���?�%Fo~�	��wP��ۈ�K�Qm��i���`n.?�ss>5O�ً�`�W˺\MT�l�U�9!�7�t��}���[�X�U���.��x��}�V�s�m��5!�ZJV0kLT��7#�<�L�S�  ���_݄xv�k�o�����b��m�7oz�R�A�N:(nh@C��d���^�i���=.|r�\�[A�T2��7g}�"�'���ƾh�e��v �w0��.�e��Aӎ� ��Rn�M%2�2��5Yi�j�a��j�
�3
�D����ě��;�\DoDvP��X��X>a_�,��?�4h��L/('8=���v��Z'NX�D�%=�_q� � ��We��d-r�6�;���H���Z�)�bH��_�G�ԣ>U@כs�;��a��pӸM��F�#��+ 3��!��懹�dt����+�D��?�7���,�6�����;�{_��nz��cS���+]w���(� ��n^*�"%;�華��A�����|zYR�n��u���������Z�C�uߏ1a�n�a&xԽ���銨�1�kUv*��MrWu�u����6��R/�S����8ȉ�f~��+4ѱIt����v5�_�ĉ	���B�6�7�y�រw>�����AZ=/�����B$U$�xU�d6FSR���3Y7�#�y����E��%=}��9���c(�%  hƪ�� y6c�R$'�wȻ�;�	?-7C�s�A!� 	�R �{�~��N����$��ߑ�x��O�؊n2�t�"o�J����B_�ɛ��Sgq6��';�V�M
9b|�Q4/��b��ϲ�?�����i�l���� ��;��BG���|j��6���>ܴY%���o�
��9��,O|�q��d�����φ�����2��#('ԏ*nt��Ap/ �y�Ɋ7���s�@�P}��Z[!���/ɧv9��Qq�7��
兩����#l�<���y]q����ȶ�w��Y�Ry����yU�� x�'���C�F�8T:�!��\�Gf#��]���П��#@�]�&؏��7�gS$SJL �#P�8��ȣ�w�B�a'{��Y�-�<J�q��
䒲E�:�M�Gդ �?���{�V�3E��?4��0���6�����w�RH#2�����840��9����0ԋ��)�'�y��
��+��36A����f-�u����7��7�vU�����Aڅ3k
�3]l�1c��� i/��E��;��x�:\'o��pz��IO]�Ɵ�s\A`�,b��Dn�����d����*$��^�N���0U�'PD�4�X�=�2�`�r��Eh�s�w��jqPw�}u�{]�,6�CA�:hZ����F�M�j��D{a�">\I,���l7�ٸk?<禲�M�7*;�1�l�'�8'�r��H~�D������e�l�u�j�,��o���@��pn�z�<B应l/ğW+Ϡ$`l�H��������$�́���}�A2���~�z�=��̇�f�S��gܴ����	��}�&0�a�N��*���SI|6������|����s/�]���sL,����������'*ȣ�MO�:����\��p.�a�.�偰�]M�*��.�#�q>N�HО�E��@wbR�/���$��_�<I
���V&�<�1�0Ê�id(=b�tcSa����+.Iƣ��ȳ��+6yf�����R����F}�F¢���=����;P�)��8S톗�T�1�����-�ڴ�����S��q~��j��W�>��[���;`H��Ѫ�����<15�wI�h0P�w�|��G|����`�=b��d���;C1��p�%fzg+Y�(���^x�'���1X#:]���������B�nC>4���{�8/;x+�H��g�nVw�3���a5�R���^�)�U-�T9�O���D�����Z�N�>*N_9U���	�=�rU�[���&�W���lXw�������I�6u�K4(�K�c2R��ܗ�b_���[��S���1^@����tC�FQp��;�D&�5���A�'n@����������L�0?���/�.z�6^�)3v�����}Z�/�a��� »������>?�^�t��u��^���ι SO(vBכBܱ��K��������q�&�1�5�ذc����ۊ������/��A��p��� w�L"��a��I���fjsӋɫ�O�dA0[b��d�!q:�~J刧�. ����3̫-G������& �B�mRul�u�d1Z�f:�J��o����oN��̷�?ph)ӉY���F������w>w�~b�M|<���O�g�R}�-��F�p	dr����~���\�'B�[jdL7ZzL���g���X����9�3�gjKk��O���o3��-�*9����=�j�A�bC�����@;0הy���@�weQ�j5���%�vrr���o���>x���R��]{��6��䓈G��*�|��#PC���<�F�����h���z��G@R��߷���!�OtE֩�
���y�|.o�ъ"z��lK|�?$�a��&ޔ�����l��^~ˤ�O|����}�"o|�0]'��Z�7h
]�S�����ԊLso59��c#�4b�p� n�H���D{�����zBY�n�;�zw:}�4�B�$��a,.���_W��5���~�<�I��߿��c���m/Z�U[I0kMR1�����9��Uĕ�~
3�D���uz,Ӊ�7C(������*
�#��2�-2O<
��k%�aƈ̉����[�QYױ䉩}��R��~T�?@߸��#�1΍��a��e�w���Fl`�L6��$�%^�T8�̔�����cu�C�i`w�ϰ�-���[��A�7�Ç��mU��/?M��V7. �����x������7Kdy��b����(J�b��ǆ���yzf2�-ԓ&����20ΐX���H�͕���_��hVU%X���п%�l9[��;��5c6�XdS����%ff���a}���+B=C$���w6ܐ����U?����>��(e_rs;��B*|����7��3+��G)�i�W?���7���&�ԋG��(��@꬗G1}>1G��8{�b��O�� .�H&o>=|���V�sMGN�8f�j���V.!7X?l�ާ0l����w�8��`vJp��Pڟo$Y�k[+�C@/�V����ݡ���8l5և�䅗���#��w}d��ܔZ<�(�V�yJ�SG����f��?w���+YZ��>��#�⍪����SA|�0Ȩo��9��g�~�}�z�]E�D��Mk[�+���?���`:fc��~Vw��%N���/ ������kM�aǏ��2��?���Ը�;X
"{=wa&�������Ih����u�k��g����S��G:C���wE��k������G�6\����G['�s�ӵ�|�E�!n�,����٧'��AV��ҞF�!�sR�;4�i��\����x�4�ռ��(�X~G4��^;׍c���(='t��۝0���񴱉,_#@ֈ�O�����D� p�:]5�3��q�p�mӨ�7�����g�tB�q��{a�|�s����ㆁg��sp��!x��H� ��Ŷ,��%�ò1�ܖll�{{4E�wn��P�F�!��?<�̦l�S{�
RsfϾg�}.\��@��YfO��]'J~&��?N���f$���i�|wNk_-G�"�q;�m��3�}8���0p�lX���+r    $�%7P�����!BU�J2�M�q��ͳk&��[���6�S�M(>�t��Dl��R~�A���j��}!��Ik�gF��Y�YQ?:��Xoy�֟�7hm����A:'�e����U�h��}�z���\(������lx��;mFx)�@�ʽ���?�Hh������sw��@�1�,C��]�iN�z���?�:�d����E���^��qu��V1z���e"߸�/� ���}��uٗ0X�)pL�����/7SY��{���z���LG#���A�.|�����}�y�70R�^��1=U�/	�q;�ϒ|��k��p��߻&3�& ~�NwLx+��E?�`��d ��X;�%zU�e����
%t��B:���tʱ+�p��Tܛ�
�z
�>�-��!bh�i]<n��f_[��?*��Mc��ɱX,���@�uf/����I\v	�����G,٥>u�?3\m����;�FЫ�f��{�/���W�.e7��Cx5"���g<���82R(�LOq����:��v5�1��h��L������p��{���8���t��4	Fzzs�����t��"��	��%D�ټ8w�����Ud�b���1� �V*����D���9�e|dq�\'?+z�U�mĐC�l?�7Ҵh��4Î=QI�b���bU��)��>�H�EA�D���4��RO=��lyIx��{�
�+k�LV))�P}ubaJI�j��]:�R%��#��TM��v������E����Z*��::I��QΖ�7����>[wRW�bgn7�`�dZ��Gv(��N��9��)��R�������	�뮌$��9�����n�����fe]c?p#�Jķ?���;��;��͵�����f�H��.�����3�c�G?��hCc�U�?���ܤ�������q��俚����Re�m&ˮ�ѽ@i�SC����*Z8����ܻg��*Z��$3�{�7���j�>�����%�pn�R.x1�`YS���wV+��-%=�#��Bf�>�����%�˷�l�E�<�����I��g��ʆfJ�Y�c������PJ��������S��a��S��H�N��&��2�AR,��@�Ll�$��W�C|T޻��<y�~���>��-��8G��� �q��]�N���i������ݔ}�x�"�M�▵�w��\S��Mk�Ѝ�n�����eМG�h	o��ҽ'9QҦ]���{���g8��BcX��d�D@����S�?�������H|k��#������qU�?�aƙ���n�<b�E�IH/U/e��M[�=���3�����H���2)�Jk.��^�e�i�����~d�����u��b��7N�XΦ���7P�7��A�/V�/S%Y���y*��m�2��Ո���x~U+EDng��\Lb���g�$=��ۖ��V�\\�>�pU�چ��Ѹ�u������
E�O�f��~�Ԉc=c'U�H�F=H�U?����I���t��Uc�;|;.��C�L��` �[�S{D2�y�6�W�{����!�&��a��5�^�9�ǈ> P$�m�N.�X݌�������N��hy=FW����t`���3��@�ߎ�?"iWM�|��G��]�?m��)B��(�.�F��9��G�F�o�S�Y�;� h9�lۤYI`�I��wLۇ�̌�q� 6��s
���F��k�B���~�4U|ܐ�WEM�V�d��k��!�4�_j�9��0���O�x'��������	K~Z�jTt���xvúIi8�?�o����xghn����q{:a��w$�4p7FA�e4>>����k����}m�=�f��~����%|��7����/�j��Y��ﻧ<��sW��3 �v(I��p(��']��N�����;�F��"��^���q.A�3�������#�B�m��?�/�j2����?�IT��S
��U~��i��v�5�t0��ќ��0Ti�n�T�/=Ёh��+����.6��L���-H����Ͻ�⡆a�o���e�F�����X&|���A�s�a�xᐬ��z��;l���=9'�s��;`��Z���U�$'Vs��}F��R�+ZM4ۡ;;�An���G����9���YV(L.��\�P���!��,{`{�8'���6H���e.�cGGTc��|�I���Mʷ�q��"+|���0��uG�2E����'�1y��?-�(|��I\I|�����Y�۩� mSs��:D�o�	'�hO�d����F�`�T�A��\�@ M'��f�>��u9{��9���y��aU��J�Ν���X21�,�I"]���7aK�Z�����|��L�%�* ??'��51�htmIe�C+��,L��%�b6*�B_���7�F�4$�� GP�������I�W�
װ�G��_[p��*q���K7����d(�[{	"��[�"����2\� �Л�]�Q/~1��:���T�g��D�&J��%�U��I,���UD�x����^M��{a|7P���sm��fo	�������v"�y��"�<�$F�ufB��+s6�&ax�fϢ������T�W�����v��y�a>&�
Ѯ���j���v��d�O�_�Js3~W�R�|��b��BO�����9Us��h_ո��G� )K��U|��CH(��6����,�M�t������{F`�)���t�\�`�v�@�GW���ƛu��ٓ֯�P`�f����ݟ�@��7�&:<�*�i����Y�
�Ze��g���KB��i|.����ωf����z�VW�ϱ���y�ӭhwe9�1LD�P�漏�<§Kb2��yjz���m�u�'�*�B@���Zُq�1�0����xhdߘVN#9��+�v���\B��6�Y��Ja<ăG�d���|jHVM�n<�R+S����&�cs���ږv�f�y-*�= �|����+��s�-e&��x���{�O��^�?�[cgK����u��=���̨֜]v.W�(�S)q����cv����S!�y����������Q�~j\�j�gjO0�r �E�<�c����^��~�M-��F� ^� cw���EbRgM�?��|i�a#�����W��{c2�V$pG�#T~@���]t/*Y/��¹v���|U��^��~��G�9��(56����M<��j���t����zQ��\�cNc�M��ԩ�{=m%:[�����&7F��fR?O�܈��H�wߒ��f3���{}�$�K��,Y'�1�୍�����^ao�)�'��
A��x�\�Or�`: #�@ކ�?�`wHp���[A�\��ƿ{�y�̧n}�,�E�G�ʞ}E�90�LJ>>�-nhb�y̟�����}��ݑe�1�u�G	��q���CA��l0O>1 ���LÊ��M��TL�wn��$!�2�FHp(�@�#����=��1��=�@�7��S5���Y��q�#8z>����̸���1�~f��>H�U蜹z��ė�ґ?f��)������0���N���C�CH��Ѻqפ��OJ�pf|����?�^��Z�-�RE���!�6y��i��*�,�>�0�x����	�a��g���Zf��g훚�4�_���i��h��KJ�y��!I��H��	�$�� ������}rx?��^S�o�D���\�(�⨰��bŻNf�m^����g	tY��R%����J�u�1 z2%���xYpo\|ˊ)�8��iN3��%��vSQn����w7 `��[�k��i��4�U�������*5�g�ob�S���Kv�?>?=��v�C����#�ߥE�3SlUu�p���~�P����I �ü�K�V��\%�8�����s^֯���F�豜ޤ������U�.���Vm�������E�;�52����3��#��M�;�[�c�?�NoDD��jڈ�&$/��mV[1Y~˰�.�ό7.�z�����fYW%	,1��w]���>�?z#������gi+b�뮞Z�U�ҝ {��+|��R    f��A1��9)c�g�ML�z�[�x	ݳ�0���&��b�<�.J���Ob���Q~�ŅS�*$
f`M�g~�o�����va�oN��!����
X���=7�Ҵ���� �厦�ˡih�o�V��'�$�3�\pZ]q�^h/�Z�%2z)���� >��r1C��y����n4�֧x]�g'���s(Vog=����B�5i���7�f$��a�����]{�W6�;��ӂpMzod���C*�qP&��LD��Gr�T����	�w��K����7����q'�ǘf���4��I���W� @�~W�A"��b�Dj�f
��z�%e�Hdk��r�YZ <^��*��K8�x�k��us��z�O2������b���ܺ�� E�D�����M����G�`z��d��U��XS"�bo�i�ϐ:�#l/�æȫ�	�9)Y+C����e���~����B��x
�jh���;�O��b|u	�F�4Ia��>*�ç�ع��M��\��N=��Y�~�]�����8u��/5�ˣ�^�����@D�B��%�IL����x�u{A�lR��Iu�<�tNh 6
a PE@���2�-�I��k�=��t�nQs�&Lg�0��w3���$�op�.��ؓIG�jE؟O�����+%��6\)�k�v�W�]�:�C�&"[*����&��ˢ��+`U1�96��c+�K�$M�:x�\��	����J_	��k3�N�����E�}a�
熓��V��R�K:%�ܢ��%|QԶI9���*�߷�ֿ��*�u�����)�Q>R	��(:��4���\F(	W»�16��m���k� ��4�8��bK?S�����[��ь�W��2R\�4��o���	���.�F%��Ψ���rU{��=�4p{���S���}o��рc�R�Ҍm�H�5�׌��q�e�a����E6�r8�������p���:�(:t�%�:
�፝D*tWPٟ�
�vI'#@�'2�y�ſ�qx���� .��󹚎�;R���Y��f�]����ei���n�}��m~�g����S���࿯?H�P!����j�'����ɳs@тA1��	뜙��Z���Z�(��T�q� �\��2��[��4�nmF�M�~�����:w�F��ri)����"N����;V;��g� 6�2��h����oXCa#���0���	�'��ۙ���u2B,K�Rm2��1���L��Ɓ��Sw�S/�EQ���f��翏	q6SE�^�1�]��[x�17sZ|Ro&��KK�z<"_�c��o�_����` fh�M3�F�>Ǽ��wF-�w�6,�>�G! ����gr脳bطbΐON��H���ʳ�8V	~_6iT�.yy2��c�o�A�Ǯ\�*��u���lǩ�c�v���@]���'^[(�/4K�$Fja��@1�@��u��K!O�)��g�"���Ҏ��E?��%���^�d
OڞX:�-_l*ˎ��&�8��!aaw�#��ӼF��c���X�����W/H/'u"~O�����~�S	��{��(���ᛅ ������B;�(�.t�D5�ܮ�%,��C{ؘpC�N�� ��}|e��.�X�l��z�/C��� 輍>sۓ3���v���eE�I ��|�ϕ?�Y������^���w���'-�,Qf��u��Ԁ(�<�O�4�1_� ��
�C���BD�$�2�2�Ѵ����DlDm"���2NS�m�9��7�~A\�<E r���S7^������ش��:p�ߒN�P_'��Dv�9޷��`�Z�9���c����J�]D�}��:�i�jl8G9SY4^Σa��g�p%�ORw5�
x1���A�00B�fI�����r\v±ת�l����]�f}1����.�-Ә=nx\�0�VQӢPۏ��� ����b�,e �Ձ��]�emߑ|XƼ��AV-�^�k`�p��ԫ��⌖�;���k6*c-��T�,�n�py��[q�K��#�TUeEwUCU�e��m�Ɍ���G�T�y�n!����7z2W9c�\.d�w��o��f�	��O͚��de)�'�����?u�֒�� }X�t�n�����So#ee髐n"�.`/���)?4�ΰ/p:�%2L�BN�9�a{E��	ܞ��xe���f��El��y���r�7A���#���L3��{�#�6}kć��2��n
�Ht���N']%E�zf��̧���O`؟~i�B��K�˂ �De�ͳ�.���@�zV���Ǒ� �)�2&�=S�ou"oXn������ �������"����i�	�wͰ���:��\\�]�6I4��7{��,��nGtWǌ6z�W��t�����<lqIV��|�\�,��s�׿i��*K�ǧ!/��P~�C-���6�b��� H�?���N�5�!�8�5��s��fG���I������� J:�Y4y�����u�Ǣ5�������a4�U���3�36/ŗ{	�+W�2�)��F ���ؔ�i��4�iGy��w�7/F�%-��՞�j���1KWܹ�$��p"�>IB�����>��SE.\/'�9�,/�6��t����,\&t]������ ���Ϥ܄5O�{.���PL7&8<���g��|�d ��}hjm��jX�8'pD>t��w�>)��.�	�-�2� �p:h*���x���R�ۅ�ZW�Kb�;Q�zp;���ہ+�}Ƣ���<�.��`��A&�Ov����2o�框#��SYG�g�8�(*C^��iN��U.�i�ynx�C;��3r{�93�hN�P؆�w@���6/^��;�?�!|',�Z"
\���gv�u����OU��"�:�����_�I� �� �:�/V��%y�����.R��3p��{�;��3H.�gb��IG�5�����O�REՐ��y�����P˔_g���8��
��إ;&�B�m��g���*��OŒ3>и�V�>f��C��p�{�;��D{��dKt!�NU*��<!�7��I��8 ��o6�+qN}�^pO$e�]���u#爍O�� ����C�,���Or���;��Qi�ك9J\F3�k��/ hz ����K���
��Zu�������|�����<֨��l�x��"�Fv��/*`R����s�p�Q��EMp� �O���8=�V1Pgw�0!�<����?�<K����_��؃�D��<C�϶	}�)@��YXa6=��s8e1x�	�=}ݖg�
#똲�~B�t�B���+f1;8�����!V�\�)�Fu�D&�"#�j�2pPh��q���9�7���:w%{�����6��6�;ΞD6� ���w�ێˠ�b�m�p�p	�"�~�\��l��uһEn]dc��A�n�ش�5��_sr���)�-��%7p�,C8�����[P�Y kDx'�/����me����K�G�<T��H�Y �����bp���g��ɳ*Z�\�oB������mʒl�dTU����=���Q��꤄~U�x�5u�-���=��u�o�-���<+��Tbhb�d���ވl��g�=.:=��������EM�N�͋{���A���%������V�Ӽ�82�=��͒�L7n�{�NJ��qN��U��L��w����� ����L�r��S���	�I�_Cc��A�[߼�ڛ9u�BCbQ��UW�"��OC���u�(��_�]v�9��� �����&�syW�ɱl&+���k��H�ts##qY�>b�ҁ�d�T�
 �A��A�f������P^�{�/��/� j�G�.���}��s��{{�Wz�r�W����Y�V!c::�B�jQ�:@K�E�	OҪ�����o�B0��,ر��7��A��q�k����C?׻�<@
c��0
�l'�E&ر�/n:(����{}ţAf��n�r'L���;�;�r�=%&�_I��T�w=W~����n����X2��x���EeS\<�)o��ZYT4+Y�q<���>q�����Lu5���AI~=��"�    *�z�y9
|pBDv�`_��-O;��T���CA�!V��hh�ZNOv�Ƌ�s "L}z1{8b��\��	) -5�J�ꮡ��9釂F4��\@���i`�����. |���1~_z���	cjeq5��[��3?�`s�����V���R�L�[�axE5�迆��kB��ٌ���=������i�ڤa i�=ʻw�'������w�6������k=g���>�	��K~ǟ��]�O��]���W�]���v���D��DWWy�5S���~�����_6�*?��.�ԕ���ށ����j��~iD=�t�������$[�
������1%r�S���x~����͞��6NSB�� J����E�4�(k���}�%U)d�sX_��{��0B��^i �8��z����=��jø�q�uGƹ�~j�Wց�V8�Z�.e)\w5�+^���7�'o3?��F��zz�b/͙I�����`^�U�s�s��ts�.�_�HP; ���<{��ZO�x��O~�>�������w�Xy1R�U����W_g�M�{�f���]g+qɲ{Jm������o����yn��w���[:X�Xn	�ߦ �3�y��������T]�{����6x��9c5;y�s޸MuЩ"��]P��\%����yZb���5���	~��gX�]��	�u���<��F]v��54�{h<��_�8*)��m9z��,���E��<��9���%�t�����wTI
ӗMg��B���h~�_�*�9���gę:��&�=��`�;Ā�H�nL�!�,ˑ߁�W��AM]Gt�FOO+܂`�0�Q�hY�E3�O،�>�U�t�j�_~r?b������N��ߝ���大���[f�H@]�W��8�.���B�Eq�0ҭ�X?��x����ZL�|���O�=�L�����u�3���/�����~왁^�o-�^���������6����������?�ϝS�k�`z<��������!��Ы����<�F/��_A���T4�.Jm�>����8h���O�w3���TMm����o��뺅��� �|CR�	`Tm��M�j�֚'V�7=�Ӭ՗����mbd8��M����)�9//�>k�W< ��u?]%�c= �����U/ϱN�"��Za��aJ.DY�2'��{���Y��戧wy\V�;��g����>x$��k	n�9�*�0o@1�e�r��ӭ/���c���U#H���4���x�4qѧ��I ��g�J=� �q���? �UҾ�߈-�|vuQ��ܢ��WnEuu�)��/=�i�?��}%��h����Ϸ�C;hq�q��?z�Ҿ]\�*���v�'e5Gb+���:d�a�c
}}�s��]X��T���6˅�f����O�o�=�J�<��Wn������˩�������Mt�3������t� zè���d��m-��6��܃�S�A���;����@r�����gXD�:{U�@8�Y�Y�3��:�
-����?��7.i�O�g	S�&��G �b�mX��#�j�#sN�>�i~�:E� �c�I�҉ �87񤛃��ng����n�h%g��ŗ�䋖o,L�W[|�K���e6 ���b:7μ�����c�3���R�+�3������Ƀu'���)�2�}��rc�TB��3���_�Z��z�Ul+�i۶�*FZ��`���{#�/��s}����ݐ��6|���m���� �m����s ��=?5�p�l�����y�ܱ�:8>�7��7���W�����6����FQmw���T[r��S�b��3t݅���u�3���|M�>��H>k89��T
��A���Pza~�������'>`W�hO��uT#\����p<U%�z[#CI�w�g�j�>"8�c6 �]���2�}~�㹴����w=��Fc~�J��4#��&�&��q�.<���E�5������?4��d
����4:�P�?=Q�[l�U�ŭ��O�V����=΍w��j���q~3��~��3�w%"�c���\@ó���p9�{�(��A.��J��)� p1S�$�bꋌ
��_�jY�H���I���t��o�";�/�8ȅ���3����
b�\i )]z�����#/{�(Kɘ�U״�#q���$BÒ�t�ȼ�Ƈsp+ �M87ȭ�3�]-�n���R猁��O@�N=>�g�;�%�d����N������D�M��x&梷�h��80'�1����iSy�����U7b�-�M�Sl�.@` ����n�K��ve\.ZF�tyz��e��B	��h��0��1:�z�<5�+����tp��U1 #>~��4g@j�=�d����*Q(�x�`vb�e�Z�s�p��X@�,�s��;Ը����g���F#Um�u!��F�����"�WoO�[g� ���͎���Zۿ�7sDss5<)�m�Xv�����nG5�W��v.�30� �5~�7c/խn����ׂ�_�5��}��\��F�M�޴ǯ^#�]�j�q�|��h���#��� ����xe�-�Z�	��|�Xk����14�V�5+�{�P���Q��yfD,��q��}ߑ�J{�@4�vIgjk��Vy�h�5}�����Ϝ_�]W�A��?�-�0(b�ݰ�g�@omA�`�i��4K�e�Y-�@�j�{_5s8�a���EH���k�	{2�E4,���t������P*���K�8q}�M�R�M�拴W�,_�U\ލ��]̉}Ė��5u���/��1S�"�c��4ǟ����s�����S���kd��F�j*��9Ѡh� �Ur�J {��f#�O�N��mY���d ۦ?���g�DB�{o����cn�,����2/:���^�ݵB�|MBr�5:�8+�o�~��^>t=D�.p-&8$�p�L�\�j�8�F�!�%��7q�r�� 4�`�ԈF3��d�ɰ�>ٟ��7�=���藧�ׯ��|懙��$�4�7�|͇!��틣�<ZĹaMa�.�d�L4-��OX�pV����bJ\�M��P����Z#{�p| �82q����f���C�ۺ�B�,���bk�DX�`��<o�B�d��(y���hYOc(s���� ț��iVlp2�H�g{M,>߻�4찤\��M؛�Eh�֩���K}q�b͍� �Df.�x%���Y��SkU�<?SU�1�1�7]�VAaʛMX �M�g�}�Զt��"M�NP����~��R U�5Ք��rI�����( L���/�S48��=��r���F�?u����ȿ���FJK�^<�gۧ����Ӕ�N>���)��B�4�~��J.z�.�K��w�E�%�����AM�̓�7��r����	O�Y��07�޳H:��7F7�j�3���¼=���G��|�;��Q�~�4B�/��Gl�D����~�W��f��kA��?�1���b u� Gc�J�n�CO��̑	�oE�Gž ƿT/돲<�D��ϼͬ^^�%$ׅ��K``Ġ���(I��@"@�#��:�e��W�i�7����2x��}Cq��m�}|��#�|RlF�1�=
ӱ�2Qg�:^@^���pa%�s����k�/�-� D4	}���}q�E�'Ez�6�"�!G�����MD��l�{�U)}�o
������WW�zo�;��5=n�x��FN�x {tZg� ��ٱK+�?��^����j3��rR?K�r�p� �4��\3�3�Pۂ�=��G�ɇ�m�o�#����L��{��{<�_&7���-��>՟&ώ��]w����oB��?t1 9����u�n�ӲK~5z$�^o����Y,��� �=��? �,�X,�b�Q���ګy�p';�5�����L����IͫF5"Х����O����I�P:�,G�!�/�TD(z�۽�q��Yq�&	J\������ʹƍ �N�z�g�γ��:ҲK6�'�D��4W��?�0��'c&���e��/��^2������LzA��#D�,἗\,��#��uz�;�,�	-���(���� ����0�%�/�Rm�    %ںX���X��50�}�⓻���ۢKp�C��N��u�;ֿ|��61*�a*�5������#�wG@��A��e�#���,>38�ՠ����,_�3�[���t��"�{��*��\m%	�u�[���ce�5�J���k{�{��'=����qfާo%3�Y�a��.�%��������O�lV���]��o�B�31����-�������ӬAs(����֭���k8��Ŧ�zW�<��W�R���9�h�߫���GpF�l�Li��PZ���c�G\$�<�s|vh��3Q��~�r^ �ޅ�ve�a q��];qC���ՠ�wx�,��I�QZ�����.+��ǎ�q<?���>q��A�:�An�r����W������F(���1u�/�c�>�"X�(Ʊ��䛦�e�p�@�@JC p�Q�vL����|���v��-�*5�c�*���{>u�������u���������W�0w��#�٭bQ�|��%�|>^k� 7[�a}�nSc�\K�~-��io��^S��Y'��}�~�0_��HxE�K�1�ȍR��r'��,�bp��#�;q����l�!���(��������7�\�=�c�O�`-q�6�l��I[���Rf4ͼO��Ď����s
�6�߀g��3
yI��$ң��˯o��~�;{o�(UNa ^w�YY>�U�4�%�g�߭�D �&>ڔ '$ܟ<�D�����#��"����EX�N��P�%���e��~��}c���Gk���_��	�G�+����/��	��9�+�"�_�$���Z߲��4*I����j������־��fz���w�MGX/+��6xΌ�.�K�/���v��Ρ�E,
.���GF3���Ґ�|0|�rݥ)�@j¨��|�X������3V��=�7��M��Ȓu�P���4���IAek:� ��2��je�'4߽rL�\�<��|�l�A�t��h�*��#���q�:榺��L��뫟��a��)0G��]�o�~̤��_�l�)��#X�4m�~C���� c����g'�.a�nۦWm4��lz�|�ڹ�DX������Kb����łɮ�	�	���G��L����e&�g�ÚRX�׶
�ˌv��o9�3�ؔ�� ���������tX/og�������}���z�:Ga���\��O5������	b:��2�xH��p���C.:��HJ��Z����S;,�`S�d�\��_?g�چ?��Aqo`?U��I���[�(Z���zez���
i�P�Xxq��������x�v"h����ϝ�2�y�A�cF�%�pN$y;�;�m��å�gjU��,}U(�(J�Fw�0	Ab�<B��-�|��Ϸa�~�dn������X�ˠ!�m�g�`���*�Ya��~��ͺ�����,҇}i���Cن����l�t@X�ra4/�Gw���s�v��N^���u���q��v����p]��XO�u���-z<��#���B�)1'S�@\�mۖE�7Ǐ���Ǟ��㼤߯`ۍ�l�@�'�ȼSU�J A��<�����O+���&p��7眅�_#���"V؟3�h�0P�ЧV��d]�i��T٭���0�8�ZB���PW|%x2.1a�	ӛ�!%p�T�D��<�YU߳{�ßf�d}��~�f�ryj����p��B��|��C�d L�%�8�o���Bc`��8�Q�D>g����Ě����۬���<vq�'��ќ�U}w�-Aڊ�,E����Y��JW��Ѳ~X1�q�b�}R���qQ���k!�	��~���ܯw��h��WKnC�B�6�sM0���� J��gVe��4�;����P\'ʗ�_�g_��{�%�z�����K�?F�V�h8���V8#�9M��e��qx�(<����'h��0�zw^�ƶi����\�r�.�5��`���Vճ��W�<�p��!�ޡ��X��������K�VHh/��oXM�-P��k�W������p�;*�Ra>ڣ�fo��\��3��c�rW�ʋ-�2:EP��oA#wZf���8��O
�f��J�%ܢÂ~�wp���"��}�3e�`C�I؃Xk�R���܉�O��!��~�.V�ݭ��K�#^�0���9t��(�ȋIy���s��J�*��k��׬�N��=��S6%4K���(P�P�.l�Е�k�r"H�N&x>j�@�d�@uL��l�K_s�M�L��jUTk2��5mO]̜`o(:��nv����c�b���U���mqbG#>#��
>7��ɽ9Pt���dP(��:�e۞�F�_�t���k%m�*U���^g/�I�>ְ�~߅�Y�U��i��" ���E?�˖�Ի�m�|Ѿʻ�d���Ԇ{��y��{<�Y�?�k�n�@�f����A�EC��wp���b��ɫ�"~�c��7�$$���oXp.����<�]=���-�	>����cxw�(ND�i�T�p�+��q�^�^��v��h������ s�^m��j��7��c&+	v?Se�вo�	�������uS�W�Ӭ�Hj��k�k�Vz{N{��z)DXx����"�U&�}?NIZW/(G�^��<��@�o�_�vhX
-5�ܤ���;-�9��̉���γ���ُj�g�
�)w~�����9� ��O]���^ѷڼ'v���5�$���i@]��R���s���}]���|�s ���5"�ɀ3�>���Z��9�dFU|���˥�A��l�^{���E9��a�$�����M"���I�燫N�ok�f�$F9�N�	["��D���W�ZX+�u�/�.��.��_���Q�!0��P���' �ƃ�ڛ�� ��/Ϫ��c�	!@X'���Ui���u��y[��H���� ?$��\��x����B=���p|I�q�e��.��Ʈ�I~y�"��'�$wE
àH��`(^S��S�����XW.�/�� RN <���ކ3�=J?/I�o*��o8_W�?,���ۼ�n�}p�������!��:���H=A�b���w��=?����U9���������e'j����q�@�B�)KuyǡV�������R�l�xO
4���ӽF��S �1 �N:�����?�_��� ���"��~�b�npM-�8�;���{�1տ_�� `5�h�޼�9�������b`�������t�K}:C�APT��{��c���,얝�\v��S�P�3�6J�)�=��}_. *E8�;R.˵ޟ���5��uz\��d��&���Es#=f����ҭ���ã�^��,�e�Ǉ^���5���@�̱ҝ�D�̚���ބ��vu� zI'��@��B���}g�j���"_L����G�"꒐TC+sb��|8Λ	 �����o�@NN��L�׫�� Vp�~�Q5��a�*�\��f�)ԯ�N�ѧ�`�Fk�ñ{"*Ey0e�yc轫�m�x�F��)��k���f=����|�1v���;ʃ�:��z�B�����d{b�du5��SmL�"�ݺۯ�~��ʭg�q����F:��"ٻrХ5�)��)�׫�UĄ7C�c8ٚ\��'^�"�"*y`��aj��>ms�K������nj<�:�����_�G�%�; �r���|��V�y�g���#�>�5���Z��P����/�l%�Ww"�v�6������rah�N܂��؊���G�&�my&�ó����m�bT$�B.�H��q�iN�V���kl��/pS�Z�#�g���I��{u�\t�"
�������!�M}8�/��/\�>�ey�p��N��J�q�>j���}���g��C0�(���6��M�=0���/S�2Ŏ���;!ʹ��TN���8�r3�~`|�o^r�+�#8��k��6�׷�ղ{s�=~�����0���Y��MY�cO�!_���T��
�ݫx��J'pOw���    e8����'��YX�t�	i_I�04$�ף��u>���a�c�xwj�]�:؏x����	���j�__}D��{pv��'@���c��S�ruE�lp!^���_����T���Q��H���'|�`d�5 Ƒ&��?�Z�cց��{�cΛ~e���~�C��"��{�d;�]n-���{^[%�ML��^v���m؛��5_22R��1�;J�*W
�z�OKi:����'�\a|�>Bv�@_d�U�H�2}\��A+KT�v����ڥ����R��.t��� s�.�}��=J�s-pc��}���@Io�=/�]���z�gu�a;�.���j�٧'["ԇ&���i�M��,�0��3��.�Κy��Kל�/�
�p��3����w�:@�{>��<lk�nb�>q��rfj�\_cʾ��r�7��5\��p�8�A��l�.��O�	��d��q�
��O��̎8T=�}j��A�|�kAnٵL�!�ߏ��yj,�������]?���|Q"�x�������J�{�`�1��!�'&����Bp8�Ad:G�e�s���Ԩ<�.̀������5���i��M1�r:qW�m+�K����c2���c�K�dUʽr*6�����'S�������)b�����a�b/T�������c�H�;�N�M�����<[��' 9� هiT!��E�"7��t:��b������D:\��(�Y�3��ʁ.	��s6�X1���aWfx/^�3XخK��̣�����q?��"G��ŔWC_�l�U1�6u(&������ҽ�m+d�"�� ��ö��ф�KV�heOK�_�<��^34���
��UT�=sZ��� ��ؚ�}���������g}o�<ܼ$����#9w�L.@��mĭ?�y� =�ha3�ep��3�.F�CD���h��q񥙋m�4id<EctG��c+���=���VE+.˭������e����`�J�I#�*�tW3���>y��"�?�� M�s��cA1�@�����lT��d��p�q�a���*�y5���*��X��.<�}�!JOr��
"!vW_&4�p�BV%J�8��?���4�3�����y!��/A�A�0��f�q^>�=��?��1A��T0\;N~c��,hsrp���md�fb-������_�� T�x4��\&��/���*轷����?oX�T?OdK�7�rU��N�7���Y�$��h�¢��=n���`_Ձs�O�	�_0ܱ�X2���MP��?��wL�_Pbq�����]�%���p���4��������TG>�&�b`Pw�
W��K�%���<�Ɓf&Җ���@�Kg���ݮl5Ur����`;:)���$	�-���糑��\2� 	/��
����Հl�rj��a5��.�ǝ���Y���<e�|9���p�g��D��*c��f_!�T�Gx̕�Ձ:>�]Ԇʆ:�����.B_j�fe�}3e��	ж�~$��4�=*��Lҳ�`5Z��c0Ȯp�}�m]QprD��-7X�d/n#?�����ثW+��6 xc��!�"jf����űO�o3���%5��@b��� R��ob4�K�)ϾIW�\����Q�q#�=yq���8v��(��FR�ŏ�u�p$>�]!1՚k>3@T��2�+�<:�H:L-�g��3�ϣ���qu�!�,˔7./KI�R��=Nq��
O���E�=����*����:_�C����V�l�vxn�r��RO���c�/��Nc�;�*5����H&ՠ�4#P�3�:��j����^�뽑H��,�^���v�kK�Go�[�%~$�*x8��W�	XGe�T��ڧ�[<&h��"2Le��.Upv(V��8���:�����%��_�6V���(�JM��L�D�"N��mGo^�탱���ٲ�ʖ%���
�#}'Y=m��m�C���rb�{�U�*�L����Z���s��>�$Eԝ��P�t�Co���R�� ��rU=���)�O����T�8�K��,�y��Ͼ��;a,��پr�{w�9;~�rۿ7ƃ E��PP��Qo�NUz�wχ_2�ԉ$�mם9r,<`���d<XI�숟�w�&��F��������!.BW�N��]�I�M�~��2���d�� -��b#�ƪot�?L��h-���vT�n�{�s�|ܥ���;F`��?z*"�dqxٗE��ߜ&)a��k���3�ɨ�=�ٽ��!�U�9<�#룷2�E/���,3l��}gHT ~.�n�Uݶ3iZ���0����m~��o�V|�*����'�[z�7��eY{��]Re�InX��O7,T��̐~w"�2���zx��U4��Q��Q��\l@[�Vʜ�'�fԈ�p���?�-���ޭ�%��<��E������)r�IW�b��)�E['<�5�ŝ��ަ��@&_ݑW�^�`�l=  bi�x0~������/�����������5}2����Qp�=%J�o�C��	!�h+����(��Og��2����33}�'��_jֆ����~ �hRp�I�XE�_��sߵ��}ڱ�Y��n�=��,t���.)����1�p��U��v^���������k5���-���6��������͈7�.2�檠��s)��5`KY.&S�pxjUeˮ�-��\=$~��ϱ��x��6��Ď�&��oV�CI�`�[���L�����ج�.���HF�V~�"�j��>q��سnnL x��A���F6,a�~YA��|��@� �bX5+ǰyk��&\8��&^���Ѿ�PƗA�=,V��^6�Fli����9Om(�~P�l�:��G�$7����`��
T����i�z�����uE��f:�gF�}�<cQ�s�� ��?�+�0�>p;���s�|s�p�>�K����JX�e�C��8�t2�LHs�E����j�2��U����,����S#CzT���U+܆��_H2�̜w�� ��Δ��\gM�nz�����0�+�2I*}0*�߹�ҵ�0:`�`���-ڲ.V�Mٯ����&?23X����Ŵp�獐�_�D!�X�=������E��X͖����r���#�ܹs��vg���$��-:w�<�n��ɴ0:�#��&����y2�U�ު�_��G�nЩ_�y�[�i0d��$K7L��2���-����]qB��C��������&2zgx>p@���KF'�blu��ޛ#zJ�����3�C�qb��]<RdY���H���I�!â��C�`*v�:��9x	�_������m�Pէ���N"a�ty>�<x�W��L���Un�N"R�������2]'Q�s�{<��kݬ	�0�"�v�'3��G�|s�k����/����E�)$�yA�o[=H��oa���]Z�Y�3X����C���Q�������m�0��-bCUB���Ź��*U�R��j��&����/˷� az�}�P��K�N`ݭ�X���/�r���X[���(��ys�y��W�S{i��A��'�s�k�ܛ�.7c���7a%�� Ë���5y�F��[��#����}��2�@�ơw����݌��
)wo79��WI���e������!�J?k�i�D�
�mӐ���e�niBq<ۧv�	G�4xǾ��}ͥ��@�ߐ���&�2���w���u7ވ�6�:��F~�t���p��x2�w���s��#�ܗG@�qx�T ��J!hSh3�,�Ȫ7b�_���$B�&I���C3/��z/S��M2��H`[ �Kb�wy ��=g�4l�(����K[R��팝�.����,s��E�n^����k�9Ա%X�����@�d�����m2ң�o4���y9��8�?i�9����(.��G �_gDﯯJ/�4|/���7�ۇ�q�xZ}��������OF͇c ��T��w���X��P����h�|���ѵKk��{��rt��L����c�  ���R��mo2'    �k��ښ��޾ە7<Ed^� �[��հ�0> /:b#N���ހ!BP���P�LS�}�޼�_�+���*Y<q�z' ����npe:u}��A�rg�3�.v�k��yjxc���sս�J$|J��p7�F(��G�{;"@��p��,l`�#�����	���\��� A8�!k�#�[�{g�QZ��o$���=����`}%���_�م<�϶�\C�`�;�l(B��|�ş��)����+��Ǿ���(�^7�|����׌���^�?g�'���\3<��)�{� ��n�b�Haj0����7���C0��D�����v���Hy7���#?�wݸˢ�������,^�����w����N�9�����8��"��=\��J���2�OJ�[>���.l�܂�c�1�DJY���z�����1������B���޺��ed'��;/��2��˿�Y&4��o�#�\,����6�#��z˟��;��m�T�c����� 3ʷ��Q+�I�R���Va�����0)E�s���a	@=�8gڠM�ȋ�K�x���ݹzTH([��e2`#t��ċ�=��ԑB���������V��&��e�?�X���%PhE��<��37���(>��������I��!b0�2��L3I�0MllC��`d��1l�Qi��Bd;,��_q���AVA��ʿ��7��t��٣ٝ�'ս���&�H��9��A1HEMMS��IϮ�&��
��P��MR�C"P��Cn���ˁ�M$�+>}�w���N�sS�n���cq4�F�����x�� TyNµ�C���a�L�ړ�q�ꪺM�~��W�Yvjs�?����*:ks��xĒK0�����]���Mk�:�2�&I  �^��%��'��y�ס|����:c8.��ߙ�A��q��QM|\��6�-��� ��4���B��8^�f�G�Ab����w���XwZiإ�Ŷu9���T��!�+�P��<0 ��G��/�j�����H�Ա�'���ks�D��i��2���HHǥ$B ���ʎ\#�ߔ���<�n�r?�!�S�d~�ް����a�DB��|-%�;Gy9����T� P;�xM̵�3)�z�sԽ��x��e��G�-�]�����i��'���=��>��	X� ����%��q�.�R�Q,�/	n��������j�/1x/1�z��������Z���8JY����D�\������	�[Ch�e+�7r6a����M��R�[������m��{�u��z
�m}��ޮ��b5����C����]ޥ����l��׺�ݜ1�@�5l�뾽3 tL��틋8�Xg�R�>�"HV�3p�ڍym�G�1�z53�������&��.�H�͇�ݨܓ���ȵ��>b��'.w�/J�0�BS�;��&;��<���|"�?�!�E���|��0���m*იv���A�#����\�����������~UԂ�[�(��c�#>L�(�2�aJ7W�[Y�	>�Q�4�6�:!*O@^Բ1�28����8#��n���)އ8N_�v�����.��`Z۳}��>�c�4\T��Y��YD�@n}��˦��;C\�_qN�$K%'MQ��N�	�w��&q��|b�9�jj���i�5��
q���R�����9O�E�u��4o��{�jѽ*ʽ��W⋕��f��LǾ���7	���+<8婵�; ����F����|p�Ϝn�@.�h��d�����X���疱��� M����h�0���4�NM��`u�ۢwMز��fӾ��v�[ʶ (�#=g{l�|�f�J���~���ZۚK���B�,u?�V������"u[('�u:���	"h�r�{���Q��j�d����7]n��@G�?��G<C3�tY:)��QY6A����.�m~���x*���M޴�D�}�Xđu�t;�o��f� o'�C͕Z��!�5h+��2K����x��0Y�֮c`�-6���[j��7۶���@з�m�MJ���e똯����i��ڣ�u���/@zC�%��)��l� 1	�Qa]}(�𐍑P'�.�ĬA���\���1��-y~���-X�s����͒bx�d���t��S���qW�.ܴP�\������Yn������ơ�Ǡſyeu�C"�^:�.L��ܣ���W�I��H]��o��	�ț��O%��~��ؼ酭јj���S^c_��{k�<ֽJ�\����0U��%��>�2�~��o�ua.�0m�7�~ϱ @y���^da���n�g���z��Djbj}kS5�L������M�����ݝ-�
k��KL(1�'�^^�U7˳C���Y�.7J$�'��R!k�c�/�,�T�����U�}U&�Cfnt)���H�	����.,������{�Ԡ8�-�46 ahu���_�'b�t��R@�Ks<�'
�x& ^��1zP�Hw 5Lэ�А|K
����ۮ+L ����yQвDM���Σ�z��౒�8�5$����g�3��F}~��`�ϲ��ː�p��!	%J��.1�<�x�º����sj�܏F,M��o7�!�p�,`����zM��-Y��:5��b	_H2��t_�ד�3y�}����=����w����|��� ��Haq꾧9^Q����8�䈢jW�H����4Yl��<��A�'
����b���f��&�y	7���ވ&x�� �9>���z���}ڲ�.hۤ��qs�5S�l�ƌ�Xz6�����Z��U.�}h
p1c5Hd�,`�ے�4z��[�J��� 0�=X���Dj'S�]1�I� �˹�5,~$��;v� ��tƬ�����"�6kR1�}Q�K��i�B/J��������9��=j��xl��BüyM����{{�m�T5�P(w��*�o넙n���<�]������M%��7�~�����D����.�L�*�۱��r��'lЗ~��D�����oc�N��R+q���,qq�v�v�=���"�e&���=e�����������D>(��R��x��A�|��i��B��N�w�$��Id毆���!x�#�b�g��$�)'�i�UGJKՙ�Xɑߩ9F�d����L��#d��F@wC��<�oT �̇Q��g��AυKʏ�(H���|k��lQ�m8�خS��|���7k+��!z*H�~vz�0!�]����#�ڇ��j����5�E��~�wnߓDg��[�u.i3��ٹ�(��3���M�@PD֠u���P�6����LV#�p���%s���ڡ�Ba��d�{h��ǵ7h��uv4�I�c�=
��i&\�m%�(���%���߶ø"�����ݯ�J�Ň���\$ϙ;��Z�8�9Apo�c< @[�����������h�y��ɤ��MP����:V#�ei�����3����:0Wh0�:ب�YY�|m4�����,��.�GI�T�z6��C��a����5Fahu���X�}���~72� �|�M�LQ�Z���.���Қ ��]+AgE��Y�0��ķs��s��J�Bɛv:�/S�f,�����59Ψ�l��Ս֬BW�I�7Ǆ{Nl5]Ix��g����
�!it�XwY_ ��2}t$��=x����hv�X�.r�c�&��}�"���$��w�l �f6�#�?_i�T P�scto��,�G��5��c?l���D�0n���M ��t���rk�$�?��_�~Od���wkޛ�ĴM�hx��x���3�`_ZZdnGYo�v+\:����bc�w.�6�W�l��)hR�]�j������|��O~�ބ�zJ��o4S�.�� >�W��yḬ�~BG�F?"�b(՛b��)X��,8 ^O�;�0�Wa�s51�r��X��t�TJ��~�cm������ m!x*PWy`��+%�T���w�M��ύY`t�<�!�#[o����7+�4`5�p    s~n�iUJ�w?;a�M9��t����P��ia+@�NO&rg�B�3�P�Ϫn뙲Yx�!�E�(8y�ׁi���G�5�	�+T%^��B�Ʒ���֩5d���c�h����
��J�龍������c�!��Rz�`�oh�A�ܤ��2r�G��y�WM��4�N�h��F�O��I�k��:�ѥ)�)�d�W<h��0O��z���� ]B��O���;<0.t�3C��&@�'⛒���\�'�i�
#���'9�G�6�u�n�]Pr]��Q����_KՄ��mv�P��[�8�hFķ����hB�٧��ߒ�"V���|��k0��~M��SEfS��;��	���;������5�����L��"����F��y�(݌��OC_A=�fD|������,���������y����j��K5�*�y!l:�%XV�[�zN�E�+���#��n��>} ��Kw�HuM�o-%+�5!�}突�"�> �s�-��F��~�<g���N�l�d��`�����o&2�|A�B�.N����z,�G�g�!��T�9)<s�^ɃXa�P2������x�(�'����9Y��ew�v���t	��>���!ӗ\���Uh�W�N%:83�{[�4z5Mv�+<��p����B=0��t��qh���a ����Ʀ���)�<�p94D��Qۭez 9�ɬ�ڃ1������S,�{�:�Ђ� �]��Γ��eǢAva�.w5��W�Ŕ�W~JO#R�Bx�L��:�* l����M�j�oh��<��<:��{D\���x��ُ��1���}�ﰗ���(.�#�C��L���� w���᙮_b��(� ��~^*�"%;������!��_½��?�fy?j-�*`w�6ݾ���Q�W�i�1�:V�rSi�5(J�L�z(���#nL5�^n������"v��(���P4B��"�6� �<��Z _�db_c,̪�){d�^���DP�j�:��)���L��%'��}���+\$�ӜRQ���vb�Ƙ-AP�Q�|�g+��B�R�@��Pޗ׾�u��X C's����)�T�C����L�sC�I�TH"Ѯ��ϐĊo2�/'j����3�#y�px�m��x��Qc�ܮ�I�?Ľ*��o�ⳁk�2'��O ��(]�K��5�Gd7l>9��&-}]�z	t�~f�7mVI+;ZgO�P.C��Y�=��'�q�6��>�����y<�OM_.h�t�%��A ڼ���D ��B<�\�!6��Xhy���c��:����.G�U&οM����$�K����\�Ց�|��`�Tnf[؝�{V�L�(3�7O��X1� �ٯ��}��e��ģA<)sÑ���׻�ؼ�s_�u	�=>/lv��	m�Kɯ�Q���҆RPQ�Ǣ�b�p�&g��Yl��˟q�j,�S���9.݂�*
x�������P�*Wv�~h���@����:�9�+�6�F��r0�vX�3�F�r�;>�1ޫ�,�^��LY��Fs���M޳�"�若�t*��~��KNC�o�����(���*!Z�5k�!v�+���:y���c�']�J,IF^@�0��M��KE#����Ѡ!V f�ȷU!ɏ��})�قe� {�%�1*��^�;M$�E����y�����п�����ņ{8��;�*wp_�^��3�Dg��s	�RK�^fǦ	�(���Ɵ��s�� m<u\v�ɲ}�%���4vtm$?:�yyA'��gY!�bݧ�&���[0��3��.�a��|��,�%���� ���e�"?0����zn��>��,'�d�����0�tN�4 z����獙�g��	h��)�;���M���1ZLa~v2��k�yͷ��B)B ���[�܋o���:sL-��������`������2]���n�}qW�� S��A�Q�&G�D�+,�|��U���qD���������8�BU�49Σ��K�n']�D��ț�
3��`���һT?���Z
��Ͼ^II2/�v�H�;7Ȇ��GVm��l��Wӆ.t�t+�{��!��������u�C�1�%��٣a�]f��U����P�?C􁁠OͰ`t��ٻ�����m}�Acb��V���ϩwjj����x0�H���B�Uf}S������u��<_=7#1�8�3�w��m}z+�����yu�S�!���$n$t��髡k|����Ox^�c���+�3��V�gB���nޥ���\m�Z��rO�]��ˤ�w�W�l�M����C�VU�T\{J�R�w�����͕�(�m�*Z�C�_#���c�@��d�aI�(���0�Em�����)� D �!_�m����{$� �.�>��b�^�d�֚6�l]����_��� տ�����Uސ�+6v~�99d�A�ן��L��z�ˆ,~���In�џ1}��ɠ��F�3*�X���V�>~[�>Hl:ˣu��=GR��@���)��Eq{��ߺ��Ћ�� ��ɂ���3ͽ�&ٜ��a] vi{6f���U[�t)ׇ_�h�/�i��&U�f��A��,w[�P�͇�|`(��]0bt����D�R�2���~�[BI�;�3I?��&�������aJ������@��X�`���N�}�ҽ�Α`c�V#sh	�W�m�:T�L��UZ>��[������U�֒�o3��m�*y���ēk���bè�O0�m'^�|�Q�J�3�dQ�(f5�A�%�����޺ߐ�y�0@m��ȕ~��-_������?�*�|��%�I�nO=u��d�VYH���|Ϸ׹ �"����@�%rn�W���m=�;�ux3~��"� Wf� 	.�(CQ�P:�bdD:�}'�o[L�7�"T{��:�{B|�([�=�� h
_"��7���ٿ�/�<����8�9*��T���Mx�_Qt9�E�zF�|8���[{ �b�Ғ��<]�(RL��)C5�IG>�1�o���?��^;؏/c�t/Z�U[i
�jMR	��`	߱9��U$���:�6_&.�0�;�A�w+D�g�ub�0E�{Ԝ}F���G�5p}���lND%A�nqW�^�-O��W-Ë��!�*�w�7A��Z��̍�9a�pe2��ҍ�L~�,.D�$����h�Y)�ӕ�uMp����A���4������J�*� �#Ǵ� ��>M��V �& f�?���c��o7Kt	�dsxf;�S��h�t����y
����%��\i�Y[����M�3�˨1�}���?����vZ��QBD$ˎ�.qe{5Bs ��5�D�0�����f�&�q���+�@��1+�p�޶o�g}5ߵ�� Wi$���.71�%�������0즉`b�W�]Ӡ�a��7�x�&�4�K��52t�D��(�bz>c���_��|�B�@|�ۑL>=����L����\ӕS�Ǭ��ǭ���E�1�����*[~�S���a�;���%�}�akGN���k�������s�i����˩�:�dk��?�Σ��j�88q�1���o꿘�&������SE�D���K��(.�k�h���t��>d�ì~�{.���{_PZɻ�>�sM@L[��!�hc����Y���=n㏸&{�����u��F�|^�!{�����z��-wJ}�Xo��)��}1D>E�5S��`S�qE ��p�S����\�g�Ut���t�i�!�x5L
B�O����@�����4o�=F�c͵���X�H�c¿�y	�;s_2m*����5&���u;^͋�B�u�j�g,˒8��h�m�G�Z�CF덴9?s4��g��Ad�A�?�p�T.�y`͂������X>t	݌�ؖ�4�$c}T6'�ߒ�K:�c&���C��!Fh0:2"��l�3s�̾g�����.�]0��M��*����~����6�&qV�\Ʋ�e����[��`O��l�m������0M�i���p��#X ��'T�0L�Kn�(��*=�|�>!�T�J߾�~Ӛif��[3�ܼ��.���    �Y��B��2�	*jס��t���&���{0K�#��3�=��X�͎�d���-�҆�a{s>.
�1]���8]U�Xk��*�8n�{�h+��� �����f�.eL3����`�4L� Gƙ�55  ��dX��_1ܵ[s��8P-��I$�?��P�$�L�QH���/��U�~=1���&x_0E���{����=���^��%���],n���0֭��>x����Fh���x�t.v��> �P�9��h��ei_��΂�Y���y~�m� �}��3�&�����Jy+��E_��ۡbb�F�uU��YU�9/�W��t�igkr�)�5�Wӿr5��z`��6|6��]��;��x�v�����jJm㇟\�#r�L~	���YHM�L�լ���\��1[~1�:�/��������yT�̡�����A���2�'����~e��ٿ	�86R(��N6u����Ӷ���4�1�xow��B���F�k�j	}��;�*�-�%�]E���N"���ш�<���q�Ჲ��V��_�}�����+�H�K�.�R�TR���T[��'��|lyQ�q�?�l�d5�"�L@"M�f�L3b�&*�17�<�DU�9}�C�~�q��U$?��qǀX}�o�
�/k�LV))�P}�baII�j��.ݏR%�󶶧��T-�̾��>߿oq_V0��;�Ɩ�5�����8�ț�5�I������NK�[���nr�e.6�|xǾH�L݀[s����#�~���B���H��_2�*��Ț�ׯ��YY�Do4�����s7_����Y�k�:i�k�B���^d�k:wD?��S-�LKb޶��S�8 �fv�8�و��"��g7y���tu�d��v����!w|�
��!9��5�-Q/���OF"	+�1l~�1����]�M�(0a�y�`��;�Ʉ��s���Q����M� ��X��h&�w�9J�����}]��KY��JC�2����鮾��9���D�W�	���3�����Y�H�nq#�9���z�G�X�!�1n�m��Fp�:��d���͕������s8�ݷ�?"�YF�'`�f������"p�8�~-ٷ��~;�wSơ�e��^l�kJ� �F�!Ì���A������A�m	v
R��%m�J�"��p���O�*4��3���LQ�;¿˫&.��y�)�NC �8Ҕt��I������6	�ˈ�6�%�(��������F�]Ŀ2-�Jk-7l4��m�i����#�g��_0Ae�@�5�K�?��ߛ�ҷ�|p��>7ݑx�W�Z^~���Ե���aI��9�ѷ�׀
]&�������S�����wp��>K��y���d��'ּj��o�#e��&.��/\�d0R셭^S�G6×���������!�9|�P�k�u���^�O�������K-V�Q�����w�;��qF���k�<�/ {ƛh(�;��QI��xB����Y�"촅�S�NWQ�sC�,9�/��04�d.s���B��N�O�P�KB���.������r#�6�:s
���F�lh,���%��'JS�;�T�ψ��M�V�#vxk�Kp��KpA� �.3V���A�-HB���H��"�m�X��q�%/ ��u����}�ͻ����ݱ`��q�*a=�7�xy�Q0s���K�}��8� ��m��ǯw�ނ;��w^������y��r�,�Ҿ����%T�N�w�p�t5�=NS�_o(��3]oH���v�]��`�*���25�2�%��Yb�z���y�l�9�eT�y��kO�Y�����M�z��֓$����j"x:}3�03��׎�i��4" C5�S���"�y��@����#̲.Ӣu���/�>F�O���M�4tȜ(��F���|T�-|8õIm_���d�� 7����Z*ggW�I�EI_SkVo 9�r�E����Loo�n�O���e9�M1�zE��$����0�\,��ơ<S�����
�9n'�i�d���(�[�N��L��^]}*��W�I>��%���'<.a��}�㫲A��K�)�4[y�o�ݦ�������+�^����Q�ۡ��0��x�u�{�fѮ}��0B>�(g��b�ɕ�	��&�ܬ�s{�^�3Ư���yr*�W������d�	�&������+]b4x�y0=(�	��g��ٹy���	V�ٷ%�o����	E���0�Q�-��e�}\Iؔ��A\AQ��4|x��#N�s\���R��- �5��J��uG�����x�2�ȗ�nt�B�"�wu�|P[.�}7�Y��h����hH+��� "^S%|Ւuiw�*�?��|����&T�\�DS�& *�U|���`v���v-ہ~?u�Q�O1 ��3��"z���ل&������v�S�-��^}��}a��j�:�yZ�*D_���T����Lf|��Ե6�;����/&��52���^t�����O>XY�\W݃�>ݨ�ȣ��g0%Kk�.Q�����܄1��������x�;���[}�'��32ir&5~�o+4��	�\+s�Ɛ �h���b�]qP��o���]Êx�%HSX�=4caŵ���y���ß΍f��������BT�sl����\ێ�/Y�e�0 ѡ�9�r~A�!>�ĺi�������1�=�~�U������Z9	M��\�ܚ�F�6?��i��6MC���s���Sh3�&+CqP��a��d:Y��<kDV-���ggJA�,Y��ދ� ��Q�{[������4�0�Q�������-�M6� xݫ��ի��(_���c@��s#y^��9�4���̸S�)WO�d�Wqz���D�
�J���B��L�ߋe���1�qh|�Ҭ��p��ą��l�x��i��~���,����m����LG� �". �ĤΚиD��}�ͺ���[��0�*���{���5����*]/����v�����{U�����4g�y�a����#f��w�ٹ�T(3�2<=�nirE�i}K�<�r3�N��cH&��Ռ~i�w�4�O���}�����O��[����P8 �"�`��xE�Z��Ǜ� *�����L{�4�nJ����ڮ�a�uYT��c8��H͵o}����{�F��W��E�ep�u��b��@���v��.	��2�z}�����|z]�%�%2��{b0<
�|d�?E�����e@�A*fV�ۘ!I�o�dDp�Ľ=|Ο�9����ˌ>.����A�=�eCN� ��A�9����q=R�	��z�/�yzw����{�!q������L>�	+Qf�M�r��!�����kR��!q��D1���^��J��}/޺�<g�|�L�`m d�&�ד���!\�R����;h���x	p��! ��y$��v`a�o�9�%pFk��|��!ҍ8��`��K�·�+_�	�������~e$�;��X/-�>���zR0��"}!�1"���1�%J��y�SIn>y����7$ ��i���u�}M�Vތ���<�J�S��'Ի�6ռ��~�3E�7���ks��m����-�,p㢽�q�1�'����,;F�^_�Ȓ;c�8�P]W�u^�����}�j�HH�F��I"�W���(�vV�O�z�����^d�����O1�ϴ{���H�_�����Z	�ڄ��F�!:I�o�\�R����g`�!���X2:g�R廠/KL~�`���}��ŀ�����?�,�X�ʇ�*o{i�=��trפ�����+�	�_9)�<�@ժ�����:������������6L��ρ��8j�J��Ņ���O� �\{*.���;�W��%M���1��5ͮx����ddZ,~�m���Q��۫2ԥ;3�8���:�^�nև��j����|_^2�k^��$�dd|yw�P.��q8/�Z�=��)T�L��ڑ޻�T�����;�P�P._R�~<�*ش���'onq_^�uMm������_�    =�
����Xtg����O�0(�}6�m�=B�w�]�0����v�IEp����֛��1�h��E��]D�%�3�k��*�-�>�@�&�#� �������9�*�j�Swg�N�o��/�#b��F�9��� �qbq{W���)��w Kʄ��V��$x��U4�Ǘp4�?�Hi��H��_di�/Oy�v93�q���B&Z$���N^[o�f|P>2�ˎ�{�Ԁ,��C`M�|���yk�u��$>Ia{6E^�O@�ς���������W��=5��:
!�+��	����z��w4�0�b|u	�F�4Ia��>*�ç�ع��:��y.�`�^e��ܮ�x�oN���K���(�>�����VH����Ϡ^�>=�n� ȝ��}���ER�?~Z'4 ��b�<@��wMe�[� �{�I�EN�ڢ��}~0�)�Ԓ{�f^�N!H��P�oٲm7h藌vو�?�����׮��<��JA]����չ�J��Pai̭59,_�y��VU�cS��ʖ������@�#*Ɠv�T��������L'�[��� .�Em_�D���T�X�+��ΗtJعE��^���m�r���U޿o��(p{䃪R\~G��Q>h�EsA�5`j��@\�Jx�1�F�m�bvm���L��'��o�gʶ_��y��/�ַ�0H-���b����ڽ@R���%ݨg���3�b%7\Y�^du>5 r�W�K���}o��рc�B�Ҍm�H��VG_3*6������v#��ِ��ᔏ�O�����#�|��hT����Q�ol%R����]��.�d��D&;O�����Vq���gj2:�H0VrgI��q�w�~��e��m�������_mV�k�L-�����f@��4��P�;ɔ��O������xE���t��&�_�(��T�q� �\��R��󼝓'T���:t?�����*w�FO�W��Rv7��E�]C%v�r>t5b���c,65W~6�5k�"�cW�f���bQ};��|��NJ�E!�C�Lf�6��3�	�JaXA�?y~g9�R\��H i�}�p�����l��,f��c�Zͷ�*bn����̓�r, ��#�KIx����˃����h�*7:�9�=(�3j񽳷`���.
��Ӌ?�c���!��H�����g�q�*��lҨ����d�����x�h�]��eE�ҡ=�l˩�c/w��'�0�K5O�[(�=�&�3F*a��@1�@��u��K �Sp)�`D�ťM5�~�K{��x���h{b���>LMe bAuM\p2<}?B����G揗y�8i�B��g�_W_� ��ԉ,�=ٳ��Η��[L)<6�ѐ�\�o@�:�w��s���pt��H%�H�v%����0���OnB�c�I� ����,]�K��}\��7������+��yeڎ�~�40	�7�O\���r4w�Ẩ��l��%��Iˆ&��M��U}�D�Q�g�:�g�|�D���BD�$�2�0�Q7����DlDe"���2N]�M���7�~A\�<E r��Y�k:����)Q'�n\3qFQ�dR��3V{"���[q~�n�g�is�1P���V�v."�>[z�C�<��˱��Ld��G�=˧�p%�ϳj+��|bO�3��,E�!v*:J�
��X�jD$[b��wW�Y_�ChDX�t1o���q�㒄�ݫ�����X8��/_����R�^�(��N���&셥��;d� ���w��L�}-�h���
�f�2�"�/�K������ܒ;��Ʃ����j�ʣ���aP��2��(_j-�%�+>��z�'s�3��rAf~W]��8�aƩ ܸ��T���NZ�x�*`�q/A�S�i,Y��ЇUKF�v;az�=@?�&RV��
�&����	
��C#���� �S �Z"���2䄎��Sdk���I�WV^�L`�=��Q�F���0)/Ax�z:��MХ������`�[->t�ה
]tS�E�;�gP!]%E�:f�9�̧���/`���������A��{�g]Z��@�z��P�Ǒ� �)�2>�{��ԉ�a��5���0�(�o������G�L\�]���h��o�6ԁY,��fݎ越m����AC�<�=��r~��<W�M}�\����s����z�TQ�?�y��2��*�]H޶ٞe�7� m�Z���Lװ���xS�HB�ی;�ّ��c��4�@Igb 6��!�B"k������VC��n�F�FS[	5l>8c��^x]�r�AL�5@�&ǦN���yN3ʛľ�пy1b-I������b�I�,Yq�^��:�w�$	�j���FF�8P�p��<�\Ӭp�������,\&t]ʚ���� ����$��F����k�<N��b��0��q�>+��c$8D�7r���/�
�:�	��O<�=��3$�l&�[F��NMeӁX��>ړ+u�]8paѬ��]�$��E�� ����\��b�g,
�{�K�R$�S�� �'�Zu�P�7�R�PÑ�ੁ��ųc��f��E�̑dds_圐���h�{�B;��3r;8sf�ќd/����oh����|�ԧA6�o��SD=4���w]�>=ԩ�AD6B�Ж0t��?��5?�gu���p$/��#��<�h:��[��3x^.���'���#8��X .ٔ*��T��+���[�Y��:�o�z���r���V��m^�g����_�OŒ3>и�F�:f��C��p�{5;��Ds��dKt!�VUJ��<!�7��I��8 ��o֭+qNu���'�2W.��Ӻ�s�F�'�
m �L5Dϥ������=���qӨ$
���.����Z� 4= N�ft�b�%��v��~-�2(&�m���<䧱F��f�FZ� ��G���I1~L�G�#5����;�b^��0��1���U�$�,����?�<K������{��|"�w�!��f�W�R��3���lzb�p�|�4�>�{�ߖW�
#똲��'��q�d�gZ����!Vl]�ɧZu��L�EFT�E�:�nm�G����!8y��]���K`@��-gO"�h�`Pӻ�m�eP؃���Z8v����~�\��l��ju�[�t�l�1?����������{On�\[E��5��:޹�!KAQM�,8�Y kDx'�/����le����K�C�����)r"�5ۏ|+W��|���|�y#��}�~� �}�~��$;)Ge���!H!�k�NB�W�ك��p�ζ���g����ߐ[���y�)�,����js-{#��;��q!��FG��.=5u:��=�"^�O�Y1K3J���V�y?qݘ��<�z�%����x����l�㜼g�l����8����A"�;|K�L+�(��'��>0�|+%>��i��5r��ެ��S�44$�%�\�/��4�[L_��i���SΑ������V7yX�˻M�eSY����X� Eڧ�O���#&�*HL*M�� `�q>���l1��Yx��JϾw�"H��Z��]4d<Y�~��\>�����L���JVԊ~V�UH���P�Z��4��5'�H�T���ǿ!�
e���"g��&��\�Re��\e�v����]�RޅQ�xdK9I�S���S��x;k�﵏G�LS*Y�j�.N��OmR蓅&�vE����Y��p!��]ͥ�rY���@YF�ox�(#E^��I��G�V嵀�JZ��"��O�'��?8S]M$>�sP����h�"q����Q��"�����hx�8��%�G�
­i���EC��2�x��7^�aꒋ���������OHh��W�Vw%�0�H?4�n����G=LL=yWw�f�����O&������j o�3A;��n��7+H^y)w&�-�0��nt_ÿt������lƋ����r^��F�;�S�4 m�Gq�.�q1�߿{;�*�����qv��y�G0�4    M�^�� �tt�����u�A���g
YEWWy���c�+��CK�e�/kc�_{PE��J�S�@Q����ү_Qρ3]�9>�?�;����ţcmdL���{�7���%i"�x�''��SpD��y�{J����vw���cA�
3��֗���o[�o�W�/N�^�.b�aπ��M7�1.���8��/-��*��2U+ե(��n��}�+������m���^kw]ON}C��ל��ͯ��S�bk��{������m��v|]���D����E�x*�돿�A� ���0�����c��H�F��������4R���m��z�d���RY�'��g��[����dm����;o� �--�y,�'�ߦ �S�u�xά"�u��P��r�3�����S'�����r���e�˃N�k윪n�*�hL/X����_�v���M�3�<����__uH���^�1�6�� ����c��u����ٖ���B��@Q��΃����sY�N��K�1��}Ge�ի/��م>����x��*T���gę:��&�=��`�=�*���sc��e0���/G��3u-��=��p��°G�3��(���~�fT���X��x'��U�����Ӆ���;Y�|w
8g�,'=%����"�G�5~����S���/4��W#�r���J�7o<|��e��ȗ�� ~�4���A�t����^W�����rZK��Ǟ�%���b�t<�.M��/Qo3I���� ����V7�����90��L���=�`w��lH�&Ԫ�b�>�������WPx�4M��B�+t�0��M������dʺ�v����׋w�U���@y>:ې�wAU��ϻZ�����M/�4+����\�-�@�� �Y��B����7���Eߗa�����񛫄�X ���Sગ�X=�<���0WqW3�тD��e~.�c�N
{�gq��#���qY��(��`},�}�HN��4s�U�aހb��e �'[�ùb���#W� 5����~�����E���	�g<KW� =n�8N�
�� �fTI�>~+��]}�b�����Q��E ��k�t���͎w� ��E�o?��r��t�b�e�,�y���7*�2O{�N=Nʪ����'DU�\Ú����Jkڰ ��T����˅�f���k�Oɮo�=�J�<��Wn��ό�o��M,'>�N+%(�6�AO-3mo�NW�6���O��Ok9��XNs�GN�ip���3��ɝ�
f^a�ߢ�8�2�yF�]�S�%_X~���}�M�y�c���ބs���߆M�#.+�#3N�>�i~�:E��y�j���A�q��I7UU�ւ恱��Z���d�E�����o��kI7|��@j[L�F!�P<bl=�`�D*y�a&����;y�,v�e�>����d*�~����ú�b-b~=�2����m[W#-�?���oĢ����i�o~õ��ݐj��R��B��~K�b�)m)�.����Hdx�OE� ܺ �;��}^ w�����M���ي���<�&X�x�(�ioPw�j
.wq�T�z���0��|�a;�����E�g��!��J�w;�7\�*@/�϶�|�ѕ��ؕ5��$gՈ?f��*������ �rϫ��t���1k��.�O�������������i7�cU"{ӌ�c�Ԋ�[�����3�0.:�q8���v��i$�%S�n���Q�J������^i[�jH��k�m���qn���e��/�#%p?@��߻���2Z�����ù�p9�{�(}E�Kns��jiʂ& \��'ɮ�ړQ�V]�|�,�)��8��o_�NT�m��_.,p� ?�g�	��?�ĺ�� R�������GVt^^�1竮i_G��W:�а$!�R2˧���
�|]�r+�z�N�֖Zg��?9:���_U猗ؒ��:K3;	&C *>^�lZ���i.z��V��s�_N<�6��nJg�\y#����=Ŧ�")I��y14(�Ҹ\h�3]^ aG��P���%Z56��}�ΣZ6OM�
|�Z=�+-���K`��o>(ɘ��d��Sϛ�*�+�xhavb�a��u�p��X@�,�s��;�qs�/v��gfl��lT��ׅē��� _�U<an�QT+7;J�{k}l��ܼw������Ԧ�b�!�����nKՌW�v.�30� �g��o�^�[դ��߯9���5��}��X�B�M�޴ǯ^#�mu������i�Ӡ��``d����V��V/m"�e�WK:�^���k�:"!�3��`x��fis�����^"����F��N�7�������
D}o�d��& �M��f�VX��ݩ������u�y#�����!��E�+^l�رb��6 Y���ԯr�%�2ꀬ���I P������ ��0q��"$�Z�z�^LvMK�C$"�;����x�y(����%zN\z��z���"�e2�����»���sb��#jL���WoS4f
���s,_���s��]t:N��7�{i�~��Z6�o�������5��~୒�W������n����f𐵀
��`�����b���̞H��pnu��[,�4z�̋��g�������IHξF����O{ۋ����(Åv��o8w�Y}N�\Vj�8�F�!�%��7q�2�� 4�`�ĈF3��d�ɰ�>ٟ��7�9��������W|�|懙��3���7����P����K-�\���J��s�L4�����s�X��bJ\�NP�C��"�h��q����ȧ����4�5��T��ʒ/�
K��0L�u�����,�M�OW_���4�2�r�o���ϛf5�w!����j�O���� ;,(da��;ʢ���-�R]\��Xs���	"�~�]I��CU��tyߩ���o���*�����V� 7s��>Y �M�g�}�Ԧp��$M�NP����~�� U�5є��r�:+6:��YQ �x��{�S4���5��b���F�_s����ȿ���ЋG�l��:������z����32��[(���O�V�Eo��p�D�$�ۧ-���yP(�`����U��W��u����,D\��M�i$���N5�3س�¼=���F��|�Z��R�~�4B�.��g�� �O���ęά	~׀�pc��b �x���[�l풅��O3C&���y?!���ƿ�/돢8��n��y�Y��KH�=�����Ak�	�3��� M��l�I-�-��/�����ܳ��).�0�	���3rdto�O���0ѡFa2T*�T�k ���.,s�{͟���Bْ�BD�����4=�Y�qop�V�m�(�r�Ǹ�}���� ���RR�.�B]AkKr9./����b{B�kr�>��b�>�8� �h��d�Y���؅����t/�u|TS6)��k1��%N�V8t�s��o��3�p�;T�����5���n�e����y��#��g2��>���@���o&ώ��]{����oB��?t1 9����u�vǓ�}�j�H������XH1��' d{�(F5 �Yh�X2��r��齴�y�p'=�5���_&��͖פ���_��t�i�k��V|ȧIfpt^��,G�!�/��C�M��������8t5m'	��0w�O�i�A����.KY�g�u�e�ljO6O]��F�LE���,4���{������.��}	���d�e���R�. �ݢ��^^p�$|�p~W�zYZ��(���� �V��0�%��A��ڋ�.V��x=-p��a�.��-=�-j�'�q(���t��t����S�Q�:F�3LĤ��]8�|���HZ�h��~�<x��ŧ��5�x�Oς�E>���N�l�û�/���նQ������=+�9��g�x^�3޳�_<�h����3�.y+�q�R#E(w�-�$��w�?�r��>�Fay���5y/��*<Jݮߢx�(��:?�8��A錱nm��ڸ�����9;Wm=����R��    �9�hV߫���GpF�l�LiڅP���c�G\$�,�3|vh�����~� '��.���(�� �ۦ�ډ�M���X���wQ�H�H����)͸�b:�?\pX��?v��������v���/ׂgr˕�l�\���^&��6���YS7,�2=f�#+�e�b�	�I�i*p�,��Hac �7
���>�/�bYݮ���\��q�TE\� � wϦ6�}y�z��8�nӶ�����}�3G�8�2Q���X0��g㵒p�U�'�&1�ɵt��w�⥝��Z�5��5pR��'�wz���Y�'����s�g+��N^�Y.�����)�w�:���j�1�����;|#�Ďس;����!�ц�5��~��S�	L)R�fާ[SbKpƎ��5U�o��s����$k�3ң��ߋ�o��~�;}o�(�Nn ^{�iQ��Ul5�%8Π�[� �M|"�. Nxr��'�H����Q��o��"�u����Wyo}��@|�����1�����1�T�-����x���.��	���q(W\EB���h��kuK���QJ�bN�]pCK�Uk��{3=s�������
oÿj�fFAۍ�֗��{�d�s�z�K9��Q���ux���4<A>>y��ҔQ 5aT@|�K,�W��%&h���o��x��Xd�:I8���4��� ��S隌 �*����ZY�	�w/S9��(N�;��7]i'�x9���C��H�n������r��w���6,�[�h��sW�[�3i���	[�7��)M�ߐ�-��w����r��3CSw�>�m�䪍�B�N}�W젝�I���M����<-���u��3��ifB�Y�54U���g�G�Ƶ���	�5��2����[L�:6e�* )���t�A�(�˛��~�54��/�3���C��Qؤ�;Wo�S�= �=��i��N>��D*��;�-k␋8w$%�����S9,WcS�d�Z^�_?gۚ�?��Aqo`?U��I����P�(����t���%R/������σs������Z,��ts�߹T�����g����d�$�y���}�o���U�R��U��</0���$�e��6?��?ۆ	�e�E��b�&��c�.����E|�~O�]֦,�Wi��b�%>��*�{ğ܁E���f@�g~(�p2{�"�n�V kS.����wp���G1ړ�~~��Ζ?=.�U���Y�c�˗��ɼn|�E��戄��ߺPdJ���x�Wzo۶eQ���㩨��'��8/��+�v�#�|#P��22�e_
$H�#��C�����
���I �2��9��ί��̥+��Z4�J(M�K+��d]�e7��魵��0�8�B���p��J�d\`�,b��CJ��d�*�y����gIÙ������9�����Y)��2��x9��>� ��KLq�_��=�����q���#�|���ݑ�5�=V%ƷY��#�u��OЎќ�U}w�-A���,E����Y��J���Ѳ~X1�q�bu}R�v�qQ���k!�
�$~��Űܯw��h��WKnB�Bf6�su0���� J��gVe��4�;���G(���K�x��װ��{I�Ο�,�*�Ru��ŭ��k��E��ΈyNӯ1E�f�^ 
�%!���
�� ��ĝy��mZ�+ӛ+[,�e���#'�}�٪z�p��g��=d�;t�8T��A��rra���
	��o��UԾ�%|���;���.�o}�{���R1�����=7�x��o�bM�
6�����V�o��	��-�s��2�ghvƱ���xR@׻f(V�/��s��#]h�ǈ�:�)��H��Z٥Җ��NT��5�>X�����4_��*���s�����|�>A�L���gq����sͨ�Oe�ne
b�}֨үY�F};
��l�)Kh���+ NQ��:]�j�K����D�X�L�|ԧ�&3 z8Ǥ�K�v���1G�ܤLծ+�PE�:u�X������	�恢�~+�zǚl��<V,�>ˡx[����'v4�3"έ�sc{N�́�s�$�B����-��
6��j�Sl�]���R�N�/�u�R�T���6 ��P�J��}9�_1 P�b�X��#�lϘz״��=���+I���Nm�@����ǃ�E���&��6d?�(��إ	*.������X��|�e��Ӝ��&!ф�Ü[�p���P�ױ���	�(��o�OX����û�D�St^�K���O�7�%��nW��1�&��ݞ����7�׫�Z��/ז��g����(c�]s}r8�Xݡ��/�����zuFR�Ls\��4��s��֓H!ª�\v�!E�2����pʳq��r�u���n޼4���o����B#�M��z�����}�`NL���4�O3�Q��$Ta;��/�ʫ�`���%xy�}���{bk����[Or�����Qԝ6jU}N��ߺ����/~!�7h#��8#�M�O�ս�x�)<gT5��.j�\�d����8`X�S��|�2ִp��B���t���������,O#���x?�	["��D�������u���	O�K{��ʯg�d�(Đ?�e���ܟ dƃ��7�� ��o�3�U=a�A'� a�����V5�������6��������~x��re
�q���
�d���K��w(F�v!_6vM2��{��`?;�NrW$7�t`��<��5n�0��/�Ai�u���yq~�d ��p" ��P|}�6�A�Q��%I��4���~]a@n��|vo�b��nh�E�-b�F�.��^\��o�h�#]#���G���t��i�>}��V�+���>i����]d&������,���Z�'��C=�K�����A<��t�//�B�|�OE �� �8ɰ7�{�h~��#�.HSL�PZ�����5�X�\��+^��U��D�~QbL �դ�	z���R�X�g�'Z�;25;�����������K}:C�FPT��{��c��R�vK�K&���)G8�3�6J�	�=��}_. *E8�;R&˕ޝ���5��uj\����u�	6�1��Fz�ʣ�!҅[	��G'��izK���H���j����p�a�;c9������_�	5���ԒNz��:ǹR}����3Uv��E>�d����y�>CR�ԉ�w���8o&��V;d�¿% 99�|���"D�S� Vp�������0G�wz�dJ�+��q��<�ŧъ{�j�p����8�"�����U����x�B��%����/����
Pu>�;X|@��`쓾��!��2�>�?�J�'6NZ�cU�0��4(�ܭ��w��q2+��)�)����t��E�w�%�S�+��V�-=�	o�
�p��y��x-�@�����S���i�#^��`NW��v�P�)�����o��ȩ8"-Yx�����}g�o�Xagy�K�9�NM���׸$rj�?C�c��?v?���h^����[��RTrZ����;q.TNm+���	�x|������e� nS�"	ryE�@��OsR�
l��\c�f�!x��bֺ�%?vhM�>߫��Q���}x谗�Io��ƾp%;����m�q�Z�kK5H�5��ݝ�K�jQ��W�`�Q �x9\m��?3���<���{S�2����5;!ʙ��TF���8�b3�����߼��WGp�;p���m��oB߰{}�=~��F�U�W��4��,�?�!_���T��
���x��R'pOw���e8� ���,,d�섴�<�04$�ף>,��`�c�zwb�m��Z؏x����	���j�]_}D��{pw��&@���c'�S�r����B�������X"�Z[��e$hd�|�`d�5 Ƒ:��?�Z�cց��{�kΛ�S��~�ס�q�w�=|���.����=���&&~~/��F�&�L�J�/	s��%��+M=o������a�H�Ԕ�*.7�l!�k�=ل{Y-D
���L    ���tG���������|@i�fic /=��f�N��`��ſ����R��?�7�Q8ۧf���f����[�]/�*���!l�ឭ 5[�$�tdC��P��|5���Ñ��8x���ri����皟Y/��W�����ft��/�N����.�ö6�:���gZ(f�b> �u��K2K �-q})Yõ��Ј3���nх<"��2A~�l>ΠU��������ýOe8���|��^��:����=O��X�qܠ	�����!���$<�WrH߃k�Y(}�<���[�.��D�s4ZDQ 87t��F�Q�a`܅��4.�i�/�-'(��������2l[�]�0T����C��52:�r	����J��N�������T��b.'eUX���� �ag���{3�_�9&���3n��4���f�z�� ȁ�.L�z�V��Lwē��ƒ�R����d�h��(�sgt �]���YX��b]�,�c�]�!�x�~D�|`a�,9J3��/ v/���DW��[S^uM��W����!�8$��{/�K��-�ɋ�e�:���\D�.Y5��=�-��}#x�=T�bhZ������8P{�i�6^< �|�g��#
�B҃�a��}��p���2�����er�϶h n�͝w���6u60 ���2�b�8DD?����A���/�\l+�I#�)�;��[�G�y�Ϸ*ZqQlw��V.��g� sU"L	P�
���!�_���[K��	�@h:�)�҈����ug��-'U]�c�����eV�$Ϻ��UH5��@��:�6Gt��!Qz��(�O�.�j{�eB@�7JdQ����ha�3�/S<��?��^R۪�r���c�n:��#P��к����* �+��n�]�enB�,MߚA�i&�bx��*��[�e>Be�GmH�e� ��Ϙ^��6Rv��O�%�������*p����{8����/�*���w�u����=�:p���2!��+�%U8�a�'�S�g����)c�r�J,΃���9utFI~o�\t{�La���C}[ݎji��ا��;�V�����%�r��b�j�@1iK+^�
�å5��n���*9�D��W{b;:)���$	����糑��\R� 	/��
��B�� 5��d	ǌ�
EO����2��@��|9���p�g��D��2e��f��u��#<�R�@�.jCi�9���ں6B{5IҢ侩2��h�p?������)���I�g��Uk���`̑]���ۺ���E[n���e����؇��b/�8V���<���	=BFE��ڍ�q��c;^��4�p��&���(����� Rt��1��%ƔWW��+�.��ʊV(�����w[ۼ�R�����NwJ�j�o�;����ʺ|8Ƌ���j�� *�s�%b-o<[L��W��g0ޟGU����nCvY&�)n\V�t�rA;��z�����!�{�N~-dU�RK[u�$��[���ڮ���Be2�U�4�s��ƾw�U*�%#��L�A�iF��WZ����|k%���{-���YT��O�m?)�"�޲��K�4H��p���:�)���ܩ,<P`�O�7xL�̻'RLe��6Qpv(V��8����-K�Y��z�/�]��|YU&��p�k��u�H'H���7����Xn4�$Bh����쒀�W��6�j��p�R�3'�wG�>8~(��>4ǂ0t:V��x/~�+��k'u�,ʹ��vC���T��EmM<���6��w>�^����phӫOO}�2z�2w�$NR�zҴ?`�t�w*��������)-b_�_e�>�_�R�R�s�Q�;���:��M��g5��ϟ�"'�Hd��l��t�
�O�L��f�?���ū�?z*ϋʪ����P�/9C����Rpg:S1�/=��ϖ�!� dUL���7bl���#��kY�vܩ�_f�gq	su�[�N��u/�*�o��e[�8��~�w���r�Y�n��6�ྫ�QƮ��*C'���D�O7,��ʰc��%�e�@�
3�8ƴ{Z~�6�;O���|�)�O^}$����,�?!�u	-���%����y$�[{�^����
�_��?c���`�W����Sn�KZ7�L�.AZ�b4����č(�(~��|��9,d����������o�d����g�Q����˷�GP�����u����/����9�~Ww����7�C7$����-3l���2 Q7�wf��h�P�$�m�O;��5l{	�d8G_؇�����ޑ���Qԅ��aT����� ˵�]	��f|���|M�s����eDIa�J��.I�\J��l��Mg:��Q׮�+��s�
�e��|�wޥ���.�sa���$enN"�s��~�����2����n��*R�/ޞ[k?n)�f�+5��մ,= �a�(N��?]T��&���>?'�ph$>�����{-��lYbϥ��;���G���p��_��9�^U����׊e� d�cd�9ȳ�V��1l�X�,'1LKs�����7�s��SI�e�5��>���(�8ǯv�S+J������}�k�dF��Y �Q�>�ĸ�F���-+)dy_mX��f��u�6�_���¥ �q����J�l��K�:r��}0	W�ǥ�:,��xQ��SFl]:���G���"��5Bx��|���4����UC]z����UK܂����H<�̜|g���Δ�m_gM�n�C���z����X'�<��u��ی��%��^ʏh�v0�%6���;6`Ǜ�H�&'�f�ĵ�7B�o��B�4{@�կ)uՋذ�9��- M���ܫ�G��s���Θ)=Ć��O�y�Sw$�I��A�>=L��?5a�d���Qg��z�h]�/fYfZs����4?����:.Ӛ�ڲ�!����%'T�7��{f/�`Z�aB����l�.>;�t\� Ɩ�>�>�2-ή��:<�;zຳK�,˺�� �S��d����K\L���7@�Q4�/A�k�Ú�U����q�#l�̯��/���� �"��͒QGAjb�q��_$˨�=�~�} ��1o�sR�
t����ن��p�c����Ͽ���D��%�yA�n+[>H��o�{��^Z�i�3X�9�C��A����w��?�6k�ag����ʘ0��ũ���*T�T��j�sG�������@�0����2���9FG0���/?�����	�v!V�f�{�:��bV`���UC�����i�ם���ԴZ5������uF�y[x�ƍXA<y��EGŞ5����~6�·6��ԅۊ�eZ��ơ!}1i��{�[*̹ͥ������.-۷{`�F�@*��i�~�+�6uM��7]��&�ǫyiw��UN�wl{�s�M�j���f��:)S�[6+���%j�A=,�9|����ӥ�m���t^��i�F��;��Y��m<���3U��͗�A�B�jDV~k�L�Go�њ$��+M�DCl�|��"Q��J:��1lc3�|�����]�H�){�S�)
�`'�hS������}ե����y��(Z�;RY�y�9�*2SS�� Č;w�|>��@Pd1���_��������p�{� s�9aT�w�@��Έ>��J/%4|/6��j���CΨx�̶�Չ]\ED�_���^��� &(�-vo�������y2�@�$�>���`�O��Z��$�]�?=��*�l� H��L�A���I�����f~���|�� �	/�﷍ض뢛������X��,�`��%Qו�qÐa���5��r�~T%K�'��[�`��W�.��Nb�a$.g�\�Fv�b5W�@o��Y2���	^��%�u�
;x �Q�ގP�Ze\?0�X�Hm�<��Ei�I.P�K� �mO�5��d����(�^����ͺ��3���2��bG�����.�g[��ߎ.�0���`%���]��[�x��w�%�    W:bfU�ؗ3Uy�>�6^�r�5�z:�G��3���`Ga�������uVn7N�ޤ0�
�}�����o������b�a��v�/���[��[~��O�.�2��7���h����}2�o?�WME����ֆ��Ow����.��|���?)�o�x�^��^?p�_�h�8	e^_�Z�r��me�}}QI�"L��y=rKɯ��Kl�-Ε��/�"Wd��P,����Pp�P���_��ʏ<���$��n(9��;�cf_���(ߺ۠���%����[��;��3��x��	������% �<H��h�6�<˧o��4���s	e��L,����q�x��=�:��r���9�3?d5L���=%�~	�a��8r��n������_�^��h߳0D��w꾘q"i����i����B���,D�����+��:B���P����%?&]���1{4���JUk%���yɀ3��(���i��3��m�� �"���L�R�C"P�h����˾��u(�>n�'xp�W�sc�N	���}~��J9�sp�L�' P�M8	�lM�ۚqRalN��u�[VMb��t���H��֗�ï��T�^�<F=_���u���? ���Z���:4I q���M.6%x:Q��Ӻ��?��q������
ǎ3w&��������p�N����l}��@�B��� x���q"����k���-}�i�9`�@n��>�t�C�Qbj��OX�"Dbr�� XS�\Y�n �.��~O��1F���ks�D��i�0S�ʋHHǥ$B ���ʶ\!�ߘ.��<�n�p?�!u(z2�sX�"
���o$!T{}6S	����m���V�� (�_5�̵�3)�Z�3Թ�����s/R��Ϧ�wv�jj�������кV��㳺N�?�K�{�����֢Xd]����~�ۿO-���wc�qͷ��jد��/�Y�̌�ĖW�mNԌe�x*H~0C����P�"�^-�#�l�l�z����W��~>>�{�DНQ��-s`Dn�8
B�Y^ "<�t�ZD�{y�F���&>7�*�>#��"�[�����T�놋8Ϙg�R��G"Hf�3p�X�qm���2�z53���禰�*��.�H���]/����L,�Z�S2T��;��������as�mk�DQP�f��eˢ��A>�[^qw�V��@L�tfv?���y�/�Bu3�LuKfIB|�*j���Lb�����b�K�E7&���Y��	>�^\5�V�:!*N@^Ԣ6 ��9�$��8�g��TSKR�wQ������>3�V!\L��0�Wx|��m%�]T��Y�LYD�@n<�����?;C\�_q9N�$K�'MQ�����w���(Wn��i֕G$C<jN�~���tǖ���c�S1�EC�ȳ��׮��7v�Q-��y��\��$>_1�qj�\�t쇁���P��6��)/�9�����T�դ0;�u6b��H�Ń�S��; �l���{N��}? �h��ᖲ���^'������h�0Ə�5�N~M�7���[�OE��<���Fݼ�
w{�e�]����=2ߞ���`��-�=,f����D�>�	���%�µW����0�'�`	�O`㤹�C?�����4�>(>ٳv5E�r�`��S��OGGt�7:� ���)~:,�y�¨4��z�Ѻ̟uz���\����Fw�#���ݺv,�м�E���~'� o'�C͔J����Dg�A�#�� L������h��|�1��-1ڃ���e�r����~A�7�u�Jv���u��QY���*��>���5]���rCX��	��t� 1�	�V��P&�!�=���]��X�H2��;��c�5�ɋ��?#�xϽ�Q�"���9����Nuj|ǝ�8�U�$5���͟Gi�z�r��^xA�ʾp���[��8$�-<��՞{x0��4���n���v񒼹n�T���@��ol	��P�ǝ�
��aw�:tx�{�7���
 $�Q�����TeK
L]<>e����}����hݰ�C^��3E �!���y����0�;m���>��#S�[���j�ܝtm*��w���^�����@�Ą���q��QU=�� ���|ӡXr=R��!�6G����A��F�ٗJҳ���^[�g���
i�4T���13D��0���$F��!��O�tr"�t@�|Z�!���7����+�<����lW��X��īF@�>B*�/�A�St�A!4$[�\��}I��u*�/��	yS�<�����ΣL�-�sYI�m�j�|��rXz��6B�CC��mZ6�9�,Cz���$(�O����qH�c��xgM��U�Q��1����H8���Ƶ3�!�SKGh�%�7eem�D�+�)l�d��>3�M����h�m�u��ߞ��ѻ�Tӡ�'�|_�C�ũ��dx�����J3�א=����B��ϗ�b��f��=V����%�F'4A�6��[�����z4ƫg��ѶȠ�^.�OK~�3��I6<nN��
�.\��O�^���v߳8@k�0�@ː��)�A"+�>���A��}Rd�*���ʅ��wa���#���LYV�d/$�]}�/�:G�����e��q�E��b����J)k�"�7�9������T���/�E`��{.�>*ܣ���F��J4����� ������h}�����B��·_�|S��x;M��mQ��@v:8�����whj�f�����E�cn����Y�-<ߡ�+�#�[�v��R#q���LqpA�v���=��ِ�6��Hϖ�h~G�/�����p$�YoT*ͮ����O'�_Z Y�Si�.�5c�i���w�����O�b/^8��7fD?��jKI :1++��'1���L6Zѝ��1P3�L�]��o�2��+��30��9�̞<�)wH����R�n��j�����0UB6ΧN+oiS�,�cN����L&@��)��$CxZ+W�hN�Q���R�5�ɀ}2��O�G`Ⱥe�ׁ!m� T0������Fx�P����\���gQ�{e����掘�쐙]ћv<[!7}t�������{Q�vpk�5fPG��v��Bݴ���Z[�>�a�{�s�O���|1.O�~G� �u�ʨ�bx� �t4�2��ۅ㮻�(����ߛ��; ������:a��=X]�77t1?4��s4]����4I����D"�$ͻ��t��W�b=�+��\�<���o[yS�(I�J��Z�Z��V+�,["�'��̬p���V2� ��lY��z���͛n�s�|�IEX��k���)Y<a�s�o?�b'��������ttZ]��u_H;��&+��P'^�����I����oX�ln9�ўJ����]�o�����I��.?g�A׻L_O��>x��l��hv�X�f��}�Ƽ�<� &��{qh����#6�'6�B���I�T P�kct���,�G���}"/����|D�0n���&�r
@:_�p�6hf����7��c�5��ݜ�z20�D�5�>o'�,f���F+�M���(��>`�B��S뷚kk�s�b��p`e3e�~��B�+�GP�Wod3����~���.�p�����['�W���qİ��-I�L��M���L�}�
 ��'�{诫�Ⱦ�w9m�R��CE��TH��y�Û1W�e�]���Gs�Q:X4�B���"�d���&/������0�P.Đ��.�x����^���1�V�4K%o�?;b�E���t�[ᳮx����햌�I���B�}^e�Te�p'�]��p�s��Ŏ���ܵ�Bk��W���8Ʉ��n�N��V��p��hЯ��G#�g#�P���~�e}� f3)9�e�d�ݯ�t?�FF��բ2Ww���A���߉Ϳ"2��H�q=�I|�19��W?�1�)�do�ܯ�<7N냺����.!�	����ܿ�o \��g���M��!�낃��X��j�    #���Nr��0m�˞޺��d��w��CUfk3UM	�bG%x�q��'D����ʳ&T�um��Z��'{x�ȳzf�T�1�yj��t����2E��tOe�{*,� C��p_�1��TC�-�Y|��ݑ��!J7����U�Ʈ-���FHlD�j�)Mdx�E��x��|jo���/�u�5QQ�~S��!�`�q/���?O��4^T��۴:��w*���Y�X��J�KLo�/pZτ,�����1�8 ���8 k5;�s�����xRgs'�Ӝ����aB�!�7��$�डA5,ǜ��r�+��[���ݑ�+c�<�%�o��θo-E|�Q>���O�"2���驮 �`e�6a�ȸ�K}պ
�n?�D�g�?&'�nE�_�c��P��F�󲿡�q`<C���8@d;#[�E���Q�y�ࢫ��ŏ�����@2������K��:H�",lO1���rt�����(c��K�ɶI��"�"]��bhq�г!���^z���ڙ9��c���)��O���wn���X�B������q����Ļ����T�yĖ�5���<��քQ1�����s�J��7���>�������,�1��祏Jx;�%S��Z��k춆���p���O��Q܏JF��
�m�I��0c2l�ep@�x�L��٨�XX�o�R'�����k�Q��,Vx�dd#�j[���(���P#�COCE ���y���� _�db[a,̪�)�d�n�%�DP�r�:�ɡ�oU&䒓�&O�n��1dק����,�ٜ�1FCATe�˫' �dF"~YHQ���emq�;_�0t2�j!r�bN�]�J���I�o(2�C�d ��$��X�U&���D�䬘��B��P^%[��9=x���0�*wT聸�/Es�uȇ\˒!8�ݨxp��R_�w�9B�f��Nt<�1in��`�K���R��i�HZ��	��e����>�4�b����k%����K*�jpAc��\�a���` ��]QߨN�^�Ń�4�aC��Y��iM�L��_���e�9
�D�V�[(NB��H�����\ʯ�u��ʌt����������K4Rt0 d�+��܄;y��!Q�/�Xq�~�t���3_�
�s�������]*kD��R�+y��o�����?�cQj�P�q�=��$w�Y���8����)�����~o�9�[������	(o���?�O ?��m�Q�:D���N�;���oݬ�zTo�Bї�õw�1��7`�$S����T�[c��$|.��m[)��O*� �~��[N��-9ʛob����`i�}��D��Z�]�
��l�������I׾K���"C}jQ�V��	�W2�^�i���-�M�K��}��ګߠL�c/_��5z�W�뺧������:�g�W7������v����ø���r��;�Ŭ?1W��<3�`)5'�evl ��1�������,h���e����,[�X�s`a�@cǷ	��WDv^���i�˖X��ƣ��;��O��a�r�0�}=�K�CJ����2@�d����_+=��#�q&�=-~&���A:��<�^pGj��uc&�U�k Z�
�I�r�_A�ĭ���D�&��N&�xM4����
��[r/���{����A+�����opb~����32^��!�i�}qW�� ���A��Y��*��&�,�z�U����qD������;4v�5B��4�����K�nǧ2��7��D��,���{�~$��1��^m���d\��P�w��uŦ��\_6Zʶ�W��S���e���G$����A��*{��%�Ǭ��j{��r�U{.��'�uU�3D�*���������ۺ��/����h%�@���z���������6�@�
��-�舀���W�׻�&$�9 gb����6��?����z^�T�K�8�(��1(t�i��߸��=��f��C�w$y���������D���[���m������Ŕ�?�����~T�i�j�M�����J�,�L9��o�T�}@_��G�\��b��:��b����5"���9�+> ��kE��\A�	Mj�����Mq� B����{���[=����}S�hÿ���'��ư�W�x�ܯ[v�Lx�:���>�O�Wy]��X������x?U�7o�.3���/j�P����'��G���"Ɲ�+�O��c���&�=��Ȱ�G�`qs��P	�(WcS2,��VG˿u��5�?Q2&�#l��'�{�M��UJG<�e�عiوU��Vmޓ�\~'��	?S�އ�T�q����κP�����P���~�����w�<ˤ��]� ����q�Iz����%�D��n[�uC����?� ��`�����:;���y���#@K �;�_�&��r�)^�R�F��ys���՚_��Ҙ��{M*X�e�o?ܟxrE�����	������۔�7�\����,�.�,��#H6��F�o���j23��m��|^�z�f߸���`���g�\"���i�ףJ����J3�Ѻ����:D�B䟟1y��S�%~�V�3���ux�VtQ�+�K��I���0��'�b��O,|; �o���ն"�{��O��f���Q6��ݻji��EMn��[�������P�8��*�,T
�+<�<v�?��Bv9ÎRέ~��.H�X�4�e<O�JD�Q�e�P�K�%����7^��~�,_؋.cm7\�E[h
2+MR	�������E$�����m�L\.a,�#R���f�D�`�#�53y����mJ?���|~����_Al�E%@�npG�ގ%���SË��!��*�w�3@���ZH��V�"�Zr���e&��&�h���]rU4r̈́������˺�?�d��� ��b�������9���>);[����c�6%����.G����ؽi�N] v Y^�َ��"��l���j!K�5��P�+M2Kc�)b�!q��"ƿϕ���/����\+1>���dپ{J\�\����r���Mڌ�aOa�n�F�d�F�1��j���A6\�����Y]�w�5>��(5��ҽ��:�7��^J�oM\� î�&�|���5��&�m<Í�p�
=��Y�=C/D��b���+�o�k2���C���[+�i������_�"�� �t����1K��q3�&�|SrMt�*0X�Aï�|>��q�E��$�����:���B;���l����������s�
����4�S?u�Ҋ'��.E�W�ǡ����~tT(|S��7��#��/م�u�������R�֯z��y\��C�ȃ����M�g/t��%��?�u.1�i�K�e��r��������k`���'a�Jf;y)������-�;�e���&�ޏv��R��"`
�{�w�Gw�P3�_�Nx�{ �:X��r�'f*���z�]bvy/]�C�eH�_��B����y�;�8P�x� �ao͝=��XS�l�sk�)~����V�0���Ȥ��4[�DW�������ռ8R,��\%�&:pʲ,������:*ո.7���֠V�Z���"�����+�r�Γ k�.�����<�tӳ|�g�p��P�9~�W.�>]�a��=�ڶ"���K��Yͯ�C�afJ��s��u���9�F�ݶX���2 �=?��i�og��e,�\�����	���a=�u])~}�?���i�m�ܽ �����)t�E1?Y�Ǒ��`L)��m���#}޹%�͝��}��)�M$�/c����vʯL�YV�";�ا�Y��̙0�q����V���nΝ�eeU��j
�1^���8UXYs�<�y7�9q����Ni���jv��������`�$�������� �@#2,C�Mv�V��wT��<�}�ڢ�w�򖄐�9C
�^w�󝵈�'&~�B� ��ho��/o|����[��k�:$��}������}��N<�̓�Fh��W�t�#v�w�     �P����h��ei]�����i�M�yn�:R����ك�)��#	Q�jc��܅P�<�.\�}�10L�Ѫ�
�,K�躷�)�Њg�?sig+��1�5�Wӿr5��r`�D|6�>�]��;��x�������r5�ֶ��O��t�5?�ڷ5;YH�L�Ũ���-�@�a��f^U�]3Xl�O�+ȹ!�(ǉCW������Jt�R�'����n����&���\
$C�Ѣ��2{zY�Qn�[�k��f��V!���-d�6�f_yNx�ai}�����H0��I���S��;�w.+�`	�j���ޗ����t�q	��P�J"b��աj=�΋�n6��L�ğN��ӕ�3D�& ����T$)�o�J�̍*�QAFB�n}�U��C�����G��#���C"��޲E�>mQ1E�Hq��sS�U�w�J��]����B5�"���}�oq�V��j�n}�d�X�}c#�����ղA/��D֥NK����73��a����ܱI^��sK��rrq�bD��/߇�Qߞ)I�v�!c*c��P��(~�N��"��JC��Oo�N�;���!p��W��ڳP�}{�i����ӣCׅ>��T�.�҃�ֵ� � �H���K�eVb�P��ٍ�O�+]�4�,���FC�=��|�_�d��S��@���V��#����_������@I�S���7`�y�`�;�Ʉ�u�}��-&����.M?� �F�n&�O��J�Iݼ�m[���V.0�@2u��a=�a�[]U�H�"�;u������pV�*�]�*'���^�V�Nn-�"R$А�����{-8n��n0Y����������)����!�,��'`s��������"p�8�n��hx����.�@\Ӧ���5�J Z#��n�U}�`?MY�{��d����D��rDI7��%������i [�ڰ~�x��)JxG�Oq���p!�1��� 3�$!�{~��å�o�`��u�eDx��T���{���x���i�M��Ii���-��~��ct�*��zO���_E��LP�Wx[������{�S�v��>N��p{�Rw�"��۫v+X����v}!,)�m>����
P��ds�WC@��c-�DL��=wIW=�c�j.BG?	��E�� |;.)��qinp��~O��z����_F�����.j���"�L�ۂ@�*�}Nf�^�O�eg���s%��Q���}�O��������Ӣi<!8���V��Pȳ�痊��c:���jd}��W��g���"�Y���� �"-���]�iI�2W�,[�(��%� $���,���h.72j��3'���m�Ⱥ�B��\B�^��e�H���8o[�7���[#]+l\�A�v����ꍜnN������Hk�(Vo+\|�3��d
`ݨԼxߟ������N_����^��.�q4�<�(�1��jޞ&N- �K�k����7�J���%,��BnԿ�l"�|@��`�����j�1p��n����ij�5��
�����O��Ϊ�K�>C��~U��BF���8SLQ@����r"���Vۼ�j���dl��y�w���1_$I���\U��=� ���3��=�(^��J=0T]��{����o��g�s�$?eZ4/5�������ظ�a�2F�n8�V"09%wvwmR[�y���.Y�����v�PS���9���(I���ij�>�GHN�\�G����{%��h�ᐯ��l�/��!fW�(bla���[�
C��<�K��>�>�A�@���Ė��A&K��R���h��8_���P*Ž,>H<|'..�ϻ��Ɖ�O߿KD�1E����G�f�-
\-�f$x�`UTJ�������\�C�!�f���0� w?I+̬]�&#�|:(9�'Sb5dJ{��tb[��~�o��w��^r޴�8����^eN��D<�Y
�X��j�O�����:Lw
�A�#C4,�O��N�&Kl�h�M��ć�K�i-B��CjB̬�{�|��z�C��C=	�T3�#(Jz�f��DD�p���ab�ٹ� ��P�Z�j�9��8�KFb�2�/�_C(Qd��*�Ԓ�r��zzVE؉i���4���w@���jɾ%�w�"�?��lYwq�G(`.���� ��*>���~0ۻ���mG^O�V�O�' �f�J7��E���o��8�s0;߾�K�M��^}85�n0C@�s�üLf�Mk*#Ѿ1�l��-}�R>�pL☫�=�7�����~�j�[����������}˻����y����da��%��:{����M�c��M�j����;���ֿ���Р���|�@G|;03���\C|l���n�v�F�Һ5=��%�
���8})h��0�k����{&��;_'����>;^�u�Y�Di�a7Eֳ�ӔkY����H&mJQ�,�7���c�͛&��=��c���X,��/�̓�,��4�O�-I��j���VN,À1D�,8מ��r
5a��h�A v*Cܑ;��L��F��Bd�4���;Sbi�����b���崶ֹ�?���J�H�t��E�ـ ���&��� �{���Ub��/����C�c��<����W�Hk�'�.Z���r2ު�8�z�ls�TE%�����L�ߋe��2�~h|�����p8X5�@���W��Y������|2�q����Τ�	-�`�P����K��^XO�����:c��"| &�XE�7��~_|��g�A��9�4����r��^V�������,?�9�}+��d���;��
%b:W�K��-�/��3�n��%PfD�I2�d21��+,�⎊���b�l���dC3�)�6��<.�P+T&z�WT��}|���)����^�q��&�{�� ��w��6�_b�`]�:U�'��1���O��ڷ>"��`ν����)��A�yp�}��b��@��5 ��^|�e*���������DK�Kd�}�U��p/�����&������Y@nc�8��"NDp���=xM���@P�M��.����A�\�aN.�x�hs$�����z$ &Xu�_�	�"��TAϷ�C�.�˥-�|�V�Pf䉍�r�V���`�5*�ϐ�z_����^��J��}7Z��qN��Z�<ƚ@Ȣ��ov�C�(%�����i���x	p���! �ҩ'c�	w`a�k�>�ٷ{���l���!tҍ8�7AW���<�l,����_w&��[)=F>!�p�j�h��P@O֕�	�\0����$��P�(���M$��|����I `��*��W�8��V>�:��<�
�S��'Ի<-���u�xg�ȫKW����@�S�Yu[<*Y�|p㼹�q�>�'����,ۇ�^]�Ȓ3a�8���S��y^|�͵!�1��#&�
Y�'�؛+i��Iɲ�:��A~�����EVkp	��yL��x����uHW쀝h��R��:�+�0�h���r%�se��s䟁��$2f`qo�IB���,1z���F��s���(:4��K�������gyl�%Q>�\ {�5ig�A�1;��;k	�_9)�:_�ʀ����:����r�����`����H��үfq���3מ�ê`�N�U�sI�#lq��#�BE��,�%=q�S-��)������,��tgF��ͫ����9�X���~�>��L���9��1�)]F�_@(��q8/ʒ-��	�����u���:�X������;�P�P�_P��x᥿j!5�/�X������Jo�����V�Υ��߱��l��f��� (�=6�i�=D�O�]�0�{��J;�h�ܿ]�Q��1�N
w\�U4�X�_����E�!�3��s,�?�A�v�A�KNW�4�}�Ei@)h-OMڙ$� �@��=	SH�]|�*�=��Ë����<eg+r��ʢ��b�dB��.W�S�(�Cd��覣��d_���(<,i/��D�ALq�[��Ma����0�����72�Ʉ��8�l���]�!�����    S�e���w��]���3��m�/!�4��{��Nb>����,߁0�y����SEE�|V��/Y�4��s�Q��������;�3��I��U7��<ຍ	A���o�3W_,��p�MOl4������xk2���C��oי���4a6���N��~�������]�� /%a��t^W�2�;�S	��|���Q0Z�µ��K���ߧ�[���T�S�}��~�ϳ,1��>D�s��R~�}��27����G�����DFw�)�7��w}��Օ?awa�!�`8�U�H�g���o�YB$6�������{8}�'��g�=������-�|P��o�_e�n|����"pX�k�e�{���Sar���2`��5�O`?[�iH��9'۫��o���d����]~a�����D )�`�$+�w��*����Yd}�L% r�r�z~�O2��oq�ͥ�a��i@�J�|���78�Y�H�0C�y����cw#<n��#��������������P]��EJB���a`��*�b?P��3_�'��{����וW�O�3]t�ћh��ڔ]Wn����筽�������4�:-�ŏ�����c��������'��W�h*��cJ���ጅQ�/��1yZ������o��k�Qd�} . �0�x��Fw�;���z�����s.��Y�^��뫮�$Ȍ1b���bQط��6)-o�#�j䜤ʲ��������?�2A����]��R���e�H��0�XM]o��L��o���͖�?Q�OA˙�����u�[���ې�����9:� ����RU�ɍŮ��vJ2�QYv��OY�8^�*LU�7 ͲO!|#�	����������z��*�g^OO������C �f:� ������^ ��a1C7��,W�L��k�Pbg��{�����C���_L/���y#{�d|��%�/�^���sj�
��ɓ�����-1��&�dw�ꅫ�$Y�}�y����F{���(�I�5�Tn�Ŋ�D�L��H#���[�[y�Z�����b��D⳴t������j�����
M�C�ysL|M�������.����1i�7��ú$����
��	�/�g�~�a'}"q���t��}n6[���G%)���f# �h�p��ԏ/
���R��r�����,���t��08}+�3�	�eh�P��u�ˑ>M��`�(@l��a]Ŏ��</C\���z�¡z�-�{�.Z�w[3}'�=�v�	�r՚�A7�QD��Oso'b=9Q>� :Qf,���0���He�q���,J�&7�����~Y�m�.K��Ε�tY� .�,�" 9E��Ϭϳ\A߸�;��R�yV�N�$.�[���x�K�j�B`���y�Q���H��ص6x��\���1�H��S˻�)��t��#���;�j>��o8O$�7w�8�# � 4cU�4h�$/J#�窓�bK���<��)��aS3ռ�:���@�2.�:i;r��x�\DX�AU���
%�>I�)���;R������xPu�tp�+�9q��5�X����ub�Vc�E�������{5��MsM�8�[�XS&��8Ӥes34?�Q?�V�K�W����'_�kw�TÐY�5O�v�zXi.�W~`>g���W�,t���xk�jV��y:[�6�êg��0��>(?�.QW����&1�΢I��C'o,���S �Z�ĵ:�ŁWXnP{y�Ǔ�����h[�,{Ȕ��O06/�i�~��&���t�	}v��V�~�D�^'����P�)��ҋ��ϠB�Ȫn�x%KV3��f, O<L�a��%�eO�$?��T����&�z�i�����-1��na��66ݑ[����q�����G�0�$�o������G�BZ�]���d�o�2��]ld(f�I��IY}�ݯ�CC�2���H=?�#-����@<��J����_�\w��*ᧇ�,���&qZc�x%8�����"H?<�����k<���x��DA�ۂ?��U��c��>"5����,y�9�E��7F��7x,zMB�74��q��j�a������?�ǅ�'�IY ԯJj)�����v����+����"����0��/��t̲�poJ��N��ʜ)�]	p�ht��E��p�������YIy���卮Kݲ�?�P���g2�{e���=�ǒ���� �������"bV�-�)�iБ����g�5��q���|4��3�y�Y������ه�p����ؓ�N��V�r�x�ŒY�˛j�,w#���n��?�~;�q�Tyr�ۇX�HY��"o�Ov��,���ЊX'��ੑj��wR��f�f\��
���JI����,4����əx䜙L2g�CGh|#���~�y��j8_� �i�zq�
Q��s��f���	u��A�K�)vd}�=��pٺ�����p�'H���O��l������Ư��������~�Q~a�=�<�h���К��r{����|{�2��{i(�{,ݞ��x�O��o�`?kb�u��:��)B�fj;ꘁ��������v����dK��r����L Z��[�x^�mtE�D`��'�nu�x&�:7���u��KX_tF� ��fL�K������������,��<b��P��B�� M���CC��qI�]�]�����Gx�k��X�Ofs�yڪ����4PI�A�e��Q!颋��p�ռ��au?cbw���NRE>�5�ׅ���K���������D��<�:z�|+���8#'Ζ/5p�*G_�8�o��<O�8�R|ht\�y�MSl
5�X?�b8�|%��b�l�n5/�+�Hc
�iVU��[xi��=ƈcp�L��P����= �|����L�~u��z,
g�1�^W������<a!��7˕��ax���F����=戼^q�u�!����6�ҫ�#������w,��*��jaC~n� ��������m��� ��돴@�)��8 ���$��j���%�8��G]v��P�;��Դ�8�2��R7�Ӥ~>E����3W7#��v��P��S�8"���o^�Yq_/X[���u�⃭�"ԥ��s������i!��?́�}]��{0h�}��1�4��%)�
�v^�j����M_/���p�>3���~�3����W�bU/7���2G�~�/9W���t��7B�.�r ���=\����}Z�?�ڞǦ�FI��u_	1��\S�2��(�Ϯ���H�q~@��1�檌���j��9.WT�^�sPP��}���q�s��KcB���w� X�yZ��)�=.�6�h�R}r���Dy_r;�������ǩ_��ڸg|.5'��sV�U�ٞ	߱z�i|�Mh|)[^|Pv�"��;P_xA�+�r?�����t���	�ʔ �&)���c�yjR��$���,����i<��AN�u��3�L*��l�����8?�ˡO���-�d6����D�ҶW3�A���oeٿ1�3PF��vh>��Lp*���<)[Oռ�yEe��?Qt!�-m����A��f,�G����?���$a n��-8��S������>s�T�_�䴏�Ɩ�����o��"�{�0�t�#���ЅOLh�K��v%�8-� u����b��,�z�jn"��:���i4"{�l�.��6#8���psն��W��r�������9|� \��b�g�LT��G�;/b� ɍ!�MG�6����X󆸘|޾{??����>�N�C�l�A��G��g�d���}�"����^��j��3���gh����c���c[J�_��<�����S�\�_�������s�2�v�����!���)��TΨ��s�)#�W���	�&-Y���;yemݶ�@���)�����Q5���?��*�V��=���� A��t�����{d�#�%�4�<�.N���p�_��^�U�k]�����RU�ewP˹�s~{~�6�pk��ad��!v��ݙ��2<M��    �\e���Y��zf������z�uB2K�cp���5�ף��.���0��k���ff\���W.���4R�Z�o�پ{T�?M��_�_s��k�xp�do�w'n�� �-=�y,�;�_�a,������YC�+����������r:୓x�N������2���d�2tNI7�s�-4e�c�aK�oF;6tNI�;�����K/�6���
@/͏��v��56�،���.iRѠnv�䥀�P�G�(z~����q��"˧K��Μ��
��5��`�#�O�l2G�'��MAx�i�������p� ����]1`>�7�;_V C0�+�z2{ȩ��>Й�Î�0i����N3��6�i��VS�%�G�ٷgp�)S�Xyq�o��g��<�l9�wv�ݫrb"!���_o5��-��� ey�qʫ��8��t��#�IF���^�O��X3a3߸��
wR;_no�E�}���Z�/��� �[f�~�v�)����ֿ�[��~�c�5P�u��=��������1�YP�+�yĭQ����³���SV�T8qp�i"�P��j������ޝ����.�!4M�B�� �bC2�	`����ߴ�kt_�w��pN�ў�ԋ�%8���a�o�0h���U��y���a�c�!iσ��*!+ �Ǘ���=�掗��ىs�-[�=HK�c�}�� uR�#8�k���U�*�G����7�# �D�x��C�ބư����2'���6��W̳r䪓��߯t�|]Z�w���Lg�BG�$L��4D���Ѭ&���b����g������%I[=��qI�����/��P���%Z����3Y	(-���H��L��v/��腊�"0~���I��qw�gËI���p��<��ѻ>�H�}J�v���gn�p�	���[+ߌw�u/�?��tR�����p�?I��&��i�$M1:�b����!Ԇ����ɑ�i/��>b����@�ޟ[4C�?��i�b��#.R�[���4v9���4�Գ/l?�5־�����o)kPo½|4�oæ�H�F�W�)AE�߬�A4����b�D�u���mX��i^oC���+[��U���y����3�ٕ�ǒo�D��$Զx�w^��_bC�ɩ����3q����[t�G�����m�T9UQ���+6��V�<���g
�׵F�I����,��Q��qCSE��������{%� �������7Sn�cKs�A"���L��� �v|�|K�=�����@�� 6Zw�{�<@�X\�ˋ��+��+!��� ��Y���t�_��:�U|���� ��}���\V!����Kf�F�Y��}(x��3���׼���gۮ� ��)�= Օ5�3עf��?f��k������"��rϣ@i�E	��ŵZ�Ӱ�O������͏�ʁ��s��4�+��&SO�J�����o�o��r:a\t;�p_�۝��0H�˖Ȩ��'W��'��K�ڱ�Ք7���!��{zǹ	�������?FJ�y��3�v5�X�g���=@ó���x9�[���A���Me��RD]��-O�[q�I%%�O��,k�~_��H��L�)/h#��raE�\��L��'4��W��ZHa��g���£����ds.WC׿���
a`KB��TQ���=����57ȭ�;=4:�[�[��)4~���6�Cy4�;a���e�g�-Z,	J�	��ph��λ���#z��.�ID�~!8�A�Ts���m���;x��;�$ 0I)ZY��O�Ay��&����=|P�U�Sb�X��\�4���G�l���Tx�z��+=��|�,��я�l
���������Y��t�a�=�j�"�=vN���ñ��Y��:$7�q��/~e�{an�+�lt���"�+c{p{I _�4"c��� T�+?�j�<g���]�W��	��������S�%�gM὞nY����\8wd@8	r��o�a�����$n����=�Tp�>�ZۦA�M�\��ׯQ��M��qoB�>~С��h����r���+G�Y8���%�P/(�˵�\�N�Ɲbk4}qu9�v��%8lOr?�0(r3��
��c������E��uK6�[�߮�[3D����R��"������~%�2��#��&MN+Qm�4pb��v Yp클��=��0�X�-�P��{[uk83���},��G�?��,��C"�?���?�~��؉��%���FF���zU���:��|��e��H����i�8�t�������n��Q�s�\2��s�]r^��Wkx��~y�b�D�,��r7'[̓'��j��w�o�11�{۫�=p�0R��_�`����:R��ΞH�ϐ����5UD�=��"H�aOQ�7�?_���}M2ͫ�����W�aģ$U#Ƹ�.�7��ˬ���\7<��&��:1�%������ D8xf&������C;�w=ojw K�3O_O/_���V�$�1֦Q�l���SD��@�"Y���,q���}�-4+�C�s�*��X���jڤnX�c����������Ȼ���A��VHu������kl�`�?�U�}\���*��_P�B��q����Z��E��y1���]�i�.>�����?(Ӊ+�Y؂��A��h�6�K�4�g�4gm4� �(���	{��҅�M������&��A�i�k�R*h�V���*�w� ���[���u���j�d��� E����w�p;Pe]3]��/o�jc�t�U��I��)��w5����Q��Vӈ������G�=�,�8�b>p�C@�����.AE���V_�5j?�^%�����c2�?�2��C�Aˠ̃�/:��rk���ES`@�Y���W���D>��7E7���g�o/6I�]��F>�rkz��Ӓ��:�ج�!�#	��Ӹ+y�3g��u ����7�B/��x|���_��$��ițh�e�|#Q�=��j�������n��g�fΨ�p��uaޯ%4qr�;�C�螽�I@��@n�I/�5���q����Q�;�8�4��8���'0X%1��'�f8�P�0�*:�Vn�5���R>�Ekn�z����eK��9^��=yݦ�[GP�*?�@��T�?���]���|+5gn��c�+hoY��5�_�%�'�`�d����/���`�^��I&�BD��Tv��ӭ*��PM���G\���YҌ��� 8�}���!���"PMyf���хV<�x�[:�� �rQT��3���P�^AI^ڏ��$Pɮ?=M�%�`�D����Gn�߉���=�@���f����,6R��	@�=T��? �,�����b{I������p'?�5�ۇ��ޠ�zA��g��zdh�w3_�?s��C�-���yz��<�� ���ZnR~��/m�wc&��i��!Ņ�9������� (٩���3�s9W^v���dw7��l4+4D��L���9�ĝ3�/��a9�Jv��f Ln.?����WUp��1[����W�a��v�ؖܟE��͗� Ѷ��ơ�<MZs���Rù��n�����{҃�9���Σpo�0��1\��:O�G[�U�8���wy�:�����j�>������A��<�lQ�f�/�_���l)�2�������\�H�ys:�u�#�)g����}A��B���/�q6��[Ő���<Dw�ǉ&՛�Uh���1�l�~� `��������t�Tމ7J_/ߪ騏�>?�:�:�A�L�a����y�NP��9O����ՒZ[�介d5ߋɍ���'pGX���ޑ�t�B�I+��!QGQ1�����yW��~��~H��t�+&)Jd� q;�U;	S�Jo�Eߜ��@���(v���%Y��V��S���UBt9��E;����
qjC�:�Q�{�An����~�Q<��	�wa-ô�a�f����mNR�:�I�e��[V����rp �+{����z~���q�ӆWi�Z��T����!b�ڽx���+L�Ғ�~,    �a���hC\�FÓ��թ$Jb�_��W��.�L���)�?�t���=��/�p���l��^� �H�IP��9���M1v!�*B��(�U:�6�ǟ��s|�Cϩ�.�3q��������ڋ�?��J�;3.��܋���	�ؑ�dé��}WW��a�ש�єԓ<�s�=�a�%���%��LbAV���I�o�70��<㕿�c�k�4�?����*���N2��;�v�@=Pd��m+����<���<�}+�&)s�e�|�����z��L��@�m�o�r�m,3vu֋.��o����B���%�?�R�C��U"��yO�o�6��_f��/��F�z>�z�J_��[c�޼�$Dh?��:����cfUtq�T�好6���CL*K>�3@YV��1z\2y��|0~�j��wA�Ԅ�!��.�����ٰ7W���=�Wp�ރ�(�}R����4�q� �^���M ���B��^Y��w�]K=���Nb8_�7_'�t9���C�H�=�����i��6��9����x�U����֗�D3��T�~���%�7b�"�K��w����~������;�v�.��I����g%4ܨ��I桝�]Q���m����T���n�ʄ���h�
�'(��:��kaO)�3��:�eV?�۷z{3�:��j �(�'���
���/�3\I����l���g��=�b����%on^§�BfDRg$��1����D*>R
�H����ҘO�;�3��L�^eQ�6.Ƿ���jx,��o��m]+q���?�p��C��W���N�(ZU��raX��5�.��s����?��V���I���b���0���ϕ��3�t���%[�������|s�Kpe����z���c.*��e�3�N�)�W$(x��Y����6��^&U�'�h��Dˀ�:R���E�=vY�������ܮ�T�ޑ~���=ub�?��|#��QJB�a�֦b����f�{.4����)�??�����Jw��6Nx�	5fG�"�)T[EL����տu�Ēٓ-�!��_��(�>X���P�㼡��d߯�8��l�D��*�[��Z�@���"|G��܏+���� p+L����Q���	'��Z4�� (�ч^݌;Ⱥ���3��kog�iQi�w����)!��B
TZ��,�o�h����Ө
U��DgM{�4�����%���{蝢Vۈ���F��zHmd� L�%�y.h���Bk�P�8!P6
���ewr�}O5�N�D|���oh�h��*J��3���]�����R)�®tqaj���8���n�����@Q�E��I��rp8��b4)̂B��q�]nd�ё�5/���>F��m��4)#@�䓎�)p>����p�?+���^6�/�?���Յ�9,��`V����K3D�G�+_�<�Hj稼�
�n\R��B��y�BT��b��-��A�|�?1e������i�\���hC�#/Z�rp4�,����?�4^g,�W��;�t��$����������S�����∴�!��܅U�w%};����N�L|�=�n�դ[�~C�\t��Te����r��9�!�ԃ��d��p{�g�JL<P'�L��jg�o�aC=��R	�xH0%�0l���X~%
� �Ʃվ6?7��3/l�<���ڧ��z�7�v���H�=��?~��A�����{u���H�ݤ�wu��ub1|M�l�U��NźE9G�ZH+(��Pc�q��Ժ��ˉ �������.$M ��Ǥ3K���pW佬εa��XC�6��T���5���.B�q�VN��]1a��W�e�J,]W5����M]���LK;�\�'��H3�JвI�pg��m{�͈B319�+�}�BO�k��2�9Ai�y�aد�X=j�.%k)(�H���z2Q�m��~���[O&�O��1xE�Omz(��gpM7K�G3S]F�m��̡0��X6|2Yu�3�RM�w����DX���ͳH�!u����ŋ2��6>�%�V_�%�%}�����J�Џ)��n��%�ayt����u��{����;�cL�%h�a�f�����¯ߨ���vP�=����g�N9Z��� b��'����n
�
|�՝(=�
�����/���W�O��oB��Q�lRNP�p����{�%��P�8Q ��{h���KЍ-G��N���~��xe�_������4��i6��8�Ic�$T�8�&,�'�W�F�<��K����bG������a}�c�(9M��Q��13zU;c΃�ߺ���ȗ8G�T�+��N�-�3����Sd���3�Y��?0�Y�.�Cwxgt����%﹂w=�o���Y�n~��������ʖ�Y$nN���_��%���W�;�+@�b`o"[��&v�EX�)nI�#0���ܛ��8(̈�ܛǂ �w(Y�n�p�Ǣo�a�����V5������v<����/�'(~�;�ra+3��C��|�����2���	�a���/�E�Au����@�(����IS.��'�P����1|�!�(cs�RYOA�#�
RO <
����F��-�>OY6���/�_W��6�쀇�ۢڮ�+�|��ت�z9��R�M���5�N��[�A�o��O����y�nj�п��a�hى:�A
87�J|~�Rc�4�k#{~?���]���#��ēͷ{xi�Y>	0 N�f�ލ�u����,Q�`#HS�'(��t�`�����q.7�.��"5Sf|�(1�  �j��	F�j�Z�9Ϡ���Ȼ�!��/P�x�.	���gL��z|K]g����硉_�+��r�	�sގ��SF�f�^�RB��#���I-�\R�K�ؐ��e𽯄҆��@�da��ϮڛSy��]x�m��7ϯ�q%�qPAQf��mx� \x��x	�rC�������oB-W�xL�$�_\��i�6��s �����P�Kҏ��e��cJ���M�W���8���W;�*�d 9%����U������SRX!���$��^��5i��� �A�TѠA{�@n�.�6�k�2��������V!�Ouh��t��[ ���z>�Q��ˮgd\!���ǝRO�QN������5{�؏��A8eǗ:7oꩩ�jc;An��y�8:ٕ_Gޒ�Y��r��Mq7�`*5i]K�`2�hV��}�	���p��~�#_��e�'�=����6����H��{%��3>��FZ�N�^��ۿ�J:M([7P`\���}k`?��)�Đ}k�ܖ�X�a�iM��:Ɗ�Ո���r��~ӛ��;	צ&��tv�������/�ظ��*��}d(��ٖǽ�|�/ ܮ.'Ui{$�H�0���"WG�gn�t� �/G��g��!����{�^|��	�A[��Ȁ��WL��!��'�9_sc {Y�6צ�����|Z�6ܘ�����.}6�D������Y��p�o�u�O�xZ�-wt�ݤ�II)|}��2t�}T���Kx	��\x!� <��ѿ�3�ώ��K�����]]�qU�ɳ�nʒ����%��[���߽N'��������r,��8��\�����Pܘ	��Ǧ�
F2\��ZE��*p�wg�ѷѻ���`�/r��iEq�j���އ��T������pkFi!���M>��}��'�/O<S�o��Hyw�;���q�Ml�V㚇} ����ڇ�b��s|���X�D����/�_+��Ӟ�W`�8��n�и�����K%f�b��������k畅�װW?�����r×�d�L�Iu�^7���QY�5�;a��*#��:��@�ҧ ^�H%�����=��u��t���F��n\T�ۧ��D��j���ߤm��؈>��0�C�{/B�V'�?Ց�1�1�M���xU��)��?�\z{��o^�xJ ��(O}�
���������#���ʸ�ݫM������m�pC�����2�eK�b5gzN�8��VD����`ԑ(����8:�^�Z�g�qgW��?�c v>��� ��R��1�_    Q��}-9K��B�˧<xB(KS�'~Y)xO/Ԙ�F��X���a��]���]7����J����ٞ�Ԩ���
y��E�41�r>����o(��R��lɛ:n[U`u\�����!���a��Q4T��ڭ�����3єN@4TP��E�� ֿ ���He��"�B�Ͻ{?�rw�qJ�ϴ7v˴�?Z��{ ��C�%52>GU�r�����>��X�>o�HfS�B�ǐ$���;k� ��rG�x.�֛����NmŠ�%�#�V���r�$�? ����DW���k��~uM�5Ф�޴�|�H ��Z>X����T(L.�j��]u�0ɂ�KNKu�Z[u��>��Ѱ�)�
��ER]�=	sz�O�o�Sn�̽RpE�)�|��'��8��(�`��q?Co��@�Ŗl#ĭ?�� }��{�p��q�	j8�Qؘ����#���X �|ꨖ� �)��71��!�G�y�ϗ&�iUm���V������sQ\Y�Q�	���)�_}�kϔ��� 4C(T�HEy�A���u��٬��5��Y�����qL
�S7)��b�Ҍu<�����	S����HR��(I䝼)��_�Ѭ&�Y%��� {��L��Ò���Om�F�[3a����(c�x�l��G6�f���Fo��{7 7�[\Y�"چ271}��ߖE��L����2M�s���~X�.��5�{_��{ʬ�1��x���Q��l���&�����{x��s�/����h7��g�O8Wu���cc�=V�%Wy�e�;J��gT����S����!��xmV�~'1_�?�8��ۡ���@����]_L��U�"��Y���q��Sk](f"oy������V�����᫥QS@��pq�;��o5ַ�-��oT�l��l&�,����۩R�.>�-�F��9ҵ�A��#�����?�)4GT��/�E)H�t�xY"뉯s�J�sn�}�h�u�	�)
wIk����c�}jY�W5���١ߠlo��ёV�����܌��(ڭ^�|��U>�g�1T��&4�i���/�J��=��^?�Te7�����;��TI�Z/��-(��xH��������R��3%q$����1 ���<������Z�����9G]�e�+���iw��O-�Y��^屫��Lk��2��~-A��ˇ��q���5{n��Q���$������Z�=���|}���.����[�[]���d�B�Ԃ͛�6�� K�=�ny�Mr[_�&�HO������q~�������nRF(�����©�ѳ	�)6ӡ�4+��#�{��z�v��a�����p�h����O�w�$���%��e�.���w��H�Geot��ڧ�;"%��$s\c��>S	n(V������={����e0�Ouk=l��3KA�ǥGA�u�H�fH�����^��\�r�DR�������%V�zV\�j�Q�DJ��r㛫6�8T��#����!}��Ђ�>�����>��{���c�1��G���f���Z��;q�<է|%��ˣ�S���CRP�.�	�
ܤ����=�=����d�y���z��"=[�ˣ��Ly5�<'�֘�uU��N��j�~y1��]������w2)���;�\�o���,�`����wp������8M�|A�5�u��7U=-	�3P�L�����	�Z7���-���bc�kJA�
ˊq�A낺�����|��&ϫ��xi�b;O���� �=Za�u�Q�����'<wM3��UCc���<���醥�kL'��j�0T��JE>Mq}��,鍱�@�	���O�|Y$vJ�H��F���z.��+�s�X'6�·����t�|�p1��Fٳ�`�G%��W��G�W�L��0�W)�(�J �Xz�J�7�8Kk>b�*&��R�G�3��7{2�����(�dPϙ>���'��`O��������I�J����C���\��[8����_8kώ[����A�U
�Y���<�������g�:�=��S���WΡ�}�s�Wb�����~�i6�����۵�ӈ��j~�1��Z"���o�++^�5�/���d��9}Ԧ ���USx:�f�zZ�^�ϭ(�U�~�9_]|�+;��l/�}��FP���i�d��BMz���t���voP��:���x�Cl��j�D� 6{?rs��]�1#��~MҼ����CՋgA+���s��� ��@��$�֬<Ö��,Z���gN<��l%nC�]A�ި|D嶉�a��{{��n/l�$PN�oܸ�ў����	+�at�o0�Gn�5���� �leKak#�{s�'^�g����~��Qb|�o�<�$� `rP/+�1
�r�_�G�{P���jzZMs ���7�ˬN2c=����3r�q�&�_��:Rz��Q�q��J��1q����W�e���)	�ː\h���
}8k�w3z�o����Iri�\�r�1�Ԓ�gp_����d�׶�=�O����o��MٙӔ�I��'(��q	�獐	;����",͞�潶��|���cP���r�n�aD�s	�e��ߙ�l��e����?�yu{
o��_�5k��!�:_�y胱�]��(��otWVY����M�YΚd�s����@�e�B$��yo������С���B�`Z��0���O�B�l�`=�t�� ƶ�+���V#f$�-��oN��X��Kt�Y���E�2�xP�+�_�j�)�p�"r����R u	6��42��l�!��W�����c�|��L�+䏽��$�&�t�|�a��)y�j������|#^����x���ܙ�/X{��'3�5�M֮�#���	˯�<b��1�ꡄ �1���r7�����"��\�sij.��)��n���-��m���K5�f�s� �UR�!����u�hf9��xY�S^�]"�e\2|�Ht�W[��PM�I�΁�_���7�X�?���;ȡ���D��y?őV~���>��N�-�s[��:�ϗ�������X5Gk����&�}��+�7OhZ�k�����{-��lYbϥ��;���G���p��_��9�^U����׊e� d�cd�9��p������Mo�4�2�v�ӯ�D�_Z��w`�F�@*��i�~�+�6uM�o�o�>MMȏW���<a�����$h3悛�loښ1���I�b߲Y���m_�6����"��W9�=?]:���s���x<-w���}��#?��G@��y��T ��R!hUh#XM���b����!Z���u塉�h�����^$J�=WI��<�ml���S���5e��c�a=E!�mJ��t�3��������2O~E�v#ő%�ט��"S05e�|�@̸���C
E����-��מ{�)�E��97�t�Q��=��:#�l�*A������ί�K�9���2��W'vq}���{͇# �w�n�w��G_F�P�ϓ��&�x���~j�֒��$f����3)���������K����ɜt���ji���η��	"��2Aۈm�.��8�> �h��8�e�} C��,�����#�${T�q�7�+8�P�,�8�^��qO�^y7�4�:�!�q���	���͊�\m 5�1�gɸ������/��P�� ���v����*#����XǂGj噕',JLroU�	���uY�Iր�;���{�zܬ�<?3M��-�+fp7�}g~��?����:����n���"vA�n��O��y/	����3��Ǿ���ȫ�i԰�"�������?z���ɟ��;
SŬ�,���M���r�q���X+`�����o8����`�C���0�v�?�l�Hy׭��-����~�E��Y��oi4G�g��>ܷ��+���"����tkC�ǧ����v�����'���>���.��܂�m�1NDB����tQ�v�����t�/*�P�	x �5�g@n)��ppaɁm��<�����/�D�y����
.��}W�K�    Y����M�z높����>f��?<���jɾh^B��������F�q�X�<���u��f	@=R?'Z�-�����d=��<�\B���/��+�x\ ^��xߧ��G<��m�dN���Gӷ�yDOI�_�fX���<c�(��| {W�kޯ����A�ދ'��a�XٚV	AO�q�-oQi]�Bd�X.��ʫ�#��o� +�N0Z"��c����G�{ڞT�Vb�l ��8sq�b������߆	2�!��d<!�;$����uWp�v9��Ev�ǭ��������@�FB�$|�u�R���߸x&� ��&��c6���m�8�06'��:�-�&��y:�$=���U�����@��h/���/�L�:�B��vHJV��|M�$�8vxy�&�<�(��i]������D��vg��cǙ;G��q	�Z�RT8['z�`nh�>�� �b!bp�~���8���r	��5n�Bǖ����C	 7�Mcr:�!�(15E�'�t]"19x` ��A���t��K�w�ߓ$u̟�*'�ڜ9Q�q� �T���"�q)���pYٖ+�b��E���A�-�'0�EOfw�kQD�?��$�j��f*���ז-�n%j�b�Uswd��ȟI�Ԃ����%���E�W�{�j�6E��sPS=mm<?�ֳ������uR���]B߃�|�� ��"�া���p��|���Kދu�3]�#xհ_11_��v���-�Zۜ��z�T��`6�Z�{>BY�@�������?��_R�m#�>2_�����̿�AoFb�́���(�V̺��"��M�E4{�wi�?in2�s3���`�g�0Pdvk�8� ��v�p��Y����Cɬv��6���P?CV�f&6����\E0��%���m�K��6=��r���*�����R�u�����as�mk�DQP>�f��eˢ��� �-���B�J� �]:3{����y�/�Bu3�LuKfIB��~UԂ��:�(����b�G�E7&���Y�)|���j ��u BT�>yQ�� K���;���>���z�Z�⽋��M�c�W��[�p1�:�\_���o�m+���*�r@�Rd��"�H�0p�E]����2����q�$Y*>i��_U̎`���G�r�}�H��|b ��Qs���|�<Mwl���=&:�_4Ԋ<k|�i�~c���{�{�şM�������L�~���	e�m��Қ�� �OE\M
��]g#�͍D_<��0%k����Z9�s
=���(�EK����N6�;i�|U�GS�1~����t�k"��=��~*Z�晥(u�%7��U3(��-?�uPt!zzJ��t}e{��J��޶��������5�8�',���H�^M3~�p�؂%?����O��#D�f������ d��������nO��>Iớ�ё!�M��a�8��F���ֳ��e���#�Ww�tT�+�q�� �w�ڱ�B�:��f�?v��8����5S*�F��M��X :�(b��H�`�4�]��,D�l ���o��4�,˔s�����i�{fP�go��c�Џ�Z��Vi����o�����-7����p�J���k~�e���h�a�Չ$�뫱��<�YC���X �3r��ܟ�QP,Ϙ,�c����T�v�w�y�S^�NR�O.��y�֩�Y����/��C��A����D཰��0��s��_�&�ABu1�-=>���#^�7��m���1��X��Ŗ��5{��1���vo�C����WxCI� B��*LU�����'�S߯���r/�E�%�
W�) (^�ϋ,���9�i��PT���>��ZݚD�W~���kSq������]��]�%&��茓@//u����U��ֽ��ڙo:K�O�c�2�B��(�a��mt��$}��w��۲�}�L�����fLC�I�3C�8�C���8��fH�S1��H"��Vg(�!�%|8�p�c����\������A�j��G�A%"�8��`��0(��dk���{ �Q��O�	�#_>43!.�sX>L�<:��k��J�m��V�P�f��ҋg�zun�z��0����2��|HB����������?vaY	7k������WgЈ�.]�vc � ��kgCN����VK�7,n���V�~WfS� �(�}f�M����i�k����]����]K����CA �����}O2���t	v��p�o�E�oe!E���`���3�+���c�z�	M����
!7��^��x�L@³}� t����i�OtF�:Ɇ��ɗTA҅�S�i�ҋ�`����;��������$�R��mN�=w�"U��w+߃�ꃎ�p2eY%��p@�$o`~����âG�U��/�� ��/:e�DćVJ!X�������;�cZ4ӳREV����:n�|N��p��>0f*�wV��tm7��h}�����B���GP�|S��x;M��mQ��@v:8�����whj�f�����E�cn��J�A[��CV�GܷZ7�<k�F��{������,mW1z�!�!�5��Hϖ�h~G�/�����p$�YoT*͞����O'	^�����:]k�(2Ӧ�I�o}	+�,�^�pIö~�wՖ��AubVV��Ob�a'�l��;��[�2Aw=��]��<ǯT ;����K�3{��!�ǫ�Kap�5x~6��6�#�T	�8�:���M��8D�9)[��3e�7���L�_� ���Z��Fs����&���iO�Y�8~�C�-K�i���u�^�?g6�Ӈ�̀���N��N?�C=��rܕC�B��;b�CfvEo��l����N�{hk�G��i��UzԘAգ�=

uӮG\�jm!�0���"�炀����b\����A���Q���CV�h�e̝��[w�Q� Z� �7��w �RC3Wcu���;X]�7/�� �m��h*��eO�i�,I)|��DI�
��t�
V�b=ݕ�V.iNS(����p�$O%��W��-�J��T�-
C��w�`fV�̓�l+�b�c|��Fc=U�|��M7�9~>ʤ",�TJ�5Cفɔ,�0��ķS��S��J�B�v::�.Sں/�����&+��P'^�����BW��7�n����hO%�<8^���73�vq�$�e��3���]��/���S<^Q�BA4;�,m�|�>Fc^
>>�z#&��;�84�_D���݉��D/7)5�
�~-`���ԞE�hS���O��p:� Q)�۷�}H9 ��J�X4�A�Ч���X��`y7���L;�d���D���L�� �h��i��E���V(�tj�V�bm-w.�V��l�l�1��]�r�����E6c�����뇰ݗt����=��:��A���Ջ#��`txے��!��]���8O�4�WΩ �
xbܱ���
�쫉q��6/Ŋ8T�K����G0���Z��_m�@𘣎�����J����%�Fw6yy��Vf�х� �|�r��!{~�H!��o7��J�f�����cG��(��.|+|��=Mlh�n�X���P�L/T��UVM5Qw"�e��9'�~��0�@Y�]�(��؁y��؋�LH��V��dѾj�����}4~6ҰL��C.��nL�a6���X��A���U|��g��șyZB��M�V5(���;q��WD�0�6�'�M�zL���Oi|�N2��G�c���A=��m@����'��v�_<0 .t�3E��&@��u��ai,�^�}���zZ'9}z�6�eOo�]P���;�O�*����&�l�#�<�x���"~��X�Y*�:���
�
Y�}�=<g�Y=�o*w�g��)2��5�L� i-�SY��
K읡�q8C ��t�!r��,mb���_���^��*DcזPN�O#$6"A����	2�Ѣ�T�Bp>5��ɋ�`��:]MTԴ�T��B&�x�����Sj9�U�/�6��h�
a}�@����[%���3!�}o��4C�>     �3�)��Z��v�<���;�����|&�4'�';}��`H҅����44����1����h���)�2�^ȃX`�PR���n�}�h�(�+��!��}���N'xMOu�++�{�拌��W���0n�I$:8S��19��*����+݆r�3r�����E@���3�\�"�٪-Z�-����]Md/~�ݜ��Q�Oπ^Z0��A2�`a{�yog������E�,^�L�Md�vC�[���u�Sz顺��kgr�|�¦xk?�O���:��F�c���3�S�G�!ʾ�n#mo��-Qk��y��l�ZF����ϭ+e�ެz��c3Ã���d�t��</T��i.�Z����_c�5DF���{��"؅���~T2�6���ݶ�d�3&��Y�Hϐ锷m6*7��[����t~��b�Z<�DT==����Ȥ�V���(��w�0����PH�i�s�{KL��/u2��0f��=2j�%�DP�r�:�ɡ���L�%'�M�����cȮO)�s��YN3�9c��� �ʮ�W_@�ɌD����'�7����w�3`�df�8B�0Ŝ
B{��� <�f�Pd��@$ڟI�3$��L���D�䬘��B�|O��J8<�os<z�1afUި�qo_��e�+��%Cp<{Q��(�����ܱ9B�f��Nt<�1in��`�K���S��i�HZ��	��e����>�4�b��ޏ�J,<7��2T�����̗���?� B����Q������i<Æ:� �/Қ�3�~A_{���(e[]��P��zɑ�?����:�_�3��'������gR>L+�7O,�H�� ����s��e��D�N�(c����?�g�zr�6ʽ���k��.�5��q)��<�зBZQ
��±(5�X(ܸўJy�;�,��gn��s��Y�Z�K֠7�ޭk���x���7�����'�j���(}"��^�?�Q�UV��nV�=��N!�����7��{՘f��1�%i�g8�nk����%��m+%��I%�Ү*�r��aܒ����F�|H{��h�&jf�B�zW0/`���(�==��WbI2�R�a�O-j"\� ~%C�������"ߔ�$?���(�^�e� {�%��+��^�;$�E����y=�����ۿ��Ƶk�|�=ƭ�e�;���/f��x�=�䙹K�9Y.�c� x��Yl��m�@e9@�'.;���dٺ���K;�M(?�"����O�\�ĪM4�����`j�0�;�; ����^�p�Rjp������ c��}���>��,Ǚd������:0�d�N�4 z��%�׍��W��=�zU�O*��z�Q@���JDo2�1�d"��D����!�� ���黛=EԼZQM4�~���w����ڤ�O
t��B��r�UI�7)g���8�B%,h�� �E�ߡ�����ɞ��4^�w�8>�Q����;%�fY�/�K�#Yo��pm�j���$�Rn��X�s��+6}������R�}��6�·�.c%~�|"ѥ��?e ��Pك7/q�?f�V�{�u�ì�sy�?�Ԩ���!z�@�P1,]d|�f�����k��B}l-�V���ϩwj��Ϝ<�`�(k�]WA��%`a�&n�����܄D<��CL��VҦV��G����_o]=�|�եI�@����~+t�ִb�.�|~��Y���P%�I����/`u�6�)�V�)dۡf���b�9K����n�UZ%�dSn��Aq��)�/S�p�)��B���+���+�Q�[��T���F���c2G��d�bq�(<�+�0�I������)� D� �!�a��g˛��~ ��7��6��1H.q2im�x5�_���e>��g������s���{�ץ��;?��R�Р|�G�2�h���&��n���y�gL)b�i����
=������or܇��{~47gO
�P �r56�!ò(nu��[��Zz� c2�1�}�9w�h�͈�R:�!,3��M�F�rU�j� �����&`�Lz�R���yt>X�j:�B�U�x8��N�z�������\h�Y&U7��*�!�|~��Lҏ���.�&��p���Z7�j_�sP�8�����)���t/̳'؈���Z��y��6�'��L�Z6�̛�V����U�Ɣ�oR��-�,x���ē+���|�(�'�����)�o��iw�,��,��#H6��F�.�y�5����6[�\>/Q�y�o\D_�x�V��3S.�N����Q��M�o����h]��|s��v!��Ͽ��"�m�߿��|�m�:��+��(���%�C��$J�P�ԓ�U1��'����o�L�׶"�{��O��f��$Q6��=�4hz�"�&7����_f���|�e��lM*��h;�W�^�p!��aG)�U?sk�S,V�2���	%�\���e�P�K�%����7^��~�,_؏.cm/\�E[h
2+MR	�������E$�����m�L\.a,�#R�����^�͎����9�QS��)�oW<
������)����wT�u,y�U��h^���T�þ���P�0�Bj�k�+�%7�_f�Kjro�SY�K��F��pѼ�~Y�G�����:@L����\*�ˀ8�쓲�UP��86jS\  ��r�(;��ݟ��$�`���%��8N-b���F�\3��K ���$�46�"���Q)b��\�m���b{[5�k%Ƈ1�,�wO�+����_����wG�6ch�S��ۤ�$ٯ��� �b����w�W�c�:~VW�]s�28J� �t/w�������R����0쪉`b�W�]]��n��7��G���K����x!�{>�^�|߿&s�~?������B�|��XK�5,.+pMGN�?�D7#hRK��k��Wy��*|7����3��_���H�O,��sz7Vh�!=?��~�w�:C��n�\�Bj�� ����O�G���ɿ��G����q(p��}
��1ō���I�Hv��:ԅ�_��D~)_�W�@�<.Lǡ\�Cz�M��3������Rޟ΃:�Ĵ�%鲌ֆ�9�B~�q��50����0i%���``�Hh�ʖ�}�WKK��G�[�W�Nk0���ͻЧ��f���j'<� P�^����'f*���z�]bvy/]�C�eH�_��B����q�N �?0�i��y��1��k���rN�c��r ŏ�>�
�6q��6�f�w��
���~S���G�� ��d�DNY�%q�x]�A�o ��FZ����
Y�3��A��A9?�p�P.�y`͜�ŗ��S���nz���L^��>*#ǯ���ߧ�2���jKm[B���%C¬����!�03���{��h������n[,��V ����?���7�3�2�U.C��
>��{R԰���矆i��4�6k�^�	��~By�:g��X�,���VoxcL)��m���#}޹%�͛��}�)�M$�/c����vʯL�YV�";����,m��L��8�|�V+�HG��͏���`k��/Q�~��*���o��<���8���c'��� dh�	�Ki
�L�}�D}0L������� �@#2,C�M|�ڭ>H��	y\�$��E����-	!cs�R�󝵈�'&vo�o��S�?�ߗ?�.�z��z�[��\=0��������wY���s��<��j��(|��H�<bq���q `%�=��fˡ^���e
l����t��V�#�;�=(�Bm0���6�MQ�[EΓ�����4�ʪ�ϲ���sU_a�V<���K;[ِ��ٯ1X�����Y\��C �$��˰�X�*]��ӏ-F���)���~r,�Ƞ3��9о���Bb�dB,FU���l�*�d�yU�q��b�j^A��G9N��`��=dV���<͆�Et��װo5	�8���[�1�-�L.���e�f�_X�7    ;d�
!�N`!�q5�s��;K�#��]E��� N"֞҈n��A��pY�KU�~��z_���[ҥJ��%TC�V(��MW����:/�����R�~�?�l�+�g�"�L@BM'�HRb�b���U��,�}��o���~��Uu$?��qǀ�n��-B�i��)�E��>Z17���j��.�A)���yk��][��P����O��#��
:^mݭo�L��ol��>�Z6���Ⱥ�i�|��f�w�3L3p�q��wlC�W�ܒa���@\��y���am·g�@ҽ�xȘ�`7T#+�_6��Ӣ��/��v��ӟ������p�\������,iߞyڻS�uzt�0�Пj�eZzӺ���ވ=�i���c���|-�{v���JW'M*ˮ@���hȵ�З�˗��j⑁�YC�b��*Z�b$�0C0�k�z�5� �(�xJ�� �3.���s�L(\��W��b�Q� �������	k��ar�4��4���[ܶU�[��po3yK��X9�'0L��J\��R�⦞�?�;C��*_ű�T��7��������2-"E	�~�,��ׂ�U�>�&��Ȩ�<�~>�������5�G�;"�<��	؜��v�4x�)�,�|��)�&�o'����-�i�}f�B% �[H7ª�Ep��,�ν�h��o���D��rDI7��%������i [�ڰ~�x��)JxG�Oq�Ľ/�B^cr��! fIB���$��G����V	�ˈ�6�%�(oQ����x���i�M��Ii���-��~��ct�*��zO���_E��LP#Px[������{�S�v��N��p{�Rw�"���W��^����v}!,)�m>�>���
P��ds�WC@��c-�DL��}�IW�`�c�j.BG?	��E�\��������78Gɠ��[�c��6�������E��Ù�����|���[�+�='�g/������I�K�(������w�{����i�hO�f�=�U4������fA�Φ��Y������3��d�,��HS�c���������$s���#��3�?!B	.I6�"�K�#5�ˍ�Z���) .~6�����;���+u� Ru?#�ۖ��G���H�0�
���A�]f�*��#'������4B=~~/��/���
]yP�L�����Ӹ��;����k �|׫�#�ƞ3��x]B@��k���4���ށ{��?Yq�_�+�E�kg���|3���%T��o�:+���jJZ���_�[R�W��B��i��Y�w	Ӄ�g��گJ�C�(��g�)
�u�_ZN䑰�j��Q����מ��t#o�።z�>�$����j"x���Nu8���j_;��a�R� U�/�^x������1�Y�\0�O��K��r�{�?7CB�H�g�J&��n��]���u�a��K��	2=��7�T9+�rNlg(J� `��Z�����)��Q�<�d�^��#Zu8��;�Af���+�ۛ0G���e�!�|��%z��>��}�d��3�ۉ-���L�V�l��2�q�ܫˡT�{Y|�x�N\\<����%�5��wKD�1E����G�f�-
\�����Q\�UQ)��.�6��rY�X��o�è޸�IZ�`f��7	�ͧ��sz"1� VC��7H�M'��za^��uy������iq*×Žʜ���x�	��c)h���?1W8D�?�bpu���G�hXʀ~}��M�� +�h��I���P�Z�"��Ԅ�Y���ȏ�2b���z6$�fGP��2�^�����gs/�Ā�s@p�/��~��sn'q�?����e�^�7��P��>�U<�%�������?����V���AD��
��%���NH��Ad���x�e���[sa~ ��W�9�����ޛ�۵l;��z:���|�=���0SO���.���^��9����9��o���S�W�>��O7�!�ʹ�a^&��5��hߘG6�qK����?�8�j|��e6�|�b����[-��<��}���<����oy��x�~"�6v���,�U�D]<g/�>��	7b|�rS��s��9oB{l��/~ �34h�G5z-�#��63��\Cl���n�}�ukz4<gy���*@������)�(��7��k�Lp�;_'����>;^�u�Y�Di�a7Eֳ�ӔkY���r$��6�(���%���c󦉯kO/�#�شD;����d?Ki�4M�S�rK��Z������0`�>ε�竜BM�6���-v*Cܑ;��L��F��Bd�4���;Sbi�����b���崶ֹ�?���J�H�t��E�ـ ���&��� �{���Ub���T�ѡ�1�H����w�+u�5�n-A��9oUF_�f�9Q������So��L�ߋe��2�~h|�j�kl8�q �A�+�߇,	������|2�q���DĽϤ�	-�`�P���~���������i�u���E����b	ް��V���p^>�*]ͩ���vFϗ����ҭ����4g�y�a��[�G�&��<nع�T(ӹ�}z$-ܒ�2�<���YeF�$�ǐL&�����)�h�9*�ʶi��lh� E�&����!�p j�
�D���*�B���BT2����%�w��d�cOC����ΐ�f�K��\�*��_0��q���\��G�q̹Ԟ|E�:(=�N���)� 	4�����a�K���L�܁�ݼ/���%Z"\"��s���� i�O<��~�`�j����6��cz+�t@����߯i��c= �����e�z�<���5웓K�3� �Ieu�y��	��V]�Ǘp���3UP�����K��ri�@� ����7�Yybc������Qxs� ��gH\��(�绳��R�sË�oc��e�&����h����N�v���5��:M/�#t� )�z2v�p���F��3��7;�˖�.B'݈�{t�r���0xecѝx޸���3y��J�1�	���W3F��� z��L8恱H\�2F$�lp9��.Q��{�Hr=d���?_� �6�U��@��t3Z�0V訿��E*�_NP��������#�.=U��Ձ����2�xT��8��ys�� }
�Oxqq�CY������%g��Gp�@��r�����gC�cRߏ�+dqO�7V�<�6��eUu���
��y݋���60�)&�fO��)xq됮�;�R�� ���3����7�:ʕΕ��Α��Ș�Ž}&	U|r�"���66�?��:��з�_bt�w�e^�c�|(���� �c�I;sڎ���ݬ%����8U+ߔ�ƧP��	�����п��� [0� >Fb�՘�~5�3'���@���TV�wꯚ�K�a�3ea*�]�f,�k��j�8lM�]7�e��e�~Jwfq�ټ��?x)��i��j	���mq��/Y�C�N���e���r~���ҡ,�ђ�@�:x`�^���Ì%�X�^�,�C
�����=�^�R���5j�˿�����m.�}w�:7�6�~��;��<��6�?�!@�0�!XM��!2}
��1��+��9���v�G=�Ƭ7)�q�cT��c5��3)�|��񨔟cQ��=
�}׺�t�H�طaX�����Ԥ�I����TQ+��0�T�%�����y9��J/Z��Sv�"G��,��*VA&x��rq9���r��"#�E7�]�}m��S�<𰤽J�1�� ��`7h
�&����J���Ȭ&��t�%��v��c3<OՖ�W��mt9����l��bI��(��Z�$��ú��1��}�W�FG�**b�b]�}�
���K�z�矯o$$?݉��(��O�gP�z����mL�o������\�x���Sm�`��/�T�R�ɬ�b�=\gҾFӄ�DkPbg8�*����k�O,�p����a'�y]���/�O%\���k@"G�h�
��/]�vO���3���2�*��hc���g�;� ��]�ݒK���1��ܘ    T0�]<� i!c����RS.��w}��+���|C$�p�@���LU�� +��HlQ��7K�p��O6��V�	���^�
�^W��($�� #��(��2l��E�L֪���6ֽ�N��U�Gˀ���4D?��l��!]�l�N���[{�a�Z���w��M~��K��|�钬t�����T�xTܧ��"�K�`*���w!G�����$��߂G�\:�0�=�����g��x�����$	�0��ωy{<v/���9�yhI�	:	��zI�:
ճ�Z�$���8f��R �o<��{�k�W�� .=y��T�;�C����(�M�u�&���oq��;����x�<O#�ӂY�x�o8�:=���J��?)־�FsP	�S�-g,�Zxp�ԏ�Ӓ�7HN�T�uD1?�A��!����,Ą��,��8��[�[�?�e�w��E2D�8�#I���,��
��6�haNLѡQ]�1���L^�vNy����p[��	�' 1[�r�
ro��A|��̄���3�X<�EY�ꑂL�-$ּv��)��'#9"I���f޺�O���%�pC�Wq���ߣ�͍��>��5C] ����2`���� {a���8�H&v8�os�X9?��,�>�	|@�������ղ�O�'0rp_�V򣱹��K�6�b'Yu��|�wg�5��7	�}� X����{�9�����q-��o����?�/��|����VȮ�����eI�_X<L�w�:
s�=�$��/%�g{����A��Í���uS�)�X���",3X���>�Bukz�{��N�P�^�h���_*K]l7F��f\��43�#�'��~���y%<rb���#w�~c����U�P��Ib��7��Y���.�Z�8+�3:9���+ޘgi����jwݹ��p����'��Y�$�\T���'�3Z�]��ά�_fٱ����Ndw�z�	�L�E��$� �H^9a��{���ݹ�(Ϳ��=`(
��;��^V�<?>��ʎ�dͲ`�8�S:y��� .�X�" 9i
9�Ϭ�z�����!����glv�p��A�ܟ��n������7�PS�ip��҄�=^������>v���U�OWr�t�A��^y#�7>1Z�*�����uǳ�v(�U3���3'�F�;qF.�4�.
<�o��k�q����y���(`	3���$ ��a��:`�_��Z�Q�QYY�%	���Z۬e���ڞJ����aU�ż���5�K*v�2����G��t!~�E�~��.�偋�-w���P�F_h�L�� �j0p��9a��%�Z���74���X�8��.��[6 ��{%w��SUUY�[�P�GWgYàfR�n|��|���A^�ij돾̕�X(�@3��k��0�Tn\G*�\G7-
�o|I�ڰKF��yK�:�aՒ����+��>��z)+KcB����_�h�����a!^������ P�9��d���Z���$�++/X&0�~��QD�+6/�aR~��&(4v���ͽK53��7<�o#�зZ|�^S*t�M��A��I�fu�p#r�b3����'^�����%
%�/D?�ߣOT��d�U��^o���*��1�#�{"S2>!;U���D����1��o�W�3fi�^����o&��b�3�;��N�:0�u٬;�V1����U���8oO㡜��#.��m�@8�&s��+�O�\O�*
�Ǘ!/�Q~�C%{�;۳�11�v��ߧg����?���F��͸C�]9�>&ѡkO�!� �t�̅͢��r!��������<��LB��e���4�����g wl^�/�/�+G�Q^# �orl����o��6��I�t��C֒�˿1�(�/���%+��	�ôn��'ITS<���hdT��r򨋥Y�5���$�n���ץ��/>�O��|&��7��[������(�}&�<���g���d �����lk��r��R���G��Ao|O��I"��7|�[F{O�#|4����x��\)�p��E���bIkE�� ���?�~;p�q�X8b�뗐�PrM�[2�/}2̪���L�K�B�n7����߉q�2�$�0G�����9!Q#�1�!�݅NLEg�u�̙AGs��4�B7�KN�A�g�
/�s
�K�� �N- ����gj?l]�?��Sչ4�l��#�����������Ǟ��������x?�����Sp�/c��8>�Oy=�_=�ȿW�=�����/�REՐ��}ev���k�)�foR�K�1w[�]��>U�_�6/�FF]�2�b�p\�u�\:f��_�W�`�|����g�A�u�%B�U��uF -�Û�pޤmpX<0�֓8��t�z<I�+�����s�F�/8|� NL5Dϥ������=���8�jT�p�`���Ԅ�
. M����d���z��ic�?���B������4֨�ޜ��OK�Fv��0)&��o�� ���쑉����;�b^��0��1��{U�$�,��u�tޥ^���}�=��|B�w�/�͎	��J�?���
��յ�S䃯H�����-��F�5e�2:.�4W�14��Y̟i��ל"S��b�L��U���ɁBdHU������~a/���#������<C�0�������?B�圷�& �{jt������h|[-=\�ӈ��~�\���Ck������1�� n7gZ↊����{r����kd�u�sC��Ú�Y�|j ��M�����u�(o[�^����ϑ"'� ^����c���ħ���W�7����'A�X8�+��%��M�8*�^p��
��<cuB��g^Bn\3u�#��ھqgŝ��[�/�<K�Ŕbv���3��Z�Gh�o6�ظ���FG�>/=��t
�{�E������(&f&�δ�V��?qݘ���^�4Kj3]{��g;�)�R�9y�V��R=��8�ml~��{
')�i��x��6��w�ɷR �����An]ݛ�?sꞆ��<�d�˶�E�A��|�il�(����.����q~ K��lu���E�R49�Me���@c�(���y���X�9bbR�Ĥһp ,�i��	�F6[��7��\��i�AڗԺj�E�GƓ���c��߼�߃R&\�g%+jE?+�*�LK�ߡ�Y���e��5'�H�T ����O�
e���"g��&ޮ�����&���]��ڞ� )�gaP�RN�Tp���{�}P��5���� ӔJV�Z9��S���ɂN�CQb�-/ ��M�\)�U���eh����@*�ҡ�xL�)8���(�4VҢ�x���́�D��g��	�'x���ca?�p�H\��y9�����^}u��hx�8�1x%�O��V�4X�����ka���/�΁����̝��ー4�R Zj"F8������F�-��<@���i���'Se 0kg��^�>x�F�JY<�p
��	:��U�Ư��$�K����bC�p��ҹ����O�/���6rbBEC�M��&H�Q�>R�/\L��wo�We�~h�T�5/���A�L�^�������y������.���g
ZEOWy���c章�CK�e�_��*��{U�'+)OMwE��o�K�~iH=���������$��
���u�1!2�W�����&.I�Ğ���n]\#">�(��z�dh(Z��GQq���h?T��1s,�a}��E	�����{`^�뾋�i83 <}�Mw����2�-�K����kk������R�;��`x��ߞ�����ٵf�zr�d�{͝I���]o05/��*]{��9�>ټ�Mn��#��s'��U�:�h_������y���0��GoeG�H�F�����@g��2R���m�l==�h{C�,ޗ�ӳ}�-����dm����wx����y,�'�����O����Y�����J%b�y�v:�h���f����2��A'��5NNU�s�L8�������_�v���M�g�xgwkP"$�^uH���^�1�6
����xڡ������QA����$��P�    G�0|~����q�,I�K�Rc��i�|y��˦3E�§ O6�SO�B��a�}F��Cmr܃�1�Y��|� ���Ӝ_ C��t��r4�k��%�@��/+����B�G�3�C)��/��ͨ���}�V��&��U�}�t�_�ʋ�}[��uv�k�>YN����c���k��_o��g�pvAx��<�P���=��kWb����-�E�̩���\u���L��U�[����Η�ZB�h>��\Z[��I�,4��D��$m���B����V/�G���s*`t���~�����������j^ZՀ\����z>L?|u	Ϟ���t^hc�a��Ƒ��|S�f�n��q2e]Y�������?��j��@y>:۠��@U��O[��J��r��/�4+���\�-BA�� �Y��Bñ��7���Gߗa���	���7Wy�c= ���˿�����7�\�]�F�rא��`��]:)��ŭ���=�J�Q������L�+8=\���7��3�	/s����l]~�s̟�j�q����������~��'���,a�c�z� q�����`4�J���[�����3[T���EQ]=����KG������Dbr�C��3Y�KZ|�8�Xw9}Ki&� �h��R�i�٩�IY��t��ℨ
,�yT���8WZӆA0�xWO�1��/l� �6��֮%['��������;_��?3οn�;��X�x;���Hڄ=�@�t�a;=�~iè�xR�����i���Щ� ��ޞ�c���@r���y�0��o��U��<��S��\K�W��m��l��ӎ��vw�M��G��6lzqY�>�q
�1�K��׫s`�?m�6iG:!h�:~�株��Z�y`��Vp�*Y|�?�p1�ab�M�}-馂O�: H^��s#��!�P|bl}�`�D*y廡&����w��6Y*�"�}h
��d*/��3���_�Z��z�e�(��8��*JZV0��ވE�q��i�oAõߛmH���R�SDA�C��a1�������r(2�ק"n=�����>/�;�N��(6�q�7[q��6��MӍ���v�SM��N��R�ж����)���c���>W$��܇��X*����k�{� �0?�v@GO֟`W��ў�&9�F�1�]_U	�g�A�"�=�2 ��{D pf�k� �!��2������υs�?��Nçq�h4�U��M3���[���uj���k��nc������>4�w�h�ۃ��B%��J�bc�t,n5����VBD���w��q�,R�1R��yڕ�d��j�� �����#�W�{����
��ҔM ���O�]Q�'������^�,k�|��ǿ}}:Q�鲑�~���A.|��L���/�a� �ͥv ����^ۄ>���󢐌9_uM���e|��}�$�[Jf�{|��0_W�s��ʻ��^F�m}ՖZw��?rt��%����ؒ����}&C *>"O�jZM��4��vH��ڽr���� m*�9ܔ�2��F�L��M�DR���m��ˠ���0�!�y���E��Bq���h��0��1:�j�|5��댵zv���>g_2 #>~�AI�ԀT&{xϝz�<U9�\��C{�a�C�4�XC��t�9H��q�]d_3n��Eo��̌�{���*� [H<�Ѻ��$�|5�x��Z�8�0Vnv�$�9��8����)]���rxQj�X��P__��^KՌ_�v.�;0� �x���ߔE�[դ���XNu}`���gxk]U��i�M{��52��Q�>?���pOs�v�Jv�9@n�8te��!2G�����
�|�TW�"�r��_X]�,n�a�E�(���YjD,��qs�}ߡ��T j�Y��ښ;�mʿ5C��z�̦��3g�����F�yd/��x�7�W��бc!�@m@�`��_�{��è�B0�'w�����j�p���yăH��k?�}1"�
�r�HD:wr���x�y(����%zN\z��z����2�e��[x/>"v}�n@�tD��s9���FMA��x�e,h�?���E���y3����X�ղq|#E5\Lݔ�a8z o�	ho��ncd�ϺU�=p��C���}z� �&?���w������|ͭ�>s�e�{��,��Y/����r��5	���� �xM ����x�z8�b1 �����|ù�f��&��`�q8���	�]�8����~ ����M�h4c	#3M�j�o��.�Mih	|�����O���af=��:~4����|߾8�d�"�5k
��|�#j�I��������*U�*v�e=��)��V�>7�y �|z/��9���P�j�׬,���d+Eū��@�yݒ�����a0���b4��1����|c hb>�j��BJO��`O���� ',(da���w�%�֪��TK�xA��F]3@h'��. �x���CU���������o~��*�vLu[��=7seb�,�������զ��MI4�LnP�����.j% ��k�)���uVltw�� 0�B���h׮��it��i��c��?;�w2�� ��D�6/�<����.0'�gd���P*}i?]�J.��.�G'�$y�>q�K�AM.��t,x���]���	O�Y��07���H:���N5��go/4���?�|NٮZ��R��p�eȬ�6�"��S�e+q�3k�_5 �����7�x��x�F�[�l풅��O3��xu���=J�)/��?��螺~�mf��/!�.�{Z�JZ�}�� =���C���5�uR�~�1�e��o ϡ�����"t5�E�6!�	tF��n�$ߌe ��(LƂJE���x��L��`�u�o�.��l��BD���I[���,����E;8m��1.��"����[))m˂�/]AkKr9.O���؞���
b��Ecpm�� {��_&��,�cv��J�v��|'�j�&?+��g����z��5_��5ۂ���G���9_�Sy�gfw׼����3��h�mo �D����s�Kɮ==U��%0/�<t�r�?f�:�K�O�����Cѥ�v����0�ß}@��bT�����%�a[,/��=��֗#/�Iw���e���p��5��+�Wc ��4�5��+>��$�kt^�<Y��C�	^ P~Yn�~赓:�>㗫i����v��Qљָ�A@��Lﲔ�y�qYWZv�a/��橋��h����������1���eyڗ�U�`%��,#�G7��K���+�k�˿#����S� �'��2�%�?�"�.��m�x
����7(�Q{��Ŋu�����]���_BK��|��d:[U�k���S�Q�:��3LĤ��4pd�������6d��y���O��k򃀞�}���N�l�C�ߗU	�s�$��v�q���8k���}�������/�t4~V�ƙY�LJj����H�-{�$<U��)�O l��nj�dZ��S��N�a�}�v�ţ<B��\�i�.q(�����+���5�l�˜����*��ҴF�]D��b;�_|�a|Gpy?�iBiJV�}q�<���٥ygΧN��q�'���"���$@�v��R���&��~�>l��{��X��%ES�qO�tn?\pY��;\i<��2~�]0���� q-x� �`���8�|5�_�L��m��+waLݰ�az��GV��8v���T�ٲl8n f@��B 8ި�vpR����eZ,�;��&nw�T�8� �"0�Y��g�6�}yCx5Ω��t&`h�s�@����+�f��EA�\�l�*� [�����$���,�Â+^��l��bI��������W�ӿ39#�B<yE���1�ȗ�l�x��+;�%��9�x
�L`�qz�c1�A-���+�=7c ��3�#��F��|�34m(Y_��/�z�:�*EJ��t�WkJl	�A�q|������	�����B^����Qk�v���Ϙ�i;F�ts��CL���b���(]�@����    .=@��O��	O�O���dI�?":�S~�N.B[�m���%�vH��m绽1�����1'*u��w���O���kr��8�'�"�c�3���Z���i��?��onh�j�O��C��DG~�z+���m�^/��@��iC��sC�<�R�?�a4s/,��'��'/�]zgHM(u'>�%�8{����j���8s��Xd�:�k�Iilc/��gN�k2� ��2���_��{�ʹdEq��9ݿ�J�8���ќU�@���q>�:�zo�͘�־{tCýU������:��c&��؂"a�O11W�2����7(��k�`�<G��>�e�"��ݦI0m4����|�ڹ�Dz����2�_�Ӻ�2�.s&Ş&`&D�%Y�S��?Av|��g\{Ք�2a��Q���h'n��7îC9�
@��|?�n�^�~�˛�y_	�58���5g���l���IEo�&�S�wz�bg���1�|\2R���nY�\t\sGR��h�W�#v+��j��ٽ�����l[S�G�^uP�����]�IS���0\�aLwq����%8��r��σs������\,�����6��T�����g��lԈ ^�D��yN.�̶�`��^�gb���,�)��J�;��� �l����g��Gd���2�"�X1���X:dР�ᶈ���	��ڔe�*��V����z]Ŝ���'�H�׌���J7��^�ȧ�
 am
�h~jG��]��|床ў���u���q�ST���f�8��_"�×y�4�b�:��	�տu�Ȕ�����_�ҟǑE�3Ǐ����y_:��|����:��76^,#�nY��@��=����$.c�B?�o �̀~{�i�\�k�6si�
�k�.-�E����K+l�	���r���魵�/F�d�!�q�߯�b��ɸ@�YDߨ^W)�������	Ϫ:��e$}�Ll�a>�lz��A����J��[�(��ɗX?���	����x��C���:�p�yܣ�3uywebM:m�U�	Ve�Hx����ˎќ�Uo�-A���-E� ���Y��K��iY?��f���O�T�]D\���
�Z�B'ޓ ��bXl�&����Yr��9�������	�4� �xpgU��Ü�~t��b��ŵ��|���k�5,0�g���Y�bLY��{�n�\^s$-*��pF�s���e�Q#��Rx.	�o@ԗ�_�K܉����K�1����b!�u�<r��督�g~��b�y��9C�N���蝃śy��۵�\4�BB��۾��/�@	"x��ίr������7�TL%�{�h����*ޢ�{�ЦJ�{�E�a���[�N�����9ٴ����q,��O�������K�E�u���JE�A��]�3ET�C�ɫ�VN�����O��&��6V��+����{>G��0���s��	�djD />���5��?�U��)�-x�5X�J�f����(@<^�i?R��,%W@���r�7�V]j�/'����G}���d @�1i�R�] }y�8/)S���-Ta�N=2ִ=qu1u�{��a�N��M6"<����r(�V%����ƮF|FĹu��؞�;s��\�)ɠ�kg��m{�7��j�St�=���=�,�&XTl�S�T��^5l@�'[(^�Z恜ԯ(`�J,z�#�3���v4����$���qթ����4�,�Ո5	��a ����\�"ͽ⢡K
|�x�U���g_���1��gMh�7̹�y�uxK���Њ�$~����?�%)C���v�(~���������y�ƽ��Sew���1�&��ݞ�.���7��_)��	VP�-��]��DS����� bu��G0��/��KW�S��Hjw3�\�!>�4�ns�]�$R����;H��"Xy��`8��xzN�ʥu���^�L ~��f)�Јs�⯞�S��c��/̉����f��lf?������N����_�������x����'1tx_l�?�o�ֻ/y���N��Qԝ6jU}N��ߺ����/~!���Fd;pG�G�@�J�{���Sxΰj���B�jA�d�᜵�8`X�S�#,�Le�i��&����&��W7|���8�dyY������1�/BNG�_�m�ZY�����dAZ[hb�_���(D�?�e��m�O 2�A]�7�� ��o�3�U=�&�!�ep#���jH+��z��6������� ?<���x�i:��<��7���<�&�̄�!��A��$�Aa��Sγ#l�à�0(ҽz�	0�)׆S�>��]��XO.̞�I�RN <�_��g`;J>�$�7����گ+��?�����Y��n78�B�1E#T99�ǐ��:�H�H=A�b�h���8}}Z|�O_���^����4}����Sd&�s�w��OYJd�C�ԓ����8�R��� ��p����C���g�T�l�8w7�f�n��/zyD2�4�@������U7��j��M����bb5&��_ ��� XM� ���S��"���<>�^�#�f�0��� 7v3�0]��R�!UC0�k���X����w��'���{r���y;L�	�=�ٛD�OG�d�һ�\��b���P/����\q��o�s�Es#}f����«���ão��izK���H���j��S�2CoFs�+2�;��_�	6]����%q8ib���J���;`ϻr�.��[6�.���G�3$��J�X���y3��j�C&*�$� �ɉ=�=�b�v�N��^T X���w�r��a�*���}3Ȕ
Tp����}0K@�7�j�r����8���cy�;O�����t�/A��~��?�z>t�u����q��E���(��}ҷ\9$�^���Ǐjǟ�㋍�V�X�?L�1A�e;}w�?Nf�ց3�8�ֹ��.��H�V�P��5E�
� !�ju�ҿ0��P�5�t}b���2�k�|���a*��?M}�K�����ԩj��u�����_9G�%/�[���S�V�N�G�䛃�����/}�K"���38J+�c�/[�wͯZv'b�؀a�JNK��0����*�v��ُt�x|������e� nS�"	��"E �М��[>6�ت9h^��1kaG��g��wZ����&.BЈ��.��_��)$�w�d�5�\�,�[ժ~[��t\ӏ���?����.u&�|���i3_��I������ޛʗ�wx�ݨ�	Q�|m�2��5�}�y��?�'c�����h����a�|~��F�U�W�4��,�?��/��U��
���x��R���� �A
�p4�^�O�˳W!s�e7�幅�!)�u7�E��T :�j(s�w'��֏w{�#��|�U�2��G��펓�����8�ᖴ\_sE�lp!^�s�{�_z4����	zwO�:wWd�5 ơ:��?�Z�k���g_k�D��s|�_l(w\��]`��l���ւ����*lb����	��39+��dd$�1x:J�*W�zޘ+��zo�kD����Tq��e��=��&��j!R��d�@*��{#KX�����j�6�҇
i����_�\���k����(��k��(��S�u�ߕ�f��y���}Wd�_%�Ķ�?ܳ.�V'I?��>�!�M+o�pdE�1��z���̋��s�ϬA�+a����?3<���� ����v�a[���e��ę����p]�*����eK\#%kxN��(q惜��!��/�����&�㼷�%~wvš�p�S9b�+_���X�\�p����j,�����v��a���p>���4��J^�#�t��Ƙ�������������Qt��r��F�Q��ݼsi	�i ��|��Ŗ�Ks����	[��Ȑ2��*����!���E�P��*�{��~����hLE *�rRV%���_7*�8Pq�7��+5�%���[}7+��G�tŐ 9W�����rE����x�>бd�G����HƜ    �L�D'�E���H倗'��s�޼X���6z8�ދW�GD�6�%Gi����.�z�'�Z���Ҙ�K�4]U�M�7e ����A�)ܶ\&)ˆK�<l
�AD�]�jD+{R[����u���CӪL� ]a��^�c����h#� ��[=�S�(8��i|��������
R��}<ϻ�"o �l���­�����z<��M݆���!��B���O���q��H3;�i��x���t>������y��I��(���E��z+��R��s����F��P�/u5Ch�Z��������t>S=�	��o6��Qꖛ��1�����0D�*�Y�\UCԿ��nsD�8�A�ҋD񀸜x��-Ȅ '%n��*�D��^����x����U�텐�V��@�3Hc^:'�K��к��k��]0\�nvcyP�%sr����[3������]�{˿̇�����F���_�ӫ�w�F�޳�i�z��yA[BN|�W��o���v}����� ,�y�q�t�����g�����<VK�p�xO��� �S�*���X���p�.茒�N�|��|��H]��m�:����c��b��ܡ�*\��m4ɖ�;0�<�ڽ�L�-��뫭 : ��h>w�t5Ur��1g�;�VBm��%I���l���?��DxBR��~f�
��B�� 5��d	׌�
�O���2��ƻ�:�S�r�#	��'�D9reʚ���!��Gx̥�Uwu|�wQJ���ֵܫI�%�M�١ހ���t4�V�P��0ώ�֊����C��=��wtE���smy�.#���cZ*�{�Ǳ�ll��?���#dTDͬ�x� ?��%��NC{������]b��ei ):����%F�WW��'��:�
W0����?���m~\�w��vʏ]��;%J5���NjZ�XY�G�È�
���\��b;Q\B���ƳE�\}u�yc�<����ۆY�,Sܸ�($	�r�;��z��p��!�{�n��*t���:_�C����FO�qyn�2��ROځ�b�Ϲ�N�_b�
�hɈ�$�h��4#P�+-[��r�5�� )f�I��Eի�4����M!��-�D]�߃�Q9���]G=E⪣26��l�����	��z"EU�k����@����g�oY"�R�`�Gh[��|YU&�q/���:a(�������Wn�`,7z�!4Pf��ivɝ�W��6g�Z�G��R�3'䆶�T?�j�.�k]0�}�M�~�׫����ѳ0�ʗ��F? HS=*�5�uV?��L���+�Wz�����M�>}�%�0beވ$nR���{\5���a4�4��o��ﮬ��"�5��`��cN	4��*U:g\�u�#����c���К:�0�h#��y޳1����*`>���6+��w|��W��T��ʪ"��j�J�����hq���S��t���?�T>[j���U19<O�l���#���,h'��&(3�Y a��A���v�iZ�0���Q���<�l�g�8��.� Gn2�-��F<wU5��]e��^Kd�t�b�F*É��� ����0c��cT�����i�y2�F�ئ�>y�e��y�R,�d$V����~�R�}߸D�[�<�A⿵��%��y�\��Q�g,`�<�x ��*�I:8�6x�uS ��k���*F#� KK܈҆�37�#4�a!C�o/�꫞N��ٓ�� �?㍢O�h]��>Au_����	���P���^~W6W���9���f֖���} ������1�4�)�-�o�O;��k���O�@�}��ֆ{�"��GQV��QY�?�g�U�5�J�t7�����8��q*�hF���t��!�tȥ�Q<���Z�t���hu����-;(����9�&���
�.�sb�sSq�277��`xP�'1xt�������i��*R��_�=/l���E�4 ��_�1`VӲ�  x�ޢ8��Z��`���
�����å��@m�g�ܚ�����EM.��݉&�!Yq��W@�6��TWawaؼ��/ט����yrC)�귎:�S���6"���� ��@M�D��6�]�lyM"���h���{4��>H�Wb�$��.h��~�W��0�ɸ�d���|��#^{���{U�����L�m�K�N4#-�J��3r��4�UN���!��ץ���i+r��!~�T��O�tG��g��Eum�Lw��5�5��xw��^��GV%�H�2��)�}�\�nF,��.%O��ŭ�9���113���9ъ}��[7~�	��
90�P�	m޴e�5/��a���4���#43��-p,��M�݌z'��-&��x�l�������o�)'��T��!;_z���;}	�pz� ��Tf�箷<�Mg���g�Lk�i�z�D��yoל�����.�텹|�)�Z�yڃ?Z2(�B^|vɨ��A���:�ОOKy��lqh}S<�h�e:��.���0�#\������-.!�G�B�c�<��<�%�pէ�18�e�t�n�꯾�<m�i�Œ�<�n����'�T�5n��6"�JǏ�����*]g�P��+�(pYw�9�o�^��4gO��J�<vZY~�Ֆē�P<�E)d7��o�&�a�F𸴜�����dM{>n5�d�7����&�8�%���9w��>�D�d�󮶵׺�cfX��pY���^��C6,	:�c$��T�C�#��"�� �j�b�w�F�E������f(-�n@�O��Ç���h>�Ì���M��� ��܌U��/:f��� �){��I6���~�Wn��˴U��>�W�!H�=kdV(y��j�����K���81�U�xӆ�a|mVz\a�k�[̖}���!��Y��������[�vg���,��Sނ1�ئu��u�����=Ѻ�]"�~z7��kg?�K�ۋ��l�Ɠ�* F��@�,lr;��h��t3� x�.AЦQN�� ��%��K�(Ie(�a]y��+ļLs�TkFsSl~+��)ME*ZBP����ß3�H���S����~_�5�����ӖO������
��wl^���Z��@�d|�eY�D�^ٲ"�"�?��y���2q N�2���>��U@ƿzD��
�+)Վ�a{�t��㮝-w~sbW���퟼���� L\�{�`�<կ2�4�\� mR�����oM��Z
��v{���ٙ�6�`������K��:�cUN��=�-�2���SDu�u�����a[m	
��/��|��G	"��k�QF�qQ<����Q���@U�x�<=�� ���̓�k�o�/�.`$���=��݆�\뗀��\�9W��BbK,Q��V�D��G�s;���:-�����Ȁ�4����_XR>���u�$�"?�UC�Ӽ�߷�H��F3��n����Q�ܯ���/��wv���OYy:�-=`�����D��f��~�(����=t�͛N>�o��E3�N;��ܸ�u�&*�{��OO�K��(~z��u�J��%6+,�i��&έN�����������/(�_�_X�T-��R���_��o�TI�Y����%{-����_eOC��%�ON�O��X��-י%Y~ �ՐP�"	�f��"�~�?��9U�������Nv����w�w3��X;�=���io�-E�������|��!n�<��m�1�DJ����tQ�� ��oLh���T,�<�ؙ�3 ����8�����kq�\�tt�y˄�jq���Œ���޿��|^}���Y��Xq�5�������Qy�Q��7��H�P~��C7�N��x�)�-���C�% �<��5��Ћ���O�˰~�+*d�--�6�������;��ԙBB�ê`�s�f~�$n��ï3~ɢp�Q��O8���n��)��\�ox�9�t�["��yof�I�ibcZ#�OvN��B���,D��%��W\y7tD�����c��	�k���t����٣�lO�;+5D]1��OG    ��ΤA1HC]ׂ�I�_KM�C�v6^�ʝ2��Fr�\�C	$�h"�]�i�ᓛ��M-�;Q,6j���D�(�#ĥ+%_ @��"�=u����ĩ���P��nS�[��M�3�����̨I����1��̄�,d���@�7`�o�C�$ �����S���ؼ��P�����>c8o��;��I��y��QM|���>�-օ^ �[#�o�nv �X�X��f�G�Ab���������ڞ�C� 7Jmk�J6���0-C���}	�1"3x` ��Q���t[��+��  I�\�U�н9s�l�4A��j��M$��V!�鲊����7e�~7σ�[�ܟ��6������M$����n����U�V,^�R-@q�i�;1�f�I�܁����-�J���OZ�|x�ep��s�P�m�]���γ������|�ϟ��-�=��/�NR�P,�n	n���~���ת������x�+q�
o:�WL̗��f�Qj+��56'�ƺ�<$?�M���C�G(Ki�Q�	sv�l�z׊�����y=��_�P���� �[��H��uT�U�)�PBx��c����.�?/����ͻx ����~k��]�cr�m;.�<c^	K1���(�����j5ƽ�}�������M&�0ţ�6	7uG~�|�8>�sq�'�C����E���˝��r��a��T���)�55O�,)�����s�eQ�ep���7�۠M#|�n��#sĿu��P�3sӑ�S��?�Z0�b�1�;y,}Ƨ���Q�����y᭢Maƀ_� m:D�~�� �� /Z��`}8Z���W�=4�*R�8N�t;gz��\�5�R�7��]�>�z�`[)�w��r�!�MD>��[,�i������@\��$�R�ES��v�]��$.ԇOG�M�#ɐ���~�f��4ݳ��I���5�~�P'�}�{ǃ=
T���(��K���+!%N�Ի���2;_ʻ�.>9���'u �ߚ����Fl����|r�qN��  �m�jt�z
�	�(�Ek}����/6�{y�|��M���CWG�������\q[����,,Ei�(��Ѵ��C�a�ũn��+1�svĦ�{��z����ZۚK���@ߨ,_~*�\w7,��Ej��X�	l\4�{q藞@ ��(�����j B���M���<���R��ۓ����O�2���gh�_K'E�1*�&��^]���w������Ae�v�ɛ������82�C}�n'�kw��#�;H��r��dH��LD�7�� F�O�u&K��}�B����?���I@�òL�`@z ��v��x�~�:�+���m����^/��o@*��֮@t�=}*[1@Bi4��=�Y|*���&CE�ib�C����;��c�+��[� �$�����bx����tz͗6w+~��K���p�@}r͗ﳲ�O�r���xIlʾqZ��WV�8$�-����]Gt0�i�_$�V3ڳ���2���|��$�ґ:�͛\l������Ny���xxk9<ֽ�j��������Ua���%��>_
�}��{c.�cX�lp��c�������H��.�NUC_����i��M�d3�'�N�77�7��ao�]X�� ^bb��޸��R���Y�eZB�g��<>P"{>�LeƐ*a��xbn���k��e	���_n�wU��6�9�RH;e��"pO�1nX�!<W'5��iAq��Si��-��
Hq	N� Z�D헥�fW�=}�~��Z	�=�T� 5:Lэ�Б|K
�'����R�@<��K33�RвDM�����#L��{��ض	�	Ae�9��t�;!ӑ�}�N��%|�,C��ç,�(�l/���y���׍p�/�zȩesF�X���O⩸�~0��Z�]�&x�⦢n]�~u1����)�i:S��O�^�wD����B@=����
��T��#���ekp���~K(��j)S�>����3�4G�r�[L��4C�>��+F�\��{���+	��i; d�y�oܧ���m�4��X3�Vn�ȗ�o��{�"��V9�6�
�R����Y�b�%kh��Q�MT�
ޭ=L|��/:�z�)�eUL��A��-���v�s>=?��
?�� W�tƬ��HO��#�6kR1�q)Ρ��x����~�o[>�q�5��=k��xl��Büq'7�.��Eџ��0�"
�6��A��m�0��2U�g�U���
��T����3�h�F�f���֞�U��si�B�Kؠ+����+��#���v�wr+s��A&�8������=��ّ'��adWGY4���pa��6��'e6;�ɋg#����I��B��R;�Oݘ$f�u<���a��ګ- �M91Lá�rZ�0����ʶ�M�!�e��7���d
�!S�����2����
�M�E�8s Oz.Ry�Q��G�W�`n��h9LU����){�V�C�T�����2�	Q�����]����<�Wn�����x�(ʚ�tľ�%$ɋ�y�s`H�!��c"���	���cEb?t��+8���)�ݘ)�j��l��P2�kz��W'f�nv�m�o��^�s ����`u����((��v3���+9D	���C<t�����8(���~�P/>dU�� y��]:�v�j�f��^��{ ��H-\�5)��h�i�=��ÂdR��"(��5t��ڲ4]�J�Y3���n+��:ب�YY�r7�;��y8ˠ�����Q���6ߍ�wP'��^Qy��(�N�;��[Ѿ���od�A����M>����]�׳Jk���o�?3R����C_ ��˃�kNQ;J����Y}��6C)�&_���aF�d�F�7���'��~��qR��Ԅ��|��<���'͋,�Cy- �n�B�?�Η=y��l��hv�EX�%�C�&�|}�"&쏼;I84�?D� 6�3�X���nZ� ��^�	��]e��2���o�M4�\�h��>DR� H��
.�M�|�w��2��(0�9��|4����nQ�u�x���3�`;�6-1���7a���˗>�-5�*p9�a��r`e3UMA���JU�P\�.�#�l_�v��m��T�Rvr����7/����1�ey�#�)�R{��q]�ix�� ������}�w�d]QI5qj��KY���`ts�<�8>~�h�S�:��M�R�L�D��/���1P�ޘFWʃ2<���,c��"�J
��B7��F]f����NXmQ�� �.�j|���{��
Тݑ��3i��A��ﻪ�z�,�%��	.
NY�ıa����Qh���U��������t�Z���i�}�"~��%Ll�S��3�	7!B����:ױ`�=4��N�pE��\���dn���4�b=�Ϳc���HtI3B��5Sz�?�y�S�S8ɜ��x�LEa\��h��W�.!��OkO�:~x` \�,W�\�C��1⛒���X�7���
#���.r�0m��=zAT���7/詩����.Nl��<�z���fD�j��)�.֞u]���z�<f{|-ȫ~f���T,<�Pd6�O�g��*�Zy��~*��0G��t�@�1��4C��]�Ĉ���<C����O}WA=���؉��[�&��F��s�����<�g/���Z��꒪eî!����`�)�`Y�ߗ�q:/i_�]V��885��􉬟7X��FjkBﵜ�p�,�"j��Q+iF}� L�S�K��_݄yv���o����b!�4'�;��`H҅����4t����\���^�lCt�q5�w��9C��I��x���7�~}�b�&唣ƾX����v���t�UT>���!�N��]�*���}S���}MN��&�#>��cC��3
�Ę���$@�C��.� ��b5�5�O����˾!�7?�a.��)��̯�^;0��I2�bQwIE�W\�3-���U��<Y�\�Md	�    �qVCO:�^�u�K~"�(������C�M��a�^hӸM��F���7�_W@gx��CTC�#�V6���8�X�ޢo�v�bz������Bh�O��c3��+]���AQT*�ݼTL#Fjv��_c�-B&���{���A��p�
��]�n[m�톙�Q���ҧ+bz5��V����jP�{�.u_�?�G��j�W��˱"�T�I��E9�����z�pΓ����V'��caV;/�#���B,Ue�zV�ݙؔL��6P�`�@n9�}�u���p�@vs�EQ����[��h)����e�ED��X�o)Jue硼+�}���� �N�V�#DS̥"��P���g���L�X!9�D�+�}�$V|S����_�����_���9R6����m�GOu0&ʭڛTz$���^��Ÿ�kY
'��o ��(]�[�Ν�3�6���L^��$X�����ܴYe���/��
�6d�����4�b����+�-��5}7��	�cn��0���mh`4''h����:���-�E�����z�������wT���)5W,/B��H�?����:R��+�?/*7�-�]�wV�L��3�7O��X�� ��"��C�����G\�Gg#��]��Ո��{�=G��]kkB��V�x�����T��Ǣ�b���&{��Y�-�<�?�8p�P`��-��t�(�ú����'��U��L�~h���A����:�s�WXm`����d����8���)������<y���|r;&��"m�����M����"������tX��DWIC�?�[
�7]b�	cP����FH���n��n��y��7�h8=0z�Ēd���АY�L�� �J���z10�%��
Yy���S��-���[ZcP��{=�2�`U��_�ΛE��7C���׾���p��Up_�^��'f�I��P�,��t�͎�Q2a�����s �� m�^���>�P�KpN,nh������I��+:�o<�
Œ�.�y4Y'߂���<#\� �y�'z���bH���b�~�(����Y���3�俊��9��WdR����ӹ��� ����>�f��u8x����r�L�f�6q@<����`2�1d*K�D��T !�\�K�{����ݞcjYE���6^���S�6N/�toRG����:"Sv�!�W5ٚ,�\���m�w���}��E����������Ɂ���<ݢw�4��I��|n���,6�ޭ��n�T��~w�Jʲq+�CE"	\�|T�>�j{��d��q�M/��ȷ��>�~�\�U ��R��7oq��j	�����-�������DS����{�ƚa��"ӻs0c���m����:z �� �	�Ԡ�%}��4 qޅ3]wA���`a�=t�)��v;nFb�p�)e��V��Q_�W���
�w�Ѯ���>�,� J⟄U:uZ5w����E�F��Q5�Y���l�`u�>�)V�-ۡ�����b�%�*���U�]�j����7Q��:}�TՏ�&����ՠo�:F�(�����(�M��h-��������W|@��4�*������HO�?��@�p���u���� ��e>�E�6B�[�L�Z�"ޭ�ʰ���O0�U|@D���ҽ���+���s>ȴS��ݟ��L��{�ˆ,U~~��Cn��?c�X��^׌�8fT�����D�~[�>�Hl�˳u���R��@���)��Eq����u�i��dB&F�2w�4�.M�9�S+G:�u�إ�ؘU�V}9��\v�O���P�g�6�:6�:O�-c3�m�B�7����������YJ<ˬ}�u�lA%_��>���o�[���s_x���r}�-��F�plr�����KJ�6&--2&��@�w^E��*p�|?*=�P��YoNOo��U��TD�o3�R,�*y����'�d��ņQ�`:�A��"<(p%��]E�<�Yg@�|����\���27��ԶX�R�nQ�e�\L߉x�Vɕ+Wo�N��t��Yg�C�����h���|{��v)��1q%Ω�
~��
��o�ъo"
pev��"��0E6�b|M�>������[&�����Qe���>	$�-��sO�L �BWB���Xk�?�/���Z16
�b���+�A���O��W�ݎp�^QO�#����H�X���m<O3JąS�m�Pk�#����/7�~��?؏ocm/Z�U_i
2k]������9�}ޫD�'���|����XNOd*����n��{a���9)��~I�;��������؜Hj�p��ƹ��L��W�-�K��!�&� ~M-Ŏs#fvب\���C��m&�f&�h�)� {{f�AD�vᶮ	�!�t�;I�}���?�#i�T���<rH���>��
��jmpl `v(��><��L��@�W`��8�JA��o�{#�)�f2�� 
s�Ifmm2C�7d��F����s����{h5P�W%DD��пd�l�Fh�~�FP�&Þ�l�б��ďY�Ir�F�v����� n���?�U��w�=>���d�PJ�;��n�`W�V`�M���T�ֻ�A����oxqM\�)nqVw`��h�<����y��5�+�p��IgE
�����gX$\�>������p�
9y܌�Y�\Ji�~ؔ�0l��W�W�8����?_X�X��Vd�Ч����5���������5�X�g������S�-�|����Qdq7|�*�8��g������&�����
d����>��_��Dq+_�z��uޘ�C�؇>m?k�*�2/��J+�x9O�Z�ַ�Q�1$,hb�{����x=&������ 	�����G�ym��}v������ΐ S���#�"��r#ش^|
� P�Jjy�f*���v��bv� ߵC�mH:܍�J���'�㺽H��>a �0W��c�?c��V�ڹ �5�ہ?'|��H����d��T����kL�'�����n^�(�@@��U�8cY��A\D�m�F�j����iq~f�P'��,�'��'������z�Γ kd .�v�_�e�K��ɋmYH�K2�Gc��-ٸ���X�	An��P�F�̆fS��23sfϾg�]��]`�h��cO�?�U��������Q��̙�z˪�!Fk_�n��(j�Nx�6��߿럆i��2�6N�G�@丠"�a
]rGQ,HW�y�7�S�����u��^�f�syx��ݢρ�0E�D��6�T��C�-��"ϫMbG��}{�����ӟgQ,�fE�}���y˳����k����A�B:�[� �����k��1��8����<"< :}�9�`�ɽ�jO�I��8[0��_S hLƀeH��K�?��4��j����O"[{���}ё2�WD!�[p��[����$�#��`������'���`�w�y琔�	�_,m��80�[7;}��1/��� 
��-ҹL��_�>|?O ����3��|=��4ҺM��#�$�����m���W ��3�&�~��vJy+�*E߸`��b`�N�uU��UU����櫌�IWz�
�`k��)�kV��n���<�-�6l��K����kK���G�nJm��~r,�ȡ+i�%���+bj�dJ�F]g����j��yבs�p��j^A΍�g5���`�/-��d^���</��l$tW��x�	�86r(+�Nu����۲�j�]�o,>��:�P"'���޸Z�5[�G������"��N"�֑���~{��q��z��if���MX���WѕF$�-T�@�^����"�D���9o�{���R����*�6j�U�3�t=��2͈cO4�cTy}��s�{vB������{\��I~���by�d��{���+k�LV9)�P{vRa�I����.�Q���y[��}Wj�Xf��fa�JǢ�����1�L�Kut�6�y[�^\����Ll��    T�?~7���lZ�P�v$}�N��9�+��u���'����N!|we$��C�\% ��:YS��<��uM�����+�^����w� �C&�Z����k�B���Ud�;?g@Ǿ��S-�MKOb޶��S�� �F&T�l����g7y���|w�d��ۋ���{C�T~|ŊǷ!�9��5�#�n��woF&	3��X/�����#%/6@6���aƅ�3�S����[M�0�$6��=�~2C`���i�\��n���M�=麺�-W]��LC�� VR��]%.*�����'~�ϯ�Po���wyU;Ń���z7}tL�ȱHC"�y�և���p���{76�;��o���{+<#ޑX�%���-��G�O��4����!�Om7�D#�q�ߦ�Ci����X הh��A#��GY�2�2�Έ�����-�#�����"�d/PW�O�*6��g��?��D�˻&.��y�)��� �q�)i�EO��~��m2�˷�c�����ǽ������ȇ��
��jk.lt�7<ˠ�d�`���}�����	*c*ok� _����nrJ?n#�!�iv/[n��_%sq����U�k��72�s�_���M6'{3D<:5�X����Oڷq�?��K��y�����O�y�9�o�#���%n��.P2(��V������m:{���qk�pn���o����_��5�{s�,{�0�^j���������N��hy^�;�������g�}�|;z���]Q<��y?�F�W��������Q2��X��v�{�o�������B��Lʟ�����A܂%͙��FFm�}�7��Z壳��;�����M R�F��=���?b��V��7ظt�`�6cհ͟8	$܂$��}���&�m��OW㒫, ��u���p�����gh ��A|��JX|FO0
f,�񾅀Z�ץ��}m�=�z��A��R8��*�Ńk�3Y#�~E�؏�-T�N�w�p�t7�NS�_o(k�;]H����ƻ����3Tt�WeZ�!d��ț3��:n-'�L�|��ۨv|�½'c�,�*{nx������&I����Uu	<�k��`f������04y@ �j��,�� �q�m����*.���BK�F[��0D🈍���yA�D�-g6j&������Mj�>�^8d���'~;jj���9'�s%i0|]��W�, ɉ�[�(z�Q:����&���8;(AnH��+�{H��r��e�!�bY�5���^�> E����bO�$ӵ�9߂u��eZn��j��R��/����Kʗ�����q��;ne�h�!�S�h�	��E����������+Y��x�!:�u;ubmfy�O�q�v��,��o2���F��>��4�T���= 6��V��yo_���!vK��{�����i_�B�;��dz��&�t���߄+b�<�rt?0ݫ�	�ѸV��9y���V�ѵ%�_����U���F��hB�|��v�C��C	��0�#�jv�f�/���S��(�Ԁ�k@pMn�w~�	��t�4}���$�m�݆7��P�ľ~u�����OD8>���˨������hH���� ^S%|ג�*�CȜ�$�U��x�����M����I�
? T��������-��^�=�}��FCh>�^ X�f��'?$�#�����ms6�'ax�f����|k��T��kO��f�v�s��ɬb��mm��/��}>��;�/Ǥ����p�]��1�|��Q��<v�}U���V<����_%�0=�?�Gf0%Ks�oQ�9���<�1���������=�ڇ7?�4ٓ�ׯ~���\/c�Ɛ �h���b�C�Q���ƣ�aE|��),��*��0����p_�.��8<��hF����y�� �r!*��9�^�?M������
A| ɦT�9�rv��#=��|�������cl;������b�ke'4Ms�rk�~����VI-À1D��8�]ߟz�aD�dfa(�C� #<��ɲl�E3MHp��`JQ�LE��c/n�86%k�mi�ofA���Ұ�A�jA������	æ /�~/�.�������٣�9>H�׻��W�IkNf�.;�T�7r1�i�4���
��DU#�O������.+c�ϩ󑫛�=�h�ā�'mo� �y���s?q��,��F�^� Z��B���Y~n�o��N����e���Hd���bU�1��CX.�W�A��%�W4ׯ��v�C�ꏵ��`���,�sX�������w7��(��}�2�<�irE^i�H�<�r#�.��ǐL!S����)�i�5���vYrN>�c��[Y���P9 �"�`��pG�Z���� *�����5��0�h2*��!')vgHh��K���C���`���'Rs�[�1�}1G(��=���sPz�D�vo�S,~h���a�[���M�ܑ{<��O�-Z"�"���C�QT�l�O<��a�`�j����6�Oz/�lDD���;��<��c=j~٧����6y�bOoِS*�3^ ڜim��y���)��V߽Ƿp����3�P�����[��vi�A� ��	+�(���&ʿr��!���h�5�ԟ!q�ޢ���ޛ�j���^��Z�-�2E����e�<�7o�:u@�$���������tp��{ H�<���F��0췪�\�؃�+^��t��� ��C�h�������;��������~�I�o�=��^0Z,}�Г��`�1�E�"�1"���qu�R���w��4c^l���� ����p�:�v���/cE��w���%�S��O�w}YT������)b��<�û��N���ml�ep�����A�����⪇���G}k#�ΌI�����/�^�E�vφ�笅τ�jdu/�wV�������u}�Փ�����E�p)���L{dx���u�w쀝xm�J��&���2�d'-�MJ-FKm���:�*��%�}�)U~�&���G6����댢GC����տ�,�XەSMկ�4'�GCڹc�v�����WNʾ�3��*�|-���?��Q!��5��K�}����s`$F[KX��fq����93����j`���]�sK�#lye�#bM�+ޮ�%�p�dz,�{[�AߏZUsGU�/Y`&�^��N�����9�X���}ߕ�L����	��F�?@(���q8/��Z��)Th���}���9�T��~ꉅH��\�����ƫ`�#j�޼��]y��5��~�-��NV���	�^=�x�Dx�@�0�Xm�2K��1��k��%���q���%�7��y�cT��s��j�W Q���?Ǣ�x�'6�雉Ʊ_°$�(mե��&9����^za�"�yk �eu$�z�1�ݴ�/O����ٳ�(o@�DD�P��n�M�ʁ&w���?>��R��gC��假%�5P�8;�9	t/�à)L�]z���;�a'�L	������>d"���<UWe?�~�C�O��_Յ�j2I��$�����,�çuc�s�]���T��N��:.�a}������8��>�Q|����,#S �_ğA����\�5!���}{s�2?����u�Fs�XQ�ܥ�[S��8���x�I�:MfoA�]ьj��O�ϟM����i�3�q�̖m#oC��7��x��G����:�:��u�ƽT�O�D(����i��O�{4|��a�V�%��{�����k\��1%j`f�*xQ�#ƂS=�$\
����2û+�qy �h8�&R$�g���Yb,������-��?�aà���J��~b]����
�e)[��]F�%�ak,G`j�^�&�F�X���ۧ�,8���!��Ϸd���Y��y�� 2R�{�C_����Pumc��/0]ҍ���?�^�g�}��,��u�
 9j
K%~���N�t8��Ű�q-�lUp��b�[�,X$I    ��!>|N*��yx1������u"i&�e��%��(4����Q�?��00�%�
 ��d�?}���W�q��)�gJқz$�C�&Ik���v�~J��	��m��7��2�&+�5H���3`5 yE#���jl�'���9g���p�¨��H���,Yys��H��G˓}�2 Y�RJ	*��fJ�[�yT�5�g�����[$CD��<���[��/��j��ˡ)��93e��M���بW�w��w��.��>��q�o�� ��+��YWTs�N���a��X��xR�bWuc�g2ᯔY��A��<�<8)Y���4�޷8y�&�#U�j ����P��A����85<遍�-G] ��?�6`�	��� {c����$�I&q8v�
�Y��>�X�}9D����Ӌ�Ǭ�=}�?9�Qa�X-����/���I�l5��~����׉��e��M�`]Z�Ǧ���ۿ;�u|D@���R���Z?8M�(�Ja/W��@�²��Nn,�����"�N�R�/%����������e����dx��Tt"�m����V���O�я5?�#~a'��/T<������V�M��>��${��+���~o㼚��q��� �Qz��`��z\�]�Ќ���Ib�E��Y���>�:�8��3:;�Җ�+=�We��t���@�8�@l�N�[���s��.*�v����![q�V䯋���V�W/��C��ۄv!�2��r�*Ed��˨�O��{�!8�C����CQ�
T�GU�����F�/(?��5���� ���I��z���f0� �d�@f}������e��z%f/������V��X5�w�a~<�R˸���GG�|�ւ����ڍ��6T�߾�L�L���3��A�|jtU�QٔK���q��]3��̫ �V�{iAn�4��*<�b�=>��<1�o#���Ӗ��V<.I���ߠ�Ỷ���	����:/�+j���g�T��F4FSv�����P��i���e������b�o�1�N�o�Y)�{�XnӬ!��Y���y�TQ��h���<{S{<t�6�MuW���+��oA^1�8Jc�����}!#M��X<Y���
SA �����k�ʹ($��%E@+��e�}����* �aU��#��N���V��`0!�Df��h���P���x���S �Z�@���	-�d��|/#x=	�����0��2y/����F�v��&�v����n�����H<��`h�=��kJ�6 ez���3��0IV�-ۑD�lf.>��D��W���d�h���A����,��~o���!T�_�㨏�<�7�G�'U�����B����_�`^Q��1K�_�~�q���U�����e�tЕ�]�P�M�0M�jo���݆ƹOF�'��g�K��M��bTT�T�b���+R� �������+��B���=�c`!�i��Q����?���{��͸C��g�/�E����(i��͂�K9�Ț������<��MB��6�UQ�޾���܁56-�������� ������m���Y��Mz��v��$_��L:�Յ�7�d��OI�0���I]�#��`A���<jbiVXu4��JB�i:�/#�.ߊE��g �����$�E2�4n?4^��6��f<^`�X��Or�9(�:5}�[��n��q����|�i`����;}��&a����޸)�����x@�^
{�Q+��,��&��o�}|������fˎj[��s�W�;�DSe�@+zщFo��A�V_�k��=q#"�VXf�1;���9ǘ�zp;���뷃Pl��%�'w�~�Y�$p*ܺ���]�:	Tv�_jjr�<5PU�xvL�����+�IF5����2=2y�]h�ttFng�&���!4�_j���m^h���)�>�!B+.�Z 
���0gz��}z�S�9�H\���-������w�����Ǟ���?�����g��b�ohl<� ���a���'���#8�, ��lZ�TC�O����[�Y��2���B���iyni�7xW��m^�g����_�Oǲ3h\�u�@3p���6�A>�_��3�`p�l�0RnU�t�@�bxsΫ��H K�fݺ2�P���5���rA~�5G\�z�=��pb�!z.��o��I���H�F'Q��{�MMį��� �� 8!����7,�+��K�w�b��p���!?�5�d6�7��RD�Ȏ?:�&����-< D�����H��-�%N��;�[�O��ґ,1�_"`jp/��/����?���yt7�&�T*��0#'Φ'Up��O�0��I]^�+��c�<ht\8i��ch%��?�b�ל"S�X�uI6ת�xި��n�����x8���G[��c�!'������|��a��ý����% �{jt�qY��C<���!�i�¹�_/Wj6���Z}�-t�B6���z�	�fd~���h��'�a�V�mi��[�|Ò�����d��-�52���~���l�}�<��܇b���<%��5׏�#V�zMB���|�y#��}��~� �}�~�p;)Geߋ��!H!�k�NB��ك��p�ζE���g\���L���n���bK){h��js}�Fdӯw.�B��~z<�����i����~tȊ[����X�ӶZ����uc���G�3��L�ƻ��̧�J��o{��l7գ�g��2��INo�B�R��;�	�)�r����-\������ʛyuOCCf�(��-��Ӹ]c�2�����~s�9���� ��ѹ�z�J��9.�)���g������F���<���Ie2����V �|�q>�&�l��p�,��s�禝�Dy_R��e͟�,p��S>���K��𩐕����l���-�x��Ţ�u6�1�%�y�EY��_�@=a��+��~97VW�
�zG�*c�(����0���*HaxF�-�e)OE;�O���-�Y�|/}<T����V+�9a^�I�O���=�d6��g�
"F��Tͥ��Y���@�����(#E^�4�I"�OsV嵈�JZ���"�����_�iB���j"�	����X��6@��p�>8!�యN��F`ȃ�W"z�=P~E(�S?.����Ƌ����<��.�����:>�K>!��&]H[�5���8��P�Ⱥګ���z2Uw�v����ՇH�8[)���� ��?f��cs����߬ u��y3n1�����>�9����O��(���;v^ĊA�;CЛ< mpGq���q1�߿{;�*������v��y���i��?$��]�+a*
�z��:�4�J��
R?��.T~�����߬����UQ$�MIzz(
q8}�\��� �9��4Ǉ�b��\R8�:�FƄ�,O���&��$MDw�v���x �4/xM��P�TÏ��?��~,�R�b�X���
���m���U�
�������c��Ӱg@x�&�������~a^Z��C[�T�T��/�����������m�0v�Z��zr�b=z͙)��޺�`kAj�U�{��9�>�ܦM���%��� ��U�:�hO�x=�;?h���	����Vv����k�n������|�F�W]��2[O�*��P*K�n�۳}�5G\�C�6�}�]����<��߯�G(�����YE�����%v��!���i��N�3����:��P��(���s����l�1���#D^�T�z�CE��d��A-��=�A����Czݯ �����hl�A:XC�y�`{�Gx�}��8��������Ǒ�7Y>�.7����A�^}�t��0R���Fs0��*Vᒆ�gě:�3&���0ߞOĀ�x¹1͆�� �I��'�����l}�y��p{<ǃ�g4��9C��ͨ���=�V��N���ֽ���#f
+/��m}>��)��}���;����)1�p��_w�J��pv@xa�<��8�{��pWb�z���$sL�z�S�ӧ�u�r&l�+�{Y�N�o��i-1    ��=�PKx�����D�a���/Yo3����� ����V7�{����*`t���^c|����Ճ��!��P�������Zχ釯���i*���6�N��aI�!4�o�j���-�������_/�!TUC�� �lC�	`Tm��>�j�U�'���~٧Y���W��mbd8��M����*�=//��k�W�A�]���J8� ����?\{����{߈sw5[-H�C���r9��p�ת>��T�*�G����3��D��p-�E3߄ʰ�(&��Qrz�u9�+��?9r�HJ��?��)1O��x�'���,_�`Az� q��(��0�Ue��Vl�2���U���FIRW��B:.��ў6�}v�+E�D�-��~��������W^$��揞�4�k�O4�by���भ�x�J_�bT��%�\a./i����d{類J0��/\�`�6{��^�w����F�ٛ߂��5R�g��7��������4Ř蠧���7l��?�6���O��Wk9��X��+ �*�48{{n���@r���}��0�H�/��S��<��]��\K��������6��y�a[��z��z6G\V�Ge�B	*��zu6�����MƖOYǹ�ߺ9���4�ݼ�
�\eK(��-&<L��ɿ�%�T��R I�m�>7
�����c�I;'���9�+�7����?����d���,c��?�)4n�u��귟1|_��*�"�׳,c[�O۶uUqʲ��]��{%� �������~�wC��cKuN� �~M�b&hmi�>b���Hdx�OE� ܺ �;�~^ w����e������l%�r�l`<	�+M7���M��.A��R�ж���eR��`�$z}`$�����G8:���'��=T�^��m��$��{ӟ>`W�hO��uT#��u������3BB��d��=����"8��c� �a��2�E����υ��}g��8��ǪL��ݎ�[�ȿtjܱO8�	���3}n��� �]6EF�w�=:�X�~�D�nq�W���F~<�R"d�q�{���8q�,V�1R��yڕ�bo-��N�� �9���ÿ7����r�7h�QK�&j"��l~R܊�=�\���β���Ʒ����D�M�F��� �0 ��:��C_��ZA��K�@
����	���򢐍9_uM�:24��)��%	��RY���W ��
pn�[g�[ht�ְ��:�C��P�S��۫�����\fy�ޢɒ����S�M�I:��7�h�Z;0'1����iSy��t�ɗWr�,"�wlJ.@` �R�m�6/���40���8o��vaJ���aѪqaT�ctղyjzW�3��\)h�>g_� #���$ck@*�;��N?���d�|⡅u��+����ح3�=�c��0ε��p��u���9���}�����_�H�����}�@��T"a��QT+?;J�{<g}l��\�)]���rx�j�X��!�����nK׬W�v.�3�� �g��o�a�j�� �z�&<g��]�uU�Φ]�Z��ܸ��:��q�B���i��t0p�,� ����#J�����%�P/���R����Cs0<qu8����G	ۣ�KD��g�q�S���6�}G��"Yߛ%��y�ߦ�K3D+�����������u�y%�����#��M�+Ql��qb��6 Yp��ԯ�=��a�Y͓�HW���j�pf`�"�Z��捿��LO�C"#�?�����y(�؈��%{^Z��Vz�����2�o����e������;����5���«�i7EI��9�]��s��]r:^��W�{i�~���f�HQM��R'%kM��[%��7�o�12�g�*�ݷ�Gp��cz� �&?�֖�� g�DB�go�s���^��G�v$G׳^��]����$eg_�����5���^�"��p��b����!��sw��盜ˊGm� �Hb;��dW�$nx�����;<1�ь��i7XC۟w9oJs ��1��ŗ��Tqx�3�g��q�0�f��a�(z�(�E�4ל)�2�}���&y~O.W�U\���y��P7Z}���� �p��}ag'�~-ć27U󅳲���,�`�?����&u�1'A�A,F�yK�k9�WA&�31���.���_��i	���a��,l��|'AY�V��Z*�5H�37� �(���	���҅Um��|���*�z~���c�cʯ�Z-��+�� 6U�[���6��nJ�d�drj�"u��|�� �����ޗ�Y�1q�͊B�$�u����]��it�?�4b�>���;�W2�� �y��5/�<����..A���_o�Uj?�Z%M���2��I�O[��&�&P����� �W��i�!0�p� ".��f�4��u���F���|���Ҽ��Q���y�W��iiI�x��2lV��#��_��<ә3���|�a�ϛBz�9^����Z&[�d�A<��̐7Q]�#A�� �c%��zPG�ԭ�3o3��c	�ua���0pr��C@�L�g�D��Gp�뤗�_Зy�8oyOA�ي��4�8ׄ����[dt�'�ft8��P�0:�tV�����2�>,Es�{��u���%� ������4=�Y�qo�V�c(���q����#���JI��M��!���$��%�*_o��j0\����A���h��Ɖ�G���$�B�cV���ӽ��q��lR���~�8�[��Ω��^3�g<�lv�*�<3??dgkB-O\�-�ٽ��rA���3��j�m� �D���ɳ#�dמ��	�⛐���.=@N���\�i�I�>5z$�Zo�����XH1��' d{�(F5 �Yh�8*��r��齴��p'=�5���co���V�亯�_��|���H��O��PO����
=YD�dB�	A?(�����������t5m�2qa���:*>3?�<(;��]�r��5���.�Ԟl����&�����Y���i3I<9�v��%tT,X�*����I�j] !�E���f�x�<U	=�,�-��YY�tim��h�A��ޠU[�%[�*�	^O|~M���͋�^<�ȁ�E�$p�{;��U��X���}Ե���&RR��.<U��;"�5چ�� �?`���}�"��3�(~��<5��3ɒ�yx��eU|w��6J�x�������J�{����Y�_<�⬌�7�.���8Dg)��&���-�$�ѩҟl�~j`���vS{I�%�\��g���˷hA:�#��<N�š@P:c�[��4��TkCs��U[ϯ��5z�"���bp��%��ֳE[$�w` M��JC�7��瑐�#ˈ��F���|*��/�� Hr����n��$A���v��*��}sz��X��Q4%ES�qO�L~*��pRqv����nĩv�t�$&��o�����[6J`�W���D��^G8 ^9k��`�>7E��Q�c;8�7MΖe�q1)l��J�����I�ߋ�iq�n׏��=�RM�X������={���+LP㜾~L�f}��:���.���Iv�X%1�/R��#���J&��Vo�>a7���]K�/~w)^�io��^?�H�AP��>a��{�9c�B>E���A�+7�8[�.
���	=������l�.o[,4�e�Vt��f���a&u����7�`y�6���<􋱞7�ĕ"ev:o�5%�$���8���j"a<;���Q(�7m}Fz���{����Ϙ�i;F�tr��CJ���R���(�y p��
�'H6��к 8�������#�3� b�<&��#�u��S�d���2m��~���}c��љ�1':t�V�zx���.��kr��8�+��_�g4۵�����(�0'�0���q՚)�6�3�:��E����:����kft��Xn�ۤN�Aϡ&�9����,����.�<<A>>y���;�Aj����.�����Gk���d�鼂g���M�N
�=� �m4�t�&#�
q#�Y�    ,��������KV'ѝ�㛮��n���[š�}�r_W�Y��T�������w�!�7<�[�h��sW�2�L�5��E�՟bba�2��F�W$�$8�0V�c�O����X�l�i��6$�
I�����\N2}X��d�!^�ӂ{Z�K9�^�&`&d�%���������(�ϸ֔�2a��Q`\f�����;��M۫
@�M��^�]�^���Mp>V����������![�(lRɝ�I������4AL�(!����(͚8���	�{�A�� v*��k��6ս�����l[SG��:(�"�jP;i
A\�>�E�b�\.l9�Z"��<?�����\z�0��'!���;���w>���c�d�;nD /Y�D����ݶ/��Ygb���sQh$��Aw*7IQ�,B����l��϶��2�"�8)E��%X:lА��H���	��ڔ��*��Vl�$�z]��v���+���������Ae�\�kE��6c5/�Gw����B�8�ў���u���qqST9cp�p��CW(1+�n�nB�EA�D�9"� ���.�2{�9���+�ɶ훤u���T���o��8/��+�v�#�|%Q�ű7�)˾)��G2{�M�3�7+���� p��眆�_���O#N�_3�h�0P~�/���O�u��ݨ�L���|/�I�1ސ��;���+���8K��능dp�T�@��<�YU�مF�pf��|��~Υ�����ۀ�o�x9���@� 0ᖘ�9���?{��C��@������v�F�I���*��ͩ���c�����9YE�ww���)9�R4A�ۼ�+�]�ҵ=�V��|�X�GA'@*�.�#>��A��|-DS����iT1,�˝l>�;�ź5��Q�M�|�x��� J��gVo�?�k�Gw�?+Y��|+ʗ�{逻�aq!<K�ΟoY|Q֥��%���k�b$��ވ^�/1M��Hy�@�OB��5�AP=�?��c�{�/lo�\�X�`��G^4���U������;�8\#{��)t��t5Qt��Ʌ�G+$�^��^��b���!����zk�[<�;�uǖ��D|-h�Y�[�~.�T�h�H�ee��S&AP��6g�;s����8�^�x� Oz0����K�E��\��HE�"�q]'�ET�C��(؃X+�T������O���ҀC�k+O�ޭ��k>G��a����0�D�Ԉ@^|�o�ߌ��TV�Z� �����*��e�j����x��{�r�f)���=�G��1�Z�R4t9$V�&�?�ӁC�� =�cҘ��:_�
�#�nR�jו[��Z��T�i{��R�<�&@�a�v��M6b����ϷP��Jz篋;����s�z�֙��
A����[����hF��I���Z���*e�4��^f/%(�>�8�a�=���U�e�ߒ�E,VIE�1�=cz�[3{�WW����X�6\�/����xp�$|T#�d݆��g��ǚG�GC�w�9�1V�r7�}YF²��o�I���0�.\nC}���X|n��V�Mҷ����3@I�5�wǉ��L��Y^�P7��*�]�>�8���w{2;<`�V�<�^�ԷM��rmٷ�|�*q&ʘ�E�\�< Vwh{�
��MA]�O�:#�=�Ls\��4��9��
�I����\n���#Ty�����l\=�j� '
��7���B���Ps4Zh���Wω)�����7̉K���f�6�U�OB�S���顼�9 �/]/����ڂ'���7t�Ó]f�Ӏs9��3FB�J�ϩ��K�uu��@���
mD��gD��TZ݋�W��sFU��S�kb�=4���N�m�aQ^�gX����M���I�뇫����8�dyY��������'!vG�_�m`���E��D�`�]l⋰�)�ݣG�`���:wsp�go^�<؅�.g=�z�&���ep"��O[Ր׋_W���� ^@"�?��i{˅-���7M�#܈�/�f�B�0B7�z��e4��_��Ȯ�ّw�� �aД{�	0��)pÇ�t}	�X�{+�^�怢 )' ��go#X�%�^���ʠ���
r���yؽ͊�z�����-�¨�^\����Ѩ ]#���G���u��i�>}��V�+�Y�>����]Tvύ3>$>�����Z�'��C?Y�����E��A<��t�����Fw��S� �� �<�d؛���4��%�"l i*��e����\�5��N����^�jL��� � � XM� ���S���y�<>�Bߑw�C�}'���\L��^��3�kEu-�ǎ=��,������e7�=9��s޶��cB�jv'Q)"�Ց�ۭһ�Z�����.A�K��\�[��D�E{�<v�֐�­���ão��izM�+A�H���j��S�2�w�s�+*�;�.�zj:��ePK�1���=�9Ε���w��we�]�������d�ϐRC+ubu�:���j�LR�I ��%�A��[���wj<���
�W��3z���
N��7�L��~��:����]|��iU���������ˇ޹�y~�Y!g�ũ��A��îg�_^T�g�<>�G�c쓾��!��2�?�?��pʶ'5NZ�cU�0��6(�ܭ��w�88ٕ_ޔ�Y��J9�ע��r0�Վ)	���	IT�ӖĄWC�k8���x�']���E�3����Vj�}�����{%���?�]j��u�����_9G�u_w@0����N��[=^�Y�g�S3#���5.ɜ^��P8�����_���W�"�v�ձ��4���ra��}�!VNm+7g�>2��l��Y��g� ܦ�GEi{E�H�3���"W�kl��7� �.G��g��F�����N|���A]܇@���)��w�T�76Ɨ���Z��ǵjU�-�G:��G���ߵ��w/u6E����j�P��I�?̃�]�7�/���;Q���-��(J��Ul&�'ad�v�	���p�?�F��� ������k�]�q�N��n��s
A���Z�wV��^�#A�������p,��8������A�9!�+�-Y���j-&���0�U�,\�N,���w���,O�$EU���jj���q*{r6�;9����p���>��}N{O{K�'7_kku�F�A�������7�q��,�V��u ����ڇ31}j���2�;!�.r�O5���k!����*lb���	��3y+��Td$,�1�:J�*_��z^YOy}�ʇ3"�SS^����r]�쮁�T�e��)H��X�9��hnr��������4P��1��R�3�Bg�c0s��� ��S����7.(��Ssu$<��j��{ޥ���؀��K7t�B�g+B�V;I?Ր�>�!�oM+���Ȋ�	c���ri�Y���暟Y/��W�<A��#|ft��/:����+����a[���o��I3#3[��
W�%�e�˖��J�p�b#p4�̀���a��^�ȏ�K��|�*�?��3;�Pv���l� ����\�K�\�p��h�<59S��B��'?xB�sC����<�jH�A�5�,�?�xX����nB��2�y-��87t��G%���a>x��D�40Դ?��ŕo(�9ݒ��ɻ2l[�ae�?T����C��%2:�B�sSQ��K�������t��b.'gUX?�ue��0����{��rs�qJkϸ�wӰ2�?���{��]�D%2�(����H$�Kv\����/�ɘ����AvҭH�;�[ ���D�p��ڝ���vi������p3��f}p�(�� ��^��DW��k�^uM��W����!�H �7-���m�o&g� ��æ�7�d��%�F��'��ؽo<^pU�X�Qo�
��ER�=�D1� �'�ꙛbpD�SHyP�3���qnVPZ����y>�{� �g[�����;�<��K��{��a�������h<���|y�c[1MO�ݑ�    ��z@�yԞ���TɊ�bk��d�����-E<; ��������TW3���u>um�<�?� �����(�8H ��M�9��R��TuY��?.?C�a��!H�u���j(Á��u�m��ܓ��!II~Q�$��O�~�����HMJ�(�UBɂ0������L�L������(m�F��d��|7����Ԭ7��<����� Õ�dW�ű����M�C����f��=�k1LW��y����YԆ\co�����U�;o�n��iú��y![BMB�"_��o����>�G�ESe����quu��}U��\6�z��c%XR��Y�}��}��\1e�R�A�#���>���*��I��nϗ)�4�v�����-#�<���s�ު�U���I���q��S�(f"oi����耵f�y���᫩R�Oƨp��'��o%Զ�[��yߨ�(���(L�#X�� �e�S��]��d��W��^���~�zZ����_GP<�/�1H�xvyY"ˑ/SΌm�9�L>b0�_=�1x�6�6���ֵګI�%�M�٦߀���ikH�ܟbi`N�>;n�Z+~>c��
�`�BP#��i�r+�\F̭o�>��� ���c�ݸ�ol��#dT$ͬ�x7??��%��NC�߮����Cr�o�2 Rt��1zߖW^]-Q���8g++Z�Lp�ow[ۼ�R2Kܔ�Nʴj��ѝ�����.�"��
W��RD�v.��Ḍ�g�����~���	���w2lyslq峢���R�4o0۬��,��|P;����b�Zڪ%iZ$l�/6zj��#���8p-���*f�����#�R!-q�bjM�"]�Ҳ5@l/�k�(	�^�L�/gQ��?���xSHz�&I��� �t.��׿ꨧD�:*{���@-��>��1ɰSO���~�m��P�4�p����[�����e0殍em�,�.��K��u�H'H���IP��`,WyR")6Hfy�ivɃ%V��.�j��A��DJ�3'�wG�>q(����cA�>V��/~I+��k'}�ʻ��vC�1�h�Kǒ�&���U��_;a��J/_�~sx��է����Y�;bI&��ԫ���X3m�F�N�o�������S^���<ʙ}�+����0ҥ�䬣8�wDwGu��Ġ�{5��/��"'�Ȥpd��l��t���
�O�����ʿ�;>��W��T��ʩ�	j�ʎC���hqN��@i�3����w=��ϕ�qSȪ����q��9�x�X�wj��,�0WW���~;�4-^��Ҩ"�v�^���Ap{��B�j�}k2�-��F\wU5��]e�����������;��^\��P�E>�qm�_���zgL�.P�e�;�k
�W_	�g+�GER%��<Z*:�+��s{3Ol��o�5{�ij�+p1����k���B��W��KYW�L��GZ�R4R����,�(q��|��9,TH���������g�d��%H��x��~9'Z�ow���/����wʄx��I�(��t��՝�������I��3k�[�׾�A�U�Y���<<h�-�m�O;��5|{��d8G_؇����]�� ��Qԅ��aT����� ˵�]���j|�!���"�X�7No+��%�/*��d��)}�� �����x<ZF]���\��=(��)w��]�����.��uɞ#;��JP��9q�$��B�U|���4�����ޠv�4t�ޠ���	������ l�~��p���c �3��i��⧋*ׄV����$�A���<{���Yy��;7Z�4���ڝx�Jܻ�w��q����*� ����������y�@m8;q���G}����F,����� ��)��k#�g�k
[0��7���<��~:��%kG��@{��󼒬���F�I����7�	�y@���jqATՁ�*�ݕ/��ь��*?���7� Uq8�Z/4���^P+��yWn5^�ĩkrM��79�K柙S�/�.��p3ezx������������K������MI����ws0:`��~�u)��/N}�����3��2;Z/?w�!��7B"쌍#6��4{"�;m�E<4,���� M�����#���[�&2NF������Z��]���o�)'��T��!��_f�s蝾�M8@�w:3�s�]���M{���g넦5pڲ��>~��5/5�74追��7���"��>x�u# [(�g��NZ���a��|ZJ��š�M���x/���W�e� \nWF�se�k\b<�A�Ȼ���8���`�O#��˶�R�|�_};y�1�I��u��cS4��R�p�,��$)]L?.���t��Ą�o���1�����꫆p�?����i�V���M+',���2����$���ַ+8�܅���@-�>�KUr�v�z!n5��������&�r�]�<J�NH��QA��S�.8���u�`f9��pY���n��#�eX|���XS]�P��I�΁�]�����8��y{��m��e<��� o�0P�O7�g��1���xg���^���R�� 0���s��b���m�N�O��w}����������}�됹���J�s�����"�j�>������.]��c�;'0�vm{����6�1��:���y=.��� ��T��&Q���ra�M����݆���d����ӽ��^;�I�@�n7�%�{�D�YE��Q��#C��EM~0m<�iF o��e�4ڎ6 ����cw��E9,��>�B#��4�J�f47�.lE�z��JS�����z��)��̸L����iGi�u�/Υ������,�����"���#9���%�3��,˫� ��e��M���?���x��2� N�2��]?��Ub@b��zD��
"()��Վ�a{��}��U�,g~sb����������ї L\�{p��6կ2�4�\�mR���y��kMj-��p�>s|���Lʛr���@r�����q*���P�ᔗ2���#RLu�u�����a[���7�����󣮂0D���8���%�V$阢f�Ez���X U�
���4	�G8��Ck�k�/�.P$.�s	l�y�vi��+5䘹\s��g�Ŗ"Z�x�[��.� �8���T������2��#�f����z�c]��Y�w�Poiށ��.��n�ޓn����I�����!/�w�Cp�SV��������Myb^u��D?b��kJ��:��Mw;�o�ߊf0�����/��Mt�׮����7�Q�4̆������K� �p����4�x�����_p���\���7��N4UK�@���?~�S��ۼ���
��1������[��2G������'�������c���O��G%=J�H�S����bh��Y�h��!Sʁ_p��n�1��_�R�z��H�?�e�^!�+>�=\>P��~B��@f���\^�jO���Ԝ��o^O
y]�T��5��ȗN�� 0�ʍ�[�Y���Ԟ��8~��yAX�xjEJ��`�^�$�������w�6����E���v{�|
�V� M\�n��A�����0��_����e�l}q�k��i ���T$
:�V�n�+�7�C�(������EG�{��hzd��̟+��4��-���=;���ňW�D��$��7\	:���?��c��	��a�1�
���G��z��njK�jc�0}��LZ���mz1�神�>���z��MD�O��{���ˡF�h�2��>������B�ϗ�j�0g��(_5������ ��/�;�i��2~&�ݗ�;��M�z��9ivfu��-4�-3o]�����tI�`&
Y�����A��h�9�2��^�8t�%�8
��� �_6��?�c8��x=Lq����-�O��
�ƄS�sq��s����m�� �P,B.��o�~%0��a	�B!�%����Ľ��u'�Sȍr�y��}��p�/z�M&��c��_�    ��`M���ݯ���:�5��:�r���3_@�=�&I'�<��DB9���y��zj�Q,�s�py��*�C�����ȗ��zQ���f�|Ep�*wG{~zO{x�+�n�?P�z�x�,F�Lʔ���0�&B��zy��Si����P�<���'�{�b���-�wd1{�_������bI�D?h�$�HB�$�-����̪�=�g�to*���d�w�pw����%�=��'�NR�P,�.	n��}>���ת������x�+q�
o:�k&�Ks�/3�(�����tc�.�
��&Pg���#�����(ل9����%�޵�����so���� � v���ގ��j6�J��}����]ޥ��As�w�jG����f�������cr�m;.�<c~�b�!�Q6냁��j��?z}#֮a&6�����I`��K8������/��r=����]�P�O\�S��>,�j�67Ŷ��N�%�Y��y�,���a����{�i�bڥ3sa����cs�_`fn:2��2���Q�Wl� Fu'����48�<�U�S�9�U�)�����w�6�M�
"$@����l@�^-�i��G��4�*R�8N�t;gz���hk.�Vo�۳}�����R�*G�,C�,"�|"�>8�e���!.�/
��'I���/MQ��N�	�w�ړ�Po>qi6�O�$C<j��q�!��t�V�+��0�IC�ĳ��7��7�(P=��<:.y�2_����8-S�a:��@�I(�n�x�ԧޞD� `�k�RX쪍�67Cy�n�n�@.����.t�0Q���o;�������h�0���:J��!�[��s�mѻ�_ز����FӺZE����- ���@������a�kX�}OKXhmk.�����|���r�54��_.R[���'��σC���E9�y��kT���d���Ʒ����$�(�gr�QD<C3��tR���l�*���ۺ���^��;z/T�k��i�� �뺱�#�*�Kt;)o���	@�Az����~#Cj�f"�i�1��x��'`�4�_e`�M6�����N�o�e*; ��Aߴ�#7(ų���1_�{mmS��{�x��|Ra���v�S��Sيb0J������]y�6�("L�/"�_�5��\s��%���Z ���QR,/�"�ӐN����݊���.��P�\��}���+d���O�$6e�8-��+�K������Gt50��4�7i������n����y>n�T�O�H���M.�FCNh�]`���v~<����^�5m�Y��f�՘��i�i�O�_�y��ߖ{a.�eX�lp��c�������H��.�NUC����i��M�d3�;�N�.7�3��ao��X�� ^bbq������Qu�<�0����g���D�|R�ʌ!U�6'�����b����۟>���2�m2s"!��v�"�A��0c�:�Cx�Nj�҂⫚NA�����(h �%|8��h��_��]���OT��L@�jE$b��R�� ��0E7XBG�-)���R\o�Ce�,�7�̈KA�5����0�ZDﱲb�&�7$����7�	���W����d�qY���2�ߟ1|�b����PΘl�\�q�7o�����Z6gԉ��\�vc �$����^����oY�Tԭ�ӗ�.��C�Q�eaa�'Mg���i��V��z��_����|��CA ���p�9^��l��q�o�E�Om!e
���`�^ y����HTnq��b����O��7���ހ&x�HA³}� t���i)tA�&����)�LE��2�a��`��Þ�H#�U������:$�r��m�Z<w�cը�wk߃���N�p
eY�?q@�do`~���W���䣆=* ƕ'�1�e"�]���͚TALp\�s��1=^�E�c������n���I��5}b<6�T�a޸�t�7�Kѯ����"
�6��A��m�0��k�8��:߹������g�	�܍2�:C;�=�(m��:��j��AW��C9V=G{�2�"��V�:��Lqp��,m�	z��#w�5��Ⱦe���DÅ��h"���T&/�1���''�zY���9}���$1��i��o}��-�^�hIoʉa͖��Amf6V��wjQ/�l��'S�����+�?}�)<�oT�8��h�%rƙy�s���9��08�Z�����6��#�T�8�9��gm��8DO�X��#c�e^�\=��(���z��F���5�EY��;��$y�C�-�>�3���q�A���|��7u[ A��]h�N��Ɣ�n�a5B`6�
�I(��5���3@7;ۅ6з��k��9�[��l0�:�{x�L��p�k���VzW�!�:y���T�����k(��*Gw�<g�.o;�V�h��@h���{ ��H-\�5)��h�i�ݼ�ÂdR��"(��5t��ڲ4]�J�X3���n+Կ�:ب�YY��n47vJE�p�A�mm��$�U�|6��A�<�zE���0�:E�fnE�2:ξ�9�{�4ye�V,в�tI�*�	Kߵ|�Hq`2#�����s.r�9E�X(y�NOg�eJ��|0C��a�&�u���`�tM�|��fp�I��P^,���r3�O�4�X� �	
}~H<;zt��U
��ay_��C	��r���g���?��$������lbE�=~�i�T R�sk$4s�-�{��5��c?l���D�0�ؿ�M$��t���rk�$�GyG.s�����a�G3��E�-�߮Oz�0y��l����%�v��&�حTq��{CK��
\Nm�8�L�ESФ"�R�1���ƈ�_�7a�O�2�f*(;����|e�������ڲ<��}��T��~E����+�!`���j,��!�Cɺ��j�Ԑ.������2�fy�q��z���u���z���*l�^�O,���c���1���1dxf�-Y���Fb����n�ύ���Zt����ڢl!8]����R}�kb+@�vG&�Ǥ��g���Ϫn뙲X���>?$�(8e�ǆi��G�u��+T%^��b�ƷF��U�h5d8�s4Z����ي����},abs�J՜aL�	�l.��s�C���&ߨU�o��q��7�;͠XO��F�Ϙ,`�]�̯�$>͔���o��N2��+4SQ_�z���+@��� �'��;�=>x` \�,��7�ǈoJ�*c՞��+�������{�i�]�����?�yx@wM]���tq"`��0����{�l4#�[ˍMYt������{�P�w�c��ǂ<�`�m�N��SEfS|�?���2 ���U��@E�q��(60�fHܽC�k@��r��gH���|a��*����;�"�־+���P~.��8��'���c��V�����jٰk,�b6�t
%8V��!w��K�Wp��g<N��>}"��	�ښ�{-'+�5���pt�J�F�' ӹ�'�R���n�<����3}�o+��B�mN6v~3����I;8i�PC��d��~��	��(޵{R|���'���f��;ܜ���Q�G��S���RD�8��՗�C���� ��vrm�^W�e���t���������i�C8�}�_6T�<��N�yڟH�84���0��(Vc�Zc���=�p�7D��A?�e�#9ſ���k��:I�"R,�R���7.�����Nu��E��&��Kt�8��'�J/�̺�W~�"�(������;���m��}�M�6��K�h��t��8D54�me�,�c�%�-���a�,f��Q\.ި�����J!�v{x�;63�)!�����?(�*@e����i�H�N=��5v�"d��K�W<��]��(��V���v�j�m7̄��G��>}#�WC�l5n*��݀��+tq��r�X<��T3?�^���ؤ�N�r�C35A�0    4���;�	��N&u5�¬v~�����T�	�^�dbS2�m�����\r����܍]�"���+Ea�1�i'��o��R5c��拈2���_R����CyW^��W�� �N�V�#DS�WEh���' ��7���Br��G�I���.}9Q?8+!/A����H�d�:��9=y���(�joR����{�6�~�R 8Y��|p�D��\�w�Ԟ�հ�d�/�xa���%�j�@��g/���*��~�_�P/C��Y�;��'�q5�6���ύXyn�Ou��k�M�s���~��6oC�99	@{��N6�y�my-"�<_���C����%}�]��"L��M��b�%�K����\�Ց�����r#���Wz���u��I�/� d�k�x�D��LАxxO��p�E?t6�Ϸؼ��r/!���ڀ`�kmMhs^J~�2���7���R�G8��7�s��Jo��Q����cPC�}�lyyǥ[0�E�u�,� ��8�z�g��C���J_E�<����WXm`�t��d���8���)������y���|r;&��"m�͍��(�g�}	D�]���'zP���������?�-ʛ.1�1(8@�]#�@ovI7�b7Aż��ɛP4��X=��WbI2�R�ah�,j&\� ~�c�G������V���ݯ�S��-���KZcPͽ��5�`U��OB��"�Λ����k��ņ{8�[˪x��f��x��ܔ��K�%]/�c� x�LXl���9��r�6~���>rS�KpN,.h����r�H��+:�O<�
Œ�.�y4Y'߂���<#\� �y�;z��]bH���b��_(����Y���3{�ߊ��9��[dR����ӹ�����I=�=ǒ=�p�@��M�ޙX��3l‸57����d
c<�T����5{7:b� B ¹�� ����ww{��e���x��N͏�8� �uI��<w5� L�X��dk���r��ϧq^�JXОW!�_M����������Ɂ���<]�w�4=�I���n���,6�ޥ��n7�T��~v�Jʲq)�CE"	\��T�>�j{��d��q\C��ȗ��>���\�U ��R��7/q�?f���G����l�c}t?�Ը��!z�@�X3,X]dzvfl]x߷��|�!�VG� �n���jj���>�`�8�����!��Sp�Ϟ��}�~�7#1�8{��Wg�Yۨ���^��g�Ҿ�>ս�Y�A��_	�t�6�j.����E�F��Q5�Y���l�`u�>�)V�.ۡf�Rh1�L����U�]�jޝ\�7Q��:}�TՇ�&����ՠw�8F�(����,�m�)ZK}�?#���1Y ɿ�2ݰ�QU^�d�Ȥ�F���Cd z�eHw�f�����? ���D�m���8����E<[�/�a���`�x����w���{�����~��9dکC��O�e&�^3�eC�*?���"���Ϙ>V���5c#�,;�w+Q���=�ro,i�)�b	 �5ؔDˢ������fZ��OT�L�d�[掙���I6'>j�H��.�����ժ/G�����n�
t��x�&W�f|ϓ.F��Lg[�P��c(�ğ`��|넃D�R�2k/sݯ[B���j�~b�M|	6�?���>��!��������`��M�y�N�s<d�4��Ƥ�E������״I>�g����	e`ޜ�����׬���"�~���bYU��w�'�\�FF�?�t6�pME�Q�J�ݻ��y�΀ �E;=����7dno�m�T�z\�z�n߸���h��+�\�D:���Q�{�97��Ufңu)���UD�R��3q%Ω�
>�����7�h��2�qH�#��0E6�`|M�^������[&�����Qe���>	$�-��sO�L �BWB���X�3���e>z�S+�F�Y���t�2���6�W~M�����7�)u��gn�t�%jK^��t1�D\�1^�հ&���^��r����{��~|s�m{�j��JS�Y�F�ވ%������\%R=y�������rz"{Q�`�H�w;6�S�G�I�e�C�]�(��/�t��DR���w4�u,e�վzo^�?5Y8`� �kj)v�1��F�ʤ��z�.3�53�E�L�����3S"ڧ��uMp���I:��4��I˥�Wp �CZ����W��Vk+�` �C��U��y����e�� �8��ǩU
b4~ڈ��1O�o&|	�0W�d��&3� xC�^�eT��1W~�?���C��
���(!"�e��!se{Bs �+5�6�Dd3��=�%��:M��6��+�@/MgV^ �p�ޖ�¿�5|�^냌�� H&ա41����R
vuiu��t	lL��k��π�����ĕ��gu�.��6�ʣ��Ϙg>�o�\�Sl�O:+Rh�����6�"���t����1+��q3�f�r)�!�aSF�°�^�>����MZ@��|`�b}簵";�^ŷ}��O��_5�K�����Hc��`�3XN��ydK/���xY\�
'N1�Y��M�7Sܤ_}���l�A6�K|��|M�����h��8��}������B.�b��^PZ)�ùS�51m}�/EAC�ǂf!��_�50���/a�jn;y)�����虯�����6��{wX�G��>�`
��}�S��Zn�֋wa�  j�UI-��`�r�iWO�%fW��;�_���5X0��?��E�D��������#����Z�k�p�q^��9��{�@��gn'�Ʀ�|��]c�?y�O����D�r�����˲$�"�l�4jT�d��H��3[�:1�xf�܉l>)�'��%:O�Y����d��ZF��n��ؖ�4�$c}T1&�ߒ�K>�e�����k���n��a6e���q��3{�=���h}��;D��n{���V �o���ߣ��7�3�2�U/C��
��5���q;�m�(~~�����0H�l8�E ��9S�8�bA���3߼1ĘJ����7�F��5���[��}�)
&���OPQ���[�E�W�Ď�{�0K[�93��ϢX�͊�z����{iAyUװ�٣���tN�(d߿�&n�y���ϛ�|q�U��A�����3&�Y�L�}�T�3L&���قu�C @�1�!��.��~kN�z�KB��=�l����EGB��~#
������Z��7����7���)���ӟ\�����_��CR�+0>�������g����s��<���V (|�H�2aq��y?0�R�^�HC���.�H�2��̒|�~�{�M�z`��tu�DBԧ��.C)o%T�H���@�i����V�e����*#v�7=�|�������k�_����x=E�Ob�������g<{�R|q�Q��R���O��9�M~	�Og���8��Q��W|t�j��y֑q�p��?=� �FȽ�f�`����^N2��]� ��C�7�+�s<��g
9�e'������Ӳ�j�]�o,>��:�P"'��庸Z�1[�G�����&��N"�֑���~z��q��z��ifs��MX���SѕF$�%T�@�^����"�D���8O�����R����U�mԐ#��3�t=��2͈cO4�cnT�}U��)��>�X���׉����'�	f��;�r��h��|�wW�L��rR"�v��Pӣ�[:�Z%�󶶣���L��v�-�����Ee�^��mh�\���ol��=�F1���غ�i�b��n���8ش��H�L��[sW���#9w~�ܭ�B��1�,t;s� ��dM��n�pV�5�7¾�����|}#92׺}���;U>�G��|��>
8��Zv���ļm���@:�L�8�و��#�wg7y���|M�d��ۋ��\wCuW>|Ŋǻ!�9��5�-�.��wOF&	3��yY�����#%6@6���aƅ�3�S��    ��[M�0�$6��=�~ 2C���=4L.�V���o��eO���x�UW.4�P6_�U����O}u��J(��A��_��[`���Yճ<����F�G�z7�uL�ȱHC"��֋���p���{76�+��wq��?{+�#ޑX�!�?N�����'L�w�c����ɻ���o��p��歷Ci����X הh��A/#��[Y�2�2�Έ�����%�#�����"�d/P��� �*6��3���LQ"����^���GG �8Ӕ���Kw��>��m2�˗�m�KPQ�����x�w#�!�B+�ښ�[��w�2�4Y4�o^yd��o��2F��	������&���2�f�������U2ׯ+\պ��n{",)�]1G>���P��ds�7CD���S#��L�L}�}������$�7\�N/�d��W�sA�v<Ry	o��
��%��b/l�N�y�_F��W�{����!�&��a��5�~gs`/��g�����ॖ*�(����gv�sF�������<}!8^ ���W���oG���+�'t>��5��(�����U���%JF���t��\�wG2���;�l9��"�ᒐ3(�K��93���ȨM�jNq�ۨU^:m�s	y���T� U�3���U���Z��`�\�!��ˌU�6�$�p�PF�J������b_]�K�� �Of �Mj�K��0pG���`��q�:a=��H�i�F��e4��P���4w ��m���ov@h�T�;/��)���A^<�v>�E1"�[4���\B��zW��;�k@(�p�C�����t�E ��ޣ�����P�u_�i��q.#OΔ2��x����3e��6/����ם��t���M�v���$�����x��f/8���_?˧ah� �TOY(=�AX��]����(.���BK�F[��0D�O����x= c��35��^q��n��%�u�;l��:�A��o�geW�I�EI_�j���@rb�?�g�N�3��%���b;^��J�R~͊"��|gYe�Xs�Ce��2�7H)8縃���9�t��Aη`�,s��˽�+���$�g����'�/a��}�[Y �w�)���0Ze�o�`Q���}A�{y	Vŕ,T}���պ�:�6��λQ���N;�d��7��W�g�Zp�TfQ��\�n��Nb+��<������%v�=�y���4��J�ΝAxKD2�DE�D�z��w1��x9�/��U�g�h\��~~��K�� '��ڒɈ7�WP�Y�*	�]n#�l4�E��}��ء�ᡁ�Yn�U5�L��_�����wX̣�Rο[ �kr����N@̥�����$Q.C��2�	t��$��eD-��#��j�G]F��&���^DCZŮy��*᫗�S�/B�;����}̞�G�7�
��&*|7 P���so�' ����������p��{ `q�af�|������W��lBN��;�=����S�O�ݝ��v�!�ڹ�0O�Y�h���H�O�#�{�e�g�o�Is3>��ev�{���󎟷F��y�$�[��CZ�d����>���t�~"�6&�`K��_�.�s��}n⍘B^i�g���x�ہ��[�Ó����I����_H`�f������Ɛ �h���b�C�Q��n�ƣ�aE���),ɞ*��0���ps�.��8<~�hF����y�y!�r!*��sl=�?C������
A� ɦT�9�qv��%ݗļ�������1�э?��*~b�<��Z�	M��\�ܚ��@k~�� �*�e0�������~ņ0"}2�0�z�!D��R�d�	6yֈ��&$8�x0�(U�"����M��d��-���,�y_4��@�2�A�-R�[z�0l ����Ю�W�~�wM�=*���y�~u^�'�9�q��R��ȗa�Nc��9�fW�&���
��fM�?�e���1��������Ԟp4Z�@���7t�<�����w�|0�y����#ą�tP-�`�HJ�	_��PZ'O������1��� �Q�*�;&�vk �E��"��t�d����7~<���e��!��ٜ��9��O�1���z�xp��P"����둴xK��(�ַ��S(7b�K2�25��/-��Κ��jil�e!��c;�����/�P+R	&~WT�U�����ҹ(^�]����&�{�p�b��!����68�ŋ������'Rs�[�1ǽ1G(ߨ=���qPz�D�v/�S,~h���a�K���L�ܑ�ݼ�O�%Z"^"���C�QT�l���?�ðb�H5H��
r�'	��I6"�����su�; A�'{u�x��^&Z��-rJp�D�3���4��31���k��NPV�s��y���2w��^.m1������w�� yb寜{hu���9Z wM*�3$��K��9���Y-�u���ۧ5��e<W�H���l�����^��䔳u��{]� �.�3r� R6d��a,��*7�h	���/_A:�^���&�4�}T߻��;����=���~�J�w�ݝ�^0Z,}�Г��`�1�E�"�1"���qu�R�|޻TV�1/�a�q�� ��Ze�Z�d���꛱"G���W�$~9U�~B��â��_��L�M�i/��hu�$�/c�{�({�n\��82d��DW=�e�H<�KYvfL�� ' T��9/�ϰ{6��g-�'�T#��%{W`5+�O;�y^�_���1׳(Z#��bb�i��၂w�N�����V��ք�q#V����I��h���WG��H�`��7M��]��%&?���H���U���P�1��;�2π�]9�T}[Ks��q4��;m'���ݼ#����<M�B�ג�X��	��[#��b�}�-�v�+1�Z�ʿ�Ņ���O� �\w*���;W��%M���7c�k�]�v,���+�ci��j�~Ԫ�;�2|�3�8�h�u⟼�̑��i����	���d�׼(��N '���2�� B�<|��y�T���ȜL�B=�]�ߎ��L�X���X��T
˅�KJ�O�
6=�f��[ܕ�]S�:��^b��d�n!� `������K�{�	�>�Ѷ�!��.Q�!��O1^"�nW<�,a�Y�΋��Ο[��q<�D9d8`ƽV�E�{� (�O4l^��7�c��aIQ
ڪ�.L�� ���z�}	SI�[�.�#Y�ӏ���<e�rf�ڢ��5B�G��6	W2�Z(��16�[|{��K��]wJ�^���@m��$�$н��0}v�)*n�l�;�7dJ`W�n�T��!��`l�'୺*��׷��@x�~�.�W��I�T%��5�^f>�����[��8ME��t���2q���؇�q���.5���x|#%�Y F� ��?�z͋��nkB��&�-z��He�~47��6��Ŋڀ@�.��¾���@̷ǫ&��4M�m���fTc�~��l�%NC���0��d�ly�%��ū>=G$vT���h�0��5����xb&Bq0UTM�o}j��y�<#��7��-��_oo�{�S�v����e=b,8U�CnK¥ ?�l3���gL�"��#l"E�?3՗p��c�u$�vn��h�_6�j����A�K|^W��,e��!#��(��2l��E�L���W��C��`r{�e� ��z��~�%�m�:';h��y�� 2R�{�C_\��g���1H�_�]ҍ���?�^�{ͽ˫�\�s�5���ǁ_�/�N�t8��a�i[@٪���oq��0�$a��x�9������x�bG��<�N$����dW���}#Q2��K��]Ҩ ��Jv����w�+5w�?���|�$��G��$k�����j�q���������x���y|���Jf����|�د$�hDp~V�c����R�?�,=;�Y�����҇%+On���իD���Q��'!.#���(����<o�$��[�[��e��L��""R�^<��J4|GW�D_M-͙){    4n�?�b�^q���ީn�(^�nǽ�� $f�\.f]Q��;I��כ�bQ�I�]Ս��Ȅ�Rf������u��@d�=R �,{���׻4�o�"�P�U��r}B\��ĩ�Il�m9�xH��8�KH(X��W��3�]'�L2�ñCW���*��u#{�݇C������^�q�:��	��DF	�m_`�8[��ɾ���&���D��Wx�v6^'�c���;�ui�����SLo�����JO|6�n}�4�*��T\Y7s q˒3;��x��.R��.�:�K�?�4��/5*{?���N�������Tt"�e����N���O<ї5��#~`'��/T<}�����V�M��>�%{��+��ɾo㼚��q��� �Qz�uc�z|�u�)9()��n�n��,c�}�u�p,<�7 gtv�-W�1��8�#���˹��p�������Y�4�]T���'�#^�C��έ�_ű�쿽��4.څT�<��Y�@��j.�*>���&H��\A���.EA0+P	{Um,��=Q>���~Y�*�:	��N龜�_��,V��,��g�g=L^�n�1QF���Gb��(,�(_��he��U�x����*��{\{t4ap��[i-�n8���xZkCu��+Δ��.�ӫn��ƧF�Q��My�<o��^=��,�<
Bl���J��Ϫ��)���e)��C�2",�L1m���a�㒄�m���z�Q���|�"_�pE�}���uo��Cو�h����5Tc`�$n�;��p����r̬S�kV
�\�)��4kȬC>�m��� o�*�r�U�{oj���ӆ����u�c������4vo߹��2� ���œ���0�k���=��L�B�k[R��_oV����ϻ�U����I�Wz�l@?�:���	�&2C~բ	��C%^���N8k	tU�>'�ܝ��������$��+/<<�,��佈�Wl^�A� 3�i�{�S�m�>��K�L� C���i�^S*�)ӋĴ�ϠB�$Y}�lG9t���xi��0�i	|���N]7��"���YHc}� z��C��_�㨗���'�G�+U����n!������ �+�����,����7WqW�*
������t���lҌ�iʐU{��*�eh��d�{�9{��D�٤�p.FE�L5+�o�\�B��}��ބh?]y��7����AM/�}���o/�q4�S��m��d��`~-�~<��@Isd/l�]��D֤��߫o�X��2	i���WEz{_6s�ش�_�#���� ���5 @����;8m;��6���I���������Ǥ�]}���c����*)@��0�9)B����:���y .`�ɣ&�f�UG��$t����2���X�/>�O�/>��_���q���؜�� �4�� ��R<|���A)p�Щ	�����{+���s�G��N+�'���SD6	#|�?��M�����z�R�;��Zi�D8�b��6�K~J��E�� �N�r�v�a��(p�nW���Pru�?�,4^�dسJ<��X�|�H੎*��6B���>)D#�H2�~�����Q�ː���FHg`�Wϙ�S��*D����� vަ�Ƌ���ҧ�6�o��S
H��̙���&���ҩjM��[ ��!���O}�>�a���禁��_-y��^�a���0)8ޗ��ЀX�n� q���{ݹW�� \�"*�T�f��>�U^�L6Y�_z���p��9F�T�}����z���C���{pX�U-_:f��_�WH�����g�F�q�%@�Q�i� Z��t�IJ[g
8 ���K������ ��H�TZ ��FM�-`m����p`�.��j��ro�����I�é�~�����@ д8!��դ�[�_mW8_��o�b�~�����C~k��l��Χ,\��p�0)���Q�9@8� �2QL�Mۓ-�%L�G�3&6w��#��Ҟx#��.��T`-�7X/��4�cw��}�����d<�[)4 ��-7az�by��yg��{�+��K�ZB3w�2:.�4W����7�<~��W]s��`�R,7�S��!Ey�^ᚰva+�l����'O�8�j�b�= ��{5�1��D��Z3L���������ѣ�%8ث��W���`8�RF������=&� IgF⺒w��?sr�5�d�k�W���,a>eV��y��O�5���z���y|���K�\b����%r���ۧ��Pֹ2���.��y-<������ƾS'7��)��G0��
A/-}5BÔ�!ׯ�:�n��l�{���[6��q���}����n��Su�{���^ˎkY��s�W�;��3���ք��5@�_���[YU]9e�m��Fĉ<$�����v�@t�ƅ��/��;:�8x�w�Qx�s/�5�4�5E112���m5[����Ƽ�揪�YR��ڍw/��O�����l��n�E�)�f�zO�$�wZ&G1�?�E#��x�� c�y{�A�[W�F�͜���.1A�ls������o1������ߝr�D�8?�%}4��݇�A�R48�M�2m.����P��}s#�鲞}�Ĥ��I�wa� X>�8^z�l�(om&^�ܳӎ#��/�� Բ���O�k���q.����K�p)�����,o��2-�x�2fR�:�10�ל�"�R���{�?]�+��~9;V7�v��� U�8�5Qf���Я�r� �0<���Жr�������s����i�X�:��T����!N��Wm��'N8�
E����Y�����6Us�\V}�2P�C�7D~�P��6��c��v�Q��Fy-���-������9�-w�8CY(>�}����Q���E�������'Dd�꫓��i�`G��m2ĭ���ǅC�W3B��7^���%������y��'� �TE���]��=�3���[�����Q�����'Se	 0k���^�>x�F�J^\���1��#׍W�fI��r�M�����z��}�s�=�f3^̇�rbBEC�E��&H�QXR�/\L��wo�We�3�P;ή�k^6x�A�L�^����h.��y������.���g
ZEWSx���c�+��CS���;k}���GU�{�S����N�<�~�Ґr��:�����I6eV+����1!2ӓ�����&.I�Ğ�}����FD< Q��uM�P��TE���n?��~,�R&c�X������m��M�
�������c�S�g@x�&�������qn�_j��C]�T�T���݆�+�������̏�U���%��A�W�����u���V_�k�1>��'�۴������D��Wgm�)^��� �����ｕ-=a��{���o���̀u�f��E��re���{���{����s����60��^5���D������>�3+���#�D,�=���N�uM����,�8o\��<�D�w��S��\%��-!�2��ף**%E�r��ar��ث�u����k����`�������%�

�f�Mwp
�5���;�o�#��t:�%5����/�^m�4��B���Fs0��*T���g�������µ�S1`>��ܘj_�� �N��Ǘ��^3u-��*�~���x���h�hb��6��F��Z�G���#VL����Ӆv+/��m~>׳S\s��r�����[��H\s�_���;�T<�����9���[�v^���%�;`Z�˘*��>�UG�.΄�\�|���I��|9�)dA�g����p�u�t�B���K��L�x�h7����f���vN��y>��k�-�Z��y�lH(ƥU��J}^a�����W���iȪH�:�V��a	��7�o�f���)�������_/��WU_��A��%����v�}ZJ�V�'���~٧Q)��U��m
bd8��M����ɿ=//��ts�W�Ah]���k+  �7/�~�
��'��V�sw5S�-H�CE��cw餰    ���>��T�*�G���@3��D�p-�E3޸B3�(&��Qrz�u�5W�1r�����S<"�*.�;�>O@=�Y¨`�z\q����`4�H�7����ev��-��͍���.tq
��⥣<u���xW
"19\��u����%-�o�@���=Sn&W�h�����^�S�I����ℨ
,�yT���8WjӆA0��PN9����^~��OkՒ���]�H�I������?3οn�7�=1��v�)A��Zj��i{�v���҆Q�V�I��j-��i.`x�Tx�� go�-�/�?��)�`��+�#��K�gf9��mW�;W��U~�{[��=���⫭�]z�Q����#.+�#3N�>�x)��zu6�����mK'��\�o�Eq[�2�ݼV�X%�/��.&4L̾ɿ�%���R �K��}n��"D�j�G��'̜CC� �|7Ԡ�?: �|'�/���.������P���J�K���A��:��W�1��e�r}ڶ�)����������8��?���o��{�t��[�s�(
�[3NApK��p��M�"�{}*����h������c�4p|��b�����m�y�M�$�nմ�Kw�j
.wqʐu�z��E���O9t��K�.�\�|V[p2b������5����l��'  ݻ����.���1�Y�U�YG�x�B�?#$h(�A�y�>��n���a�Q���������ϯ<�5�x�;��q�Q?V$�7��~��JE��S�mx^3�W\t�p���v��i�K�@���GG��o���L6�J��V]ڈ��b%D�ۻǹ���2!�#%p=@���]�H��2j�����_s�r�V��}�A�ۜN��RwA .f�dWT��(g��w��,���i|k�o_�N��t�H��\X�  ?�g�yh��+�us�> Ha�£��6�AVt^^�>竦�_G���4����tK�,��sp+ �u87ȭ�3j�et��Wm�uƇ��' G�_�W�9#�w�fif߂�����S��V�x>�Ek�Rk�v������'H��k7�3��Ce�A�cCt�����y�eP��KA��獼<@"LI���H��lU��G�l��Z����Zv���>g_2 #���$cj@*�=��N=o�"D.⡽��!��͡�[g�����B?�.��7���7�|f�����F���-$��hM�}kA��<an�^T�+7;r�{k~l�Jnޔ�sDss9�(�i���P__��nKՌW�v.�30� �x���ߔE�[դ��[XNu�o�����.ֺ�`gS����5w���Ny~����:�2>t���9@nu9te��&2���jI��s�Z)�HEP匡1螰:�Q����8��Q�%��T�X�)��f���C3F{�@�V�$3�5�۔i�����`�Ee�g�0cה獠s��^��1�x��c�B���ڀd��T���,]��z�p�<���֪�������k��~�7�b2D4d4���4��,}���K���K���Z��z�S3"�e2���rl�������:���5������)5Q��9�c	@s����.:'ϛѽTt�z����7�C���I��S��V��#���m�t�Y�2������zL�`�����b���̞Px�ٛ����cn�]pߣw��iY/���Rs��5���� �xM ����4-D��qvpH���a��|sYq���8�|l��.�<����v ��?�M�h4b	#3�~�����]Λ���{t�1��
z����z�"u4���|�߾8�d�"�5k��|�#j�I����e����*��*ve=��)��Z�=n8> � �t_��I�_��!�M�|�YY�Ra�V&��W�?@�;�%y��'��$��ް��P�Z�󍁠��L4�6�)�?�W�=M>�ۃ����\����7߉�,Z��R-���u� �� 2����J"F��4i��S�e�<?U�ѭ���V�Gn���>Y ��g���)Mᾛ� h8���HG���.j& ��k�ʅ��uVltw�, 0�B��'�׮ƿ�4:��j1�k�ߝ�����q E<�g������S������-�B_�OW�������҉�I�O[��&�$�̃�:<ZydU�煨��Ӏp� ".�ͦ�4��u����S��|���u¸X��(����[U+}ZJ�N%���?��P�oxj�l%�tf�$_������/��hx+��]�Pǟ�id��ny޿��d{�����ZPG����3o3��c	�u�����QbP��_虼�� M��ٮ�Z�[��/��XoyMA�ٲ��q(ۄ��ט{�w�'��w(i�Fa2T*j�T����e�/\X
�\������{ɖ�"�'}L����j����d-K/��ah����b�)�Gj�>����]���+hnI~�Kĕ��$����%�탂/v��_'���7��k"��0S�����"_�	���I�K`�[�,qµ¡�SO���k��f[�Q����!:[�k�xj�B o�̬��ן�tF� n{$���L�]Jv��**�/�qq?�������\7mw<)��FE����dn���,&T�	 ٞ?�^� s@ZL���m1ݨ���^j_��p\p'=�5���#o�Í�W����_��xh�SO��O���O�̮�y��d8�y &x�����$��m'e�wm�/W��-]#.�e����3�r#ȃ�����e)��l㰎���^ړ�S��$S ��?�01�o}&�'���Ӿ���� +�d�>?:��_Z G�nQ\�^�1%��p���<�L�	M��Y��tim���)�҃���N)�ҋ�&V���&���z�6/\|q-�5�G9����4��4��W��죬u��0�������eڻ#@iQ�m�2��������0��>=���S�?�,ٞ���/��f�0I��e7c����1��g�x^�3�3߿x���Y�gd]2ɩ~�R#E���-�$��ҞL�~j`���uS�%�o�L]g�S7�[�/����:N�z�C��t�h�6n�5.��dk_朝���_Y�(��9z�"���a�����ق-��;С�]�!��|���ex�����p>�p�-��8A��P��~$n�:.�N\��ķY�oփ-x�]3R<�b��hJ#έ��+V�Õ�#�w�O���'�>H\�5�-g�0� _�W/��{���YC�M�0���˂��b�	�I�a��lY673��F! o�U;x�?)��{�2L����q�W*i� U��L�ݳw�ܾ<�!����c�6�3��ٽ�ta�hG��[Ƣ 
َ��|6b�D���ܯ���$��vM���+^�io��b�|DV�IͲϫ��=��f!��,\��A����q��]������
�x&�Y?]�6�ˠ��[�Þ1 s�����{f��o>��6���y�m>���EJ��tޯ֔�����ޏ���	�����B^���3Ң�ڭ������1��v�R��:䵇���Y�VU�Q����w3�.=@��O��	O�O���dI��)?�'�����MͿ�H��%��ݲ���zh4:h��ʻ�/���ջ����K��\�3劫Hh����o�V��z������j:�j3��fx�Pǖ;�Q�?��o�?j�fF�ۍ�ֿOʴ!��9�!b�s)ǟ>�0���K��	���ɋu��RJ=��w�E����<Z}5�'sO�<s�N_�y��ܓ���^�ϜJ�dAT���?��%�P��1�sɊ�Ļsz|ӕqҍ��9�8Tˇ*�u�<�u�Mq�h�1)�}�tCý�������:)t0�vMl~��������`�{���O�5�0V�#�O��2uG��	�n�$�:��
I���b�\N"}���d���i^{j�9�bO0�͒�]�S��?~v|��g\{Ք�2a�����̨'n}��;ÎM٫@�]��^��.�(���7��X	�U8���5g���l���IE    w�&�S�z�b{��� 1�.	��xP��p���C.:��#)a@~O�˫,���a�}3�Mv��5��9�����W�F�ꧪ�v���x{�ŀa�]l-�z	��>�����\z����'!�~�w���-.���c�d �#��L���D��޳eۘ��Ǚ��.E!Kc2�y���N�!H,�E0���������6�/�L�7VL��K�*�3��Y�=vY���_�ֲ��\���S�"p����~a�?�C醓�+�tCZ �MF�K��Һk���G�ۓ�~~��Ɩ?=.v�*gn&��h��%bޝ��/�(��7G$ W�օ"CbN&�s�q�Jo�m�.��1~<�?���q����l�֠m���b�;�e_
$H�#�=ށ*q���i� �e:��sNC�_#��K#V�_3ti�,
`��_jaiO�u՗�(�Lo��|1� �m������+���T�E�juŐ8y
Y��y��(��^F���t��*��~Φ��y��].�y�7
�r�%ց��`�.1ű~-��j���#f�G�s�vߝ;�&��Ǌ��6��Z$��]���e�h��*���Ӧ M�z��JT��Y��K���v�1�q�bv� �P�̏�(V�?�N�N|$~��ŰX�E4�3�M�!df�;W?ޮ"&8�� �|�������T�9����(��t�K�x\��a���$f���,��u��`tqs��#iQnl��c�S5,�(��)���sI�}���BO�N�>^�����+[,&2���#'}�يr���.�g��=d��ގ>8X��(�]�Ʌ�G+$Ԟ��ZQ�b��!����zo�{<i���-S��>j�X�Q�[�~.�T�`s��H8�4�|�)�@�؂�ӐE��=��3��"�w��t���l&�n�a^z�8RB��?Fl��L��E��A��]�m�,���/��4`������x��Y:������|�>A�L���g�}�}��fT���J�2��:�W��(�V�����nXA��)g�
�S����F�j�K�W�儠Xy��(O���| �9&�^*��/�:�&e�t]��
�֩Kƪ�'�&��co�[a�;�d#��h��|��*�w[��QI�ψ87��s��(:�qJ�)�ڙ:�e�^��������l�\�N�/
6{)N*��D�6 ؓ%�R)s��ԯ(`�J,z:���SSM۪�Ӿ»�d�\uj�E �rz�9�;��G�cU��m�~f�+ףH�h���3cE,w�ٗe�/{Ls���D*�sna��>ԇ2���gWOh��$~��>>�%)C���r�(~���p�����y�ƽ��Ry����1���ݞ����7��W��}L�\[�m>����<�p�5ؓ���u�`~y\vS����^��TF�:�M|i��v��I����\v���"X~��0��l\-���:� N�	7o& �����P�\�ĹI�W��)�����7̉����f�6�U�OB�j�X���/yuc���_>�<^^���ڼ'�Ɵ�7t�Ó\z�S��rde���Z�F�S�������ρ �����N�%h�S�u/0^}
�V��/D���A�Pm�^;����9��a�gzG���oB��^�Nr�~�:���6�i$�S�"'%�g�F��!=�;���ms��:@]4�'�ZBc�z�PfE!
��p/]q,cp��u�޼8x��]�xf���x�����<����.��o�����p ^@"Ɗ����c
=���� _�w��֗�3n�?�L�B�l��V��`?;�"9�u�"��Gp� C�|m�0���/ށi�u������ �� �#/����p����K�vSh����B��q`��ս͊�v�����)�B��^\������ ]#����횾�4��ie�>}��f{�Wh3�}��%Zv�vu��<7�����R"S������d��.%�����$��mF^.B��˧" fc �y8ɰ7�{�h~�KE� �T��L�?]��n�%&t�8�|ŋ���jL���@������4A��Z-E�� y|��|G��~a`�;n�d�b:���>C��`XSC+v��g)M:zKO$����)�k>�m�01&���fwB�"\)��+�;�%!,��5�Ҹ����׏M�/�han�Ǭ<��"]����~x����7Mo�v��)3�_��q� \fh��h�rE�uǶ��7���b.���$'M�C��\���}g�yWv��D>���?G�Q�I%4S'V����q� !�Z퐉2?I< r���}1E;\��c/� ��\��Q9�؍0F�wz�dJ�+��p�����p�M��8�?E9/�x��X>��U�����
:˗ L}���v={=`e~|�1v���<�c��-WI��!������d{b�U9V�SmLC�eZv�]���ɬ�:p���:�7��&�Z�ArT;��W��'^�N[z&��ʵ���O�<+�Q� ��S)��i�#^��`NW��v(�;��ß��]�T��]xY�`܊�����7{���<�$�D��G~ik\9�Ο��QZւ�Ͽl)>T�juH�툭c�)*9M������\��ږ���~�K��-�gx&��w p�2eI� ��9�OsR�
ll��U�����c�Ď�ς��*E�/�N\���A]XC�]��)$�w�d�56��_�,o�[�*^[*�t\ӏ�Y�ߵ��w/u&����3_��I��������wxܝ��	�y�Ne$����*6�'~�%��q8��ށ��l�~}{���k����giW`\���䧛�����B�/x+&��e�����}|�k���,��z�?��^��A�;!���-uI浨��-���U�@�k�;1����Տ�bz+ʊ�e�A��w펓�������������Y�B�������hr�նVfd$h��=�빻j �]`�#S���U9�a��ֵ��Lt�����ņr�E\����f�\n-x�=���&~~�]��	;�3��KFz� ���#g�p��*獹�i!��V��z�yJ�I��_������l½�"�= � ��;�]
`	ط���%�,m��|y�����9v��k���Q��k�����:�rr3f�<-q�+2���b����
�f�����l�P��������pdE�1��z���̋�_s�ϬA�+a����?3<����� ��\���a[������3-3S1�
��%�%�˖�FJVw�b�Q8⌀���!��_,�ȏ�M��|�ʥ%~�gvġ�p�S�:b�+_���X�\�p��h�<%XC`��]&p�'?8��s]䃞���uN1rH�A�j�Y(}t�0=���S�.�7�T�h����ܗ�=5�A݆��!�)p������^&[�/Q��zMX�mE��a�P ����X�w(�����r��N�>��g�����DC�\Nʪ��~���@�����*������x��ڞq��nf��h��� �*@va���C�,�t3�O�:�̸�H��/ɘ3�����{�>wF3R9��	mᜅ�;/&"f��vi�����Q#@�f}��(�<� �E^�u«I��-�)��tM��W��ܔ!sP �7-���m��$"e�pi��Ma5�h\�KV�hyOjS�{_��=T�bhZ�+HW�(;���50�&�x: >�V���#
�Bһ4>��{����f�f�>���]���}�E�p����yw� �haS�a:�p�+3=�/D���T���@|i�b[6OQݑ���|\��=��9)���p���Woy��pv@0����H��ǥ���W�|���y�}�9 M�3��bAQ�@o��9��R3�Tq����!�V� (�:L�*��p��mt�#:���lB�^� ���ē���b�����ZE�(p� ګ����!���_��^�nՈ 6ۃ�0�靈~"I�4�u�;�8x_s�
���q�àH@���M�]>K�o�@�{&�b�nt�    s�-�2�� �u�F���_�ӫ�u�F��g�ӆuI�󂶄���U�<��~w��<�N�AXr���jp�U�k���2�|y�K*søO���p��+&�Uʁ7(�8����]�9�=�����2�������vTK>�>�EG��Co��*{Xh�-!w`�q*�s��H[ZA�G[t@Z�Q=�!�j(��1�c��Dw�-���xK�0��@I>������$��:e2م��A6j8�����.�ǭ�f�Y��u�S�rJ��p�g��D��2e��f��u��#s�r�C��.�Ci_s~��ں6�{%IҢ侩<��ж�:��
ղ�Jq�ٱ�`�j��1sh��`�y[�e��GѦ�X��2"n}������}���� xc��<BFYT�ڍ�q��c;^�?�4�����^Pc�x��@��}�C@���y F����EҕRemy�+�n��M�n��W�Cb����c��)�N�R�qһ��?���Ñ�0"�L��9W|�����E��q���lQ%W^�o�A�>AU�؁�ې!˛e���$aC.p�S�No��6t0D�rA��XqW�.5�U�K�Ԉ�J_h��vm��*���ZjI;PUL�9��i�kA�\A5Q�d�Қf�|�e���^ηƑ$ŬZ"���(Z�:�~R�)D�e��I�{�8*篽׿ꨧH\uTƢ���M��>���1A3SO���|�6�qv(V��8����-K�Y����m�cY/���ĸC�ka��N��*.��h���>�ˍ���@��^s]�`�U.�����Z�Z�;����	9�����Y2�@��!p����զ)ދ_�z��Փ:z��W�R���� �TťbQ]Oc����䯝���{��nx�9����S^�F���$��I�Oz��U3m�F�J�o�V���ܕSZľf��}�ɾ���0R�B�#;�w�wGqvl��߽Z��O[�m$�?2�}6�a8�_^�'Z���f��������?z*ODa�x%T$��KN��8��k�Ե3�)��w=��ϖ�~W Ȫ����	Q��y)�8�X�wJ��,�0WV���~;�4-^xyqT |;O/�����=�k�KUȾ7�	�ѫ#����e�
��0t�b�%��a�f!�n�T�K��<2W���1����r�C-�@-����|�)�O^}(����,��� ly<�Tp�7.���n�� ���k��U�����Ũ�30H�A k�
~�N�.i�d 2�Z@i���H�F@��7��`�̍��sX���K�o�UW#������Kޟ�F�#�rN�.�,���/����v�y�Љ�
(��t/�+��n�����	��3k�[�׾�A�M��Y�U�������{��Ut{	�d�k���YmC��M����?x]������*��v%|���y���k�c��8��hF��(t�k�.�tȥ�Q�<���R�t���h�u�*��-+(�����.�}NMhI��]���L��$elNB�s�p��Obp�f����n��*���x{^�Z�q�Hn 6{�R}�̦e�@��EqZ}����2�����9�����@-�g�������s�EI.��݉&�����=�+���LX����0l^~�����s��<���F�[G�)loc���{�V ��sT��P"�U�y��&��qE��f{=�gV��+1_�z���Ǚ?�+�� ��d��J�yS��=�K���*j\�Uu@��x���W;���U$����f�*�U���_���
F�@{Z�F�?5U�q�&gz ��3s���"��6S��w���6�����CQ�UI*�������.}7� ����Z���x���؜�v�Y��ъ}��]l��	��6
�0�P�	m�e�5/��a���4���#43��-p�7�M���z'��-��x�l�������o�)'��T��!�_z���;m	�p
H��-*#�s�]�:Y��F�ҏ�y^�5״e=A�}���kNl��o�����\���z-�<���;(�B^|vɨ��@���:�ОOS�g�84�)c��2l�Kp��	��~�e� ?7ڻ�� �cD�Q�<L`�Gќ���44���l�&��W�շ���0M��w8���5?6E�I,Uz������������r?/0�J���'T�}��J���c�;�3���7b/�d�3��Θ%w�.;�,��j��J]�.���S�o�$�a��\Z�Y}�XU��z{>nU�d�7����&�8�!���>w��>�D�d�񎺵׺\03,�b�,{�� 7�̡���c$8�T�C�#��"�� Ī�b��B�E��<�ms�P��C��?�v%�t��|�#����޳ ^g���^�5��9 �yw[��,��q����^��i��1}¯C��{�Ȭ�s�e���Q����#81o�U�xS���-V
�0۵�-f�>�G���L]�	O�t����[�v{���]$�=��c�M���nC��{�u�DD�toƻW�~�?�N��εxO>� 5�zyd�����<����ͨ��ךA�J��� DV��{�ͣ,$A�.ˇy�/S�2�A�R��M���H`[ �4d�h	AoXWO�7g:6�$���s���ב���k.����.�$�m/�Wd����ؼ��յ,�7����eY�D�^.Yw�ދ������~x��8�ȜKw���W5����{��/�,T;:�����C���n:�������n���Lz� `�Jۓ�Ϳ��~�	�8�A�"h��x��^k��R���3G���Τ��3�< $�?^
ס�p�����N����W,�"��K�4�j9�_Xo�=���G]%`����q��;⋶-��1E�`Ԏr�0�Rd��)h0�4׶�4_�]�8H\�l�y݆�\땀��\�9W��BbSLQ��V�D��G�u;���-�։9�Ȁ�4����_X�?���5�$�"/�]��y�ݷ�H��F#��nە��uQ������/��wv�����<ߒ�Æ����=���l��!��5���:��Mw?�o�݋f0���۹q�뉛���]�?=�/�o���i����+uG�X ��,����8�*x�����_P��`�����!���T<)��ǿ���6,A��u�/�_������U��4��_���$���g�;�����i����G	~)�r³1�U�Cܮo`#�s�?DJ:���y�˂��ot�<�/��X=S����>�f�^���>�=\.���z^�E��б���֞Xq/�9'�߼���T�a�(;�k�s��+���K`F�ٷV3&��H�*=[�q�x��10�T�����c@=ϛ��Pe�E^|�����k��o<e*��L\�j��~�x�?�aH�)$�xX<�K�s�[���i���ːE�(t�����W`o^�mQ�o�C�[>l��BC�hzd�Iϟ��1-������r|@�m�����+���'��O� �X�w����L��w�����^ 7��ڢ���+L�8�=�� �u]�":��9�g�zT�>���)�l17^�;�H�)1+>�S߹O/��A��|����Sq�ύ��q�� �*V��ӝ��-�g��}��Ⱦn�����H�3��^k/��1��$om/�����̄�F2� ���t�[pη̧n7  �^��%��(��׽�������c8/��z8��N���-�G����	%���~�/��ͷ���!�X"�߲��#�Ab��������ZJ�N�'E����N%�xO�^cZ�L��c�_�L�`M����o���:�5�ۍ<�r&�tg��({8EN�zb}	���DĻ?�S�d ���U���AޭR�'0����\	�	~���o�����O�Oqy�M�' �S������?�2y A?G�KP� !zM��L�)��dtUt���P��彇d1�C��;2鈱���߻��ߞ�G�y�{��7�}�s��x�Z��|�Xt�<$�X�M�~��|�,�ef�L=E���$    �^�����3	48cl��"�J6c����&I��Ȗ
ߘ{k���=4 ",(@��%n.}!b�i�0��ƗV����.}Y�}l��;��@�v���3n���7tL��m�%���o�1�FD����du[�*�?��k��If�pģ�n���%i�|�V������E����4����N�EyǸ@(��'��ϝ�;QUdHd��9�0��q���7<ؠM#B�.��#�s$�t����ӟv��wYFc��&j���r,�Vs�P��9#Ҫ�9�|�m�3$8����M�hӯ�����ȋV�6 XG	q�Z��Ө2V0��I��z��t;?�s�� \J��v6��C�ޓ�4^T�
�Y�|.�� � 4܅�PWmG�M\�_$q~��2�R$ɛM���K
����nNۄ��F�lu>�q:1�S��Ԛ�
	1j�gR� �w�m���?�����K�]拕���2�Z�cJ�a��A����SM�;��p �Y6ĵ������<n&��α�O� �L���ǒAw�8�hm�7�1�/��<s�f�G��=�z��Q*�-����}jn{�ea��v��Z�m��r�yx{q����JL�';^�#T�85��}O�Kh�.��҇�gUa*��p-,����]��	l|)�78��f����}م�[�@�^�k)�Q�;�b�m��F��x������H�34ÿ>C%E�412�f�v�ᵭ�����bI�D? �Z��V;HBZ��'���U�{^Ϝ��d�{@D�����-�m�
xsG��~���7-1�ún,�ȼ��"�N���>3��w�ީ�j�3xH�/�L�7���FN�'�{&K��U�!Ҥ��F�I��Ġ��,S)�������A(��_���JJ��M=S�R�xp�s� )?�J�Y��)+�D�����h�C��Y��׀i��jb������;��c�wWVd�`�}'��g�6J������4��c�js�ޏ���.��P_��-U�����A���6��wZ|�+�K��-<���}��j`�5i��[��f�g��7�e�W8��w�#�|JG��6or�5rL�%���ݹ���&r8�{�3Դ� dA�����1U���V��
����-��\�˰�S���=� �эS��&#m`�s�<;Uyt�����L�j�f��<�|]*n�g����⫱��A�D�B���b��u�<�0����ga^P"{>�LeF�*f��p�n���c��e	�
��O�n�wU��6�9�v�"�ݩ{B�q��
��puR�x/�_�t
,�_����@A).�ÉD+������궧��D��g�U+��!FN"��A�d�E��[�%���Y���x�T ���&���вDM����!#L��{��ض	�Aa�>����wL&#�U�y;�b\��i
��3�OY(����tʅt놹y�]=�Ĳ9��-M��������rz�r��^�{K�MEݺ:}��b
;$�$��>I2S��O"^�wD�����Gx=����
��T�N�G�߫W�������[|@�S[�2��i�hσ<C�As$*���T�^��f��'�v�����}o@�{�HA³}� t���i)dA�&�G�q�5So����a��Y���a�]��*��FR�����:$�r�(�d�<w�cш�sk߃���L��
aY�?� ����t9�9���䣆��>* ƕ'�Q�e�DI����WALp\�uȃ��z���Z�V?�'�.��q�w�O*+��r�0S��y�Nn�]�3� _Q`�mz9����:�&�k�w��Wu�������`���4㡹e�v�th{�WA�Υu�3�.������r�,z���e�E�ɭ�v|��͹���I�N�ӏ��&���F������ܴ;?YcM�D��Nd��È�\�p�ੇ������'�nL"5��=��f��ګ- �M96Lá�rZ�0���F˶�N�!�e��7� �d
������
�Oe
�r(5R���怟�\8�"=A�g���1�ކ��rD�� ��eN��Y[i�"�W���QT�P�O��z�}�H���F����g� ��HG��[|�<��C�g�����8� ��o>��`@PD�E�A>�S��1�5Eh}�P�m���)��5���
3@6;��6з��k��Y�[��lP�8k�?<�^��Lw�k��VzW�!�2y��e�T�����k(��*GwnyN�]:�v�j�f�~ϡ�  mo��ڤ���է��x��ɤ"����k�:T�ei����f�[ںu`�P���`#jj�������)��Y�U�����������+"�����)zg4s+ڗ�q��P�1�{� �+S�b���e K򐪴�04}�j�1#Ł�/0���;ι<�f����M:=�՗)m3��Aa��f�I6ht?�9k�5q�j�6��[��&�P�38��1�O�4�X� ��
y~�{v>�H��5a�D��]��}Q�6$H����g��̈́��s'�M�禼n6�3�X�]��nZ� �\����}�@�2���w�M4�lp��=�o������\n-�D�(��å>Q`�_sX9��hfտH�E��u�I�*��R��:ؤH1gYo��2�z����7��X+��Ć��ʂ�MU]4M*�+QmpCqQ���Q��r���l�)_&��L�e��^9}��la󒘢YC[�?¨�/5F���W0�Y� ��=5xTz=��"�b<��+*��N���˥��o)]��,�:��_��B�T �*����WB����5��<�>=
J����Jx��g�2�2��-Vq�|�Z�ݍ��_�R����Z[��' �����T����
Т���1I��A������z&,�E��.
VY�ıa����QH���
U������1��p�����}�F�|��>[��m�qK�\I��3�17�B����{�cA���<�:ad����{zA����N3���<Ɛ�3��D�4�+ıO3����<�qǩ�?��4SQ_�x$��+@��� �'�5	��{` \�,���-�ǈkJ�*c՞�+|;������ ����?�yx@��.�nj�0a�EO(�qp�N:�o�[ˍMYt������{I�w�1��c�=�`�m�N���gS,q��U������k �
s�8Og�N3DV�n�5 M{9��3D�y5��߄x�
*��aD؎��Qkߕi�ot7����O˓}��1X_�e}]]T�lص�sB6�t�%8V��!w�Ήڍ��.��x��F��y[_Opt��ք�k9Y�Y0E���#V܌P�<���<!-�v��}�/��K|[/ls�y��
�]�Xpҹ�5d��K6>��7�n:F���v�Ϝ"W��VX8Ռd����O�(�}�I9娱�4���^;}�;F+*�ʍ�ܦ_���Uh)�{�2|���m����$��A��/�(����'5�G��|����H��|���O��,rӠ�2I���^��ȵkj�8E`)u_�����C� ���S�'k�+�I��"�"Y6�j�I���!�n����H;
�yP����C�M��a�>��q�h��&O��~2��w�9X54�me�,�����y��S���(.oTv�|�}�`|���{pwlj�>�����(?(�*@�{7/����z��k��E���.�^��?vݟFɟ���&{5��V�n�a&x�=�����Q��f��Si���^!����cq7'&��Qn�r����M��D���)�?4�4@C�A�@�#�រ _�dbW�4Lk�W��=�MU#��&��*��oUƍ�%'�Ͼ�2�
	d7_�(
��YN;��PFK@ԌU?(�/ܔٌ��e!E�N���w�u�|�0t<���+`���7һ���w�m�M�X�r��G����M�\�r�~�V�_�~��Α��wx�,�f9����ܪ�I%G����X��-K��d���	�Q�ks�߹S{FVC瓝���    ���.1Z��?{�/nڬ�^~���
�2d���W�n��Pzn�ʱ�(=ձ&�$�>�%��A ڼ	��dE �B<�\� 6����|Az[!?���uw9��z��|oJ��/�]r��O��������׃ȍl?_�=�o*O�<�'VH����ٯ���<~�����=	c��\�Cf�����W�xv'�K�L]lz��	i�Kɯ��dJyC�(��cb�P`�ɞ+eVz�,��g�
�+g���X6݂�,
����g��cPѪ� �� ?4���*"7�Y�?���BkmD�_ԓ�CC〼:�T")�p	CI�WOY>���TY������M޳�"�]���'z����	����?�-.6�1(<8@��ab�7���}���^@���MN� VO��h�� a2��1WC��_��Q��� �n�k�BV$���boA�PE�>����_s��}�[0�f�'��fm���g��ֵo�b�{w�n4���|��'f����(u	�K�^fǆ�(����}��s �em�>�c�7FQ�K,�9�h�D����F��o�,�t޳�P,��R�C�ep�-���Q���a����K�C���t�(
9��s#gZ�ފ��9��[�R���$ӹ�����q=e�5��:<�zS�w&T3��8����;L�0�Oe��h^�w�#�
 ��{	r�}���n�1���^�c/c�b����'��t]RG����^:Sv���j�5Y��rA�ϧq^�JhОW!�_M���������&���r�.ѻY��$B��3�fX��4��w�~��*��Ϯ^qY6.�v�HD�핗j�gVm��,u?�kh�!|�2V���җ�˻
@��S"�8���cV���}D}o9Ԧ?�G�M��:����5E�սM��A���}ۺ�ku�
@ �O㉩A�K���p��.�A���=��c��������s,�����:[��F}Lo���o�?×��&���%��������J�nC���ޝ��=���h�=��#+3Ԟ����gL3��jޥb;��\-�Z��r�>��kͻS�k@6c'bU�����P�מZ���ǈ<台����@�m�/�@k�/�gD@��?Ƌ[��� O74iTU�|&2��%�_Cq7@�p���t���� ��d>�E!�%N&o�aa���Ke����'��(^ ��<��?�^�^�?bů�[;�L;u���	��$�kƾl�R�f��/r;����cULz]36�a@���nEb����CA�{�ZM���P�r6%E����I�wn3���'*�'x���-��L�8�c�r�SX�^ڎ�i��j՗#�@��a7}��ra��h��c3��I�el���D����<%��(�o෥������\����P��9����X}_�M��}���G�2��X[����q4X��=��)x��̗�w����Ș Z��y��6�Tܩ��Tz>!̙�ޜ����U��T�o3�R,�*9[�~��5ޠx����L��@?0�Tx�� W���UD�#��p��-_�h''�}?����� �-��T�KTo�m���+�6�*����K��x8���a����G�R��ګ.�إ�=��f ⊬Su՝���#�m�*��_D�������8B�P�ă�51zE4;�o�T�7�*TG�u���	�I "t��;xZe���I�����/���Z16ʝFmIW"��I�z���]�p�~��PG֫��H�h���e<O3�Ņ�e�Pk���Ėz�����������e�=��E���+I@f���{#�p:���sq�䠏�̗��%���X�"b�o�3���|.TQ�=bN�.#"sţ�����W��QC�ۻ���c)S���R��?5�?`� �kj	z�!��Feˤ��z�.3�53�A�L�y�Ӑ�3S�ڧ��uMp��݉;�Ĵ��q�%�W� ��CZ���ԗ��Vk+�` �C�����<�y��2Yv Y���~'V1���i����y
~3�K ���$��6���3d�\F�7�?��O���{h5P�W(%X����?d�l�Ah�~��!���=ٔ��a��Y'q|�F%vE)����� n���_�o}ߵ���FGmn�L�Cibn��ݥ������"ؘ�5z�4��π�����Ė��gu�,�7m~�G1=�1G}�ߐ����P�tV���Ookm>���U���(���cV����14k�K(��2���-����/��o���-���,�w[+�C�U|ۗ�|�vp���^B7~��5����?���O�G����=��G��5�q�p�C�53ڿ��&�����d����^��/�k����_W�@�8/L�"l�C����]�s������J9�D|�Ĵ�)�i�����u���#��*^�}1�Tsہ�K�?��F�|��x�����J�a)���hg��)�|W��O`�nh�lZ/H�  Ԅ��Z���L��?Ӯ��K̮�wH�I�k�`R1"<��؉��������%����Z�k�p�q^��s���y	s��O����3Bd����}>=\ËAC�u��g4M�w�dۦQ#Zoģ��-��lꄼ��#a�|�O<\5�KtX����k������d	1��ؖ7�$�}D1&�ے�M>�������k��F����#�l��7�!�aj�������"���zF�2{���V) �o���ߣ�ٌ̚�z˪�!Fko���ĸ��m??�?���a�m6,_��	����	dɍ;��A��ҙo��T%h$��Mꆑ=xv�ia���.���fL�7o�q����(��0Y�y����J軇i�n�3��tłnVԏ��%�[�҂�ak�G�.QȖ��&l�y�FI'�8�;�*�t`X6x 2t���r��$�{,�$�J��6�q�`���P H�ǀe�ܹ��3͉�CO�`I��'��=~~���p�6�߈��O�q_\o�b���I\&��`������'�e%a��kּsp�}�'7S]����J�y��Ah���p�t.z����	�1���rF���v�FZ�)���x�������m"�כ�!3�&">�NwBx+�*E_�`� ��@Q�D�.�ߪ���w5_��N��ǣ���!;���`�r��װ��� �Il��a���պx �|�޶_�T����~��c�X}��[�ә�"��O�ը��+<:���Z�K=�ȿ8f��ʟ�W�s��TM3�l0��KK.'�W�.g Oċ!H��������G�BeE��"��e������mW������NŔ�	��r]\-���-����z�G��W�`�J'�K�����~z�Ȳ��z�if#q�Ư�S�Td�a�p	�%P��j*���6�f=>Γc]\"]�O_�J����L@"]�f�L3����(�(�o�*Ü<��އ��w�u�����ǹ	���;�"�x��{�
�+k�LV9)o�&uba�I����-�Q���z[ۑ}Wj�Pf���g~�Ǣ���^�=3�T��ut��9[�l��J�Tl]�D�3��o��i:�\ȣ�-}�N��9zWR�u��[?��7��f$���A�\% �!:^ܺ��u�}����o">��3_��A�L������ug����(�����3 c�G��T�.�����z����N#�+��6l��H���M^��}Z�&i2Eq��J�]wC%)�����`RB v�$څU��I�8fF`�7/�����~$d�!Æ�0L�08b���
���a_�b��Fu��Fz�G� Bf�ѿ��������mR��I��g��ʆf���f�+�a�S_]��i����^���)��V�,�C$j�`��h�V�LGu79HH�^Ll�H����0��wc���0�~7�}��[^�8G��� �8]��K�O��4�v�C�%m7�D"���歷Cq����X הh��A/#�&��,�)dtgD�m	v
R��e}�ez�I��o�g     l�����W�(����^�N�G��q�)n��7$��>��n2�˗!3�%���q���a������B*�ښ���Nɱ2M��׀���E��&�����E��������)�\F�Cp'�id���=������a��Z�6�m���\W̑��-�T�2ٜ��n�����z�N��H߾{7�����$�7l�L/�d��W�uA�v<\y�o��
������/l�N�y�_F��W�{����!�&��a��5�~gs�/��g������+�(����gv�sF���y��x��/ {��+�ȷ�ǇH��'d>��5��(�p�%�U��%�F��{�����7��.suw�!�r&�'D(�%&+fP�`IsfF{���r՜��Q��t�|������@��g����U��2�|	n�q	.���eƪ��?�"H��)#z%��EZ��IЯ����� ��g �MjÉ��0xpG�㝡`��q�:a=��H�i� FA�e4��P���8w ��m���ov�o�T�;/��)���A^<�v>�E1�ڷ`��j�)��Z{L׀P��Ib��?ӕ�@�'�Go5�%L�"��*�2�ǹ|{���!�^�å償)�o�yՎ�_w26�ҭ��7��ɼ�'����g�����k���< ;�o|�,�����`��z�|��΍6���9z�r`�Yy(�h^j��K�C�Dl��a�dL�ݲf��`sJ˄��_���U�^8d�x�+f�15�ʮ���9��$������
@rb�?�g�N�3eޢ�Dc�/g�%�1�fEo�b�|gY�0�Xs�Ce&��mH8g����9�t��Aη`�,s��˽�+���}K���&���8O�.a��}�[Y �w7S���a��tgL�"����r����+���x�!:�u;u�mjaNɨû�N;���7��W�e�Z��T�A��\�H�M'��f����u9{��=���x��U%_����E,�A��$����X�����/�^��&{}߂3K4�U@>?Nޥkb�htmIe��WP�Y�*�$�j6��ފ�]F���pЀÆ,7��T5�L���<ӗ��wX̣�Rο[ �kr���뎿�K7���m)�D�u���&�o�(ҏO�,#b)�t�W3?�2��7v���$$U��w���{M���K���&����x��>j���#HM������
K *��|���	���-s۞|?N��H.E X\f��'3��&|5�k�&4�$��ٳ��s>��t*��5�i�l�)����4�U�v���T�$�mw%&{<3�x�Tꘛ��.�+_�O�~2�r�[��o5�q�'#Z���� �'���<�(?�-Y��~��x�Q�]�a�BNi�g���x�ہs#=�ڇ'7�$ٓ?׷�n���^�~��Fҗ���p�Ŵ������J���${�HF�0r��}p:�n�����D�{j�����Q.Xe|�~��G�g(ײ��U�X��$ڄ�6'8�.��DiILF�ם^�G����n�	,V�;�A���NH?�a�4}Z���VI-Àћ�^�l�}ԯ�`F�Of�b�Q��G(d���<뛢�&�;�xP� V�"����M��d��-���,�)-�] }� r�����-e&� ��j�<����U��]cg������w���+��5'��.;W���KQ�N���9�fW`�&���
��fM�?�e���Q��Թ����Ԟp4Z�́�io���y���Ź������tG��G���` Z��B���Y�.�o��N����a�Ucz+"�&#hU�w�?B��� ����E`Q�z����o�x:��W���˃���9��s���?c:]���`�K�D�Ŗ���I�I��(��L��)���ũ?�d
������O�gMB�I�4�˲�u�����J��C@eԊT����Uj���7�AD:��#�k0aБxT�C�O\�~5$�]���x5x�X��d~"5׽���u��س��!�I���e~��O@M,|4 �S�vI𵗩�;��}�|r/���G�0<�rfÿD�����@�A*�V�ۨ>IȽL��&8lܽ#|�㯎%�|�W���e�Ş��!�T g<@�9���O�q=S�1��f�/�e:g����:Q��K��ri�A� ��V�j�N��r���M����kR��!q�^���A_��j��{/�>��-�RE����e�H�3{�8��(���#�����x	p���  ��y���`a�oU��FK`f�x���)�2��Fxi�������;�؃a����p��x%�w�J�P/()�>B�I{r0�Q�E��.cD<�G�e)�����w��4c^l���� l���p�:�v�"�7eE����r��r���zׇE4�~?9�"����^��9��4I^_�R�({pܸh/q�ې�]\\��"�/mdٙQQ�N� ��P�s^��a�l��f-�\�o���o���jV�vV󼮿d%�!�׳(Z#���b�j���� n��;`'^� �	�ㆭ&�I�m�R�R[ǯ��30�o��h2��4%�wA^���F#���W��GB�����8K=�Cw�TS�m-�	����v������w�c������4�
	_K�B�/'x��jo�����[0��|��hk	-�zV��>��0sݩ8���<\=?�4��.���P��zoW��wzez,�{[�AߏZU�GU���&���N���#�q�VK�ޟ���K&~͋��p��/#� ���g�;'��Z��)Th�����ѣs���}��J܄r������^����-��˿��_�i/�}w�z��w��ш��J���%�F e°OG�@�-wD��]��(��\�/�\�U �$KhoV���ǈ�s��z�G �!��ϱhx/����Kv�f"��aX�G������&9����^z_�T\��@���H���c"�h�/O��v;3��o��
�£�T�xW2�Z(��16&f^����cCםၗ��5P�8;�9	d/�� 	T�]r�
��a��O1������<d����	x���>��m��/n�?U�W�qWE�f�W/Ӏ�օ�����P���vw2~�q�8��{��w��.5���x|#Ź��J& ��b?�z͋��nkBЋ���޽�b��?�����bEl@�r� _M�_[� ���U��u���6ނ
�F3��o?}J��w'!��p���l�6�2�Kz�]W}>z���QQR���C�K��jܯ�Y�7���* j��S�M�+�<�P���X?�Lz)�2o�{��v����d=�,8U�CnK�% ?�l3���g��&��o��?3�� Vd	��:�F�;��|4�/!��#E��;uI���* ��lq;d$W��\��Ap�78� S���2��Q�F��5�^�d0������'��o�<fۯ�I���m�:8������6���m��l�t#�p�O�ׄR��wy�"�K�`� �#��Tbi�%�����AwG�B�R�a\w m([|A���;xXpp3KC`|V,�S:������b�?�NRA/�=8/��G�yv߈����'C�n5" �~$���>܀����_����S�;�)Iozȑ �hM��V}_��;�]�����׽�_#n��Z�dl�;�9���+�ƻ7�ֱ�F{)ǝs���4�X����҇%+Ov���V�W�b��Q��'&,#���(�#�<o�$��)���_�2NX��n���"Oy�����i�/�&���L�=7�c�Q����H�T�.�=�۱�w�< ��+��iWPs�N��1SL(
��<�|Ы�ѵ��L�)eڼn��9�_�܊�,�G@�e��;��.M`&U1 ^�#�P�������X5<Ɂ��-G\ ��?�2`���z�y��.��TƩ�a�+��N+����=����������L/���Y}������/�Z���2�/s����l5�ǖ��޿��ӱ��e�y�A�.-��S    �iX����βa�i�Xq�g�%��	�P���ʺ��[X���Ʌţtto��!����CI��R�b�����H�=r)cd(�:LEf b]&ꪰ.�d��~��yY���XqG|���s��Ԗ��nr;�Z�d�rC=ce~=�7�m�W�T`{ߞ 1JϽJ���_��H�AI�8��[�`읦)�#�s}�c�Q�h ��ّ��l\���q�G����s �3�8�=:�w����i����ەO�G�r�l�9�[��.�c�[�{�>�i\&���yL��X�("{�\FU|B�Ë�\A�����A@0�	}Um,���+P~~��Y�T���L%\@�/��O��@N�A�3�&�n�kL�Q�j둘� �K2ʗ�3R��j,�<��`�R�؇��GGb+=�JkA��0o��ֆ���W�)��$�ӫ��p�ѡD9GeS2�G�T��g�"�G�	���r�����gU�@z
�Ƽ,�b!�/#��MӖ��V�]���AU�Wo?��▯S������� ��VR��F$FRz�v��@����ǋ�?-��:��f���E�b�M�Ϻ�ǲ�7{��SEQ�Z_�zSc]'�S��g�x�J%�-�+D/Gi�ޖط���v�&nW,���x�)��lK�%�X{3-
��mQ�J�i��s�S?%^�@V5�Y?��:ـ~ju ����&PC~բ1��C�^4q|wM� ��:�(o��[V��V���>O�!��r���̲�T�H������ ��2����ß�mS��V_��x04^	�v�5�|�2��T�*DT��gKw8�C������<� ������-���u�9(R{x�epk��D��}�U��q,�r�|��z����=��-��}���y�c����~�8�f�*�
ZE��R�tЕ�^�P�M�PM�jo�_���s�tO>g��h5����Ũ����cE���+RȢ ��ui�L����+%k!8�`>}45m�|�!JW����1�dO\b�{��)����Zd�P�Pb %͑��Y0v)�cY��o�~���cQ��$�/�_���}i��8cӒ��컗@L�5 @�N����f�K�����v=�$_�?&����d���� �a�13����x�.<�#���@�y�vr���Ya��x9+��鈿��+����'��I�/N�Ӹ}�x	lV�h�b��x��c)�}���Ap�Щ1�����{+���s�G��N+�'���X6�#|�?��M�����z�b�;��XI���łIm��i��� �N�r�v�e�8C�g�ݮb>K���
J44^�d�J<��X�|��8�SQ�m�w�2�$n0G��k�rL${J�/C�W�!���^=g:LI��l�/1\��6-�h��o/}h���_X��d��]M���{i�=.��֤ H`������[�3�?���乓7zهʓ'E��x_��Cbqx���G��>�ȿם{p��y��A*����i���3Z��˔��5(�����,�1������&��5Ыw�2�ރò�j��1����u/�����A|���5N�7Ll�m=����]w��֙�ػ�Kd�������7婴@׍�&�m����p��.��j��rao���YD%���S�>����)�q@���wW�L����.�����D�D�����4�ȓ�G��O��
�����h'sG�c���	*o"nڞt1-ar<�1��[�aD������r��
����e:��{��tB�w�.�N���B��M������k��;[un�7���ĭ��������0�\�{_������_u�!xVl,���J��H":�&A��p��5a��Vl��WG籝N���(���<} �H�jXc�D��Z3L���������#Gw�4����_-W�7�b�J��r��6��<Ǒ;mP"ە��?����nh#���O�
w��1�)ð*gϫ?y� �a�����5Uf��K�u^r����c	� ��OϹ���e<p�ɷ]��,�7�(m��}�N�	͔���ÛZA�����	��J����WO�a�`�/[��^1���M�z�o>��B檂��TIvm���c��[ʷYx��c������X��4�y
B����1l�Qퟸn��j��!ԉ��p������Yi�VɰR-��0�^���8���J�L�B�����q�#�1q �N��� ���<J{b�=�u���d��M�	�G����ڱ$GI�y����q΀%�S�R����-<X�I%�z.���P�}ĭ@�,�6���TC��Mü��j�l�=�e��f��7^ܗ��j��,ݓ��c�;������[�6�7#��g���O�rG_F�$�N�e������-C��:`�.��K���E��%.�W_oRex�&��e�T��,�)�{���RV�7B��>�x��������N�)��V��7�O�����'�����OT4#�m(����Y9�c�,A�׿���"$�I�K2�4�+	�hX�$iY�W$��؇�>��� G�3��e�"���I��"0r�Չѫ9
;�މަ^��+D�2[�����c������ "�mr{�Fw��1�b��}@KU@1C�U��0#�W����d��:�z2�/�zm��������]ʋ��ev�3A��L�����+H����#e�z�ۯ��Z����)6ߋ鰽�u;Q����E��M�:�6��xٷr�p1�y}�f��G��ڲFi_���;�4v���� �aj��8������b�����V��N�L�s�S��S%�7+}���-�"�$9������a~�h��_
RΎ}Xf}�w����2�^�P�`�Ӗ����ێkY��8�+z����W�HhM�������=�edfet������^w^���l3{�U��&"�w���v��� Di^�5�B]VS݋�'��K���}fw�:���%$R�
��oϾ��c��C�G@x�M7�>�w͹��̼��+����98�j��E!b�6�W�q�����(�U���%��B��:#%�{�l-H��ܮ�Ęv㝬n�&�~���D��Wgm�)^��� |�?a����ʆ��p��mo�������2i���b��t��}�re
��{�'sȽzH��O��[ nn���L>э�>B!�^��9����?B���%r�Ct'��]'�����r�����˝I�{��9]��r3�����B/S�=ھ�SJ2��fp�f/GH���^6�^6_+�l6HK�?�P֯��qTЀ7���sg� �#`>αw{y~����n�>�����˫W�W�-2��\�h>ob�w	]�3������ f��㩀0��knL�/|Y �$��'���^3u-��*�}���x�4���h�b��V��vV�Z���{����Z{��e�<;�ל���)�9�d>�oB���)>�\㩶��N%ps8: �0p�c(J��kǵ+1�ް�(��Ӣ^Ƨ�ij�:bwq&d�+�Ėk'���崦��d��%�����ix�!3�l�I��H1x�h3����f���6^��y>��k�-�Z�#�k�?$�Ҫ�b��WXky���Kx�0dUb�Bʉ;�~M��#�op�e]�������ۅ�j��@y�	&[�DpA�~�OK��J��r�/�0*���U9{k����������դ����󥛽��B��;񛫼� ���߇� ��z�yl�q��f��`~�����}�.�n�����=�~�Yn�^���<h������.�h�W�� �	�c�����]~�����������'O�f�x�P�x�at0Co\q����`4���3����ev5��U���FIR�8��c��ў:�}v�+E���.��"&+"~�AK_��e���g�����'��by�����z���Ũ
Y,�Tf��4VjӆA�o�r0���\=#�:zSk�7K�&��R��y�W��{#    �f�3��'�=1�<̔�)ƀ{-5A̴�~=\�qi�(������_���t(Hs�������H�W�_��!�%��s
;G�������y�����&�g�MO+���ݥ7�`���e��qY	��2=�ҥH����0?�Z�}; h�:�jF�(�ۚ�y`��Z��r3���<�⃆��n��5���Qj yi[|���v^�țCM�����o��sE:����w��2Y*�"�X��w���ڼ�ix�1|�c�B���Y��-ׇmۚ"�(e��]��I���H��\_��oO��o���R����@#Ӱq�[�߆��37��t�5U�­�Ѳ�'9�@�X:�Cs1ɿ�l��r]m`4	>$M7-y��M��.N�RO߶���)�np0b��E��G��!�!�N�{��ϵ��W�^Ӻ�>��޵�ؕwi�'�A���:B�S��!A}A0�rϫ��t��s��4���_�O^�_�x,�k���6>��dP?Vn��0����*�N�;��q�t^q�i���L����0�c�"#��E��y�R3��+m�_��JL����f��ݏUp��l�R�1R������[V��ֵ4<�k."�w�j��� �m^�aF)���� ��Aq���(����,���g�j�o_�I��粑r���A.@~��xzh����uc�> Ha��c���A��輼(n��/�����2��(��J72���;��/ ���� �
Π���i[_����ϟ��jx�_U�Hl��o#�� T|@��մ�H�Ә��� �Vj��Ix�8�@ڔ_c�ʝi�%I�������}_�Ջ/��]��^�8_���aJ����C�E�¨چ�ثy��Ԓ�g�ղk����9�%0b�J2���2��}n��ty'ry�����~�XnX�6��n�ϵ�� u��t�u͸�Ή������$h����f
OHF�6��H _}<a�V� *�9�=�3'۷����1�X�/Zi3�;��/Sx��k֫�u=f��Y[N�f��3吒��4�q�����G������*�YU�T�_��εu�)�ɱ�~3|�^Ƨ��R]`�;ȭ.�.^�Dfߵ_-��|>_*ő���!4z��3J���a�C�(��z�Y�G��N���mЈ1^*����H�̓8��/��0��Yt�Oc���<I��}?{�<$����İ�Ŋ� zK�W�P�*���z5@�C���!ҕ}Z�j� g. .D���Y�}�|��!�!�)�KD��oy�Kp��\���'��%��h��N��m+���o:�f����[����}ۣ���\x�m�AQ��x��XМpl>�IN���A�KE7���w}?#Y1d\J���a8�� ��x$��Q���.<�V�6�6�]}Џ�3�6�i���T�88�^��knu�X2���w��wAr4-{��HZj.N�Aܜm�v"N�����܊@��^��ag�����ˊ�m��Hb;�v�H�$�h����;4ѣ��o��������o9�r�C��1oO��Sz*�u�w#{����aV�x��.�0y�0�E�4֜!.7�|�'y�O.��2��0T���y�u_n��6j}��~� �8�龐���~-Ļ<6Us^�����L�����w�E&3Eޙ��`
��Yo8Oeic)Ǒd!��N�S�Ĕ֟�����m�N�vX�.���՛�K�Uzo��
qu�挕�f��N��MD��woF��4i�
�S�e���*
��VL�u[+�#7r��=9 ������)M�~�� 8�85@��2��]>�L TY�D���uV�Lw�, 0	b�OV�]��i��?�4b�>���;�W2�� �x��5/�<��~��� ��8��V�K��U����r�Lr��$�ۧ-m�yP�K����� ��az!�� �%��3K�̖F�}��1��t�<[�uC�0� ~<x�w�joSKK«��!��g�� ����HG� j@��'\���7����x�FC�L�v�Bj��A_�"������{���^ւ�ػ�f�Ӹ��V �9����~懎�ڸ~�g�=r(4=�f�z���_��r�
��<�ܳe��i>�Q�	����{�w�O�U�P�.��d(�T��[/@^��}��R4����_�.�K���Q?����͛WMj����ۋ�qZ�{�Ǹ�}J� ��O%��u�ox�
�k���q���H�qi0`�NN(��R��q��Ѫ3ɼf!�ѱ3��?��*�e� TS6)x	��*�'|+��9���|�3�lv�"�<3>'��U���.���y� �~��Lg�	p[D���f���R�kWQ�m������&=@N���\�i��I�>5z(���&K���P���' d{�d�' s@�M���u6ݨ���^�q��N�;Kt�_��n��z����1����%��+&�iP�5:�\�,"O0� �� �_�_�����G�M��մ�ޮֲ��QёQ��A@٩L범��q8�6o7���'��&�z�I�@J�O3�0�پ�H�ON��?�:
��d����ष��up��ŵ��=�����*A.O �aCSr~E����m��^zPw��ӊ��%[�*�	^O|~U�a�.�x���5�Gy����4��4��W��lR�:��G�HIu��[�Seڛ#BiQ�mȱ�
����<��a��}f���O�?��ٖ���͋�3f�0E�o�n���(w�9�/�i�A�2�3��x�1�Q�+od]�S}�������[�IBßJ{��2�>�FaIv�K>s��2}��/L��Y�� ����t�Q�ġ@P:b�[��WPq��/s��UZϯ�R�K�<g����t��N|�a=[�E�:Դ3!7}��mp�ڳ���a�~6�N�%�$"��A��m���ډ�wR��5��<����E1#ţh.J��4�73���q���
6�R�����t���	D��7����7mG�S���Dq?�����54�S0��]M}���N N�C�f˲~'À
� p$�v��N)��[�2L����AJ�/�4�U��}@&��ٷM�S�1DP�&'öY�e��~�Jf�V�?�e,���m�T���gV�p���U���D������a�K=��5,�I�t��,����ރ��ag�)��e|ļ|�g+��A�8>A/ϩ�)�g���m��jY�)|#`n��0�:b�,4��'�}C`ъR�5�b��]#P�H����5%�Ϣ�0��j"�xv~izF�p���3Ң�ڬ��������un�����RZ/g�ZUa��5Π��t� �ML\ '<�?y���yt�8��(O��y�ں_�����e���6A|��|�V���	�C����N���]o�_�%��pM.��r�E"4�xF��.��CO����9��ບ��|��jxF_ǖ�a��o3$��6x��϶�Z��Q>+�]�C"�9�����,�K����?A>觼X��7�AjB�1�s,�G�x��G�/��d�� �3����~3�{R@[�� ���� ����g����s+C>�(�;>�3]'�x9�7�]�|�r_$c���EیMyyw�>@W4�Z���x{�]-�	Fʮ��/���{�L��]��t������g�L�Q$|��4	�:�B�~߅Pq�z��>��h�̂���4����M���	�f�tW�T����IƵWM),�o��ˬz��Y|�vl�^ R���{�J^zQ�U/o��8�V�d��k��7��e��&�ܱ�S9<�����t*�$d.��A� ��ÓY�|�_sG���=Q/�� v*��k��6ս�����Yצ�0�꠸7�W?U���>!����a�(z����`K	�s(����ߟ������$��b֯�N7��ŧ���f�B��%S��=����ٲm�'��q$f�ݢ�c0���@x�r�o�E0����-�����/�L�WNJ�d�Cz�Y~��,=�]��,�W���l�%>��"    崻�S��|����_���P��T��%!]�Vk�V�R+���=*Ǒ��n??�A�ʟ��*gH�q4t�1�.h�.kL��#w���B�qc6�s�q�J�c��]R;c�<�'�{�8�sr��m���$�/��NY�K��{ ��7Po|��f�~�� n�������רu�ӈ��]Z4�� x��/���'Ⱥ��n��Q�dk&'FT�q?�ax<��b���@�QB��VW,u'O�
X>��3����53]p��y��s���A^js���G������zIu�}� �psL�_Kǟ=�ZG/���������7�N,I�n�rc}�S8-_�&m���c4�d%��S����<SVoT�Ǚ]�cJ������1���lv� �P�̏�(V���(�k!����H�L��~�0�h&�3�M�!TfS_?��"%8�� �Lq�����3i�g� {C4��t�$���_��a���$f��,��e��`pqs��Inl��c�W5,�i��)��,�I(�>Q_!�w��>\��;��6��M�7��G^4�yg+ʑ_���wq�Dv�����6���i<�������VH�o��V����iq"��ބ��n���m��;�tL'⷟Ԡ�r���h9.�T�h�Hx�2�|�)�@�Ԃ�3��ܹ-��#��"w��L���l&���n^z�8R¸�?D\�	l�h��u� ��.��'����k*8�\�X~��2K��	������0�D�T�@^|ؙo=�7��=��F�)�-xw�^��Q�J����nXA��)g��S����E�jfJUP����X���(O���| �9&��+��o��:"�&e�t]��
�֩KŪ�%�&��ck�7���m���m���ȩœ�;*���c"�7fr�o:_;SG7���Ҍ(T����5��Õ��i�Y�F/�)�>��U��c�ūT�ܿ'�+� X���7�����O�ت�f|Epo7��?�U��]�/��??�΍�0)z��`x�{�=r��Q�yT|�wIa���"���|�e$�[����č!T�s~����׻ҿ���Ol��G:��>�����_Ch9N?%�e�t����y��}��Ry����1����-0w��<N����*�~����|>6?yH�k�'����������.]��^��RF�:�ML���9I^�$J�����.����E����O���q��v�K�8Q ܼ� hx�7}��p��z�O-�?I��}޿aNT��4������~�W;���}ɫ� `�������H�-xRk��|}�<��ˌAt��\��l��Ћ�hc�O�.N�A'~�q?��Fd=XpF��M��R��z�!>GX1�����&�C�y{�T����%��m�k�	!B{y:�����_�l��H槞ENJ|���#��$�������U+� uѐ/��Hk�M�	ˑB��(�ýtű��	�A��5{����.<�����y5�X� ,��[?mU��`��,�?oÃx=�D�����c=���� _�w��֗�#n�?�l�+B�l��V�Uo?;¢x�u����Gp C	�|m�����/���s���1��@���G]�룷�,lE����4Ra`�s���ō���mV�$I��	�K��X!�Ǟ]����Ѩ ]"� �������5�5�2x[ӻtb���+�Q8�s���]�Tvύ3<$>�2��'�RK��D?Y�ߒm�E��A<��t���z���2U�l,�8'鷦w���3Q�� M�������XbBW�s��W<�'&UC��'|�C  `��h�Vj��x�������6ۅ���������������aM�ر��=�����dz ���~�r��s��CB�{5�Q)��չe�{�u5����&]���\�{�XE��1�f��<v�V��­Ć��ѯVg���F�x�ɀ�گf�8T.3�pG4Q��Һ���՛`�Q1�y\Z���}��2ƹ\��q �|+;�4IȿwC��I�<j�!��f���'��p� �U��3I>7 �{b��}�E;|���[�X���mG�c$a��]��F�)eد�V�������Y����)�y������u�ro��W *�(_��y��^=�a�3а�V��������Q��ɻ��>��2D��?(�p�lOj��*���a��m`�L�~w�?pp����!�)��o�r�Ӥ8KޙB�jǐ��_�����iK���\k8��ļ���2�����J鼩��x�N�`W�R���k����]�tQ�]|Y�`���=?��o���<�n��KN�,�Җ�$rz���QFւ��O���W�:$nv�ձ�4��L�0�=�����S���ٸ�v�xL��zV�g�p �)�A��4��"Y�� ���."W�����7� �ߘ3�=F���ޢ���!hD�sPVhW/�R޷G��76\�_�,o�w�j�-�G:,�t�w��Y���_�M�(�p��(�f�����oW{���<lN�l�t�<u�3��T�y�q��#��;��.x;���z�v/�n�1��7��6Et ƕ;M~�)s�o�O�_���Q�ϭ��*��\��?H�X������r�*d���	_~�a��dA�:Rm!,e�ɮZ�^�݉��u�m�~D�M�鉜$+J�a����޵;Ne_@��v���)�{}�Q�· x}�������&w_mkeD����������U ơ:2�?�Z����q�k]k·y��~�'֗.��&r�O5���B�~���r����ٴ6ag�fZ�T�',��1�:r��
_��r��O���h��#�SR�V�~r]m���&��j&R��*	�
q����o|�{��epI5sx�A�m��Й�X����5@����(�����
g�j������ƈ���%�ݹ =�*��� ���ឭxi��I:uTC�Z_��	ޚZ��~ϊ�	c���ri�Q���暟�[���yoCG�F�������Wp�.��ui>u|�O�ي�@��*T��d��\6�5Rr�k+��o�癮B���ű�|?�$�G�\Z�?9�#�e�{Se�8���|y��b�s���D�Sb�3Dv�2�æ|�q!�uI���P�9Ũ>����Ƙ��Iwӓ��?���kq�H5���(z �}9�Ӄ�m�0<B�"�l��2��{�b~�I�ׄ%��ZdH�r��i�Ez�"H�Mw���tJ�?�-�[O4�#ep�[V%,����H*t]?�=��{k�����_�R�#n��������C^ �\�.L��ߐ-�2��;��wG��f)��D2��e�� :�^�ύ�L�Tvx~Bk8fa펳�HYj��]!�x�Njh�,�n� �/ v�W`�bR�K�1�U��i�������_� ��>󄴟p]�;�ܲ����æ�D2��%�D��%�)�o_��=T�bF�HW�$;���50�&�x: >�Z��'G<��wi|��IN���YA��~���p��d����_��7w�]>@�3���i��8��LDO�������?�6�-�����cl>.�y����(���𖤷Wo���xt@0������X����.�����2y�M� ��	��j�xP�@o�`c8�f:��<+X?.��}�!��BP�u��WP՗aO��:�:FL�I��!���zI�!>'��u����'%���"�D��;�^�����H��v{!��V��l�7�5}7��n��Y��ݱ������V W���,�"m^27!�,}Ϛ���H,E�!�*�92?ى��,j�V#_��Wx��"j��Rw�Y��a]J�^КP��*"_�o���v}���S�gł\w']~_}U��3~�lx�_+���<ϲ���l��'�b�P�<x�7@�����+'�'1 �=^�8З�CM.nG�����S�u��;������&��;��R;���mM+��h�Hk4�Ǔ�.�B>�foOt��r�����&��J5�J1ӴR�`AH�\=@�ˬC��M|�k��^    yr�cDhÇ��q멙wT�C{�A�O^	b��xt��D�_����;�2��`,U�z(C��$�/�k�o��֮�ි$iQ�g*�6�������B�l=�RG��}v\/��Z�|��d>�F��d���ӌ�>�9�[߃�oi�Al�;�ev�j ��}^!�,�F�������/�v�k�����~<$�'��}�B@���y F����%ʽ�.���W0���}��VW/��Ǎ�w��N�h�>zwПُ�e�x
�D�)T1�JHu۱��2�VП-��ʫ��3�)�*�1w�3d�rlA�YQ�n�R3��4�3�(��,��|P;9V��KMuф��5��-�]�������Z��t3Bο6=-��+hR�E)6Q/�iV��WZ�:���H6�� )f�7�x9��U��s픢M!	0�}$�&|�O�µ��W������Zt�	�ڔo�y)����&2έ �Jc<�����?K��#�X�P��ˤ�21���Z0���8��Ko;�2���L2Г	��2�k�K,��Ż�"�V���N�n愜�r�j��]��m���8�C��b3���/i�z��A�o��W�R��\� �TťcI]O㴝��䯝��b���F������<=�%�a���I2����ݾ[p�Lp�A����j�؜�r�f�]s's�;�e_DS��Rar֑���Q��0��^����-���67B�3�}6�n8�_^��_n��o��O��U�=�'�p��x�*7��K^��8��k���3�)��w=���JU�+ dUl���\�� ��cY0v�)�_fȳ@�\Y�����Τi����K���qx��;�m�_]�B���L@���:p�+�^Ʈ(k
�$��#��kR�vL���2���F,�q�����R�1PK�|l@;�k
uʫ��B���b��"���͏���Η�ml�Ɓ�7ᬽf+9U���u���k��B��v^&{�2I�L��GZ.R4P�1�I���1�q�3�y)����j���=��s	��3�(y�_�����twB�~Mh' :	Q%�����we��gf�nH���!XZ�_ۿ�e �I�wFc�[��ů�뜷n?�ث���K�����9���e�U��D:.|��.��.�ze�����\�ە8u�>}Cn:�w����͈�Fg�IsM�o�)��� ����ih<�z]��/c�d� �wق���	�[a�\�l9��cUp�6V'��9c�_�ѻL3����l7MC���_$��V�"��;�T�1�i9�<C�(N�S��.,c�qYA��� ����@��"pj�a�΍f%M�xZ�M�>Yp�{����J{�VWawaؼ<����������4�E5����ׯ�Hnw�ݟ� ��!��}�F�k�-�)dy\�����3����+1_7u�>h�7�W��0��q7ɖ>�|�>�$]{���wQԸ��j��,�d;��Sn��3r��4HU~�-4���^�V0B�Ӓ�5Z�����wa��|H2�̜"ƺ��͔�ûzM���]���a�GaU�JTzg4<6$��?�w7� ����R�7W��٩�1��ޱ1;r�=����ܝm����16
�0�����gͨk^ă����4���#6#��#���*2NF�^g�?o\�ɿȴ����֔�L�����\s�6�M�	(��-:#�sǝ�:Y��D��F�Lk�i��I���ޮy��㿡^��3{����zo0�8�`3u��9���1���b{<M9`z�]��<S<��e��u瀼�,��ddq�&��ȸ��xH�<
�����(��� �U���p�uդ�9�_};yZۤ�y���$���O4�\�׸Y:Z�$�]L�?.���t-��jo�~c%�c�1��qCjR���?�����f���}N���qoS�.��-�V����$sa��\Z�Y�3XUr�z��BܪZɽ�����f��ƻ��P�����m�?TNU��k{��#ˁ ,��u LpC���~N�<F�c~겏�b�N�7�X����Y(>��� �}�\3���С�O���@ɧ�כ���!�|A�k<�u���0��o��5�=�nkt7Kxz�{�~�ޗi�|1}¯7� 4�9���B�}�S�����*��l��yYY�����w�0۵-s�;[G����L]O�uxǶ�W�6{���.Q���Цu���nE���D�V�H������0]:�n|Ox�,<�0j��Dj� pga��DO`�A�[���*mG�Y]"�9��r��uY��+M�LC��0z�J�f0V��"�=l��ҐoEK��@b]�	�1ӱE!<�?7ڑ[���]s)�-?u�"\�����R}E�9���H��.e�~�L�`+˒�z�d���[��p<��Û?<�S�I��9w�t<_U/2��GTn�&C��ҰXm���ۇ���n:}�����������|�~9 �ĕ�%���O�*@qJ��%�&���^k��R��$���5��3y[���< $�?^
ߡ������N�����8<E^�(�[߯�� ~a}^�n�m|�UP�Ay��z�#�d۲$ퟨ�m��P��&@U�x��	�� �{�&������$�����OX`��׭X˷^	�!ǌ���~VHlʢ)���J�� �(�n�P�Vc$�:0X��T5���o��|��.A�,�BKѕ{�w�ߝF��:��t��F�K����|%�x´�?䟲�g��-�y�߾n���*��5��ȏ��_{舓7�}_�L�Mo�-l�������_��z�'�o��45�
��r޺�K,V8�W�)��
���������_����o��0�_8�PL��R��������a��M8��B��^����߯2�?}��%�)����x���^ׯ3�G%=J���#'��bh��z�.2=��q"Rʹ�����9��meb�q}SM�ꙂO ���!.#�2^X�a���\���20
n,۪�\�I����c�W�My]*߇�M��ߚ�����N�J�F���V�&-�H�)o����*�ba��)�ς9x���{�uN�E�z��;1�t=m���BF��.����_(�����0��_���z2'[cNI&�����y�Y/�B��j�~��uP�ŗ�<d��v7�(t1�}Y`2�D�0L+��!Y�1~-�{T^Wp�7�<��t����*@BV��2�ky������q{�ߧ�M禮�+6�
�/ΜGҢ����kQĤ绣F�|�F�n�H��@e����.خD7�h�7v���S�w~z�"?v�?_R��§8��J������LI ���N�w�Cׅ�e�L���q�z�M�z�<�4;�:~k����� f���[�=�>Xr)f�W'�'(]��5�i�����8|���t�@��{u��?���p\��u�3ŝ±�,�����q)�������	���E���O>@!s����۶_p�!HB,���Ž�C�ĵ��V��)	$�[�y��M�S�ט�!V����/Df
�����J�n� �~�IR�\�T=AWu�L��i�p2Փ�I��%%B ���*�� ��-��=o��?�!�[}�\�KX�(��n�HB�n���>���><�D7՞ )~�Z����s)�{�sԿ��`D���6�Cn��U�.��q@]kh��'����x#��X�"���ޥ����w��ޣ�˽4��w�~������Z=��|�XL�<n<��������ʙ�����z�h���t{Y/�
��&P��"��Jt�*و���C�¥��wW*Bcn�q/���P�`0� ��Η��c��N[���nxi�k.�җe��d���\���m��@/gX;�/�3|L��u�o��8g�R��y�$;������U�Z瓁�k��MF�p��:���ԥi�B��V��f�z�"�y��'C�?u�|S�!.���쬊�흨**$�|�bYTy08H�m�+�Ъ!�i�    ���9^B��\�a������.�h���H-x�^�1�cX�x6�bT@Y�0��o����qƀ���� ���!,�O�^���òxZ��ֺ�O��8-�������>����>s�� ������f�B|?��b�pMP�*`g2]lA�A����ڎ.w���(��$I�JN���I�����%�B�Bb�y�i����i�3m��ĸ@�[kV*&Ġa�IC�M`�Ch=�9v/P�)�E��|Rn�P,�-�x-S�m:�d �K�{n��j��A<� ̲!�-��Ǯ���#��<��ҵ��e[��>�����(�EK����N6
y�C����{,����t��"�śj~}�ma��R��K�R�m��r�{[q����B|�)�_�#T�85��mK�KXh�>��҇�gUa*/|m��	�E�I�T�6N�<Z�#D��̅wم�W�@Ȟ�k+�U�;���mʁ$�g<L��+_)�����g�(�&Fe�ծѿ�e.��^���X�6>6��"��ݫd�z:WW�Fw�Rz�{�I��v28�\mt���͢�D"Ǯl�+�_#}��Ҵ~��Y�v�<B�-p��4q��(������{nSJ�m��c����]ǁk�{ogN"?���@t��C*[0�>��j����I�+և�F[�$�i_�E���^��e2g�yn�����9�E8���X�1E&�O:өM���oܦ�)��X�\���i�,�y�/���GYǠ9䂪��!x�<ɐF�?��5���ҤK�-�sˎ2��y�k�B��$�/uk0>����	-���7�&|�`i�� �s�
�����,�'�/M��[Za�𩀟��t�-ەe��rzI �?A��Sv�¼��yv�j�{H�6�5\�j�j�w�;��*��{���[_�d�Ѐx�I�= �$��L��v6�8v�6�Z�,(���T�*cH��Q:�� c��y������:��*	=2�bL!ݘ=5��<a��·��x�S�(gH��Su��H_`l��P�Bʃ��=:Q�y.��{���
��īNB��=��F�ju��[�BG�5)��ɷW���D�Q,%�Lȃ����F!L�����K++��@zKBPD��M~����7B���՜۴l�����>d�BI5��E��C.��#o>95��W'�~��@�Aܕ����V�R�,	ޱ���kߤ��Ύ�A�]�eqf&Mg�h�4���aX���`�M�G�d���q�y&f�#1�ȯo#3�����t�&#%�w7Su3S����O<1������4�Wf������~��� ڧvne
��âўy����HTv񋩢���!R�h�"v./��I���H7 l�3��|OG1�i�4%�+�L�e+;d����s`���OGh�<jI
�bF�H�Y@�̒�7hx��ۈF�_?!��V��	�V!����$��07]�u�٣��|Ԑ��G��� 3ju�(���Y�*�	�O�y�wT�rQ��)����ż[G�|����RM�(�N 3UH�7��� ��;�	�<�j +( P���T4��	51_[�s����Į��M��3���(���P�G���
�v.���A�v	t�+�H,Gˢg1~oL�-�Nne��;�Fo�]0��&�:A�WD�7���䰲oG8$w ������h�%�nv"���5���%��=���W��>Itk�y��i���|0���]_��ޔc�4�+�%��Lm��*���^��xCN�P�ox�f@~�(S8�ۈ@���K匵�$����1�%183������6��'�D�w.�:e��J��9��<>FFQ!B��\=�([�ȑz�ݭ���j<����G:����Ġ�9L�}<�gB��Y� ����o�Y Ai�,��4�S��1��5Eh}�P�m���)��5���	� ���|�����g�� ���٠q�R<	(2m���ʳ�W|�X�}!�86������0��k;^U\C	�� ��t��Ϲ����U� �� ���9�O @�[-l�6)����i�1��ɤ"��/Oאu�b��tM+��� B�����Z�ޤ�`#jj�������)��Y�S��������^��#�WD��1C�W��h�N�/������g���A3S�b��ݴ�%1�*�1Mߵ|�H�`<�K��<@|�9�>׬�v4��I�'��r�m�R>�!L�0^�Ìx���g�g�FN>Q͸ܱb�j�	Ep>�C[;��Ic��z(�0��+�����i���k�U	���� ���lH������}�7~��?�wh�?7ż���t�Dw)~�i�T �ck�7s�-���B��+l��d��F��CF���t���rk�$�GyG�:�D��a�磙-T�"��oߋ'=O�<�K�����"Ŝe��#ʔ�]���ސb�<���V�l��)hR�^�j����ڿ�ֈ���[�7���r�f"7��{�|�|�
�3�)���1teyxEU��ƨ���
��|� �pO-����Y�^S���uE%�ة�>w����[
F��7�I���� i!x*O�Lph�Pf�pEr�?1O��'���Z`d%���g�2�2����8_��>���؈�]�E����	����ӅO}_L��mth���D�ؤP��A������z&�E��.
VY^���$�{ݣ�:����g��B��L�����<�1Z-��Z�l�����},al�%�j�0��a:��﹎u�C�ꄑ�o�*�o��������4�������{�x���f6C�4Sz
�Wc�S�w�:_G�ރf*
�뼑'�?��KH3 �	bMB���X z�7�}F��1⚒���Z����
�N�p���`Ң�#cz^Ps��̃I��8����=�����<�h��o-�6eх��|���K��h������f�`�m�O���gS,q���2 ����@D�u��(.
0�f�����k@�(fz��i�2c6��߄x�
*�ɰ"l��ۨ��ʶA��:���G�Χ��>?�1X��q��.�Z6���9!l:�+�m��s�v�*���3���/���mõ5!�ZNV8kL4���#�<O �s�+O��F˿݄>ݾח��%�-��9����"��q:��C�璍�c�f�M�(_#8��q�S䊟�
������s���+J`qRN9j�/M`���³���=��w�F}nӎ����*��߽S�����Yyx�$��<A�jӅ
�iډR������>�";(�iRk��~�\��?�i�{��[Npf2�v`M��,E��+=���ahA�Wu��d-rŵI�]DX$��[-=�Tr�d�Ͽ�Ì��Uܾ�Y l�s毁4��D{h�&�<�����	���ê��`~+[��h,%%����~���؅�Fq�<Ge���W
Ʒ�܃��R�D��7]w�^AQT"߻y��F���ԣ_��-�MO�R����b��a��Y+Hh�W���[v�G�Q�'�O߈��е[��J��4�(�
Y0u_���y1��F��˱�&:���Q������CL� �v��8G"�=�A>���ĮFi��ί����|�h��!U�5�ؔT�;��0n�.=�}~�,C�p�@n󕋢p���]pe�A�X������2۱x�<������� ���Ns�aLP_�F>oDf~�L�� �I�["�a��±��)�O^V��$�����p��M��S�p.�!'�x(�N��Tr�����|�q��(�,ϸ| p�D��\�w�Ԟ������0Qy����K�{xe����*��4�/T��#��,���Sи�u���c�V�]F顎5yM� 	��.���`���!�՜���R�'��Ö��� -��z�� �_��������{Sj�P~1��#�~*�tu�<�oܛ�[�~��{V�T��3�nO�Bb��g�.�7#���v�{�v��ȇ�ƻ��۳���N���4�. ��Z;Ҝ��_�!ɔ�PQ*�(�"�b    ����;Wʬ�]��9|b(Я�-�c�t�(�ù�������V�&�3~����Dȫ�܀�:��w�Z[h#2����:44��y�I�KJ�����1N������	�{ޗBĽ�:9�D�� K���+i����R ��c�Y��K&z����w��*��p�����4�Փ�{%ǣg��0�C̘�!��W:���ov v�ȵU!+��}��nA�PE�>����_w����n�,���J��"���ዹ�X׾������w�i��k����~jO�]e�.�RbI���ز �ݸ�~<=@eY@��]��׍Q�RK�N4.h����"}���)2��,+G��T�d�|��s�p��p��|Hȥw�!e��C�P	���i���3-qoEIr�H�-P)��`����� ����2���GO��צ��L�f�6q�1w26�Ta����ў�ލ�P*�p��%Ƚ����ww��e���x{��S��6��\n�uI��|/���@�r�<7l0���d��M?�yu*�A{^��u1tbR~���V�
��̕�y�T�fq2�I��'�X~�a��4:��K�#��Vٮ~t��˲uI�CE"�l���K�Y�=ftr��8��C�4����KM9Ɨw�@�J�\��K�[-�6����Q�n�F�SM��:�9���5E�սM��C���}ۺ�g��
@ �?���� �%5��4��g���0{O��>{,�d�(���;v���$ff�Yۨ��V�g��Ghj�k��Lyg%�fB�*���ڃ�޿�x��"�����p���P{6���c�1��y���?7p1t�j	�����w}�hޝ\�;��z}�UՇ�&�~���A��8F�(����Te��U�ž��Q���/nɿ�<�ФQU^�d��&�F��M��d z�ep���q���+ ��.��	1H/u2yk-{�ޫT�m�/|�
Fa������H�I�g�����0n��v�P��&�r�h�!���K��������s��U1�u�ڰcF�͎���������r��Ф��P%�(�dSQ4�ܝ�T~�6�@/~�x�'��2{�$�/(��9�Q+O<�u����V��V}9����f�(��9D�\��=O�k��m%B�eI�CB��?������~[J<ˬ���_� ����j�����Rl"���i������;B��yh���^�S�=�/���1�h�5��g��6q*�T�`*=�
��YoΧ���U��V��f��8NUr����'�x��ņ�O1���|[��	����"jO�Z-o���%�vr�ٷ�j����/���Q�ʸT���eؘ�����+�\�T:	�눇Tg�pLeg =:��=�^uA�-E�x����/�^�Uw�S;FȻ�U�F'��(��٥���	p���(r	�zibdF�����wl*x5�*TG�u�{ˍ�$�N��Ze���I�����/��<�bl�;����D�<�<�ʯ�?�,�"z�F=�����[?A:E��/�y��,.�/W�jX�.%���'7�~��_����huV}%	ȮuY�^�M��Ù�XE\=9�2���r)cy=��D���-~��ۏ�*�������HCd�xp[ח2�s"�a�u{�4��eb�*�'2��M��e��5�=΍��a��e�w���&�f6"H�)2/?5$~�)a��S�˻&8�t���Ľ�	b�]z����Y,�y��V��������jmpl`v(�T� ��k�?�L��@{��n�߉Ub$~�7��7B���L�R@��4I���g7�,�5�˩�f��\�����r�*�
��p�zCf����fA�W���x�c�KY:jK��:���6�P`W��LM�V��pC��˼�k�����6zjs�e2_Js;��.�`_W`�M��T�ٻ�A�~��e=�>���,.uV���q�f�<���9�����?�����s"�|zx;k���������p��vrw;�f��	���aSF�°�^���=�M����i���|�u"7���ۚ�i�����z)������8�;X�L�?y��K�{��'���ǩWA|��h�抛���;F �eP�Md
￤��Ⓘ6�~��8/L�"l��̶��]�s������J9O"�kb���MEAK|�IC����6��k�ʳ羘M���A�%�@B�G�~h*�F^�p���p��Z_hg��)�|W�ы�x��r+ش^��A �	W%u��7�K M�z�.5�b���!�r$�ɂI�@h����~/`'�:%�4�ן��I�?g��V���k�������{�@��gv���%�|��Y��kz~>=\ӋAC�u��g4M�w�dۦQ#��G+�;�+su�򎣖��e�Ix?�p�R/�y`����*�_s�b̼ؖ��IF�ŚXnK66�O��B��#����	v��0�)�ߴ�|��9s����}.RK(Y��`�,�'��n�`�x�?N���ed���YV�1Z'x��� �턷m#h�������òp�nX� ��9Ȓ[wA�t��3ߞc�R�����7�[Vf��	��<{�T���޾���,�STԯ���d���&ң/���Ig��ތ��Y�9Q?B&�K�s�Jʫ����=�s�T	 W�z������4J:��ޑV�ò�	 C��(/gLR�󃥚DQi��F@<��3��j  ����;w1<t�9q{�,	~^�$��Ǐ��ݦ����{����*F����g���L����<^�ﳒ08�5l�y8ᛁ����VF?���>�����$�@�c�T:�	���߇��JQw9#��S�\#���]P<K������6�����A��	��O��]��S�"�/\���f��N"uU��oU9V���K��N���Q�]���N�o2X����kZ\��S �$v�˱qh�j]< �goW�/�?��Tj�?��9,�Cߤ�@�tv��u�Sl��:�
F>�~���S�:z]3\]�O�+ȹ�M���E6���%��+d�3�'���FDv������G�BeE��!�����p���]_������NŔ���r]\-�j�x�Q��D٫I02S�I��92�f���(��帬�#D��H���k��>YiX2\Ju	�꥚��,�M�9��{p,�B���K��KWI�C~S��H���,�i�{��O�!����0'O���!D��6�{�U�87��u� [$�vw�W!~weM��*'�-ԤN,l9	5=�ޥ7�U2����vdߕ�-��.�����ⱨ�`��g���u��N���;�*��6�E�􋊝K��(v&�v��-ֲ��C��yt�����5G�Jʀ�NP�'q�Grv��uߌ�d��9Ț�`7D�k�[w���������MD�5���F��!p-�#��Y��E6�s��d��(`��l��Zzb�Uo��� �ie|��Ԇ�/=R~wv�3��/Z�Fi2E���J�]wC%)�����`RB v�$څU��A�8fG`�7�c�o-f�	3d�� ـ�)G�:XV�T�?�kXl��ª���'�$I��g��a|y������-{�uu�9�������mޜ6S&?��%.(�����Ϟ�)Io�"�T��<D��
�����~�tTw�c���db�$�F�u8ćE�[͕����`�9�����R�y"M���tA3���0	�i�!���K�n+/�x�K��2�-k���\Sj�5b�VT7LYFS�2�ވ�����#�����"�x�����*4��s���\Q"�ƽ˫'.��9�*��~0�LS��/nIOb�D��h/_N�������ǽ����ݍȇx�R���^tt�3H�c�i�h�1������?pA��@�\-������������>w��F�p��U��UN��u�"���Ѹ�u�����Հ
].���Y�<25�X��I��r�ϛlj�`\�'�7l�L&~2`ͫ�� |{O\1�7v��p���@�����    ��_N����>n��[js�X���~C�U��w���&,{ײ�^j�������f'>g�H�ȟǗ����`�x3�^nd|��]�{B��~^��F~�3R�LWQ�sS�,9�ֱ;�w�o�N]���DC��M�O�P�KLV�.Œ�̬��##6�9��o�V1u�^ޥ��JԦ� ���'��f��Q;dZ�R�`�R\�!��ˍUC��Ċ �8�Vd&��"�m� h��, ���u��p"o���xoh �z���]��O�;�x8�QPk�ǥ��/]�; ��6���7;���T�w^��CXe�������xk߂]���R�E��y�
�c����N�o�7�5���L�>�4z�y^��`�)"��2-Cox�˷k��u<\bN�����ڗS�(q�u'�,�*{n='Q;����q����Uu<����	�ؙ}����aY�<� �j��̗Oػ�����ǧQl0+�B��%G[�4?D�O��y�,�4 k"ܖ�5�S�X&�����v�z���!;�;�͘�w��X'�rN���� `�t���F* ɉ�K�(2�(��GʼE���b;Lo�%�-1��Eo�b��|gY�0�X{�Ce&2�6������i�x�v� �[�N��L�e_]��Z�U��%�gf���8�)H�2Nܾ������-iY�2��w�i��B����J�>�w��j�N�h�Z�S����|��pR�~ݛL�r٨���T#����	��%�Ҭ�c{�>��_�ǫ9o>�FqU�׹7�oK&FP�0I䠫7��N���S���o�d���[p&`�Ƶ
���˻tM,p��-�{c�
j;SE���6B�F���[��ˉ=pؒ冺y��f�k�㑚R�
�a��2J-8�n��T��Uw��^�Y�̷���rԍ.Ǜ@��H�:YF�QJ��f3u���u\gq�*z�;�n�&J��%�T���,/a�*�������R�`/l���Jt5����} 0;<����mO���h7�KQ ��3{ʌ�2E�	��w�ل���w�{��·v�^^�&y��0�A�w�a6�
Ѯ���Ꞔ����d�#�7K���Y�o�S��~1��'�(��U;��V�n��=Ѳt�O�)?1�O��E�l����K�����uF`�)䔶~t����x7�IW���F�:#�� w�����C�����e`m��[�n$}�M�᡺W9L; ���ְ��N	��d�hF�������7�?^4ߺ�f��И7�\���F�;F�g*�q��W�X�0]BU�gJMQZ����u���Qcl;�
�U���2��Z�	I��\"욦f�5?��i�Ա,�����v��G�
fE�dga(���7�q�B&ˎ�ɣ�)�mC�ǍU
be+2��]�QplJ�8���́Ңa��P���3Z��r�ö��Pt ���chW��Y��]cg������w���+��3'��-;W���KQ�N���1�vW`�&���
��aM鿪e���Q�y�\���cjO8���Aw�t7d��<B�oun�n�r��h����7D�� X(�:kB�R��K�����[��0A�2���j�0\TF�E%�%�W$׿���^_զ�����;��t��u�t���q����J��ɖ�����&�S�7�����Pn��/N�q$S��n�W���IȘTG��,Y/�1Ȑ���T�LT@�HŨ�1\Q�V	Zz�D�sQ��_����ģ5,�?q��Ր�v�K���$j�������Tj�{�3f�7���q�*~<�\&�N���)? 	���h h�����k/W)d����ɿTK�Ke�iu��� ʙ�R�{��0�(� RR1���F�IB�e��7��`��<��<��X A�'3�@��_/�-~�-�Jp��͙�N�׌뙂����5{|)'(��ys�׉��^2��M[2�����P Ot���s�o*g��]�J��k�R�x��|V��c<���Z�ٱ+U$h� Y���?8�׉��rʺ:R��.�������� )�<���p�_�*7�h	���g��x
��`�L����+Y���ȁk��*
��6�Ln��^PR(_�'�����>�Z���rF��|�Y�".U��{��J3��6?�� ��_��@��l�(R}SN�i�z�*��/�
�O�w5�y����A񫩞�����^����l!Պ�w����Rǹ ?����'B�C$�%�,{3*J5�� ��:�E����Ҭ�R���m�����X͊���j�����$�#D�q}Ek��H��'��E�Gv�၀w�N�����V	�ք�q�V
ݤ�I��h���WG�9�TA-4�o�� /�M��E+���W��GB�����8K=�Cw�TS��,�	����n�Y���������;'��hz/-�
����>��k�[̕F؁I��b�J�����gqa����rf�;����������&���7�<�j�^��
X�q�!3�cq��j�~Ԫ�=�24d��@2�G��NN�{�pZa{�+/��5/
�w�	2<���?�P.Ƌe�|�kaux��P��O�]�ώ�Σ�
P�֬'> ��	�Bq%���^����Y[ܕ��]S��i/�}rz��w��ш��J���%�F e������h[�n�D/U�!��O!^"��� H���Yeϋ#�Ν[��q<�@$<<PK�՟e��^��'6����D��O°(�m�W�*Mr��PE�|~1[p��r]VG���+&����o�3�j�x7"QA�Txt�j�J]�A�?�V�Č�(>��?.t�)O𰸻jg'6'a��EpX$��ONQ�<��;�x��)�^q��S�;�LB����=O�U�G����ōÌ�Su�}u0'qU�i�1{�|�t.,v.�o��4������{ohߣ����?u��,���yY)��<P2���9�k�x�p��6��L���-��}47�Kl4��q��}�5�6��#@�wǫ&��I��x*�͈F�_�C����&�;	A����ϖm�/G���޵p���x�=%�:�:��t�����#��}#X���&_o}j��pE��
X���I/�W�m}/wcB����U�<��G��
r�m��য়Ͱ�k*Fyaan�`y�&8�sS5y�"G���5���E���aز)Ԍ��� �%	^���|P���퐕\m���rl����Q��ח.�b.ڇH���f�c� ��z��~�%�m�:'=h3��{��2R��C_\��稺�1H�_�]ҍ���uڽ&�R;˫�\�s�1��K��-�O��tw�Y�_�����me���۽��/�cvi	̋�g|OZta1��u�I*�e��%��(���7"!#���P��E� ��d�7`}���W#���y*۝˔���ȑ ��L��V}_��;�]����Y�yo(�k�MVRk��s�:o@= yE�x��f�96�jO"�s�ҳ�ᜆ�\*�Sj8��`G�n�z�(�y`�2b 9F)���y3%�%�O1�˙��/�e*�Na��)R�w'��0��&����Ҟ��G���,6�����{��u��w��  1{�1��`O��xe���?��X��nt-e ~J����j�s�a�[q���H H��}{��K�I�A,�W�<��1�q���'9����!Q�G�],y "`�3 _o�'}a����$�q*�Xz�
���J�5�X�7<�^�������1����:Y�R~�X-��e�%s�����4�Ǖ��޿��ӱ��e�y�A�.-��S�iX�~��e;.� Z�B�������&\B%���/�v n�8r�&��ѿ����L�R���?��F��������{�S��P/<��0���u���º���j������w��⎼��C����R;�����$Oh��ɞ�z��l>�7���gMR�m�}{@ �(=g2�����Z������qc����;MS.�Gl� ��Gi�pFfO^ڲ�E�2*�@���w ���8�=:�    w�lo��4���+�8F�r���9�;�k]ϭ����"}x�ú\h\)�,g�QD~VsU�	�޻,����;P�4O$�qT��,�{�6�4���~i�*�:	��J���_�4V��,�<����6�n�9&�(T�c$v/����e��T����y�0?��2ְ���H�b��[iH�<��6O�u�:|�k�g"	��~V�a���P����)���#s���3���Q`B�����.��;�YU,�B�1��P�'��ˉ�|SŴ�*��wEDh�wP���ۏ�zÆ����:/�/h��.H��J�Cو�HJ�� �5T�`��ݱ^��}��b�ǳ�N�/�Y)�c�XnӬ����q\��y�TQFpV�H��1����ө��s�c��V�"�S�w%�m��|�ݠ����k{=�0�y�m��d���Ӣ���t�M���{��!�Z ���I���y����S�ye(�O6������*f����5�p����_,߲ʹ��XF�z���0��Sy/ ���F7H7Ax�e
=m��?�ߦ��V_��x04^	O��kJ�6�er��9T��(����p,�.63���<� ������%:\!���sP��`�epk��D��}�U��q,a��D>n}��r��vO�v�w_�_�`^A��������K�LX�]A�(�Z�����j�I��)CZ�]�����q��#�)����h�����Ū����cE���+RȢ ��ui�l���ѕ���e1�>��6^>��뫽��1�dO\j�{��-��l`-�~�{�1���H_�,��}aY���~���cQ��%�/�_���}i��8cӒ��컗@L�5 @�BC�m�Q]��Md���n=�$_�_.����d��fI �0���I`<YO�#���@�y�vr���Y���xY+����k�uyW��/>�O�/>��_���q� ����� �4�a���(��$W��4��Wc�����{+���s�G��N+�'���"�l�G��~荟r�k<(2�ыa��b%Q�Ƃ&��M�!Ҍ�/���������˖u��b�[�|�B����hh����G�<z c%{�w���2X\+����'q�p�9����U�1��)��y��e�dpN{���T0%Y�B$�ݿ�p9��۴���=�W{��@�5��*$��j�Lͧ�����t�Z�� �	��e�<�S�tp�ꟃx�a4����%ϟ��3�Py����xh@,O?���H��'���s�>��pyl����bu�qf~F��z�2tr�s�a��9F�^��o����;���v��ò�j��1����u&�GH\� >c��'[�&6����@����Fם��u6��U㈬�\�x�x'�<����S���[|� t��R�a��Z�"�~�;��d���I�]�S�J�m� �t8������-᯶˟&��ۡ���gqÿ��yR����!�W!;�����e�(r, � {f��ۈ��']LK�F�s&�w�|E��=����ܟT�R{����O�=v:!�;M�n'� O����w�0�d�By��y�������/q��=c�{9v�+}�ҹ7�?�⫮9�pa����|�Ǐ$�#o�(��,|�.l����|utO�{���k,J���E1O��ҙk����`��Pk����U�!!�>����E8諯�W��͢X�RF������>�'��ȝ�(��J�����m7��EKX��T�;[Ә��aX�����<t ְ�������*���\��ܻ����Ǳ��
��̧��P��2����.��y��0JC[�i�W'��vJ�����m�����KG_��P%��E����βx�@��q�W�a��e����c�-d�*�Q�N���Ц�&�h�`�#��R/���9�y�>l���O�Z�� $Fƿ�a[����uC�Us��P�NT儻���\0o��J{�J��j�4��d�ӓ���5��D�D/����ԍ�k��;͛k����c���*{��E�$��n
N`�ԩKxH�Kr���w�~O���XҬ1%.u�}ނ�2L*��c�TƂ/�"�#�z�0�u�ؠP�H��XX2 �~�]< W�f�p����y.�a��xq_҇�eL�tO�k����l>r��{o-Jؔ�ތ��I�V>��_2� �u�/g`4�X>&oҿ���p����Y�L_�~��� U�w�k��RMצ��t�'Ha�=�pЖ�����z��aǃ䬬���'�u"M�duʕ�ٯ|j�^FYpª�K�p�DE��7Bنrz{)���?��_���2T�o�d�>I8�`I�y�#�����$�#~DR�'k(��'X9��X�Y�.���<MN
|��Y���N�Ϛ����8�]�|��B��(��N�0=f�o��"��&7#��#$�����"�T��]���f���U�j�w �#��� ����|@���?Z9ߓ�KyqT���.��&h��-W�[�z	�s{��bz�PX���W�n�m}��o����t��Լ�(_RP`Rwr���(L�V�.�>�wo��4��?Ԗ�J��}�#Hc��Q���[s�/ǡ�P$�_�<M$�
��p�g"��+�r=�P?Y��~Y�#�)G�,��SG�g�R�rv����1߽�L.ȌV<[Ƃ���l���q��$u��s��Z�Uq��� ����N��.���E��?��O_�o��c��Ǘk��kp�-t�ǎ���ȩ[ <�����/�fKwv�b5w��W�w��V����݂�������I����Y���%��A����_���t�	������͘�lN�$��u��|,	�*n���]���Ͽ�A��o�}�][ّ�'L�����PO���rR�xQ7tzDQ4].�+��{��x9W鱹Nt7w�� �[���c�#d�G�ťn�ή=)���a����<s��3��VCR�Ov�k��/]�>�D�����?WрCjA���B���v%��~��5���B4�^�� ���)���n�t����|��m��%
�fK
	�������:�7Ǒ�(�6f���{����e֫-�F�����`zl����`��3`�(�e�����6g��0��7�Z�, ����w�w�7WO]�5�J����~G"ȳ�9�!$�M�~¦��Ak�P)ro�y����x�y�T�]�ʋ��|���O���9v�H�=v�5~����Sq��l^(8�Q!��j�5+��nxFI�i�1� ?��u��^��6���E�k&�7�e7>{ֳ5ї�� ���j���-��X�Me��nC�����N��}k��
`tu�ϸM���ݫ���)ƥU��J����n��Kx�4dU��B��3÷V���su���Í�y��|����W�{peY����t`T�A	��+���F�R1��
��c�4J���{q� 1�f�&��^��o��������cZ�9�__�Տ� ��/?��r��2B�����T��k��:�d	>�|żcڠՌ�$�	E�Z ������Ȭꮜ��0���8<{����}��f��`yh��\�c�.���ς��#��Ł�r{�ﹷ�4�}�JD^�<4�ˎ�b��e �'[�_}�<�'G�Ai����{��ӤE����3�d�� ����� �fUY��ۿܮ�آ��Gn�$uu��SH/�i��{ǻR����"���eE�/9h�C�"��7�,�]����M`�f������i+��*d��P��^�TiM����z*����x���ɛ�{-��O��u`�7}�{k��O���M|K,| O+%h�1�^O-3m��NW\�0��j<)�_���Wc9�� �� �����ӥ��;��G|�yD����.�}�*��Z��O?�&�g���{|kw�ބ�ͪ��cSp�e%xT�+�lH�"��Ά!�񼣵���	A�0��G7{UU�ֺ�c7���7W����#&ֻɿ�%�TpE���m�97�y#o	u�#�֓vJľ�s�W�j���=�    ���RaY��@ch�j�F���~� �}��X��ߙe�J}ڶ����R��>�5xIbQpi����헼r}Y�T���dNCpK�����-�"�{��p�l�����_ w���6�\L��o��B�m� �	�#I�MK^��tS�Ӧb��ӷ-�"0��Bʣ;LX�w�|E�Ik�~�x��pm=^c�}�9o����M��]y�F{�Ԥ��ǭ#t<U%ܟ�s�@�y�>��n���a�Y���|~������w~<���x�;��A2��2�6��v|>jE��S�mx^=�W\t�p�Y�v��z�)2
����Q����'*u���Ҷ�Ր7b�4���6���qn���e��H��I	<x�qW"����V;�khx�W_D���q��� $�y���4o�&\��'ŭ���������zY�H���G���L����G�����0 ��:���/�a� �M��  �e
��^ۈY�yyQ�Ɣ���}�r��)��J2�RY���W ��
pn�[g���鴭��R���O@N5�n��s$�n��M��}D�% ��vZ���4�qwH��ڹr���x m*�)ܔ�2��$���G��Ħ�")E��m��ˡ�a����#�yy��E�Rbq��!ѪqaT�CtղyjzW�5���5R�^��1��%[BP���>w�I��r�2�}{�a?}�4,d[}c��x�9H��q�]t�z�\狒��̌�K2�F���-������}�@�U<a�֨ *���%�=��fۿ'�7��1�T�/Zm+�9��/Wx��k֫�m;��Y[N�z��o�!%Y5ij�w,���o��������*��4�Ԃ_��Ƶuԩ�ٹ1�f�N��O{���b�[]]9���̾�Z�y��|�V�#�T9Ch��'�g�6?�a�C�(��z�YjD��A�ƾ�Є1^*��Y��ޚ�mʿ4C����Xv�3�2��u�IL��ً�!���&�/6t�8�1�[�,����W���k1ꀬ���C�+�{_5s830qq!�}-���{惾��LM�C""�?�����y(�؈��%޼�z��J��	��2�n��sl������:���5�����m�j����S|���s��]r:^���ٽ4t��|}3�o����K��5���[%K��7�³nl�m�ܴ��)���O��������=���ڛ����c��&���������-
"y�rq�����ktqZ�F�~Zr/]{I*z�q�l�o8uؤ>?�TV<l�8G���5KF����l� �c��Ĉ3�1*�nW�cϟrڔ��cޞc_驢�;?��?C�����4�=�����,Z���Lq���s@M8��Cxr�"�\��J\�Σ��r?%������0��O����<����T��ꕥ^ �\e��t��T��/2Y(�Ɯ<S�/F�yK�k9M$A#;��6��)m<�W�=-!�ۃ2찠]����l��.Y�V���Z*�5�37��B;Qbwvߕ%�Um��|���*&=?UU�1�1��m����̕�{r ���-��S���4%A0p2:5@��:��Y>�J TY�DS
��?�ؘ8�&E! `�:~��]��Q��(��i������?�s���(�>׼���/��s]`N�<���[h�����Z%��)��$�w$y�>mi��̃�\2�?�Xh�н����� �Y������i$��������س��IX��(��u��U+�--��Z�L�fs(�7<u2[�3�8|Հ�ϸ��?o
�q����d�l풅��O3�>xE���%�)/��EqtO�
�i�8�@KH������ָ3~�g�9s(4=�z�Nz���_�}��94y�g+bW�|ģ\�������F�O���P�/��d(�T�Y��� ��x[��ͩ~k�����%[�	@����1jK��5�:�NՊ�bl�6��q.v��p�6��ஔ���D�^��֖䷸D\��R{^Xr�3
b��E�M�x {���\2�^�`r��J}�v��:� ՔM
>+>��	ߊ�pN=�暯~���m��V%�g��Lt�&������@>ҙݻ�_.���Lf���-	"H4���<;�����U5a_|���~�K����#׹n��xR��_��.���Œ���,T��	 ٞfŨ�������~[,7��9���.A<.������z#���V���]����姑�џs�b��&�]�����"�
 L"�E��Iy�ێ����_���G�Z\ػ����N�� �Nez���.p��9��6wiO6O]���&�
��?/�`b�?�D�ON���}	IV�
�2|apR�}i] !�Eq�{yĒ=p�4V	ryYZ��(���� �V�/��u�����[�u�������k��ۼp��#�x[ԠO��kn'ӹ���:O٬�u��0�����r�Seڻ#BiQ�mȱ�
���<��a��}f�/4Oc�?�,ٞ�wo_V�w̶a�@�w�!X�ӣ��̾��m�����I��gel��uɨ��!:K�4��on'	���d�u�}����K�%�\�����I�[�� �Z�|m�I�ġ@P:c�[��W�p��/w��U[ϯ��5x�"��3�~��� ��٢-��'0��]�!�r�ӀKԑex�O#�}>�p���=p��bI"���H�6}\���q#��U�΃� �^�(V�z�EIєf��c&�?\t8��;\i�x7�T;<}n�̷�]�܂���� ~�2Q<��p5�W��a��L�|SD��8���|�T�޲�?H3��F! I��<>s
��^�L��t�~����K5�c�*C��{�i�+�"�qN��i۬�2Zg�}�3G�x�2�DI�vL*X���d<l�v�'�&1��k�<�wX��N{s�K�`�8���}^�ރ��a�)(��|ļr�,g+��OA�9>A/ϩ�)�5�M����^��Ҋ����0w�F�I�gw4��'�}C`цR���b��M'P�H���u4%�Ϣ�0�ϣj"a<;�4=�P�o������������<cL������k)-���J����|��=��V ]z"�ds��	O�O��ceɞ�0Z'�������%S�֗i���=������9�y����z��[��t	�3\�Kڡ\i�;���m׊L��L���ɝ|CpCK�Uk�x�L�����L��m�d�����U��vc��o�:nHvya���|����f�}����|��y���'�AjB�1�XK�|��5V���t�`�}:c���I]}O*Hcw9�?s:]�Q����V�xb��K�T�%+�����MW�I7^@�����>T�/��@�17���mƦ����O��r�h�����Qe���kb󋄫�bd�:�eʟ�I(���`�<G��>���"��ݦI0m0����.���s9��aEg�ew-O���:_��{���m��7Na��옕��\{Ք�2a��Q���j'~�w���W���2�^���^�~�˛�|���58����g��z��:Ea�J�T��\��b�ǩ�1�
.	��xP.�"��d��!Wߑ�� �'��U�N�p|�~�¦����9�����W��:O�.��1q�|�=E�a�]l-�z	E��n���yp.o�0�?OB.�:��ֿ��S�L �Q#xɒ�kN�9:��ﶍ�$�>��*w9
9Sh(���w*7	Q�,�����l��϶�s�eRE�qR
'3,�kP��[$d���em���FX+�_�S��RN�G<G�	,�̽5��������W.	醴"@X�����ޣ��]��B�8�ў���t���qqcT9C@Z(���+��x7A7�آ `�_�x�\��L�=���ǅ+�Ѷ훤u�0{*l����q����m�֡m"	�xq�Mp��]�H��=>�&����iS �e��sNC��_���O#N�_ti�,*`���_Zqן �j/�Q�G����|1¤�m�������+���T�$    ��u�R2�y*U��y����^N�W�t����~Υ��yi�M)���6�r�%Ձ��`�-1�s~-��j���#f�G��~۝�&��Ǫ��6�rz$��]���e�hN�*J��3���M�y���Tܦ�]�cJ����~X1���bu���T�]�G|���
�Z�b'=?Ө�_�؝hf��nM�!TfS;_?>�*%8�� ��q�L��:�5g��ψA��h���K�o�f_��=I�ΟnY�)�Ru������5O1���
o���XL��5R/ E��P��D}	�� ��̟�m�b�g�1�m�\�XHo]=��h���V�3��w1�<�p��>k���v���i>������VHho��7����iq&��ޅ���x��k�Z:����Z��s���h�>\��R��_C��ee�~R&�`�?�3Н�q{ggK/D<o�'=�z��J�%ܢú�\�`KE�B�q]'�ET�}����b��RiKc�՟�J��m�<�Wz�J��	������a�'������,�o��8���TV�,S[��kpF�~�2o5��рx�n�=H9B��LZq��#T?W-L�	������\M�� ��Ǥ1K�u��PG�ݤLծ+�P��:u�X���ѥ�y�M ��Nv��M6 ����O�P"W%����ĎF|FĹ��I���:���\�i٠�kf��m{=6��j`Rt��ֳy�JY:�����8����j؀`�w�x�j����~ŀ@ �UR�f�ٞ1=֌��o�WW�����Nm��_�����M�0�F��0��=��8���(�<*>껤�����X���|��2�=fx}sMBf��9�p�r��C�_��s�'��m����AsI�Я!�;N?%�e�t����y��}��Re���cLA}w{29<`�ֻy|�J�o�h��ڲ���U�L�!�����< Vwh{�㲛�t�zuJ{���617��9I^�$J�����.�ˁE��||nX^y6��ӎri� '
��7#���B����9.4�������������D��M��?�ُ*�'�z�܅e~_��f/ ���|xy���G)�Oj�?��w�Ó]f
�Ӹ�rug��^�F�R�K�uu��gO���lD��{D��+�~��W��s�U|�Q�ib�=4���N�m�aa^�WX��Ц��"�ק�\��N���4��id���3��K�R����jms��:@]t�'���&Ƅ�L���(�ýչ�����������]��rֳ��u���� a�����V5����z��6<��3H�X1�9�O�[0�0���4��7���m�M�̆�!��F���~q/#���gG�)�rà)�:#8O��M�&|�J������Ź��|�P� ��� ��.����p�G���e�T���¸�q`��uz�I�p��#b�F�j����'u4*H�H=A����vu��:��[\��.��j/�
}�O��D�Nخ*��u����,%2ơV���;�O�v9�g[�ēN�	y�at���" fc�y8I�7�K4��%�"�i*@�f����U7��j�˝zŋ�ŤjH���@�) ���<���c���y�<>�^�#�f�0��7v2�0��R��!]C0�k�=v�|Or�>�LO$����)��?�c�01$���&wD�"<9��*�;�% ,���u�Ҹ����ՏM�/�haI�cWn�)�Jl�����MS2�I�;�2S��l��e��� *WTZw\�c�zl:�2�KK�����=�)Ε���w��Oe�.	��f
]<�<�G�3���J�X��I� B\��>�a� �nɽ��-B��;5ޒ�
�Wo;*'#	sP���7�L��~�:���]|��qU���������ʇ޹�y�����|���~����Y�@�^X��3��G�cx'�/������z��v�)۞�8iUU��T��t���������]���M)N�uz���-��+S(Q혒P���x�:m�]��4�k']��xV�-����3[��77�/ݗ$����Ԯ5�ĺp��p�毋��#ʺ��; d�}�c���-�,�t�3{ɩ���_��DN���8�(z����+���U���qul�0M'��� }�~��ʩm����,_"󶼞U�Y|&� �m�|Pd���W��T >���*re���VM~C"��9;b$?n0��_��A#샺���~�e�!�}�p��|c#|���U��� �V��R}�Ú�jwg��}���w��C�� e ��MB��'��0���oS����5;!�2O�錢t�q^�f^��(����0�p�;p���m��o�����=as����0�"�i��MY�c�!_�|T�N
���x���6|�3��������(G�Bf�ߜ������zԑZ�a�@Lv�*P��N,���O{�G܌X��I��f�jj�]��T��ljg;9����W_5|����7�-o4��Z[�2��е��~� ����hjU�qX�m���pF�������r�%\�E��f]~-��O{^[e�ML��"�>�av&o������E�#OGɴC�QSO���i!��V�9#�=5��ύ/�E���j½�"�=�� ��;�M`﹏���%�,m��ty�3�c0s��_� ��S��?�7.(�m��:JB��B�wi�+�ï������ي�f���sG5D��u�|��i%y돬ȝ0��;���KkM��������~%��x:�<����1} ���kv��ok3��<>ib�bb+v��Pe_�I�l�k���.6�#���nB��ű��8�$�G�^Z�?;�#�e�{se8���|}/�b�s��i����X�L�Ã��L�9?x\�sC�7�X�k�bT���|��P��<�)�K�.�7�T�����ܗ�==(A݆��#�%���=c/�+?�(�xKz�&�J�mE��a�P!�����Xdt(���|Sa��K���s�㿝��t��b.'gUX?�E�Pa���셎�{�y�����֞q��ae��h��� �*@va�P��lEQ0�4�O>:���H��H$C�^����nE��Y�H倗'��S��X���w��K3���YB� ���Q�<	p�`y�^-jp�4����5MW_�BkS���C |޸�H;�ۖ�(Dβ��:��� �y�.95b�=�-�~���u͡��0�XA��$Ź�Ǯ�9-��3 �ɷz��lQ�
)����/9���f�e,�9���]���}�E[��_�yw� �h�R���p�+�#�/D���4���@|y�c[1MN�܁ɧ�z\��=M�9�����w�h���c)��9 �`J��=+�X����!�_��)�e�D��) M2��cQP�@o�)��R��TuY��?.��}�!��AP�u��WP՗aO��:�6EL�I���$��^��ω'q��j��7B��7Jh�`����h��g�	^�t��?��^�mՀ 6۽���煉q"�l\���֝G|���O�p�8ɲ(��%s����[�������G��r�#�/;��Am�5�� �
ϘYE��6��>��6�K���jޮ*�����{�k�����p����!�=HW��׹�s��\6��/��`I�gY�	�t6��/xb�P�<�@�����>���*�o%���e�}y;���vtˈ>�=��@��CoU�*{��$[B���Tk�3�����[[t@Z��<��t5Uj��0{�;�QBm{|dY���j��b�y��!�z�^v?*����٨��'G8f�V0|�����yg5<��O�˫AO./KD9�eʙ�ͽC�)�Y�R㫇:�]��Ҿ����um��$I�����d�@����5�V�O�4'a�׋V�?�!�v��I�uE��~�4c��.�ַ`�[�{��c�ݸ�oh��GȠH�Y��4l~~l�K������#o=�I��}[�����~���Ĩ��j�r��E9[Y�
f�Z�q�mm��J}�,~pc    ~�
��)Ӫ9�Fw����ʺ�<���+�ZS%����TDq	�G+�Us�����q������Y>[�|V���,��N��M�@���y���c�M���V](	;�"a+}��S۵�_��Ɓg�'mOW1#��kg���
��d@Q�M�Kk��򕖭b{9���$H��k�"^΢�\;�hSHLf���§�y:��׿ꨧD\uT�Ng�[ �����1���HQ����D���Xi�g����}��g���0" �]��|Y4]&��_X�u�P'Pq�mG���{o,$=)�(���4����R�.k�Z� �t"%��r»�T3��l��f�M�X���Ђ���:��N�xs0�ʗ������.Kښx:�Tm&�|��V�2��7������ԗt�+s$���ު'�ઙ6��A��7�h�cwn�)/һ�<̙�W|M�~�K��YGq�� �������wշ�/��"�'�Ȅpd��l��t�
�9Z>��f����`�U�=�'�r��x�����%o(Z���3`����TT�����s�f�T �*6��qdC��rA2,˂��Nm�2C����|��&M�>^T���˶0?pn��Z�R�oMf�e����]U�2vEEWY&��?ݰX�#�a�t���y<�0c��cT���������h�sM��y�e��~�r,qT$U������R���|�O��<�^����%���[����O[@/�& ��*�Q>x��]�" 2�ZDi�J�@�f@��$Q�a����ͳ_���K�o�UW'�����;� �?퍒G��h]��=���_3�)#�M'!����sx�]����of�nH���!X[��ڿ�e �I�w&c5���G<����v�u���K�璅�>��>�5�#>GQ���������\kؕ8w�1Bn��"�X�o��V4#J]T&�uɐ)&�S�(`KU-&��x���vU_����\ߔ;��.�:�&�˅�s]��Ď��mnNB�s�p��O�w�f����n��.���H>/l���E�4 �}^��cV�rL x��Q�V_-~�����e�}�'8��Y,�f�6��hQӄ��;�$��w��
(��N�=,�U�]6/���cLʆ�����4�Au�������Hnw��+�A�>*PS,���tW?[^S���"�g��7�g������z�ڑ#|�o�<�$+`���n��}����,]s���gU�����L��ʗY�hBZN���g���i��8W�-4���^�V0B���j��S��waot��L?3��_�.��k2e|x�Y��z7�O��z��EX�����MIx����M!��%���֥�^�856e��;6f'N�ev�b��������!v�F!�X�=������E<8,�X�V����r�f�bD~�|k�D���Ob��b�_Y��v �����r�ɤ��� l���C��%l�1� Z��iX�y�;��4`�n�k�,�a��˴�궬GH����v�K�����^��7�֮A����
�P�]2:i=c�+���R���-�o���L|��2˲A��HFj&���^��4��R�<L� �G�\ ���44���l�.��W�շ��a�t�npY��?6F�I,Uz�����$������~^`B���Q���o�x,#��	�1�&5������k���ܸr��-��+#L��0.Hr�ml}#�N�0�~pi9g��`U���Mzq��%����m�1�w�(�:!�s�y�G*�*]p����傉�@��e�;�x�VEX�$����Xc]��P�I�΁�a�}xxw_�=��o����2t�i��C����F3�6;Dw_��}�;��?aa
 �˾��5�?onkv�]xz�{�W~�ޗi�~0}¯7� 4��{Oe����fo�QUxi�>��v��K��φ�srp�ٮmɘ+��f:�T�Vg�@x:o���>
��K��7����v���6�3�]w��&ZG�����.i~�������v�[»w�'�*Fs�H�,l򻀀h�	L3� x�.CЦ�v�9 ��%���(�m(�a]yhb_�ًU�5��)wa+��)ME.ZBT��1���F�Bx���:pߗw������e�pQ�����|U���ˑC[�� ���^�%)1�r�~Sno�ߟ��||>oy �B��s���|��^d��Q���	JJ�b��Cؒ�n�}U7���_���U���'o�d4B��  W��\�����L �)M&�h@��o$h���ZӸ��B�'�g�n�IySv|y Hn��C;N��J�5�+C�]qx���.Q�wr�o��A���xѓ[yz�UP�Ay��z�!�dۊ$c���H�(_��*U<q��  㞅�	8�������A��g,�����6��[�Ԑc�r��Z|?+$�ђĻ�J��� �(xn�P�Vg$�~b6����T3�����|�˗ Ay�]5�[�w��F�6��=�]]�ܐT���J���sg~�?e��x�w9�y��?n���*��-��ȏ��]s舓7��X��~+�޴[ض�s�_׊���Y�?g�_��aGin����+wG��AX�8^s�4�X}������C0�!����DS�TDJ����_x���wQ�U�s���쵼����*sx���'y�9E�_u����o�p�:�{Tң���_J"p1�S�Cڮ���,��c���r�o���@y�owߘ�y\��R�z���޹n�2�����.(UN?/�@f���\^�jO���Ԝ��޼7!�u�~�>�:7|j�sǁ/��-� �*7p�f-ZP��S�\=���UN���S+R�_k�b�% �<��w��my1�O����}�Y(([���2�"tc������C�L!�%���i_��֘S�ɫc���/S��K��y��w�_��y��E�!Ǉ"�B��.�������f��a��ؖ�	鞝���"x�*�v"�ƒ��뮼&:���~BH��P|�/����~�?n����Jӻ�-�����3�3iQ�Q�0�(b�ﻣ&�|�F�n�MH�O�@����.ءF2V�O�]�i����oE����Kj�T��}n���G��ߔ4��8�K�Nw�з��IS��{�N��K�~��G��Y���r�M3]���B��K.�L�:�B���IJ7�}�|�$�8x�%�8
<Q�ͯ{���N<�C��R���)n���y�}���`h�(E=��~A4w?h����(�b!b�p�~��+��/I��R[ܛ:�N��z�Zw�>%��(w�w���=�[��2��6�y!
S�Ț������ �:����$I�K9Q�]ՙ/`�N��i�T_LB9/)�nV���X@ �l5��y�x���)�j$s�/a������N�&B���9�=�ᩮ ���Hq|��cb�j�ϥL�A��Q�R�d��^�[^F�TZ|4�*:$�?O�k��>}���>p��'�������O}�R��x�;�O��Q��^��;x�}�=>>�^/��$w&p2O��f`�nb�r�r3~��*z��a��ETA����!�C�r5�[5�0w~hS����N�JUh��5o���@v��02?�����Uˈ�w�K�^Kp����&��6�ݝ�{ �����0�������>�����2.0�7a)�_")Ns0p���}U����k��M&�p���n2x�ԥy/��;����{n�.r���2T�S�;�7�~����agS=wjoDUQ!��K��ˢ��ABl{��`�6�AL��f�(Α�zl/�B��mO�7EAc��Zj��z9w��S����y��^S��&ީ�g�p��;ʛ�f\'"$�����jm���<-�i{�}�f�qz��5)���>����撧C�����lV�B|F�M1h�:�|���/�� ʉ ܅`SWmG�C\�_�N�$K%_���I�	�w�ݓW�q!q<�MH|H��ԙ��tb\�遭�{*&Ġc�EC�,��)��{���    :z>)wE(VBN8^ϴk��-������ۥ�YFw�� �l�kJa��p������}�t��r�֨?�%�n�q*
b��.c�/��2�~?GS�=�F�0P:�M�r���5�=ˆ�c��R�~H�Z�m��s�yx{qj���J���/�j{��:^���m�%,�v��y�C峪�0UV�����E�I�T�6�4�6y��'�����-!{1��HVmo�3ն)�8��0���~�H�34ÿ>K'E�0*�&�v����K�ͷ����*a�cS0-/"��ýJ��s���t7��׿g�(� �Sϵ��Ș�ﴓH��ؕM|��k��'��4m\��,D;l!�����O�9�uԂ�}���xۑ۔x��똯��q�i��֛��Y�H�1V;��U�N�[He+��H����M���z	}�EIB���މ4���ds�̙yG~wuuAv��;�E8���X^0U!�1��������o�s�~��O��R�j�{�Y~|�/���GYǠ%䂪��!��<ɔ&��ϫ��ץI��S_�瞝eh�˄�$��'PI>��$�`z`�s�	=���7�.|�`m�� �}�	���W�"�'�/u�j{Za��W߾��}\���ۮr�ܔ�K�������ϳS�Q�?B"�1��TO6���ꔫ���y�o{]��C�%&���/�^f�մ�Uű+�a��w�%Iu�2��ϙ�{��2]�H���{���þ���#3�)��M�S7	�����|X�!<�W?��r����j�_��[D���� B8���J'ڰ,4?/0v<�����x�IH<�ГJe�pPk�����oI���H�_�v�Ig��43#
Z�g�0}��.1��z�-	A�6�YG���B?�{����d�ϲ�܇e�p8_�HJ����/���Jq;�u#y7}3�Բ��X���sI'qS��-`��ڗ�fM���U��&����H;���M�a�t�NfH�A��Ap<��#����;�c(��㩱8%i���g�F���8v䈢��q�*�ӲYlA�a�=�_�T����mL�����\]�{#������煴6�/+ ��&��]���k�!�ʏiz�b.��;<�m��lZ�"\�X�Y%�X�[�����Q^�S��h,� ֛�H#�U�uk&�p@��`�`a�������n�[��7{� ���1�� �ͨ�'؛����?(ާǌ�B/Z�r؂-[�}�w�'��5�	�0S��y��/��^;��R�����A	�r�]Ψf��I���:.����7~��l�p��L3���B����>�M�*�۹t�vF��'l�Wa��D�U�����m��{�S�^�!C|\�K{M���ّ����ξ=��oD����tω�QN�S����Aw!1�4��r�_���$1�If��������&�bv5o�HzSN��x螒V �3������=>�a_zPp2�z��)z�#�=<3U����T��0�x����H��\��z�FI�$g�Ëo��`m����e��!2�W���u�� U�z���(s��a5�6>m�nw��֐�9�(w>�V殘$&!0�ry��aȘ!��o�\~�	�K�[ A��;]�mF���^��ؘ�5�y|'"��d�5�n�f/N�n^��]dlc�j���nm���l�ln�P���x턫Ak���L`uxH/HࣈN�{���"�����#�_��K��o����ڛm��,Y���>��}�D'�V_�8�fVeը̗�1��C��fs��͙��9��o�ުNmN���z ���@۠MF��7�}o��h�N*�����C5�+�֬>�L "t�Z���TnDM�4��6�;�"9���B�.�����WMa��hAu�H���k�����;Z�������P�5�{� ��j�-��D�Ԑ���04{�j��bŅ�^0���;ι<�f����M�=��/W�f(����5>̈�n��}k֠k��׌c�+�����P��#<����O�6^��b, �n�B���:=��{M8*��r`y_���)�rr��Gt��`�I�C��)ϛC��L�v|����U:@A>V�F|3w�2��\C�;	�&�O6�i��7b\y���\n-���(��Q�*0�9��|4���_$�����ɤ�)���R��:8�H1gYo��2�z����7���+��Ć��ʂ�MU]<�M&�+Qmp�@IQ{��Q��r����!_.��L䆲�{���W���iB�,���#�CcTї����+X��(X ^យ<*=Wg�sM1ʫ+*��N���˥�o)=��l�:�gP�!�B�T �*=���WB����5�$<�=|
����J��G�ke�e̍�-Qq�|�Z�����_�R����Zۄç ����<���Z�
Т���H�
�A������z&l�E��.
VY��u`����QH�rB�
U��f���	��p����L�}�f�|��9[��m�qK�<I��3J0/�"����{�cA���:�:ed�����zC����N3	���<Ɛ�#��D�6�3±O3e��	C�"�����z��(̯�F|����KH3 �	MB���� ���u�� �c�5%Ǖ�jrӏ���a��=��I�ǋ�yA��3$i�b��"�����&���ܔEj���]���z'�3�ͨ���ڛ��#M��}� We@Z+���ρ�+4��<�1T`:�Y���א�P��*�e��|B~���*� 'Ì��n�־+���n.�8�����'c�>W��z��j�a�n0�	1�`�ɗ�X�oC�X��W�ݫ>�qp���m}>���6\[Sr��t�_͂)����V���	�t.��	A��h���P��{}�L_���x��`��A�o*6)��c�I���:Ԑ�z.��x���v�1���sz\x���'��©�H�?����Ɋ�G��S��KX����ї��a��rѮܨ�m�񵹚]���w&���u��-V���?�+HS�t��雅v�����"�Ƒiĺ��w��J���; ����˾��7�a-�t�	��FH�XS��)�и��E�ߤ@fZP��U��<]�\q,dɲqWSO;�\L����x��Q��*n_�sM6�߆�k M�5���MH��������b��|0���n�5��R[�[���NY�Bo�\�Q�����J��v{����:�(|����	QAXU���n^*�b�u�����&���{�����u�%�
Y�����m�����qgT�	��7�z5r�Vc���_M(ʽBLݗ���nnB4�Qn�r���N,��D���+�?t�4@��� } Α�h�,��/y2��Q����xҞ~�f��Ru\��MIP���*���ғ��@gz��r��\���-���c(�% jƪ�-n�l%���"T7Tvʻ�w�
�:�����0A}��߈����;r�ı�� F����M�<�6X;�/E�����X��;<u6�rr��Rqn����#�wU��m,�|��@p��I� �(�����Ｉ=c����ɞ���KW��]
�C�z�/nڬ�^~H��B�z9��r݁�?��[���w$=6l��e��X�ׄ�R�R[�0m���fs�"��J!�t�s���\hy<!����J��%y�]��ި$ߛR��i�)�S9���c�!}��i��ڢ�W|���Su����O� ���e�f�\�n������o�!_���|�ͯo<�ޥD&��6����4�%�WqE2��!T��?ʱ��X(0��̕2+�m�G�s��A��_���X6���*
����g> �cPѪ����~h8f"�UEn����I��&ڈL��'���yvn��R��R��8��^��v�Se�;�7��37Ax���R��w]'g�� �`iO<%���[
��<l�1sPxp�tI��PovQ���7^E����ɟ$����|�+�8�!.�04�lb�<� ��1�^�Y!��"�V��H���	�����}��    �1���^����pT��OJ��"��YQ�ܽ�k���v����>hZ��s.x1�O����Q�R,%�l�܎M�Q<�э���*���5��7FQ�K-�=�x�T����Ɗ�o�,�t�_�B�ź�tI��ͷp�>0G	[� �i�CB.]�K�e���<��E�P��ȑ�9��V�4������}� ���| ���3��P3����7�6�}��j�Q���0p'c�E�x��,^�o�nt�R�@�s~/A�o��۝9!�U��zl�e��Y����r��K�~��ثCG a�)��ܰ��&G���.4�x��թ���y"���Љi�[g�[�*`0G*��R����P'�|�1��L��P���G�1���]����e�n��T��^y�y���1�����qMm§�/g%��,{�	���� #r��.u�?n��8G���Km���O55�����S4�V�6=:5�.��m�>hH���+ �4�;�'�y/�q���]4��uu�Y{��c� �G��ױ�-�X g%�����6�1�UǏ�!������'��<�3���gJF*�y�Z�ww߿���E`G�5�\Y���l�`u�>c�%v�.�%n�bdS�N���w<�hޝ^�/v"�Qu�ʭ�UMp����A��8F�*������n��Z�}�?����1^���x��i�����0�El�(������ "���޸́�q��� ���
�.��	1�.u2ykM{�nP*ö�>A�x����w$��{�{���?na��_کC�L��&�^C�e��*73���9��L��b�뚹aǌ�:��V$Ơ-����t�uѴ��P%�(�dSS4���T~���5�^�T�Osd��I�[P�s�V�x
��K��	�^m��rdH��e�PPn!��orul��<�b���r������܇�"��%�����:�.������!7>�U�R�o�K����/0{d4OS���%��*\�E���󪝂�0d���F'��������������S僩�|B(��f�9}��u����\о[�������'�x��ņ�O1�C��<K��\	wzO5��V�n�|�㝜<�m���;�j[lU��KUo��M�+��*����K��0܎xH��e���H��%}ϵW]qJ�3��� ≬[u՝�Զ�yo��N."
p��R�����8B�P;�A�?c}����-*G��zu�{ˍ�$�O�|�� h�<�de���?ʗ����N���d+��I�z���_�p1�~�PG֯��>H�h����<O3�%�����Pk���ԑz������������=���ǫ��+I@V���#�r:�_��*���A��/�K���דHx+�%�hw�PEq��9-�i���Bnk��2`AFtNE5�@�n��z��LL�RKq"SP��d��į�%�qn��5*[�}�����ח�F����}I|+c!�}�
yׄ�m:ܝ��8AL�K��="{V!p>dU�hO@}�ij��� 60;�D�z��#���,�%`���+���wb�I΍썐g�3��P�+MRk�௛�q��>�˩�f��\�����r��*�
���q�zCf����fA�W��9x�c�C�:jK��:���6(	�+JAOM�V��pC�v��k�����6�js��d�:�&�v��]R��.����.���\�wM�H��M`�IOl�,.uVo���q��gy��p�'�M�+<
qig�
	�����c�8\�����8fu;���@�Vy��`��)#Na�r[�|�dq�S��oYh���9j�؉�g�m��i�����z)��������3X�L�?y��K�{����k��T��-�09kf�s�M�5p�e�������/�k�����W�@c��c6	�g��ڮ��	��}AY��+�51m}�OEASƂ�!�~�q?��k���s_�"��q!����� ��#_C/z*~#�m4{Rw��G��ڙ"`
<�}��Zn���?�  5Ѫd��pS�д�'�R�+���/G��,�T�Ɵ
���v"�)� ����/�O�?g��V���k�������{�@��gvǳ�!^��!�F�`�?�=\ӋAC�u���h��� ."�M�F����+��l�rt�򎣖����p�᪩^��8���_;T���e$K�y�Ŷ,��/:@sb�-���c�4EE 7�G$w]#$7�cVS��i�S�˙��}.RK(Y��`�,����n�`�x[?N���ad�
��YV�1Z;|��� �턷m#h��������4q�jX� ��9Ȓ�wA�l��3��1B�J�Hf���M�e������k�T�C��޺%��,�STԯ����d���&ң'���I{�����Y��q?BOd�X�Jʫ����]�s�T	 G�����ֱ%���~�H�ҁa�����g��_/��r��e�DQY��F@<��3��j  I���;w1:t�9qk�,	~^�$��'���ݦ�����ޓ��U�C1��ā	�L���|��y�$v�w.Nx���$�f����us2�c}�2����V (|�J�2����!� C�,g�!�zj�k�}�;���|�~�{�M�|�`� ���	��O���!�S�"K.\���f��N"uU��oU�f�{Z�RB'~��(䃮�ɦ�7�\S��5-.$�)�}�����8�4{�.�?�_oGL.�?��Tj�<�ɵY,��i�-���^2�g�j���+��:@mţu\3Z�O�+ȹ�M���E6���%��+d�_ O$�)H���J�����G�B�dE��&���������O�M����NŔ���r]\-�j�6x�qe��D٫I0~f��ȥ}����y��Ȳ��z�kV#q�Ư�C�Td�a�p)եP��j&���6�f���L�.�?/��/]�����\@b]�g��^ر��SQ~�XUF9y
=�Z�����7�Yu�sL�Qw�E��xw�|�wW�T��rZ�"M���H���]��Z�����#���,�|�⛟��-�J�{����R�.��I2tr�e3�F1ɕ�ľ�i�bgBn�
�dM�
]tZ��G�[��ܐ]s��d��%��~${'n\�}Q��w;�s���xMp�nr�k�o$�~S���|��`9� �b>r�ם�*�Q�o?}�,�-�\KOl޶��Sts@:�_�4�as�����n�C���5J�RO��^���u�0T���*Z8�&� B`��L�]XE���cV����%,��#!c��. Ph�0������*����s��V���s>I ��8�O�˻���ۥn�Ӯ�+��ԕ��,����.�g�䧾��%���{�y/_xJқ�����գ<��݂���ڽ�1���D !�z2��$�Fp�:�ä��K������]0���goy)�\��A�q������0	�Ӝ@����R�y�K��2����������0@k�z�q�0	�^4�,��H�-�Na&_j9��O�L/2��<���L��Bc�?w���%�oܻ�z�K��өB��7 3�,������'v�MF{�r"d��=��7������+�2���0���g�\�$�t��y��z��
���2C�s����?�t9%��	|�$=�����s�h-^Pv��u� ���Ѹ�u����j@�.����L��25�X��I�8w�&?� �ԇ�M��	��X�߮�+O��]b�;\ x8􅭼�=b���	t�o����T�#���=���&��l��1�LX��i�/x��
0�ss>GH������"}co=��/'����u
���i�"������&Y�"��gd(�����OA4_/�co���}��p�rW�&�mwR~J�2\b�b�ex)�4��l/;2bS��S�]�6n��NC[�^J�A�6Ur H���8�={���C��/e�6/�� X��X5t&V	��1�0�gj|.�چ�~v�]�    �@}�`ݤ6����[�;� [����	�ߑ&������h>.%��tq� x_�Po��� ߂'��w^��CXe��d�|Ƌb��o�*��s)�"S�_������������d~d+��O�Fo7��L�"��꥽������Z��:.1'���|s�˩v�8���q@�n�=7�I�N�m=p?�?wU]��X���C�3�&���a��<� �j��̗>��h��]�X�o�Ί���u����1�S���i>Ȝ�e�FM��*��$��.����� �p����g��;bi���rN���� `�V�F#��$�~g�M�#cޢ��c�Ow�B%�M1��Eo�a֤|gY�0�XkM"e&^�m�H8g�۳�=�l��Aηp�lk��˾�+���}K��̦��r�/H�2NҾ���l���%���4[e�3o�Ӣ}�ERy)V%��W}���պ�:��0�d���g�pR�~ݛL�3�^�Z��L�A��\�H�-7u�f����8gH�=���x��U%_����E,�A��4�î�������O�^��&{}��3K4�UH>>n�ekj�hvmI��7v����1U�Inc�j4���i��ء���MYn��+���r�<���d�wX���3ο[�kz��ꎿYK7���m+�T�u���&�o�(�ƧN���R��ǳ����{��:�39�H��n7�^%|��}*���,/a�*�������R�`/l��	�J|5����y 0;�K�\Ƕ'��m��e������eF�"�D��w��D&�F�w�z��·vXn^�&���a
�j���<,j�]ok3�?)w�=�y�W�Y*s���|�ڕ�􋉧t?�F����؉ηwC\�鈖��~*>���!~*���`K�֦_�.�{��}����S���}�?��N��H�������u�&IAΤ%��mE�[�DV������Fo!����7EG�� \e3�$��Q����)4}=T�E�0r��38�������q���=4���y3���o�ωmt�rm;�=EI{B�C�js���A�S���bt�q������Ɵ�b��C!���VNJ��1��f�3Ԛ��?��Jf�&����zg����~�3c}�^Q$���7�q�B�ˎ�飾)�eA�ˍU
be)2��]�Qpbʫ����/zH��qHC�&>��т ���ē�� �_C�Z������5v��|��qz��r��s:ߝ��p�zܾu�4J��nuVi������o֔��ZvI�/�{�:{�����G����]"��1�����:�t�j9Oo4�d���
�ER ,�i�j���͗��:�_5��"��`2�VexG�#�~a���.�J��K_�\�&������^���Y~�sh���������Ǎ�_*%�O���>N
L�^N�߬f� Ϡ�L�/N�q$S��j����=k2&������X7�1|![ۙt��,�Z��Q�c��J����_��E����NGv$�a���ݯ����_j��\O����p>��J�uo}&,�F]�|#����E�e�w�����@���v��.��r��F�a��OޥZ"\*��q�
Ã (�k��
^0�ð��H5H��
rէ)���k�	.�w�����cI 5�׳����ry�_o�U*�3mά��Ӻf\��d����K9AY�Νk��N�d��1�l��)�����w�� y�S寜{hutS9k��T��H\{�*��s���Z���O�Ok~g�|�T��m d٦���^'�.���H���(�"^
\g�} ��<��Ƈ�0���|�%t�W�|y�z���#<5�3��dr�N#f0��<x�( �ۈgz{Ǭ����B 4���/����Zd��rFĳ|�X�".U��{��J3��6?�� ��_���P���nR������~��U.�_N�R�j�D����Ӄ*���|��y��n����l!Պ��w����Rǹ/@~⋋�>B�C,�%�,�3*J5�� ��:�E�v߁hi�")����z_���
������j�����$�#ļq=��5�12��	*	��x�sx �ĭS�b�&k�U�5�{ܰ��D'm�mRj!^j��Ց��-SPM�eD�.ȋ�bS;�b�����Q�H���8]�g�GHs讜j����9A�8��]�tRz�^�a�sR�q���Wh�W��e��q��1�o1Wa&�[���-��_�����;�rf�;����������&����E��!�$����$�Cϗ����Vk���V��Q��!����>�4899f���i����	���t�׼(��I'x������r1��s򩮅��9�A�6�`�^��KM�X���h��T�&�ŕ�n��{nzL���3��+/��~v��������B�)�Gc��+�,\��R�	��Ѷ���w�^�0�7Bp��B��r2W<�WJ��ʞ?FT�;����x�H�x4��T�?ˢ���'5O�훉����aQڪ�.T�� �.��z�1Kp�_C�.�#]�3H��E~y�ɷ���j�������`*<:M��w�]�B�7&f�$�Q<��S"|�eqg�6y�؜F!��a���9��x�a���0������8d�\���)�V]���׻¾�q�}�.��6&�$��2�4�^�>�����[y�0ME��d�2u������$�O]jzG��f�s3���L ���~����p�ւ�'Ç�{k�2ύ耍�p�" P�G�����-t	��I:IbV�la�~���w�=���h��I
^8���k�6�r�K{�]W}>~���UQR��C�K��n����Z7���*$j2x�S�-�+�<�Q���X?�LvI�2o�{��v����#�zL�p� �ܖ�G ~��+���g��&��o��?7�'� Vd�غ�F�;��|<�/�&!E�������$�����R��2ӫ��O/��0<�W���z}���(�}���o�b�M��_OC�S�Ϸt_ۯ�I�����:�������6�9��m��l�l#�h	N�ׄR��wy�"�K�`� �#��Ti�%����awG�B�R�i^w m([~�����<,88�Y�)0+�)~rO[ta1��u�I*�e���u�Qh��7"!#���P��E���t�7`}���W#�����ν���|�HF�'Qk���v���.�����w�����P��L�WI�a:6̝������y�=��U��`�=��������4����R��2Ö�;��p�իD�H�������6J1È<ϛ)�/	|��{�W������8�Ū�H�C��T�/��i�ȑ�#�5Se�$M��Yl�+�=�!һ��u��u��" 1{�	�	�`M��|�2V�	E��/���]K/�	?�L[�R5���a�[q���H H��}{��%
�d�� &��w�����؉U����r��(�#t/�<��/ _o7��0C��p��8��,=t|�i��>�X�3\�@���������g�'+PJ�o����:,#2�/���v������8��]F�w����:�U,�,�q1њ��}�@�?p�rq��^*��[9���m�/'��x��ޭ8��0d��7�,��/5.g?��D�c�2G�
���T�D��E]��Gۏ { O{��#1Аw$�+�?W�Kmk�㥷�<���L�Wn�g��������kB�
lc�� F�'CI�z|�u�	9,	G1v����4� }�v^ p,<J�32��Җ�'2�Q�zD����8N^ �ǧ�.�r�9�r|��m$+w�v�ù뢸N������%��B��J�'d9��"�_�e\%'d|^<x��"�v>��i�H��jsY���mXi@����VURu�_d&��~A\~�XE r^/ȅ~n}�aq��<�T�������_�Q�쟑��Uc9��c�ڋ5L�=:3Y��VZ�L�y;���TG�b-�L%A�X~�`���%�9.����{>2��\=��,I&�
܋�    �RJ�#�U�B�!���q�(���7UL[��{TqwQD�6y�U_��H��-_���y)<A{wAzJ���;������Ļ�jl��f�N�7�,V��]�թ��5+�~,�m�j�Ww�؎�f�?��Q�(
#ث(Roi��i�t�{�l�D���y���*��;���B��n����ᵵF��<ζ�\2��[YQ�\�
�T��M���{��!�Z���i���y����S�Cye(�O7������*����k:�%�1Dy,߲ʹ��XF�zR���0��Qy/ ���F7H�����zZRj��T#���=��`h�|��k��6�er��9T��(����p,�.63Omy"����/-a �\!8��sXd�`�exk��D��}�U��q,��R�|��zf���=��-��}���y�����~�X���U���é��٠+�<��5ifH5eD��c}�r4�<�}��}SX��j2�?�"r�����^�X!�D�>ѥ�� R��FWJ�Bp��|�hj�d��C��A{�c ɞ��n_�N���������.$ JZ#}a�p�26�^M��p����E�.��v��~U�"���a3w��MK�e?|���^1E�� u\�	���Gu���6���ŝz,i���\:���:f�z��%�ðcV(S'��d]��UG�_d�u����!��
����Z��XMG�e���]ѷ�� >����<��I��a��(�[��\m.BЀCDn�A��}�[y]u�#x?�uX�=}|΀�^?��|�Co��;����x@�^�z�+��7|�pR��)?D�ybE�5 �ޟ\�w�4�H�Ylw��ePzu�?$/}2�Q��Bd����8�SQ��cFw�r�$n0G�"��*�H��J_���60#2<C��z�t*��W�B$�ݿ�p9��۴���=����i��~a������:����Dg�\:U�EA���p�"���'���� ����j��&�_*O���}9����ŷ[���#�^w��Շ�/ �'&��.V������.�^�:ك_���հ��#x����mz^C�z���%#��}8*���/3��/�[��I��g��]�dKx��F�ߖ�hy^��������]�jl���K�s�D���yx\7b
��vx��/��.�0^�=*�_�]���og�L� �|�(���[�o����	V�&>�n�~�]�|�������&7�;�i��'����92��Y�)�I���E���������e�I���Q�����.�#^Y��o��.w���Zjo�^��i���M'�|�����d�[)$ ��-?�P^s8E�9�{��~�%im�g,Cr.����r���{Ӌ�s-��ChVll���J��X":�&A�bx~�Y�va;
���WG�] N���(��'<}� �H�lXs�T��Z3-���|�D���#Gw�,����_-W�7�b�J�沺�6��|Ǒ;mR"ە��?����nh#������v��1�!ð*�W��XÂ'�|���T/S����𒻗Z���K�� x�|z΋d�-���,����׼���4��6	�:e&�22
ߟoi-�^��j���*�,B�_=u��3�>{���[6��8�|B����
^��S%9=�i�D�_0xL�Co��a��C��Fޫ�`I�Ӡ�V�!����氭�Fu~�稹W~(�P'����y��\0o��J�k�L;�Bi�^��|�`3���^��9R7�3b�S`�,o�1bk��Q:��Y������n
N`|��%<�Ў%9J�̻d��Pp�s,i֘��źo�`&�d걸*c�@��C=��<"lP(O�3q,L K/��.��e�A�����y.�a��xq_���eN�tO�k����l>r��o-Nٌ{�A->���|F7�72� �u�/g`4�X>!oҿ�;�p�@��,r�/q��z{�*�;�5��T��E%�Ӗ}���z�-cE!�x3rO�Îə������׉,#��.W�f)��:�����U�� ��􉋆�o����v3�U��8(K��n?e���&�F}�rf���#�G"9+��!I�G�I�|�PV�N�r���0��]/"��z.8!� W]��������$�����B��(���0=a�o�X"�ئ7#7�#"������ Z���ʮ��D/�x���m@�H����ӡ|� �k��ߏV��tD�R^l.;���	��f�U�T�^A���)��� �ջ�~u��Z�����O��^L��g�ۉ�%�O�Nnbׁ���ӹ�ㅋ���7SR�_�j˚�s�������z�x?$��l��q(7���jO	���)���c�J�܃�I�_V�*%�WEjKrƑ�'�������Y���k�V}�w����2�~˘P�b��#���q�&,ib�����VVU\-"�(ur�S"�e5S��(Y��?���-},���r-׺M�`�8������#�v9us��SQ��"i�tg*Qs�(=u}�ࠪoe)
�M�0�{i��ߜ��M\�>+��i�m�����Dp�Wj?:]qB���5�p3�����]7)~|m,�MKäJZ�hjG���7?�}������ߵ�)nz��J�X	u5:�.'e܀uC�GlE�����9�����}Ր�c���Ι�pKs�y,x����\�$��X����?L߷'Ϝo��i�Uǐ��ߓ��5�问zT*Kmm�d���h�� o/���P�j�]If�`��A,`ͼG'��M��\w�^ڟ����&Hk���@���[�(,H��M)$p
�w��w���G�K�xZ�S���=�;,]f�ڲit�a�\�7N���V�|�mL��z���A.e���=Q�Y���#���T��T:x�����k��U�1y��u$����i!)l��6�,Zs�J��'!�G�<�7~Uh���b}��<_{�������o��.�{�]}�_���;�T����9� ���#��f%z���(	0-"1�৹��ۋ3�&����zͤ�f������z6'��$��Zힶ����������`�[�n��}�����5�Y0�:�F?飧s�����`�qiUr��sTZ�?|u	Ϟ��
T^��{f�����=�.~=x�1�'����n����jq�,��rP��zmP�� �i~��S��Ru��y��q��8[����~Ӆ�#g�p�7���Dt�z�0��د��������ˏ��ܒ���<z~j~*�����`���/�ѷ�N
s�g����Cq�V�9ޟ�{|=䥹`IxV��4c�+M�b���@NO�6���Y�O�\U�PY�O�{����
�6���M"J���� �c�_� Fӊ�~�߈�?nWsWla��+7
�����)����t�������D�pO����/9ha�Y[w�흇\��� �o���z'��|TGlʟ���2�Ѡ��Ba*պ	
�?����?��/L�ܸmr��Y�OmLwm#�*:�ș_��?=οn�HJ�?F�wZ� 1�t���5�҆Q���ɠ�ۻ���XN�>�A�48{sn�ti���N:=�I�������Q��<��,�1W��u��wYg��5���*k��ބ�Ί�c�D�s�+��.\�4�Z�	C�?�ʠL񄠵��hԌNQ�y\�Wj�����O���	�ǧοɒm
x��@�Ҷύ�f^��Y�w��q���R�����d�G࿞���e�0�׋�:���@���Df���~F �}-���H�_���ru���)2����W��űE��o�Os}sk���O]�.˖�B�|ςb��ܐ ��lH}�u@��$s�� �� �����	�k���$����Z��{�L`$��$��t�ɺ`s�N�RO�47�C��e,�����Z�W$����1d
�� �k̻+�0�m�]�і���ʹ4�S� &V�?n��(
f�������� rO�v����j�i��L~ax���0���s�)���B�H��a��1�J��    �Sc�Mp^=�W\�j����cv��)
�v��)��ݱ���~�Do��D��|��.n����s�,+z��p��8)������ۮk�v`;�+�i����	K»���Z�ɼ/ߓ^����=w�s67�ZsƊ��i��b�-��Vk� ���,��l,��� �M^�aF)���� ��Iq+���0��m}�^�5����Ѣ߼>�(������A.�A~��h���=+�uS�z ��L�0�kQ?+:'/��>嫦�_�v9_i�\%��RY�|��W ��
pn�[k���鴭��Rk���'��^�W�Y=��M����K *> �zZ�����;��Jm]9	���N�6��lr�0��$�����DR�����D�C�g�:���#�y9��E�Rbq��!�rAX�Cxղ9J���5�j�5R�^�����%[BP�a�;��"D.�Q�^u�O����1[k�����B?�.|^=n��EI�3}������b�'$�i��%��FOX��+��
}�'KN\����>��u
~*��4�#�[��/Wx��k֩�m;��YSN�z��o�!%Y5i��O,�����G����k]U������z͝k�S��z
�f�N��O{�:�� ��<�rxi�y�~����r�|�K�C�����uG\-�(M~|�8��a�$"�Y��n�A����Є1N*��Y�����6�_�!j���X��3w�2��5%&	&w�����pt�&�/6t�8�1�Y�,����W��n�b� Y �O�+��\Uc8�7p�!�}-���{惾��M�C"B�?����+>�RlD~�o^Z}�Wz%����2����sl���5F�ȅ��6�����m�j���GSt���sw�]�:^���ѽTt��|}׏o(+��K��5���[9K��7��B\�2�����wգ�1N�M~Z=�)-��	���t���KFw����.H��eoQɧ���� n־���k�%��״����G���&�S�MJ�!���a�q8T���Y2���`S; ����C=��Q�z�j�s���&7���v��J��^��0�7H����{:t��/#Y�HS��zC��p��s�,�\��rTE�W�}��ڨ����c����~!gw��Z�yj��{��R/�
K�z��t��}T��/2Y(�Μ<S�/z�9*Kk9M$A#;��6��)����⇐��A�fP�6���u6�I�,Z���R-b��}� ��(����k�$��Ei��\�R�*"7U�ҟ��m��^n��������r��q���?MI��VP��L�z�}$ ��k�ʅ���:+6&��I�	 ���ނ#�׬��4:��_j���k�����2�c�8��5/�<���\�S>6l�uZa.���Vɇ�u�a3��9�<jcS��.�$����t,�r|�Y�QE]` �,D\X�d�4�����������c:a�>��4
xp��g��斖4�W	5C&�O�9����ęN��j@��g\�ݟ7��]}� G�Y&[�d����id���< ��� �#兗5�(�.��<m���Ժ0�q�t���ƞ� ���̡�����:�e'#~ύs6�����sǔŮ���G�&@gWc�ލ ��ޡ,�]��PЩ���*Z=@^���A)S�V�_��K���Q��1�K���u<���ۋ1q��{�ǹ؎%�HM�{�]�)��'�t[�ߣ��3J�yi0`�A�(��R�5q� �Ѫwɼz!��2�G���ӳ��a��lR�X�Q�%J�V<4�s��7�|�3�Wot�"�<3�3љ�P�G���|�3{vW���g��Lg�p[D�pT~=yfx)ٵ���¾����]_�<����#��v��xR��F��֛�`I��a�T��	 ٞfY������G���<찾��^���NzXkx�_�7�<�h�V�+�Wc <����9+f*6��j�W.O�'�@ `B�/�/�M�	�vT�}�&��5m?��Ņ}���Ĩ� � ��T�uY�i�X�u[���]ړM�I���$S �u�L��G�<��}ܗ�R�`�G=tW�����. ��좸�y�p�4V	ry=,6xH�Ϣ��M�� Ѷ�]�F/=����i�Tޒ�Ig����_U/G��K/an����(_s;��U�f=�M�)������$RR]����T��n�PZ�pp�~x��ŧ:Ͽkr\��D���� ��$K����ٗUv�3M�"���l���(w�9�/�ywA�3�y|~�c��7�Ⱥd�S�������w������J��r�k`��$��Œq�6[��=�i�m/HGy�s��Ӥ^�P (�ڭ�]b�-�8՚�;gg+��V�R�K�18�"�ӹ~��� �똢)���ס�]�!�|�ӀKԑex�O#�}�r0�O�w<� ��X��t���I�j'��I�����Ox�Y�G�8ͅIєF��#&�2.Z�T<��T��;~*�;�.���Ʒ�]�܂�����d�x|��j���54��?��]� E�� ���|��e�A��&
�H�W����)��{�2���GJ�ǗJE*@U�z�p���&�W�1DP��&g�4Y�e��|�Jd�V�;�e$����T�`�gV���U�0�D_>�C�1�Ê�z���X���g��qJ{��u��xlG�� ���������L�?y���<��Xk�����{9Բr+ZR�<#`�p� �:bϞh��O0��������<�F�r�2;���hJj	�E�a�_�jBa<;�4=�@���5��}�������<cL��n����RZ/k�ZUa������?|��$��C�. N��?y���yxs���0O��q�!�ڟ翫�W7�ٺ7�����ύe�Fc���[��	�{��s��5]����ҟv([Z%B��8���Z��?�i��r'�\W�aU�17�1�:z�#���x?��gm�����b�ѭu�2nHvya���|����j���[�|��y��OF�Ԅ�1�HK�|�X��������$���t�r�=N��{R@۸�!<��tMDe����ZY��w/-C>��(N�;G��v���?�C}�Pe�H�Y����������>��nh������ZG��'ʬ��-�����������Q�����s��3_��(Ā�6M���N ����w!T\���I��#<�,{B�k��\�ڹRΦXl fB�Y2�U8��}v�c���s�US
ʄ�F��2����[|�	�L�\ R���:�F^zQ�U/o��[	{�p29߫�����u
�&����<��"�ǩ� 1��/	��8P.�"n�d�DW��-aA~O�˫̏�������Iu��5��s����#H�:(��u��^�Ic �"�=E�a�]l-�z	D��n.��<8�7\��'!�~��tS�>��^���3�@OT^zH�5'���ib.ɬޙ<����4����;��x�,�����l��Ͷ�s�eRE�qR
'3�/ҫP��[(d���em��}�zP˦[�S��RN�G4��	,��{�������Ne�\�iE��6aU'}�O��zυʲd�=��Ϗrи��ōae>�@ql�D�s4C�-�}&����տq�и�'��9�]��MӼKjg����l~.�iI�_�4k�&������,ߥH��=�����q�^���7�[�C�9�4@��5j��4���5A�͢0 �>�K-�Z���2��ʔl�#*�І��a𼫯#**Pq����K���S����'E'�r��z��U1vs.�.o�6w��z�s�h�ɩ�T����	�D4Ϲ�t��C�u��:q�������[wbM:u��뚜�i��:vi�?��1%�(���<D�oJ�y�������+�aLi�s׎G��|�<�Y�G@*�.sC>����
�Z �b'y���T�/O�I4�
���=�M� TfR;_{[�DiA樷&�~��5k�g� {C4��t�K�o�    f_��I�;ݳ�ץ����+��<�Hrcʼ	��aM��<^@��'��u���@P�"��m�%�ط�r��@����ȋ�;�LE9�k~s�3
���vlgG=�H�C�N.�?X��r�Њ�S�řp_�{�{�ߣQۯ9P{h�N�O?�~�̍*�����hS��ɿ�"�1��[�I����l�@O�����Q$����1����#��`�ǥ��[*Dr���:�-���D]gke�r[�����T�s�wm#96^��QZ��H��_�� J�z�b\`�|�q��=��Y� ���W��*�eު����xݍ��r���3i�)�d/P>W-L�
*��)�%��������cR���:��PK���L��+�@��:��HU��Ҥ���Ƈ�~'���&A@��Ц{ ���>yr�"K� >#����$�����L.��M��kf��m{y͈B50)���G�x�\�V�.
69)N)��W��)�R)s��ԯ(`�J*ތ![�c͘��f\E�o7�wG��S�6��v�q8�IfE��o}O�'�r=�4^Ň}�Op��)R��,Ca�#��6� n��� �.X�}}(��X\nu�V��ҷp?�7������e�Q,Y/æ#�����K�I�ݬ�s�a0����d�?ލ�u*��o��-ז�<boW�3��.��y@��P�ﲛ�t�z�J��L�l�����XI^�$J��sz��o������q��gy9nl-�-��:�N;oF ����M_s4\�Ĺݢ���c��c������5͆��g?�����u����}ɫ� `�r��{9�R`
����VϹ��䇧~������	�ʍ6������j���Ϟ �'yوl'���	4Wj�Y�>�x�|�Q�i"�=T�7�N�M�aa^�WX2N�h�^�M�kl%���|��F?�d��,�Rb����,�H�����6W���EC>x� �Sl"LX�ʞa�B0�KW���� d�O_�7�� �o��Σ��C<�@�`Gϟ��~[1����?oÃx=�D�����΂���?��� _�w��Ɨ�n��`6��^&��ųͪ7�xR<�NS�uFp� C	�|M�����/���g��-H�OQ@��	�G]�듳�,���}�i����x���ō���_��Y��$	�_<"�h�
�Fs�Y�PG��t�(�nW�������e��Ҋ��_�M�7f�K���꠲;X7��I| >e)�1
�RK�ߙ�Y��o�>�"�� ��p�M��F�����0 �g%���69���b?��)UC�Q�bW� K�U�\��+Z�/&UC�}��b ��n3�	Z=�j)��3���;�i�;�pc+�"./���5Ú<#���tKSOG��D����r��s>�	CB�j�GQ)��ӹe�{�u'�D�E�&]��7^�{�m�y阅KR�
p�KLaWbC���G+�o���F�x�ɀ�گf�*�Z����\Qi�qm���M�a���x������)�����w��Oe�&	��n]4k<��mPJ�H�H���I B\��>�da�	 �ݓg/��[��wJ4�%����fXN0FƠ���o�R��
n5~Y>��\��$���$������u�ro��#t�/Q��W��4��k�˃�ɛ�!���<ʽ᝼[��j/t����	��t��J�r���������i����?ٕ_{ސ�Z�7IY��AqO�`
9�-C*wu�V�-���r��k�9�#ae�!��~�l�t���G�t_�`O[�S����i������.r:
��]|=� �����}�����P�9F/Y53��K[����u��GY�w7�r��N�ꐸ�!WG:�tr>d�����/�XY�)߭��o��Ǽ-����	w p�2�HC�+�E����o�*r����VMnC"���vDH~��1�-���=�!��4�u��}�:���t�D���D���ݫ��l�AV�ⴥ�Ú�J�d��}�(�w��C�� ���NB��'������!�|���
����tFQ�jY�b3���aF�f�1�p�9p���mԯk����sas�mWD`\Y0�䧛�D��_�����d���рS�}��g����34z�?Q��]��^�[����M��#��R���U��5ޝ<���?�u�s3�pDN�%�0�W�P{��� gS;��a�̽����I��>縿igy���U�Z���`�OC׺�j �]`�Ç�GS����q@�f?��kdީy|�_�/w\µ]��j����Bx���������_d�F8h���i��B=a��ӑ3�P�BT��d�xZ�V��gN5GI�[�����Bh�u�M5�^V����S��T��^s���﹏���%�,m����Bg��`f�ſ�����F��n�_X�\su(xrB�B⧴u���W�u}q�����j&��Qh}0_pijI��#+r+�p���˥}L�����go	��q�,a���u���^�5�xﷵ���41b1�;� �U��/�t�l�j��t�,6�C��1N������X/?N.	��k�KK�tgk����pg�L���"S���>�F?G�D�9�?����ǅ<�%�3�����)F���߮c�f]<��R�¯�"�x.����r��ٯ��3<�"�l�3�zp����I���SȐ2�=���i��z�"H��w����J���y��~&�!���	��-����/��
]�O2:z�����5�����Zm7�Gv��f�!/ r�d$a	�oȔe�H���s�C�����D2��e���t/�xg�@*���LYP���@�,}��Y�xe�j�hЬG�I�� ��������L#ک.]�tu)xlJ�x(���i�`��;�ܲ���΃�x6�d\�KN	yO�l�]�{]s�Z�2�r'V��0I�.���aNM�qt |򭞸1[�Bʹ4>��K��y�YA��~������ �g[��n���w����Z���!���)~!��^������&>2e�`�����|��%:��4��"=����)��u��|�xv@0������,Vޥ����W�\�l�<��`�BӄLf�H�(H ����Lz�=�T�Y��?.��}�!��AP�u��WP՗AO��:�6�L�H���t{Q�$�1�J��wB���Kh�`����h��g��_�t��i��JݪAL6��>\;���o��Y���yD�����T W���,�">��dn��Y�|kZ?��H2U�sd�eg�3߯�[�|�/��B1��u�F����i�ڔ2��-�F�m+"_��o���f}b/�©܋��l� m~_��5g������<V�%�y�e���l��_���Jyp�7@��]^�E����J��M�����v�����]���EG��Cg��*�h�-`�q*�u��ܶ���[[t@Z�Q��t5jp�0s���ȁ�y��M���j��b�y��	!�r�N�<e*����٨ᕘ#,#D+>m܍ZG͜�<�u�E,yŏ@B ���oQ|�rFdr�d��T��S��%�/ͫ�o_[׆�[I��(�o*O&�����B����RG���;��Z�|��e��'��d���i�a{+/b�w�[����|G��n\��3���2Ȓj�v4�����i������{AoϓĞ���e ):��~�K�ʯ��(���(g�+\��OR�3��nNT)ލ�n̏]��?o�b�ޝ�����.3O���h2�*��RD�v*¨�����E�\yu�~}������>C��$����,��N�:�M�@���y����c�]�����P����V�b���mZ��ٝ�RKڞ�"F���Π�'��4�ɀ�����4+��+-[��r"KN�{�7�xY��U�s휢M!	0���v>���s�{���zJ�UGe�t�`�9�<"v|)���g��8�    +M��0��#�,u���T��6^�.��/���:a(������Q�ɽ���bJ$��Ns]��*��Z�V�>�H���	Y�Ӓ����h}U��z\0�s�&CN����l_=������*_Jח�C���t$�k�h�vP���5�T�[~�H��Y<ܼ��Q^�F�= I&���V��g����`�0�t}��Z{�uW��"�k��Ü�x�����T���d���n)֎��{W}k��i�b�͍�̶��8�˫�����.mV�}�1�*��Ĉ�)�J��,/y]V�����t���?�Tf�+U�� �U�9<�#�\�7?���,3��-3$.� WV����v0iZ�0��Ҡ@�v�N���s{��B���yo��[�[8��E/#[�5�e{-�����'R�fD���2�'��|�ꀾ -����S�\l@;�k
uΫ/f��"��B�>�-�����!�D�ڻq"�M��N�����o��_�?m��6`�W!�����ަ�@�P������m� D,-A���ܘ��8��
𿼔�^_�5��̜�?���io��-�D����t���7���N!l:	Q%��<������Wd�33�����`m�~k���0�&%ך�Uo�G���9g�ڱ�Y��n/1�K�����6P9ru\�E]<އ�����g���ʵ�Y�sG��'��!��������fDI��¤�&�7�	��>J] �RQ
��44z]ۊ+c���
������α	����r]��Ď��mlV@I�`�[E'��L�����l6MC���_$�[�?n��f�W��أi9�<C�0J���6,c�qYA~��$|���}�<��`׬<��.J��Ѽv'��}�������2zO*��[]݅a���|Y�$o8/l� PJ�T#;��Oq�ۀ�fכ���5�1��Hw���5����>���<{�ݴ%��M=r�� ��?�+�0��q;���w�|s�h��9�K���*jT�Uu@��8O�ˬf8!-�܄�g���i��(W�-4���^�V0B�Z���5Z�����ag�FI���S�.Xb�5�2z�u����M�����f����T��;��!	o7^�� �X2x�k]�lŉ�Ʀ�7{�F��)��Wlvs{1-\�y#$�Θ(d�K�'���QW���k�
д�\��L ?B��Ϙ�X6��2������&�e;���L��[�ܚr�ɤ�7A��2�Շ�iK��O���Ӡ0�<��%�a�i�k�,�az��i��mY��d?�횗�?��忽��o0�^�0�w��l�.>�dt�: ��WVl��!�L��[<�)a��2L�O�X����N2�xP3�8dT�b4�~�B�`"�<���%Hէ��=�e�4�n�ʯ���O�m��q���A^�cc8��R�W�Y:=I���8~\��&T�:=��ޮ��J���2r-ΚpCjR���?��>��G��͍+',��r��7�)d��p[�I��9�x��_Z�Y}0XUr�z��BԪZɽ?����fy�m�8J�N��a�6�#�S�&X��^�r��r K����^�#�B�_t�H�c]��P�I�΁�b�s�'�/��=��o����{:t�i��C�+���z3�&;�OW��s�'��?aa ��\3j�)V��vkt��;�{�V~�ޗi�|0���C���ܳ��B�]�S���UD\Z��b�NVO�T�Y׿O��_a�k[2��w��.�{�@8����?2��K��w��������6�3�]w��&ZK|����6i|������鶣{��O�'�*Fs�H�,l𻀀h�L3h x�v��M��p� "�K�>v�P�A�.����C� ��2�^�R��M~
[���@Hiȷ�%De ��}g�tl�(���x�-�uׁ����/����.s�����z/�UdAЙ�м,��յ,������eY�A/���w����=���|<gy ��2�ґ���^�	d��Q��	rJ�b��CВ�n�}U�����>���<?7���Q�� LTi{�s��>֯2�4�\�mR���:��i��Z
�$�ݢ?3��M>���  ���R���8���F(5[�J��w��)�X�a���~[�����έ�M^]�%`����a��;�J�)K�1�Mo����= �Rd���o0�Y8��k�i�/�)`$.w�|��n�Z�uJ@9f*ל��w\!�C��4[���S @���k5F'fan�OU#���M�a����%H��N�Tt����o�Qz�F�L�mW#�%��s���^�o���>���<����0����N-��"\���њ��k���7��E�f����׵�F:�k��ϙ���w�Q�f��u�޺�K� �p��)M�
V��o��F���`�E�����DCy(������p���m<E�����߲��������/���5��_j��;�����uǫ$��*�?r"p�S��]���x�4)e]߰{�Cy�owߘ��o��T�)�����@��|�8�`م��}����20�o,���\�H���s|�7�My]*O�gE�O�;�8𥕿�R �Q����d��7WQ��i�X��"��ExN���'�����6�"/�w����k�o׈e+[�\l�n��~����⃀:SH|	�*:���5f�d�꘱ǿ�ː%�R(��Vs���77���(>���B+����Ɛ[8z��`���a�&6��5Bzf��y�ޣ򶁝Ⱦ�$^ݕ�DGY�*@BV��2�k}�������q{4�_Ǘ��NMIWL�����I�b������!�~�5d\@�պ�4 �?e��>�+�`�ް��o�O�XFw~~�"?u��/�USa,�6�(W1��}S� ��/�Zݩ�B�2n&Mݗ��'���.u�e>�4;�:zk���� f>��Y�=�F,�3��$�~�%(��l�-si��<���X|b���E�6��u*_�9��Ku����S8v~w��u^
��>�/���hn�|���P�B�� z���Wq_��>��3u�������]J���uΩd���2d4`u*��Bd� 7�5�Q{'� ������$I�K9Q�]ՙ/`�N����T_LB>/)q��8J�P, �S����<H�U����O5��ȗ��zQ��_�}	����-5�ߎ�9�-�v�� )�o��&�F�\��D�u/e@��k|ߖQ:���
	v��Zs��O�,Ƨ����	L�>���w)}��'��(��/n����.��O��K���ɓ�-��+��د�X��E�܌��Q$_k����vU��`6�zk�� �lU��V�&�ݭ�.-����R����r����	�
 �m}�?����j�U�V��2/}=��M��[W�@����a��5l���7|L��m�o��X߄��c|�$[����j��U폟ߘ��k��M&�����n7�K9�Y
w<k����\�l���s3T�S�;�7�~����akS{j�DUQ��K��ˢ��� !�=o��A�F �]B3G�Hp	=�r��f�'�,�~\-�`}��'Ĩ����:M�(�zVÔn��w�6E2����M�hӯ���؋V�&`XO���}޿�Qe��cZM����J�t;gz����h~K����GB�F�N1h�:�\���/�� � �`SWmG�C\�_�N�$K%_���G����7{O^���q��6�!�Pkޏӊp���֞����9�o�B�����G��X���I��B����L���ؒ��-I(�]���C�N"��0ˆ���G�������gN�� (�m���-t�PQ����p;�0��'�9�"̩�#OG��7Eʅ�3����Ė��(��0���r(>��8�mXt%FzΎ���e�F���i`	�]çZ^�PW���������a�Hɖ���Ɨ������Ź�.���QC����d��ξ8Ci�r     �3��9�\�#����uY:)���QY6A�m��m]�m���}�'*��M����0��*Y�b�:տ�ݤ�N��y����O-W�##j�V"�eV&�����Ҵ~��m�y�0�[�R�?	h�l�R
v�����lGnR��엯c����ަ�k�{o��/D*�����@t��*[1�FBi5����,ݕ�Hh�)J´/�I����&;��d��;�+��[� �I,��ޘ�"��)29��d�_m�W��]�6M�-���/彶�ψ��7�z���(��1h	8��/uH>*G2������`�ui�%k���Yf�LxMr~�;��S��Nb�'[�1'��.�S�`��9���]�^L5m�Y�7V�?ՙ��i�ik@�_�}�Jۻ0�4m�T6�)�Py�ʿ�0���ϳS�P�?"51��TK6����䫪���yvg{]��C�%&w��/�^f�մˣ�"[l��u�	%���Te��5I'潰2]�P���y���A_WI�����tSk�3x�|^�+0�G��fQ.�_�r"}=cim��R<"��[�t��R@��;���
�	�W��D�=��F�ju��[�BG�-)��ʷW��ʄ�Y�%�̈GA��a Ӈ�~`ʳ��ge�q,HoI
)[7��:޾�N�tl>��>o'[|�%�>,C���OY�P���|������!����P�͘S��~tbik�8�N�x��-`��ڕ�fM���-E��&}��bI;$��]�{�t�LF@�~�¾����BDE=m��	�
C��U��#���gkx�݌�AG�(���R�<&�"�3��G��WL5뿾����:��su��h�7F
��Nؠk�>�N[1���4��9�X3�V~�HÁ�a�Z�þ��>�V����(�o�C7V�B㖬C���>��B5��Ƈ���a�)щ�C^�l�f���o!,L�u����=y���f��q�Ag�j[����r�fC� &�Ż����Z�Em^v?��-O�<
�;�����l��F���&���k�/E?���P(w��kV蚄��������|�W�ɦ
G`N�4����4�.��Τ��m;��U�0R���*]�ȱ�xB�ۧ�y/w2ߋ=da��K��`i�I�3���Ӟ�f��)��x#.N���'�NY�Ne���݅�p��G�����;$�nN7f�u<�!�o�.f[u� ^@қrb��Cs�aP�����L�1d�}m�A��i9B�����g��*.�a4�R9㭑<�pI��%����/�j���۽�T9�����g]��8DO�؏��1L�2�w���#��G��z�����5�e�G������`C�l.��.�3���v�Q��o>�sIq (7�I�A�}��z3�X���w"b�K�NC��i�Ra���d�؅�6��t��&;[̤��>>�O�i'\�[}%�8����^���!�<���E*�
xlGP�(�� �kWw�<gD��\;�NuBhs�P��8� �vH-|��)����x�����dR��&���5t�ڲ4]�Zz�3��v^�+4<�&ܨ�YY��m4�镚�,�B�.�GI�&��h���z���5������-�c�v�/��72� �,��E�g�j�-��D�ĸ�iCXZ6j��bŅɌ�*E���s�rnxE�Y()iw���r�m�J>�1JJ�l�qF�d�>�{�f�FN�q�9&��N7�D���|���pV��� ��P�`�MT��M��i��]��Q)�f\��}Q�71&h"�a�����#x��&��(Oġ`of;�﯇��:@E?V���v�Ux�3����Dm<�|�h��7�$R� H���M��#��1��(0�9��|����_4����פ�	�g�=�vZ��pg�l��*��������W�ϩÂ�;���x
�TbW�������Cv���WX��p��|���3��N�r _9��'/��a�9�<1�C�q�m~��e���� �������qu9��d}Q��Ԑ7.W�����1�f��q<�f���u��l�f���*����Ȧ�����,0�R>Đљ�\�|r�D^*)VOX�|ܜ��j���?;a�M9bp��n�����V���L��EKu��R����隙�Yx��C~����%H\�(���B�ZW�J�$ͥ�{q������t����з�9g'��N��
&6������c�Ͷ]E�,���h�{ъ������:�q�ͬʪQ�/�c쵇����t3�3�"����{�SA���>�:ed�����zC��޽f���y�!�G�0X�>m>f�c]3g���!�G�q��d���\��y#>���
�%�����&�ߣ������}ݾ#@�sM��qe�ڃ��c�o�c8_��aҢ�������}F�4uqv[Ӆ�zF��[�<��s�Znmʢ��|���K��i����;�ͨ����9G,����� We@Z+����H��u��*.
0�f�����kH�(fzJ�[�̘M��C_A9V��Xv���]�6��V�p��{��iy��d
Wsu��SU�5���9!l>�+�m�=�s�v�*��g2�^}����mõ5%�ZNW��,�"h��+n�(y� L�W�������aЗn�ߖǋ�o��b���'t,8��qK�2Z��5����n:F=5�{�.<r�\�[a�T_$�Ϝ�dE	�g������+� ��H%�a��\�+7���;�6W���R����d�}ݻ��ʣ_�x�y�4צ�oډR��E@�#ˈ�'�";(�iRk��p��.���<ꇽ��-'83�!��`M��,C��+����Ђ2����\��Z�k� ���H���Zzګ�b��3��3֎BxTq��gi����6~��4�&�#+3���oH�|�oV�M�=[��GGc))uD�E�;��.�6N�ş��?�}��o73��wϥ&��o��&DaQT!"���RQ���S�|�޷�6�ܥ�+�Ů��*��V��f�v�i�m���{��NH��15��k�;���jBQ�`��;��y	�|�r��c��tb}/��?]9�����2,��#	p�DF{f�||ɓ�}��0��_�Ǔ��#4Se����MlJ����TY�n����	t��W�H!���EQ��rڙ.8��Z��f��Q��|�D�_R����Ay_^��W�AZ C�s��߰&��z#��2�|'�e��,N�-��0�$�pl�o
�$/+j�uR�R��o�M��s�p.�!'�x(�N��*9a|�Pu?ߦb��g9
���� ��8[�K��9�g�4t>��y/LT^���h�R���y��i��zّ��
�rd����4�n��ߑ�ذ�c�Iz�SM^.HJuԥ�a��	��dE �B<�\� ���\hy����cD%X����.��SoT��M�=��i�)�S9���c�!}��4��zmQ���M������&X ���x3�_.h�d4�am�����t7�o����gw�y)�I���^kgF���8�"�R�*J��X�X@,vv?��Q�.�����+���Y6���.
�p��g> �|�cPѪ���� ��p�n"�UEn��~��;�
�-��aQO
<M#b�^��R�q)CI�_ϯ|~v�Se���7�4�����ޗBĽ�{9�b��> K?5�d��sK�p��v� ]�01ԛ]�����WQ?��u�g�fi�'_�J4��~��0�/��`O� ��)�A��!��"�V��Hϯ����-B!��K[cTݽ���n�GP5�?)�7�8j;gGs.`]�.�����A�*�k����~j��.��P�b)�d��vlY ��)�n�w?|PY�ƯqW<7�1��\j	މ����]+R'�NY�����^��u���.��o��`��� ����\�p���b!yH��"�����|l䇖�����l��������3|���p=c�Au4�������P}�G�$!�4���hS    �5x&��F󛽟<�T !���K�{��7x��'!�U��zj�eL��Nm�;����:��-x.���@�r�<7l4���d��M?�yu*�a{^��u1�bZvS�C+TL�#�J�g�T�>�l��a>�X��L��X���G�1���}����e�n��T��A1U�<_��������qMmB�ȗ�w���r�/�*�:Ȉ\��K�[-�6���Q�n�F�SMM�:�9�M5E�ս͏�C����}������Y=�Hc���xbn����poI�G���0{���>,�d��}<{�sK8�YI|�����F5����7���}�|�7��Q�n�d��ٳ!U{|޽��{<��"����r��|��l���c�`�-N�.�#n�b�P�Ε��w�Ѽ{5�&d_�L���WUU�p���S�޵qL�#T�(���Y����R���F���c������lC�FUx�7�ab��Q��5w�D �����	���MgĂ��`}��b�]�d��Z�h��T�m�/|�
Fa����w"��{�3�Ԋ̓[7�v�P�3z�I�א}���}������s�OT1t�ڰ�#�:��V$��-���r��д���P%�(�dSS4�ܝ�T~���5�^�T�Ose����sAI�αN�<������Z��Z���6�r����.��BX�orul��<�br������������"�wሒ���~[J|��f��~u؂��y�$����Rl"���i������;A��yh����j��9�/���	�h�5��g��6q*�T�`*=�
��ޜ����U��V.h_��8NUr���ԓk�A�bC��O1�C�����3���OE�|�Z-o���%�wr~�o#h����P��Je\�z��2lB^�xrVɕo�^*�����C�_�pLe�@zt.�{��ꂈ[����7���zU_���v��wɫx3NNrQ�+_�">$����%*��،�5�n�߱�0h\U������-7��PD�"<���k�@S�oH�P�����|�O~�Њ�Q�4�jH�/�����yP~]��e	��7ub���n�t��j�_��d�A���"�\�qM;\J]i�Nn�?��^;8H.g�w]?^�U_I�k]ְ��Д��~��U�Փ�:��\..�2�7`/�Hx;�%�hw��PEq��OZ�/��+�����e��L�'�(ẽ{��ef�@�Z������&�X ~�-AO�Fx�Q��e:����&��l6B���ȼ�kH��a��S�˻&<�l���Ľ�	b�]zO��$2�
Y���1�W3�����
����P� ><��w�,;��^��~��&H�po�co�<����B]i�Z[�,��d�/�қ�se�����9T���)�4=�̖�5	͂ܯ�7s�h�b��t�����$����$��(��N��ᆾ����k�����6yjs��d�:�&�v��_R�O]\� �n�6�r��5"�m�O�xfK���Y�#E����1ˣ������7e���)4ĥ�+$����Y��rp���5=%�p��vrw;�>Z�$��M�`p
����k$����24ˆ�@���~�։�2�okJH״��W�R������q�g���,'~�<����:���k��T��+�09kf�s�M�5p�e����M����5V\����/���X�M�l����|.s��{_PV)��I�wMAL[��(Hc��T�4Dݯ;n�����lR�]�/	X� 	��>#S�ym��S�G�����%���}1����V�i� � P�J���7�K M�z�.5�b���!�r$�ɂY�@h���<����HpJ0�i�S����ğ3֧V���k���������������x�k7Ad����w݋��ř�!�:[uу_4M�w�t��I#Z���6x�:�y�QK'a��Ix?�p�R/�y`����=*�_s��b̼ؖ���E�b�,���v�OSTrc}Dr�7Br#�n������M{�w����O�[��Ej	%���e�T�٭R �o���ߓ����ڡz9˪�#F�o����Ĵ��m?�i�0,w���I�9�P��0�,�uG4�VY:�͟"���dv@�Iݲ^Ϯ/AZ��K�9t[��[r\�"?EE�*�o	Ly^m"==%�=�4�7����tłnN<L����/R�@yUװ������tΗ*�J_O6�>�@���Q��i�Q:0�5� 2�����&���L�(*�����قu�~S @ 	� �!r�.F��4'n�т%���Dv����C���mn�1q���4��Y��7�>�8����	2�����'+	�3\�潇O3��D�lu�`�[77�8��)�Ih���x�t.3z��=� c(C��5$_O�r�t.W`wA�W����^o3�o��|A}8���;ݿ�_1U)���{�7Eu�����ʱ��*%��7;�B>�څ�l����5��^��B���'�_��cH�W������v�����zM�6���O��b9�Mn	���EȬ;�a�Uׯ�`��� u�'�������*z^A΍oR5Xd���_Zr9�Bv��D�X�ԈȮ����qt,�HVP���]nO�9��}�\c����ӫ�{�s[���%T���q\9o�(Q�j��p�t�y3݇?�,{9.����f7���5yH]EV���R]
ez�f"��&������$r�R��U�ڈ1����$���#��;�T#}�!����('Oa��1B��6��p�U87��u�[$�ww�W!y�eM��*��-Ҥ^,l9�4=�ޥ7�U:�Qk{r�K���.�����cQi������-��b�$C'w�U6�m�\�J�K��(v&�v��-ֲ��C畋xt�e���5G�Jƀ�NP�'qk'9;q��d��9��T)�n������ʺ�:x#!���F��>�;
&��!p-�����,T�؍�5>?a��4q�"?ٲ˵��>�V�~�n�H���+��6��򻳛���|�Ҽ�)`� P���C+I鸊�w�I9��58�jV��%���ߘ�����~"d̐a�d
-��08b���
����^�b��Vu��F��O� !�ѿ���������R��i���<Օ��,�m�����0��W���Dr~o���LIz���X�z��!�W0x}4_gxfLO�79HH�L&qL�oϯ�19,*���\yy���DC��-/Ŝ'Ҕ!�?N@4c*�	��;}���!����J`#1�|�wS&�����8 הh��C������ES�2�ބd��f�#�����"�������*4��s���\Qb�ƽ˫'.��9�*�N��qf����$����C7�ˉ�����������x�����B*��]C��F�s,2Ksď���U��.�����ż�������)�\N�cx'�ybWn��[E{y��D�Z�.�o���\_|� y;\���9��%���C�F��vR�D�ݿɦ�Ӓ�pް	2� �ɀ5�:����q����%����#A_��9�G��r���s��
��R�#�Ƈ=���&�ߏ=���3a9�����+�(��펐�3;ѝ�"}��g
��3!8Y �L63�(pc�#�vE�)���d5�����P2[E1�MA�^/�co=���C��q�rW�4;ެ��e��d���R,iΗ�^vdĦ\5���m�*�NC[�]J�A�6Ur H5��8�=3[��!�ʗ2�[��A�_n��3+��[��bX���EZ��A�f_�ŧ� ��� ��Ն�ðxpǀ㽱`+ �q�:a}�;�d9�QPk��ǥ�>]�� ��m���ov�o�T�;/��!���A~2>����tk߂]�Gw)�"s�_������������d~d+��O���4��L�"��꥽���������:/1'���|s�˩v�8���qA�n�=��Y�N�m?p?�?wU]��X��	�!ؙC�g��,Mo C5�C�K�n�u��@��7�    �?����}���O�c��b��-�2Ț	�e�FM��*��$w�.������p���s3a��5�y]9'us�I0]�i��
@r�R?��3���1o�i���۩P	sK̯aћ�G�=+��YV)L)��^�H�/�6F�����Y�x���(�[�Ύ���e_]M�Z�U���S�a���8��K'i�������-iY�2��w�iѾ�"����J�!�w��j�N�h�Z�S���^8�E��Mf̌�פ���T#����=	����Ҭ�c{?��;&�=����`5��J�ν��X:3�"Gi*�}���;eKM�^NO&}��3K4�UH>:/�5��	����^��WP�;�*�$�1j7��ފ�]N���qЈÖ,7��T�u�f�?�)%���(�̂�����^@%郺�o����|;�-U.G��r�	�!�����2!�RJ7�0��Q�� ��[��' ��׼��&�k���^���MLfy	�W���}ԞG��H{a-�, T���7����_B�:��~^��H.C ,.7̗/3b`����,8���d�}�·v�^^�&y��a
�j��<lj�]ok+ӻ���O�y�W�Y*����œڕ�􋉧t?�F����؋vC\�鄖��vf��?�G�?`K���_�.�w��}���S���?L��л�>]�ホ �-���YK�ێ�[�Fv������Fo!����7EG��"\�0�$��Q����)4}=T�E�0r�G�ip:�φ��S�ş[�Ќ��f�VY�x�$�����u�x*J�`�	�.���	���LQZR����u���Qcl{��~
�U���2��Z�)I�ǧD�5��Pk~�� �*�cY0z������N�
f��l��H4
�o<|��L���G}S4ۆx�����Vd򟻸����W�lK;�_���.���>��т ���ě���_���]-�f���w��"��s�އ�:�<��'��ݲ�p�zܾu�5J��n�Vi������o֔��ZvI9/�3O��������'��y�]"��)����[�[�����s��d��蛍
�ER ,�i�j"�R��K����_5��"��`2�VexG�#�~a���>�J��K_�\�&����Mg/����,?�94|tup&t���q����J��ɖ���I����)��L��[��ũ?�d
����N@�gMBƬ:ݿ^��S;�/dkc'�.�P+V1*y�WT�U����"�OQ���\�����5,�?q��Ր�v�K���$j��;�������\��g²o���7�~U�<�\f�N>/�S4y hc�� �NQۥ��^�Rωe����y���ʠou���(�����|�q\QX��bj��Ҕ���5�����D����cI 5���C�r�\���[:b�
�D�3��ᴯ�31C�k��RNPV��>54p\/J2{ɘ^6m	�����;Bm�<ѩ�W�=�:���=9 w�*�s$���*ƻ;���Y-�u��'[�Zߏc=V�HѶ�lS����A'�.���H��(�"^
\g��� H�ψ�^.��pЪr���A��5��Sd;;F05�iT_��ԝF�`X�}�TQ �fz{Ǭ����B 4���/��;ꃵȞ�����ɲq�R����LV�)/�q�q� ��:e��Z��v�"�7�Ğ���r��r���zW�!��_��T�M�k&��<h��4�/g�V�=�n\��:�m|�_\\��c�/qd����T���n��9/�n�}���I).ַ���o���(����y]�J�;!��Y�����OPI@����#� n��;`/Y� ���ӆ�&�i�m�R�R;ǯ��s0�o��Zh:��,#�wA^���E+���W�b@"�����8K=B�Cw�T3��,�	����n�Y����7x�=��;'��jz��~��_V���C�s�	v`һ,X���RZ��,.�ܿ,a�S�hl��x��\��7���(O8����{��d�u�|�8�m���0iU�U2O� ��N���cƞp�VG��]�����En
8�O.'���X��ɧ�V��x���z}vl�5W�b�f=����M(�+	�8�*������ڒ������������3<y�x�yj��{�p}�KQP&tD�rG|��K�R�����)$K,!s��y���Q���ǈ�s��z#	�FԒj�gY4��B�D�Ɣ����;ڵ ���V}u���4x�� U�K��٪�k��uY鲞AB�.Z��Sn��ΗT;�?ވTS��m�M�+/�Z(��Sb�L��$�y�Bם�/��k�����>i"{I���I�q�<^�w���3��t�g:w<��0��{
�U_�:�z�c873�����`2N�(�Lc2���\X�\�o���y.��N&�:)S｡Àvx}'��R�YŻ��><R2���9�k~��8�u[�L��L��-��}�i�@l4��q�ʟxk
mn�G���NWM:�I��d+��~�C�\�@S�NBP��a�~�_˶ᗣ_:X�Z����c�%���bo=J^�N����#��}#X��B�&��>7��f�"ϣ��#�d��+󶾗�1!h`g?U�}Y�)���{��v�aG�T�充�ɂ��@���M����![O�H~g��?��a�"�H32Tڿ�P�$x�O䃲�n���j���˱5��`j�^_.�<���!��Y̎���iH~
���~����sң���vo=@�Ajy�86�9��m��l�l#�h	N{ЄR��wy�"�K��S G�Q�$�4rK�ų9��������h˺�@�P�*�a���;xXpp�KK`V,�S:�䞶��b��C댓T8�� �����|whDBF����`��b?��Q7bC�]���@\�|e�s/%l9R��Y��j�]�s�K��<��6�4�e|��y���S�ܹ��_H^�7�Iq�96�jO"������sF�{x��ϙ��ʃ�do���U�X$zR`�	˄x���aD��͜Ɨ>�T���W�����;8�Ū�H�CޝT�/���4!�#�GJ�C��4�g�I�������]�{�gϾ�!b �WO6���2ڳ� ���aBQ�勥A��F��d®�i��A�>yn2�r+n��� i�}h��׿D��L�x���c�#�;�jt�#�[�<<$���ˁ%E�����ͧ/�P�1�f2N�K�}�wZ)�&� >k� �s��c?���`��
��۾�jq�.�ȁ���&��ĝ+q�}x{�c���(���p]Z���'Ӱ����e{.� Z�"��n$�����#���Ryʺ��[8��r�������s����%�K���ݏ����{�����<��0��rQW�u'���#���|$�H4d�	��C����mu���$Oh�����-�L����߼��~MR�m�}{@ �(g2�����Z���Ò�qc����;MS.2�l� ��'i�pF>���e�ʨ�=�N�M�: g�����|�������e�|��c$+w�N�ù�xn���w��#��B��J�'d�+Ed���q����1�x��eD�o�|H�<���Q�ֲH�	۰Ҁ��������4���L�t�����)�� �^������ԍ1�T���v���_�I�쟑��Uc9���ڋ5,�=z�X��VZ�,�y����.TG�bm�L%A�l�b���2�G���M�8�=��SE��a`���Z��v)�ݑnU�Pz�Ƙ�B1��a���y�Tz�*�.���&ﰪ᫷	Æ�����Y������ �R+���&$A2z����@���S�'�=<�~�*|a�J��0'r�����:�u���G�7�EagUEl�at��,�����q�w�T�ߊ�BlzJ��ľ���o�4s��pxm��e<��-�)c�(D�vE�G*�|�<�瞧~H�V��>�j:�8~^�uv���    P^
��M����Ec$8凊�4q|M� ���:�(��[V��V��^O�!��r��� fٟT>�p����}� ��2���4�]�l3�Ȫ/~a| �_���2�q�\D��~"*�꣥{ˡ��|
S[@�Ht�a�KK�Wn�|������8���8�D��}�U��q,a>S�|܆23�������޿x�����qK��j�,}_�*�
Z���R�lԕ�^P��5+��2�����
{9��|~|KX��n2�?�"r��+�o�\�B��C�KgC�~?������,���ij�d��1�֠���1��@\j�/�Pg[�����Q�H %퉾�Y8�`�&�_8�^}�ǢV�KH;]N�*B���Ұ�����K�e;>A�� ��"Hk�:.E�N����v=H�Ȍ����z,i���\:���:f�z�͒ �a�1;����x�.|�#�/2��������^�S��e�����#�2�����_|�׿�LJ~q
���C�%tYm��i�� ��Q��,W��4��Wc��آ�U�9��#pY����Gw���	��z�̸#��|M��h���XI���������i�Ċ@k n'�r�v�e�:#�g�ݭ��A����hh����G��
=���
�;�� O�D.����퓸i8�鋨�U�1�(��y�6�"2<C��z�t*��W�B$�ݿ�x9�~�y!�E{�A{��@�5��*$��5uf�oj���.��֦ H`Bx,����[�s:F��Z�?�����Ee�x_��cbqt>��-���}ґ�;���C����TE��N^f79����BggT�K�1��Y�cO�W�MB�P��y���H��ʡ��K���K��֛ !I����շk�l	o��(�۶ -��}�����ػgT�#�vs��u7�NDy.���u#�	i��z����ڣB������wQ�4�̧��.��y%��n h� �`�����/ѯ�˟&��ۡ���gq���yR���������}�������ȱ�p�×�T�F�Y{�żD�a�?gb{w� ƈW6`���ݧ*������u��؟�	1�y�xt;[�V
	�?C�φ+��N�����6�_����6$�r:.�,W�!й7�?�⫮9��pa����|��KDO�$HQ��_<mX�������WG�} N���(��'<}X �Ho6�5	L��ANc�Y�C�W>@"|}ܑ���p�W_ï�+ԛE�H�LZsY]A}�>��ȝ�(��K�9<����nh#������v��1�!ð*�W��X�s���k��%O��� ��ޥ��+�+0 ^3��=#Yg�d�2�o�8y�5o,�7�(m�M�N��쌌�w���BP�륣�v�i�w`r�ꩳ,�,�tu�{/n�$�q���~��*<�L�+��M�M�a��)A�������Z��W�`I�Ӡ�V�!����ָ��Fu�����(�Pg�r��}�ԧ`�ڝ���*YN����f�}��`3���A��OnR7�i�\#���Y�\c��V�Q�3��Y������n
N`|��%<�О%9J�>�d��Pp��X�GcJ\��6��e�L���⩌_ E�'�	��a\눰Q��"��Sa� X>�(��Z6�3�ǽ�s�c��~��}�O@-�p�H�t��������O��)�q�7#�E7���gtC=�@F$�������'��-C��9`�/�H���E�%.�W_� Ret�&|Y���T����ƀ�0�m+
y�[�wj;$g����vѠYF��S���R�uve�)��� ����E��7B��r~{�*?�8(K��n?e����FC�rV���#�G"9+��!I�'�I�|�PV�N�r���0��^D��MN
�8!� W]��������$�]��e�]!Bg����0=a�o��"�Ԧ7#��#"��-Q�O@h�
(f)�
c{�/�U�j�w �#}CG SO���>��V��V~��Х�8*\�`�q���-W�[�z	�s{��bV�z�ս[k[_��?��{1�����K

M�Nnb߃���������Xg~�fNJ����CmY�t�~Y�9�4v�%ϟ�ak��8������c��癄V��N�f�ع�+��!D����J��,�"u$9���)�����x��/)g��]����w����
�e,hH��Õ���8n��1}dNVZ+�*�@�:��)貚��Q�,��톂|�DD}<�\˵^� ��+n��8�t�H�����5���AT�ǰH�-�مJ��-ʧ��spPշ���lX轴��o�O�fnh�J55-=�z<;՞	��Jm��'4�*^s7�s]�9u�����b�zbi�TIkM�*^�������p�����#�MO�Zi���PO���rR�xQ7t~�Q4�.�Ε�۽}w<������\'��;gq �-�u��1���3�27A?�=+�����}3y�|��=-�����{�_�ƺ��W�Je����,�s8�����!T�m_�!�wX�磗�[�&U@�;@/���F�v��5�c3��m��%
�fK
G	�������{�7Ǒ�(�6f��>x����e֫-�F��
�f��;l�����t�g��Q������6g��0��7�Z�, �����r�Ao���k<���G�=�=� ~�s�CH
�/��M/˃�\�R��$�󈔇�y�yDT�]�ʋ���ϵw���>]NjJ��؝"�����U���N�1K0� �Pp��B8�=��kVb������ �"c,~���=b{q��̖�]����̗�<��_�����G	.�V���m����Ūm&(ltڍ�ou^߷&;� FW���O��t�;ܽz�L1.�j@.V�����_]³�!�����0|k�À�O�.~=x�1�'����n����jq�,��rP��zmP�9 �eu��T*�T]ύSb�F�t[�w#[�a�o�Pp��.������[�OLk���U^�X> ��~���(�d(c$�̮��2j+�����z��=���Ia�,�:�i,��*6ǻ���yiX�Ղ� /͘�
E�#���2�/��ӭͯ�b���#W#T��S����¢M�����f%���:��X��? �iET��o����O_la��+7
��:��)����t�������D�p&�sY���0�,�����C�GG�h����Qn���I>�#��d��h4�8D��D�K�n���Nx*�����S-7n��OcV��M�m��DEw�8�+�B������~I��>��#�H�2�^� fZn������a���x2���.��6�S�OsЩp ��ޜ�?_� ��nAO|�!����gz9�p��h���{]?�]��ٸ~}b3�����7a���Ǳ�?�wɹċ�ɏ.\�4�Z�C�36�ʠ,�u��hҌ^Q�y\�Wj�����.��ň飫�o�d��(� ���-�s#��>t�@�]lh\���k2y�!����g��qY*������;�1Х�!�Yp鷟|_��2RC�W�|G�\��ei��#�����w_[�����4�7�f�/n�buY�����kx�����fC�?�
u7���­�Ѻ߿�'�cm5p|Бd"�����ν��� 6AR�I�n�Kw��6w�!� ��Ms�o0��\�";��h�����ڀ��b!�L���x�y�%��g�p� tt$-� �r/���6�Y�U�[G`���9?'$�/0�@�I�������Bm�9�6����/o�_�x.�����w
>��/RD�3�P:�I)�tj��	Ϋ��v�����j?=w��)�ݽi���~�Do��D��z��.n��U�7�5/�s�s�l;z��x��8)���<�rH�RC���8��g~�E�ᙵ-w
A��bu���!�*p1���"JG�9S����zY�P��äE�y}*U���r~����\��L���-��XA������*\jK��_E��E!�s�j������J# 꺒�x�����0_��s���ك�\N�    Mu�-5���~��`�C"%ek��!y:�33��*>�b�*Z���V;;�VJe_9����� m��lr�0�7����1j��DR���ms�ˡ�i��ۍ�q�[�vAF��U�����a��y���*�)_{��^�HAs�svo`D�����
��`'��w��r���u;��\Ӑ��k���k��X@�,�smC��qs�/�Sg�ҷ/NA��<t!�)Ni� �ը�So��B_�ٖS�e�����w�l�C���}B*u��$���r�w��ݲضsa잶d ᄫ���͘�/�,��&��m�=�Q���O�Z�%lo*����Fb�*l��c�\w۪��i�#D�?��V�EV�����%i�������|-[ C�����u�_m�x[���w涇�����{ez����;pK���Q��x�2�%�ɭ~b����f�Z<��2ɗ��_��kJ�cT�y��f!���:��ؐ�e �@w�A�`����4��f� Y ��'O���\Uc8�7��́:Y���{jB�u��C�B�=Y�EΎ���<;|��V_�\q��o��Ng�wd�.�!�ƈy�%amhl�%�ER��Z͑�� �q��ѻ`���=q�MTdG;����ʊ!߅�ΰ
�3���X��.ٕ&[W����\Ъ{q �-g ��~};�V}��#_5��=7󜌄p7���lo o�,	ho������w�`�o�A��:�`��O��������=���ڛ���c��!����x����GD��Jq�LBv�5>�$�^#H?�W��G�$U�8�6�M=6�鏘ꆇm��X;�g�H�7��m� @�͌�k&2F�㮡���WO����{����R���a<��w�̦���0D&/F�x��7g���\�5�,!�JE�og�C��I��~�~Jh��?3�< G��9{y��Br(S۴��+K�@*��扢�]�Q����l��s�La8�-�i,m��4�,��<2���.洑��K�B�we�QE� ���|/ݲh�:xK�4�k4gn�������""�+K���+�N��MBz~���cX	忻�Z�Y*#�r ���-��S����5A0p6:o�"u��g��g�ʺf�Ry���jc���� �I��G����5��j�/5����k�����s��P�#|�}i=������
���V���*sk?ݵJ>�S��d��ʤKmi�w�5�e��I�B@/���;�M4�@ą%mf�c�X�+�7�n�3؋��I�X��Q���|XM'�-��Z�L�?��P�ot�d�g>q&����qc���)����8��:ۺ��<�O��~xC����5��o���Uu�����i�8�B�%�օ��K`�Ġ���(�~g	ŀ��wo�I/;�`�˴6��@�C� ,=[�7��<ʵ:�:���~��܌e!��(̾�K:+7� 򺌏��jќ�������eK~!�9Fmi?����ũ�"����x��8��$�p/�+%g�����[W�e�#�W��Q��[��rFA������'����.�w/D89v��}��dU�����|V��yI2�����7�|�3�wo��*�<3�3�ۚ��T�Iga�w�\�3��j3�$� ������dם��	��7��C]
@N����u�nǳ�K�j�P|k�O�$�?���y@��Y1�i0d���Q�-O7~�sz/�S��N~8k,�_��<��M~���@����sV�TjR��:�ޞ,"O0� �� �_Tޞ���ݨ~�]���ִ��w�k���Qщ��/ȃ��S��9�\�p�����ړm�Kg�Y�Bj��.���1x��Ǹ/��"9�J�
z��ur�sk] !�Uu�{y�=p�46r{=6zJΟE��ʗ� Ѷ	}�Fo=���1h�V?��K焯�	�_�nG���K/a����Mq��﹝B�Fw��M穘�����3ʤ���<�TF��P^��.�����������a��}f������ɖb/#�ۗU���m�"Џe�k��{��9��{����=�g�16�,�lTr����4�X������FO�z��>�FQM�c�e�l�B�{��$vU� HG}D�s��Ӥ��P (�	گ�[c�+h8�ٷ;g瞧�7V-)���z�"�ͅܰ_��{��l�q�P�-���C9��K�Qx�O#��p�J4��{N_K�IDz<B� �ۦ�[�7��{������,�3V=���jk3��	SZ���'UV�Í& ���O����'�1�|�5�-��aA.�W���"�w�x�,��O���I���4�R���I�i*woY1$�Pe� �$}��ߜ>�W/��q��Hi�Z͓D���� z�^����C5)ir6m��YF�폯�Q��O��['�(�ŎI�|��� [}��	�͌��>u�{�zi������p�8�t�>��N/`K8A؅HE���ÄW��lc��)(;�g��9�"X�d�.o?�ۡ�U:ё���	 s�oD��{a��_�=�o(����_�3}��T9ð��������Y��~��/h�X�.oM�8䇶��w�nU�o���c>n�W��Ҁ���z9��i*���~ ���B�� ����
����'��ce˞��1��0>O>F;�g�w5�F��Η�'��U���2C�3ak�t�/��	��zW���t	�g����i�r�U"t�L���ֆ��әF-�'w��-��Z;&�fz��N,wd���gD�Y��5�
��n"w�cT�)n�!�ʒ�y��a���u_X&)��\V�.�
�&���Z	,��#�Ag�������k���C~������4�q�CxZ���}AU��_��2O|_{�ʹUu��9W�2 N��r4�����}��������
6��������h�;G���w��*N��&6�ʸ�\��]Gx��o�w*G�n~�,�O��vuG�(l�m3L��
Y��TB�ڹ�D<�-
�_K���2�ޗJ6�R0�+�����"�_�2�9��5���X�m�;.�ډ[W�s'رi{UHy(���y�E�w���`%p����]w��_�g(�)��\r�f��0��N�&��TxK��HŃJAq�'�6��������=�n��0q���菭l�-���<g�ڷpD�]Ž�x��j�v���H�� �U5`��7[k�D"��7���<8�\�?OB��>��η����)d&��,Ԉ^zJ�='���f˶1�d��̞�.��`
�e�2�N�&!�W�0x��Y�����6�n�L��6N��l�¥G*Y~��"�N�]ֶ��WmDo��k|z��T���1x�<s͸1�?�C��Sū��|C: �MAX�˭�����\hG1�S���(�:W��qqc�8ߐ|�8�F�P#��{�i��!������B�)�'[�%ܸ�m�~HZo~gO�����:�Ӓ]�h�o�&����>��?�H���%��j2_p�B�� n���9�r��Q���1'�	��h�0P��/���d]�e���9�=�#L*IЖx\��w_1FTR��$�?T7,%���R���	O�:N��$}�LW��a�\�� �KkJ���ѐWR/�� &ܒ�<翥�9����R�1�a���?v�A�Y��*��ͩ���c���w�1�S������ST��漧��T=��]�cj����~<������
<R����q��(�k���d~�QհX�E�����=m�!TaS;�~�*e8�� ����L��>�5g������|'�E��g_�
�=ɞ�?=�S֥�ï�?W�|�#)���F"�%4m���x)�E���[�/a@�d�D�;���c?��U��w�#/����U�,��]�;�$Zc{(�1r�xX"� ��{8�2�����#���6���"-΄��>��>�����~ρ�ߎN�L���Vi6��W�m��6��V�QϢܢ_�d,u�gK���pq&��B��xR��w�P��D[|<o=Wl�    a\���\�l�ѡ�$�>�X�V�ژ-����M�!_k�(��ʭg���?G��(���s�<Q27b��
��}�����d��؂���M~�u�i��Ӏx����=�BZq�%���5Sk�/'%���GM��i������4fi�ޗ/uD���\��z�TX{�.�hڞ9��;�ކ0<�de�w�-�� ��b��#��U�-�\���(�ψ�|3�}�Go4S*8-4|�L���m�`�Qh�L�������Ե����M^�S�}��]�{���U�u�?��+� X���&Ȗ&��fl��0�*��l��uj�E �r>~:~n��Y5M��m����w�G�6h�x����|U�w3��u,,{���暄�~E%�p��އ:����VO��(]��C�y�%e��7�'NR�y�.����Ioݸ�^�^��vs�c|���~�=�0��.�QޏM|��ڱ�g�*~f�7����R�?�=��%���n]���:_J�Bs\��[y���$�z%�hx��r�$�V~>7�,��������Z<������U��o��+�879����?�y�s���M��ֳ7����}�b	������A 0�����G)�O���o����]f
�Ӹ�rug��^�V�r�����t��@���mD��{D����Y�}���&���6�& {h6o���� �¼�_a�4�mw�7!Dd���ݟ�N����8�lI�"vrbL���,�I��ӟK�ڻV��#?<[����3�
+�P��2T�2����������}t�%�=��>�c�D��v�a�i���ֺ���-��1V�~	�Cj{�VFh���|�#<��_zL�	���(�7�z�(�5����:���N{¢x*������<�4��a݃_�3O�}T�G������ ����'o�Y؊��#�:�20<��u�qs������mQm$I���G�V�� �h/.K��Ѩ0_c�������u�5w
���S;ɳ��+�I�R��E�N�n�x�u�|����,52&�V�����]�������mB^.B=�en��X q'�vp��?�_��12�4�Z3ڟ��]7��'t�8�z%�}aR����oc
 ` �&π&�����y�<>�ݾ#�v�1�w��;x�q{��Έ~C0�k��8���Lr�J�'R<����߻?�g�0����h&wD�b<�x<�?�%�BX"q��ҭq�_�?��&ڷ�Y��$屫 w��Tn#�������s2�Iz�2S�����e�V *7T��n���M��h����D0���ꔔJs]����k�r�%��=L�Of�'ʸK#J�����c��q�&�w�v($Ee �Gf�}�U;|�&ߏ� ����ǎ�	�H�����q�@�T`��;�_N�.>7�����s{*)eu�U�z�:�{W}����:�(���>h���u�����7q��=ʃ�'�t|=d�^G�|��j/���I��7����0�ƶ0YO����?px�+��)%9�N�r��Iq�r0��S�3oV�����z���k�y�'auh1���~�l���ܾ�d�/�`OW�s���/х�����uU�IL=������5�����]��.{� 9o���/}Mj���i*e=����j)м�3 q�c�0L���TH�~׏_p�q޶�pvn�o�y[^izO� �u�Ud���W���">���*ru����L~K"�K�'v$HyV�0���|��1�����P�ϲǈ�~}4Q������ey�p�M�z]��w�g����оZԿw�W�`��H�!X�6	�?=�V`���?�r��w'nwBz���E�㼪ͼ���0
���x���]�l�]�=����ߘ�	��k�]�q�γ?ݔ%9�t�@���>�kR�k��/NՏ�<��?H�X������r�.d�É_I�(2dE���:D�jb��V���xw�Իw���󈐛��'r���E��ƀ�{��8U� 9�����fﻯ��>��w������=|�{��%�קн����� ���S�GS�q��y@��Z�؇32��>��z�%\�E��v]~��O{^[e�ML���]ᨍz����E�#OG)�C�+QSO���i%�A�̜랚�r×���1�����h����Az�,D�鏠}�!,����:���ڥK ���J�n/t�_,���k���S���n\X9���ޱ(iN�I-i��W��Cq���v��jg��S-��;b.piZM>���J'Jp����K����W_sZ|$�j���.r�y�߿�1� ���{v�1lk;��x|�Ĉ��6�\ߠʾd�rْ���3\��p�y3��4�b�:�ǋc��8�,
ϠSo-�ӟ�ɑ��ǽ����W�~�̱*]�h�x�<59S��� o8l.�Ґ��À?V�ާ5�� �5�"�gC<���
��n�߃D��\�q 8��lO���E�����@`Ӟ�ד��(����MXʰmU��Q������Xl�(�D��Pa��k��<�����D:�P����&cA��"Y�2� {�����>��?�Һ3���4���?Z�+�� ȹ�}��54| [Q"M��g����w��*�X�Hdߒ�M��U���H倗ڢ����<��-��k3�o�YB���5ਯ<	p�`y��	�O��yB{ͭk���*E�M� �y�2#�m[���(�[�<j+�E$�]rj�({�~*��7��=��7,èb�
�����L�"��O��'nL����n��(��?��(�`�ߑ���"? �b���ƭ}�������N��pȫx"F�߈�O�?������Ol�4�{J���2�<�[t��i:GUz&U���%�}�����x�@0�����x �Mp��bwi�O�Sf�M!@h�P(����	$����ɨ����.˳����a��S6*�3�j�:����M1Sz�x�!�/j���K"%���v�� D8�q��V	&*�8��.ƿ�eJgN�7m�Bi[�E��AFا��q"�lܚ��֟G�_�p�8ɲ(��[�&�o����f��7k5�$Ӕ<G�;�]��ې��Ͽ �҄YE��6��՟6�K���2j>�*���������O��+��������>Wu�9��F�^���.���,�0N���S�M΃�9\ �?�yuuV��Vbn�;_���oo�7��=�1��s����w�
���f������vn1y�辵@�3[��IAWS��>��f�)��?%Ҷ�'��oTm3�����}Hx�u*T����d��WS�p�m`�tq?�<�����#�R���0	�L&��%���uΙ��}"Ω�Y�Z�@���.iCm�}~����.�?j��U�_�2��ж�:R[�ފ����8��� >�Z��c�-�]��}l]Qp�<�<�`��勸�G���^�Da7�������#�H��v����/�?�4t������'$q ��c�#@����@��%A�W��(W�]���n`&$�����m^Ҩ���7�Ǯ�]��2�����Oz\�DY������
��ϩrD�n�⤆̣��C�R}���8�M�a�nC�,?��H��*Y�h�Z��y��&E l�`���÷Sb�C�����Pv���V�b��k;��Ń�RϺ�nF(��Π�qJ�Z�EQ�ʹ[k����םb{=���dH�Yo�"^΢�\7�h[IL����o�y����QO��먬E�?V�˽��a���*{Y]���P�4%3����~:�����e�Ҿ��|=i���Ŀ�L넡2ɠ��ێGA!��XHJ)�[�xz�i�Y��R}*.k�Y�0��"%��'�D��43����B� ��y�0�w�6C^���l_;�������_j?�B���t"ik��~Po3���G�0�#��gsx��������<��d� v�G����5ӯ��נ��~�;؝�zʋ�yss�'�_Ds�ҵʔ��8�    ��wGuvld�w5t�/��"'�ʄp����a:���
�9^~�����;�`�5�?z*)�r��x�����5o(ZR��3`���.TT�=���j�x� d5l	O��F(ה�<X�c'���u�����w���L�W/|��U!|;O�آ���=��B�k��h�'�[�G�r๫�Q'���*�d�Zb�O7,�-�1섮?2�2A�𕙈|���}Z~�Ř�%P>�E{�k+m.���";��D�Xj�aKh���H>ӧ�a�� ��k�������q�O[� �&��Q>x�\�I* d
o	�z��/�1 KG�Dm��Y����P�//����:��̜�p	����Q���2�/7�#�������^!l:	� %��y:G�ߕ�7d4\�������`��a��5/`MJ�3���C@�?�08o���c�p�^b2�,t��W��h]�q���;�w���a4�����.�v#�=i̿��/S���J�ǊDM����.2�D|N�! l���:�|�������-�U�~(\�α�,�z�\��%�㹩8E���DP�.�7�I.�.�����l�mKW���_$�[k�"VZ��~���g�q�  x��q�7���.�`�y[A^�|��@ɁZ �b1�5+ϰe�Ƌ�g|2���fᐭ���
(c`Q� ��&�o[֗�r�I�p^ؼ�@m(��P����}���ܾHi��=\� `U�)ֈ}�F����|S������-����+{�d�(� h��y^I������Y�����7&�t�y���UՒ
o�2Uĳ��Y�xB:N��?��寧Aj�h\���ҫx�Z�ꩥ<�h᧮�o܅��$��̜b����ɔ1���}�7���AcM�KT�`t<1%��˧�"��K�{}ײ�z�⼱����cv��Ga�+6����n�y#d���(d�K�'���VPw��G���lh��\��N ?B��Ϙ�\6�q
�������%p�}I�E��~r[�0�5�MC�/f���{}��h)��-:�*�,K�]R�,�^�l�|��y���ݖ�����{��K�?�������o0�݃0�5x��l�n>�t�y ƾ�:�؝�S	�g�$z^9�`��2m�KH�,ˆ�� E<��d<2�1��a�B�a"�<���%�pק���˶�һ�Կ�v�Z���������x:����v�|�IR��8��ܟ����d�#�|��� ��e�;�3�<��I�n�d�7��`�5�.7����Ֆĕ�R\$9�6�� �N�0?������`M���C�I��5��	�?�6��c�:�QC��y��jt�Ѷ��'�AX��e�!@��B�%cÒ�XF����՗C8��9b5l���g��"��	�}��=�O#0�ǟy��B����h��f�����X��Y �s��5�) /�:f~�)�X=}���˖�z�g�W~o>�i��0M��C��>�5PE��>ǩ����n-� <1o'K"�a6������}ב	W��t�:�����y>���S��^~~HT�'��`l���w�}���&�������%��G;?�0�:�n��x�,<�W0j��D�( �fa��DO`گ����e�4ڎ7 �w����0�A2D�r<�<4
�/��&�گ�)��U�a�Ԧ"W!�_��c�M�����t��宗w��t�h�i��,�]��|U����ˑC[����}ý�kRb ��2��P�����_�-#�T��A�\zr>�W3�!�|�����#]�%�a���oԑ�nr������>���X?��O���hD�� &i�=��z��W��S�L)р6�W,h���u�qk-E�@�i�n�?3����� ����Rp��9�W�V�u�pj���O��9�:�����ð������xѓ;y
�MX�Ae��~���K��H�1��`���<�R��1l0�Y8ڐ�߶׶�`$.�B���~�:��j@9f�ג���A��">%Ѳ;���S @��L��tF­s�/ni�5�|_���0�'�|�Y��>�?w5et�׌���vu1KCR���+c����͝��!$�)+�G�[r�ذ���q����eZ4����9�����l�Ǳ^������;�~��ƿ�7��f��9����;Js�l𴮗�}f���q���4uX}����o������`�����+��'��S�@�-�?���>�ߦ%��*p�����x-�����Kx��o��K��_�!o�;�?����^�HA�/V��L��=i��?=��i&rʹ��N����1����r�Isp���7�p�Qp���{�ˇJS��m`�,�ؚ��ۓ�%����lއ�w��q�U���޼�_�vʏP 4�ܗ��o�I
�p�{�$x���0�jU����z���{��uʹE�FUV�'{��v���7�JA��n��[�|�(^����(��_���v1�Ɯ��^=3�u�LEo�B'�t��B{�z���G��"tB�O:�\��1(�'3�$�4����U���r|@�m;��`Y��uW�)�|R�	Y��_���q�~�?n����B��ܖ�F^Q�Ù��:�t�6=������D�i�T�gۄ4�TT������;�Xƪ.�����N��QD~�!�O_R���X�]�Q�j	._9i�p�E�N�0t�_HS�nQ�w��ް�g�g�N>zw�?�M3?]���F���n�L�>�B�?��oF6�V�4Iq���>sx�P��˽O����x܇�:��zP8v^�?�T�:o��Q�J�B/��Zn�a�
�X�XbD��i�G��d�z+���M=Bg���֟�OI 9�}�j1{��xcz��&�}��{!
S�Ț�����A �;�;�I�:�z��3tWg.��=�&��<�}3	弥D�{��-B�� N�j��� �69��0����,E���׋��>�H5���h����S]Ats=Hq��U01w5�ϥL@�/Q�V�d��^�G^F�T:|4�&>$�?O����~C���!t��/~21kY����w+}�<�'i(�ron�~>>��_����V�3�	�@��쯛Xh�Ÿ݌��S�P�<^6�u��*�~0�A��M��\M��N-&�ߝ?�)�Z�C/q�*�Ͻ3��7>4 &.(���cd~�}!��(��/�y-�m^��L��m�ڝ�{ ����b��|������S�ö�2.0Ε�s��/")N{0p���}W�S�JX����l*G:�k���n�H������Vi$.r��yH*�S�;�7���M*��z��M�ܩ{MCEDQ.QYB,������0���m:��v�qR"�-���ȅ�.03wY>M��n����X�S����y�B�j�S��&ޫ���p�u��f�@���	`yr��7����b�w��Jͦ���ߤ,~_�<ȷs�7�*%O�p9w���=�$��7zn�A߻��� ;+��f�����}6u��t}0���E!_�$I�Tv�%<ی��~��={U���N�FďdH[@�y?N'����o��Ō�����AX����=*�H�w��ջ"T+!g��=M����~MB���҃מF�p �Y��=����}8�y�D�̓�~s�@�lg��R@�8�hm�W�����W��H����aO��J�S�\�z��Һ�-lYX��IY+������۫S��EWb���x9A��I�x���w���ڷ|����iӘQ���pO,��U�I���)l\4�1y��'��--�O�G�O�A�^�{*�U���L�k�/I�i��WR,�Z����YU�O�*�	z����֥��Go�/�P%j}l
��E�1~�w��:���L��Z{�g�I��2<�Rk�L�ݢ�L"�����Ox�&�:��i�>f!�a�a����p�̹��V�X�}�ێҦ���o_�r���M_�5�i
�s��8&jO��
�9���b� 3	��aSh��P���'[�$��^�E��ݓ�m2g�=y����/�5�U4?Z��    X^0U!�1�����a��7�j+?� �'�r�o���?��7�ƣ�Ǡ%���}�C"��x�)M��:һ��K���T_�t/�:��e��$F�'PY9�?�$�p
�5KB/";�-��#\��`��5�����P�G����:S�=o0}��R��w��v�sі�*���m=�$��SDP��.;�`^���855�#"r�[���l���N���[��g����Y�mA�Ĥ�_�"��L��ny6I�]Tt��YP���NM���9�tb��B���+o2�>�X���n��#?
�"�Mg����zVaO�����^ =�.��+"Y��Ŵ�@q����+�i�e��90����L��ī^B��T.���:���/�0�r�*�#Ɗ�j��ԘX:����	(hY�.�`��L.�YE�<2:�b�5l��U�B���^���l�[����}�|*R���f����R=i݈���Ў%�l�� ����@�I<� 7�
�������]3�gqGն��-Q[i���Pą	�4]���h8�p)dQT��h��|Z���8V�TcqJ<�[i�Ƈ��8�䈢��u�&��i��Wy�����4~	��͆��!ژX/�R~nn������A��"ڋ���3��&��}����Wk�!�ʏiz��$\X�w8�mo��~�
Ÿ\�$�J��=�a�S^�S��!~�m�N��*�o�|� )���t[���{=�����x0�>�Y]��[I��lI�?�x�>x3^�h�˭�'�$�����R��4���'&`�Lo4)�`
^ ݽv.�(�:��ޠ�B��.g�f��͘���}���B^158s�x���O�Yah��&c���\z_;�D26�(�i�Ě����Y�W���+� ��!>.Y߃��6C�(ev�Avv��5P.-��At\��_�N�r��*�%��������H �si���2Þdf�<��!�­fW��(]@қJb��C���aP���U<���1�*��Ѓ��)�K���Ê��7-T�6*V}����r�;#y�s���9J�-18s=^]=j���?חa�y�P����[gq��*Ru��`�e�O������O������=Z�5���G������dc�\�,>>3�����Q�뫜๦����J?h3>��Q~�1S���y|/"��d��n�� UN�n^��}llc�jï���g����>�GHA��x݄�ag��f���$�qLg��0�ʥ�@� ��ޯ��%�ܷo�HY2��5~�F�y1�yq,��9~C @{���ú�����~�t��4��l���%��7tt�#�y��o��� BH�ml���b�x�Zfe�+�h�7�oZ���=��[%�K�`���� ʏ5�TY�/�V���?�t�}������v���Y��W�얍.��x�-A`y�j��IU&�1a��;ι9ȹ�Um`����/]��+m76���IV�dK�3�g�>�3��=r�I[γၗ{��2A�����9��u&Y��j. �n�J�/N�H�R�FA4�����1C3A��&�G?!�d���Z�G���fn�?^�  H�\�;�y���1pa�+J�t>��)�?�+�$R- H�7�l=���O�Q3`1Sa�_KX=���f3.4��o���(3�,�G���6z��pg�n��W.c�;Z��U�Kjðh���f�C:�].�+������6@v����%,[Mx�S�]|ә*Mu'��zF _y�f/��a��x�2F)�T�F�4׾.ɱ�g�� �Jxn���zޝE�=�x��P��8u�+��E�#����!sV��1�C�T������iWJ��ʓ���D6��?7f�ѕ
!�L�b��W�5��H��`=	q{~n�張j����	k]�3�ӥO�/���� -z�����3J�^?�m�Δ��_����W�.Q�{0�@e��u�`�عCUfy)����D8_���B��?v�~��;{	�z���؂�����E��l��׹�*��یS�+�U�*C�B������Hp��|��Đu���ħ��S�D��L�@�$sF�k��n�*�rk4��p_��tp���?����p��\rU��T�N���?��8V9]ӽȹa�fףྡྷ�����Gz����nH�섡� ��u��ȵ^ڛ�R��=�{�P)k�c�~悘�	�}�S��B���z'*5��wxi�5R�KJ�>O��0�n��c@�5���|�ڲ�Y�'7�5}�7Tѓi��N��O���o�07���O/�}_�x�V׽C��b�u)l:�l+�6��7YG�7<����~��}"��[w�H}��U�.��P%]<j%�����R��`���k����~��3]�Ջd��`�����5��Iб�����ut��K�3��Ul�A0�N	��%�g��+y+,�ZAs�����Z1��ȓz*i�],E�����~����jB���A��\���U�`�s�������aK�SkyPe�v����>��qb��0���n��z�F�w�O��vD���8�ez %%X�l��:�w�$C9��\}��zU�C���jS[fkU��C��"�2�t�j٠ы��Ay)O+ՏJzL�\���: lZ���e�]t�ع�eO�{]1]��9">���=���3�̕�}�u2��S}�j����i�߷J��f�x���{Pbr��nA�?��k�UdY} .{��N���#��z�S���s����{g�=̧QU���LEb��,5�J��:�����}�/�S�ʽ��Q���J<�v�{n�m���d�[ut"����A�<�3��r�W������v���P�Ǫ6t9���&��2.�ӕ�_�a��6.�9� �(t�g��P�L��EY��jO2��g�g�JPJ}��Ķb
$��A�GI��d�O`���E�x�W-������l!p��Q��S=��H��$�zHQ�j���}�a�AY C's��^����~���u��;��]fy�/9�D��%C�uӈ��-�MI��߿�'�6��ν+x�����L���s����n>�m*�|��!h�<���Qgk��sw�n�泗ݯ�W���ր
�c�_!7mWլ޴�~�B���c��;��OAv불XF�m#V�_&�O'\��y3P=l�, �=7,�ۓ���
�dsS@P�6��"!�페]3FLb�ůhxw9�~a�|o+�!U_z��O� NW��M�&�ݢr��E�\~���S���)�X�����_�E�I"	]�.�x'n��]/�M�����۳���N=��2=<@�ٵqg�=��_-`�U�QHQi�(�b�b�������6�NuT?�8��X�_��ܟ=�g[8:E�.� χ+��'�_���V��;F�*r���ޑ�xc���~2�qXd�{�WZ�$o!�Ex6�+���LU�^��?���7I*?R	"�}߫�;�����ÐZ��8���<�i'�Q�2��C��e�z��D�l���âY���^�%���2�"�˥>���b��l
�x0/Nv�,tu�j����)���c���:���_w����/�G���)���<��Dw},`]�-���^݃eu<��������p��@�Rj�V�vl� ��)�o�w?�>��<��_��^p�4ͅj	���#T���wk�[���`��v}�
͕�>3,]F?��O�FF:��8�x���A5���RrS���������m�U�R��\uFZ.%&���A:�_�m �B�̸�|�[�O��`���%���IHp-��*1:LaO��2�h�v�'_�4@$4�
������I�e�̪��d��;�f�[o�+�\fxI�e���:S^��B�V={�*_w�`���>a�v',D�������=u�8tR]�49�R}f�z��gK�e�x����^D��,����~d�;:�7��YIU��t;R����]���Uo�>��~pjÒޭ
���#��&�R�!�AF��@u�?n��zG<��l��Z�O55���>025    V�2�z��>R�m��odL��7k ��;C��+�̺��xI�>���;=������I����K"� �*���{��kuk.u�}C�ݍ/������? J^�)�t�hi�W��}��Y$~���C�W�ҝ-����?��ȇۖ�����\�\�^¹�����æڲ�C8!��gj�t���~3��6O�~H�XǄ�B폲����@�m��j��<T�wT@��?&�K�����6<mu]Br&v����_Sq@�p�1m�����Db�~D��fP�L�:�%n�Tڸ�9�'�dwQ�Nԟtow����!,����8M�؃�n��Z�҅����.`?g�D���4�8>�4��Zv25]q�p�$��(����w$�F� D��Mḭ,vuZ��ۗ�z�S S2]p�S��C��I6'�z�˧�.�t=��:lk5�#�@��GvM	ʾ����fϓ.&��[��lſ)88�;q:�z� /Ke���1�κ�[BI�}d��C�@�&�g�����m�9֎.�R����>?NX;�a�b�|G�MH׈��%��}�׵IZHqe�W���1��|��|�ݯ[u�M��%���֕�)ϟzrC�8Yl8��)��ah���D�z�Dz�C��'Ŭ�?^.��;=?��
Z2��2@j[\]�-�����'4Lē�J�}s�tR��S7�y��&p���х��B나WɂU����C������q�H�hX�'7�D��T�!���$F�H{����cM���w&ZO��~��{˅�$�1�O�1>���)z�,��wf�Q�̧gx3��ծ,�X�R/�Љ��y�~]�1������>����n��O�����t����P*�����oRI=e9Am�?�^�o4H�3�Hz�3^��\i
qS5��9��fs�u��2���ֹtq��X�@��T":�%�E��8��)����E��-���(�m�6�T֣������w��k]�A�
�@o�*h`��5w;}Z��E��W�Г;bݡ���r��җ�����������|M��5�9f���'��NӮJ9����u��G�Y=x�P_q�;��.@m �-Q����>����`��_k�ۯWj��Kn�E����g�3��
(L���y��b����:�^���+���_��"�Y�B�1ɲ�`�|��Ih�~��`�GF{�m▴$�ǤIrܦ �v��n��*� nx��뷁�w\�������R����D�ɲ�R�S^ �n�6�g��S��6��L�x�{�Y#CW���WG1�n����ߔ�&���2���n�рO����o�%Ѻ	 ���,��1��)\�����Zb7mB�)�:a���,��ߔ��K6��.��un�EȽ�vw{����UC�J7>������&˩�<�ꚕ%܆��"8�q�h�c���rƿ����k��W�E��w��K��(������	1��I�ܻ�c캘��4�����a�
�]S�֛z�4���`*ha�����G]מ��%Z�=!�j�	�o�>���lյ�>�?\��7� �m0Q�!(B4m#���$Ee ��h�2���qS�h�	�jvŨ��!:��p�`�	*<�� '�

`�0�K�d�3֧����k�Ђ�z�׽�l a�~'�֣^������`~��/v�Ӌ3�"�M�����X�%� .b�͓Auω�W�t���H/��,o�x}N�����U�I�52����~��DWwϋmYH���� ���t�ӷ�d&��9"��[)��`7�ɘpڪ�M{�W����O���5
N�!������[e ��J����I�<N�P�β:t��ܰ4�엢��D�m�X������&-˶I�iy��$ ��9�Rؒ�W��lU�3ߞS�3�d���7m�����%)�\��>��H�sI�,�ST4aQ~KP���z����倲�;^p����Y���0!wlW��T.��M���7�8H�U	O�����α�����X���A��	 Co~pQ}�P�ɟo"3�ɢ�2�qv`���T XB&�e�¹��ar�I:�@u`I�ޓ�����P�$r��oL]���?���r��I\��}�L��̏�H�;�a��'��=�߉�9���{ݼL�瓱�NBk �F�ҹ�8�/�!�)' �H�{�X��t�t�+����+�?��wo��B�vF��>�I�z7;ۿ0��Vd	��+.6��4��Mu�ֵk��tF��ovX�z���xٜ�&�58���iq)YO	��E�c��<l]< ��JON �t8��z�~�]�ȑo�
Kh�{gФ̾���M��JV>�	pW{0�& ǌVO���
rn|Q���c
�����I�5��/�'�Ŗ�V�v-�M�ޒ���c�F��c��R��=�\��w�a
��'Gw n�Z��e�WK�[��vK��p6	��p�r�}�{��$�<t\�ɕb�i᱉krS�5]D:B����J�d�#�ml��ۿ	<�˃��P�����k����k?��4�Ze/��S�~2U}K����>����o�+z?��|V3�2�CbQT2޽=_��쫆��UM�Kd(�\8jfߥ?�u:��s�zz�+Ñ��.��G�K�XtV�_�}�Ǝ�M��O�c���i�ŷ�M�l�$.�������)D��'��y"�/�-�C~��q �S��+��Vܝ���� ���b�`7�$JXw[@_U�ot����V�y�;
&��p-��Y��[�k||·?b�0�!��dˠk�I|��.~�.�H��k�e6��������!qX�Ҽ4�!� 1��!���������%��@��K�U��ƨ$��`��w�BK#���(��T���@BE�
��}�F��pxpXlu�®����i�����S��Rv��w��-{��M-�}�#'�T�~q���(�n`���Ej~/���)�����n}��C�����h���ȸ��/j"ш�ܹĽ�b+��&��f���-��XY�����w���2���8[��]3O��� ��T����E�K�m�D���rqA����G�vܴ\����`�h��mK�S��P-GV�yW�E��A��ß	�Ujm����\Qb�"�쉋�r�`2��6/ f�YFzb�%m�I����7T�D�}�RT��dx���x�_w#�!_w��>z�,��&�ߵ�,]4h�#y��W���2v���������.�4����J���Y�ڢ������ÍV�i<��n�T����V�B�tٜ�͖.��as+O͇8�F�����w#�%}�y�'�|�O�y5������bI@��-02)b�������	��,��tv����9�Qd��~����τ��َ�B�F��87�}���ى�/�7~|��L>�A�`�d��&�^l���[�kJ�����V��E�2��VY��$ۯȱ�����KC[�$��3���?k?%B�Us�*��%���;hGFm�9��q��M�*y���� ��s�����i��N�ʀjC�AԄn��3/��[��f��=�ސ�v�b�}s���>��n�[A��A���� ��v�>��H�y F��e�oP	�{���x_������؁'��2���&���!�d|x��,��ҕ�S��*�bs����P�_ij�M�F��޲��Aҧ���O�L��bx_�2^��Lr�r���z��P̉<36�<:�N� �;d�N�s�9��ɕ΍$���sW5e���5z��<;sh�n�m��`����b�D�k��+gzZ�ȇ��hفr�̓����<��m�-Ğ)��VO��Tj��o���.�wx /�{�a~O8q��w_0�^�a$F`k�JHN�C���:�lnW�nO�v���	�0���^�="�Y��β�Z�,ΚDڇzY�1�M�М�b�Z�$��7G5��uv�e^�}u=�z%�UyI���O+����@e��+��Q� ��GF��mw�|�ѥ��E�r��
*V%�*�C�������&���p    �b7��Yf�t2�	�Mf�	�I/�{�2�$7S��"���zZ�2��|<oL~�y����PWb���X�D:s��Fi��}��A��O�w�ZM�;J:^^�3K4�uH��~�gkj�h�]ż����H׻�.���v1�]JM٠;2�2����-s�%]A�,��-�+I&}��9�8����� ���$}����Y��<�KW��tԍ��Mh^(Yf�w�.�j�r�{���*䒸�Bo�:�.��P
{��5y'T^T�|��?���� 9��F:��l�b���s��z7 f��r��ty��ָ�B�[ X@7��S���.c\toלmd�i}'g�����������
�e��a��0��f�ؙ�N���P��u{	E�3��l��[<�]�*��x*דk���*���}�i����NxU����L�9�����l���L������'q�	Z�����������x&�:c�fo6��Z:��z���Uho��K�o4�����=L�]��dz�kT�[�4������XŮ��=,�s�ъWtz�����k��~�����o<|���L�n�?4-������	����g�7x���Qc�z��~
�uR�R�Xl��^J���0~Ͳ{h�?��i�̵m���z��o�ֿRKر9;�(��!ċ�^J��e'���\4�q����$�v4���.nF4qF�պ�ҍ��En�bi��&GY�:��r�#���q|���m���^=�d�瀩�đ�`��Ϋ��I?W��	R�o�/�\{����h:}AԆ��?x*B��5����]1��)�ӹ�݉Ɠ�^|��ކ��gat�[�[�:���c��dB�蛍�ER ,�i�j�;T�+�(�X�_5�R�ɨ��bu�q�C\C-j�������2W,7��u�C����W���ww�����Mp&l���q���G�D��W��I����)�5\�����K2�42s�1�܀�φF�Yw��"�ϧn
_���n�@�P+�	&��0�4:�*%�B��S���X���&��lU<I��Ր�n�K���N5���~N�R�τ�K���>�.�}�^f�J?��)�� 	t��jhg�j�u�U�1��|�����%T|ZG�(:J�v����zW� ���YAnc�4��*}M�gP��<��g�ձ ����އt�.F�4;6��D�3k��t��뙁�L��=��	�*���AA�eE塌)�iK@� ��SV�1f�M��r�a4�E���k֩�#q���`��^���l���~\��2E�w-��U�*���&u WY�x���}0e�*p���;"  �>#��]|x �A���7^Bot홯�(�Ҡr��椻A=���؂���AXoy7�)
��6�^ʘW��YpZ��Г}���?�Zd�tF$�|z�<CAU��{��Z;��6�?ߒ �v_����h��n3�^2n��z��V�/�J�O�w�\�-����`�$h�q���~��t�PM��+��E�q.���rq����KGőU���Jp�@uK�缨����V����rsY_��������}�<o�/]+�[�E>�f��12��)&	��x]st��ĭS�����5j	1ڨ�6be�K;a��F���=~u䟃�y�4�����fU�	,1��/v�O�ŀE������,sYߵS���]�d��%�ܷi/e�o��{��wN���34�:�#�JͿ��11n�k��[�U&�Ei��`%&�HY�׳��j_D��S�Yl��{~�6����/Ɨ����ڭ�%YW���D���^�a���ᏺ�,Udf���֤�)�1�L�N�+m�;�
�įyQ ��N�"����r���
ꩯ�ݓ9�!�1=�v��[���5�Xݽ�Y�@t�"U#T�i��knfL}�7�ޒ��vms��w���;<
ugD�Ef��k�}**QP&�lD�	G|��Ua�Ǆ��yJ��E��x2b��}~t����M���_��a�2�ш�J��,��ry"Hh�X��Uhg���;�eu�(d���z0Y�<^��*���K8�D�5T��>�e=��zAZ��S^�]ΗҸ�s�P�J����֛|�^\(�Sb�\��1�A���C���_���P��I|�(��"<l���σ�セ��︓yKf�t�g�p��Fg�k
�U_��*|�c8���w�G��%T�&uYe��>�,�ç�ع���#��h;��MR�~��À���J��ԥ�{q�;�3R��DȨ@�_��Po<��[ \�s�Ή჋���B����ǟ�	L�Fs�X1��A�����-�)�	֤��	�K��ƿ�3�2�n��#-<}^i	^$�^��k�6:���]6��Ƿ��:N�M��8u����W:q�B�(U�TC�9����"ϣ��$���2(�ʕ��S�v�C�GR͘q�L������{��N�pQZ��*پ�I���T�"X�+%r��-������-~QԶ)%2�W��(5^�C���TW�;�m��:����^иL5�+ℇ6(�݋ٵQ��=�Oa?�����~uNv4>���0H-�#�b�����% )�v�6:���tC���/+X�l����@���JK�i��Kfs���{�amށt�lu���b�vW��0�$�T���\��r<�k��O���3I3ᠢ8//�Ga<���)���N���.T��D�������7�_�����mWᥥ��Ď�dw����zW��!슼�(|�;߯-c}��}U��S�]���_H^����=6��N*�����Es��kU���rU��O�?^�(��4��2 �V%g��y;�1��g�:p?���*�v�d�X�5������E��!j�X�|�j�����,6�5_~�!6�5gJ��x�|Y��H�^?��}H���ϓ�x圌��B<��\Y�ol��@&|W*������w��.�EUˉ�fه�*|�P��4��l�W�:V�5�I�3�G'=�1����C��Ї,y(c`�_ �^.Ob����4SI&�yv����Z�s� ����. ��7׋?�cnϞ���h����g���¾l�m������	&���se��ҡo6{p-�9Ͻ�y�ba#�k�xo���,��Ľ���� �����b�8���|�D`��4��e��q�x�q-�
}��=qL@F�S�/����.�8��q���G���C^ޱ@�,~����5V�^N�D��=�_��������R|n���$� 6��� b�A�s�������D�aE9$N�[���eb� Ǣ��� 8c_]��}�c������>< �`�����|�E`;��ɲ��� ��|�Z�*���h����h��l��d��]hR��>r����?U\''b�9Q>DZQf :�2���H��qԍ�,J9QYH~~��SWL����)���_�o,V����[�k9��q�)�&�n\+uI�tR��3V{���ߢ����x��wGO6��J�s����k�F�!MT5�g�H��y�����q���U[q�x�'��1�3� ̂ЌUR����\�R�{�:*7�1���1�/Et"�J���Lg�����I]R�u���~,,��_��g)�QWI�+���;�����T� ��I^];(S�D��n��z�X����"͉�e��|����%�Q�2M�8�]�@S��8Ӥme3�a~ܣL�Z�[�W���z���3��rAfa�\�l����LI�c>g����,4���Xm�KV���47E4�ЇUO�$O�^g�O�	Օcp1�$f�a-���)?t��r� �p:�%4	L+^�x��:U�-x=)�	�*�7K �e0� a��KkZ��AxU?e@�ͣ�t+���5D�`h����k��.$Uz���9Tȸ�귎�I"G ��wcy"1���/-a �B!y��~�"�F��K�o z%�!��/�����*��2��=���~!������ �+I����������%�Ү�u���FS���t�ٰC��"V<    ����8��|���iKK�:m��b�T�ԟc����+�� ~HLe�6���W��P�mso�=FA�.Y��gk�A�q�4=PP�����(Q���[��52�@Igb!6�>���f��_�7x,z]B�	:��Co%԰�����K���b��堀�")k�:�D�N���{N3(�̍��'��-i���\:�����t�:���a�	'T��"D�)��#�/:������0�^����V{�0�`��u)k������/>��_�A�i{c�z��� Ŵ�a���j��֛�Q,������E�r��U�9��#	Yo�����(�5�
�of�Ȅ#��~Mr�h��7��8y��g����Mf�;QFp;�������I"O�^���IaW�Ma�	��:}j�H'�+ЯI<�SU�xvt��'u1H�9���W%'dz`t:�޻��������L8��DGhl�~�:�~�y��Ew�A�i�Zq�Q�_�sf��ݐ���Tu� �C`�:�S��pؚ�������ؒ������f���08���xlA,��G|�$���O:�/�sa�s�<�iM�L�>��uOn{�^��
s�幥=&�T��m���f]�I�ӑ�O4���Q��x�P����A>f�h.p�l	/��jj����'��Vߟ����x��[u�ʼ�B]���Y�+��iݨ9�B���>�#[�a��{T�����(��p�1�N� ͞�Q\4��BK����	��C�q��j��y�˿�����0�;�i��'�پ�>o���Ǹh�I���1��5|=_�.:�#�N���(=���L��n����� ��\�L��(�z9����c>�;ϐGw�m�o�р��3�p�lyR�p���t�<�{�&��sŁs,ŃNǅ���0�P���s-�u�1�$�[�`���G�P=}QM�����nn��X���p�L�ǩ�8���?��{�ۓĥ: �46���,
k�����UF���}�Z��l6�c�6-��B6���IbW�fd����p�gNn��*��ޔ:���%��������� �f�Fw������/[��g���P����OI��xͽ��&_%��9b��I�7��Pߘ`��6	�&�(.r2:
��[t�A
Ѭ\suR����!7aO�m�`�w�$�^q�r�6�[g)&l)���3}�o@6�����N	v�x<���3�k��"�tȊ�$)�^bi��zku燐	��?�7�Q���n�{���\i\ye���fF���k���B�1�LaTj����ߙ��b��S`�,o��u�۪����,0e���\�� qO�42b�Fyv�)�P��X���*R��2���s\���m�u�F!@���tC3v9�>"bԘ��f�T�* ��,��d�`�f�	��v��\}s�~���d���]8�k���>N���$x��/�8�3�Ur�^�gu[Ōm�������ل��x^�bB�J1��z��W� �~97T�D¾����
rM�����0�zw�'Ha���	Ȗ�g����槃�W�|�w4�T����V+q�|j�A�,4��{ �l4����mc5�~ƿ��?�
����A)�Ҧ�hHS�.x��ea^�X�fE�(�(�ă�����B����j,�G�Ë̿�wA	>8!�`��NM�F`���$=��T~E(��>.X��"̄���<�S�^��:>�D>��.ᄭ�:J�A���@ԉ�Z�d�~Z&�z:Vw�v����6��5�0�RWG���?n��csԺ��_� �r�L�[�A����쾦��k�b���|-��{f�ˉ���w�Jor߃���ݻT�������9���/����ʃ�����t=J?$�1\�+�0M��c�@�FV�54Az����_��M��/ksU��QE�*j&��CU���n��~D;{�r���\���S\.��Q<;�F��x�<՞�M6iI��0G�䕵v���x �4	|�T`�z�cGQ��O�=t�R{,�q�
���m��y�	��Գ�-y�v��ϻ	��;�E1��/L��^Q=����A�Km)
�mԲ�ke��ߜ������k�n�il���֝���ҽM���\e8�p�>��N7�iS���D��"�:��m<������y�_�o�}�][ٱ�b�\�u��Wp�`�:)���>�b�*ڷ�V7�S�ǽ}W2G\XC�m�_�` �--��X�������ϙ5����\^�"w>D���6Xu˜���Wn�ް�uy0��t���y���F̂�� InR�����Q�~��5{�z5�DxR��� ���9���n�t�f|��6	��x�����B��@Q��ν����sE�O��ˍ9��}Gh�k,���!~
�f��9��U�^W�0M��!o��X<��8�,|{���þ1݆�� �IǇ'�����h}���[�==�a���4��1C��ͬ��5<����N��i��ۏ�G�tV^��t�|��)`�}��̔����Ev����ۯ�N%pK0; �0h��F��'��Ho8|�`����+��>�G� g��|�|�Τ�f���&���ǞY�%<*h�u�5�.���/Qo3���Fw�����V���}k��`tM�����=8`Gz��? 4jUr�ҟ$����

Ϟ��KL^�C����@BS�z�Hkz�lYW���os���BU5tP��ymH*� �m���]��J��r���>�J{�|U.�b Fv�ì�ta���kR��yy�71o��^�ѽ��W	��� ���姇�]����<��q���f��`y�9^�c�N
w�gAV�Mcq\V�=����}��������xi�t���D�9|���n]��y�O�\u��y�O�{����K�1=�O�g4�8�\���q��(��0��d�������v��-���FI�V��B:�h�hO����JQ"6G� ��?��
堥��Eb��nj3�&�F#*���x�N?O�V���+^��ŃZ�TO��қ6(�}K�T������E�f���k�nL�nl�����<	�Wi��O���M����@����)�B{#���i{�v��j�h��d���]��i,g�'+ �&�48{{n�j���N{;�I�����������<�ɮ�)��/�~���M�q������;�7����Ǳ�yDe%xԋW�)AE�_��F�߱�bl�D�u��h2�^�4��A����k��U�	�;��ň�����d�6<Qf 	�-�s��̋zK`�1��t�s*������0���� �發\�
�x�X��dL��)t@��3���X�PEz��j�ed��i۶��"F�n�]��/I,��zi����헼�r-[�siyd�FЖ���C�ߜ	M/�T�­�Ѻ_��'�c�p|��"�_�U(�� 6���H�tӒPw�n
>w���� ��m{a/(��B�c;��������ނ����N���Ǽ�
��m�O  :����]yP�=u,j6P����8����		���K �$����A�|�U��v�~���E�ϯ~<6�<��AO� ̏4�z[V�ӤU�?:5��'��q�i��?��݇a��.["��?�&Vʯ��4n\���_My#>���Ѿ��{���8Q�,����<�!�*-��N�� �9��ÿ7��~�r�mޤQF+-E�E��������T�sU�v���e��8LF���gRM����˅���'���}���ĺ�� ��L�1[����Ut^^�9竡�_G��W�0�JB&3�O��9������V��:��5�[j��a��	����DI��.�M�|�gn-� T|��:,Z��[�Ѹ;��Z���t��/'H�j2���,�$����#�L�%� ��HJ�ʺm^�vi^.,tę.�H�Q%��w	W��j���Ӳ�
�Xk��HA�9�%0���������7��t5� r��-����HmXľ���:#�s8�:�\��{�\狑����K2�F���/�5%����(�|5jה%[�8    �0W~v���x����{Jzc��!��e��Z��"�!�w]�ݖ�Y�*��\8�gm@8	��]�w)ɪ�2�z�s�{��~T�>��S��U�:�����w_�pmvZ�q�B���ӡ�iobT���ȭ.��ܵ���������|�V�#�!R9C`��'�g�6?��+w���KE��23�N��m����8�e"Qߛ%��yߦ�G3D/n�����_��ZLL�������&M�ذ���@om@�����r�e�@�E��!ҕ����� ������E(6Y����̄%��"Y*��D��wK'>�RlD~�o^Z�F��J*�|��2�����s|���5Ɯ�Gl���s!y�4�Y�d��)x
Мp�>�KNǫߓ��D�v��׊y|CU�ԫ�9Q�h��U_`K {��fCS��V�w߶OEЏ1� �MZ=�-���	�����KF��N��(����-
"y�s������ ��HF�~Zr/����T��qvpH����O�\V<j_�W4ԅ��,	v↽P�8 и>�K�p�"�^���'�3��6������J���5?����:z6̦[��0E%�W��
i�9K\��70M��b.W:�U8�FU�<ʺ/�S��V<�?> � �����ٯ��P�j��W�J@*,��a��b��&d�P�<�R������,m��<�,���gd8��]�h3��o�koʴ��vA�`m���,Z���R-��5	��6� a�(��xvߕ%�x��d�+�N��UDz~�i�c�#ʯ�Z+���#s [��-��iM�NMI��NP����y��� ��k�������UlLu�� 0	b�O����4:��?j����O�#��C�,@/�sM�w�|���~�RO�3���[h���O�GX�p�T��4��ؖ��d��<��M�B�*�ܫ�\t�@8K ���=�c��]�&>�kr���'��i��9�{�ʟ������2k�͑���4��J���Y�wH�������7��}� GcY�[�����B�kE��{B�%��RB�l<���b�|�m���Xj]�i\&F�z�~�� ��t�Hhz{�Nz��G�q���>��g�bW�|�c\`�`���F�O���01�Fa:t&�\E���eT>(Ek�ߺ?�u���%���:f�Q_�7�ߨ��\�Z�ƾ��f*��b7�Z{�fW�eKp|߯�9�I+�Њ�oe5� ��������W���,�FǶ�l���<�ג�O� ��J��&���
Z{V���?I�	5��sYp�>8q���i�d�^�hv��ʃ��dW�6N ��m.ATouYӌ�ďp�s��5�~����q����3�}�zG��箃�����{�/E��|�0Xm��"H2���<'�Jv�驚p��	��Rr�?{�z�˻�̪����#	�z-�B�?�b!��g� ��yQ�f^ �Yh�8:���'��{h�z��;������^��p�4��j�_��
u�n�[���Z�I�u^��,"O1� �� �?TB�Mڏ�nR���gښvo����󧎊όƏ �Nz_�.p�˹�z��'ۻ.��F�BE�.XV�05oc��;��nӱƮ�� +Yb�0����Z GH^U�y/?�,���S�a��r�ؒܟE������m��zP��e\UG}I�.5�=�x~M���탔<�ȑ�'-~'q�s;��5��Z���T,��L��gR���.<]G�s�"�WO��9��������Ͽ�(�3��Y������(c�?�M	��p����������9��r�����[�_<��l��7�>������Z�R�W�YvE�F����<�����O�Mk�{��7z�ߪ�Sb�\�v�5(�ҙ���z5�z�Fҝ�9{O����kI�Mk��U2�/ap��%���wDG$�wd m�RJK]o��GR�?EA��2�3�]���&x?$)j����I�[dR q;�T�$��Ez[O����/�E�է�\�Umm��kʔ�]!E��*;:�F0׿����P�pd������İ��_���{a�x㮬�XLѬ-7E��QJS'8)0M����bR98���
k�{��?��iq��<Ë��|��i�TEx�X���.�|��5-���t6`�w^��ǅ�7<�^�J�$!U,���H42^�z��	�͌��Y:O=Q=���=k#� Z$� i�vNx��l���RwA��q���Z�6�ǟ�rp|�Cϩ�.�5A�����B�ZV�DW�_Bh� �}#.��:
�~�	��RD����C?�~�)\�r�a�������Y�����6&��K��Ă|Ӷ{�'�}��70��yƔO�g�k�4��HyU=�M�4�e��`pX�D ɦ�}V '��?y���y"�f%LR��d�|�w���5�F��.����]��2C�3QkNײ_��	�������.��הҟv(O�$J'�{2�����r�Q���N�c���㦵S:��o���&&I��zY�e�Wm���*��x���I�v���C&�%����,���=�L� KYm��.� 5�אZ�k*�%p�d6���_�=���޽��d�aߓ
���A��{yͷlAT!o�V+�|��=j�Tε�����)��⤗� G�V��� i�ǅ�A�1w�{�]��|�����;�s4����mR�h��'�U�=�jba�2��N��$��0VYb�O����X|l�m3B
`�,�*���\O*��l��F��z��\��R����̄�l�ih���E�ε���˷��2������ތ����T Rn���~�zQ:����nI�44��/�3����b����%on&a�ǐ��H�4AL�#(!�����(�.)�4��;�3��L�^eQ�6.�?�7[9t�X��<g�ۧ��sX%�Q���N�b/wr@Ѫ�`{���y���s������B+���$D�j5��N?w�����3�d�F�%�pN�>���m�!���gfՇ��C(W�,+�A�4)Q�"A��-�b�$(���2�*�9)G����4�d�=��{첵u<j#~*NP��sۤ��}�%o`������w�.�$�;։ a�
�j~n'����s�q]��NA��Q�:W����)i�1�X8I�'Ԙ�7A7�ړ(b�_����7.��2{�%Y�!ĕ��8�M�zs\|u�u�5�~E�y��>_(�xp�Mp��U�4H�#U��H�����
���i �
��9�1���}���ǌ@-�Ue ���C�l����pZ����Yٗ�L:M�}�qC�WLP�V�8K�ןK�`�t�*�y���N���a�t��A��!��Z{S�}�޷���%������`­�炧t��Cx8�:NH���$�M�v�7j�z�HU�N��D||�8�Ўќ�M��`,Qښ�-E����+�]��=�gn��Jq�oW�_t�B� �T�������h.�R��FW�j6�.�a�����¡��=U�H�AY����<�5w�]�ψA�B�|'ʗ:^�ξ�A��Y}0ߊ�P����#��/�<�HJ�(��
����j����d�(���7��P�/a@�e��n#�m�5%ؗ�q�ja�{y�|����g	�w	�<�xK�����<�Q�b�Ir��ɕ�G+���p9v���#^Ņ
���[w��I?��7v�����aѢ�.�&ݓ�zx���?�*�	�*�=~�L��R~�d��qG�g�JL<o�'�������5ޓ��\m����`L���*y�C��hx�5N�t���T���I��~�.U��#�����?G"�8���s���dn$ /�+�[ɷ�zܕM��9�-d�58�ɿf]v���_�x�L;�9J��B� qJB%��7�5+Sk���'�����G���i� ��}L�6\�_wE���\��z�UT{��jڑ������F(:��yx[�� ��j��-�.����euSW�>���
���o�9\�R!��qE���ٯ���+#
����q�{    zJ]�m�����$�:��5l@�'[��Z��-{>R@�(���z1Q����:=G3_L�
�,�C0E�Nmx�_�+�O㇛%aQ�T�Qt�5s(��8ֆ�}V��9�1U��0ﯺN��H^�=��J#�qɯ\�ކ�G�5�6_��$}����� %e��1�]7I��0�k����u��G���r8<�GSP_���.���jï�(��.ZA�u�ۺ��J��2�hշĝ'��?ڑ��B�)�+�<7w���,4�s���'�m/XO��oB�A�,JNP�pS��ʽ����*P�8Q���� 4�V:�Ó���F���~������aN\���4�w=�I��$T�q�-��ʫ�� `��5|�-�NR��ԙ�o�З=f��Ӏ}9�z0FvݔV��`�[�us#���@Q��mD��{D��Y��Y�y��UMp��6+֦ {h�l��; â��a�{~���7aT�lw7�׏77~���8�l�E���t/�����/!N}}�����P{�يu�ئ���9R�I�#0��P]�<� Ft��7�- ��o_�����!��
�e�#?�O[Ր7"����<��H�D�%�w�_	�2"�/M�#���/�f�?�l��;F?�M:*�N�fp�=e�<���q�]xFp� C	�'|�F�чࢌ�y��|	��t��p" ��P|}�w�E�$[^��_TE'8_W�GV���ۢ�/��|��ت����c��E���-QO�8;�a��㏥S�m-��M��W��3-;Q�����w%>WYklJc�ֳ�w��Y����X�yOJ4�g��a���^����'t��h�2���b�(I������~�b�n@dk��M?���R3f���Bc
 ` �&/�&�������<>�Aߑw{@�'����L��^��3�>յ�N]g�_��硁_�+n�{r��������4�7a�J		ގ\�n�ޟ����J\jƺ5.��}#o�p�c�����M@;Cb*������z���%�/$9�
 e���ن��e�Wތ� *7t��n ~�&�t5�cB�%�<q�:���|�����n�r�%�|�L�O��ʤ�Ǵ[���S���8/&��V;�"L� ��-��?�*F]�W��%) ��|�r�zF�e���<��f�)4h�N'ч�k��?mj���q�����U��c꽧�����9�(N��1h����t���.x������^_Ys�1��z����);�ԺyS�M��T;ۢb[���?pt���)�9�ͯ��_��l��TJ�tMIh�-�(��ܮ�!&�*�ɷ;�G�D�e�%�{���6j�/����B���/�������'���7]��4�������T��;[`���)�D�}s��'3��C�Қ*�ۼ�3�A��j)���3�p�(z�f��\@z��J���t��{p�E<�}}ܛȷ�B���������"�C�/�����{3-%��;�,�b�YqG�hr�|	o�O�`<+{�tx�=Ŵ���~��57�������t���j��[�����S�jU��W�`�Q��,O���OO�����/S��偎���%�
_;�M��>�݄��$L����DH������h���W�O"���ŵ�.������O7eM?�}�A���Z�wV��Q�#I׷�����p,�\q��D���~sc&P�{�"�I�:L�ka
X��Y8ޝYz���<����|��U-
��(�އ��t��l�'��5s{¾"z6���9������h�S���b�wG຃5��0�<K���ո��� ���p�Ý�W�|��/1�)��!r��n���J����&lb��;�	�۸7y+~���X�����(��Q�J�����xZ�[�)g$��������9<}�m|��J� �Gta������*���:��@�ڥ ^�H%�����k���T�y��?j���k�;U�<�g"�Jv1g���mi�6�����:�w�D���d���-��3f��ִ�r>EU�qJ�o��^.�5R�w_�xI ��(O�]�
ˌA�E��������۰o��Lo��I3#V3۰p}�+ǚ�2�ek��j��j'q4�͈����`�'�=86,?'���v*�?�ŝ]i�{�_� A�|��kE.9Qݷ!��(�|_ME�92�\�	����Ґ��ŀ6�S��i�a�����?�/݅�T�!����<�VI�����=�84C�-�?5��xX\�����-�'e+þWV�e�"��c2���q��妢Ju�nͅ�}9ҿ�D�k��� .'MƂX?�ua��0�3D������������Zw��~��U@��"��@,@�q����BEQ�bz#��?�X��JbU����ƒ���!�K�*��n��A�;��s?�y�0��m���fx/�x����[�ѣ<h� `{D��n=z�<���5ͷ@�bkW���# |��.X7��^�hL.�j��me��d��%�&�rdOKq^�>��ް�ި�+BR\�=�L1� ��ܟ37�`��UH�P�3N���<?^Q�Z������{{ �{�����{�ݓ��ݖ��GaaFNBD���4�`�<󩣘&���d��Ȕsj�Ptu�y>'U�Ҫ�[ޖ���`oK���P\X�Q�	���!v_��Kǔ���s�.
���<� �D�>s<�n���<+�?.?CR`��#HY��7H3��p��u�}N�җ���(I~Ѓ$}���}Ԏn��f5i��&�TE�����=L��/�����hmoFs�d��/��[dj�Z~����� Í��ű�jA����>K��E��Lm�0]���K�e�Q�4�'�� �
���D��w��ݫ�6�G���3z^�*�����{x8�s�/�+���6�y����/x���9���P/z�Dk��<�zw���p��7��M΃�9R ����!ꬒ�Vb�;�8^����y��cĀ���j�����)Bϊ5�?f��Ӆb&�7|�@�3[��/�o�J����w�@�J���[������ifYvl�UxH��}*tv���d��W��	ޠ��A��Z���OTݕ/�F)H�t�xY�ꑯs�L�sn�-b4�߄����������]���,˫�����\߀����h�S��bm`n��{n��V�|�9>:f����G4䯌�y_G�{ޢc�AH�+Mv� �cw�!�"i��K�q���yH�2�����˭���0�ā:^��� )z�灘�ok�+��)ў�{8�(ڠLt�WG���QC�%?�T~�����9NF^�5H�m]x�FLWh\��F���J�1?�`�;\-�G��g0�%j���>������U%�ĕ�W�'����"P�a��㣧[�M���6]�)'�a���s�s\�_�ō�RϺ�ڤ�P���6�)�hو�4�iPk���#�;��z����a9a?e�z���7�ipݒ�m%	襘$]ރ�_Kν�]G=%
�QY�Z��Xm)��L)��^T�����2��v�b�9]���g��qTP��!���1�6�O�a]�uf��At(`Z'��i�TPo;��r�za�;-Rb��ߞf��,�)ի��V�M��w/��>!7�]�YH��Vi��a���9�U�Ӈ���}��~^�{����C�3�h�wM%m�|��?�������楼���]m_��W�Ŭ����Nz���>"X3�F㚧���=�ý���J�'��Q�|���x�V��u������AL��VCg��(�p�L	�����1]�o�vI�w�vE�׼�,�����r�TN�0_PcUv]��EKK\��B���,Wk�M �aKt�&6ƹ������'��6��^aq�nA�?_�����A��K����y����;��)���8��� �2_�ȁ���F�z���,�q�cM��nX��Xc8�~ɀ˄��Wf*�i�k#� ��Q�1q[�b���k+m)�/��ν�S����B�a����� �  >w7��Y�>���9M-_
�_L�?m��T�ƣ&��+�����@���0�7)i�L �X;�B�6J��9b�V:&��R�������?s2������Q򩠞3�/wۧ���^�c�{eB|��$L���t��ߕ�7�x�N��y����c���{^���E
�Y%XM«�?���O;��k��ӥf�G_9E�b��L�A
�O����G0�����?`��pq�/���k��k��i~�������2y�K�L31�_?�! l���:����|zj��b� ?o�������ƶ\Y�gG� �t�*I_��Mc$��4�IӮc��n�uڶ�V��/^�[k?n�(-�f�Gn��v3 ^��$͛���=T!<ZA~��IE.���y�H���x�-{/Y�<��e�O<��l#�>�n�2�6���l�bز��ט����zǯ��/���<��m�#V:���`��*�ḱ�����O�B�޻��_A><2�!k����x��y%Y �����b�@-wJ	�y@���jiE6�1U̷�/�9Ɍu�*?����� 5i<m�Kh)�Q<�V0FG��VnO���S��'���N!��?3�$X�>!�p2e
}x��W�f���\��IB4Y.�����Ԕ�Wp__��X2��۳�=�OW�I��o��MٙSo��l���긤��FȄ�qp�A�ʞ��M{A�~��/Ѳ�i����~D�_��Zw�q��;s�}5��,�u7^��%����zB/Y�����e&؇��k��SD�n_�2˲t��n��m:[���q�NhZ�-�"9�������?���^Y�|�� ���Ѻ����4�kq�:��'�Ê�y���HvOc뛓)����]��̲l����z�0�%�1�(K!�	�t�K�l��idNo�w]z�_�W���6ƶ�j��2�.�lJ�Z���峍I�ҧ����~^`B�o�MN��
�Q<�Q�r�L���h����k��'�i��W[0OƘJ�PR������v2GPvl�r.��hj.�n�KH;M���[�����O��R�yf�s� /�D�t���wp\.�Ya)^ףG a
��J$!�5�g��Dך�����a�t=8b5b��зqr����ka�e�r�i�wc���F�;&v �6c��o���3�P� 0��9�sD����uf/����_���G���&x��>^������.*�8N-^A�PM�l��$�����E��ڜ�0�w�%��W���!U��[�(P���8no9��ᗛD�Gz�V�M�.����x��չ�]c�~z�����$,P��Ko�قMf�&F�r�H
|Y�����v����� �vu����Yc��p����`Z劰��&����[ث���jS�����B��)��� &��x4�WW�m���t���uIHQ��.|h����|���J��mu��������"1��ľ)������w��Tl]A�\��r�� F6�uFT�� ��_Q�9�1�.P��>���ïOr�-_��<��}� ���~dW~o��Qg���&SJW@��o"h���;ӀZK19\.���?3��|��� ���Rp��9�W�V�u�pk���WÑ9���&���ðo����xї;y�MT�� e���x��qI�LI;8�����-��T��y���"|ڈC��߶_�]�$H\�BD�z��Nt|�׀r�\o%�_�K-E�$�v:���S @������D�'�#i�5�|~QYY���2$(?�UC��e~�������Y��j���G	�WƐ��͝A�]����O�r���p�����;�7�˴x� �r���1�l��g���j��PǺ�;��+n���:�9����;JK���m_�����
��^����������P���A`��b�%�p��Z�"�h{���j��UY8������o��o����      �   |   x�u�1�0���>E/d�I	�i(xH�����Cŀ���ӓ>��7��$PdX�f�M����k�`��Дm����J==P_$�k������t��;����h��$[l֊��mL(�      �   b   x����	�0 �s2�T�hH?BD[i����� Ϗg��[b�
HӨ)m��*Ij+r�$��}�ݫ�n�A&�\p���xe��Q��ox�G�F�*�      �   ]   x�3�4�00�4� N_W?� O?ONC84202�54�50�tt���9����2��iddfadi��������
3	�l�fr� �%�      �      x������ � �      �   z   x���1
�0��Y:�/�`+�T;�#��!���J!�%���xt}H]D�@���C.���ѸX;�.�v+�I������m������g�r��Ua�[:�����ɇ�����}M��K�F�      �   p   x���1
�0��Y:E.�b)�U�Ab��l��9������A��ކT��,�đ�(0��U��!��π�����s��a�m�G����o�]밶�OMb��� ��-�      �   �  x�͗]n�0ǟ�S�l���I-�ْ'Y6��}hl��ΰ#�b�۩������?J�(1T.@x�����N�?�����gj~�����r(�bq��gE.��}� ��X��8{B����]����n�P�*-�^_w+j탳��s��c�O��?���B�R��
����S��H�����	n`����TF[j�V&޲�$p��-F���iP:����nHgC,��{^�K��'�����=:k�b������7
\�z�.z��L�K@)up&�cԄқ�4�B&�$�=��aZiн���C��Er7�~w3<ژRB^@�k
�ƽDNc煂�;�+��1ݙ�f�R�w*�d�ؙ��KJ����N!G3r՟`�0h��é�ˍsZ_�PJJ.oo�^�ҷ���>5쉂|	z��!z���4L�"�+G�d��-:6���%#Gr�5���w"�đ.\�m{��J+z=��A._�%kM�����W��(�X@cj��o���J���-���>Qr9��:@�0��v�zpN��I�Ö���L��qPg�]R�����Z¦�t�`�3�h�JS�T��|ES2�c��q� ��͚~��X���C�Y��ӊ�|�[bl3��>`9�6aI5Э	�i��Ɉ�JZ��B��Pd���{=�\Y�7�|y7������5      �   �  x���Qk�0 ������N�d�m7[���R��J_�##]c��''͚4l���уO:}'��#j-��
��:gɳYX\���[Ap�s>M�\o6���/��?V���կ�����r������ƅhk���\��[�>� L��4G�sTw��E��!P>
t>0��%��q��h?&gK���(vv`�6JQ�V�rG�w�-R��2�k��a��bn{J)�R�AO��F�Lm+뉵ƛH.�pT�<�"ݎ�8�bzZ�l s��b�9��/�t�_��)Z��1|�����>Ptt�%��^
-.��Et�t!�,%������]K˧�Up#�'�֛v�lKn�g�����e�}	�8�e�� R<�PG�{�ι΅:H'� }v�Co��,��z)o      �   y   x�3����s	r�4�4202�54�52�tt����	rt��)�e�������H�ncN�G25�p��:���:�@��� ��r:��f�e�%��!Kg�)��d�e&'q��qqq P<C      �   �   x�3��+͍��+�/K��L�/�4�4�4202�54�5��tt����	rt�B���S��w�t�tv�2��XWR�X�zxc"�Yf�p�����:F�y��!�A���d�d�lR���'�!�{����F���$P2�t)-JL��ϋOF�/�$5��ӈ�Ӏ&%LP%�b���� ۚ`�      �   7  x����NAE����Q�]�^"�aA"���w��!�䮁vn4b��3nϱ����M���$){�{N�����O?__��}c���̨Bꌪ�ͨF���ąA�uP����8�f�aRrffӒs3���������&'gh6=9G���9&��8��q�	��1�^�9&�K8�z	�@/��%�c�!(�$(*��
E��T���
E�<���<U(��I]pPs5-	�qK��uOy�6�96x��ݴq��1���~Ȟ����7�:�~D-��1�?0t=�C�?�s,�(��q���^�n�ϣ#�rb̏W�(���5��Ǫ	���cQ��<��%=��/G)(i�]f~ͧѱ��S9>{�S�<
�,�Ȱg֎a��PE=>���z�a�T)�=�Ұv���@��qJ�0��~�Q�8w~�Qz���t��
D�><V����sӆf�I���?���i2��e�_.�|�2�
F���wD��wD�N1J�ŎI�ȯ�N�a�;ZQ~�2�q~�2�,~2��oaQF�{L�3]�o�Q��ߐ������۶m� ,��      �      x������ � �      �      x������ � �      �   �   x���]
�  ��x�^��O���-���/��9�ۺu�2CA�g�
*�(H6�s�P�5ʝln5!( $�q���1�0/�k�t��$�~�[7^�~C�0K�e�ca�S������Y�C�dէiyN����̿�4G�i����Z+AZi�`I�� s�/G���"���e��fg�O�� ?Q      �   �   x��л�0�9���@#ۉ�c�hAAj@6���� �7�G6
25RV�(h
�;MF,�p<�w��h�>��\妝�2X�$�y'q�䊞�������p羚��%�7A�� �+?r�o�Z�v7i��.�r7�T�A�w���`�_��t��!�qX��DA� ��e7��
3��.�a��ϧ�^������jjE      �   �   x�u���0E�3_���*1.+Ť��)�sS�EI����Xu��If(p�Dfg�E���i̽��h-)ʊ��T�(0�m<�{��}Z*��Q��]kM�̎���Ǹ��2eӕ��8E�����ӯ���48h[������t��N��9��HDD>�-<�zl7=�Pd2!q*�A�\�u��O��z�      �   �   x�}�A�0�u{��@��l?-5��ִ@4��琅��O��-�����{�.()p�3h�o�Iha*S+mT���.�u^8Ґ{��R/O]��H}� Z�q_����(GQ&;�@aG����������B*�חܨJ+s���|;�q�R>#�Iu      �   w   x���A
�0��+�[MrW�j�(��Gr	�R�ygf�u4�f�D�IB�IsA��\��qXQ/�2L�,�7��O�F�0�6���S���-��S�]ߩ�>��_Wf~/;;�      �   t   x���A
�@�3��68�>�
�כ��o	���U%���\�9��b� �#MkuM�GJ�ư���I�h�S��������4��OA/���;���-aƨ����{4<*      �   =   x�3�tv��r�4202�54�50�tt����	rt�B���S��w�t�tv����� �h�      �   Z   x�3��u�4�4202�54�54�tt����	rt��)�e���h�k`���T��P�]�1��D#Vyd�`O?_O7Og� �=... > &�      �   �  x��X]��@}�_�&�K�5���߸��j[�41,Ru���v��d�Q�	s���s�=s�D������ DX"�"H!��NTP
����U��znmVVy�
��Ps�����þV7��������M���K��ժ"�'�0�%�o�HB��"����Z,˶��p2��R�n�J��B��iM�D��Iσ�aL
�m�Y��.Aӓ9`�u�
u��p8��Vñi|2����q)e\̦96�Ifj��#df Г9��S������S����h���g{M��X�a�g�[F��JH��1�'W`�8��Ra�{9X`�g�#?��?
�FC��'��{g�� ����?��p�����rc{���q4��K� �c��a6�hx"@�I�S���=3��*)
J\m��C��5�q��ٸ�;u>����v*;ך�������iX��z}�Cn�q��<H��N�q��n���`a"x4�"��2�G��{�uT|H��(:��xc��5� @��>�J 3��wP_�/s�@ �$*7
��(�֥8�r�΀�-��Q>����H��A���x5�;��P7#�p84�����Ts9(�9�I�� ��+<ߓ �.�2'
��Vk�x͍�\�-$A5���➀\�dl��iBC�F�S����!�ƶe�vL@��
^@�AI@��K�Uuu�t�i0��k�&��Ԫ�H_i"��y������Y�i̔�5���gL�~�7l�(�i��L�3kc/,�jn����Bn�~�c� �	�T(x�����r�Q�B�0$n�y��|3˹�
�y��A�#�h�R��$���k�F%|���U��K����$���O���	�9{�h�#�&��$�sr�ғ�O�T*��7      �   X   x�3���tuv����4�4202�54�50�tt����	rt�I����Ipq�9�@�bU�,��������������� =>s      �   �   x���A!�5��` ⶁ1�bڤ����!�����e�ӗ�{�U�	�z�>�^A���6�²辣���?n�Յ	�gx���W�T$3q�#f���a ��ĥ��w�u����,�Is,إ7"miE\wZ���[b     