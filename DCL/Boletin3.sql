-- Creamos la base de datos y la tabla.
create database if not exists prueba;
use prueba;
create table if not exists tabla1 (id bigint primary key, dato varchar(255));

-- 1. Crea un usuario llamado usuario_test bloqueado por defecto.
create user 'usuario_test'@'localhost' identified by '1234' account lock;
select * from mysql.user;

-- 2. Asóciale permisos de consulta sobre la tabla “tabla1” que se encuentra en la base de
-- datos “prueba”.
grant select on prueba.tabla1 to 'usuario_test'@'localhost';
show grants for 'usuario_test2'@'localhost';
select * from mysql.user where user = 'usuario_test2';

-- 3. Ahora inicia sesión con este nuevo usuario y cambia su contraseña
alter user 'usuario_test2'@'localhost' account unlock;
-- como usuario_test
set password = '123';

-- 4. Cambia el nombre de dicho usuario añadiendo un 2 al final.
rename user 'usuario_test'@'localhost' to 'usuario_test2'@'localhost';
select * from mysql.user;

-- 5. Crea una vista llamada “info_tabla1” que haga una consulta simple sobre la “tabla1”
grant create view, drop on prueba.* to 'usuario_test2'@'localhost';
-- como usuario_test
create or replace view info_tabla1 as (select * from tabla1);

-- 6. Este usuario debe poder crear otro llamado “consulta_info” que tenga permisos de
-- consulta sobre la vista anterior
grant create user, select on *.* to 'usuario_test2'@'localhost' with grant option; -- Siempre permiso global
-- como usuario_test
grant insert on *.* to 'usuario_test2'@'localhost';


-- 7. Una vez crees la vista, muestra su contenido desde el usuario “cosnulta_info”.


-- 8. Una vez creada la vista y el usuario, quita los permisos que has tenido que otorgar al
-- usuario “usuario_test2” para poder crearlos y déjale solamente los de consulta sobre
-- “tabla” dados en el ejercicio 2. Prueba que esta acción se ha realizado
-- correctamente mostrando sus permisos.


-- 9. Ahora añade todos los privilegios posibles a ese usuario para cualquier tabla de
-- cualquier base de datos y vuelve a mostrar que la acción se ha realizado.


-- 10. Muestra ahora todos los usuarios del sistema y elimina el último creado.