CREATE DATABASE TareaDML;

use TareaDML;

/* 1. CREA Y NORMALIZA LA SIGUIENTE TABLA. */
CREATE TABLE employees
(
id INT PRIMARY KEY AUTO_INCREMENT,
employee_name VARCHAR(50) NOT NULL,
surname VARCHAR(50) NOT NULL,
job VARCHAR(50) NULL,
direction VARCHAR(100) NOT NULL,
high_date DATETIME NOT NULL, -- DEFAULT FECHA ACTUAL
salary FLOAT NOT NULL,
commission FLOAT NOT NULL,
department_number VARCHAR(50) NOT NULL
);


/* 2. INSERTA 5 REGISTROS DISTINTOS EN LA TABLA ANTERIOR. */
INSERT INTO employees 
VALUES ('1', 'Christian', 'Mengibar', 'Programador', 'Avenida Fuenlabrada', CURRENT_TIMESTAMP(), 2350, salario * 1.08, 'Marketing');

INSERT INTO employees 
VALUES ('2', 'Roberto', 'Fernandez', 'Comercial', 'Avenida America', CURRENT_TIMESTAMP(), '1350€', salario * 1.08, 'Ventas');

INSERT INTO employees 
VALUES ('3', 'Julian', 'Fernandez', 'Director', 'Avenida del Carmen', CURRENT_TIMESTAMP(), '4500€', salario * 1.08, 'Informatica');

INSERT INTO employees 
VALUES ('4', 'Alberto', 'Benito', 'Director', 'Avenida Peru', CURRENT_TIMESTAMP(), '4500€', salario * 1.08, 'Informatica');

INSERT INTO employees 
VALUES ('5', 'Alejandro', 'Pardal', 'Practicas', 'Avenida Calatayud', CURRENT_TIMESTAMP(), '950€', salario * 1.08, 'Marketing');

/* 3. DA DE ALTA 2 EMPLEADOS: JULIAN ROMERAL Y LUIS ALONSO SU SALARIO BASE DE DE 30000€ Y COBRARAN UNA COMISION DEL 15% DE SU SALARIO. */
INSERT INTO employees 
VALUES ('6', 'Julian', 'Romeral', 'Director', 'Avenida del Pilar', CURRENT_TIMESTAMP(), 30000, salario * 1.15, 'Marketing');

INSERT INTO employees 
VALUES ('7', 'Luis', 'Alonso', 'Comercial', 'Avenida Leganes', CURRENT_TIMESTAMP(), '30000€', salario * 1.15, 'Ventas');

/* 4. ACTUALIZA EL APELLIDO DE JULIAN ROMERAL POR ALONSO. */
UPDATE employees
SET surname = 'Alonso'
WHERE id = 6;

/* 5. ACTUALIZA EL APELIIDO DE LUIS ALONSO POR ROMERAL. */
UPDATE employees
SET surname = 'Romeral'
WHERE id = 7;

/* 6. ACTUALIZA EL OFICIO DE JULIAN ROMERAL A PROGRAMADOR Y EL DEPARTAMENTO POR INFORMATICA. */
UPDATE employees
SET job = 'Programador'
WHERE id = 6;

UPDATE employees
SET department_number = 'Informatica'
WHERE id = 6;

/* 7. ACTUALIZA EL OFICIO DE JULIAN ROMERAL A PRACTICAS Y EL DEPARTAMENTO POR VENTAS. */
UPDATE employees
SET job = 'Practicas'
WHERE id = 6;

UPDATE employees
SET department_number = 'Ventas'
WHERE id = 6;

/* 8. ACTUALIZA EL OFICIO DE OTRO EMPLEADO A COMERCIAL Y SU DEPARTAMENTO DE MARKETING. */
UPDATE employees
SET job = 'Comercial'
WHERE id = 1;

UPDATE employees
SET department_number = 'Marketing'
WHERE id = 1;

/* 9. ACTUALIZA EL OFICIO DE OTRO EMPLEADO A DIRECTOR Y SU DEPARTAMENTO A VENTAS. */
UPDATE employees
SET job = 'Director'
WHERE id = 2;

UPDATE employees
SET department_number = 'Ventas'
WHERE id = 2;

/* 10. MODIFICAR LA COMISION DE TODOS LOS EMPLEADOS DE LA EMPRESA, DE FORMA QUE TODOS TENGAN UN INCREMENTO DEL 10% DEL SALARIO. */
UPDATE employees
SET commission = salario * 1.10;

/* 11. MODIFICA EL SALARIO DE 2 EMPLEADOS PARA QUE COBREN MAS DE 32000€. */
UPDATE employees
SET salary = 32000
WHERE id = 3;

UPDATE employees
SET salary = 32000
WHERE id = 4;

/* 12. MODIFICAR LA COMISION DE LOS EMPLEADOS DE LA EMPRESA QUE COBREN MAS DE 32000€ DE FORMA QUE TODOS LOS QUE CUMPLAN ESTE REQUISITO TENGAN UN INCREMENTO DEL 12% DEL SALARIO. */
UPDATE employees
SET salary = salary * 1.12
WHERE salary = 32000;

/* 13. INCREMENTAR UN 5% EL SALARIO DE LOS EMPLEADOS EN PRACTICAS DEL DEPARTAMENTO DE INFORMATICA. */
UPDATE employees
SET salary = salary * 1.05
WHERE job = 'Practicas' AND department_number = 'Informatica';

/* 14. INCREMENTAR UN 8% EL SALARIO DE LOS PROGRAMADORES DEL DEPARTAMENTO DE INFORMATICA. */
UPDATE employees
SET salary = salary * 1.08
WHERE department_number = 'Informatica';

/* 15. INCREMENTAR UN 6% EL SALARIO DE LOS EMPLEADOS DEL DEPARTAMENTO DE VENTAS QUE COBREN MENOS DE 20000€. */
UPDATE employees
SET salary = salary * 1.06
WHERE salary < 20000;

/* 16. INCREMENTAR UN 8% EL SALARIO DE LOS EMPLEADOS DEL DEPARTAMENTO DE INFORMATICA. */
UPDATE employees
SET salary = salary + salary * 1.08
WHERE department_number = 'Informatica';

/* 17. REDUCE UN 3% EL SALARIO DE LOS EMPLEADOS DEL DEPARTAMENTO DE MARKETING. */
UPDATE employees
SET salary = salary * 0.03
WHERE department_number = 'Marketing';

/* 18. REDUCE UN 5% EL SALARIO DE LOS DIRECTORES QUE COBREN MAS DE 40000€. */
UPDATE employees
SET salary = salary * 0.05
WHERE job = 'Director' AND salary > 40000 ;

/* 19. INCREMENTAR EN 1000€ EL SALARIO DE LOS EMPLEADOS DEL DEPARTAMENTO DE MARKETING. */
UPDATE employees
SET salary = salary + 1000
WHERE department_number = 'Marketing';

/* 20. INCREMENTAR EN 1500€ EL SALARIO DE LOS COMERCIALES. */
UPDATE employees
SET salary = salary + 1500
WHERE department_number = 'Comercial';

/* 21. INCREMENTAR EN 5,75% EL SALARIO DE LOS EMPLEADOS QUE COBREN MAS DE 20000€. */
UPDATE employees
SET salary = salary * 1.0575
WHERE salary < 20000;

/* 22. INCREMENTAR EN UN 12,5% EL SALARIO DE LOS EMPLEADOS QUE COBREN MENOS DE 20000€. */
UPDATE employees
SET salary = salary * 1.125
WHERE salary > 20000;

/* 23. INCREMENTA UN 5% EL SALARIO DE LOS EMPLEADOS QUE NO SEAN DEL DEPARTAMENTO DE VENTAS. */
UPDATE employees
SET salary = salary * 1.05
WHERE department_number != 'Ventas';

/* 24. INCREMENTA UN 2,5% EL SALARIO DE LOS EMPLEADOS QUE SEAN DEL DEPARTAMENTO DE MARKETING O DE INFORMATICA. */
UPDATE employees
SET salary = salary * 1.025
WHERE department_number = 'Marketing' OR department_number = 'Informatica';

/* 25. SUBE EL SALARIO EN 1000€ Y LA COMISION AL 16% DEL SALARIO A LOS EMPLEADOS QUE SE DIERON DE ALTA EN ESTE AÑO. */
UPDATE employees
SET salary = salary + 1000,
commission = salary * 1.16
WHERE high_date >= '2021-01-01 00:00:00';

/* 26. SUBE EL SALARIO EN UN 5% Y LA COMISION SEA DEL 10% DEL SALARIO A LOS EMPLEADOS QUE SE LLEVEN EN LA EMPRESA MAS DE 10 AÑOS. */
UPDATE employees
SET salary = salary + salary * 0.05,
commission = salary * 0.10
WHERE high_date < '2011-03-18';

/* FIN */