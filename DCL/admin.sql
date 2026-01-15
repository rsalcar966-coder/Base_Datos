select current_user();

drop database if exists prueba;
create database prueba;
use prueba;

create table alumno(
	id bigint primary key auto_increment, 
    nombre varchar(250) not null
);

insert into alumno (nombre) values 
	('Paco'),
    ('Pepe'),
    ('Maria'),
    ('Sara'),
    ('Carmen');
    
create table comentario (
	id bigint primary key auto_increment,
    comentario text,
    alumno bigint,
    constraint fk_comentario_alumno foreign key (alumno) references alumno(id) on delete cascade on update set null
);

insert into comentario (comentario, alumno) values
	('Me parece bien', 1),
    ('Me parece mal', 1),
    ('Me parece regular', 1);

insert into comentario (comentario, alumno) values
	('No se no contesto', 2);
    
select * from comentario;

select * from alumno;

create or replace view comentarios_por_alumno as 
	select 
		comentario.id as id_comentario, 
		comentario.comentario, 
        alumno.id as id_alumno, 
        alumno.nombre 
	from comentario, alumno 
    where comentario.alumno = alumno.id
;

select * from comentarios_por_alumno;

select * from alumno;
select * from comentario;

create user 'alumno'@'%' identified by 'pass_alum';
show grants;

grant select on prueba.* to 'alumno'@'%';
grant alter on prueba.* to 'alumno'@'%';

drop user 'alumno'@'%';