-- phpMyAdmin SQL Dump
-- version 4.6.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-10-2016 a las 20:55:19
-- Versión del servidor: 5.6.21
-- Versión de PHP: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `proyecto_bioartsoft`
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Actualizar_Fecha_Limite` (IN `_id_venta` INT, IN `_fecha` DATE)  NO SQL
UPDATE tbl_ventas SET fecha_limite_credito = _fecha WHERE id_ventas = _id_venta$$

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
UPDATE tbl_prestamos pres SET pres.estado_prestamo = _estado WHERE pres.id_prestamos = _id$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ConsultarUsuario` (IN `_id_persona` VARCHAR(50))  NO SQL
SELECT u.nombre_usuario, 
       u.id_usuarios,
       p.email,
       p.id_persona
       
        FROM tbl_usuarios u JOIN tbl_persona p ON u.id_usuarios = p.id_persona WHERE id_persona = _id_persona$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Consultar_Configuracion` ()  NO SQL
SELECT Porcentaje_Maximo_Dcto, Valor_Subtotal_Minimo, 	Porcentaje_Minimo_Dcto, Valor_Subtotal_Maximo FROM tbl_configuracion_ventas$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Consultar_Emails` ()  NO SQL
SELECT email FROM tbl_persona$$

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
p.fecha_pago,
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Informe_Compras` (IN `_fecha_inicial` TIMESTAMP, IN `_fecha_final` TIMESTAMP)  NO SQL
select c.id_compras, 
	   c.fecha_compra, 
       c.valor_total, 
       c.estado, 
       c.Tbl_Persona_id_persona_proveedor, 
       c.Tbl_Persona_id_persona_empleado,
       CONCAT (p.nombres, ' ', p.apellidos) AS proveedor
       from tbl_compras c JOIN tbl_persona p ON c.Tbl_Persona_id_persona_proveedor = p.id_persona
where DATE_FORMAT(fecha_compra, '%Y-%m-%d') BETWEEN _fecha_inicial and _fecha_final AND c.estado = 1 ORDER BY c.id_compras desc$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Informe_Prestamos` ()  NO SQL
SELECT DISTINCT p.id_persona,
		        CONCAT(p.nombres, ' ', p.apellidos) AS empleado,
                t.Tbl_nombre_tipo_persona,
                tp.fecha_prestamo,
                tp.valor_prestamo,
                tp.descripcion,
                tp.estado_prestamo,
                tp.fecha_limite,
                SUM(ap.valor) AS valor,
                tp.valor_prestamo - SUM(ap.valor) AS pendiente
FROM tbl_persona p JOIN tbl_tipopersona t ON t.idTbl_tipo_persona = p.Tbl_TipoPersona_idTbl_TipoPersona JOIN tbl_prestamos tp ON tp.Tbl_Persona_id_persona = p.id_persona JOIN tbl_abono_prestamo ap ON tp.id_prestamos = ap.Tbl_Prestamos_idprestamos
WHERE tp.estado_prestamo = 1 GROUP BY p.id_persona$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Informe_Ventas` (IN `_fecha_inicial` TIMESTAMP, IN `_fecha_final` TIMESTAMP)  NO SQL
select v.id_ventas, 
	   v.fecha_venta, 
       v.total_venta, 
       v.subtotal_venta,
       v.descuento,
       v.estado, 
       v.Tbl_persona_idpersona_cliente, 
       v.Tbl_Persona_idpersona_empleado,
       v.tipo_de_pago,
       CONCAT (p.nombres, ' ', p.apellidos) AS cliente
       from tbl_ventas v JOIN tbl_persona p ON v.Tbl_persona_idpersona_cliente = p.id_persona
where DATE_FORMAT(fecha_venta, '%Y-%m-%d') BETWEEN _fecha_inicial and _fecha_final AND v.estado = 1 ORDER BY v.id_ventas desc$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_InsertarBaja` (IN `_tipo_baja` VARCHAR(50))  NO SQL
INSERT INTO tbl_bajas(tipo_baja) VALUES(_tipo_baja)$$

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
SELECT p.idTbl_Abono_Prestamo, p.fecha_abono, p.estado_abono, p.Tbl_Prestamos_idprestamos, p.valor FROM tbl_abono_prestamo p WHERE p.Tbl_Prestamos_idprestamos = id_prestamo ORDER BY p.fecha_abono DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_listarAbonosCreditosV` (IN `id_VentaCredito` INT)  NO SQL
SELECT v.fechaAbono, 
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
       c.fecha_compra, 
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
            (SELECT max(pag.fecha_pago) from tbl_pagoempleados pag JOIN 			tbl_pagoempleados_has_tbl_configuracion confi ON pag.id_pago 			= confi.Tbl_PagoEmpleados_idpago WHERE 									pag.Tbl_Persona_id_persona = p.id_persona AND 							confi.Tbl_Configuracion_idTbl_Configuracion = 1 ) as 					Fechaulti,
            (SELECT max(pag.fecha_pago) from tbl_pagoempleados pag JOIN 			tbl_pagoempleados_has_tbl_configuracion confi ON pag.id_pago 			= confi.Tbl_PagoEmpleados_idpago WHERE 									pag.Tbl_Persona_id_persona = p.id_persona AND 							confi.Tbl_Configuracion_idTbl_Configuracion = 3 ) as 					FechaTer
          FROM
          	tbl_rol r JOIN tbl_usuarios u ON r.id_rol = u.Tbl_rol_id_rol
            JOIN tbl_persona p ON p.id_persona = u.id_usuarios
            JOIN tbl_tipopersona tp ON tp.idTbl_tipo_persona = p.Tbl_TipoPersona_idTbl_TipoPersona
            WHERE p.Tbl_TipoPersona_idTbl_TipoPersona IN (1,2)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Listar_Prestamos` ()  NO SQL
SELECT DISTINCT p.id_persona, p.nombres, p.apellidos, tp.Tbl_nombre_tipo_persona, pre.estado_prestamo FROM tbl_persona p JOIN tbl_prestamos pre on p.id_persona = pre.Tbl_Persona_id_persona
JOIN tbl_tipopersona tp ON tp.idTbl_tipo_persona = p.Tbl_TipoPersona_idTbl_TipoPersona WHERE pre.estado_prestamo = 1$$

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
SELECT * FROM tbl_rol$$

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
       v.fecha_venta, 
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
SELECT *, CURDATE() AS fecha_actual FROM tbl_ventas WHERE DATE_SUB(fecha_limite_credito,INTERVAL 5 DAY) <= CURDATE() AND tipo_de_pago = 1 AND estado_credito = 1$$

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
       CONCAT(pro.nombres, ' ', pro.apellidos) AS proveedor
FROM tbl_compras_has_tbl_productos AS cp JOIn tbl_productos AS p ON p.id_producto = cp.Tbl_Productos_id_productos JOIN tbl_compras c ON c.id_compras = cp.Tbl_Compras_idcompras JOIN tbl_persona pro ON pro.id_persona = c.Tbl_Persona_id_persona_proveedor
WHERE Tbl_Compras_idcompras = _id_compra GROUP BY pro.id_persona$$

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
            v.fecha_venta,
            v.descuento,
            v.subtotal_venta,
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
SELECT DISTINCT p.id_persona,
				CONCAT(p.nombres, ' ', p.apellidos) AS cliente,
                tp.Tbl_nombre_tipo_persona,
                v.total_venta,
                SUM(av.valor_abono) as abonado
FROM tbl_persona p JOIN tbl_tipopersona tp ON tp.idTbl_tipo_persona = p.Tbl_TipoPersona_idTbl_TipoPersona JOIN tbl_ventas v ON v.Tbl_persona_idpersona_cliente = p.id_persona JOIN tbl_abono_ventas av ON av.Tbl_Ventas_idventas = v.id_ventas WHERE v.estado_credito IN (1,2) GROUP BY p.id_persona$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_sumarValorAbonoPrestamo` (IN `_id_Prestamo` INT)  NO SQL
SELECT sum(valor) as Total from tbl_abono_prestamo WHERE Tbl_Prestamos_idprestamos = _id_Prestamo$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Validar_Email` (IN `_correo` VARCHAR(50))  NO SQL
SELECT email FROM tbl_persona WHERE email = _correo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Validar_Fecha` (IN `_fecha` DATE)  NO SQL
SELECT fecha_compra FROM tbl_compras WHERE DATE_FORMAT(fecha_compra, '%Y%m%d') = _fecha$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Validar_Fecha_Venta` (IN `_fecha` DATE)  NO SQL
SELECT fecha_venta FROM tbl_ventas WHERE DATE_FORMAT(fecha_venta, '%Y%m%d') = _fecha$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Validar_Id_Persona` (IN `_Id_Persona` VARCHAR(50))  NO SQL
SELECT id_persona FROM tbl_persona WHERE id_persona = _Id_Persona$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Validar_Modificacion_Email` (IN `_id_persona` VARCHAR(50), IN `_correo` VARCHAR(50))  NO SQL
SELECT email
FROM tbl_persona WHERE email = _correo AND id_persona = _id_persona$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Validar_nombre_Usu` (IN `_Nombre` VARCHAR(50))  NO SQL
SELECT nombre_usuario FROM tbl_usuarios WHERE nombre_usuario = _Nombre$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Validar_Nombre_Usuario` (IN `_id` VARCHAR(50))  NO SQL
SELECT nombre_usuario
FROM tbl_usuarios WHERE id_usuarios <> _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Validar_Prestamo` (IN `_id_persona` VARCHAR(50))  NO SQL
SELECT Tbl_Persona_id_persona, estado_prestamo, valor_prestamo FROM tbl_prestamos WHERE estado_prestamo = 1 AND Tbl_Persona_id_persona = _id_persona$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Validar_Tipo_Empleado` (IN `_id_persona` VARCHAR(50))  NO SQL
SELECT id_persona FROM tbl_persona WHERE Tbl_TipoPersona_idTbl_TipoPersona = 1 AND id_persona = _id_persona$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Validar_Usuario` (IN `_nombre_usuario` VARCHAR(50))  NO SQL
SELECT nombre_usuario FROM tbl_usuarios WHERE nombre_usuario = _nombre_usuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ValiPrestamo` (IN `id_persona` VARCHAR(50))  NO SQL
SELECT COUNT(pre.estado_prestamo) from tbl_prestamos pre WHERE pre.estado_prestamo = 1 AND pre.Tbl_Persona_id_persona = id_persona$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_valorPrestamoliquidacion` (IN `id_persona` VARCHAR(50))  NO SQL
SELECT SUM(pre.valor_prestamo) as total from tbl_prestamos pre WHERE pre.estado_prestamo = 1 AND pre.Tbl_Persona_id_persona = id_persona$$

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
(1, '2016-09-14 00:09:27', 2000, 1, 1),
(2, '2016-09-14 00:09:45', 2000, 1, 1),
(3, '2016-09-18 19:32:59', 16000, 1, 1),
(4, '2016-09-19 15:01:22', 1000, 1, 2),
(5, '2016-09-19 15:41:37', 1000, 1, 2),
(6, '2016-09-19 15:41:56', 4000, 1, 3),
(7, '2016-09-19 18:17:35', 2000, 1, 7),
(8, '2016-09-19 21:03:46', 0, 1, 7),
(9, '2016-09-19 21:12:24', 0, 1, 3),
(10, '2016-09-19 21:14:08', 0, 1, 3),
(11, '2016-09-19 22:06:14', 0, 1, 3),
(12, '2016-09-19 22:07:58', 3000, 1, 3),
(13, '2016-09-19 22:08:44', 0, 1, 3),
(14, '2016-09-19 22:09:00', 0, 1, 3),
(15, '2016-09-19 22:09:49', 0, 1, 3),
(16, '2016-09-19 22:14:20', 0, 1, 7),
(17, '2016-09-19 22:19:47', 0, 1, 3),
(18, '2016-09-19 22:20:44', 0, 1, 3),
(19, '2016-09-19 22:21:18', 0, 1, 3),
(20, '2016-09-19 23:03:26', 0, 0, 3),
(21, '2016-09-19 23:05:39', 2000, 1, 8),
(22, '2016-09-20 14:05:37', 2000, 0, 3),
(23, '2016-09-21 01:01:36', 1000, 1, 1),
(24, '2016-09-21 01:02:43', 1000, 1, 1),
(25, '2016-09-21 01:15:43', 1000, 1, 7),
(26, '2016-09-21 01:16:15', 5000, 1, 9),
(27, '2016-09-22 17:53:31', 0, 1, 3),
(28, '2016-09-22 17:54:25', 0, 1, 3),
(29, '2016-09-22 18:17:43', 0, 1, 3),
(30, '2016-09-22 18:21:50', 0, 1, 3),
(31, '2016-09-23 15:38:36', 0, 1, 3),
(32, '2016-09-24 22:43:35', 0, 1, 3),
(33, '2016-09-27 19:28:08', 2000, 1, 10),
(34, '2016-09-27 19:29:05', 3000, 1, 10);

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
(1, '2016-09-16 14:32:14', 6000, 3, 6000, 1),
(2, '2016-09-16 14:39:53', 17280, 3, 23280, 1),
(3, '2016-09-16 17:58:35', 5000, 6, 5000, 1),
(5, '2016-09-16 18:30:43', 19000, 6, 24000, 1),
(8, '2016-09-20 21:44:44', 11000, 9, 11000, 1),
(9, '2016-09-20 21:48:17', 23280, 8, 23280, 1),
(11, '2016-09-21 02:33:59', 52000, 10, 52000, 1),
(12, '2016-09-27 17:32:17', 5000, 13, 5000, 1),
(13, '2016-09-27 17:46:44', 2000, 13, 7000, 1),
(14, '2016-09-27 17:47:14', 2000, 13, 9000, 1),
(15, '2016-09-27 17:47:42', 1000, 13, 10000, 1),
(16, '2016-09-27 19:04:59', 2000, 13, 12000, 1),
(17, '2016-09-27 19:09:57', 4000, 13, 16000, 0),
(18, '2016-09-30 17:40:37', 3000, 16, 3000, 1),
(19, '2016-09-30 17:40:53', 3000, 16, 6000, 1),
(20, '2016-09-30 17:41:32', 5000, 16, 11000, 1),
(21, '2016-09-30 17:41:51', 5000, 16, 16000, 1),
(22, '2016-09-30 17:43:25', 1000, 17, 1000, 1),
(23, '2016-09-30 18:20:01', 4000, 17, 5000, 1),
(24, '2016-09-30 18:22:16', 500, 17, 5500, 1),
(25, '2016-10-03 16:46:25', 2000, 23, 2000, 1),
(26, '2016-10-03 17:56:02', 28500, 24, 28500, 0),
(27, '2016-10-03 18:24:38', 28500, 24, 28500, 1),
(28, '2016-10-03 18:26:48', 20000, 25, 20000, 0),
(29, '2016-10-03 18:30:18', 7500, 25, 27500, 0),
(30, '2016-10-04 23:41:02', 2000, 25, 2000, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_bajas`
--

CREATE TABLE `tbl_bajas` (
  `id_bajas` int(11) NOT NULL,
  `fecha_salida` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tipo_baja` varchar(15) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_bajas`
--

INSERT INTO `tbl_bajas` (`id_bajas`, `fecha_salida`, `tipo_baja`, `estado`) VALUES
(1, '2016-09-15 17:19:06', 'Robo', 0),
(2, '2016-09-27 16:45:46', 'Robo', 0),
(3, '2016-09-29 20:46:13', 'Averia', 0),
(4, '2016-09-30 14:48:50', 'Averia', 0),
(5, '2016-10-01 23:42:05', 'Averia', 1);

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
(2, 'Confeccion'),
(3, 'Aromas'),
(4, 'Fumadores'),
(5, 'Varios');

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
(4, '2016-09-15 17:20:10', 140000, 1, '34346546', '1'),
(5, '2016-10-04 19:20:42', 56000, 0, '34346546', '1'),
(6, '2016-09-17 18:27:57', 99000, 1, '435621278', '1'),
(7, '2016-09-27 16:55:12', 120000, 1, '34534646564', '1'),
(8, '2016-10-04 19:02:22', 175000, 1, '34534646564', '1'),
(9, '2016-10-02 00:24:48', 175000, 1, '34534646564', '1'),
(10, '2016-10-04 19:02:27', 70000, 1, '34534646564', '1'),
(11, '2016-10-04 19:02:31', 35000, 1, '34rt454mn454', '1'),
(12, '2016-10-04 22:42:29', 30000, 1, '34534646564', '1'),
(13, '2016-10-04 23:01:57', 14000, 0, '34534646564', '1');

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
(4, 4, 10, 2147483647, 7000),
(4, 5, 10, 2, 7000),
(5, 6, 2, 2, 7000),
(5, 7, 2, 2147483647, 7000),
(6, 8, 7, 2147483647, 7000),
(6, 9, 5, 3, 10000),
(7, 10, 10, 2147483647, 7000),
(7, 11, 5, 3, 10000),
(8, 12, 10, 2147483647, 7000),
(8, 13, 5, 100, 5000),
(8, 14, 8, 3, 10000),
(9, 15, 10, 2147483647, 7000),
(9, 16, 5, 100, 5000),
(9, 17, 8, 3, 10000),
(10, 18, 10, 2147483647, 7000),
(11, 19, 5, 2, 7000),
(12, 20, 3, 3, 10000),
(13, 21, 2, 2147483647, 7000);

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
(1, 'Pago Normal', 'Mensual', 32000, 0.01, 690000),
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
(40, 'Ventas/informeVentas', 'Reporte Ventas', NULL, 15, 4);

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
(96, 'ventas/infoCreditos', 'Ventas/infoCreditos', 1);

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
(200, 2, 90, 1);

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
(1, '2016-09-08 23:42:33', '1', 89000, 890, NULL, NULL, 0, 0, 0, 0),
(2, '2016-09-08 23:46:54', '1', 0, 0, NULL, NULL, 1048462, 698975, 349487, 0),
(3, '2016-09-12 01:16:33', '1', 0, 0, NULL, NULL, 0, 0, 0, 1),
(4, '2016-09-13 23:15:41', '1', 20000, 200, NULL, NULL, 0, 0, 0, 1),
(5, '2016-09-13 23:28:44', '1', 30000, 300, NULL, NULL, 0, 0, 0, 1),
(6, '2016-09-14 16:44:22', '1', 0, 0, NULL, NULL, NULL, 720040, 360020, 1),
(7, '2016-09-14 17:18:45', '1', 78520, 785, NULL, NULL, NULL, 0, 0, 1),
(8, '2016-09-14 17:24:35', '1', 56656, 566, NULL, NULL, NULL, 0, 0, 1),
(9, '2016-09-15 21:08:54', '1', 157000, 1570, NULL, NULL, NULL, 0, 0, 0),
(10, '2016-09-18 19:23:18', '1', 320560, 3205, NULL, NULL, 0, 0, 0, 1),
(11, '2016-09-18 19:24:42', '1', 0, 0, NULL, NULL, 0, 698975, 349487, 1),
(12, '2016-09-18 19:25:21', '1', 0, 0, NULL, NULL, 373425, 0, 0, 1),
(13, '2016-09-18 19:35:49', '1128453257', NULL, NULL, 6, 1000, NULL, NULL, NULL, 1),
(14, '2016-09-18 19:36:05', '1', 56000, 3360, NULL, NULL, 0, 0, 0, 0),
(15, '2016-09-18 19:36:31', '1', 0, 0, NULL, NULL, 0, 699988, 349994, 1),
(16, '2016-09-18 19:36:43', '1', 0, 0, NULL, NULL, 1917, 0, 0, 0),
(17, '2016-09-18 19:36:54', '1128453257', NULL, NULL, 2, 1000, NULL, NULL, NULL, 1),
(18, '2016-09-18 19:38:01', '1128453257', NULL, NULL, 2, 32000, NULL, NULL, NULL, 1),
(19, '2016-09-18 21:57:34', '1128453257', NULL, NULL, 0, 0, NULL, NULL, NULL, 1),
(20, '2016-09-19 18:44:08', '1', 0, 0, NULL, NULL, 0, 0, 0, 1),
(21, '2016-09-19 18:45:41', '1128453257', NULL, NULL, 0, 0, NULL, NULL, NULL, 0),
(22, '2016-09-19 20:19:51', '1128453257', NULL, NULL, 3, 20000, NULL, NULL, NULL, 1),
(23, '2016-09-19 21:43:16', '1128453257', NULL, NULL, 0, 0, NULL, NULL, NULL, 1),
(24, '2016-09-19 21:43:52', '1', 0, 0, NULL, NULL, 0, 0, 0, 1),
(25, '2016-09-19 21:50:58', '1', 0, 0, NULL, NULL, 0, 0, 0, 1),
(26, '2016-09-19 21:51:18', '1', 0, 0, NULL, NULL, 0, 0, 0, 1),
(27, '2016-09-19 21:56:20', '1', 0, 0, NULL, NULL, 0, 0, 0, 1),
(28, '2016-09-19 21:58:07', '1', 0, 0, NULL, NULL, 0, 0, 0, 1),
(29, '2016-09-19 22:00:31', '1', 0, 0, NULL, NULL, 0, 0, 0, 1),
(30, '2016-09-19 22:02:18', '1', 0, 0, NULL, NULL, 0, 0, 0, 1),
(31, '2016-09-19 22:04:44', '1128453257', NULL, NULL, 0, 0, NULL, NULL, NULL, 1),
(32, '2016-09-19 22:38:11', '1', 0, 0, NULL, NULL, 0, 0, 0, 1),
(33, '2016-09-19 22:42:53', '1', 0, 0, NULL, NULL, 0, 0, 0, 0),
(34, '2016-09-19 22:48:40', '1128453257', NULL, NULL, 0, 0, NULL, NULL, NULL, 1),
(35, '2016-09-19 22:56:23', '1128453257', NULL, NULL, 0, 0, NULL, NULL, NULL, 1),
(36, '2016-09-19 23:58:47', '1', 0, 0, NULL, NULL, 0, 0, 0, 1),
(37, '2016-09-19 23:59:25', '1', 0, 0, NULL, NULL, 0, 0, 0, 1),
(38, '2016-09-20 00:02:09', '1', 0, 0, NULL, NULL, 0, 0, 0, 1),
(39, '2016-09-20 00:08:49', '1', 0, 0, NULL, NULL, 0, 0, 0, 1),
(40, '2016-09-20 00:09:23', '1', 0, 0, NULL, NULL, 0, 0, 0, 1),
(41, '2016-09-20 00:10:02', '1', 0, 0, NULL, NULL, 0, 0, 0, 1),
(42, '2016-09-20 00:23:01', '1', 0, 0, NULL, NULL, 0, 0, 0, 1),
(43, '2016-09-20 00:23:43', '1', 0, 0, NULL, NULL, 0, 0, 0, 1),
(44, '2016-09-20 00:24:29', '1', 0, 0, NULL, NULL, 0, 0, 0, 1),
(45, '2016-09-20 00:26:17', '1', 0, 0, NULL, NULL, 0, 0, 0, 1),
(46, '2016-09-20 00:26:46', '1', 0, 0, NULL, NULL, 0, 0, 0, 1),
(47, '2016-09-20 00:30:01', '1', 0, 0, NULL, NULL, 0, 0, 0, 1),
(48, '2016-09-20 00:34:13', '1', 0, 0, NULL, NULL, 0, 0, 0, 1),
(49, '2016-09-20 00:38:43', '1', 0, 0, NULL, NULL, 0, 0, 0, 1),
(50, '2016-09-20 00:53:57', '1', 0, 0, NULL, NULL, 0, 0, 0, 1),
(51, '2016-09-20 00:55:51', '1', 0, 0, NULL, NULL, 0, 699988, 349994, 1),
(52, '2016-09-20 00:58:12', '1', 0, 0, NULL, NULL, 3835, 0, 0, 1),
(53, '2016-09-20 01:07:31', '1', 0, 0, NULL, NULL, 0, 0, 0, 1),
(54, '2016-09-20 01:08:43', '1', 0, 0, NULL, NULL, 0, 0, 0, 0),
(55, '2016-09-20 01:16:24', '1128453257', NULL, NULL, 0, 0, NULL, NULL, NULL, 1),
(56, '2016-09-20 01:20:57', '1128453257', NULL, NULL, 3, 2000, NULL, NULL, NULL, 1),
(57, '2016-09-20 01:21:16', '1128453257', NULL, NULL, 0, 0, NULL, NULL, NULL, 1),
(58, '2016-09-20 01:22:57', '1128453257', NULL, NULL, 0, 0, NULL, NULL, NULL, 1),
(59, '2016-09-20 01:29:01', '1128453257', NULL, NULL, 5, 4000, NULL, NULL, NULL, 1),
(60, '2016-09-20 01:34:53', '1128453257', NULL, NULL, 2, 3000, NULL, NULL, NULL, 1),
(61, '2016-09-20 01:39:34', '1', 0, 0, NULL, NULL, 0, 0, 0, 1),
(62, '2016-09-20 01:45:33', '1', 0, 0, NULL, NULL, 0, 0, 0, 1),
(63, '2016-09-20 02:11:31', '126787454353', 0, 0, NULL, NULL, 0, 0, 0, 0),
(64, '2016-09-20 13:50:39', '1', 0, 0, NULL, NULL, 0, 0, 0, 1),
(65, '2016-09-20 13:51:38', '1', 0, 0, NULL, NULL, 0, 699988, 349994, 0),
(66, '2016-09-20 13:52:07', '1', 0, 0, NULL, NULL, 1917, 0, 0, 1),
(67, '2016-09-21 00:51:53', 'rt4656nm343', 0, 0, NULL, NULL, 0, 0, 0, 0),
(68, '2016-09-22 16:59:14', 'rt4656nm343', 0, 0, NULL, NULL, 0, 0, 0, 1),
(69, '2016-09-22 17:00:52', 'rt4656nm343', 0, 0, NULL, NULL, 0, 699988, 349994, 1),
(70, '2016-09-22 17:07:29', '1128453257', NULL, NULL, 5, 16000, NULL, NULL, NULL, 1),
(71, '2016-09-22 17:25:07', 'rt4656nm343', 0, 0, NULL, NULL, 0, 0, 0, 1),
(72, '2016-09-22 17:25:42', '126787454353', 0, 0, NULL, NULL, 0, 0, 0, 1),
(73, '2016-09-22 17:30:54', '8104179', 0, 0, NULL, NULL, 0, 0, 0, 1),
(74, '2016-09-27 19:14:08', '1', 0, 0, NULL, NULL, 0, 0, 0, 1),
(75, '2016-09-29 19:13:58', '1', 0, 0, NULL, NULL, 17260, 0, 0, 1),
(76, '2016-10-12 16:40:14', '1', 0, 0, NULL, NULL, 0, 0, 0, 1),
(77, '2016-10-12 18:28:48', '1234567890', 0, 0, NULL, NULL, 0, 0, 0, 1),
(78, '2016-10-12 18:31:47', '1', 0, 0, NULL, NULL, 24916, 0, 0, 1);

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
(1, 1, 840890),
(2, 2, 0),
(3, 1, 0),
(4, 1, 840200),
(5, 1, 840300),
(6, 2, 365765),
(7, 1, 0),
(8, 1, 0),
(9, 1, 0),
(10, 1, 703205),
(11, 2, 1048462),
(12, 3, 373425),
(13, 1, 6000),
(14, 1, 873360),
(15, 2, 1049982),
(16, 3, 1917),
(17, 1, 2000),
(18, 1, 64000),
(19, 1, 0),
(20, 1, 870000),
(21, 1, 0),
(22, 1, 60000),
(23, 1, 0),
(24, 1, 900000),
(25, 1, 0),
(26, 1, 0),
(27, 1, 0),
(28, 1, 0),
(29, 1, 0),
(30, 1, 0),
(31, 1, 0),
(32, 1, 0),
(33, 2, 0),
(34, 1, 0),
(35, 1, 0),
(36, 1, 0),
(37, 1, 0),
(38, 1, 900000),
(39, 1, 0),
(40, 1, 900000),
(41, 1, 0),
(42, 1, 0),
(43, 1, 0),
(44, 1, 0),
(45, 1, 0),
(46, 1, 0),
(47, 1, 0),
(48, 1, 0),
(49, 1, 30000),
(50, 2, 0),
(51, 2, 1049982),
(52, 3, 3835),
(53, 1, 0),
(54, 1, 0),
(55, 1, 0),
(56, 1, 6000),
(57, 1, 0),
(58, 1, 0),
(59, 1, 20000),
(60, 1, 6000),
(61, 2, 0),
(62, 2, 0),
(63, 3, 0),
(64, 1, 900000),
(65, 2, 1049982),
(66, 3, 1917),
(67, 1, 900000),
(68, 1, 900000),
(69, 2, 1049982),
(70, 1, 80000),
(71, 1, 900000),
(72, 1, 900000),
(73, 1, 900000),
(74, 1, 900000),
(75, 3, 17260),
(76, 1, 960000),
(77, 3, 0),
(78, 3, 24916);

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
('1', '51310123', 'Victor Hugo', 'jdvargas752@misena.edu.co', 'Cra 45', 'Gómez', 1, 'Masculino', 'Cedula', 1, '31474721334', '2016-10-02', '2017-10-02'),
('1128453257', '3027984', 'Juan David', 'juan@gmail.com', 'Prado', 'Vargas', 1, 'Masculino', 'Cedula', 2, '3503116785', NULL, NULL),
('1234567890', '3458912', 'victor', 'davidvargas.jdvp@gmail.com', 'Medellín', 'Gómez', 1, 'Masculino', 'Cedula', 1, '3004525612', '2016-10-12', '2017-10-12'),
('126787454353', '23459012', 'Guillermo', 'guillermo@hotmail.com', 'Medellín', 'Gómez', 1, 'Masculino', 'Cedula', 1, '3005671234', '2016-09-08', '2017-09-08'),
('32432nm2324', '325425423', 'Mickey', 'mouse@yahoo.us', 'Orlando', 'Mouse', 1, 'Masculino', 'Cédula_Extranjera', 5, '3002348956', NULL, NULL),
('34346546', '3451232', 'Jonhatan', 'Johatan@hotmail.com', 'San Javier', 'Ramirez', 1, '', 'Cedula', 4, '3001236543', NULL, NULL),
('34534543364', '3456789', 'Cristian', 'cristian@hotmail.com', 'Aranjuez', 'Rojas', 1, 'Masculino', 'Cedula', 6, '3217864590', NULL, NULL),
('34534646564', '2348912', 'Jhoan', 'jhoan@hotmail.com', 'Estrella', 'López', 1, '', 'Cedula', 3, '3002345621', NULL, NULL),
('34rt454mn454', '3002389', 'josé', 'jose@yahoo.es', 'En la lejania', 'Perez', 1, '', 'Cédula_Extranjera', 3, '3219003412', NULL, NULL),
('35353454', '3059748', 'Manuela', 'manu@hotmail.com', 'Medellin', 'Urrego ', 1, 'Femenino', 'Cedula', 5, '3005673425', NULL, NULL),
('435621278', '3457823', 'Bryan', 'bryan@yahoo.es', 'Norte', 'Bedoya', 1, '', 'Cedula', 4, '3004562389', NULL, NULL),
('4546546546', '3459012', 'mario', 'mario@gmail.com', 'sur', 'perez', 1, 'Masculino', 'Cedula', 6, '3453324436', NULL, NULL),
('464365745', '3059748', 'Kevin', 'kevin@hotmail.com', 'Caldas', 'Escudero', 1, 'Masculino', 'Cedula', 6, '3005673423', NULL, NULL),
('8104179', '6767878', 'Diego', 'diego@gmail.com', 'cra 12', 'Lopez', 1, 'Masculino', 'Cedula', 1, '3112334312', '2016-08-02', '2017-08-09'),
('rt34mn3434mf', '3002389', 'Daniela', 'dani@hotmail.com', 'Envigado', 'Alcazar', 1, 'Femenino', 'Cédula_Extranjera', 5, '3219003412', NULL, NULL),
('rt4656nm343', '2345678', 'Raúl', 'raul@gmail.com', 'Poblado', 'Martínez', 1, 'Masculino', 'Cédula_Extranjera', 1, '3002341278', '2016-09-09', '2017-09-09');

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
(1, 0, 20000, '2016-09-01', '2016-10-14', 'Jholo', '1'),
(2, 0, 2000, '2016-09-18', '2016-10-18', '', '1'),
(3, 1, 30000, '2016-09-18', '2016-11-10', 'Jholo', '1'),
(5, 3, 20000, '2016-09-19', '2016-10-19', '', '1'),
(7, 1, 6000, '2016-09-19', '2016-10-19', '', '126787454353'),
(8, 0, 2000, '2016-09-19', '2016-10-19', '', '126787454353'),
(9, 1, 31000, '2016-09-21', '2016-10-21', 'cosas', 'rt4656nm343'),
(10, 0, 5000, '2016-09-27', '2016-10-27', 'pruebas', '1'),
(11, 3, 10000, '2016-09-27', '2016-10-27', '', '1');

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
(2, 'Mochila', 1, 10000, 6000, 8000, 2, '', 'Grande', 5, 7),
(3, 'Camiseta', 1, 12000, 9500, 10000, 1, 'M', '', 6, 7),
(100, 'Pipa', 1, 5500, 4500, 5000, 4, '', 'mediana', 5, 7),
(2147483647, 'Gorro', 1, 8000, 5500, 7000, 2, '', 'Pequeño', 5, 4);

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
(1, 2147483647, 2),
(2, 2147483647, 3),
(3, 2147483647, 1),
(4, 3, 2),
(5, 3, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_productos_has_tbl_ventas`
--

CREATE TABLE `tbl_productos_has_tbl_ventas` (
  `Tbl_Ventas_id_ventas` int(11) NOT NULL,
  `cantidad` int(11) UNSIGNED DEFAULT NULL,
  `Tbl_Productos_id_productos` int(11) NOT NULL,
  `id_detalle_venta` int(11) NOT NULL,
  `precio_venta` double UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_productos_has_tbl_ventas`
--

INSERT INTO `tbl_productos_has_tbl_ventas` (`Tbl_Ventas_id_ventas`, `cantidad`, `Tbl_Productos_id_productos`, `id_detalle_venta`, `precio_venta`) VALUES
(1, 2, 2147483647, 1, 5500),
(1, 2, 2, 2, 6000),
(2, 3, 2147483647, 3, 5500),
(2, 2, 2, 4, 6000),
(3, 3, 2, 5, 6000),
(4, 12, 2147483647, 6, 5500),
(5, 2, 2147483647, 7, 5500),
(6, 4, 2, 8, 6000),
(7, 2, 2, 9, 6000),
(8, 2, 3, 10, 9500),
(9, 2, 2147483647, 11, 5500),
(10, 10, 2147483647, 12, 5500),
(11, 3, 3, 13, 9500),
(11, 3, 2147483647, 14, 5500),
(12, 4, 2, 15, 6000),
(12, 2, 2147483647, 16, 5500),
(13, 2, 2, 17, 6000),
(14, 20, 2147483647, 18, 5500),
(14, 2, 3, 19, 9500),
(15, 2, 2147483647, 20, 5500),
(15, 1, 3, 21, 9500),
(16, 2, 2147483647, 22, 5500),
(17, 1, 2147483647, 23, 5500),
(18, 1, 2147483647, 24, 5500),
(18, 1, 100, 25, 4500),
(18, 1, 3, 26, 9500),
(19, 1, 2, 27, 6000),
(21, 2, 2147483647, 28, 5500),
(22, 2, 2147483647, 29, 8000),
(23, 3, 2147483647, 30, 8000),
(24, 3, 3, 31, 9500),
(25, 5, 2147483647, 32, 5500),
(26, 8, 2147483647, 33, 8000);

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
('234.23.456', 'Manillas de Colombia LTDA', '344665767', '34346546'),
('345.23.345', 'Artesanías de Colombia S.A', '4562390 ext. 123', '435621278');

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
(11, 1, 10),
(12, 1, 11),
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
(92, 2, 35);

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
('1', 'LyUas5/8yyKmG2r5zCc7o9a6DLOEAkEDza7XkPtC6vM=', 1, 'victor', 1),
('1128453257', '2ArwmOp/4S9scdWnZQqV6djYuQG7y/1DbRkWiRPqJW8=', 1, 'juan', 2),
('1234567890', 'OhDXxgrBCH4k8QbJ76n4cODBZ2tqf93YgIWS730sqvQ=', 1, 'victor2', 3),
('126787454353', 'kjZPL6rDJdgYjPNygtgkBPjL7CWLbn0HThA40lE14BA=', 1, 'guillermo', 2),
('8104179', 'VhAd02jxyJ4oxgZQvFe9cqc0LzbihivtdNz6qNO+GOE=', 1, 'diego', 2),
('rt4656nm343', '61ULh0y3o42+S0MJDvdzobjN2HXAh8oiB2NXyoXYMFQ=', 1, 'raul', 2);

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
(1, '2', '2016-09-17 19:21:06', 0, 45000, 45000, 1, '1', '35353454', 3, '0000-00-00'),
(2, '2', '2016-09-15 17:48:44', 0, 112000, 112000, 1, '1', '32432nm2324', 0, '0000-00-00'),
(3, '1', '2016-09-20 21:48:58', 720, 24000, 23280, 1, '1', '34534543364', 0, '0000-00-00'),
(4, '2', '2016-09-21 02:11:04', 0, 66000, 66000, 0, '1', '32432nm2324', 0, '0000-00-00'),
(5, '2', '2016-10-04 17:29:18', 0, 11000, 11000, 1, '1', '32432nm2324', 1, '2016-10-09'),
(6, '1', '2016-10-04 17:23:11', 0, 24000, 24000, 1, '1', '32432nm2324', 0, '2016-10-09'),
(7, '2', '2016-09-16 16:38:14', 0, 16000, 16000, 1, '1', '34534543364', 1, NULL),
(8, '1', '2016-09-20 21:48:17', 720, 24000, 23280, 1, '1', '34534543364', 0, '2016-10-17'),
(9, '1', '2016-09-27 17:23:52', 0, 11000, 11000, 0, '1', '32432nm2324', 0, '2016-10-20'),
(10, '1', '2016-09-21 02:33:59', 2750, 55000, 52250, 1, '1', '32432nm2324', 0, '2016-10-20'),
(11, '2', '2016-09-21 02:50:21', 0, 0, 45000, 1, '1', '32432nm2324', 1, NULL),
(12, '2', '2016-09-22 16:46:10', 1050, 35000, 33950, 1, '1', '32432nm2324', 1, NULL),
(13, '1', '2016-09-27 19:09:57', 0, 16000, 16000, 1, '1', '464365745', 0, '2016-10-22'),
(14, '2', '2016-09-27 17:21:46', 9200, 184000, 174800, 1, '1', '4546546546', 1, NULL),
(15, '2', '2016-09-30 17:12:02', 0, 20500, 20500, 1, '1', '32432nm2324', 1, NULL),
(16, '1', '2016-09-30 17:41:51', 0, 16000, 16000, 1, '1', '34534543364', 0, '2016-10-30'),
(17, '1', '2016-09-30 18:22:16', 0, 5500, 5500, 1, '1', '32432nm2324', 0, '2016-10-30'),
(18, '2', '2016-10-01 23:54:51', 0, 19500, 19500, 1, '1', '32432nm2324', 1, NULL),
(19, '2', '2016-10-03 14:53:46', 0, 6000, 6000, 1, '1', '32432nm2324', 1, NULL),
(20, '2', '2016-10-03 16:17:41', 0, 11000, 11000, 1, '1', '32432nm2324', 1, NULL),
(21, '2', '2016-10-03 16:21:54', 0, 11000, 11000, 1, '1', '32432nm2324', 1, NULL),
(22, '2', '2016-10-04 21:42:21', 0, 16000, 16000, 0, '1', '34534543364', 1, NULL),
(23, '1', '2016-10-06 17:13:55', 0, 24000, 24000, 1, '1', '34534543364', 1, '2016-11-05'),
(24, '1', '2016-10-03 18:24:38', 0, 28500, 28500, 1, '1', '32432nm2324', 0, '2016-11-02'),
(25, '1', '2016-10-12 18:51:39', 0, 27500, 27500, 1, '1', '32432nm2324', 1, '2016-11-12'),
(26, '2', '2016-10-12 18:18:54', 3200, 64000, 60800, 0, '1', '34534543364', 1, NULL);

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
  ADD PRIMARY KEY (`id_bajas`);

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
  MODIFY `idTbl_Abono_Prestamo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;
--
-- AUTO_INCREMENT de la tabla `tbl_abono_ventas`
--
ALTER TABLE `tbl_abono_ventas`
  MODIFY `idabono` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;
--
-- AUTO_INCREMENT de la tabla `tbl_bajas`
--
ALTER TABLE `tbl_bajas`
  MODIFY `id_bajas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `tbl_categoria`
--
ALTER TABLE `tbl_categoria`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `tbl_compras`
--
ALTER TABLE `tbl_compras`
  MODIFY `id_compras` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT de la tabla `tbl_compras_has_tbl_productos`
--
ALTER TABLE `tbl_compras_has_tbl_productos`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
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
  MODIFY `id_menu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;
--
-- AUTO_INCREMENT de la tabla `tbl_paginas`
--
ALTER TABLE `tbl_paginas`
  MODIFY `codigo_paginas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;
--
-- AUTO_INCREMENT de la tabla `tbl_pagina_rol`
--
ALTER TABLE `tbl_pagina_rol`
  MODIFY `codigo_paginas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=201;
--
-- AUTO_INCREMENT de la tabla `tbl_pagoempleados`
--
ALTER TABLE `tbl_pagoempleados`
  MODIFY `id_pago` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;
--
-- AUTO_INCREMENT de la tabla `tbl_prestamos`
--
ALTER TABLE `tbl_prestamos`
  MODIFY `id_prestamos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT de la tabla `tbl_productos_has_tbl_ventas`
--
ALTER TABLE `tbl_productos_has_tbl_ventas`
  MODIFY `id_detalle_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;
--
-- AUTO_INCREMENT de la tabla `tbl_rol`
--
ALTER TABLE `tbl_rol`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `tbl_rol_menu`
--
ALTER TABLE `tbl_rol_menu`
  MODIFY `idrol_menu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;
--
-- AUTO_INCREMENT de la tabla `tbl_ventas`
--
ALTER TABLE `tbl_ventas`
  MODIFY `id_ventas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;
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
