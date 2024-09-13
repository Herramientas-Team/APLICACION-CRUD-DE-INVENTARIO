/* Base de datos */
CREATE DATABASE InventarioDB;
USE InventarioDB;

/* Eliminar tablas existentes si existen */
DROP TABLE IF EXISTS FacturaProducto;
DROP TABLE IF EXISTS Factura;
DROP TABLE IF EXISTS Productos;
DROP TABLE IF EXISTS CategoriaProducto;
DROP TABLE IF EXISTS Clientes;
DROP TABLE IF EXISTS Usuario;
DROP TABLE IF EXISTS Rol;

/* Base de datos */
CREATE TABLE Usuarios (
    Id_cedula INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Contrasena VARCHAR(50)
);

/* Crear tabla Rol */
CREATE TABLE Rol (
    Id_rol INT PRIMARY KEY,
    Nombre_rol VARCHAR(30) NOT NULL
);
-- Insertar rol Administrador
INSERT INTO Rol (Id_rol, Nombre_rol) 
VALUES (1, 'Administrador');

-- Insertar rol Cajero
INSERT INTO Rol (Id_rol, Nombre_rol) 
VALUES (2, 'Cajero');

CREATE TABLE Cajero (
    Id_cajero INT PRIMARY KEY,
    Id_cedula INT,
    FOREIGN KEY (Id_cedula) REFERENCES Usuarios(Id_cedula)
);
-- Insertar usuario Cajero
INSERT INTO Usuario (Id_usuario, Nombre, Apellido, Contrasena, Id_rol) 
VALUES (1, 'Juan', 'Pérez', 'contrasenaCajero', 2


CREATE TABLE Administrador (
    Id_admin INT PRIMARY KEY,
    Id_cedula INT,
    FOREIGN KEY (Id_cedula) REFERENCES Usuarios(Id_cedula)
);
-- Insertar usuario Administrador
INSERT INTO Usuario (Id_usuario, Nombre, Apellido, Contrasena, Id_rol) 
VALUES (2, 'Jean', 'Píerre', 'contrasenaAdmin', 1);



CREATE TABLE Factura (
    Id_factura INT PRIMARY KEY,
    Monto_pagado DECIMAL(10,2),
    Metodo_pago VARCHAR(50),
    Fecha_factura DATE,
    Hora_factura TIME,
    Iva DECIMAL(10,2),
    Cedula_clientes INT,
    Id_cajero INT,
    Id_admin INT,
    FOREIGN KEY (Cedula_clientes) REFERENCES Clientes(Cedula_clientes),
    FOREIGN KEY (Id_cajero) REFERENCES Cajero(Id_cajero),
    FOREIGN KEY (Id_admin) REFERENCES Administrador(Id_admin)
);

CREATE TABLE Productos (
    Id_producto INT PRIMARY KEY,
    Nombre_producto VARCHAR(100),
    Precio DECIMAL(10,2),
    Stock INT,
    Id_categoria INT,
    Id_admin INT,
    FOREIGN KEY (Id_categoria) REFERENCES CategoriaProducto(Id_categoria),
    FOREIGN KEY (Id_admin) REFERENCES Administrador(Id_admin)
);

CREATE TABLE CategoriaProducto (
    Id_categoria INT PRIMARY KEY,
    Nombre_categoria VARCHAR(50),
    Descripcion TEXT,
    Id_admin INT,
    FOREIGN KEY (Id_admin) REFERENCES Administrador(Id_admin)
);

CREATE TABLE Clientes (
    Cedula_clientes INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Direccion VARCHAR(100),
    Telefono VARCHAR(20),
    Correo VARCHAR(100),
    Id_admin INT,
    FOREIGN KEY (Id_admin) REFERENCES Administrador(Id_admin)
);

INSERT INTO Clientes (Cedula_clientes, Nombre, Apellido, Direccion, Telefono, Correo)
VALUES 
(1234567890, 'Juan', 'Pérez', 'Calle 123', 9876543210, 'juan.perez@example.com'),
(2345678901, 'María', 'García', 'Avenida 456', 8765432109, 'maria.garcia@example.com'),
(3456789012, 'Pedro', 'López', 'Plaza Principal', 7654321098, 'pedro.lopez@example.com'),
(4567890123, 'Ana', 'Martínez', 'Callejón 789', 6543210987, 'ana.martinez@example.com'),
(5678901234, 'José', 'Rodríguez', 'Carrera 1011', 5432109876, 'jose.rodriguez@example.com'),
(6789012345, 'Laura', 'Sánchez', 'Calle 1213', 4321098765, 'laura.sanchez@example.com'),
(7890123456, 'Carlos', 'González', 'Avenida 1415', 3210987654, 'carlos.gonzalez@example.com'),
(8901234567, 'Marta', 'Díaz', 'Plaza 1617', 2109876543, 'marta.diaz@example.com'),
(9012345678, 'Andrés', 'Fernández', 'Calle 1819', 1098765432, 'andres.fernandez@example.com'),
(123456789, 'Sofia', 'Hernández', 'Avenida 2021', 9876543210, 'sofia.hernandez@example.com');
-----PROCEDIMIENTO INSERTAR CLIENTES
CREATE PROC SP_INSERTAR_CLIENTES
@ Id_cliente VARCHAR(20) PRIMARY KEY,
@Nombre Nvarchar(30),
@Apellido Nvarchar(30),	
@Direccion Nvarchar(50),
@Correo NVARCHAR(50),
@Telefono Nvarchar(50)
as
insert into Clientes(Cedula_clientes,Nombre,Apellido,Direccion,Correo,Telefono)
Values (@Cedula_clientes,@Nombre,@Apellido,@Correo,@Telefono,@Direccion)

DROP PROC SP_INSERTAR_CLIENTES



---PROCEDIMIENTOS ALMACENADOS DE LOS PRODUCTOS
--------------------------MOSTRAR 

DROP PROC IF EXISTS SP_MOSTRAR_PRODUCTOS;
GO

CREATE PROC SP_MOSTRAR_PRODUCTOS
AS
BEGIN
    SELECT 
        Id_producto AS Id, 
        Nombre_producto AS ProductoNombre, 
        Precio, 
        Stock, 
        Id_categoria, 
        Id_admin
    FROM Productos;
END
GO

--------------------------INSERTAR 
DROP PROC IF EXISTS InsertarProductos;
GO

CREATE PROC InsertarProductos
    @nombre_producto NVARCHAR(100),
    @precio DECIMAL(10,2),
    @stock INT,
    @id_categoria INT,
    @id_admin INT
AS
BEGIN
    INSERT INTO Productos (Nombre_producto, Precio, Stock, Id_categoria, Id_admin)
    VALUES (@nombre_producto, @precio, @stock, @id_categoria, @id_admin);
END
GO

------------------------ELIMINAR
DROP PROC IF EXISTS EliminarProducto;
GO

CREATE PROC EliminarProducto
    @id_producto INT
AS
BEGIN
    DELETE FROM Productos WHERE Id_producto = @id_producto;
END
GO
------------------EDITAR
DROP PROC IF EXISTS EditarProductos;
GO

CREATE PROC EditarProductos
    @nombre_producto VARCHAR(100),
    @precio DECIMAL(10,2),
    @stock INT,
    @id_producto INT
AS
BEGIN
    UPDATE Productos
    SET Nombre_producto = @nombre_producto,
        Precio = @precio,
        Stock = @stock
    WHERE Id_producto = @id_producto;
END
GO

--PROCEDIMIENTOS ALMACENADOS DE LAS CATEGORIAS
--INSERTAR
DROP PROC IF EXISTS InsertarCategoria;
GO

CREATE PROC InsertarCategoria
    @nombre_categoria VARCHAR(50),
    @descripcion TEXT,
    @id_admin INT
AS
BEGIN
    INSERT INTO CategoriaProducto (Nombre_categoria, Descripcion, Id_admin)
    VALUES (@nombre_categoria, @descripcion, @id_admin);
END
GO
--MOSTRAR
DROP PROC IF EXISTS MostrarCategorias;
GO

CREATE PROC MostrarCategorias
AS
BEGIN
    SELECT 
        Id_categoria AS Id,
        Nombre_categoria,
        Descripcion,
        Id_admin
    FROM CategoriaProducto;
END
--EDITAR
DROP PROC IF EXISTS EditarCategoria;
GO

CREATE PROC EditarCategoria
    @id_categoria INT,
    @nombre_categoria VARCHAR(50),
    @descripcion TEXT,
    @id_admin INT
AS
BEGIN
    UPDATE CategoriaProducto
    SET Nombre_categoria = @nombre_categoria,
        Descripcion = @descripcion,
        Id_admin = @id_admin
    WHERE Id_categoria = @id_categoria;
END
GO
-------------------------------------------------------------------------





