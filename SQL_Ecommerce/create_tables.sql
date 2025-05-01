
/*

Owner: Fabricio Di Palma
Objetivo: crear un database para simular un ecommerce
Fecha: Abril 2025

*/

--- Creo DATABASE e indico su uso ---


CREATE DATABASE ecommerce_db;
GO

USE ecommerce_db;
GO


-- Creo las tablas indicadas en el DER --

-- Tabla: Customer
CREATE TABLE Customer (
    ID_Customer      INT IDENTITY(1,1) PRIMARY KEY,
    Email            VARCHAR(50) NOT NULL,
    Nombre           VARCHAR(36) NOT NULL,
    Apellido         VARCHAR(36) NOT NULL,
    Sexo             CHAR(1) NOT NULL,
    Direccion        VARCHAR(50) NOT NULL,
    Fecha_Nacimiento DATE NOT NULL,
    Telefono         VARCHAR(20) NOT NULL    
)

-- Tabla: Category
CREATE TABLE Category (
    ID_Category        INT IDENTITY(1,1) PRIMARY KEY,
    Nombre_Categoria   VARCHAR(50) NOT NULL,
    Path_Categoria     VARCHAR(100) NOT NULL
)

-- Tabla: Item
CREATE TABLE Item (
    ID_Item            INT IDENTITY(1,1) PRIMARY KEY,
    Nombre             VARCHAR(50) NOT NULL,
    Descripcion        VARCHAR(50) NOT NULL,
    Precio             DECIMAL(10, 2) NOT NULL,
    Estado             CHAR(1) NOT NULL, -- Ej: 'A = Activo', 'B = Baja'
    Fecha_Publicacion  DATE NOT NULL,
    Fecha_Baja         DATE ,
    ID_Category        INT NOT NULL,
    ID_Customer        INT NOT NULL,
    FOREIGN KEY (ID_Category) REFERENCES Category(ID_Category),
    FOREIGN KEY (ID_Customer) REFERENCES Customer(ID_Customer)
)

-- Tabla: Orders 
CREATE TABLE Orders (
    ID_Order         INT IDENTITY(1,1) PRIMARY KEY,
    Fecha_Order      DATE NOT NULL,
    ID_Customer      INT NOT NULL,
    ID_Item          INT NOT NULL,
    Cantidad         INT NOT NULL,
    Precio_Unitario  DECIMAL(10, 2),
    Monto_Total      DECIMAL(10, 2),
    FOREIGN KEY (ID_Customer) REFERENCES Customer(ID_Customer),
    FOREIGN KEY (ID_Item) REFERENCES Item(ID_Item)
)