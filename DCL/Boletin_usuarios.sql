-- 1. Con MySQL Workbench nos conectamos como root y tratamos de ver 
-- aquellos roles o privilegios que tenemos asignados.
show grants;  -- los mios
show grants for 'root'@'localhost'; -- los del usuario indicado "for"
select * from mysql.user;
select * from mysql.user where user = 'root'; -- consultando user
show grants for current_user(); -- Anidamos funcion a consulta

-- 2. Creamos un usuario llamado administrador al cual le 
-- vamos a conceder todos los privilegios. 
-- La contraseña de este usuario debe ser pass_admin 
create user 'administrador'@'%' identified by 'pass_admin';
create user 'administrador'@'localhost' identified by 'pass_admin';
grant all privileges on *.* to 'administrador'@'%' with grant option;
grant all privileges on *.* to 'administrador'@'localhost' with grant option;
select * from mysql.user where user = 'administrador'; -- Ver usuarios creados

-- 3. Ahora, cerramos sesión y nos conectamos con este nuevo 
-- usuario guardando su conexión 

-- 4. Mostramos un listado con todos los usuarios disponibles 
-- en el sistema y posteriormente sólo aquél que se encuentra 
-- conectado actualmente. 
select * from mysql.user;
select current_user();

-- 5. Muestra los permisos asociados al usuario conectado
-- a la base de datos  (ambos hacen lo mismo)
show grants for current_user(); 
show grants;

-- 6. Crea una tabla “Alumno” que contenga dos campos Identificador y nombre e 
-- introduce 5 registros 
-- quitamos, para probar, todos los permisos
revoke all privileges on *.* from 'administrador'@'%';
revoke all privileges, grant option from 'administrador'@'localhost';

-- se los vamos dando poco a poco
grant create on *.* to 'administrador'@'localhost';
grant insert on *.* to 'administrador'@'localhost';
grant select on *.* to 'administrador'@'localhost';
grant references on *.* to 'administrador'@'localhost';
grant create view on *.* to 'administrador'@'localhost';
grant drop on *.* to 'administrador'@'localhost';
flush privileges; -- actualizar permsios desde tabla user

-- 9. Quita a tu usuario los permisos para realizar consultas 
-- sobre la vista e intenta realizar una llamada a la vista anterior. 
revoke select on *.* from 'administrador'@'localhost';
grant select on prueba.comentarios_por_alumno to 'administrador'@'localhost';
grant select on prueba.* to 'administrador'@'localhost' with grant option;
grant alter on prueba.* to 'administrador'@'localhost' with grant option;

grant create user on *.* to 'administrador'@'localhost';