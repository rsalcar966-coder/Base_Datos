-- 1. Mostrar el saldo medio de todas las cuentas de la entidad bancaria.
SELECT AVG(saldo) AS saldo_medio
FROM Cuenta;

-- 2. Mostrar la suma de los saldos de todas las cuentas bancarias.
SELECT 
	SUM(saldo) AS suma_total_saldos
FROM Cuenta;

-- 3. Mostrar el saldo mínimo, máximo y medio de todas las cuentas bancarias.
SELECT 
	MIN(saldo) AS minimo, 
	MAX(saldo) AS maximo, AVG(saldo) AS medio
FROM Cuenta;

-- 4. Mostrar la suma de los saldos y el saldo medio de las cuentas bancarias agrupadas por su código de sucursal.
SELECT cod_sucursal, 
	SUM(saldo) AS suma_saldos, AVG(saldo) AS saldo_medio
FROM Cuenta
GROUP BY cod_sucursal;

-- 5. Para cada cliente del banco se desea conocer su código, la cantidad total que tiene depositada en la entidad y el número de cuentas abiertas.
SELECT cod_cliente, 
	SUM(saldo) AS total_depositado, 
	COUNT(*) AS num_cuentas
FROM Cuenta
GROUP BY cod_cliente;

-- 6. Retocar la consulta anterior para que aparezca el nombre y apellidos de cada cliente en vez de su código de cliente.
SELECT cl.nombre, cl.apellidos, 
	SUM(cu.saldo) AS total_depositado, 
    COUNT(*) AS num_cuentas
FROM Cliente cl
	JOIN Cuenta cu ON cl.cod_cliente = cu.cod_cliente
GROUP BY cl.cod_cliente;

-- 7. Para cada sucursal del banco se desea conocer su dirección, el número de cuentas que tiene abiertas y la suma total que hay en ellas.
SELECT s.direccion, 
	COUNT(cu.cod_cuenta) AS num_cuentas, 
    SUM(cu.saldo) AS total_fondos
FROM Sucursal s
	JOIN Cuenta cu ON s.cod_sucursal = cu.cod_sucursal
GROUP BY s.cod_sucursal, s.direccion;

-- 8. Mostrar el saldo medio y el interés medio de las cuentas a las que se le aplique un interés mayor del 2.5%, de las sucursales 1 y 2.
SELECT AVG(saldo) AS saldo_medio, AVG(interes) AS interes_medio
FROM Cuenta
WHERE interes > 2.5 
  AND cod_sucursal IN (1,2);

-- 9. Mostrar los tipos de movimientos de las cuentas bancarias, sus descripciones y el volumen total de dinero que se manejado en cada tipo de movimiento.
SELECT tm.cod_tipo_mov, tm.descripcion, 
	SUM(m.importe) AS volumen_total
FROM Tipo_movimiento tm
	JOIN Movimiento m ON tm.cod_tipo_mov = m.cod_tipo_mov
GROUP BY tm.cod_tipo_mov, tm.descripcion;

-- 10. Mostrar cuál es la cantidad media que sacan de cajero los clientes de nuestro banco.
-- Nota: Usamos LIKE para buscar la palabra 'Cajero' en la descripción si no sabemos el ID exacto.
SELECT AVG(m.importe) AS media_retiros
FROM Movimiento m
	JOIN Tipo_movimiento tm ON m.cod_tipo_mov = tm.cod_tipo_mov
WHERE tm.descripcion LIKE '%Cajero%';

-- 11. Calcular la cantidad total de dinero que emite la entidad bancaria clasificada según los tipos de movimientos de salida.
SELECT tm.descripcion, 
	SUM(m.importe) AS total_emitido
FROM Tipo_movimiento tm
	JOIN Movimiento m ON tm.cod_tipo_mov = m.cod_tipo_mov
WHERE tm.salida = 1 
GROUP BY tm.descripcion;

-- 12.
SELECT
IF(tm.salida = 1, 'Salida', 'Entrada') tipo,
	SUM(m.importe) as total_dinero
FROM tipo_movimiento tm
	JOIN movimiento m on tm.cod_tipo_mov = m.cod_tipo_mov
GROUP BY tm. salida;

-- 13. Calcular la cantidad total de dinero que sale de la entidad bancaria mediante cualquier movimiento de “salida”.
SELECT 
	SUM(m.importe) AS total_global_salidas
FROM Movimiento m
	JOIN Tipo_movimiento tm ON m.cod_tipo_mov = tm.cod_tipo_mov
WHERE tm.salida = 1;

-- 14. Mostrar la suma total por tipo de movimiento de las cuentas bancarias de los clientes del banco (apellidos, nombre, cod_cuenta, descripción y total).
SELECT cl.apellidos, cl.nombre, cu.cod_cuenta, tm.descripcion, 
	SUM(m.importe) AS total_acumulado
FROM Cliente cl
	JOIN Cuenta cu ON cl.cod_cliente = cu.cod_cliente
	JOIN Movimiento m ON cu.cod_cuenta = m.cod_cuenta
	JOIN Tipo_movimiento tm ON m.cod_tipo_mov = tm.cod_tipo_mov
GROUP BY cu.cod_cuenta, tm.cod_tipo_mov, cl.apellidos, cl.nombre, tm.descripcion;

-- 15. Contar el número de cuentas bancarias que no tienen asociados movimientos.
-- Usamos LEFT JOIN y filtramos donde la tabla de la derecha es NULL
SELECT 
	COUNT(*) AS cuentas_sin_movimientos
FROM Cuenta c
	LEFT JOIN Movimiento m ON c.cod_cuenta = m.cod_cuenta
WHERE m.cod_cuenta IS NULL;

-- 16. Por cada cliente, contar el número de cuentas bancarias que posee sin movimientos.
SELECT c.cod_cliente, COUNT(cu.cod_cuenta) AS num_cuentas_inactivas
FROM Cliente c
JOIN Cuenta cu ON c.cod_cliente = cu.cod_cliente
LEFT JOIN Movimiento m ON cu.cod_cuenta = m.cod_cuenta
WHERE m.cod_cuenta IS NULL
GROUP BY c.cod_cliente;

-- 17. Mostrar el código de cliente, la suma total del dinero de todas sus cuentas y el número de cuentas abiertas, sólo para aquellos clientes cuyo capital supere los 35.000 euros.
SELECT cod_cliente, SUM(saldo) AS capital_total, COUNT(*) AS num_cuentas
FROM Cuenta
GROUP BY cod_cliente
HAVING SUM(saldo) > 35000;

-- 18. Mostrar los apellidos, el nombre y el número de cuentas abiertas sólo de aquellos clientes que tengan más de 2 cuentas.
SELECT cl.apellidos, cl.nombre, COUNT(*) AS num_cuentas
FROM Cliente cl
JOIN Cuenta cu ON cl.cod_cliente = cu.cod_cliente
GROUP BY cl.cod_cliente, cl.apellidos, cl.nombre
HAVING COUNT(*) > 2;

-- 19. Mostrar sucursal, dirección, capital anterior y suma de saldos, sólo si la suma de saldos supera el capital anterior.
SELECT s.cod_sucursal, s.direccion, s.capital_anio_anterior, 
	SUM(c.saldo) AS suma_saldos_actual
FROM Sucursal s
	JOIN Cuenta c ON s.cod_sucursal = c.cod_sucursal
GROUP BY s.cod_sucursal, s.direccion, s.capital_anio_anterior
HAVING SUM(c.saldo) > s.capital_anio_anterior;

-- 20. Mostrar cuenta, saldo, tipo mov y suma por movimiento, sólo si la suma supera el 20% del saldo.
SELECT c.cod_cuenta, c.saldo, tm.descripcion, 
	SUM(m.importe) AS suma_movimiento
FROM Cuenta c
	JOIN Movimiento m ON c.cod_cuenta = m.cod_cuenta
	JOIN Tipo_movimiento tm ON m.cod_tipo_mov = tm.cod_tipo_mov
GROUP BY c.cod_cuenta, tm.cod_tipo_mov, c.saldo, tm.descripcion
HAVING SUM(m.importe) > (c.saldo * 0.20);

-- 21. Igual que el anterior pero suma > 10% saldo y NO sean de sucursal 4.
SELECT c.cod_cuenta, c.saldo, tm.descripcion, 
	SUM(m.importe) AS suma_movimiento
FROM Cuenta c
	JOIN Movimiento m ON c.cod_cuenta = m.cod_cuenta
	JOIN Tipo_movimiento tm ON m.cod_tipo_mov = tm.cod_tipo_mov
WHERE c.cod_sucursal != 4
GROUP BY c.cod_cuenta, tm.cod_tipo_mov, c.saldo, tm.descripcion
HAVING SUM(m.importe) > (c.saldo * 0.10);

-- 22. Clientes cuyo saldo en cuentas suponga al menos el 20% del capital de su sucursal.
-- Nota: Agrupamos por Cliente y Sucursal para comparar el total del cliente en ESA sucursal específica.
SELECT cl.cod_cliente, cl.nombre, cl.apellidos, s.cod_sucursal, 
	SUM(cu.saldo) AS saldo_cliente_sucursal, s.capital_anio_anterior
FROM Cliente cl
	JOIN Cuenta cu ON cl.cod_cliente = cu.cod_cliente
	JOIN Sucursal s ON cu.cod_sucursal = s.cod_sucursal
GROUP BY cl.cod_cliente, s.cod_sucursal, cl.nombre, cl.apellidos, s.capital_anio_anterior
HAVING SUM(cu.saldo) >= (s.capital_anio_anterior * 0.20);