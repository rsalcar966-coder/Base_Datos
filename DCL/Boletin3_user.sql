use prueba;
create or replace view consulta_info as (select * from tabla1);

create user 'consulta_info'@'localhost' identified by 'info123';