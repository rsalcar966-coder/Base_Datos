SHOW GRANTS FOR CURRENT_USER();
create user 'administrador' identified by 'passadmin';
grant all privileges on *.* to 'administrador' with grant option;
