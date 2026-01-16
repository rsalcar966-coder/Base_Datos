-- 1. Crea un usuario global con una contraseña, bloqueado por defecto que este usuario sera administrador asi que tiene que terner todos los permisos posibles de manera global. (salguero y contraseña 123).
-- como root:
Create user 'salguero'@'%' identified by '123' account lock;
grant all privileges on *.* to 'salguero'@'%';
select * from mysql.user;

-- 2. Desbloquea al usuario, logueate con el usuario y que el usuario cambie su contraseña, muestra sus privilegios y muestra el usuario conectado en ese momento.
-- como root:
alter user 'salguero'@'%' account unlock;

-- como usuario salguero:
set password = 'salguero';
show grants for 'salguero'@'%';
show grants for current_user(); 

-- 3. El nuevo usuario tiene que crear el siguiente esquema de base de datos.
-- como usuario salguero:
drop database if exists fp_dual;
create database fp_dual;
use fp_dual;

create table Empresa(
    cif char(9) primary key,
    sede varchar(255),
    nombre varchar(255)
);
create table Alumno(
    id bigint primary key,
    nombre varchar(255),
    apellidos varchar(255)
);
create table forma(
    id_alumno bigint,
    cif_empresa char(9),
    es_dual boolean,
    fecha_convenio date,
    primary key (id_alumno, cif_empresa, fecha_convenio),
    constraint fk_alumno foreign key (id_alumno) references Alumno(id),
    constraint fk_empresa foreign key (cif_empresa) references Empresa(cif)
);


-- 4. El usuario que he creado anteriormente debe de crear 2 usuarios locales, uno de ellos escritor y 	el ecritor debe de crear 2 inserciones y el lector debe de mostrarlas
-- como root:
grant all privileges on *.* to 'salguero'@'%' with grant option;

-- como usuario ddiajim990:
Create user 'escritor'@'localhost' identified by '990';
Create user 'lector'@'localhost' identified by '990';
grant insert on fp_dual.* to 'escritor'@'localhost';
grant select on fp_dual.* to 'escritor'@'localhost';
grant select on fp_dual.* to 'lector'@'localhost';

-- como usuario escritor:
use fp_dual;
INSERT INTO Empresa (cif, sede, nombre) VALUES 
('A12345678', 'Madrid', 'Tech Solutions S.L.'),
('B87654321', 'Barcelona', 'Innovación Digital S.A.');

INSERT INTO Alumno (id, nombre, apellidos) VALUES 
(1, 'Juan', 'Pérez García'),
(2, 'María', 'López Fernández');

INSERT INTO forma (id_alumno, cif_empresa, es_dual, fecha_convenio) VALUES 
(1, 'A12345678', true, '2025-09-01'),
(2, 'B87654321', false, '2025-10-15');

-- como usuario lector:
use fp_dual;
select * from Empresa;
select * from Alumno;
select * from forma;

-- 5. Al usuario lector le damos permisos para crear vistas, este va a crear una vista que muestre toda la informacion almacenada de todas las tablas.
-- como usuario salguero:
grant create view, drop, select on fp_dual.* to 'lector'@'localhost';
flush privileges;

-- como usuario lector:
use fp_dual;
create or replace view vista_dual_completa as 
    select 
        a.id as id_alumno, 
        a.nombre as nombre_alumno, 
        a.apellidos, 
        e.nombre as nombre_empresa, 
        e.sede, 
        f.es_dual, 
        f.fecha_convenio
    from Alumno a, Empresa e, forma f
    where a.id = f.id_alumno 
    and e.cif = f.cif_empresa;

select * from vista_dual_completa;

-- 6. Quitale al administrador todos los privilegios y dejale solo que pueda hacer el select a la vista creada.
revoke all privileges, grant option from 'salguero'@'%';
grant select on fp_dual.vista_dual_completa to 'salguero'@'%';
show grants for 'salguero'@'%';