DROP DATABASE IF EXISTS gestion_empleados;
CREATE DATABASE gestion_empleados CHARACTER SET utf8mb4;
USE gestion_empleados;


-- Tabla UNIVERSIDAD
CREATE TABLE Universidad (
    Cod_univ INT PRIMARY KEY,
    Nombre VARCHAR(30) NOT NULL,
    Ciudad VARCHAR(20),
    Cod_postal CHAR(5)
);

-- Tabla TRABAJO 
CREATE TABLE Trabajo (
    Cod_trabajo INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(20) NOT NULL UNIQUE, 
    Salario_max DECIMAL(6,2) NOT NULL,
    Salario_min DECIMAL(6,2) NOT NULL
);

-- Tabla EMPLEADO 
CREATE TABLE Empleado (
    DNI CHAR(9) PRIMARY KEY,
    Nombre VARCHAR(20) NOT NULL,
    Apellido1 VARCHAR(20),
    Apellido2 VARCHAR(20),
    Direccion VARCHAR(20),
    Ciudad VARCHAR(20),
    Municipio VARCHAR(20),
    Cod_postal CHAR(5),
    Sexo CHAR(1),
    Fecha_nac DATE,
    -- Restricción Sexo: H o M (mayúsculas o minúsculas)
    CONSTRAINT ck_sexo CHECK (UPPER(Sexo) IN ('H', 'M'))
);

-- Tabla DEPARTAMENTO
CREATE TABLE Departamento (
    Cod_dpto INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(30) NOT NULL UNIQUE,
    DNI_jefe CHAR(9),
    Presupuesto DECIMAL(6,2) NOT NULL,
    -- Clave foránea al jefe
    CONSTRAINT fk_dpto_jefe FOREIGN KEY (DNI_jefe) REFERENCES Empleado(DNI)
);

-- Tabla ESTUDIO 
CREATE TABLE Estudio (
    DNI_empl CHAR(9),
    Cod_univ INT,
    Fecha_fin DATE,
    Titulo VARCHAR(30) NOT NULL,
    Especialidad VARCHAR(30),
    CONSTRAINT pk_estudio PRIMARY KEY (DNI_empl, Cod_univ, Titulo),
    CONSTRAINT fk_estudio_empl FOREIGN KEY (DNI_empl) REFERENCES Empleado(DNI) ON DELETE CASCADE,
    CONSTRAINT fk_estudio_univ FOREIGN KEY (Cod_univ) REFERENCES Universidad(Cod_univ)
);

-- Tabla HISTORIAL SALARIAL 
CREATE TABLE Historial_salarial (
    DNI_empl CHAR(9),
    Salario DECIMAL(6,2) NOT NULL,
    Fecha_inicio DATE NOT NULL,
    Fecha_fin DATE,
    CONSTRAINT pk_historial_salarial PRIMARY KEY (DNI_empl, Fecha_inicio),
    CONSTRAINT fk_hsal_empl FOREIGN KEY (DNI_empl) REFERENCES Empleado(DNI) ON DELETE CASCADE,
    -- Restricción de fechas cronológicas
    CONSTRAINT ck_fechas_sal CHECK (Fecha_fin IS NULL OR Fecha_fin >= Fecha_inicio)
);

-- Tabla HISTORIAL LABORAL 
CREATE TABLE Historial_laboral (
    DNI_empl CHAR(9),
    Cod_trabajo INT,
    Cod_dpto INT,
    Fecha_inicio DATE NOT NULL,
    Fecha_fin DATE,
    DNI_super CHAR(9),
    CONSTRAINT pk_historial_laboral PRIMARY KEY (DNI_empl, Cod_trabajo, Cod_dpto),
    CONSTRAINT fk_hlab_empl FOREIGN KEY (DNI_empl) REFERENCES Empleado(DNI) ON DELETE CASCADE,
    CONSTRAINT fk_hlab_trab FOREIGN KEY (Cod_trabajo) REFERENCES Trabajo(Cod_trabajo),
    CONSTRAINT fk_hlab_dpto FOREIGN KEY (Cod_dpto) REFERENCES Departamento(Cod_dpto),
    CONSTRAINT fk_hlab_super FOREIGN KEY (DNI_super) REFERENCES Empleado(DNI),
    -- Restricción de fechas cronológicas
    CONSTRAINT ck_fechas_lab CHECK (Fecha_fin IS NULL OR Fecha_fin >= Fecha_inicio)
);


-- 2a.Insertar registros inventados (3 por tabla) 

INSERT INTO Universidad VALUES 
(1, 'Universidad de Sevilla', 'Sevilla', '41004'),
(2, 'Universidad de Granada', 'Granada', '18010'),
(3, 'Universidad Complutense', 'Madrid', '28040');

INSERT INTO Trabajo (Nombre, Salario_max, Salario_min) VALUES 
('Programador', 2500.00, 1100.00),
('Analista', 3000.00, 1500.00),
('Director', 5000.00, 3000.00);

INSERT INTO Empleado VALUES 
('11111111A', 'Ana', 'Garcia', 'Lorca', 'Calle A', 'Sevilla', 'Sevilla', '41001', 'M', '1990-01-01'),
('22222222B', 'Beto', 'Perez', 'Ruiz', 'Calle B', 'Madrid', 'Madrid', '28001', 'H', '1985-05-05'),
('33333333C', 'Carla', 'Sanz', 'Diaz', 'Calle C', 'Valencia', 'Valencia', '46001', 'M', '1992-12-12');

INSERT INTO Departamento (Nombre, DNI_jefe, Presupuesto) VALUES 
('Desarrollo', '11111111A', 50000.00),
('Sistemas', '22222222B', 30000.00),
('Marketing', '33333333C', 20000.00);

INSERT INTO Historial_salarial VALUES
('11111111A', 1500.00, '2020-01-01', NULL),
('22222222B', 1800.00, '2019-06-01', NULL),
('33333333C', 2000.00, '2021-03-01', NULL);

-- Asumimos IDs generados: 1, 2, 3 para Trabajo y Departamento
INSERT INTO Historial_laboral VALUES
('11111111A', 1, 1, '2020-01-01', NULL, NULL),
('22222222B', 2, 2, '2019-06-01', NULL, '11111111A'),
('33333333C', 3, 3, '2021-03-01', NULL, '11111111A');


-- 2b.Intentar insertar registros con errores (Corregidos) 

-- Intento: SERGIO PALMA (Daría error por Sexo='P')
-- Corrección: Ponemos Sexo='H'
INSERT INTO Empleado (DNI, Nombre, Apellido1, Apellido2, Sexo, Fecha_nac) 
VALUES ('111222', 'Sergio', 'Palma', 'Entrena', 'H', '1995-05-05');

-- Intento: LUCIA ORTEGA (Necesaria para ser supervisora en el siguiente paso)
INSERT INTO Empleado (DNI, Nombre, Apellido1, Apellido2, Sexo) 
VALUES ('222333', 'Lucia', 'Ortega', 'Plus', 'M');

-- Intento: HISTORIAL LABORAL INCOMPLETO
-- El PDF da un insert con muchos nulos. Corregimos asignando Trabajo=1 y Dpto=1
INSERT INTO Historial_laboral (DNI_empl, Cod_trabajo, Cod_dpto, Fecha_inicio, Fecha_fin, DNI_super) 
VALUES ('111222', 1, 1, '1996-06-16', NULL, '222333');

-- Limpieza solicitada en el enunciado (Volver a eliminarlos)
DELETE FROM Historial_laboral WHERE DNI_empl = '111222';
DELETE FROM Empleado WHERE DNI IN ('111222', '222333');


-- 3a. Columna Dificultad (1-5)
ALTER TABLE Trabajo 
ADD COLUMN dificultad INT,
ADD CONSTRAINT ck_dificultad CHECK (dificultad BETWEEN 1 AND 5);

-- 3b. Campos Planta y Puerta en Departamento 
ALTER TABLE Departamento 
ADD COLUMN planta INT NOT NULL DEFAULT 0,
ADD COLUMN numero_puerta INT NOT NULL DEFAULT 1;

-- 3c. Restricción empleados de Sevilla (Fecha Nac NOT NULL) 
ALTER TABLE Empleado
ADD CONSTRAINT ck_sevilla_fechanac CHECK (
    (Ciudad <> 'Sevilla') OR (Fecha_nac IS NOT NULL)
);

-- 3d. Cambiar Municipio por Localidad 
ALTER TABLE Empleado CHANGE COLUMN Municipio Localidad VARCHAR(20);

-- 3e.Valores económicos no negativos 
ALTER TABLE Trabajo ADD CONSTRAINT ck_salario_trab_pos CHECK (Salario_max >= 0 AND Salario_min >= 0);
ALTER TABLE Historial_salarial ADD CONSTRAINT ck_salario_hist_pos CHECK (Salario >= 0);
ALTER TABLE Departamento ADD CONSTRAINT ck_presupuesto_pos CHECK (Presupuesto >= 0);

-- 3f.Eliminar restricción NOT NULL de Nombre 
ALTER TABLE Empleado MODIFY COLUMN Nombre VARCHAR(20) NULL;

-- 3g. Dirección hasta 50 caracteres 
ALTER TABLE Empleado MODIFY COLUMN Direccion VARCHAR(50);


-- 4a. Modificar Universidad para permitir borrado (ON DELETE SET NULL) 
-- Primero borramos la FK antigua y creamos la nueva
ALTER TABLE Estudio DROP FOREIGN KEY fk_estudio_univ;
ALTER TABLE Estudio 
ADD CONSTRAINT fk_estudio_univ 
FOREIGN KEY (Cod_univ) REFERENCES Universidad(Cod_univ) ON DELETE SET NULL;

-- Probamos eliminar una universidad (la 1)
DELETE FROM Universidad WHERE Cod_univ = 1;

-- 4b. Borrar tabla Universidad completa 
DELETE FROM Universidad;

-- 4c. Cambiar código de Universidad con actualización en cascada 
-- Insertamos una de prueba (porque borramos todo antes)
INSERT INTO Universidad VALUES (10, 'Uni Test', 'Test', '00000');
-- Modificamos la FK para soportar Cascade en Update
ALTER TABLE Estudio DROP FOREIGN KEY fk_estudio_univ;
ALTER TABLE Estudio ADD CONSTRAINT fk_estudio_univ 
FOREIGN KEY (Cod_univ) REFERENCES Universidad(Cod_univ) ON DELETE SET NULL ON UPDATE CASCADE;
-- Probamos el cambio
UPDATE Universidad SET Cod_univ = 20 WHERE Cod_univ = 10;

-- 4d. Eliminar empleado con datos en historiales 
-- Esto funciona directo porque pusimos ON DELETE CASCADE al crear las tablas
DELETE FROM Empleado WHERE DNI = '11111111A';


-- 5a. Tabla Información Universitaria 
CREATE TABLE Informacion_Universitaria AS
SELECT 
    CONCAT(IFNULL(e.Nombre,''), ' ', IFNULL(e.Apellido1,''), ' ', IFNULL(e.Apellido2,'')) AS Nombre_Completo,
    u.Nombre AS Universidad
FROM Empleado e
JOIN Estudio s ON e.DNI = s.DNI_empl
JOIN Universidad u ON s.Cod_univ = u.Cod_univ;

-- 5b. Campo Emp_juvenil y actualización 
ALTER TABLE Empleado ADD COLUMN Emp_juvenil BOOLEAN DEFAULT FALSE;

-- Desactivamos safe updates temporalmente para permitir update masivo
SET SQL_SAFE_UPDATES = 0;
UPDATE Empleado 
SET Emp_juvenil = TRUE 
WHERE Fecha_nac IS NOT NULL 
AND TIMESTAMPDIFF(YEAR, Fecha_nac, CURDATE()) < 30;
SET SQL_SAFE_UPDATES = 1;

-- 5c.Borrar todas las tablas del sistema 
-- (ADVERTENCIA: ESTO DEJARÁ LA BASE DE DATOS VACÍA AL FINAL DEL SCRIPT)
DROP TABLE IF EXISTS Historial_laboral;
DROP TABLE IF EXISTS Historial_salarial;
DROP TABLE IF EXISTS Estudio;
DROP TABLE IF EXISTS Departamento; 
DROP TABLE IF EXISTS Informacion_Universitaria;
DROP TABLE IF EXISTS Empleado;
DROP TABLE IF EXISTS Trabajo;
DROP TABLE IF EXISTS Universidad;