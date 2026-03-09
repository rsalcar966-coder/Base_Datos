-- 1. Creación de tablas mediante consultas:
-- a. Crea una tabla llamada reintegros con aquellos movimientos de tipo
-- “Retirada cajero”
CREATE TABLE reintegros AS
SELECT m.*
FROM movimiento m
JOIN tipo_movimiento t 
ON m.cod_tipo_mov = t.cod_tipo_mov
WHERE t.descripcion = 'Retirada cajero';

-- 2. Inserción de datos en base al resultado de consultas:
-- a. Crea la tabla cuentas_clientes y almacena el nombre del cliente, el código de
-- la cuenta y el saldo de la misma.
CREATE TABLE cuentas_clientes AS
SELECT c.nombre, cu.cod_cuenta, cu.saldo
FROM Cliente c
JOIN Cuenta cu 
USING (cod_cliente);

-- 3. Eliminación y modificación de datos en base a subconsultas.
-- a. Elimina los clientes sin cuentas
DELETE FROM Cliente
WHERE cod_cliente NOT IN (
    SELECT cod_cliente
    FROM Cuenta
);

-- 4. Modificación de datos referenciados.
-- a. Modifica el ID de un cliente que tenga cuentas asociadsa. Debes de poder
-- hacerlo, para ello decide cómo va a implicar esto en el resto de tablas donde
-- se referencia dicho ID.
UPDATE Cuenta
SET cod_cliente = 100
WHERE cod_cliente = 1;
