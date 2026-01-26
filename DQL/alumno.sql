use gestion_deportiva;
describe persona;
insert into persona(dni, nombre,  apellidos, fecha_nac)
	values
		('12345678A','Ruben', 'Salguero', '2006-11-04');
	select * from persona;
    describe jugador;
    insert into jugador()
		values
			('20', 'Delantero Leon', '9', 1);
select * from jugador;
select * from equipo;

insert into patrocinador(nombre)
	values
		('Casa Paco');
select * from patrocinador;

update patrocinador set nombre = 'Casa Pepe' where id = 9;

describe partido;

insert into patrocina()
	values
		(11,9);
    
select * from patrocina;

select nombre from patrocinador where nombre not like 'p%';

select * from persona where datediff(now(), fecha_nac) / 365 > 20;

select concat_ws(' ', nombre, apellidos) as nombre_completo from persona where dni like '%G%'