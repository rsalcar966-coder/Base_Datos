-- 1. Crear usuario formado con nuestro apellido con contraseña y que este: bloqueado por defecto y que ese usuario va ser administrador por lo cual hay que dar los maximos permisos posibles de forma global.
create user 'Salguero'@'%' identified by '123' account lock;
grant all privileges on *.* to 'Salguero'@'%' with grant option;

-- 2. Desbloquear al usuario, nos conectamos con dicho nuevo usuario, que ese usuario cambie la contraseña y mostrar los propios privilegios y mostramos el usuario conectado en ese momento.
alter user 'Salguero'@'%' account unlock;
alter user 'Salguero'@'%' identified by 'nuevo123';
show grants for 'Salguero'@'%';
select current_user();

-- 3. el nuevo usuario tiene que crear la siguiente tabla de base de datos de la pizarra DDL
-- Como Salguero 
drop database if exists practicas;
create database practicas;
use practicas;

create table alumno(
		id bigint primary key auto_increment,
	nombre varchar(255) not null unique,
	apellidos varchar(255)
);

create table empresa(
		CIF char(9) primary key,
	nombre varchar(255),
	sede varchar(255)
);

create table formacion(
	fecha_convenio date,
	es_dual boolean,
	id bigint,
	CIF char(9)
); 

-- 4. El usuario que hemos creado tiene que crear 2 mas: lector y escritor
-- Como Salguero
create user 'escritor'@'localhost' identified by '123';
create user 'lector'@'localhost' identified by '123';
grant insert on *.* to 'escritor'@'localhost';
grant select on *.* to 'lector'@'localhost';
flush privileges; -- desde tabla Salguero

-- 5. Usuario lector de crear una vista que muestre toda la informacion almacenada de la practicas
-- 6. Quitar al administrador todos los privilegios y le dajamos solo el privilegio de hacer select sobre la vista que acabamos de crear