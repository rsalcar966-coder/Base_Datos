-- 1. 
SELECT e.nombre AS nombre_entrenador, COUNT(en.id_pokemon) AS total_pokemon
FROM entrenador e
JOIN entrenamiento en ON e.id_entrenador = en.id_entrenador
GROUP BY e.id_entrenador, e.nombre;

-- 2. 
SELECT p.nombre AS nombre_pokemon, r.nombre AS region, g.anyo_descubrimiento
FROM pokemon p
JOIN ciudad c ON p.originario = c.id_ciudad
JOIN region r ON c.region = r.id_region
JOIN generacion g ON r.id_region = g.region;

-- 3. 
SELECT p.nombre AS pokemon, e.nombre AS entrenador, 
       m1.nombre AS mov_1, m2.nombre AS mov_2, m3.nombre AS mov_3, m4.nombre AS mov_4
FROM pokemon p
JOIN entrenamiento en ON p.id_pokemon = en.id_pokemon
JOIN entrenador e ON en.id_entrenador = e.id_entrenador
JOIN set_movimientos sm ON p.set_movimientos = sm.id_set
LEFT JOIN movimiento m1 ON sm.mov_1 = m1.id
LEFT JOIN movimiento m2 ON sm.mov_2 = m2.id
LEFT JOIN movimiento m3 ON sm.mov_3 = m3.id
LEFT JOIN movimiento m4 ON sm.mov_4 = m4.id;

-- 4. 
SELECT t_fuerte.nombre AS tipo_que_gana
FROM tipo t_fuerte
JOIN vence_a v ON t_fuerte.id_tipo = v.tipo_fuerte
JOIN tipo t_debil ON v.tipo_debil = t_debil.id_tipo
WHERE t_debil.nombre = 'Planta';

-- 5. 
SELECT r.nombre AS region, AVG(g.num_entrenadores) AS media_entrenadores
FROM gimnasio g
JOIN ciudad c ON g.ciudad = c.id_ciudad
JOIN region r ON c.region = r.id_region
GROUP BY r.nombre;

-- 6.
SELECT nombre AS movimiento, precision_mov
FROM movimiento
ORDER BY precision_mov ASC
LIMIT 1;

-- 7. 
SELECT r.nombre AS region, COUNT(p.id_pokemon) AS total_pokemon
FROM pokemon p
JOIN ciudad c ON p.originario = c.id_ciudad
JOIN region r ON c.region = r.id_region
GROUP BY r.nombre;

-- 8. 
SELECT p.nombre AS pokemon
FROM pokemon p
JOIN tipo t ON p.tipo = t.id_tipo
JOIN ciudad c ON p.originario = c.id_ciudad
WHERE p.nombre LIKE 'V%' 
  AND t.nombre LIKE 'F%' 
  AND c.nombre LIKE '%O';

-- 9. 
SELECT DISTINCT p.nombre
FROM pokemon p
JOIN set_movimientos sm ON p.set_movimientos = sm.id_set
LEFT JOIN movimiento m1 ON sm.mov_1 = m1.id
LEFT JOIN movimiento m2 ON sm.mov_2 = m2.id
LEFT JOIN movimiento m3 ON sm.mov_3 = m3.id
LEFT JOIN movimiento m4 ON sm.mov_4 = m4.id
WHERE 'Placaje' IN (m1.nombre, m2.nombre, m3.nombre, m4.nombre);

-- 10. 
SELECT nombre
FROM pokemon
WHERE set_movimientos IS NULL;

-- 11. 
SELECT p.nombre, en.nivel
FROM entrenamiento en
JOIN pokemon p ON en.id_pokemon = p.id_pokemon
JOIN tipo t ON p.tipo = t.id_tipo
WHERE t.nombre != 'Fantasma' 
  AND en.velocidad <= en.ataque_esp
ORDER BY en.nivel DESC
LIMIT 10;

-- 12. 
SELECT DISTINCT habilidad
FROM entrenamiento;

-- 13. 
SELECT c.nombre AS ciudad, AVG(e.dinero) AS media_dinero
FROM entrenador e
JOIN ciudad c ON e.nacido_en = c.id_ciudad
WHERE e.id_entrenador NOT IN (
    SELECT en.id_entrenador
    FROM entrenamiento en
    JOIN pokemon p ON en.id_pokemon = p.id_pokemon
    WHERE p.nombre = 'Charizard'
)
GROUP BY c.nombre;

-- 14. 
SELECT r.nombre AS region, AVG(e.dinero) AS media_ahorros
FROM entrenador e
JOIN ciudad c ON e.nacido_en = c.id_ciudad
JOIN region r ON c.region = r.id_region
WHERE e.dinero > 1500
GROUP BY r.nombre;