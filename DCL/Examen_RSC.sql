-- 1. Crea un usuario llamado alumno que cumpla con los siguientes requisitos.
-- como root:
create user 'alumno'@'localhost' identified by '123' account lock;
grant all privileges on *.* to 'alumno'@'localhost' with grant option;
flush privileges;

-- 2. Ahora, debemos realizar las siguientes operaciones.
-- como root:
alter user 'alumno'@'localhost' account unlock;
alter user 'alumno'@'localhost' identified by 'nueva123';

-- como root:
show grants for 'alumno'@'localhost';

-- como usuario alumno:
select current_user();

-- 3. Con el usuario alumno, crea la siguiente estructura de datos en una base de datos llamada jardines.
-- como usuario alumno:
drop database if exists jardines;
create database jardines;
use jardines;

create table Jardin(
		id bigint primary key auto_increment,
    localidad varchar(255),
    nombre varchar(255),
    es_publico boolean
);

create table Flores(
		id bigint primary key auto_increment,
    nombre_comun varchar(255),
    nombre_cientifico varchar(255),
    color varchar(255)
);

-- 4. Con el usuario alumno crea los siguientes usuarios.
-- como usuario alumno:
create user 'insertador'@'%' identified by '123';
create user 'consultor'@'%' identified by '123';
create user 'visor'@'%' identified by '123';

grant insert on jardines.* to 'insertador'@'%';
grant select on jardines.* to 'consultor'@'%';
grant create view, select on jardines.* to 'visor'@'%';
flush privileges;

-- 5. Con cada usuario creado anteriormente.
-- como usuario insertador:
use jardines;
insert into Jardin (localidad, nombre, es_publico) values
('Madrid', 'Gran via', true),
('Sevilla', 'Plaza España', false);

insert into Flores (nombre_comun, nombre_cientifico, color) values
('Rosa', 'Rosa roja', 'Rojo'),
('Tulipán', 'Tulipán raro', 'Amarillo');

-- como usuario consultor:
use jardines;
select * from Jardin;
select * from Flores;

-- como usuario visor:
use jardines;
create or replace view vista_jardines_flores as
select 
    j.id as id_jardin,
    j.nombre as nombre_jardin,
    j.localidad,
    j.es_publico,
    f.id as id_flor,
    f.nombre_comun,
    f.nombre_cientifico,
    f.color
from Jardin j, Flores f;

select * from vista_jardines_flores;

-- 6. Quita todos los permisos al usuario alumno. Dale solo el permiso de borrado sobre la vista creada anteriormente y bórrala.
-- como root:
revoke all privileges, grant option from 'alumno'@'localhost';
grant drop on jardines.vista_jardines_flores to 'alumno'@'localhost';
flush privileges;

-- como usuario alumno:
use jardines;
drop view vista_jardines_flores;

-- 7. Quita uno a uno los permisos que no sean CREATE VIEW para el usuario visor y posteriormente elimínalo completamente.
-- como root:
revoke select on jardines.* from 'visor'@'%';
flush privileges;

drop user 'visor'@'%';

select user, host from mysql.user;