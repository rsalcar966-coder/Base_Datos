-- Cabecera
drop database if exists examen_DDL;
create database examen_DDL;
use examen_DDL;

-- Ejercicio 1
create table empleado(
		id bigint primary key auto_increment,
    nombre varchar(250),
    salario decimal(6,2) -- Lo he puesto decimal ya que el sueldo puede quedarse en tantos euros con tantos centimos
);

-- describe Empleado;
    
create table pieza(
		id bigint primary key auto_increment,
    fecha_fabricacion date,
    marca varchar(250),
    modelo varchar(250)
);

-- describe Pieza;

create table vehiculo(
		num_bastidor int primary key,
    combustible varchar(250),
    marca varchar(250),
    modelo varchar(250)
);

-- describe Vehiculo;

create table propietario(
		dni char(9) primary key,
    nombre varchar(250),
    apellidos varchar(250),
    es_mayor_edad char(2),
	constraint chk_es_mayor_edad check (upper(es_mayor_edad) in ('SI','NO'))
);

-- describe Propetario;

create table arreglo(
		fecha date primary key,
    precio int,
    id_empleado bigint,
    id_pieza bigint,
    num_bastidor int,
    constraint fk_arreglo_empleado foreign key (id_empleado) references empleado(id),
    constraint fk_arreglo_pieza foreign key  (id_pieza) references pieza(id),
    constraint fk_arreglo_vehiculo foreign key (num_bastidor) references vehiculo(num_bastidor)
);

-- describe Arreglo;

-- Ejercicio 2, Requesitos a cumplir:
-- a. Se decide que el campo nombre del propetario sera clave alternativa.
alter table propietario
add constraint uk_propietario_nombre unique (nombre);

-- b. El combustible del vehículo sólo podrá ser Híbrido, Eléctrico, Enchufable.
alter table vehiculo
add constraint chk_combustible check (combustible in ('Híbrido','Eléctrico','Enchufable'));

-- c. Como máximo el salario de un empleado será de 2300 euros.
alter table empleado
add constraint chk_salario_max check (salario <= 2300);

-- d. Por defecto, los propietarios serán mayores de edad.
alter table propietario
modify es_mayor_edad char(2) default 'SI';

-- Ejercicio 3, Realiza los cambios oportunos para poder eliminar una pieza y realiza las consultas necesarias para eliminarla
alter table arreglo
drop foreign key fk_arreglo_pieza;

alter table arreglo
add constraint fk_arreglo_pieza foreign key (id_pieza) references pieza(id) on delete cascade;

delete from pieza where id = 1;

-- Ejercicio 4, Añade en la tabla vehiculo el campo cilindrada con valor por defecto 2000
alter table vehiculo
add column cilindrada int default 2000;

-- Ejercicio 5, Elimina el campo fecha_fabricacion de la tabla pieza
alter table pieza
drop column fecha_fabricacion;
