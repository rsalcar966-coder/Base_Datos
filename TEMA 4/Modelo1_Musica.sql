-- Cabecera fija
drop database if exists musica;
create database musica;
use musica;


-- Tabla artista
create table artista(
	id int primary key auto_increment,
    nombre varchar(200),
	nacionalidad varchar(200)
);


-- Tabla cancion
create table cancion(
	id int primary key auto_increment,
    nombre varchar(200),
    duracion time,
    fecha_lanzamiento date,
    artista int not null,
    constraint fk_cancion_artista foreign key (artista) references artista(id)
);

describe cancion;

create table colaboracion(
	artista int,
    cancion int,
    constraint pk_colab primary key (artista,cancion),
    constraint fk_artista foreign key (artista) references artista(id),
	constraint fk_cancion foreign key (cancion) references cancion(id)
);

describe colaboracion;

 -- Insertamos datos de prueba
 insert into artista (nombre, nacionalidad) values ('Paco Candela','Español');
 select * from artista;