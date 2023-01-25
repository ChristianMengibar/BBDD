USE jardineria;

-- 1. Muestra el listado de descripciones de texto de la tabla gamasproductos usando la función CONVERT(DescripcionTexto USING utf8).
SELECT CONVERT (DescripcionTexto USING utf8) AS 'Descripcion'
FROM GamasProductos gam;

-- 2. Muestra el número de clientes norteamericanos.
SELECT COUNT(*) AS 'numClientes'
FROM Clientes cli
WHERE Pais = 'USA';

-- 3. seleccionar la concatenación del nombres, apellido 1 y apellido 2 de los empleados, y la dirección1 de su oficina.
SELECT CONCAT(emp.Nombre, ' ', emp.Apellido1, ' ', emp.Apellido2) AS 'nombreYapellidos', CONCAT(ofi.LineaDireccion1, ' ',ofi.LineaDireccion2) AS 'direccionCompleta'
FROM Empleados emp 
	INNER JOIN Oficinas ofi ON ofi.CodigoOficina = emp.CodigoOficina;

-- 4. Mostrar el apellido de los empleados y la ciudad de su oficina. Si algún empleado no tuviera una oficina asignada no saldría.
SELECT emp.Apellido1, emp.Apellido1, ofi.Ciudad
FROM Empleados emp
	INNER JOIN Oficinas ofi ON ofi.CodigoOficina = emp.CodigoOficina;
    
-- 5. Mostrar el apellido de los empleados y la ciudad de su oficina. También deben salir los empleados que no tienen una oficina asignada.
SELECT emp.Apellido1, emp.Apellido2, ofi.Ciudad
FROM Empleados emp
	LEFT JOIN Oficinas ofi ON ofi.CodigoOficina = emp.CodigoOficina;

-- 6. Muestra el nombre de los cliente y el nombre de su empleado asociado (si lo tiene). 
SELECT cli.NombreCliente, emp.Nombre
FROM Clientes cli
	INNER JOIN Empleados emp ON emp.CodigoEmpleado = cli.CodigoEmpleadoRepVentas;

-- 7. Nombre de los clientes que hayan hecho un pago en 2007.
SELECT cli.NombreCliente, pag.FechaPago
FROM Clientes cli
	INNER JOIN pagos pag ON pag.CodigoCliente = cli.CodigoCliente
WHERE FechaPago BETWEEN '2007-01-01' AND '2007-12-31';

-- 8. Muestra el número de pedido, el nombre del cliente, la fecha de entrega y la fecha requerida de los pedidos que no han sido entregados a tiempo.
SELECT ped.CodigoPedido, cli.NombreCliente, ped.FechaEntrega, ped.FechaEntrega
FROM Pedidos ped
	INNER JOIN Clientes cli ON cli.CodigoCliente = ped.CodigoCliente
WHERE FechaEsperada < FechaEntrega;

-- 9. Muestra el nombre y apellidos de los empleados (concatenados) que trabajan en Barcelona.
SELECT CONCAT(emp.Nombre, ' ', emp.Apellido1, ' ', emp.Apellido2) AS 'nombreCompleto'
FROM Empleados emp
	INNER JOIN Oficinas ofi ON ofi.CodigoOficina = emp.CodigoOficina
WHERE Ciudad = 'Barcelona';

-- 10. Seleccionar de todos los pedidos, el Nombre del empleado que ha realizado el pedido, el nombre del cliente al que se le ha vendido y el código de pedido.
SELECT emp.Nombre, cli.NombreCliente, ped.CodigoPedido
FROM Empleados emp 
	JOIN Clientes cli ON cli.CodigoEmpleadoRepVentas = emp.CodigoEmpleado
	JOIN Pedidos ped ON ped.CodigoCliente = cli.CodigoCliente;

-- 11. Devuelve el producto cartesiano de las tablas empleados y oficinas.
SELECT emp.*, ofi.*
FROM Empleados emp
	CROSS JOIN Oficinas ofi;

-- 12. Mostrar el listado de pedidos que no tengan fecha de entrega, de los clientes con códigos del 1 al 15 junto con los nombres de los clientes.
SELECT ped.CodigoPedido, ped.FechaEntrega, cli.CodigoCliente, cli.NombreCliente
FROM Pedidos ped
	INNER JOIN Clientes cli ON cli.CodigoCliente = ped.CodigoCliente
WHERE FechaEntrega IS NULL AND cli.CodigoCliente BETWEEN 1 AND 15;

-- 13. Devuelve un listado de los productos que han aparecido en los pedidos, cuyo codigo de producto empiece por OR.
SELECT DISTINCT pro.CodigoProducto, pro.Nombre
FROM Productos pro
	INNER JOIN detallepedidos det ON det.CodigoProducto = pro.CodigoProducto 
WHERE pro.CodigoProducto LIKE 'OR%'
ORDER BY pro.CodigoProducto;

-- 14. Devuelve un listado de los productos que no han aparecido en ningún pedidos.
SELECT pro.Nombre, pro.CodigoProducto
FROM Productos pro
	LEFT JOIN detallepedidos det ON det.CodigoProducto = pro.CodigoProducto
WHERE det.CodigoProducto IS NULL;

-- 15. Devuelve el código, nombre, y la descripción del texto de la gama de los productos que no han aparecido en ningún pedido.
SELECT pro.CodigoProducto, pro.Nombre, CONVERT (gam.DescripcionTexto USING utf8) AS 'gameDescripcion'
FROM Productos pro
	LEFT JOIN detallepedidos det ON det.CodigoProducto = pro.CodigoProducto
    INNER JOIN gamasproductos gam ON gam.Gama = pro.Gama
WHERE det.CodigoProducto IS NULL;

/* FIN */