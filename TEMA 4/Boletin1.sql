-- Cabecera
drop database if exists academia_idiomas;
create database academia_idiomas;
use academia_idiomas;

create table Profesores(
	DNI char(9) primary key,
    Nombre varchar(250),
    Apellido1 varchar(250),
    Apellido2 varchar(250),
    Direccion varchar(250),
    Titulo varchar(250),
    Gana decimal(7,2)
);

describe Profesores;

create table Cursos(
	Cod bigint primary key auto_increment,
    Nombre varchar(250),
    Max_alumnos int,
    Fecha_inicio date,
    Fecha_fin date,
    Num_horas int,
    DNI_Profesor char(9),
    constraint fk_curso_profesor foreign key (DNI_Profesor) references Profesores(DNI)
);
describe Cursos;

create table Alumnos(
	DNI char(9) primary key,
    Nombre varchar(250),
    Apellido1 varchar(250),
    Apellido2 varchar(250),
    Direccion varchar(250),
    Sexo char(1),
    Fecha_nacimiento date,
    Cod_curso bigint,
    constraint fk_alumnos_cursos foreign key (Cod_curso) references Cursos(Cod)
);

describe Alumnos;