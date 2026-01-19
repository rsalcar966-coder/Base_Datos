-- Para mostrar valores por pantalla (console.log.system.out.print)
SELECT 'Hola mundo'; -- varchar
SELECT 12; -- Entero
SELECT 12.43; -- Decimal
SELECT true; -- Booleanos

-- Operadores matematicos
SELECT 5 + 4 AS suma;
SELECT 10/2 as division;
SELECT 10 DIV 3 as division_entera;
SELECT 5, 'X', 26, 5 * 26 AS producto;
SELECT 5 % 3 as modulo;

-- Operadores comparacion
SELECT 1 = 1 as igualdad;
SELECT 2 <= 1 as menor_igual;
SELECT 3 > 2 as mayor;
SELECT 1 != 2 as distinto;
SELECT !(1 < 2) as negacion;

-- Operadores logicos (AND, OR, XOR, NOT)
SELECT false AND false;
SELECT false AND true;
SELECT true AND false;
SELECT true AND true;

SELECT false OR false;
SELECT false OR true;
SELECT true OR false;
SELECT true OR true;

SELECT false XOR false;
SELECT false XOR true;
SELECT true XOR false;
SELECT true XOR true;

SELECT NOT true;
SELECT NOT false;

-- Operadores especiales(IN, BETWEEN, LIKE, DISTINCT)
SELECT 5 IN (1,2,3,4);
SELECT 5 IN (1,2,3,4,5,6);
SELECT 5 NOT IN (1,2,3,4);

SELECT 5 BETWEEN 1 AND 6;
SELECT 5 NOT BETWEEN 1 AND 6;
SELECT 1 BETWEEN 1 AND 6;
SELECT 6 BETWEEN 1 AND 6;

SELECT 'Pepe' = 'pepe';
SELECT 'Juan Pedro' LIKE '%P%';

-- Algunas funciones
SELECT current_user();
SELECT current_date();
SELECT current_time();
SELECT NOW();
SELECT database();

SELECT UPPER('hola');
SELECT LOWER('HOlA');
SELECT LENGTH('ESTERNOCLEIDOMASTOIDEO');
SELECT CONCAT('Juan','Martin','Sanchez');
SELECT CONCAT_WS(' ','Juan','Martin','Sanchez');
SELECT UPPER(CONCAT('Juan','Martin','Sanchez'));
SELECT 'GIRAFARIG' = REVERSE('GIRAFARIG') as palindromo;
SELECT 'ISAACNORONCAASI' = REVERSE('ISAACNORONCAASI') as palindromo;
SELECT trim('    paco   y   santi '); -- quita espacios en blanco del principio y final
SELECT substring('ESTERNOCLEIDOMASTOIDEO',8,6); -- Corta la cadena a partir de 8, y devuelve los siguientes 6 elementos
SELECT LEFT('Juan',1); -- Porciones de cadena a la izquierda
SELECT RIGHT('Antonio',2); -- Porciones de cadena a la derecha
SELECT REPLACE('PACO-DE-LUCIA','-',' '); -- Sustituye coincidencias de - por espacios
SELECT REPLACE('PACO DE LUCIA','LUCIA','MARIA');
SELECT REPLACE('PACO DE LUCIA','A','O');

SELECT ROUND(RAND() * 10); -- Numeros aleatorios entre 0 y 10

SELECT ROUND(127.1283, 2);
SELECT ROUND(127.125,2);
SELECT truncate(127.1283,2);
SELECT ROUND(127.1253,2);
SELECT ROUND(127.9283);
SELECT truncate(127.2,0);
SELECT FLOOR(127.9);
SELECT CEIL(127.1);

SELECT ABS(-23);
SELECT SQRT(121);
SELECT POW(2,10);

SELECT DATEDIFF(NOW(), '1976-01-01') DIV 365;
SELECT YEAR(NOW()) as anyo;
SELECT MONTH(NOW()) as mes;
SELECT DAY(NOW()) as dia;

SHOW VARIABLES LIKE 'lc_time_names'; -- Esto no hay que aprenderselo
SET lc_time_names = 'es_ES'; -- Esto no hay que aprenderselo
SELECT DATE_FORMAT(NOW(),'Hoy es %W día %d de %M del %Y'); 

SELECT IF(1000 > 5000, 'Eres rico', 'Te aguantas');
SELECT IF(7500 > 5000, 'Eres rico', 'Te aguantas');