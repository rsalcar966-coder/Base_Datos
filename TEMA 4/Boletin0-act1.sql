drop database if exists academia_idiomas;
create database academia_idiomas;
use academia_idiomas;

create table profesores(
	DNI char(9) primary key,
	Nombre varchar(250),
	Apellido1 varchar(250),
	Apellido2 varchar(250),
	Direccion varchar(250),
	Titulo varchar(250),
	Gana decimal(7,2)
);

describe profesores;

create table cursos(
	Cod bigint primary key auto_increment,
	Nombre varchar(250) unique,
	Maximo_alumnos int,
    Fecha_inicio date,
    Fecha_fin date,
    Num_Horas int not null,
    DNI_profesores char(9), 
    constraint fk_cursos_profesores foreign key (DNI_profesores) references profesores(DNI)
);

describe cursos;

create table alumnos(
	DNI char(9) primary key,
	Nombre varchar(250),
	Apellido1 varchar(250),
	Apellido2 varchar(250),
	Direccion varchar(250),
	Sexo varchar(1),
	Fecha_nacimiento date,
    Cod_cursos bigint, 
	constraint fk_alumnos_cursos foreign key (Cod_cursos) references cursos(Cod)
);

describe alumnos;