USE GDA

-- Consultas simples

SELECT * FROM almacenes

SELECT * FROM almacenes WHERE ciudad='Seattle'

SELECT * FROM almacenes WHERE id>100

SELECT * FROM clientes

SELECT * FROM clientes WHERE pais='Brasil' AND calificacion_CREDITO='EXCELENTE'

SELECT * FROM clientes WHERE pais='Brasil' OR pais='USA'


/* Consultas simples con funciones AVG(Promedio), COUNT (Cantidad de registros), 
SUM (Suma de todos los valores de un campo), MAX, MIN */

SELECT * FROM pedido

SELECT SUM(total) AS 'Total sumado' FROM pedido 

SELECT 
	MIN(total) AS 'Minimo ventas', 
	AVG(total) AS 'Promedio ventas', 
	SUM(total) AS 'Suma de los totales'
FROM pedido  



--------------- FUNCIONES AGREGACION -----------------

-- Consulta con funcion de agregación donde se agrupen por un atributo de la columna
SELECT 
	SUM(ID) as 'Sumatoria_id',
	AVG(TOTAL) AS 'Promedio totales'
FROM pedido
WHERE tipo_pago='CREDITO'
GROUP BY ID



---------------- GRUUP BY, ORDER BY ----------------

-- ORDER BY

SELECT * FROM producto ORDER BY precio_sugerido DESC


-- GROUP BY: Se agrupa por las columnas que queremos mostrar y por lo que ordenemos.

SELECT nombre, descripc_corta, SUM(precio_sugerido) 
	FROM producto 
	GROUP BY nombre, descripc_corta, id 
	ORDER BY ID ASC 


------------------------ HAVING --------------------

-- HAVING ejecuta la condición en base a los valores que nos retorna la agrupación.
-- HAVING puede contener funciones de agregacion, mientras que el WHERE no

SELECT * FROM clientes

SELECT nombre, telefono, direccion FROM clientes
	GROUP BY nombre, telefono, direccion
	HAVING MAX(id_vendedor) > 12

SELECT * FROM clientes order by id



-- ------------------ TOP, BETWEEN -----------------

SELECT TOP 10 * FROM clientes ORDER BY id DESC

SELECT TOP 3 * FROM producto WHERE id BETWEEN 10000 AND 10500;


-- ---------------------- LIKE ---------------------

/* LIKE: comodín para filtrar búsqueda
% sirve para indicar que hay x cantidad de caracteres antes o despues del caracter que pusimos
_ cada guíon bajo indica que hay 1 caracter antes o despues */

SELECT * FROM almacenes

SELECT * FROM almacenes WHERE direccion LIKE '%ch%'

SELECT * FROM almacenes WHERE ciudad LIKE '_a%'

SELECT * FROM almacenes WHERE ciudad LIKE '%a'

SELECT * FROM almacenes WHERE ciudad NOT LIKE '%e'

-- Direccion que contenga solo dos digitos numericos
SELECT * FROM almacenes WHERE direccion LIKE '[0-9][0-9]'

-- Direccion que contenga dos digitos numericos o mas
SELECT * FROM almacenes WHERE direccion LIKE '%[0-9][0-9]%'




-- ---------------------- JOIN ---------------------

/*JOIN es el proceso de tomar datos de varias tablas
y colocarlos en una vista conjunta

INNER JOIN o JOIN: Selecciona todas las filas de las 
dos columnas siempre y cuando haya una coincidencia 
entre las columnas en ambas tablas. 

LEFT JOIN o LEFT OUTER JOIN: Devuelve todas las filas de la 
tabla de la izquierda, y las filas coincidentes de la tabla de la derecha

RIGHT JOIN o RIGHT OUTER JOIN: Caso opuesto al anterior. 
Devuelve todas las filas de la tabla de la derecha, y las 
filas coincidentes de la tabla de la izquierda.

FULL JOIN o FULL OUTER JOIN: Devuelve todas las filas de las dos tablas, 
tanto la izquierda como la derecha.*/

SELECT * FROM clientes
SELECT * FROM almacenes

-- JOIN
SELECT *
	FROM clientes JOIN almacenes
	ON clientes.ciudad = almacenes.ciudad

-- JOIN con alias
SELECT *
	FROM clientes c JOIN almacenes a
	ON c.ciudad = a.ciudad

-- JOIN con alias y clausulas
SELECT *
	FROM clientes c JOIN almacenes a
	ON c.ciudad = a.ciudad
	WHERE c.pais != 'Brasil'
	ORDER BY a.id DESC

-- JOIN implicito
SELECT *
FROM clientes, almacenes
WHERE clientes.pais = almacenes.pais

-- LEFT JOIN
SELECT *
	FROM clientes c LEFT JOIN almacenes a
	ON c.ciudad = a.ciudad
	WHERE c.pais != 'Brasil'
	ORDER BY a.id DESC



-------------------- SUBCONSULTAS ---------------------
/*introducir una consulta dentro de otra
La consulta interior es la primera que se ejecuta, es decir, se ejecutan desde dentro hacia fuera. */

SELECT * FROM empleados

SELECT * FROM empleados
WHERE salario > (SELECT AVG(salario) FROM empleados)

-- Sub consulta que retorna mas de un valor por lo que necesita usar ANY o ALL
SELECT * FROM empleados
WHERE salario > (SELECT salario FROM empleados WHERE id_jefe > 2)


-------------------- ANY y ALL ---------------------

SELECT * FROM empleados
WHERE salario > (SELECT salario FROM empleados WHERE id_jefe > 2)