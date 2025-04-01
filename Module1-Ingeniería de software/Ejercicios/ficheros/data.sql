CREATE DATABASE IF NOT EXISTS TiendaFrutas;
USE TiendaFrutas;


CREATE TABLE Clientes (
    cliente_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    direccion_facturacion VARCHAR(100),
    email VARCHAR(50),
    telefono VARCHAR(20)
);

CREATE TABLE Proveedores (
    proveedor_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(100),
    contacto VARCHAR(50),
    telefono VARCHAR(20),
    email VARCHAR(50)
);

CREATE TABLE Productos (
    producto_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    cantidad INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    unidad_medida VARCHAR(10)
);

CREATE TABLE Compras (
    compra_id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    fecha_compra DATE NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id)
        ON DELETE CASCADE
);

CREATE TABLE Detalle_Compra (
    detalle_compra_id INT PRIMARY KEY AUTO_INCREMENT,
    compra_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (compra_id) REFERENCES Compras(compra_id)
        ON DELETE CASCADE,
    FOREIGN KEY (producto_id) REFERENCES Productos(producto_id)
        ON DELETE CASCADE
);

CREATE TABLE Inventario (
    inventario_id INT PRIMARY KEY AUTO_INCREMENT,
    producto_id INT NOT NULL,
    fecha_ingreso DATE NOT NULL,
    cantidad_ingresada INT NOT NULL,
    proveedor_id INT NOT NULL,
    FOREIGN KEY (producto_id) REFERENCES Productos(producto_id)
        ON DELETE CASCADE,
    FOREIGN KEY (proveedor_id) REFERENCES Proveedores(proveedor_id)
        ON DELETE CASCADE
);


INSERT INTO Clientes (nombre, apellidos, direccion_facturacion, email, telefono) VALUES
('Juan', 'Pérez', 'Calle Falsa 123', 'juan.perez@example.com', '123456789'),
('María', 'Gómez', 'Avenida Siempreviva 742', 'maria.gomez@example.com', '987654321');


INSERT INTO Proveedores (nombre, direccion, contacto, telefono, email) VALUES
('Frutícola del Sur', 'Calle del Sur 45', 'José López', '555555555', 'contacto@fruticolasur.com'),
('Verduras y Frutas SA', 'Avenida Norte 32', 'Ana Martínez', '444444444', 'contacto@vyfsa.com');

INSERT INTO Productos (nombre, cantidad, precio, unidad_medida) VALUES
('Manzana', 150, 1.20, 'kg'),
('Plátano', 200, 0.80, 'kg'),
('Naranja', 180, 1.00, 'kg');


INSERT INTO Compras (cliente_id, fecha_compra, total) VALUES
(1, '2023-10-01', 12.00),
(2, '2023-10-02', 8.00);


INSERT INTO Detalle_Compra (compra_id, producto_id, cantidad, precio_unitario) VALUES
(1, 1, 10, 1.20),
(1, 2, 5, 0.80),
(2, 3, 8, 1.00);

-- Insertar inventario
INSERT INTO Inventario (producto_id, fecha_ingreso, cantidad_ingresada, proveedor_id) VALUES
(1, '2023-09-25', 150, 1),
(2, '2023-09-26', 200, 2),
(3, '2023-09-27', 180, 1);


