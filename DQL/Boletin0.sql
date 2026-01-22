use Centro_educativo;

-- 1. Mostrar el nombre de las provincias
select nombre
from provincia;

-- 2. Mostrar nombre y apellidos de los alumnos
select nombre, apellidos
from alumno;

-- 2. Mostrar nombre y apellidos de los alumnos (todo en una misma columna llamada nombre_completo)
select concat_ws(nombre,' ', apellidos) as nombre_completo
from alumno;

select concat_ws(' ',nombre, apellidos) as nombre_completo
from alumno;

-- 3.  Mostrar el código y el nombre de todas las asignaturas
select *
from asignatura;

-- 4. Mostrar el DNI, nombre y apellidos de los profesores, ordenados por DNI ascendentemente
select dni, nombre, apellidos
from profesor
order by dni asc;

select dni, nombre, apellidos
from profesor
order by dni;

-- 5. Mostrar los datos de los alumnos de mayor a menor edad, de forma que en la columna 
-- de la fecha de nacimiento aparezca el encabezado “Fecha_de_nacimiento”
select id_alum, dni, nombre, apellidos, fecha_nac as fecha_de_nacimiento, nacido_en 
from alumno
order by fecha_nac asc;

-- 6. Mostrar los datos del alumno cuyo DNI es 56846315M
select *
from alumno
where dni = '56846315M';

-- Mostrar los datos del alumno cuyo DNI es 56846315 (Y si no conozco la letra)
select *
from alumno
where dni LIKE '56846315%';

-- 7. Mostrar los alumnos nacidos en las provincias cuyos códigos estén comprendidos entre 3 y 7.
select *
from alumnos
where nacido_en between 3 and 7;

-- 8. Mostrar los profesores nacidos en alguna de estas provincias: 1, 3, 5, 7.
select *
from profesor
where nacido_en in (1, 3, 5, 7);

-- 9. Mostrar los alumnos nacidos entre el 19/02/1980 y el 20/07/1984.
select *
from alumno
where fecha_nac between '1980-02-19' and '1984-07-20';

-- 10. Mostrar los registros de la tabla “Matriculado” del alumno 7.
select *
from matriculado
where id_alum = 7;

-- 11. Mostrar el nombre y apellidos de los alumnos mayores de 24 años.
select nombre, apellidos
from alumno
where DATEDIFF(NOW(), fecha_nac) DIV 365 > 24;

-- 12. Mostrar aquellos alumnos cuyo DNI contenga la letra ‘Y’.
select *
from alumno
where dni LIKE '%%%%%%%%Y';

select *
from alumno
where substring(dni, 9, 1) = 'Y';

-- 13. Mostrar aquellos alumnos cuyo nombre empiece por ‘S’.
select *
from alumno
where substring(nombre, 1, 1) = 'S';

-- 14. Mostrar el nombre de aquellos alumnos cuyo nombre contenga la letra ‘n’, ya sea mayúscula o minúscula.
select *
from alumno
where nombre LIKE '%n%';

-- 15. Mostrar el nombre de aquellos alumnos cuyo apellido contenga la letra ‘z’, mayúscula o minúscula.
select *
from alumno
where apellidos LIKE '%z%';

-- 16. Mostrar aquellos alumnos que tengan por primer nombre “Manuel”.
select *
from alumno
where nombre = 'Manuel';

-- 17. Mostrar aquellos alumnos que se llamen “Manuel” o “Cristina”.
select *
from alumno
where nombre in ('Manuel', 'Cristina');

select *
from alumno
where nombre = 'Manuel' or nombre = 'Cristina';

-- 18. Mostrar los datos de los alumnos cuyo DNI empiece por 2.
select *
from alumno
where dni LIKE '2%';

-- 19. Mostrar los identificadores de provincia en las que han nacido los alumnos, sin que estos identificadores se repitan.
select distinct nacido_en
from alumno;

-- 20. Mostrar la tabla de “Matriculado” y añadir una columna más que sea la media de las
-- tres notas de cada alumno, ordenados de la mejor nota a la peor.
select ID_ALUM, ID_ASIG, Nota1, Nota2, Nota3, round((Nota1 + Nota2 + Nota3)/3, 2) as media
from matriculado
order by media desc;

-- 21. Mostrar los registros de la tabla “Matriculado” en los que un alumno haya superado
-- los 3 exámenes de la asignatura 1.


-- 22. Mostrar los registros de la tabla “Matriculado” en los que un alumno haya sacado un
-- 10 en alguna de las 3 notas en cualquier asignatura.


-- 23. Mostrar aquellos registros de la tabla “Matriculado” en los que un alumno haya
-- superado alguno de los 3 exámenes de la asignatura 2.


-- 24. Mostrar los registros de la tabla “Matriculado” en los que un alumno haya superado
-- el primer examen ordenando los registros por “nota2” y “nota3” de menor a mayor para ambos campos.


-- 25. Mostrar aquellos alumnos nacidos en el 1985


-- 26. Mostrar los datos de los alumnos y además una columna calculada “mes” que
-- represente el mes en el que nació el alumno. Además se debe ordenar por dicha columna.


-- 27. Mostrar los datos de los alumnos y además una columna calculada “fecha_de_
-- nacimiento” que represente el día en el que nació el alumno con el siguiente formato
-- “Nacido el día xx del xx de xxxx”.


-- 28. Mostrar el nombre, apellidos y la edad de los alumnos


-- 29. Mostrar los datos de los alumnos y además una columna calculada “dias_vividos”
-- que represente los días que lleva vivido el alumno hasta la fecha de hoy.


-- 30. Mostrar el nombre y apellidos de los 4 alumnos con mayor edad.


-- 31. Contar el número de alumnos que hay en el centro educativo.


-- 32. Contar el número de profesores nacidos en la provincia 2 (Sevilla) que hay en el centro educativo.


-- 33. Mostrar la nota2 más alta de todas.


-- 34. Mostrar la nota1 más baja de la asignatura 1 (Redes)


-- 35. Mostrar el sumatorio de todas las notas1 de la asignatura 1 (Redes)


-- 36. Mostrar la suma de todas las notas1 de la asignatura 1 (Redes) fabricando una
-- columna llamada suma. Además, se deben añadir 2 columnas más que se
-- correspondan con el número de notas1 existentes y con el valor de la nota media.



