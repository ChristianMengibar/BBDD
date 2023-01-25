USE jardineria;

-- Realiza los siguientes ejercicios mediante subconsultas.

-- 1. Listado de clientes de las oficinas de Madrid (MAD-ES).
SELECT *
FROM clientes cli
WHERE cli.CodigoCliente IN (
	SELECT emp.CodigoEmpleado
    FROM empleados emp
	WHERE emp.CodigoOficina = 'MAD-ES');

-- 2. Listado de clientes de las oficinas de Madrid (MAD-ES) mediante una tabla temporal.
SELECT *
FROM (
	SELECT *
    FROM  empleados emp
    WHERE emp.CodigoOficina = 'MAD-ES'
) Temporal;    

-- 3. Listar el nombre del cliente y el nombre y apellido de sus representantes de aquellos clientes que no hayan realizado pagos.
SELECT cli.NombreCliente, emp.Nombre, emp.Apellido1, emp.Apellido2
FROM clientes cli
	INNER JOIN empleados emp ON emp.CodigoEmpleado = cli.CodigoEmpleadoRepVentas
WHERE CodigoCliente NOT IN (
	SELECT CodigoCliente
    FROM pagos
);

-- 4. Sacar e1 nombre, apellidos, oficina y cargo de aquellos que no sean representantes de ventas.
SELECT emp.Nombre, emp.Apellido1, emp.Apellido2, emp.Puesto
FROM empleados emp
	INNER JOIN oficinas ofi ON ofi.CodigoOficina = emp.CodigoOficina
WHERE emp.Puesto NOT IN (
	SELECT cli.CodigoEmpleadoRepVentas
    FROM clientes cli
) AND puesto != 'Representante Ventas';

-- 5. Sacar el nombre, apellido, oficina (ciudad) y cargo del empleado que no represente a ningún cliente.
SELECT emp.Nombre, emp.Apellido1, emp.Apellido2, ofi.Ciudad, emp.Puesto
FROM empleados emp
	INNER JOIN oficinas ofi ON ofi.CodigoOficina = emp.CodigoOficina
WHERE emp.CodigoEmpleado NOT IN (
	SELECT cli.CodigoEmpleadoRepVentas
    FROM clientes cli
);

-- 6. Sacar los clientes que residan en ciudades donde no hay oficinas ordenado por la ciudad donde residen.
SELECT cli.CodigoCliente, cli.Ciudad
FROM clientes cli
WHERE cli.ciudad NOT IN (
	SELECT ofi.Ciudad
    FROM oficinas ofi
)
ORDER BY cli.Ciudad;    

-- 7. Muestra el listado de ventas por gama de productos mediante una tabla temporal.
SELECT *
FROM (
	SELECT *
    FROM productos pro
    GROUP BY pro.gama
) Tempoaral;