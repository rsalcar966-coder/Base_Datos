-- 1. Mostrar el id y saldo de todas las cuentas cuyo interés es positivo.
SELECT id, saldo 
FROM cuentas 
WHERE interes > 0;

-- 2. Muestra aquellas sucursales cuya dirección contiene la A y además el capital del año anterior supera los 10.000 euros
SELECT * 
FROM sucursales 
WHERE direccion 
LIKE '%A%' 
  AND capital_anio_anterior > 10000;

-- 3. Muestra todos los movimientos realizados en enero.
SELECT * 
FROM movimientos 
WHERE MONTH(fecha) = 1;

-- 4. Muestra los movimientos realizados antes de las 12 horas
SELECT * 
FROM movimientos 
WHERE HOUR(hora) < 12;

-- 5. Muestra los movimientos de salida realizados
-- Asumiendo que hay un campo 'tipo' que indica 'salida'
SELECT * 
FROM movimientos 
WHERE tipo = 'salida';

-- 6. Muestra el nombre y los apellidos del cliente sin repetir en un mismo campo llamado nombre completo.
SELECT DISTINCT CONCAT(nombre, ' ', apellidos) AS 'nombre completo' 
FROM clientes;

-- 7. Muestra en mayúsculas todos los tipos de movimientos existentes de los que se ha hecho algún movimiento. No debe haber valores repetidos
SELECT DISTINCT UPPER(tipo) 
FROM movimientos;

-- 8. Muestra aquellos apellidos con más de 5 letras.
SELECT apellidos 
FROM clientes 
WHERE CHAR_LENGTH(apellidos) > 5;

-- 9. Muestra un nick para cada cliente formado por las dos primeras letras del nombre y el primer apellido
SELECT CONCAT(LEFT(nombre, 2), apellidos) AS nick 
FROM clientes;

-- 10. Muestra la dirección de la sucursal 1
SELECT direccion 
FROM sucursales 
WHERE id = 1;

-- 11. Muestra aquellos clientes cuyo nombre sea un palíndromo.
SELECT * 
FROM clientes 
WHERE nombre = REVERSE(nombre);

-- 12. Añade el campo fecha de nacimiento a la tabla cliente con el día de hoy de valor por defecto.
ALTER TABLE clientes 
ADD COLUMN fecha_nacimiento DATE DEFAULT (CURRENT_DATE);

-- 13. Incrementa dos días a cada cliente en su fecha de nacimiento.
UPDATE clientes 
SET fecha_nacimiento = DATE_ADD(fecha_nacimiento, INTERVAL 2 DAY);

-- 14. Muestra su fecha de nacimiento en días
-- Esto suele referirse al día del mes, o a convertir la fecha entera a número de días (TO_DAYS)
SELECT DAY(fecha_nacimiento) AS dia_nacimiento 
FROM clientes;

-- 15. Muestra su nombre en mayúsculas y el año de nacimiento.
SELECT UPPER(nombre), YEAR(fecha_nacimiento) 
FROM clientes;

-- 16. Muestra un mensaje de felicitación para cada cliente, del tipo “¡Felicidades NOMBRE por tus AÑOS cumpleaños!” y llama a ese campo felicitación
-- TIMESTAMPDIFF se usa para calcular la edad exacta
SELECT CONCAT('¡Felicidades ', nombre, ' por tus ', TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE()), ' cumpleaños!') AS felicitacion 
FROM clientes;

-- 17. Muestra aquellos clientes que su edad sea mayor de 18 años y que además su nombre o su apellido terminen por S
SELECT * 
FROM clientes 
WHERE TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE()) > 18 
  AND (nombre LIKE '%S' OR apellidos LIKE '%S');

-- 18. Haz una lista de clientes en la que aparezca su nombre, apellidos y el numero de iban.
-- Requiere unir tablas (JOIN)
SELECT cl.nombre, cl.apellidos, cu.iban 
FROM clientes cl 
JOIN cuentas cu ON cl.id = cu.id_cliente;

-- 19. Muestra todos los movimientos junto a su descripción
SELECT id, importe, fecha, descripcion 
FROM movimientos;

-- 20. Cuenta el número de clientes que existen en la base de datos
SELECT COUNT(*) 
FROM clientes;

-- 21. Muestra aquellas cuentas cuyo nombre de Sucursal contenga la A
SELECT c.* 
FROM cuentas c 
JOIN sucursales s ON c.id_sucursal = s.id 
WHERE s.nombre LIKE '%A%';

-- 22. Cuenta el número de movimientos de salida realizados en aquellas cuentas con interés inferior al 4%.
SELECT COUNT(*) 
FROM movimientos m 
JOIN cuentas c ON m.id_cuenta = c.id 
WHERE m.tipo = 'salida' 
  AND c.interes < 4;

-- 23. Muestra el nombre del cliente, el apellido, el iban, el saldo, los movimientos realizados, el importe y la direccion de la sucursal
-- Unimos Cliente -> Cuenta -> Movimientos -> Sucursal
SELECT cl.nombre, cl.apellidos, cu.iban, cu.saldo, m.id AS id_movimiento, m.importe, s.direccion 
FROM clientes cl
JOIN cuentas cu ON cl.id = cu.id_cliente
JOIN movimientos m ON cu.id = m.id_cuenta
JOIN sucursales s ON cu.id_sucursal = s.id;

-- 24. Muestra el total de saldo que tenga la sucursal 1.
SELECT SUM(saldo) 
FROM cuentas 
WHERE id_sucursal = 1;

-- 25. Muestra la media de importes de entrada que existan en el sistema.
SELECT AVG(importe) 
FROM movimientos 
WHERE tipo = 'entrada';