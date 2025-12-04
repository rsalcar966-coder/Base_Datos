-- Cabecera
drop database if exists empresa_turistica;
create database empresa_turistica;
use empresa_turistica;

-- Paso 1
create table Proveedor(
	ID bigint primary key auto_increment,
	CIF char(9) not null unique,
    Nombre varchar(250) not null unique,
    Pais varchar(250),
    URL varchar(250) default 'www.default.es'
    );
    
    describe Proveedor;
    
    create table Agente(
	Cod_agente bigint primary key auto_increment,
    Nombre varchar(250) not null unique,
    Apellidos varchar(250),
    Telefono char(9),
    Tipo char(1) -- C o N
	constraint chk_tipo check (upper(tipo) in ('C','N'))
  );
    
    describe Agente;
    
	create table Booking(
	Localizador char(6) primary key,
    Fecha_checking date,
    Precio_coste decimal(5,2),
	Precio_venta decimal(5,2),
    ID_Proveedor bigint,
    Cod_Agente bigint,
    constraint fk_booking_proveedor foreign key (ID_Proveedor) references Proveedor(ID),
    constraint fk_booking_agente foreign key (Cod_Agente) references Agente(Cod_agente),
    constraint chk_precios check (precio_coste < precio_venta)
    );
    
    describe Booking;
    
    -- Paso 2
    insert into proveedor (ID, CIF, Nombre, Pais) values 
	(1, 'R5502108C', 'Jet2Travel', 'España'),
    (2, 'D76506849', 'Corendon', 'Turquia');
    
    select * from proveedor;
    
	insert into agente (Cod_agente, Nombre, Apellidos, Telefono, Tipo) values 
	(1, 'Eduardo', 'Ruiz Salvador', '953639337','C'),
    (2, 'Elisa', 'Caceres Pulido', '971408799','N');
    
    select * from agente;
    
	insert into booking (Localizador, Fecha_checking, Precio_coste, Precio_venta, ID_Proveedor, Cod_Agente) values 
	('ZN5DSC', '2022-10-19', '150.12', '299.90', '1', '1'),
    ('SF3XSR', '2022-12-30', '194.64', '275.00', '1', '2'),
    ('XL14LH','2023-04-06', '701.00', '881.50', '2', '1');
    
    select * from booking;
    
    -- Paso 3
	alter table booking drop constraint fk_booking_proveedor;
    alter table booking add constraint fk_booking_proveedor foreign key (ID_proveedor) references Proveedor(ID) on delete cascade; 
    
    -- Paso 5
    insert into agente (Cod_agente, Nombre, Apellidos, Telefono, Tipo) values 
	(3, 'ST', 'ST', '957779337','C');
     select * from agente;
     
	-- Paso 6
    DROP TABLE booking;
    DROP TABLE proveedor;  
	DROP TABLE agente;