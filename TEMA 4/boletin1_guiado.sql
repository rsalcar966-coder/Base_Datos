-- Cabecera
drop database if exists academia_idiomas;
create database academia_idiomas;
use academia_idiomas;

-- Ejercicio 1

create table Personas(
	Id bigint primary key auto_increment,
	DNI char(9) not null unique,
    Nombre varchar(250) unique,
    Apellido1 varchar(250),
    Apellido2 varchar(250),
    Direccion varchar(250)
);

create table Profesores(
	Id_persona bigint primary key,
    Titulo varchar(250),
    Gana decimal(7,2) not null,
    constraint fk_profesor_persona foreign key (Id_Persona) references Personas(Id)
);

describe Profesores;

create table Cursos(
	Cod bigint primary key auto_increment,
    Nombre varchar(250) unique,
    Max_alumnos int,
    Fecha_inicio date,
    Fecha_fin date,
    Num_horas int not null,
    Id_Profesor bigint,	
    constraint fk_curso_profesor foreign key (Id_Profesor) references Profesores(Id_Persona),
    constraint chk_fechas check (fecha_inicio < fecha_fin)
);

describe Cursos;

create table Alumnos(
	Id_persona bigint primary key,
    Sexo char(1), -- H o M
    Fecha_nacimiento date,
    Cod_curso bigint not null,
    constraint fk_alumnos_cursos foreign key (Cod_curso) references Cursos(Cod),
    constraint fk_alumno_persona foreign key (Id_Persona) references Personas(Id),
    constraint chk_sexo check (upper(sexo) in ('H','M'))
);

describe Alumnos;

-- Ejercicio 2

insert into personas (DNI, Nombre, Apellido1, Apellido2, Direccion) values 
	('76978084M', 'Juan', 'Arcos','Lopez', 'Puerta negra, 4'),
    ('50427865C', 'Maria', 'Oliva', 'Rubio', 'Juan Alfonso, 23'),
    ('99857929W', 'Sara', 'Lemes', 'Sancho', 'Calle Viento, 1');

insert into profesores (Id_persona, Titulo, Gana) values 
	(1, 'Ing. informatico', 7500),
    (2, 'Lda. Fil. Inglesa', 4900),
    (3, 'Magisterio', 6100);

select * from profesores;

insert into cursos (Nombre, Max_alumnos, Fecha_inicio, Fecha_fin, Num_horas, ID_Profesor) values 
	('Ingles Basico', 15, '2023-01-01','2023-10-01', 120, 2);
insert into cursos (Nombre, Num_horas, Fecha_inicio, ID_Profesor) values
    ('Admin Linux', 80, '2023-02-03', 1);

select * from cursos;
    
insert into personas (Nombre, Apellido1, Apellido2, DNI, Direccion) values 
	('Lucas', 'Manilva', 'Lopez', '23755174S','Alhamar, 4'),
    ('Antonia','Santos','Alcántara','03818863N','Maniqui, 21'),
    ('Manuel','Baños','Rioseco','33577501P','Jurel, 2'),
    ('José','Llorenete','Escueto','36107620','Jarcha, 5');

insert into alumnos (Id_persona, Sexo, Fecha_nacimiento, Cod_curso) values
	(4,'H','1970-01-01',1),
    (5,'M',null,2),
    (6,'H',null,2),
    (7,'H','1990-02-03',1);

select * from alumnos;

-- Ejercicio 3

insert into personas (Nombre, Apellido1, Apellido2, DNI, Direccion) values 
	('Sergio','Navas','Rental','12345678J', null);
    
-- insert into alumnos (Id_persona, sexo, Fecha_nacimiento, Cod_curso) values
-- 	(8,'P',null, null);

-- En esta ultima consulta el codigo de curso no puede ser nulo
-- Si corregimos el cod_curso saltaria la restriccion chk_sexo

-- Ejercicio 4

alter table profesores add edad int;
-- alter table profesores drop column edad;

select * from profesores;

-- Ejercicio 5

-- a)
-- Si previamente a esta instruccion existiesen profesores que la incumplen, no podria añadir el check
-- insert into personas(Nombre, Apellido1, Apellido2, DNI, Direccion) values('Daniel', 'San Juan', 'Martin', '81001535C','Las torres, 24');
-- select * from personas;
-- select * from profesores;
-- insert into profesores values (9,'Lengua Castellana', 1200, 86);
alter table profesores add constraint chk_edad check (edad >= 18 AND edad <= 65);
-- alter table profesores drop constraint chk_edad;

-- b)
alter table cursos add constraint chk_max_alum check (Max_alumnos >= 10);

-- c)
-- Con esto forzamos a que actualice aquellos registros que imcumplen el check que queremos introducir (No recomendado para entornos reales)
update cursos set Num_horas = 101 where Num_horas < 100;
alter table cursos add constraint chk_horas check (Num_horas > 100);

