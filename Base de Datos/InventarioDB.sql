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

/* Crear tabla Rol */
CREATE TABLE Rol (
    Id_rol INT PRIMARY KEY,
    Nombre_rol VARCHAR(30) NOT NULL
);

/* Crear tabla Usuario */
CREATE TABLE Usuario (
    Id_usuario INT PRIMARY KEY,
    Nombre VARCHAR(30),
    Apellido VARCHAR(30),
    Contrasena VARCHAR(30),
    Id_rol INT,
    FOREIGN KEY (Id_rol) REFERENCES Rol(Id_rol)
);

/* Crear tabla Clientes con la columna Id_cliente */
CREATE TABLE Clientes (
    Id_cliente VARCHAR(20) PRIMARY KEY,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Direccion VARCHAR(255),
    Telefono VARCHAR(20),
    Correo VARCHAR(50)
);

/* Crear tabla CategoriaProducto */
CREATE TABLE CategoriaProducto (
    Id_categoria INT PRIMARY KEY,
    Nombre_categoria VARCHAR(50),
    Descripcion VARCHAR(255),
	Precio Decimal (10,2),
	Cantidad Int

);

/* Crear tabla Productos sin la columna Precio */
CREATE TABLE Productos (
    Id_producto INT PRIMARY KEY,
    Nombre_producto VARCHAR(50),
    Stock INT,
    Id_categoria INT,
    FOREIGN KEY (Id_categoria) REFERENCES CategoriaProducto(Id_categoria)
);

/* Crear tabla Factura */
CREATE TABLE Factura (
    Id_factura INT PRIMARY KEY,
    Monto_pagado DECIMAL(10, 2),
    Metodo_pago VARCHAR(50),
    Fecha_factura DATE,
    Hora_factura TIME,
    Iva DECIMAL(10, 2),
    Id_cliente VARCHAR(20),
    Id_usuario INT,
    FOREIGN KEY (Id_cliente) REFERENCES Clientes(Id_cliente),
    FOREIGN KEY (Id_usuario) REFERENCES Usuario(Id_usuario)
);

/* Crear tabla FacturaProducto para la relación muchos a muchos con columnas Cantidad y Precio */
CREATE TABLE FacturaProducto (
    Id_factura INT,
    Id_producto INT,
    Cantidad INT,
    Precio DECIMAL(10, 2),
    PRIMARY KEY (Id_factura, Id_producto),
    FOREIGN KEY (Id_factura) REFERENCES Factura(Id_factura),
    FOREIGN KEY (Id_producto) REFERENCES Productos(Id_producto)
);
