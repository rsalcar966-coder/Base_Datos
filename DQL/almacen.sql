drop database if exists almacen;
create database almacen;
use almacen,

create table almacen(
	id bigint primary key auto_increment,
    pruducto varvhar(250) not null,
    cantidad int default  0,
    cantidad_max int,
    fecha_comier date,
    precio_unit decimal(16,2),
    id_proveedor bigint
);

insert into almacen(producto, cantidad, cantidad_max, fecha_comer, precio_unit,id_proveedor ) values
	('Iphone', 12, 20, '2025-10-10', 850.5, 27),
	('Huawei Free Clips', 15, 30, '2026-09-15', 199.99, 27),
	('Google Pixel 8 Pro', 8, 15, '2025-12-01', 950.00, 28),
	('Xiaomi 13T Pro', 20, 40, '2025-09-20', 650.50, 29),
	('iPad Air 5', 10, 25, '2026-01-10', 599.00, 27),
	('MacBook Air M2', 5, 10, '2026-03-05', 1199.00, 27),
	('AirPods Pro 2', 30, 50, '2025-12-25', 249.99, 27),
	('Samsung Galaxy Tab S9', 7, 15, '2025-11-30', 799.50, 27),
	('Sony WH-1000XM5', 12, 25, '2026-02-14', 349.90, 30),
	('Cargador USB-C 20W', 100, 150, '2027-01-01', 19.99, 31),
	('Cable Lightning 1m', 80, 100, '2026-06-30', 14.50, 31),
	('Apple Watch Series 9', 9, 20, '2025-10-20', 449.00, 27),
	('Garmin Fenix 7', 4, 10, '2026-05-15', 699.99, 32),
	('OnePlus 11', 6, 15, '2025-08-15', 720.00, 29),
	('Motorola Edge 40', 14, 30, '2025-09-10', 499.99, 28),
	('Funda MagSafe Transp.', 50, 80, '2026-12-01', 35.00, 31),
	('PowerBank 10000mAh', 25, 50, '2027-02-20', 45.50, 30),
	('Kindle Paperwhite', 18, 35, '2026-04-12', 139.99, 33),
	('Asus ROG Phone 7', 3, 8, '2025-11-05', 1099.00, 29),
	('Chromecast con Google TV', 40, 60, '2026-07-20', 39.99, 28),
	('GoPro Hero 12', 11, 20, '2025-12-10', 449.99, 30);
    
-- Consultas:
    
-- Mostrar los elementos insertados 
select * from almacen;
    
-- Cuantos dias faltan para que se comercialicen los Huawei Free Clips
select timestampdiff(day, now(), fecha_comer)
from almacen
where producto = 'Huawei Free Clips';
    
-- Mostrar el nombre del producto y el redondeo entero de su precio
-- para aquellos adquiridos al proveedor apple (27) o que sea de algun 
-- otro proveedor pero que su precio supere los 500. Todos los productos que
-- se muestren deben cumplir que su cantidad sea inferior extrictamente a la
-- cantidad máxima que podemos almacenar de ellos.
select a.producto, round(a.precio_unit) precio
from almacen a
where (a.id_proveedor = 27 or a.precio_unit > 500)
	and a.cantidad < a.cantidad_max;
    
-- Muestra aquellos productos cuya cantidad maxima es un numero par
-- estan adqiridas a proveedores cuyo id se encuentran entre 20 y 30 
-- y su nombre contiene la i o la a.
select * 
from almacen
where cantidad_max % 2 = 0 
    and id_proveedor between 20 and 30 
    and (producto like '%i%' or producto like '%a%');

-- Muestra aquellos productos comercializados en 2024 cuya diferencia 
-- entre cantidad maxima y actual supera las 30 unidades o su precio
-- unitario es inferior a 500 para todos aquellos productos adquiridos
-- a los proveedores 27 o 29.
select * 
from almacen
where year(fecha_comer) = 2024 
and (cantidad_max - cantidad > 30 or precio_unit < 500)
and id_proveedor in (27,29);

-- Muestrame el producto mas caro
select *
from almacen
order by precio_unit desc
limit 1;

select max(precio_unit) from almacen;
select sum(precio_unit) from almacen;
select min(precio_unit) from almacen;
select avg(precio_unit) from almacen; -- media
select count(*) from almacen; 