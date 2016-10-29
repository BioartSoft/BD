-- phpMyAdmin SQL Dump
-- version 4.6.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-10-2016 a las 04:43:12
-- Versión del servidor: 5.6.21
-- Versión de PHP: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `proyecto_bioartsoft_v2`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Actualizar_Existencia_compra` (IN `_cantidad` INT, IN `_id_producto` INT)  NO SQL
BEGIN

UPDATE tbl_productos
	SET cantidad = cantidad - _cantidad
WHERE
	id_producto = _id_producto;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Actualizar_Existencia_venta` (IN `_cantidad` INT, IN `_id_producto` INT)  NO SQL
BEGIN

UPDATE tbl_productos
	SET cantidad = cantidad + _cantidad
WHERE
	id_producto = _id_producto;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Actualizar_Exitencia_Bajas` (IN `_cantidad` INT, IN `_id_producto` INT)  NO SQL
BEGIN

UPDATE tbl_productos
	SET cantidad = cantidad + _cantidad
WHERE
	id_producto = _id_producto;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Actualizar_Fecha_Limite` (IN `_id_venta` INT, IN `_dias` INT)  NO SQL
UPDATE tbl_ventas SET fecha_limite_credito = DATE_ADD(fecha_limite_credito, INTERVAL _dias DAY) WHERE id_ventas = _id_venta$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_anularAbonoCreditos` (IN `_id` INT, IN `_estado` INT)  NO SQL
UPDATE tbl_abono_ventas SET estado_abono =(CASE WHEN estado_abono = 1 THEN 0 ELSE 1 END) WHERE idabono = _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_anularAbonoPrestamos` (IN `_id` INT, IN `_estado` INT)  NO SQL
UPDATE tbl_abono_prestamo pre SET pre.estado_abono = _estado WHERE pre.idTbl_Abono_Prestamo = _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_AnularBaja` (IN `_codigo` INT, IN `_estado` INT)  NO SQL
UPDATE tbl_bajas SET estado = _estado WHERE id_bajas = _Codigo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_AnularCompra` (IN `_codigo` INT, IN `_estado` INT)  NO SQL
UPDATE tbl_compras SET estado = _estado WHERE id_compras = _Codigo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_AnularPago` (IN `_id` INT, IN `_estado` INT)  NO SQL
UPDATE tbl_pagoempleados SET estado = _estado WHERE id_pago = _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_AnularPrestamo` (IN `_id` INT, IN `_estado` INT)  NO SQL
UPDATE tbl_prestamos pres SET pres.estado_prestamo = (CASE WHEN pres.estado_prestamo = 1 THEN 3 ELSE 1 END) WHERE pres.id_prestamos = _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Anular_Venta` (IN `_codigo` INT, IN `_estado` INT)  NO SQL
UPDATE tbl_ventas SET estado = _estado WHERE id_ventas = _Codigo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_AsociarPagoaLiquidacion` (IN `_id_persona` INT)  NO SQL
SELECT pagos.total_pago FROM tbl_pagoempleados_has_tbl_configuracion pagos JOIN tbl_pagoempleados p ON pagos.Tbl_PagoEmpleados_idpago = p.id_pago WHERE pagos.Tbl_Configuracion_idTbl_Configuracion = 1 AND P.Tbl_Persona_id_persona = _id_persona
ORDER BY pagos.Tbl_PagoEmpleados_idpago DESC LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_AsociarPrimaLiquidacion` (IN `_id_persona` INT)  NO SQL
SELECT pagos.total_pago FROM tbl_pagoempleados_has_tbl_configuracion pagos JOIN tbl_pagoempleados p ON pagos.Tbl_PagoEmpleados_idpago = p.id_pago WHERE pagos.Tbl_Configuracion_idTbl_Configuracion = 3 AND P.Tbl_Persona_id_persona = _id_persona
ORDER BY pagos.Tbl_PagoEmpleados_idpago DESC LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_borrar_proveedor` (IN `_id_proveedor` VARCHAR(50))  NO SQL
DELETE FROM tbl_proveedor WHERE Tbl_Persona_id_persona = _id_proveedor$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Buscar_Usuario` (IN `_nombre_usuario` VARCHAR(50))  NO SQL
SELECT p.nombres, 
       p.apellidos,
       p.id_persona, 
       u.id_usuarios, 
       u.clave, 
       u.estado, 
       u.nombre_usuario, 
       u.Tbl_rol_id_rol AS rol, 
       r.id_rol, 
       r.nombre_rol FROM tbl_persona p JOIN tbl_usuarios u ON p.id_persona = u.id_usuarios
JOIN tbl_rol r ON u.Tbl_rol_id_rol = r.id_rol WHERE u.nombre_usuario = _nombre_usuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Cambiar_Estado` (IN `_id` INT)  NO SQL
UPDATE tbl_productos SET estado = (CASE WHEN estado = 1 THEN 0 ELSE 1 END) WHERE id_producto = _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Cambiar_Estado_Cliente` (IN `_id` VARCHAR(50))  NO SQL
UPDATE tbl_persona SET estado = (CASE WHEN estado = 1 THEN 0 ELSE 1 END)
WHERE id_persona = _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Cambiar_Estado_Credito` (IN `_id_venta` INT, IN `_estado` INT)  NO SQL
UPDATE tbl_ventas SET estado_credito = (CASE WHEN estado_credito = 1 THEN 2 ELSE 1 END) WHERE id_ventas = _id_venta$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Cambiar_Estado_Credito2` (IN `_id_venta` INT, IN `_estado` INT)  NO SQL
UPDATE tbl_ventas SET estado_credito = _estado WHERE id_ventas = _id_venta$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Cambiar_estado_Proveedor` (IN `_id` VARCHAR(50))  NO SQL
UPDATE tbl_persona SET estado = (CASE WHEN estado = 1 THEN 0 ELSE 1 END) WHERE id_persona = _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Cambiar_estado_Usuario` (IN `_id` VARCHAR(50))  NO SQL
UPDATE tbl_usuarios SET estado=(CASE WHEN estado=1 THEN 0 ELSE 1 END) WHERE id_usuarios =_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Compras_Dia` ()  NO SQL
SELECT
	SUM(valor_total) AS compras_dia
FROM
	tbl_compras
WHERE
	DATE_FORMAT(fecha_compra, "%Y-%m-%d") = DATE_FORMAT(NOW(), "%Y-%m-%d") AND estado = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Compras_Mes` ()  NO SQL
SELECT
	SUM(valor_total) AS total
FROM
	tbl_compras t
WHERE DATE_FORMAT(t.fecha_compra,"%Y-%m-%d") BETWEEN DATE_FORMAT(NOW(), "%Y-%m-01") AND LAST_DAY(NOW()) AND t.estado = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ConsultarUsuario` (IN `_id_persona` VARCHAR(50))  NO SQL
SELECT u.nombre_usuario, 
       u.id_usuarios,
       p.email,
       p.id_persona
       
        FROM tbl_usuarios u JOIN tbl_persona p ON u.id_usuarios = p.id_persona WHERE id_persona = _id_persona$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Consultar_Configuracion` ()  NO SQL
SELECT Porcentaje_Maximo_Dcto, Valor_Subtotal_Minimo, 	Porcentaje_Minimo_Dcto, Valor_Subtotal_Maximo FROM tbl_configuracion_ventas$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Consultar_Emails` (IN `_id_persona` VARCHAR(50), IN `_correo` VARCHAR(50))  NO SQL
SELECT count(id_persona) AS email FROM tbl_persona WHERE email = _correo AND id_persona <> _id_persona AND email <> ''$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Consultar_Email_Proveedor` (IN `_correo` VARCHAR(50), IN `_id_persona` VARCHAR(50))  NO SQL
SELECT email FROM tbl_persona WHERE email = _correo AND id_persona <> _id_persona$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Consultar_Nombres_Categorias` ()  NO SQL
SELECT LOWER(nombre) AS nombre FROM tbl_categoria$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Consultar_Nombre_Productos` ()  NO SQL
SELECT LOWER(nombre_producto) AS nombre FROM tbl_productos$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Consultar_Personas` ()  NO SQL
SELECT * FROM tbl_persona$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Consultar_Proveedor_Juridico` (IN `_id_proveedor` VARCHAR(50))  NO SQL
SELECT  Tbl_Persona_id_persona FROM tbl_proveedor WHERE Tbl_Persona_id_persona =_id_proveedor$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Consultar_Total_Abono` (IN `_id_venta` INT, IN `_valor_Abono` DOUBLE)  NO SQL
SELECT total_venta - (fn_total_abonos(_id_venta) + _valor_abono) AS total  FROM tbl_ventas WHERE id_ventas = _id_venta$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Consultar_Usuarios` ()  NO SQL
SELECT nombre_usuario
FROM tbl_usuarios$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_DetalleBaja` (IN `__Tbl_Bajas_idbajas` INT, IN `_Tbl_Productos_id_productos` INT, IN `_Cantidad` INT)  NO SQL
BEGIN
INSERT INTO tbl_productos_has_tbl_bajas (Tbl_Bajas_idbajas, Tbl_Productos_id_productos, Cantidad) VALUES (__Tbl_Bajas_idbajas,_Tbl_Productos_id_productos,_Cantidad);
UPDATE tbl_productos SET cantidad = Cantidad - _Cantidad where 	id_producto = _Tbl_Productos_id_productos;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_DetallePago` (IN `_id_persona` VARCHAR(50))  NO SQL
SELECT
pp.nombres,
t.Tbl_nombre_tipo_persona,
p.Tbl_Persona_id_persona,
c.tipo_pago, 
c.tiempo_pago, 
c.porcentaje_comision, 
c.valor_base,
p.id_pago,
DATE_FORMAT(p.fecha_pago, '%Y-%m-%d') AS fecha_pago,
p.valorVentas,
p.valorComision,
p.cantidad_Dias,
p.valor_dia,
p.estado,
conpa.total_pago
FROM tbl_pagoempleados p JOIN tbl_pagoempleados_has_tbl_configuracion d ON p.id_pago = d.Tbl_PagoEmpleados_idpago
JOIN tbl_configuracion c ON d.Tbl_Configuracion_idTbl_Configuracion = c.idTbl_Configuracion
JOIN tbl_persona pp ON p.Tbl_Persona_id_persona = pp.id_persona
JOIN tbl_tipopersona t ON pp.Tbl_TipoPersona_idTbl_TipoPersona = t.idTbl_tipo_persona
JOIN tbl_pagoempleados_has_tbl_configuracion conpa ON p.id_pago = conpa.Tbl_PagoEmpleados_idpago
WHERE p.Tbl_Persona_id_persona = _id_persona ORDER by p.fecha_pago DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_DetallesBajas` (IN `_id_Baja` INT)  NO SQL
SELECT Tbl_Bajas_idbajas, Tbl_Productos_id_productos, Cantidad FROM tbl_productos_has_tbl_bajas WHERE Tbl_Bajas_idbajas = _id_baja$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_DetallesCompra` (IN `_id_compra` INT)  NO SQL
SELECT cp.id_detalle,
	   cp.cantidad,
       cp.valor_compra,
	   p.cantidad AS cantidad_producto, 
       p.id_producto,
       p.nombre_producto,
       p.precio_unitario,
       (cp.valor_compra * cp.cantidad) AS total FROM
      tbl_compras_has_tbl_productos AS cp JOIn tbl_productos AS p ON p.id_producto = cp.Tbl_Productos_id_productos WHERE Tbl_Compras_idcompras = _id_compra$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Detallesproducto` (IN `_id_producto` INT)  NO SQL
SELECT id_producto, nombre_producto, precio_unitario, precio_detal, precio_por_mayor FROM tbl_productos WHERE id_producto = _id_producto$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Detalles_Bajas` (IN `_id_baja` INT)  NO SQL
SELECT b.id_bajas, 
       b.fecha_salida,
       b.estado,
       b.tipo_baja,
       db.cantidad
FROM tbl_bajas b JOIN tbl_productos_has_tbl_bajas db ON db.Tbl_Bajas_idbajas = b.id_bajas
WHERE b.id_bajas = _id_baja$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Detalles_Venta` (IN `_id` INT)  NO SQL
SELECT
          	dv.id_detalle_venta,
          	dv.cantidad,
			dv.precio_venta,
          	p.id_producto,
          	p.nombre_producto,
          	p.precio_unitario,
            p.precio_por_mayor,
            p.precio_detal,
          	(dv.precio_venta * dv.cantidad) AS total
          FROM
          	tbl_productos_has_tbl_ventas AS dv
          JOIN tbl_productos AS p ON p.id_producto = dv.Tbl_Productos_id_productos
          WHERE dv.Tbl_Ventas_id_ventas = _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Existe_Usuario` (IN `_nombre` VARCHAR(50), IN `_correo` VARCHAR(50))  NO SQL
SELECT p.id_persona,
       p.email,
       u.id_usuarios, 
       u.nombre_usuario,
       u.clave,
       r.id_rol, 
       r.nombre_rol 
FROM tbl_persona p JOIN tbl_usuarios u ON p.id_persona = u.id_usuarios
JOIN tbl_rol r ON u.Tbl_rol_id_rol = r.id_rol 
WHERE u.nombre_usuario = _nombre AND p.email = _correo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_getDetalleCreditosV` (IN `_id_per` VARCHAR(50))  NO SQL
SELECT
		p.id_persona,
		v.id_ventas,
        v.fecha_venta,
        v.fecha_limite_credito,
        v.total_venta,
        v.estado, 
        v.estado_credito,
		fn_total_abonos(v.id_ventas) AS total_abonado
FROM tbl_ventas v  JOIN tbl_persona p 
ON p.id_persona = v.Tbl_persona_idpersona_cliente
WHERE p.id_persona = _id_per and v.tipo_de_pago = '1' and v.estado = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_getDetallePrestamos` (IN `_id_per` VARCHAR(50))  NO SQL
SELECT
pe.id_persona,
CONCAT(pe.nombres, ' ', pe.apellidos) AS empleado,
p.id_prestamos,
p.fecha_prestamo,
p.fecha_limite,
p.valor_prestamo,
p.descripcion,
p.estado_prestamo, 
(SELECT sum(tbp.valor) from tbl_abono_prestamo tbp WHERE tbp.Tbl_Prestamos_idprestamos = p.id_prestamos) as Total
FROM tbl_prestamos P JOIN tbl_persona pe ON
pe.id_persona = p.Tbl_Persona_id_persona
WHERE pe.id_persona = _id_per$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_getNombreCliente` (IN `_idCliente` VARCHAR(50))  NO SQL
SELECT id_persona, CONCAT(nombres, ' ', apellidos) AS cliente FROM tbl_persona WHERE id_persona = _idCliente$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GuardarPersona` (IN `_id_persona` VARCHAR(50), IN `_telefono` VARCHAR(30), IN `_nombres` VARCHAR(30), IN `_email` VARCHAR(45), IN `_direccion` VARCHAR(45), IN `_apellidos` VARCHAR(30), IN `_genero` VARCHAR(20), IN `_tipo_documento` VARCHAR(40), IN `_id_tipo_persona` INT, IN `_celular` VARCHAR(12), IN `_fecha_contrato` DATE, IN `_fecha_terminacion` DATE)  NO SQL
INSERT INTO tbl_persona(id_persona, telefono, nombres, email,	direccion, apellidos, genero, tipo_documento, Tbl_TipoPersona_idTbl_TipoPersona,celular, fecha_Contrato, fecha_Terminacion_Contrato) VALUES (_id_persona, _telefono, _nombres, _email, _direccion, _apellidos, _genero, _tipo_documento, _id_tipo_persona, _celular, _fecha_contrato, DATE_ADD(_fecha_terminacion, INTERVAL 12 MONTH))$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_guardarUsuario` (IN `_id_usuario` VARCHAR(50), IN `_clave` VARCHAR(200), IN `_nombre_usuario` VARCHAR(30), IN `_id_rol` INT)  NO SQL
INSERT INTO Tbl_Usuarios(id_usuarios, clave, nombre_usuario, Tbl_rol_id_rol) VALUES(_id_usuario, _clave, _nombre_usuario, _id_rol)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_IdEmpleado` (IN `_id` VARCHAR(50))  NO SQL
SELECT id_persona FROM tbl_persona WHERE id_persona = _id AND Tbl_TipoPersona_idTbl_TipoPersona IN (1,2)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_InfoCompra` (IN `_codigo` INT)  NO SQL
SELECT c.id_compras,
	   c.fecha_compra,
       c.valor_total AS total,
       CONCAT(p.nombres, ' ', p.apellidos) AS proveedor,
       CONCAT(e.nombres, ' ', e.apellidos) AS empleado FROM tbl_compras c JOIN tbl_persona p ON p.id_persona = c.Tbl_Persona_id_persona_proveedor 
JOIN tbl_persona e ON c.Tbl_Persona_id_persona_empleado = e.id_persona WHERE id_compras = _codigo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Informe_Bajas` ()  NO SQL
SELECT pro.nombre_producto,
       p.Tbl_Bajas_idbajas,
       b.fecha_salida,
       b.tipo_baja,
       b.estado,
       b.id_bajas,
       p.Tbl_Productos_id_productos,
       p.Cantidad,
       pro.Tbl_Categoria_idcategoria,
      c.nombre FROM tbl_productos pro JOIN tbl_productos_has_tbl_bajas p ON 
pro.id_producto = p.Tbl_Productos_id_productos JOIN
tbl_categoria c ON
pro.Tbl_Categoria_idcategoria = c.id_categoria 
JOIN
tbl_bajas b ON b.id_bajas = p.Tbl_Bajas_idbajas WHERE b.estado = 1 ORDER BY b.fecha_salida DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Informe_Bajas_Por_fecha` (IN `_fecha_inicial` TIMESTAMP, IN `_fecha_final` TIMESTAMP)  NO SQL
BEGIN
SET lc_time_names = 'es_VE';

SELECT 
       p.id_producto,
       p.nombre_producto,
       c.nombre,
       b.fecha_salida,
       DATE_FORMAT(b.fecha_salida, '%M') AS fecha,
       b.tipo_baja,
       db.cantidad
FROM tbl_productos p JOIN tbl_categoria c ON c.id_categoria = p.Tbl_Categoria_idcategoria JOIN
tbl_productos_has_tbl_bajas db ON p.id_producto = db.Tbl_Productos_id_productos JOIN tbl_bajas b ON b.id_bajas = db.Tbl_Bajas_idbajas where DATE_FORMAT(b.fecha_salida, '%Y-%m-%d') BETWEEN _fecha_inicial and _fecha_final AND b.estado = 1 ORDER BY b.fecha_salida desc;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Informe_Compras` (IN `_fecha_inicial` TIMESTAMP, IN `_fecha_final` TIMESTAMP)  NO SQL
BEGIN

SET lc_time_names = 'es_CO';

select c.id_compras, 
	   c.fecha_compra, 
       DATE_FORMAT(c.fecha_compra, '%M') AS mes,
       c.valor_total, 
       c.estado, 
       c.Tbl_Persona_id_persona_proveedor, 
       c.Tbl_Persona_id_persona_empleado,
       CONCAT (p.nombres, ' ', p.apellidos) AS proveedor
       from tbl_compras c JOIN tbl_persona p ON c.Tbl_Persona_id_persona_proveedor = p.id_persona
where DATE_FORMAT(fecha_compra, '%Y-%m-%d') BETWEEN _fecha_inicial and _fecha_final AND c.estado = 1 ORDER BY c.id_compras desc;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Informe_Pagos` ()  NO SQL
SELECT DISTINCT p.id_persona, 
	   	        CONCAT(p.nombres, ' ', p.apellidos) AS empleado,
       			p.estado, 
       			t.Tbl_nombre_tipo_persona,
                pe.fecha_pago,
                pe.cantidad_dias,
                pe.valor_dia,
                pe.valorComision,
                dp.total_pago,
                cp.tipo_pago
FROM tbl_persona p JOIN tbl_tipopersona t ON p.Tbl_TipoPersona_idTbl_TipoPersona = t.idTbl_tipo_persona
JOIN tbl_pagoempleados pe ON pe.Tbl_Persona_id_persona = p.id_persona
JOIN tbl_pagoempleados_has_tbl_configuracion dp ON dp.Tbl_PagoEmpleados_idpago = pe.id_pago JOIN tbl_configuracion cp ON cp.idTbl_Configuracion = dp.Tbl_Configuracion_idTbl_Configuracion WHERE pe.estado = 1 ORDER BY pe.fecha_pago DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Informe_Pagos2` (IN `_id_persona` VARCHAR(50))  NO SQL
SELECT DISTINCT p.id_persona, 
	   	        CONCAT(p.nombres, ' ', p.apellidos) AS empleado,
       			p.estado, 
       			t.Tbl_nombre_tipo_persona,
                pe.fecha_pago,
                pe.cantidad_dias,
                pe.valor_dia,
                pe.valorComision,
                dp.total_pago,
                cp.tipo_pago
FROM tbl_persona p JOIN tbl_tipopersona t ON p.Tbl_TipoPersona_idTbl_TipoPersona = t.idTbl_tipo_persona
JOIN tbl_pagoempleados pe ON pe.Tbl_Persona_id_persona = p.id_persona
JOIN tbl_pagoempleados_has_tbl_configuracion dp ON dp.Tbl_PagoEmpleados_idpago = pe.id_pago JOIN tbl_configuracion cp ON cp.idTbl_Configuracion = dp.Tbl_Configuracion_idTbl_Configuracion WHERE p.id_persona = _id_persona AND pe.estado = 1 ORDER BY pe.fecha_pago DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Informe_Prestamos` ()  NO SQL
SELECT DISTINCT p.id_persona, 
                p.nombres, 
                p.apellidos, 
                tp.Tbl_nombre_tipo_persona, 
                pre.estado_prestamo,
                pre.valor_prestamo,
                pre.descripcion,
                pre.fecha_limite,
                pre.fecha_prestamo
                FROM tbl_persona p JOIN tbl_prestamos pre on p.id_persona = pre.Tbl_Persona_id_persona
JOIN tbl_tipopersona tp ON tp.idTbl_tipo_persona = p.Tbl_TipoPersona_idTbl_TipoPersona
WHERE pre.estado_prestamo = 1 OR pre.estado_prestamo = 3$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Informe_Prestamos_Por_Empleado` (IN `_id_persona` VARCHAR(50))  NO SQL
SELECT DISTINCT p.id_persona,
       CONCAT(p.nombres, ' ', p.apellidos) AS empleado,
       tp.Tbl_nombre_tipo_persona,
       pres.fecha_prestamo,
       pres.valor_prestamo,
       pres.descripcion,
       pres.fecha_limite
from tbl_persona p JOIN tbl_tipopersona tp ON tp.idTbl_tipo_persona = p.Tbl_TipoPersona_idTbl_TipoPersona JOIN tbl_prestamos pres ON pres.Tbl_Persona_id_persona = p.id_persona 
WHERE p.id_persona = _id_persona AND pres.estado_prestamo IN (1, 3) ORDER BY pres.fecha_prestamo DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Informe_Ventas` (IN `_fecha_inicial` TIMESTAMP, IN `_fecha_final` TIMESTAMP)  NO SQL
BEGIN
SET lc_time_names = 'es_CO';

select v.id_ventas, 
	   v.fecha_venta, 
       DATE_FORMAT(v.fecha_venta, '%M') AS mes,
       v.total_venta, 
       v.subtotal_venta,
       v.descuento,
       v.estado, 
       v.Tbl_persona_idpersona_cliente, 
       v.Tbl_Persona_idpersona_empleado,
       v.tipo_de_pago,
       CONCAT (p.nombres, ' ', p.apellidos) AS cliente
       from tbl_ventas v JOIN tbl_persona p ON v.Tbl_persona_idpersona_cliente = p.id_persona
where DATE_FORMAT(fecha_venta, '%Y-%m-%d') BETWEEN _fecha_inicial and _fecha_final AND v.estado = 1 ORDER BY v.fecha_venta DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Info_Baja` (IN `_id_baja` INT)  NO SQL
SELECT b.id_persona_empleado,
	   b.id_bajas,
       CONCAT(per.nombres, ' ', per.apellidos) AS empleado,
       per.estado
FROM tbl_persona per JOIN tbl_compras c ON c.Tbl_Persona_id_persona_empleado = per.id_persona JOIN tbl_compras_has_tbl_productos dc ON dc.Tbl_Compras_idcompras = c.id_compras JOIN tbl_productos p ON p.id_producto = dc.Tbl_Productos_id_productos JOIN tbl_productos_has_tbl_bajas db ON db.Tbl_Productos_id_productos = p.id_producto JOIN tbl_bajas b ON b.id_bajas = db.Tbl_Bajas_idbajas WHERE b.id_bajas = _id_baja$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Info_Producto` (IN `_id_producto` INT)  NO SQL
SELECT id_producto, nombre_producto FROM tbl_productos WHERE id_producto = _id_producto$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Info_Venta` (IN `_id_venta` INT)  NO SQL
SELECT p.Tbl_TipoPersona_idTbl_TipoPersona,
       v.id_ventas,
	   v.fecha_venta, 
       v.total_venta as total, 
       v.subtotal_venta,
       v.descuento, 
       v.Tbl_Persona_idpersona_empleado,
       CONCAT(e.nombres, ' ', e.apellidos) AS empleado,
       CONCAT(p.nombres, ' ', p.apellidos) as cliente FROM tbl_ventas v JOIN tbl_persona p ON p.id_persona = v.Tbl_persona_idpersona_cliente
JOIN tbl_persona e ON v.Tbl_Persona_idpersona_empleado = e.id_persona WHERE id_ventas = _id_venta$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_InsertarBaja` (IN `_tipo_baja` VARCHAR(50), IN `_id_persona` VARCHAR(50))  NO SQL
INSERT INTO tbl_bajas(tipo_baja, id_persona_empleado) VALUES(_tipo_baja, _id_persona)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_insertarCompra` (IN `_valor_total` DOUBLE, IN `_proveedor` VARCHAR(50), IN `_id_empleado` VARCHAR(50))  NO SQL
INSERT INTO tbl_compras (valor_total, Tbl_Persona_id_persona_proveedor, 	Tbl_Persona_id_persona_empleado) VALUES (_valor_total, _proveedor, _id_empleado)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_insertarDetalleCompra` (IN `_id_producto` INT, IN `_id_compra` INT, IN `_cantidad` INT, IN `_precio_compra` DOUBLE)  NO SQL
BEGIN
INSERT INTO tbl_compras_has_tbl_productos (Tbl_Compras_idcompras, Tbl_Productos_id_productos, cantidad, valor_compra) VALUES (_id_compra, _id_producto, _cantidad, _precio_compra);
UPDATE tbl_productos SET cantidad = cantidad + _cantidad WHERE id_producto = _id_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_InsertarDetalleVenta` (IN `_codigoProducto` INT, IN `_codigoVenta` INT, IN `_cantidad` INT, IN `_precio_producto` DOUBLE)  NO SQL
BEGIN
	INSERT INTO tbl_productos_has_tbl_ventas 
	(
		Tbl_Ventas_id_ventas,
		Tbl_Productos_id_productos,
		cantidad,
		precio_venta
	)
VALUES
	(
		_codigoVenta,
		_codigoProducto,
		_cantidad,
		_precio_producto
	);

UPDATE tbl_productos SET cantidad = cantidad - _cantidad WHERE id_producto = _codigoProducto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_InsertarVenta` (IN `_valorSubtotal` DOUBLE, IN `_descuento` DOUBLE, IN `_valorTotal` DOUBLE, IN `_codigoCliente` VARCHAR(50), IN `_tipoPago` INT, IN `_empleado` VARCHAR(50))  NO SQL
INSERT INTO tbl_ventas (subtotal_venta, descuento,
                        total_venta,
                        Tbl_persona_idpersona_cliente,
                        tipo_de_pago, 
                        Tbl_Persona_idpersona_empleado)
VALUES (_valorSubtotal, _descuento, (_valorTotal - _descuento), _codigoCliente, _tipoPago, _empleado)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Insertar_Abono_CreditoVen` (IN `_valor_Abonar_CreditoV` DOUBLE, IN `_id_ventas` INT)  NO SQL
INSERT INTO tbl_abono_ventas
(valor_abono, Tbl_Ventas_idventas, saldo_abono)      
VALUES(
	_valor_Abonar_CreditoV,
	_id_ventas, 
	(CASE 
		WHEN 
			fn_total_abonos(_id_ventas) IS NULL THEN 0 
		ELSE 
			fn_total_abonos(_id_ventas) END
		) + _valor_Abonar_CreditoV
	)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Insertar_Proveedor` (IN `_nit` VARCHAR(50), IN `_empresa` VARCHAR(50), IN `_telefono` VARCHAR(50), IN `_id_persona` VARCHAR(50))  NO SQL
INSERT INTO tbl_proveedor(nit,	empresa, telefono_empresa, Tbl_Persona_id_persona) VALUES(_nit, _empresa, _telefono, __id_persona)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Insertar_Proveedor_Juridico` (IN `_nit` VARCHAR(50), IN `_empresa` VARCHAR(50), IN `_telefono` VARCHAR(50), IN `_id_persona` VARCHAR(50))  NO SQL
INSERT INTO tbl_proveedor(nit,	empresa, telefono_empresa, Tbl_Persona_id_persona) VALUES(_nit, _empresa, _telefono, _id_persona)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Insertar_venta_Credito` (IN `_valorSubtotal` DOUBLE, IN `_descuento` DOUBLE, IN `_valorTotal` DOUBLE, IN `_codigoCliente` VARCHAR(50), IN `_tipoPago` INT, IN `_empleado` VARCHAR(50), IN `_fecha_limite` INT)  NO SQL
INSERT INTO tbl_ventas (subtotal_venta, descuento,
                        total_venta,
                        Tbl_persona_idpersona_cliente,
                        tipo_de_pago, 
                        Tbl_Persona_idpersona_empleado, 
                        fecha_limite_credito)
VALUES (_valorSubtotal, _descuento, (_valorTotal - _descuento), _codigoCliente, _tipoPago, _empleado, DATE_ADD(NOW(),INTERVAL _fecha_limite DAY))$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_listarAbonos` (IN `id_prestamo` INT)  NO SQL
SELECT p.idTbl_Abono_Prestamo, 
       DATE_FORMAT(p.fecha_abono, '%Y-%m-%d') AS fecha_abono, 
       p.estado_abono, 
       p.Tbl_Prestamos_idprestamos, 
       p.valor FROM tbl_abono_prestamo p WHERE p.Tbl_Prestamos_idprestamos = id_prestamo ORDER BY p.fecha_abono DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_listarAbonosCreditosV` (IN `id_VentaCredito` INT)  NO SQL
SELECT DATE_FORMAT(v.fechaAbono, '%Y-%m-%d') AS fechaAbono, 
       v.valor_abono, 
       v.saldo_abono,
       v.estado_abono,
       v.idabono
     FROM tbl_abono_ventas v 
WHERE v.Tbl_Ventas_idventas = id_VentaCredito 
ORDER BY v.fechaAbono DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ListarBajas` ()  NO SQL
SELECT pro.nombre_producto,
       p.Tbl_Bajas_idbajas,
       date_format(b.fecha_salida, '%Y-%m-%d') AS fecha_salida,
       b.tipo_baja,
       b.estado,
       b.id_bajas,
       p.Tbl_Productos_id_productos,
       p.Cantidad,
       pro.Tbl_Categoria_idcategoria,
      c.nombre FROM tbl_productos pro JOIN tbl_productos_has_tbl_bajas p ON 
pro.id_producto = p.Tbl_Productos_id_productos JOIN
tbl_categoria c ON
pro.Tbl_Categoria_idcategoria = c.id_categoria 
JOIN
tbl_bajas b ON b.id_bajas = p.Tbl_Bajas_idbajas ORDER BY b.fecha_salida DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_listarCateg` (IN `_id_categoria` VARCHAR(50))  NO SQL
SELECT * FROM tbl_categoria WHERE id_categoria = _id_categoria$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ListarClientes` ()  NO SQL
SELECT
	id_persona AS documento,
	CONCAT(nombres, ' ', apellidos) AS nombres,
	telefono,
	direccion,
    estado,
    Tbl_TipoPersona_idTbl_TipoPersona, 
		Tbl_TipoPersona_idTbl_TipoPersona AS tipo, 
	(CASE WHEN Tbl_TipoPersona_idTbl_TipoPersona = 5 THEN 'Frecuente' ELSE 'No frecuente' END) AS tipo_cliente  
FROM
	tbl_persona
WHERE Tbl_TipoPersona_idTbl_TipoPersona  IN (5, 6)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ListarClientesVenta` ()  BEGIN
	
SELECT
	id_persona AS documento,
	CONCAT(nombres, ' ', apellidos) AS nombres,
	telefono,
	direccion,
    estado,
    Tbl_TipoPersona_idTbl_TipoPersona, 
		Tbl_TipoPersona_idTbl_TipoPersona AS tipo, 
	(CASE WHEN Tbl_TipoPersona_idTbl_TipoPersona = 5 THEN 'Frecuente' ELSE 'No frecuente' END) AS tipo_cliente,
	(SELECT COUNT(v.id_ventas) FROM tbl_ventas v WHERE v.Tbl_persona_idpersona_cliente = id_persona AND tipo_de_pago = 1 AND v.estado = 1 AND (v.estado_credito = 1 OR v.estado_credito = 2)) AS total_creditos
FROM
	tbl_persona
WHERE Tbl_TipoPersona_idTbl_TipoPersona  IN (5, 6);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_listarCompras` ()  NO SQL
SELECT c.id_compras, 
       date_format(c.fecha_compra, '%Y-%m-%d') AS fecha_compra, 
       c.valor_total, 
       c.estado, 
       p.id_persona,
       CONCAT(p.nombres, ' ', p.apellidos) AS proveedor
FROM tbl_compras c JOIN tbl_persona p 
ON p.id_persona = c.Tbl_Persona_id_persona_proveedor 
ORDER BY id_compras DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ListarEmpleadoFijo` ()  NO SQL
SELECT DISTINCT p.id_persona, 
	   			p.nombres,
       			p.apellidos,
       			p.estado, 
       			t.Tbl_nombre_tipo_persona, 
       			e.fecha_pago, 
       			e.valorVentas,
       			e.valorComision,
                e.cantidad_Dias, 
                e.valor_dia 
                FROM tbl_persona p 
                JOIN tbl_pagoempleados e 
                ON p.id_persona = e.Tbl_Persona_id_persona 
                JOIN tbl_tipopersona t 
                ON p.Tbl_TipoPersona_idTbl_TipoPersona =                               t.idTbl_tipo_persona 
                WHERE e.estado = 1 AND                                   t.Tbl_nombre_tipo_persona = 'Empleado-fijo'
                GROUP BY p.id_persona$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ListarPagosEmpleados` ()  NO SQL
SELECT DISTINCT p.id_persona, 
	   	        p.nombres, 
       			p.apellidos,
       			p.estado, 
       			t.Tbl_nombre_tipo_persona, 
       			e.fecha_pago, 
       		    e.valorVentas,
       			e.valorComision,
                e.cantidad_Dias, 
                e.valor_dia 
                FROM tbl_persona p 
                JOIN tbl_pagoempleados e 
                ON p.id_persona = e.Tbl_Persona_id_persona 
                JOIN tbl_tipopersona t 
                ON p.Tbl_TipoPersona_idTbl_TipoPersona = 			                   t.idTbl_tipo_persona 
                WHERE e.estado = 1
                GROUP BY p.id_persona$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ListarProducto` ()  NO SQL
SELECT
	id_producto AS codigo,
	nombre_producto AS nombre,
	precio_detal AS precio,
	precio_por_mayor AS precioPorMayor
FROM
	tbl_productos$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ListarProveedor` ()  NO SQL
SELECT
          	p.id_persona,
          	p.nombres,
          	p.apellidos,
          	p.celular,
          	p.email,
            p.telefono,
            p.direccion,
            p.genero,
            p.estado,
          	tp.Tbl_nombre_tipo_persona
          FROM
          	tbl_persona p
          JOIN tbl_tipopersona tp ON tp.idTbl_tipo_persona = p.Tbl_TipoPersona_idTbl_TipoPersona
          WHERE p.Tbl_TipoPersona_idTbl_TipoPersona IN (3, 4)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_listarProveedorJuridico` ()  NO SQL
SELECT p.id_persona, 
       CONCAT(p.nombres, ' ', p.apellidos) As nombres,
       p.estado,
       tp.Tbl_nombre_tipo_persona AS Tipo_proveedor FROM tbl_persona p JOIN tbl_tipopersona tp ON p.Tbl_TipoPersona_idTbl_TipoPersona = tp.idTbl_tipo_persona  WHERE Tbl_TipoPersona_idTbl_TipoPersona IN (3,4)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ListarUsuario` (IN `_id_usuario` VARCHAR(50))  NO SQL
SELECT
          r.nombre_rol,
          	p.nombres,
          	u.estado,
          	u.Tbl_rol_id_rol AS rol
          FROM
          	tbl_usuarios u
          JOIN tbl_rol r ON r.id_rol = u.Tbl_rol_id_rol
          JOIN tbl_persona p ON p.id_persona = u.id_usuarios
          WHERE u.id_usuarios = _id_usuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_listarVentasEmpleID` (IN `_id_persona` VARCHAR(50), IN `_fecha_inicial` DATE, IN `_fecha_final` DATE)  NO SQL
SELECT SUM(ven.total_venta) as Total FROM tbl_ventas ven WHERE ven.Tbl_Persona_idpersona_empleado = _id_persona AND DATE_FORMAT(ven.fecha_venta, '%Y-%m-%d') BETWEEN _fecha_inicial AND
_fecha_final$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Listar_categoria` ()  NO SQL
SELECT id_categoria, nombre FROM tbl_categoria order by id_categoria desc$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Listar_Cliente_Creditos_Ventas` ()  NO SQL
SELECT DISTINCT
           	p.id_persona,
          	p.nombres,
          	p.apellidos,
          	p.celular,
            p.telefono,
            p.genero,
            p.estado,
          	tp.Tbl_nombre_tipo_persona,
		    v.tipo_de_pago						
          FROM tbl_persona p 
          JOIN tbl_tipopersona tp 
          ON tp.idTbl_tipo_persona = Tbl_TipoPersona_idTbl_TipoPersona
		  JOIN tbl_ventas v 
          ON v.Tbl_persona_idpersona_cliente = p.id_persona 
		  WHERE p.Tbl_TipoPersona_idTbl_TipoPersona IN(5, 6) 
          AND V.tipo_de_pago = 1 AND v.estado = 1
          GROUP BY p.id_persona$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Listar_configuracion` ()  NO SQL
SELECT tipo_pago, tiempo_pago, Valor_dia, porcentaje_comision, valor_base, idTbl_Configuracion FROM Tbl_configuracion WHERE idTbl_Configuracion = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Listar_Configuracion2` ()  NO SQL
SELECT tipo_pago, tiempo_pago, porcentaje_comision, valor_base, idTbl_Configuracion FROM Tbl_configuracion WHERE idTbl_Configuracion = 2$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Listar_Configuracion3` ()  NO SQL
SELECT tipo_pago, tiempo_pago, porcentaje_comision, valor_base, idTbl_Configuracion FROM Tbl_configuracion WHERE idTbl_Configuracion = 3$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Listar_Configuracion_Pagos` ()  NO SQL
SELECT idTbl_Configuracion, tipo_pago FROM Tbl_configuracion$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Listar_Configuracion_Venta` ()  NO SQL
SELECT Valor_Subtotal_Maximo, 
       Porcentaje_Maximo_Dcto, 	
       Valor_Subtotal_Minimo,	
       Porcentaje_Minimo_Dcto
FROM tbl_configuracion_ventas$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Listar_Creditos` ()  NO SQL
SELECT
	COUNT(tipo_de_pago) AS creditos
FROM
	tbl_ventas t
WHERE t.estado_credito = 1 AND t.tipo_de_pago = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Listar_emple` ()  NO SQL
SELECT
            u.id_usuarios,
          	u.nombre_usuario,
          	r.nombre_rol,
          	p.id_persona,
          	p.nombres,
          	p.apellidos,
          	p.celular,
          	p.fecha_Contrato,
          	p.email,
            p.telefono,
            p.direccion,
            p.genero,
            u.estado,
          	tp.Tbl_nombre_tipo_persona
          FROM
          	tbl_rol r JOIN tbl_usuarios u ON r.id_rol = u.Tbl_rol_id_rol
            JOIN tbl_persona p ON p.id_persona = u.id_usuarios
            JOIN tbl_tipopersona tp ON tp.idTbl_tipo_persona = p.Tbl_TipoPersona_idTbl_TipoPersona WHERE p.Tbl_TipoPersona_idTbl_TipoPersona = '1'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Listar_informe` ()  NO SQL
select p.id_producto,
	   p.nombre_producto ,
	   p.precio_detal ,
	   p.precio_por_mayor,
       c.nombre,
       p.cantidad,
       p.estado,
       p.precio_unitario
    from tbl_productos p join tbl_categoria c on p.Tbl_Categoria_idcategoria = c.id_categoria WHERE p.estado = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Listar_PersClienteID` (IN `_id_cliente` VARCHAR(50))  NO SQL
SELECT
           	p.id_persona,
          	p.nombres,
          	p.apellidos,
          	p.celular,
          	p.fecha_Contrato,
          	p.email,
            p.telefono,
            p.direccion,
            p.genero,
            p.estado,
          	tp.Tbl_nombre_tipo_persona,
            tp.idTbl_tipo_persona
			FROM tbl_persona p 
            JOIN  tbl_tipopersona tp ON      							 			tp.idTbl_tipo_persona = p.Tbl_TipoPersona_idTbl_TipoPersona
						WHERE p.id_persona = _id_cliente$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Listar_PersEmpleado_FijoID` (IN `_id_usuario` VARCHAR(50))  NO SQL
SELECT
            u.id_usuarios,
          	u.nombre_usuario,
          	r.nombre_rol,
          	p.id_persona,
          	p.nombres,
          	p.apellidos,
          	p.celular,
          	p.fecha_Contrato,
            p.fecha_Terminacion_Contrato,
          	p.email,
            p.telefono,
            p.direccion,
            p.genero,
            p.Tbl_TipoPersona_idTbl_TipoPersona,
            u.estado,
          	tp.Tbl_nombre_tipo_persona,
            tp.idTbl_tipo_persona,
						u.Tbl_rol_id_rol AS rol
         FROM
          	tbl_rol r JOIN tbl_usuarios u ON r.id_rol = u.Tbl_rol_id_rol
            JOIN tbl_persona p ON p.id_persona = u.id_usuarios
            JOIN tbl_tipopersona tp ON tp.idTbl_tipo_persona = p.Tbl_TipoPersona_idTbl_TipoPersona WHERE u.id_usuarios = _id_usuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_listar_Personas_Clientes` ()  NO SQL
SELECT
           
          	p.id_persona,
          	p.nombres,
          	p.apellidos,
          	p.celular,
          	p.fecha_Contrato,
          	p.email,
            p.telefono,
            p.direccion,
            p.genero,
            p.estado,
          	tp.Tbl_nombre_tipo_persona,
            tp.idTbl_tipo_persona
						FROM
          	tbl_persona p JOIN  tbl_tipopersona tp ON tp.idTbl_tipo_persona = p.Tbl_TipoPersona_idTbl_TipoPersona
			WHERE p.Tbl_TipoPersona_idTbl_TipoPersona IN(5, 6)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_listar_Personas_emp_fijo` ()  NO SQL
SELECT
            u.id_usuarios,
          	u.nombre_usuario,
          	r.nombre_rol,
            r.id_rol,
          	p.id_persona,
          	p.nombres,
          	p.apellidos,
          	p.celular,
          	p.fecha_Contrato,
            p.fecha_Terminacion_Contrato,
          	p.email,
            p.telefono,
            p.direccion,
            p.genero,
            p.Tbl_TipoPersona_idTbl_TipoPersona,
            u.estado,
          	tp.Tbl_nombre_tipo_persona,
            (SELECT max(DATE_FORMAT(pag.fecha_pago, '%Y-%m-%d')) from tbl_pagoempleados pag JOIN 			tbl_pagoempleados_has_tbl_configuracion confi ON pag.id_pago 			= confi.Tbl_PagoEmpleados_idpago WHERE 									pag.Tbl_Persona_id_persona = p.id_persona AND 							confi.Tbl_Configuracion_idTbl_Configuracion = 1 and pag.estado = 1 ) as 					Fechaulti,
            (SELECT max(pag.fecha_pago) from tbl_pagoempleados pag JOIN 			tbl_pagoempleados_has_tbl_configuracion confi ON pag.id_pago 			= confi.Tbl_PagoEmpleados_idpago WHERE 									pag.Tbl_Persona_id_persona = p.id_persona AND 							confi.Tbl_Configuracion_idTbl_Configuracion = 3 and pag.estado = 1) as 					FechaTer
						
          FROM
          	tbl_rol r JOIN tbl_usuarios u ON r.id_rol = u.Tbl_rol_id_rol
            JOIN tbl_persona p ON p.id_persona = u.id_usuarios
            JOIN tbl_tipopersona tp ON tp.idTbl_tipo_persona = p.Tbl_TipoPersona_idTbl_TipoPersona
            WHERE p.Tbl_TipoPersona_idTbl_TipoPersona IN (1,2)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Listar_Prestamos` ()  NO SQL
SELECT DISTINCT p.id_persona, p.nombres, p.apellidos, tp.Tbl_nombre_tipo_persona, pre.estado_prestamo FROM tbl_persona p JOIN tbl_prestamos pre on p.id_persona = pre.Tbl_Persona_id_persona
JOIN tbl_tipopersona tp ON tp.idTbl_tipo_persona = p.Tbl_TipoPersona_idTbl_TipoPersona WHERE pre.estado_prestamo = 1 OR pre.estado_prestamo = 3$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Listar_Prestamos_Pendientes` ()  NO SQL
SELECT
	COUNT(*) AS prestamos
FROM
	tbl_prestamos t
WHERE t.estado_prestamo = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_listar_producto` ()  NO SQL
SELECT  p.id_producto,  
        p.nombre_producto, 
        p.estado,
        p.precio_detal, 
        p.precio_por_mayor, 
        p.precio_unitario,    
        p.Tbl_Categoria_idcategoria, 
        p.talla,
        p.tamano,
        c.nombre, 
        p.cantidad,
        p.stock_minimo FROM tbl_productos p join tbl_categoria c on p.Tbl_Categoria_idcategoria = c.id_categoria order by p.id_producto DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_listar_proveedor` ()  NO SQL
SELECT
           	p.id_persona,
          	p.nombres,
          	p.apellidos,
          	p.celular,
          	p.email,
            p.telefono,
            p.direccion,
            p.genero,
            p.estado,
          	tp.Tbl_nombre_tipo_persona
          FROM
          	tbl_persona p
          JOIN tbl_tipopersona tp ON tp.idTbl_tipo_persona = 					p.Tbl_TipoPersona_idTbl_TipoPersona
          WHERE p.Tbl_TipoPersona_idTbl_TipoPersona IN (3, 4)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Listar_Proveedores_ID` (IN `_id_proveedor` VARCHAR(50))  NO SQL
SELECT			
			p.id_persona,
          	p.nombres,
          	p.apellidos,
          	p.celular,
          	p.email,
            p.telefono,
            p.direccion,
            p.genero,
            p.estado,
            p.Tbl_TipoPersona_idTbl_TipoPersona,
           	tp.Tbl_nombre_tipo_persona
            FROM
          	tbl_persona p 
          JOIN tbl_tipopersona tp ON tp.idTbl_tipo_persona = p.Tbl_TipoPersona_idTbl_TipoPersona
          WHERE  p.id_persona  = _id_proveedor AND p.Tbl_TipoPersona_idTbl_TipoPersona IN (3,4)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Listar_Proveedor_Jur_ID` (IN `_id_proveedor` VARCHAR(50))  NO SQL
SELECT			
			p.id_persona,
          	p.nombres,
          	p.apellidos,
          	p.celular,
          	p.email,
            p.telefono,
            p.direccion,
            p.genero,
            p.estado,
           	tp.Tbl_nombre_tipo_persona,
            prov.nit,
			prov.empresa,
			prov.telefono_empresa
			FROM
          	tbl_proveedor prov
            JOIN tbl_persona p ON prov.Tbl_Persona_id_persona = p.id_persona
          JOIN tbl_tipopersona tp ON tp.idTbl_tipo_persona = p.Tbl_TipoPersona_idTbl_TipoPersona
          WHERE  p.id_persona  = _id_proveedor AND p.Tbl_TipoPersona_idTbl_TipoPersona = 4$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_listar_rol` ()  NO SQL
SELECT id_rol, nombre_rol FROM tbl_rol WHERE id_rol <> 3$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Listar_Roles` ()  NO SQL
SELECT * FROM tbl_rol WHERE id_rol <> 3$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Listar_stockMinimo` ()  NO SQL
SELECT 	  p.id_producto, 
          p.nombre_producto, 
          p.estado,p.precio_detal, 
          p.precio_por_mayor, 
          p.precio_unitario, 
          p.Tbl_Categoria_idcategoria, 
          p.talla, 
          p.tamano, 
          c.nombre, 
          p.cantidad, 
          P.stock_minimo FROM tbl_productos p join tbl_categoria c on p.Tbl_Categoria_idcategoria = c.id_categoria WHERE p.stock_minimo >= p.cantidad AND p.estado = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Listar_TipoPersona_Proveedores` ()  NO SQL
SELECT idTbl_tipo_persona, 	Tbl_nombre_tipo_persona FROM tbl_tipopersona WHERE idTbl_tipo_persona IN (3, 4)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Listar_TipoPersona_Vendedor` ()  NO SQL
SELECT idTbl_tipo_persona, Tbl_nombre_tipo_persona FROM tbl_tipopersona 	WHERE idTbl_tipo_persona IN (5, 6)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Listar_tipo_persona` ()  NO SQL
SELECT idTbl_tipo_persona, Tbl_nombre_tipo_persona FROM tbl_tipopersona$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Listar_tipo_persona_Clientes` ()  NO SQL
SELECT idTbl_tipo_persona, Tbl_nombre_tipo_persona FROM tbl_tipopersona
WHERE idTbl_tipo_persona IN(5,6)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Listar_tipo_persona_Empleados` ()  NO SQL
SELECT idTbl_tipo_persona, 	Tbl_nombre_tipo_persona FROM tbl_tipopersona WHERE idTbl_tipo_persona IN (1, 2)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Listar_tipo_persona_proveedores` ()  NO SQL
SELECT idTbl_tipo_persona, 	Tbl_nombre_tipo_persona FROM tbl_tipopersona WHERE idTbl_tipo_persona IN (3, 4)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_listar_usuarios` ()  NO SQL
SELECT id_usuarios, nombre_usuario, clave AS Clave, estado, Tbl_rol_id_rol FROM tbl_usuarios$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Listar_Ventas` ()  NO SQL
SELECT v.id_ventas, 
       v.total_venta, 
       date_format(v.fecha_venta, '%Y-%m-%d') AS fecha_venta, 
       v.Tbl_persona_idpersona_cliente, 
       v.tipo_de_pago, 
       v.estado, 
       CONCAT(p.nombres, ' ', p.apellidos) AS cliente  
FROM tbl_ventas v JOIN tbl_persona p ON p.id_persona = v.Tbl_persona_idpersona_cliente WHERE p.Tbl_TipoPersona_idTbl_TipoPersona IN (5,6)  ORDER BY id_ventas DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Menu` ()  NO SQL
SELECT
        *
FROM tbl_menu$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ModificarConfiguracionVentas` (IN `_ValSubtotal_Minimo` DOUBLE, IN `_Porcentaje_MinimoD` INT, IN `_ValSubtotal_Maximo` DOUBLE, IN `_Porcentaje_Maximo` INT)  NO SQL
UPDATE tbl_configuracion_ventas SET Valor_Subtotal_Minimo = _ValSubtotal_Minimo, Porcentaje_Minimo_Dcto	= _Porcentaje_MinimoD, Valor_Subtotal_Maximo = _ValSubtotal_Maximo, Porcentaje_Maximo_Dcto = _Porcentaje_Maximo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ModificarEstadoPrestamoAbonoCero` (IN `_id_prest` INT)  NO SQL
UPDATE tbl_prestamos pre SET pre.estado_prestamo = 0 WHERE pre.id_prestamos = _id_prest$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_modificarFechadeliquidacion` (IN `id_per` VARCHAR(50), IN `fecha` DATE)  NO SQL
UPDATE tbl_persona p SET p.fecha_Terminacion_Contrato = fecha WHERE p.id_persona = id_per$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_modificarPrestamo` (IN `fecha_limite` DATE, IN `valor_prestamo` INT, IN `id_prestamos` INT)  NO SQL
UPDATE tbl_prestamos pre SET pre.fecha_limite = fecha_limite, pre.valor_prestamo = valor_prestamo WHERE pre.id_prestamos = id_prestamos$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Modificar_categoria` (IN `_id_categoria` INT, IN `_nombre` VARCHAR(50))  NO SQL
UPDATE tbl_categoria SET nombre = _nombre WHERE id_categoria = _id_categoria$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_modificar_clave` (IN `_id_usuario` VARCHAR(50), IN `_clave` VARCHAR(200))  NO SQL
UPDATE tbl_usuarios SET clave = _clave WHERE id_usuarios = _id_usuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Modificar_Configuracion` (IN `_tiempo_pago` VARCHAR(50), IN `_valor_dia` DOUBLE, IN `_porcentage` DOUBLE, IN `_valor_base` DOUBLE)  NO SQL
UPDATE tbl_configuracion SET tiempo_pago = _tiempo_pago, Valor_dia = _valor_dia, porcentaje_comision = _porcentage, valor_base = _valor_base WHERE idTbl_Configuracion = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_modificar_persona` (IN `_nombres` VARCHAR(50), IN `_apellidos` VARCHAR(50), IN `_celular` VARCHAR(20), IN `_email` VARCHAR(50), IN `_telefono` VARCHAR(50), IN `_direccion` VARCHAR(50), IN `_fecha_contrato` DATE, IN `_genero` VARCHAR(30), IN `_tipoPersona` INT(11), IN `_fecha_terminacion` DATE, IN `_id_persona` VARCHAR(50))  NO SQL
UPDATE tbl_persona SET nombres = _nombres, apellidos= _apellidos, celular= _celular, email= _email, telefono= _telefono, direccion= _direccion, fecha_Contrato = _fecha_contrato, genero = _genero, Tbl_TipoPersona_idTbl_TipoPersona = _tipoPersona, fecha_Terminacion_Contrato = DATE_ADD(_fecha_terminacion, INTERVAL 12 MONTH) WHERE id_persona = _id_persona$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Modificar_producto` (IN `_id_producto` INT, IN `_nombre_producto` VARCHAR(50), IN `_precio_detal` DOUBLE, IN `_precio_por_mayor` DOUBLE, IN `_precio_unitario` DOUBLE, IN `_Tbl_Categoria_idcategoria` INT, IN `_talla` VARCHAR(50), IN `_tamano` VARCHAR(50), IN `_stock` INT)  NO SQL
UPDATE tbl_productos SET nombre_producto = _nombre_producto, precio_detal = _precio_detal, precio_por_mayor = _precio_por_mayor, precio_unitario = _precio_unitario, Tbl_Categoria_idcategoria = _Tbl_Categoria_idcategoria, talla = _talla, tamano = _tamano, stock_minimo = _stock WHERE id_producto = _id_producto$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Modificar_Proveedor` (IN `_nit` VARCHAR(50), IN `_empresa` VARCHAR(50), IN `_telefono` VARCHAR(50), IN `_id_persona` VARCHAR(50))  NO SQL
UPDATE tbl_proveedor SET nit = _nit, empresa = _empresa,  telefono_empresa = _telefono WHERE Tbl_Persona_id_persona = _id_persona$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Modificar_Usuarios` (IN `_nombre_usuario` VARCHAR(50), IN `_id_rol` INT, IN `_id_usuario` VARCHAR(50))  NO SQL
UPDATE tbl_usuarios SET nombre_usuario = _nombre_usuario, Tbl_rol_id_rol = _id_rol WHERE id_usuarios = _id_usuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Modificar_Valor_Base` (IN `_valor_base` DOUBLE)  NO SQL
UPDATE tbl_configuracion SET valor_base = _valor_base WHERE idTbl_Configuracion BETWEEN 1 AND 3$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_NombreEmpleado` (IN `_id_persona` VARCHAR(50))  NO SQL
SELECT CONCAT(nombres, ' ', apellidos) AS empleado FROM tbl_persona WHERE id_persona = _id_persona$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Notificacion_Creditos` ()  NO SQL
SELECT *, NOW() AS fecha_actual FROM tbl_ventas WHERE DATE_SUB(fecha_limite_credito,INTERVAL 5 DAY) <= CURDATE() AND tipo_de_pago = 1 AND estado_credito = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Notificacion_Stock_Minimo` ()  NO SQL
SELECT * FROM tbl_productos WHERE cantidad <= stock_minimo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Paginas` (IN `_id_rol` INT, IN `_url` VARCHAR(50))  NO SQL
SELECT p.url 
FROM tbl_pagina_rol t JOIN tbl_paginas p ON p.codigo_paginas = t.Tbl_Paginas_codigo_paginas
WHERE Tbl_rol_id_rol = _id_rol AND p.url = _url AND t.estado = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Pdf_DetallesCompra` (IN `_id_compra` INT)  NO SQL
SELECT cp.id_detalle,
	   cp.cantidad,
       p.id_producto,
       p.nombre_producto,
       p.precio_unitario,
       (p.precio_unitario * cp.cantidad) AS total, 
       c.fecha_compra,
       c.valor_total,
       c.id_compras,
       CONCAT(pro.nombres, ' ', pro.apellidos) AS proveedor
FROM tbl_compras_has_tbl_productos AS cp JOIn tbl_productos AS p ON p.id_producto = cp.Tbl_Productos_id_productos JOIN tbl_compras c ON c.id_compras = cp.Tbl_Compras_idcompras JOIN tbl_persona pro ON pro.id_persona = c.Tbl_Persona_id_persona_proveedor
WHERE Tbl_Compras_idcompras = _id_compra GROUP BY pro.id_persona$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Pdf_Detalles_Abono` (IN `_id` VARCHAR(50))  NO SQL
SELECT p.id_persona, 
       CONCAT(p.nombres, ' ', p.apellidos) AS cliente, 
       (SELECT valor_abono FROM tbl_abono_ventas abv WHERE v.id_ventas = abv.Tbl_Ventas_idventas and abv.idabono = MAX(a.idabono)) as valor_abono,
       MAX(a.idabono) AS idabono,
       DATE_FORMAT(a.fechaAbono, '%Y/%m/%d') AS fechaAbono,
       a.saldo_abono, 
       DATE_FORMAT(v.fecha_limite_credito, '%Y/%m/%d') AS                        fecha_limite_credito,
       (v.total_venta - sum(a.valor_abono)) AS pendiente,
       fn_total_abonos(v.id_ventas) AS total_abonado, 
       v.total_venta
FROM tbl_persona p 
JOIN tbl_ventas v ON v.Tbl_persona_idpersona_cliente = p.id_persona 
JOIN tbl_abono_ventas a ON a.Tbl_Ventas_idventas = v.id_ventas 
WHERE p.id_persona = _id AND a.estado_abono = 1 AND v.estado_credito = 1 AND v.estado = 1 GROUP BY p.id_persona$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Pdf_Detalles_Abono_Prestamo` (IN `_id` VARCHAR(50))  NO SQL
SELECT
	p.id_persona,
	CONCAT(p.nombres, ' ', p.apellidos) AS empleado,
	pre.fecha_prestamo,
	pre.valor_prestamo,
	pre.estado_prestamo,
	pre.id_prestamos,
	pre.fecha_limite,
	pre.descripcion,
	ap.idTbl_Abono_Prestamo,
	DATE_FORMAT(ap.fecha_abono, '%Y/%m/%d') AS fecha_abono,
	(
		SELECT
			valor
		FROM
			tbl_abono_prestamo abp
		WHERE
			pre.id_prestamos and abp.idTbl_Abono_Prestamo = MAX(ap.idTbl_Abono_Prestamo)
	) AS valor,
	SUM(ap.valor) AS abonado,
	(
		pre.valor_prestamo - SUM(ap.valor)
	) AS pendiente,
	ap.estado_abono
FROM
	tbl_persona p
JOIN tbl_prestamos pre ON pre.Tbl_Persona_id_persona = p.id_persona
JOIN tbl_abono_prestamo ap ON ap.Tbl_Prestamos_idprestamos = pre.id_prestamos
WHERE
	p.id_persona = _id
AND ap.estado_abono = 1
AND pre.estado_prestamo = 1
GROUP BY
	p.id_persona$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Pdf_Detalles_Venta` (IN `_id_venta` INT)  NO SQL
SELECT
          	dv.id_detalle_venta,
          	dv.cantidad,
          	p.id_producto,
          	p.nombre_producto,
          	p.precio_unitario,
            p.precio_por_mayor,
            p.precio_detal,
          	(p.precio_detal * dv.cantidad) AS total,
            CONCAT(per.nombres, ' ', per.apellidos) AS cliente,
            v.id_ventas,
            v.fecha_venta,
            v.descuento,
            v.subtotal_venta,
            v.tipo_de_pago,
            v.total_venta
FROM tbl_persona per JOIN tbl_ventas v ON v.Tbl_persona_idpersona_cliente = per.id_persona JOIN tbl_productos_has_tbl_ventas dv ON dv.Tbl_Ventas_id_ventas = v.id_ventas JOIN tbl_productos p ON p.id_producto = dv.Tbl_Productos_id_productos WHERE dv.Tbl_Ventas_id_ventas = _id_venta GROUP BY per.id_persona$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_RegistrarAbonoPrestamo` (IN `valor` DOUBLE, IN `estado` INT, IN `Tbl_Prestamos_idprestamos` INT)  NO SQL
INSERT INTO tbl_abono_prestamo VALUES(null, null, valor, estado, Tbl_Prestamos_idprestamos)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_RegistrarDetallePagoConfiguracion` (IN `id_pago` INT, IN `idTbl_Configuracion` INT, IN `valor_total` INT)  NO SQL
INSERT INTO tbl_pagoempleados_has_tbl_configuracion VALUES(id_pago,idTbl_Configuracion,valor_total)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_RegistrarDetallePagoConfiTemp` (IN `id_pago` INT, IN `idTbl_Configuracion` INT, IN `valorTotal` DOUBLE)  NO SQL
INSERT INTO tbl_pagoempleados_has_tbl_configuracion VALUES(id_pago,idTbl_Configuracion,valorTotal)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_registrarPagoEmpleadoFijo` (IN `num_docu` VARCHAR(50), IN `valor_ventas` DOUBLE, IN `valor_comision` DOUBLE, IN `cantidad_dias` INT, IN `valor_prima` INT, IN `valor_cesantias` INT, IN `valor_vacaciones` INT, IN `estado` INT)  NO SQL
INSERT INTO tbl_pagoempleados VALUES (null,null, num_docu, valor_ventas ,valor_comision, null,null,valor_prima, valor_cesantias, valor_vacaciones, estado)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_registrarPagoEmpleadoTemporal` (IN `num_docu` VARCHAR(50), IN `canti_dias` INT, IN `valor_dia` DOUBLE, IN `estado` INT)  NO SQL
INSERT INTO tbl_pagoempleados VALUES (null,null, num_docu, null, null, canti_dias, valor_dia, null, null, null, estado)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_RegistrarPrestamo` (IN `estado_prestamo` INT, IN `valor_prestamo` DOUBLE, IN `fecha_prestamo` DATE, IN `fecha_limite` DATE, IN `descripcion` VARCHAR(100), IN `Tbl_Persona_id_persona` VARCHAR(50))  NO SQL
INSERT INTO tbl_prestamos VALUES (null,estado_prestamo, valor_prestamo, fecha_prestamo, fecha_limite, descripcion, Tbl_Persona_id_persona)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Registrar_Categoria` (IN `_nombre` VARCHAR(50))  NO SQL
INSERT INTO tbl_categoria (nombre) VALUES(_nombre)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Registrar_producto` (IN `_id_producto` INT, IN `_nombre_producto` VARCHAR(50), IN `_precio_detal` DOUBLE, IN `_precio_por_mayor` DOUBLE, IN `_precio_unitario` DOUBLE, IN `_Tbl_Categoria_idcategoria` INT, IN `_talla` VARCHAR(20), IN `_tamano` VARCHAR(20), IN `_stock` INT)  NO SQL
INSERT INTO tbl_productos(id_producto,nombre_producto,precio_detal,precio_por_mayor,precio_unitario,Tbl_Categoria_idcategoria,talla,tamano, stock_minimo) VALUES (_id_producto,_nombre_producto,_precio_detal,_precio_por_mayor,_precio_unitario,_Tbl_Categoria_idcategoria,_talla,_tamano, _stock)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Registrar_Proveedor` (IN `_nit` VARCHAR(50), IN `_empresa` VARCHAR(50), IN `_telefono` VARCHAR(50), IN `_id_persona` VARCHAR(50))  NO SQL
INSERT INTO tbl_proveedor(nit, empresa, telefono_empresa, Tbl_Persona_id_persona) VALUES(_nit, _empresa, _telefono, _id_persona)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Reporte_Creditos` ()  NO SQL
SELECT DISTINCT
           	p.id_persona,
          	CONCAT(p.nombres, ' ', p.apellidos) AS cliente,
          	tp.Tbl_nombre_tipo_persona,
		    v.tipo_de_pago,
            v.total_venta,
            v.fecha_limite_credito
          FROM tbl_persona p 
          JOIN tbl_tipopersona tp 
          ON tp.idTbl_tipo_persona = Tbl_TipoPersona_idTbl_TipoPersona
		  JOIN tbl_ventas v 
          ON v.Tbl_persona_idpersona_cliente = p.id_persona 
          JOIN tbl_abono_ventas av
		  WHERE p.Tbl_TipoPersona_idTbl_TipoPersona IN(5, 6) 
          AND V.tipo_de_pago = 1 AND v.estado = 1 AND av.estado_abono           = 1 AND v.estado_credito = 1 GROUP BY p.id_persona$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Reporte_Ganancias` (IN `_fecha_inicial` DATE, IN `_fecha_final` DATE)  NO SQL
SELECT ((SUM(precio_venta * cantidad)) - (SUM(cantidad * precio_unitario_actual)) - SUM(v.descuento)) AS ganancias 
FROM tbl_productos_has_tbl_ventas dv 
JOIN tbl_ventas v ON v.id_ventas = dv.Tbl_Ventas_id_ventas  
WHERE DATE_FORMAT(v.fecha_venta, '%Y-%m-%d') 
BETWEEN DATE_FORMAT(_fecha_inicial, '%Y-%m-%d') 
AND DATE_FORMAT(_fecha_final, '%Y-%m-%d') 
AND v.estado = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_sumarValorAbonoPrestamo` (IN `_id_Prestamo` INT)  NO SQL
SELECT sum(valor) as Total from tbl_abono_prestamo WHERE Tbl_Prestamos_idprestamos = _id_Prestamo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Total_Compras_Fecha` (IN `_fecha_inicial` DATE, IN `_fecha_final` DATE)  NO SQL
SELECT SUM(valor_total) AS total, fecha_compra 
FROM tbl_compras 
WHERE DATE_FORMAT(fecha_compra, '%Y-%m-%d') BETWEEN _fecha_inicial and _fecha_final AND estado = 1 ORDER BY fecha_compra DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Total_Ventas_Por_Fecha` (IN `_fecha_inicial` DATE, IN `_fecha_final` DATE)  NO SQL
SELECT (SUM(total_venta) - descuento) AS total, fecha_venta 
FROM tbl_ventas 
WHERE DATE_FORMAT(fecha_venta, '%Y-%m-%d') BETWEEN _fecha_inicial and _fecha_final AND estado = 1 ORDER BY fecha_venta DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_traerAbonosPorPrestamos` (IN `_id_prestamos` INT)  NO SQL
SELECT abono.estado_abono, SUM(abono.valor) as TotalAbono FROM tbl_abono_prestamo abono WHERE abono.Tbl_Prestamos_idprestamos = _id_prestamos AND abono.estado_abono = 0$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_traerinfoCreditos` (IN `_id_venta` INT)  NO SQL
SELECT fecha_limite_credito, id_ventas FROM tbl_ventas WHERE id_ventas = _id_venta$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_traerinfoprestamo` (IN `id_prestamos` INT)  NO SQL
SELECT pre.fecha_limite, pre.valor_prestamo, pre.id_prestamos from tbl_prestamos pre WHERE pre.id_prestamos = id_prestamos$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Traer_idcategoria` (IN `_id_categoria` INT)  NO SQL
SELECT id_categoria, nombre FROM tbl_categoria WHERE id_categoria = _id_categoria$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Traer_idproducto` (IN `_id_producto` INT)  NO SQL
SELECT id_producto, nombre_producto, precio_detal, precio_por_mayor, precio_unitario, Tbl_Categoria_idcategoria, talla, tamano, stock_minimo FROM tbl_productos WHERE id_producto = _id_producto$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_UltimaBaja` ()  NO SQL
SELECT MAX(id_bajas) ultimo_id FROM tbl_bajas$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_UltimaCompra` ()  NO SQL
SELECT MAX(id_compras) AS ultima FROM tbl_compras$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_UltimaVenta` ()  NO SQL
SELECT MAX(id_ventas) AS ultima FROM tbl_ventas$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Ultima_Persona` ()  NO SQL
SELECT MAX(id_persona) AS ultimo FROM tbl_persona$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Ultimo_usuario` ()  NO SQL
SELECT MAX(id_usuarios) as ultimo FROM tbl_usuarios$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Usuario_Por_Codigo` (IN `_id_usuario` VARCHAR(50))  NO SQL
SELECT nombre_usuario, clave, estado, Tbl_rol_id_rol FROM tbl_usuarios WHERE id_usuarios = _id_usuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ValAbonoAnularPrestamo` (IN `_id_prestamo` INT)  NO SQL
SELECT abono.valor from tbl_abono_prestamo abono WHERE abono.Tbl_Prestamos_idprestamos = _id_prestamo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Validar_Cantidad_Producto` (IN `_id_producto` INT)  NO SQL
SELECT cantidad FROM tbl_productos WHERE id_producto = _id_producto$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Validar_Codigo` (IN `_codigo` INT)  NO SQL
SELECT id_producto FROM tbl_productos WHERE id_producto = _codigo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Validar_Email` (IN `_correo` VARCHAR(50), IN `_id` VARCHAR(50))  NO SQL
SELECT count(id_persona) total FROM tbl_persona WHERE email = _correo AND id_persona <> _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_validar_email2` (IN `_correo` VARCHAR(50))  NO SQL
SELECT email FROM tbl_persona WHERE email = _correo AND email <> ''$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Validar_Fecha` (IN `_fecha` DATE)  NO SQL
SELECT fecha_compra FROM tbl_compras WHERE DATE_FORMAT(fecha_compra, '%Y%m%d') = _fecha$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Validar_Fecha_Baja` (IN `_fecha` DATE)  NO SQL
SELECT fecha_salida FROM tbl_bajas WHERE DATE_FORMAT(fecha_salida, '%Y%m%d') = _fecha$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Validar_Fecha_Ganancia` (IN `_fecha` DATE)  NO SQL
SELECT DATE_FORMAT(fecha_venta, '%Y-%m-%d') AS fecha_venta FROM tbl_ventas WHERE DATE_FORMAT(fecha_venta, '%Y-%m-%d') = _fecha$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Validar_Fecha_Venta` (IN `_fecha` DATE)  NO SQL
SELECT fecha_venta FROM tbl_ventas WHERE DATE_FORMAT(fecha_venta, '%Y%m%d') = _fecha$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Validar_Id_Persona` (IN `_Id_Persona` VARCHAR(50))  NO SQL
SELECT id_persona FROM tbl_persona WHERE id_persona = _Id_Persona$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Validar_Modificacion_Email` (IN `_id_persona` VARCHAR(50), IN `_correo` VARCHAR(50))  NO SQL
SELECT count(id_persona) total FROM tbl_persona WHERE email = _correo AND id_persona <> _id_persona$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Validar_Modificacion_Nombre_Categoria` (IN `_id` INT, IN `_nombre` VARCHAR(50))  NO SQL
SELECT LOWER(nombre) AS nombre
FROM tbl_categoria WHERE nombre = _nombre AND id_categoria = _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Validar_Modificacion_Nombre_Producto` (IN `_id_producto` INT, IN `_nombre` VARCHAR(50))  NO SQL
SELECT LOWER(nombre_producto) AS nombre
FROM tbl_productos WHERE nombre_producto = _nombre AND id_producto = _id_producto$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Validar_Modificacion_Usuario` (IN `_id_persona` VARCHAR(50), IN `_nombre_usuario` VARCHAR(50))  NO SQL
SELECT nombre_usuario
FROM tbl_usuarios WHERE nombre_usuario = _nombre_usuario AND id_usuarios = _id_persona$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Validar_Mod_Email` (IN `_id` VARCHAR(50))  NO SQL
SELECT email
FROM tbl_persona WHERE id_persona <> _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Validar_Nombres_Categorias` (IN `_id` INT)  NO SQL
SELECT LOWER(nombre) AS nombre
FROM tbl_categoria WHERE id_categoria <> _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Validar_Nombre_Categoria` (IN `_categoria` VARCHAR(50))  NO SQL
SELECT id_categoria, nombre FROM tbl_categoria WHERE nombre = _categoria$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Validar_Nombre_Producto` (IN `_nombre` VARCHAR(50))  NO SQL
SELECT nombre_producto FROM tbl_productos WHERE nombre_producto = _nombre$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Validar_Nombre_Productos` (IN `_id` VARCHAR(50))  NO SQL
SELECT LOWER(nombre_producto) AS nombre
FROM tbl_productos WHERE id_producto <> _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Validar_nombre_Usu` (IN `_Nombre` VARCHAR(50), IN `_id` VARCHAR(50))  NO SQL
SELECT count(id_usuarios) total FROM tbl_usuarios WHERE nombre_usuario = _Nombre AND id_usuarios <> _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Validar_Nombre_Usuario` (IN `_id` VARCHAR(50))  NO SQL
SELECT nombre_usuario
FROM tbl_usuarios WHERE id_usuarios <> _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Validar_Prestamo` (IN `_id_persona` VARCHAR(50))  NO SQL
SELECT Tbl_Persona_id_persona, estado_prestamo, valor_prestamo FROM tbl_prestamos WHERE estado_prestamo = 1 AND Tbl_Persona_id_persona = _id_persona$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Validar_Tipo_Empleado` (IN `_id_persona` VARCHAR(50))  NO SQL
SELECT id_persona FROM tbl_persona WHERE Tbl_TipoPersona_idTbl_TipoPersona = 1 AND id_persona = _id_persona$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Validar_Usuario` (IN `_nombre_usuario` VARCHAR(50))  NO SQL
SELECT nombre_usuario FROM tbl_usuarios WHERE nombre_usuario = _nombre_usuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Validar_Usuario2` (IN `_nombre_usuario` VARCHAR(50))  NO SQL
SELECT nombre_usuario FROM tbl_usuarios WHERE nombre_usuario = _nombre_usuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ValiPrestamo` (IN `id_persona` VARCHAR(50))  NO SQL
SELECT COUNT(pre.estado_prestamo) from tbl_prestamos pre WHERE pre.estado_prestamo = 1 AND pre.Tbl_Persona_id_persona = id_persona$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_valorPrestamoliquidacion` (IN `id_persona` VARCHAR(50))  NO SQL
SELECT SUM(pre.valor_prestamo) as total from tbl_prestamos pre WHERE pre.estado_prestamo = 1 AND pre.Tbl_Persona_id_persona = id_persona$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Ventas_Dia` ()  NO SQL
SELECT
	SUM(total_venta) AS ventas_dia
FROM
	tbl_ventas
WHERE
	DATE_FORMAT(fecha_venta, "%Y-%m-%d") = DATE_FORMAT(NOW(), "%Y-%m-%d") AND estado = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Ventas_Mes` ()  NO SQL
SELECT
	SUM(total_venta) AS total
FROM
	tbl_ventas t
WHERE DATE_FORMAT(t.fecha_venta,"%Y-%m-%d") BETWEEN DATE_FORMAT(NOW(), "%Y-%m-01") AND LAST_DAY(NOW()) AND t.estado = 1$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_total_abonos` (`id_venta` INT) RETURNS DOUBLE NO SQL
BEGIN
		DECLARE total DOUBLE;
		SELECT (CASE WHEN SUM(valor_abono) IS NULL THEN 0 ELSE SUM(valor_abono) END) INTO total FROM tbl_abono_ventas WHERE Tbl_Ventas_idventas = id_venta AND estado_abono = 1;
	RETURN total;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_abono_prestamo`
--

CREATE TABLE `tbl_abono_prestamo` (
  `idTbl_Abono_Prestamo` int(11) NOT NULL,
  `fecha_abono` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `valor` double UNSIGNED NOT NULL,
  `estado_abono` int(11) NOT NULL DEFAULT '1',
  `Tbl_Prestamos_idprestamos` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_abono_prestamo`
--

INSERT INTO `tbl_abono_prestamo` (`idTbl_Abono_Prestamo`, `fecha_abono`, `valor`, `estado_abono`, `Tbl_Prestamos_idprestamos`) VALUES
(1, '2016-10-25 12:44:53', 11000, 1, 1),
(2, '2016-10-25 21:45:13', 5000, 1, 2),
(3, '2016-10-26 12:28:34', 2000, 0, 3),
(4, '2016-10-28 20:35:37', 3000, 1, 3),
(5, '2016-10-28 20:57:03', 1000, 1, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_abono_ventas`
--

CREATE TABLE `tbl_abono_ventas` (
  `idabono` int(11) NOT NULL,
  `fechaAbono` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `valor_abono` double UNSIGNED NOT NULL,
  `Tbl_Ventas_idventas` int(11) NOT NULL,
  `saldo_abono` double UNSIGNED DEFAULT NULL,
  `estado_abono` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_abono_ventas`
--

INSERT INTO `tbl_abono_ventas` (`idabono`, `fechaAbono`, `valor_abono`, `Tbl_Ventas_idventas`, `saldo_abono`, `estado_abono`) VALUES
(1, '2016-10-25 15:31:45', 3000, 1, 3000, 1),
(2, '2016-10-25 22:24:24', 2000, 1, 5000, 1),
(3, '2016-10-26 12:23:33', 2000, 8, 2000, 1),
(4, '2016-10-26 23:16:58', 6000, 1, 11000, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_bajas`
--

CREATE TABLE `tbl_bajas` (
  `id_bajas` int(11) NOT NULL,
  `fecha_salida` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tipo_baja` varchar(15) NOT NULL,
  `id_persona_empleado` varchar(50) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_bajas`
--

INSERT INTO `tbl_bajas` (`id_bajas`, `fecha_salida`, `tipo_baja`, `id_persona_empleado`, `estado`) VALUES
(1, '2016-10-26 22:12:08', 'Robo', '103456784356', 0),
(2, '2016-10-26 22:19:14', 'Averia', '1234567890', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_categoria`
--

CREATE TABLE `tbl_categoria` (
  `id_categoria` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_categoria`
--

INSERT INTO `tbl_categoria` (`id_categoria`, `nombre`) VALUES
(1, 'Ropa'),
(2, 'fumador'),
(3, 'collares');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_compras`
--

CREATE TABLE `tbl_compras` (
  `id_compras` int(11) NOT NULL,
  `fecha_compra` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `valor_total` double UNSIGNED NOT NULL,
  `estado` int(11) NOT NULL DEFAULT '1',
  `Tbl_Persona_id_persona_proveedor` varchar(50) NOT NULL,
  `Tbl_Persona_id_persona_empleado` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_compras`
--

INSERT INTO `tbl_compras` (`id_compras`, `fecha_compra`, `valor_total`, `estado`, `Tbl_Persona_id_persona_proveedor`, `Tbl_Persona_id_persona_empleado`) VALUES
(1, '2016-10-25 15:47:39', 10000, 1, '353453454', '1234567890'),
(2, '2016-10-26 12:08:04', 21000, 1, '353453454', '1234567890'),
(3, '2016-10-26 12:10:02', 15000, 0, '353453454', '1234567890');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_compras_has_tbl_productos`
--

CREATE TABLE `tbl_compras_has_tbl_productos` (
  `Tbl_Compras_idcompras` int(11) NOT NULL,
  `id_detalle` int(11) NOT NULL,
  `cantidad` int(11) UNSIGNED DEFAULT NULL,
  `Tbl_Productos_id_productos` int(11) NOT NULL,
  `valor_compra` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_compras_has_tbl_productos`
--

INSERT INTO `tbl_compras_has_tbl_productos` (`Tbl_Compras_idcompras`, `id_detalle`, `cantidad`, `Tbl_Productos_id_productos`, `valor_compra`) VALUES
(1, 1, 5, 2, 2000),
(2, 2, 6, 3, 3000),
(2, 3, 3, 1, 1000),
(3, 4, 1, 3, 3000),
(3, 5, 1, 5, 10000),
(3, 6, 2, 1, 1000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_configuracion`
--

CREATE TABLE `tbl_configuracion` (
  `idTbl_Configuracion` int(11) NOT NULL,
  `tipo_pago` varchar(30) NOT NULL,
  `tiempo_pago` varchar(11) NOT NULL,
  `Valor_dia` int(11) UNSIGNED NOT NULL,
  `porcentaje_comision` double UNSIGNED NOT NULL,
  `valor_base` double UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_configuracion`
--

INSERT INTO `tbl_configuracion` (`idTbl_Configuracion`, `tipo_pago`, `tiempo_pago`, `Valor_dia`, `porcentaje_comision`, `valor_base`) VALUES
(1, 'Pago Normal', 'Quincenal', 32000, 0.01, 690000),
(2, 'Liquidación', 'Anual', 0, 0, 690000),
(3, 'Prima', 'Semestral', 0, 0, 690000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_configuracion_ventas`
--

CREATE TABLE `tbl_configuracion_ventas` (
  `idConfiguracionVentas` int(11) NOT NULL,
  `Porcentaje_Maximo_Dcto` double UNSIGNED NOT NULL,
  `Valor_Subtotal_Minimo` double UNSIGNED NOT NULL,
  `Porcentaje_Minimo_Dcto` int(11) UNSIGNED NOT NULL,
  `Valor_Subtotal_Maximo` double UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_configuracion_ventas`
--

INSERT INTO `tbl_configuracion_ventas` (`idConfiguracionVentas`, `Porcentaje_Maximo_Dcto`, `Valor_Subtotal_Minimo`, `Porcentaje_Minimo_Dcto`, `Valor_Subtotal_Maximo`) VALUES
(1, 5, 15000, 3, 51000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_menu`
--

CREATE TABLE `tbl_menu` (
  `id_menu` int(11) NOT NULL,
  `url_menu` varchar(45) NOT NULL,
  `texto_menu` varchar(45) NOT NULL,
  `icono_menu` varchar(20) DEFAULT NULL,
  `padre_id` int(11) DEFAULT NULL,
  `orden` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_menu`
--

INSERT INTO `tbl_menu` (`id_menu`, `url_menu`, `texto_menu`, `icono_menu`, `padre_id`, `orden`) VALUES
(1, 'otro/index', 'MENÚ PRINCIPAL', 'th-list', NULL, 1),
(2, '#', 'Administrar Personas', 'users', NULL, 2),
(3, 'Personas/listarTipoPers', 'Registrar Personas', '', 2, 2),
(4, 'Personas/listarPersonasEmpleados', 'Listar Usuarios/Empleados', NULL, 2, 2),
(5, '#', 'Productos', 'cubes', NULL, 3),
(6, 'producto/registrarProductos', 'Registrar Productos', NULL, 5, 1),
(7, 'producto/listarProductos', 'Listar Productos', NULL, 5, 3),
(8, 'producto/RegistrarBajas', 'Registrar Bajas', NULL, 5, 2),
(9, '#', 'Categorías', 'database', NULL, 4),
(10, 'producto/registrarCategoria', 'Registrar Categoría', NULL, 9, 1),
(11, 'producto/listarCategorias', 'Listar Categorías', NULL, 9, 2),
(12, '#', 'Gestión de Entradas', 'shopping-cart', NULL, 5),
(13, 'Compras/registrarCompra', 'Registrar Entradas', NULL, 12, 1),
(14, 'Compras/listarCompras', 'Listar Entradas', NULL, 12, 2),
(15, '#', 'Ventas', 'usd', NULL, 6),
(16, 'Ventas/index', 'Registrar Ventas', NULL, 15, 1),
(17, 'Ventas/listarVentas', 'Listar Ventas', NULL, 15, 2),
(18, '#', 'Abonos Ventas', 'credit-card', NULL, 7),
(19, 'Ventas/registrarAbonos', 'Registrar Abonos', NULL, 18, 1),
(20, 'Ventas/listarVentasCredito', 'Listar Créditos-Abonos', NULL, 15, 3),
(21, '#', 'Pagos Empleados', 'money', NULL, 8),
(22, 'Empleados/registrarPagos', 'Registrar Pagos', NULL, 21, 1),
(23, 'Empleados/listarPagos', 'Listar Pagos', NULL, 21, 2),
(26, 'Empleados/listarLiquidacion', 'Listar Liquidaciones', NULL, 24, 2),
(27, '#', 'Préstamos Empleados', 'credit-card', NULL, 10),
(28, 'Empleados/registrarPrestamo', 'Registrar Préstamos', NULL, 27, 1),
(32, 'Empleados/ListarPrest', 'Listar Préstamos', NULL, 27, 2),
(34, 'Personas/listarProveedores', 'Listar Proveedores', NULL, 2, 3),
(35, 'producto/listarStock', 'Listar Stock Mínimo', NULL, 5, 5),
(36, 'producto/listarBajas', 'Listar Bajas', NULL, 5, 4),
(37, 'Personas/listarPersonasClientes', 'Listar Clientes', NULL, 2, 4),
(38, 'producto/pdfinformeproducto', 'Reporte Productos', NULL, 33, 1),
(39, 'Compras/informeproducto', 'Reporte Entradas', NULL, 12, 3),
(40, 'Ventas/informeVentas', 'Reporte Ventas', NULL, 15, 4),
(41, 'producto/informeBajas', 'Reporte Bajas', NULL, 5, 4),
(42, 'Ventas/informeGanancias', 'Listar Promedio Ganancías', NULL, 15, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_paginas`
--

CREATE TABLE `tbl_paginas` (
  `codigo_paginas` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `url` varchar(45) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_paginas`
--

INSERT INTO `tbl_paginas` (`codigo_paginas`, `nombre`, `url`, `estado`) VALUES
(1, 'persona/listar', 'Personas/listarPersonasEmpleados', 1),
(2, 'personas/registrar', 'Personas/listarTipoPers', 1),
(3, 'index', 'otro/index', 1),
(4, 'Cambiar/estado/usuario', 'Personas/cambiarEstado', 1),
(5, 'Contrasenia', 'Personas/modificarContrasenia', 1),
(6, 'personas/registrar/tipo', 'Personas/registrarPersonas', 1),
(7, 'personas/listar/proveedores', 'Personas/listarProveedores', 1),
(8, 'Personas/CambiarEstado-Proveedor', 'Personas/cambiarEstadoProveedor', 1),
(9, 'producto/registrar', 'producto/registrarProductos', 1),
(10, 'producto/listar', 'producto/listarProductos', 1),
(11, 'producto/estado', 'producto/cambiarEstado', 1),
(12, 'producto/registrarCate', 'producto/registrarCategoria', 1),
(13, 'producto/listarCate', 'producto/listarCategorias', 1),
(14, 'producto/obtener', 'producto/obtenerProductos', 1),
(15, 'producto/obtenerCateg', 'producto/obtenercategoria', 1),
(16, 'producto/modificar', 'producto/modificarProducto', 1),
(17, 'producto/modificarCateg', 'producto/ModificarCategoria', 1),
(18, 'producto/codigoBarras', 'producto/generarCodigo', 1),
(19, 'compras/index', 'Compras/index', 1),
(20, 'compras/registrar', 'Compras/registrarCompra', 1),
(21, 'compras/listar', 'Compras/listarCompras', 1),
(22, 'compras/estado', 'Compras/modificarEstado', 1),
(23, 'compras/detalles', 'Compras/ajaxDetallesCompra', 1),
(24, 'producto/registrarBajas', 'producto/registrarBajas', 1),
(25, 'producto/listarBajas', 'producto/listarBajas', 1),
(26, 'personas/validarId', 'Personas/validacion', 1),
(27, 'producto/listar', 'producto/listarStock', 1),
(28, 'ventas/index', 'Ventas/index', 1),
(29, 'ventas/listar', 'Ventas/listarVentas', 1),
(30, 'ventas/detalles', 'Ventas/ajaxDetallesVenta', 1),
(31, 'ventas/cambiarEstado', 'Ventas/modificarEstado', 1),
(32, 'producto/detalles', 'producto/ajaxDetallesProducto', 1),
(33, 'personas/listarClientes', 'Personas/listarPersonasClientes', 1),
(34, 'personas/estadoClientes', 'Personas/cambiarEstadoCliente', 1),
(35, 'Ventas/validarCantidad', 'Ventas/validacion', 1),
(36, 'personas/validarEmail', 'Personas/validacionEmail', 1),
(37, 'personas/validarusuario', 'Personas/validacionUsuario', 1),
(38, 'Empleados/RegistrarPagos', 'Empleados/registrarPagos', 1),
(39, 'Empleados/RegistrarAbonos', 'Empleados/registrarAbonoPrestamo', 1),
(40, 'Empleados/ListarPrestamos', 'Empleados/ListarPrest', 1),
(41, 'Empleados/RegistrarPrestamos', 'Empleados/registrarPrestamo', 1),
(42, 'Empleados/ListarConfiguraciones', 'Empleados/ListarConfiguraciones', 1),
(43, 'Empleados/Registrarpagoempleado', 'Empleados/registrarPagoEmpleado', 1),
(44, 'Empleados/ListarPagos', 'Empleados/listarPagos', 1),
(45, 'Empleados/detallesPagos', 'Empleados/ajaxDetallePagos', 1),
(46, 'Empleados/DetallesPrestamo', 'Empleados/ajaxDetallePrestamos', 1),
(47, 'Empleados/estado', 'Empleados/modificarestado', 1),
(48, 'Empleados/sumarAbono', 'Empleados/sumarAbono', 1),
(49, 'Empleados/undiadespues', 'Empleados/fechaUnDiaDespues', 1),
(50, 'Empleados/listarprestamos', 'Empleados/ListarPrest', 1),
(51, 'producto/validar', 'producto/validacion', 1),
(52, 'empleados/empleado', 'Empleados/ajaxNombreEmpleado', 1),
(53, 'producto/validacionCantidad', 'producto/validacionCantidad', 1),
(54, 'empleados/comprobante', 'Empleados/comprobante', 1),
(55, 'empleados/detallesAbonos', 'Empleados/ajaxDetalleAbonos', 1),
(56, 'empleados/valorVentas', 'Empleados/valorVentasEmp', 1),
(57, 'ventas/Credito', 'Ventas/listarVentasCredito', 1),
(58, 'ventas/detalleCreditos', 'Ventas/ajaxDetalleCreditosV', 1),
(59, 'ventas/registrarCreditosAbonos', 'Ventas/registrarAbonoCreditoVen', 1),
(60, 'ventas/detallesAbonos', 'Ventas/ajaxDetalleAbonosCreditosV', 1),
(61, 'Ventas/nombreCliente', 'Ventas/ajaxNombreCliente', 1),
(62, 'empleados/prestamos', 'Empleados/validacionPrestamo', 1),
(63, 'productos/nombreCategoria', 'producto/validacionCategoria', 1),
(64, 'ventas/estadoCredito', 'Ventas/modificarestadoC', 1),
(65, 'empleados/valiprestamos', 'Empleados/validarcantiPres', 1),
(66, 'empleados/infoprestamos', 'Empleados/infoprestamos', 1),
(67, 'empleados/prestamopendiente', 'Empleados/valorprestamopendiente', 1),
(68, 'empleados/modificarestadoabonos', 'Empleados/modificarestadoAbonos', 1),
(69, 'personas/pdfProveedores', 'Personas/generarpdfproveedor', 1),
(70, 'producto/pdf2', 'producto/pdf2', 1),
(71, 'producto/pdfStock', 'producto/informestock', 1),
(72, 'producto/pdfCodigo', 'producto/generarPdfCodigo', 1),
(73, 'producto/geberarpdfCodigo', 'producto/generarPdfCodigoProductos', 1),
(74, 'producto/imagencodigo', 'producto/guardarImagenCodigo', 1),
(75, 'producto/informe', 'producto/informeproducto', 1),
(76, 'producto/informeProducto', 'producto/informefproducto', 1),
(77, 'existencias/informeBajas', 'Existencias/informbajas', 1),
(78, 'personas/pdfClientes', 'Personas/generarpdfClientes', 1),
(79, 'personas/pdfEmpleados', 'Personas/generarpdfEmpleados', 1),
(80, 'Compras/pdfCompras', 'Compras/informeproducto', 1),
(81, 'Compras/pdf', 'Compras/pdfCompras', 1),
(82, 'Ventas/informe', 'Ventas/informeVentas', 1),
(83, 'Ventas/pdf', 'Ventas/pdfVentas', 1),
(84, 'empleados/estadoAbonos', 'Empleados/modificarestadoPrestamo', 1),
(85, 'empleados/validaranularprestamo', 'Empleados/ValidarAnularPrestamo', 1),
(86, 'empleados/asociarpago', 'Empleados/AsociarPagoLiquidacion', 1),
(87, 'empleados/asociarPrima', 'Empleados/AsociarPagoPrima', 1),
(88, 'empleados/informePagos', 'Empleados/informePagos', 1),
(89, 'empleados/informePrestamos', 'Empleados/informePrestamos', 1),
(90, 'ventas/reporteCreditos', 'Ventas/generarpdfCreditos', 1),
(91, 'Compras/pdfDetalles', 'Compras/generarpdfDetallesCompras', 1),
(92, 'producto/anularBaja', 'producto/AnularBaja', 1),
(93, 'ventas/estadoAbonos', 'Ventas/modificarestadoAbonos', 1),
(94, 'producto/validacionombre', 'producto/validacionNombre', 1),
(95, 'ventas/pdfdetallesventas', 'Ventas/generarpdfDetallesVentas', 1),
(96, 'ventas/infoCreditos', 'Ventas/infoCreditos', 1),
(97, 'producto/pdfBajasRangoFecha', 'producto/pdfBajas', 1),
(98, 'producto/infoBajas', 'producto/informeBajas', 1),
(99, 'empleados/pdfPagos', 'Empleados/generarpdfPagos', 1),
(100, 'ventas/pdfAbonos', 'Ventas/generarpdfDetalleAbonos', 1),
(101, 'ventas/pdfreporteganancias', 'Ventas/reporteGanancias', 1),
(102, 'ventas/informganancias', 'Ventas/informeGanancias', 1),
(103, 'producto/detallesBajas', 'producto/ajaxDetallesBajas', 1),
(104, 'empleados/pdfprestamos', 'Empleados/generarpdfPrestamos', 1),
(105, 'empleados/pdfAbonoprestamos', 'Empleados/generarpdfDetalleAbonos', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_pagina_rol`
--

CREATE TABLE `tbl_pagina_rol` (
  `codigo_paginas` int(11) NOT NULL,
  `Tbl_rol_id_rol` int(11) NOT NULL,
  `Tbl_Paginas_codigo_paginas` int(11) NOT NULL,
  `estado` tinyint(4) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_pagina_rol`
--

INSERT INTO `tbl_pagina_rol` (`codigo_paginas`, `Tbl_rol_id_rol`, `Tbl_Paginas_codigo_paginas`, `estado`) VALUES
(2, 1, 2, 1),
(3, 1, 3, 1),
(4, 1, 4, 1),
(5, 1, 5, 1),
(6, 1, 6, 1),
(7, 1, 7, 1),
(8, 1, 8, 1),
(9, 1, 9, 1),
(10, 1, 10, 1),
(11, 1, 11, 1),
(14, 1, 14, 1),
(15, 1, 15, 1),
(16, 1, 16, 1),
(17, 1, 17, 1),
(18, 1, 18, 1),
(19, 1, 19, 1),
(20, 1, 20, 1),
(21, 1, 21, 1),
(22, 1, 22, 1),
(23, 1, 23, 1),
(24, 1, 24, 1),
(25, 1, 25, 1),
(26, 1, 26, 1),
(27, 1, 27, 1),
(28, 1, 28, 1),
(29, 1, 29, 1),
(30, 1, 30, 1),
(31, 1, 31, 1),
(32, 1, 32, 1),
(33, 1, 33, 1),
(34, 1, 34, 1),
(35, 1, 35, 1),
(36, 1, 36, 1),
(37, 1, 37, 1),
(38, 3, 38, 1),
(39, 3, 39, 1),
(40, 3, 40, 1),
(41, 3, 41, 1),
(42, 3, 42, 1),
(43, 3, 43, 1),
(44, 3, 44, 1),
(45, 3, 45, 1),
(46, 3, 46, 1),
(47, 3, 47, 1),
(48, 3, 48, 1),
(49, 3, 49, 1),
(50, 2, 2, 1),
(52, 2, 33, 1),
(53, 2, 26, 1),
(54, 2, 3, 1),
(55, 2, 29, 1),
(56, 2, 28, 1),
(57, 2, 35, 1),
(58, 2, 30, 1),
(59, 2, 31, 1),
(60, 3, 50, 1),
(61, 1, 51, 1),
(62, 2, 21, 1),
(63, 2, 23, 1),
(64, 3, 52, 1),
(65, 2, 10, 1),
(66, 2, 32, 1),
(67, 2, 16, 1),
(68, 2, 14, 1),
(69, 2, 9, 1),
(70, 1, 53, 1),
(71, 3, 54, 1),
(72, 3, 55, 1),
(73, 3, 56, 1),
(74, 1, 57, 1),
(75, 1, 58, 1),
(77, 1, 59, 1),
(79, 1, 60, 1),
(80, 1, 61, 1),
(81, 3, 62, 1),
(82, 1, 63, 1),
(83, 1, 64, 1),
(84, 3, 65, 1),
(86, 3, 66, 1),
(87, 3, 67, 1),
(88, 3, 68, 1),
(89, 2, 6, 1),
(90, 1, 69, 1),
(91, 1, 70, 1),
(92, 1, 71, 1),
(93, 1, 72, 1),
(94, 1, 73, 1),
(95, 1, 74, 1),
(96, 1, 75, 1),
(97, 1, 76, 1),
(98, 1, 77, 1),
(99, 1, 78, 1),
(100, 1, 79, 1),
(101, 1, 80, 1),
(102, 1, 81, 1),
(103, 1, 82, 1),
(104, 1, 83, 1),
(105, 3, 84, 1),
(106, 3, 85, 1),
(107, 3, 86, 1),
(108, 3, 87, 1),
(109, 3, 88, 1),
(110, 3, 89, 1),
(111, 1, 90, 1),
(112, 1, 91, 1),
(113, 1, 92, 1),
(114, 1, 93, 1),
(115, 1, 94, 1),
(116, 1, 95, 1),
(117, 1, 96, 1),
(118, 3, 1, 1),
(119, 3, 2, 1),
(120, 3, 3, 1),
(121, 3, 4, 1),
(122, 3, 5, 1),
(123, 3, 6, 1),
(124, 3, 7, 1),
(125, 3, 8, 1),
(126, 3, 9, 1),
(127, 3, 10, 1),
(128, 3, 11, 1),
(129, 3, 12, 1),
(130, 3, 13, 1),
(131, 3, 14, 1),
(132, 3, 15, 1),
(133, 3, 16, 1),
(134, 3, 17, 1),
(135, 3, 18, 1),
(136, 3, 19, 1),
(137, 3, 20, 1),
(138, 3, 21, 1),
(139, 3, 22, 1),
(140, 3, 23, 1),
(141, 3, 24, 1),
(142, 3, 25, 1),
(143, 3, 26, 1),
(144, 3, 27, 1),
(145, 3, 28, 1),
(146, 3, 29, 1),
(147, 3, 30, 1),
(148, 3, 31, 1),
(149, 3, 32, 1),
(150, 3, 33, 1),
(151, 3, 34, 1),
(152, 3, 35, 1),
(153, 3, 36, 1),
(154, 3, 37, 1),
(156, 3, 51, 1),
(157, 3, 53, 1),
(158, 3, 57, 1),
(159, 3, 58, 1),
(160, 3, 59, 1),
(161, 3, 60, 1),
(162, 3, 61, 1),
(163, 3, 63, 1),
(164, 3, 64, 1),
(166, 3, 69, 1),
(167, 3, 70, 1),
(168, 3, 71, 1),
(169, 3, 72, 1),
(170, 3, 73, 1),
(171, 3, 74, 1),
(173, 3, 75, 1),
(174, 3, 76, 1),
(175, 3, 77, 1),
(176, 3, 78, 1),
(177, 3, 79, 1),
(178, 3, 80, 1),
(179, 3, 81, 1),
(180, 3, 82, 1),
(181, 3, 83, 1),
(182, 3, 90, 1),
(183, 3, 91, 1),
(184, 3, 92, 1),
(185, 3, 93, 1),
(186, 3, 94, 1),
(187, 3, 95, 1),
(188, 3, 96, 1),
(189, 2, 27, 1),
(190, 2, 72, 1),
(191, 2, 73, 1),
(192, 2, 70, 1),
(193, 2, 74, 1),
(194, 2, 95, 1),
(195, 2, 57, 1),
(196, 2, 58, 1),
(197, 2, 61, 1),
(198, 2, 60, 1),
(199, 2, 93, 1),
(200, 2, 90, 1),
(201, 3, 97, 1),
(202, 3, 98, 1),
(203, 3, 58, 1),
(204, 3, 99, 1),
(205, 2, 59, 1),
(206, 3, 100, 1),
(207, 3, 101, 1),
(208, 3, 102, 1),
(209, 3, 103, 1),
(210, 1, 103, 1),
(211, 3, 104, 1),
(212, 3, 105, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_pagoempleados`
--

CREATE TABLE `tbl_pagoempleados` (
  `id_pago` int(11) NOT NULL,
  `fecha_pago` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Tbl_Persona_id_persona` varchar(50) NOT NULL,
  `valorVentas` double UNSIGNED DEFAULT NULL,
  `valorComision` double UNSIGNED DEFAULT NULL,
  `cantidad_dias` int(11) UNSIGNED DEFAULT NULL,
  `valor_dia` double UNSIGNED DEFAULT NULL,
  `valor_prima` int(11) UNSIGNED DEFAULT NULL,
  `valor_vacaciones` int(11) UNSIGNED DEFAULT NULL,
  `valor_cesantias` int(11) UNSIGNED DEFAULT NULL,
  `estado` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_pagoempleados`
--

INSERT INTO `tbl_pagoempleados` (`id_pago`, `fecha_pago`, `Tbl_Persona_id_persona`, `valorVentas`, `valorComision`, `cantidad_dias`, `valor_dia`, `valor_prima`, `valor_vacaciones`, `valor_cesantias`, `estado`) VALUES
(1, '2016-10-25 12:21:25', '103456784356', 0, 0, NULL, NULL, 0, 0, 0, 1),
(2, '2016-10-26 12:34:40', '1234567890', 86000, 860, NULL, NULL, 0, 0, 0, 1),
(3, '2016-10-26 12:35:30', '1026151027', 0, 0, NULL, NULL, 0, 699583, 349791, 1),
(4, '2016-10-26 23:00:11', '1128453257', NULL, NULL, 5, 7000, NULL, NULL, NULL, 1),
(5, '2016-10-26 23:00:33', '1128453257', NULL, NULL, 5, 7000, NULL, NULL, NULL, 1),
(6, '2016-10-26 23:06:38', '325345345', NULL, NULL, 4, 3000, NULL, NULL, NULL, 1),
(7, '2016-10-26 23:07:53', '3773443674', NULL, NULL, 4, 5000, NULL, NULL, NULL, 1),
(8, '2016-10-27 16:12:43', '103456784356', 0, 0, NULL, NULL, 0, 0, 0, 1),
(9, '2016-10-28 16:17:18', '103456784356', 0, 0, NULL, NULL, 0, 0, 0, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_pagoempleados_has_tbl_configuracion`
--

CREATE TABLE `tbl_pagoempleados_has_tbl_configuracion` (
  `Tbl_PagoEmpleados_idpago` int(11) NOT NULL,
  `Tbl_Configuracion_idTbl_Configuracion` int(11) NOT NULL,
  `total_pago` double UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_pagoempleados_has_tbl_configuracion`
--

INSERT INTO `tbl_pagoempleados_has_tbl_configuracion` (`Tbl_PagoEmpleados_idpago`, `Tbl_Configuracion_idTbl_Configuracion`, `total_pago`) VALUES
(1, 1, 960000),
(2, 1, 480860),
(3, 2, 1049374),
(4, 1, 35000),
(5, 1, 35000),
(6, 1, 12000),
(7, 1, 35000),
(8, 1, 480000),
(9, 1, 480000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_persona`
--

CREATE TABLE `tbl_persona` (
  `id_persona` varchar(50) NOT NULL,
  `telefono` varchar(30) NOT NULL,
  `nombres` varchar(30) NOT NULL,
  `email` varchar(45) NOT NULL,
  `direccion` varchar(45) DEFAULT NULL,
  `apellidos` varchar(30) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `genero` varchar(20) NOT NULL,
  `tipo_documento` varchar(40) NOT NULL,
  `Tbl_TipoPersona_idTbl_TipoPersona` int(11) NOT NULL,
  `celular` varchar(12) DEFAULT NULL,
  `fecha_Contrato` date DEFAULT NULL,
  `fecha_Terminacion_Contrato` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_persona`
--

INSERT INTO `tbl_persona` (`id_persona`, `telefono`, `nombres`, `email`, `direccion`, `apellidos`, `estado`, `genero`, `tipo_documento`, `Tbl_TipoPersona_idTbl_TipoPersona`, `celular`, `fecha_Contrato`, `fecha_Terminacion_Contrato`) VALUES
('1026151027', '3069472', 'Jhoan', 'jhoanlt19@gmail.com', 'Carrera 51', 'Lopez', 1, 'Masculino', 'Cedula', 1, '3136747329', '2016-10-25', '2017-10-25'),
('103456784356', '3029867', 'Guillermo', 'guille@yahoo.es', 'Medellín', 'Gómez', 1, 'Masculino', 'Cedula', 1, '3004567812', '2016-10-26', '2017-10-26'),
('1128453257', '3029748', 'juan david', 'jdvargas752@misena.edu.co', 'Prado', 'vargas', 1, 'Masculino', 'Cedula', 2, '3113679012', NULL, NULL),
('1234567890', '3458912', 'victor Hugo', 'davidvargas.jdvp@gmail.com', 'Medellín', 'Gómez', 1, 'Masculino', 'Cedula', 1, '3004525612', '2016-10-12', '2017-10-12'),
('2434355454', '4567812', 'cristian', 'cristian@hotmail.com', '', 'rojas', 1, '', 'Cedula', 3, '3113679012', NULL, NULL),
('325345345', '3456567', 'Jonhatan', 'jonhatan@gmail.com', 'muy lejos', 'Ramirez', 1, 'Masculino', 'Cedula', 2, '3002349012', NULL, NULL),
('3459012356', '3459012', 'marcos', '', 'Poblado', 'rojo', 1, '', 'Cedula', 4, '2347812343', NULL, NULL),
('353453454', '4567812', 'Bryan', '', 'muy lejos', 'Bedoya', 1, '', 'Cedula', 3, '3113679012', NULL, NULL),
('3773443674', '3041246', 'juan', 'juan@gmail.com', '', 'vargas', 1, 'Masculino', 'Cedula', 2, '3002348912', NULL, NULL),
('435445445', '4323435', 'jhoan esneider', '', '', 'lopez', 1, 'Masculino', 'Cedula', 6, '3002348945', NULL, NULL),
('4546456546', '43545466', 'carlos', '', 'medellín', 'gutierres', 1, '', 'Cedula', 4, '3218902356', NULL, NULL),
('454656767', '45467678', 'mario', '', 'medellín', 'restrepo', 1, '', 'Cedula', 3, '3001239034', NULL, NULL),
('645656456', '3435435', 'Kevin', 'kevin@hotmail.com', '', 'Escudero', 1, 'Masculino', 'Cedula', 5, '3002349012', NULL, NULL),
('erer4545tr', '3456567', 'rosa', '', 'industriales', 'lujan', 1, 'Masculino', 'Cédula_Extranjera', 6, '3113679012', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_prestamos`
--

CREATE TABLE `tbl_prestamos` (
  `id_prestamos` int(11) NOT NULL,
  `estado_prestamo` tinyint(1) NOT NULL,
  `valor_prestamo` double UNSIGNED NOT NULL,
  `fecha_prestamo` date NOT NULL,
  `fecha_limite` date NOT NULL,
  `descripcion` varchar(50) NOT NULL,
  `Tbl_Persona_id_persona` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_prestamos`
--

INSERT INTO `tbl_prestamos` (`id_prestamos`, `estado_prestamo`, `valor_prestamo`, `fecha_prestamo`, `fecha_limite`, `descripcion`, `Tbl_Persona_id_persona`) VALUES
(1, 0, 11000, '2016-10-25', '2016-11-24', '', '103456784356'),
(2, 0, 5000, '2016-10-25', '2016-11-24', '', '103456784356'),
(3, 1, 10000, '2016-10-26', '2016-11-25', '', '1026151027');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_productos`
--

CREATE TABLE `tbl_productos` (
  `id_producto` int(11) NOT NULL,
  `nombre_producto` varchar(45) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `precio_detal` double UNSIGNED NOT NULL,
  `precio_por_mayor` double UNSIGNED NOT NULL,
  `precio_unitario` double UNSIGNED NOT NULL,
  `Tbl_Categoria_idcategoria` int(11) NOT NULL,
  `talla` varchar(10) DEFAULT NULL,
  `tamano` varchar(10) DEFAULT NULL,
  `stock_minimo` int(11) UNSIGNED NOT NULL,
  `cantidad` int(11) UNSIGNED DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_productos`
--

INSERT INTO `tbl_productos` (`id_producto`, `nombre_producto`, `estado`, `precio_detal`, `precio_por_mayor`, `precio_unitario`, `Tbl_Categoria_idcategoria`, `talla`, `tamano`, `stock_minimo`, `cantidad`) VALUES
(1, 'pipa', 1, 1900, 1800, 1000, 1, 'M', '', 5, 5),
(2, 'camisa', 1, 1500, 1000, 2000, 1, 'M', '', 5, 20),
(3, 'camiseta', 1, 5000, 4000, 3000, 1, '', '', 3, 20),
(5, 'camisilla', 1, 13000, 12000, 10000, 1, 'M', '', 5, 20),
(6, 'pipita', 1, 5000, 4500, 2000, 2, '', '', 5, 20);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_productos_has_tbl_bajas`
--

CREATE TABLE `tbl_productos_has_tbl_bajas` (
  `Tbl_Bajas_idbajas` int(11) NOT NULL,
  `Tbl_Productos_id_productos` int(11) NOT NULL,
  `Cantidad` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_productos_has_tbl_bajas`
--

INSERT INTO `tbl_productos_has_tbl_bajas` (`Tbl_Bajas_idbajas`, `Tbl_Productos_id_productos`, `Cantidad`) VALUES
(1, 3, 3),
(2, 2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_productos_has_tbl_ventas`
--

CREATE TABLE `tbl_productos_has_tbl_ventas` (
  `Tbl_Ventas_id_ventas` int(11) NOT NULL,
  `cantidad` int(11) UNSIGNED DEFAULT NULL,
  `Tbl_Productos_id_productos` int(11) NOT NULL,
  `id_detalle_venta` int(11) NOT NULL,
  `precio_venta` double UNSIGNED DEFAULT NULL,
  `precio_unitario_actual` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_productos_has_tbl_ventas`
--

INSERT INTO `tbl_productos_has_tbl_ventas` (`Tbl_Ventas_id_ventas`, `cantidad`, `Tbl_Productos_id_productos`, `id_detalle_venta`, `precio_venta`, `precio_unitario_actual`) VALUES
(1, 4, 5, 1, 12000, 10000),
(2, 3, 3, 2, 4000, 3000),
(3, 8, 1, 3, 1800, 1000),
(6, 4, 3, 4, 4000, 0),
(7, 6, 2, 5, 1000, 0),
(7, 5, 1, 6, 1800, 0),
(8, 2, 5, 7, 13000, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_proveedor`
--

CREATE TABLE `tbl_proveedor` (
  `nit` varchar(20) NOT NULL,
  `empresa` varchar(30) DEFAULT NULL,
  `telefono_empresa` varchar(20) DEFAULT 'No',
  `Tbl_Persona_id_persona` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_proveedor`
--

INSERT INTO `tbl_proveedor` (`nit`, `empresa`, `telefono_empresa`, `Tbl_Persona_id_persona`) VALUES
('123.456.34.21', 'Artesanias de colombia S.A', '2349012 ext. 123', '3459012356'),
('123.456.34.21', 'Artesanias de colombia S.A', '2349012 ext. 123', '4546456546');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_rol`
--

CREATE TABLE `tbl_rol` (
  `id_rol` int(11) NOT NULL,
  `nombre_rol` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_rol`
--

INSERT INTO `tbl_rol` (`id_rol`, `nombre_rol`) VALUES
(1, 'Administrador'),
(2, 'Vendedor'),
(3, 'SuperAdmin');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_rol_menu`
--

CREATE TABLE `tbl_rol_menu` (
  `idrol_menu` int(11) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `id_menu` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_rol_menu`
--

INSERT INTO `tbl_rol_menu` (`idrol_menu`, `id_rol`, `id_menu`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(5, 1, 5),
(6, 1, 6),
(7, 1, 7),
(9, 1, 8),
(13, 1, 12),
(14, 1, 13),
(15, 1, 14),
(16, 1, 15),
(18, 1, 16),
(19, 1, 17),
(22, 1, 20),
(23, 3, 21),
(24, 3, 22),
(25, 3, 23),
(29, 3, 27),
(30, 3, 28),
(34, 3, 32),
(37, 2, 1),
(39, 2, 5),
(40, 2, 6),
(41, 2, 7),
(47, 2, 15),
(48, 2, 16),
(49, 2, 17),
(52, 2, 20),
(56, 1, 34),
(57, 2, 2),
(58, 2, 3),
(60, 1, 35),
(61, 1, 36),
(62, 1, 37),
(63, 2, 37),
(64, 1, 38),
(65, 1, 39),
(66, 1, 40),
(67, 3, 1),
(68, 3, 2),
(69, 3, 3),
(70, 3, 4),
(71, 3, 5),
(72, 3, 6),
(73, 3, 7),
(74, 3, 8),
(75, 3, 9),
(76, 3, 10),
(77, 3, 11),
(78, 3, 12),
(79, 3, 13),
(80, 3, 14),
(81, 3, 15),
(82, 3, 16),
(83, 3, 17),
(84, 3, 20),
(85, 3, 34),
(86, 3, 35),
(87, 3, 36),
(88, 3, 37),
(89, 3, 38),
(90, 3, 39),
(91, 3, 40),
(92, 2, 35),
(93, 3, 41),
(94, 1, 41),
(96, 3, 42);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_tipopersona`
--

CREATE TABLE `tbl_tipopersona` (
  `idTbl_tipo_persona` int(11) NOT NULL,
  `Tbl_nombre_tipo_persona` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_tipopersona`
--

INSERT INTO `tbl_tipopersona` (`idTbl_tipo_persona`, `Tbl_nombre_tipo_persona`) VALUES
(1, 'Empleado-fijo'),
(2, 'Empleado-temporal'),
(3, 'Proveedor-natural'),
(4, 'Proveedor-juridico'),
(5, 'Cliente-frecuente'),
(6, 'Cliente-no-frecuente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_usuarios`
--

CREATE TABLE `tbl_usuarios` (
  `id_usuarios` varchar(50) NOT NULL,
  `clave` varchar(250) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `nombre_usuario` varchar(30) NOT NULL,
  `Tbl_rol_id_rol` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_usuarios`
--

INSERT INTO `tbl_usuarios` (`id_usuarios`, `clave`, `estado`, `nombre_usuario`, `Tbl_rol_id_rol`) VALUES
('1026151027', 'HIwTGoQPkXEyfXnnzR4yhYQsQcr/yW6S92adUpLNhaI=', 1, 'jelopez', 2),
('103456784356', 'nUwG2vtRp9rKnP7087izc8UEtyjbxba8EKZ+w1Wvj6s=', 1, 'guillermo', 1),
('1128453257', 'YHQOOQ+0iYDZTdUlCKf3T2BOHXGpKncHXl8DGa6Gfqs=', 1, 'juan', 2),
('1234567890', 'I4HclU851h5KTTVoHee+XGaslYxpincs/P46UI1tVyQ=', 1, 'victor', 3),
('325345345', 'rGQDtZ3U+RAOEoUbBkVswLviqouqyvC5s4xHuoazmFU=', 1, 'jonhatan', 2),
('3773443674', 'nncl+zDZUUZwLw54hUBFGsd8NsNVFw2lItReSQkoSPU=', 1, 'juan2', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_ventas`
--

CREATE TABLE `tbl_ventas` (
  `id_ventas` int(11) NOT NULL,
  `tipo_de_pago` varchar(45) NOT NULL,
  `fecha_venta` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `descuento` double UNSIGNED NOT NULL,
  `subtotal_venta` double UNSIGNED NOT NULL,
  `total_venta` double UNSIGNED NOT NULL,
  `estado` int(1) DEFAULT '1',
  `Tbl_Persona_idpersona_empleado` varchar(50) NOT NULL,
  `Tbl_persona_idpersona_cliente` varchar(50) NOT NULL,
  `estado_credito` int(11) DEFAULT '1',
  `fecha_limite_credito` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_ventas`
--

INSERT INTO `tbl_ventas` (`id_ventas`, `tipo_de_pago`, `fecha_venta`, `descuento`, `subtotal_venta`, `total_venta`, `estado`, `Tbl_Persona_idpersona_empleado`, `Tbl_persona_idpersona_cliente`, `estado_credito`, `fecha_limite_credito`) VALUES
(1, '1', '2016-10-25 21:49:28', 1440, 48000, 46560, 1, '325345345', '645656456', 1, '2016-11-24'),
(2, '2', '2016-10-25 15:59:18', 0, 3000, 3000, 1, '1234567890', '645656456', 1, NULL),
(3, '2', '2016-10-25 15:59:37', 0, 6400, 6400, 1, '1234567890', '645656456', 1, NULL),
(4, '2', '2016-10-25 19:35:21', 0, 3600, 3600, 1, '1234567890', '645656456', 1, NULL),
(5, '2', '2016-10-25 20:57:05', 0, 16000, 16000, 1, '1234567890', '645656456', 1, NULL),
(6, '2', '2016-10-25 20:57:24', 0, 16000, 16000, 1, '1234567890', '645656456', 1, NULL),
(7, '2', '2016-10-26 12:17:43', 0, 15000, 15000, 1, '1234567890', '645656456', 1, NULL),
(8, '1', '2016-10-26 12:25:03', 0, 26000, 26000, 1, '1234567890', 'erer4545tr', 1, '2016-11-27');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tbl_abono_prestamo`
--
ALTER TABLE `tbl_abono_prestamo`
  ADD PRIMARY KEY (`idTbl_Abono_Prestamo`),
  ADD KEY `fk_Tbl_Abono_Prestamo_Tbl_Prestamos1_idx` (`Tbl_Prestamos_idprestamos`);

--
-- Indices de la tabla `tbl_abono_ventas`
--
ALTER TABLE `tbl_abono_ventas`
  ADD PRIMARY KEY (`idabono`),
  ADD KEY `fk_Tbl_Abono_Tbl_Ventas1_idx` (`Tbl_Ventas_idventas`);

--
-- Indices de la tabla `tbl_bajas`
--
ALTER TABLE `tbl_bajas`
  ADD PRIMARY KEY (`id_bajas`),
  ADD KEY `id_persona_empleado` (`id_persona_empleado`);

--
-- Indices de la tabla `tbl_categoria`
--
ALTER TABLE `tbl_categoria`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `tbl_compras`
--
ALTER TABLE `tbl_compras`
  ADD PRIMARY KEY (`id_compras`),
  ADD KEY `fk_Tbl_Compras_Tbl_proveedor1_idx` (`Tbl_Persona_id_persona_proveedor`),
  ADD KEY `fk_compras_id_empleado` (`Tbl_Persona_id_persona_empleado`);

--
-- Indices de la tabla `tbl_compras_has_tbl_productos`
--
ALTER TABLE `tbl_compras_has_tbl_productos`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `fk_Tbl_Compras_has_Tbl_Existencias_Tbl_Compras1_idx` (`Tbl_Compras_idcompras`),
  ADD KEY `fk_Tbl_Compras_has_Tbl_Existencias_Tbl_Productos1_idx` (`Tbl_Productos_id_productos`);

--
-- Indices de la tabla `tbl_configuracion`
--
ALTER TABLE `tbl_configuracion`
  ADD PRIMARY KEY (`idTbl_Configuracion`);

--
-- Indices de la tabla `tbl_configuracion_ventas`
--
ALTER TABLE `tbl_configuracion_ventas`
  ADD PRIMARY KEY (`idConfiguracionVentas`);

--
-- Indices de la tabla `tbl_menu`
--
ALTER TABLE `tbl_menu`
  ADD PRIMARY KEY (`id_menu`);

--
-- Indices de la tabla `tbl_paginas`
--
ALTER TABLE `tbl_paginas`
  ADD PRIMARY KEY (`codigo_paginas`);

--
-- Indices de la tabla `tbl_pagina_rol`
--
ALTER TABLE `tbl_pagina_rol`
  ADD PRIMARY KEY (`codigo_paginas`),
  ADD KEY `fk_Tbl_Pagina_Rol_Tbl_rol1_idx` (`Tbl_rol_id_rol`),
  ADD KEY `fk_Tbl_Pagina_Rol_Tbl_Paginas1_idx` (`Tbl_Paginas_codigo_paginas`);

--
-- Indices de la tabla `tbl_pagoempleados`
--
ALTER TABLE `tbl_pagoempleados`
  ADD PRIMARY KEY (`id_pago`),
  ADD KEY `fk_Tbl_PagoEmpleados_Tbl_Persona1_idx` (`Tbl_Persona_id_persona`);

--
-- Indices de la tabla `tbl_pagoempleados_has_tbl_configuracion`
--
ALTER TABLE `tbl_pagoempleados_has_tbl_configuracion`
  ADD KEY `fk_Tbl_PagoEmpleados_has_Tbl_Configuracion_Tbl_Configuracio_idx` (`Tbl_Configuracion_idTbl_Configuracion`),
  ADD KEY `fk_Tbl_PagoEmpleados_has_Tbl_Configuracion_Tbl_PagoEmpleado_idx` (`Tbl_PagoEmpleados_idpago`);

--
-- Indices de la tabla `tbl_persona`
--
ALTER TABLE `tbl_persona`
  ADD PRIMARY KEY (`id_persona`),
  ADD KEY `fk_Tbl_Persona_Tbl_TipoPersona1_idx` (`Tbl_TipoPersona_idTbl_TipoPersona`);

--
-- Indices de la tabla `tbl_prestamos`
--
ALTER TABLE `tbl_prestamos`
  ADD PRIMARY KEY (`id_prestamos`),
  ADD KEY `fk_Tbl_Prestamos_Tbl_Persona1_idx` (`Tbl_Persona_id_persona`);

--
-- Indices de la tabla `tbl_productos`
--
ALTER TABLE `tbl_productos`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `fk_Tbl_Productos_Tbl_Categoria1_idx` (`Tbl_Categoria_idcategoria`);

--
-- Indices de la tabla `tbl_productos_has_tbl_bajas`
--
ALTER TABLE `tbl_productos_has_tbl_bajas`
  ADD KEY `fk_Tbl_E_has_Tbl_Bajas_Tbl_B_idx` (`Tbl_Bajas_idbajas`),
  ADD KEY `fk_Tbl_P_has_Tbl_B_Tbl_P_idx` (`Tbl_Productos_id_productos`);

--
-- Indices de la tabla `tbl_productos_has_tbl_ventas`
--
ALTER TABLE `tbl_productos_has_tbl_ventas`
  ADD PRIMARY KEY (`id_detalle_venta`),
  ADD KEY `fk_Tbl_Existencias_has_Tbl_Ventas_Tbl_Ventas1_idx` (`Tbl_Ventas_id_ventas`),
  ADD KEY `fk_Tbl_Productos_has_Tbl_Ventas_Tbl_Productos1_idx` (`Tbl_Productos_id_productos`);

--
-- Indices de la tabla `tbl_proveedor`
--
ALTER TABLE `tbl_proveedor`
  ADD PRIMARY KEY (`Tbl_Persona_id_persona`),
  ADD KEY `fk_Tbl_proveedor_Tbl_Persona1_idx` (`Tbl_Persona_id_persona`);

--
-- Indices de la tabla `tbl_rol`
--
ALTER TABLE `tbl_rol`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `tbl_rol_menu`
--
ALTER TABLE `tbl_rol_menu`
  ADD PRIMARY KEY (`idrol_menu`),
  ADD KEY `id_rol` (`id_rol`),
  ADD KEY `id_menu` (`id_menu`);

--
-- Indices de la tabla `tbl_tipopersona`
--
ALTER TABLE `tbl_tipopersona`
  ADD PRIMARY KEY (`idTbl_tipo_persona`);

--
-- Indices de la tabla `tbl_usuarios`
--
ALTER TABLE `tbl_usuarios`
  ADD PRIMARY KEY (`id_usuarios`),
  ADD KEY `fk_Tbl_Usuarios_Tbl_rol1_idx` (`Tbl_rol_id_rol`);

--
-- Indices de la tabla `tbl_ventas`
--
ALTER TABLE `tbl_ventas`
  ADD PRIMARY KEY (`id_ventas`),
  ADD KEY `fk_Tbl_Ventas_Tbl_Persona1_idx` (`Tbl_Persona_idpersona_empleado`) USING BTREE,
  ADD KEY `fk_ventas_idClientes` (`Tbl_persona_idpersona_cliente`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tbl_abono_prestamo`
--
ALTER TABLE `tbl_abono_prestamo`
  MODIFY `idTbl_Abono_Prestamo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `tbl_abono_ventas`
--
ALTER TABLE `tbl_abono_ventas`
  MODIFY `idabono` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `tbl_bajas`
--
ALTER TABLE `tbl_bajas`
  MODIFY `id_bajas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `tbl_categoria`
--
ALTER TABLE `tbl_categoria`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `tbl_compras`
--
ALTER TABLE `tbl_compras`
  MODIFY `id_compras` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `tbl_compras_has_tbl_productos`
--
ALTER TABLE `tbl_compras_has_tbl_productos`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT de la tabla `tbl_configuracion`
--
ALTER TABLE `tbl_configuracion`
  MODIFY `idTbl_Configuracion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `tbl_configuracion_ventas`
--
ALTER TABLE `tbl_configuracion_ventas`
  MODIFY `idConfiguracionVentas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `tbl_menu`
--
ALTER TABLE `tbl_menu`
  MODIFY `id_menu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;
--
-- AUTO_INCREMENT de la tabla `tbl_paginas`
--
ALTER TABLE `tbl_paginas`
  MODIFY `codigo_paginas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;
--
-- AUTO_INCREMENT de la tabla `tbl_pagina_rol`
--
ALTER TABLE `tbl_pagina_rol`
  MODIFY `codigo_paginas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=213;
--
-- AUTO_INCREMENT de la tabla `tbl_pagoempleados`
--
ALTER TABLE `tbl_pagoempleados`
  MODIFY `id_pago` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT de la tabla `tbl_prestamos`
--
ALTER TABLE `tbl_prestamos`
  MODIFY `id_prestamos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `tbl_productos_has_tbl_ventas`
--
ALTER TABLE `tbl_productos_has_tbl_ventas`
  MODIFY `id_detalle_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT de la tabla `tbl_rol`
--
ALTER TABLE `tbl_rol`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `tbl_rol_menu`
--
ALTER TABLE `tbl_rol_menu`
  MODIFY `idrol_menu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;
--
-- AUTO_INCREMENT de la tabla `tbl_ventas`
--
ALTER TABLE `tbl_ventas`
  MODIFY `id_ventas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tbl_abono_prestamo`
--
ALTER TABLE `tbl_abono_prestamo`
  ADD CONSTRAINT `fk_Tbl_Abono_Prestamo_Tbl_Prestamos1` FOREIGN KEY (`Tbl_Prestamos_idprestamos`) REFERENCES `tbl_prestamos` (`id_prestamos`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_abono_ventas`
--
ALTER TABLE `tbl_abono_ventas`
  ADD CONSTRAINT `fk_abonoVentas_ventas` FOREIGN KEY (`Tbl_Ventas_idventas`) REFERENCES `tbl_ventas` (`id_ventas`);

--
-- Filtros para la tabla `tbl_compras`
--
ALTER TABLE `tbl_compras`
  ADD CONSTRAINT `fk_compras_id_empleado` FOREIGN KEY (`Tbl_Persona_id_persona_empleado`) REFERENCES `tbl_persona` (`id_persona`),
  ADD CONSTRAINT `fk_compras_id_proveedor` FOREIGN KEY (`Tbl_Persona_id_persona_proveedor`) REFERENCES `tbl_persona` (`id_persona`);

--
-- Filtros para la tabla `tbl_compras_has_tbl_productos`
--
ALTER TABLE `tbl_compras_has_tbl_productos`
  ADD CONSTRAINT `fk_compras_detalles` FOREIGN KEY (`Tbl_Compras_idcompras`) REFERENCES `tbl_compras` (`id_compras`),
  ADD CONSTRAINT `fk_detalles_compras_Tbl_Productos` FOREIGN KEY (`Tbl_Productos_id_productos`) REFERENCES `tbl_productos` (`id_producto`);

--
-- Filtros para la tabla `tbl_pagina_rol`
--
ALTER TABLE `tbl_pagina_rol`
  ADD CONSTRAINT `fk_Tbl_Pagina_Rol_Tbl_Paginas1` FOREIGN KEY (`Tbl_Paginas_codigo_paginas`) REFERENCES `tbl_paginas` (`codigo_paginas`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Tbl_Pagina_Rol_Tbl_rol1` FOREIGN KEY (`Tbl_rol_id_rol`) REFERENCES `tbl_rol` (`id_rol`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_pagoempleados`
--
ALTER TABLE `tbl_pagoempleados`
  ADD CONSTRAINT `fk_pagoEmpleado_idpersona` FOREIGN KEY (`Tbl_Persona_id_persona`) REFERENCES `tbl_persona` (`id_persona`);

--
-- Filtros para la tabla `tbl_pagoempleados_has_tbl_configuracion`
--
ALTER TABLE `tbl_pagoempleados_has_tbl_configuracion`
  ADD CONSTRAINT `fk_Tbl_PagoEmpleados_has_Tbl_Configuracion_Tbl_Configuracion1` FOREIGN KEY (`Tbl_Configuracion_idTbl_Configuracion`) REFERENCES `tbl_configuracion` (`idTbl_Configuracion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Tbl_detalles_pagoEmpleado` FOREIGN KEY (`Tbl_PagoEmpleados_idpago`) REFERENCES `tbl_pagoempleados` (`id_pago`);

--
-- Filtros para la tabla `tbl_persona`
--
ALTER TABLE `tbl_persona`
  ADD CONSTRAINT `fk_tipo_persona` FOREIGN KEY (`Tbl_TipoPersona_idTbl_TipoPersona`) REFERENCES `tbl_tipopersona` (`idTbl_tipo_persona`);

--
-- Filtros para la tabla `tbl_prestamos`
--
ALTER TABLE `tbl_prestamos`
  ADD CONSTRAINT `fk_prestamos_personas` FOREIGN KEY (`Tbl_Persona_id_persona`) REFERENCES `tbl_persona` (`id_persona`);

--
-- Filtros para la tabla `tbl_productos`
--
ALTER TABLE `tbl_productos`
  ADD CONSTRAINT `fk_productos_categorias` FOREIGN KEY (`Tbl_Categoria_idcategoria`) REFERENCES `tbl_categoria` (`id_categoria`);

--
-- Filtros para la tabla `tbl_productos_has_tbl_bajas`
--
ALTER TABLE `tbl_productos_has_tbl_bajas`
  ADD CONSTRAINT `fk_TblBajas_tblProductos` FOREIGN KEY (`Tbl_Productos_id_productos`) REFERENCES `tbl_productos` (`id_producto`),
  ADD CONSTRAINT `fk_bajas` FOREIGN KEY (`Tbl_Bajas_idbajas`) REFERENCES `tbl_bajas` (`id_bajas`);

--
-- Filtros para la tabla `tbl_productos_has_tbl_ventas`
--
ALTER TABLE `tbl_productos_has_tbl_ventas`
  ADD CONSTRAINT `fk_Tbl_Productos_has_tbl_detalles_Ventas` FOREIGN KEY (`Tbl_Productos_id_productos`) REFERENCES `tbl_productos` (`id_producto`),
  ADD CONSTRAINT `fk_Tbl_detalles_Ventas` FOREIGN KEY (`Tbl_Ventas_id_ventas`) REFERENCES `tbl_ventas` (`id_ventas`);

--
-- Filtros para la tabla `tbl_proveedor`
--
ALTER TABLE `tbl_proveedor`
  ADD CONSTRAINT `fk_proveedor_persona` FOREIGN KEY (`Tbl_Persona_id_persona`) REFERENCES `tbl_persona` (`id_persona`);

--
-- Filtros para la tabla `tbl_rol_menu`
--
ALTER TABLE `tbl_rol_menu`
  ADD CONSTRAINT `fk_mo_menu` FOREIGN KEY (`id_menu`) REFERENCES `tbl_menu` (`id_menu`),
  ADD CONSTRAINT `fk_mo_rol` FOREIGN KEY (`id_rol`) REFERENCES `tbl_rol` (`id_rol`);

--
-- Filtros para la tabla `tbl_usuarios`
--
ALTER TABLE `tbl_usuarios`
  ADD CONSTRAINT `fk_Tbl_Usuarios_Tbl_rol1` FOREIGN KEY (`Tbl_rol_id_rol`) REFERENCES `tbl_rol` (`id_rol`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Usuarios_Personas` FOREIGN KEY (`id_usuarios`) REFERENCES `tbl_persona` (`id_persona`);

--
-- Filtros para la tabla `tbl_ventas`
--
ALTER TABLE `tbl_ventas`
  ADD CONSTRAINT `fk_ventas_idClientes` FOREIGN KEY (`Tbl_persona_idpersona_cliente`) REFERENCES `tbl_persona` (`id_persona`),
  ADD CONSTRAINT `fk_ventas_idpersona` FOREIGN KEY (`Tbl_Persona_idpersona_empleado`) REFERENCES `tbl_persona` (`id_persona`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
