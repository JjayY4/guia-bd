-- ============================================================
-- EJERCICIO 1: GESTIÓN DE TIENDA DE ELECTRODOMÉSTICOS
-- Base de Datos - Guía de Ejercicios No. 1
-- Universidad Don Bosco
-- ============================================================
-- Análisis de normalización:
--   La tabla de Excel original contiene datos redundantes (el nombre
--   del producto y su precio se repiten en cada línea de factura).
--   Para llevar esto a una base de datos normalizada (3FN) se separa en:
--
--   1. Productos: catálogo de electrodomésticos con su precio unitario.
--      Llave primaria: id_producto (formato código autogenerado).
--
--   2. Facturas: encabezado de cada venta, con su número de factura y fecha.
--      Llave primaria: id_factura (VARCHAR, formato 'F001', 'F002', etc.).
--
--   3. DetalleFactura: tabla intermedia que relaciona Facturas con Productos,
--      almacena la cantidad vendida y el subtotal por línea.
--      Llave primaria: id_detalle (autoincremental).
--      Llaves foráneas: id_factura -> Facturas, id_producto -> Productos.
--
--   Relaciones:
--     Facturas 1 ----> N DetalleFactura N <---- 1 Productos
--     (Una factura tiene muchos detalles, un producto puede aparecer en muchos detalles)
-- ============================================================

-- Creación de la base de datos
CREATE DATABASE TiendaElectrodomesticosDB;
GO

USE TiendaElectrodomesticosDB;
GO

-- ============================================================
-- Tabla: Productos
-- Almacena el catálogo de electrodomésticos disponibles.
-- ============================================================
CREATE TABLE Productos (
    id_producto INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL UNIQUE,
    precio DECIMAL(10,2) NOT NULL CHECK (precio > 0)
);

-- ============================================================
-- Tabla: Facturas
-- Almacena el encabezado de cada venta realizada.
-- El id_factura conserva el formato original (F001, F002, etc.)
-- ============================================================
CREATE TABLE Facturas (
    id_factura VARCHAR(10) PRIMARY KEY,
    fecha_venta DATE NOT NULL
);

-- ============================================================
-- Tabla: DetalleFactura
-- Relaciona cada factura con los productos vendidos.
-- Registra la cantidad de unidades y el subtotal por línea.
-- Llaves foráneas con ON DELETE CASCADE y ON UPDATE CASCADE
-- para mantener integridad referencial.
-- ============================================================
CREATE TABLE DetalleFactura (
    id_detalle INT PRIMARY KEY IDENTITY(1,1),
    id_factura VARCHAR(10) NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    subtotal DECIMAL(10,2) NOT NULL CHECK (subtotal >= 0),
    FOREIGN KEY (id_factura) REFERENCES Facturas(id_factura)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- ============================================================
-- Inserción de datos según la tabla de Excel proporcionada
-- ============================================================

-- Productos (extraídos sin duplicados de la tabla original)
INSERT INTO Productos (nombre, precio) VALUES
('Televisor',          450.00),
('Refrigeradora',      560.00),
('DVD',                250.00),
('Cocina',             290.75),
('Licuadora',           50.00),
('Extractor de jugo',   40.00),
('Reproductor MP3',     80.00),
('Equipo de sonido',   235.00);

-- Facturas (encabezados de venta)
INSERT INTO Facturas (id_factura, fecha_venta) VALUES
('F001', '2012-01-12'),
('F002', '2012-01-30'),
('F003', '2012-02-05');

-- DetalleFactura (líneas de cada factura)
-- Factura F001: Televisor x1, Refrigeradora x1, DVD x2
INSERT INTO DetalleFactura (id_factura, id_producto, cantidad, subtotal) VALUES
('F001', 1, 1,  450.00),   -- Televisor: $450.00 x 1 = $450.00
('F001', 2, 1,  560.00),   -- Refrigeradora: $560.00 x 1 = $560.00
('F001', 3, 2,  500.00);   -- DVD: $250.00 x 2 = $500.00
-- Total F001: $1,510.00

-- Factura F002: Cocina x3, Refrigeradora x1, Licuadora x2, Extractor de jugo x4
INSERT INTO DetalleFactura (id_factura, id_producto, cantidad, subtotal) VALUES
('F002', 4, 3,  872.25),   -- Cocina: $290.75 x 3 = $872.25
('F002', 2, 1,  560.00),   -- Refrigeradora: $560.00 x 1 = $560.00
('F002', 5, 2,  100.00),   -- Licuadora: $50.00 x 2 = $100.00
('F002', 6, 4,  160.00);   -- Extractor de jugo: $40.00 x 4 = $160.00
-- Total F002: $1,692.25

-- Factura F003: Reproductor MP3 x3, Equipo de sonido x1
INSERT INTO DetalleFactura (id_factura, id_producto, cantidad, subtotal) VALUES
('F003', 7, 3,  240.00),   -- Reproductor MP3: $80.00 x 3 = $240.00
('F003', 8, 1,  235.00);   -- Equipo de sonido: $235.00 x 1 = $235.00
-- Total F003: $475.00

-- ============================================================
-- Consulta combinada: reconstruye la vista original de Excel
-- Une las 3 tablas para mostrar toda la información de ventas
-- ============================================================
SELECT
    f.id_factura AS IdFactura,
    f.fecha_venta AS FechaVenta,
    p.nombre AS Producto,
    p.precio AS Precio,
    d.cantidad AS Unidades,
    d.subtotal AS Total
FROM DetalleFactura d
INNER JOIN Facturas f ON d.id_factura = f.id_factura
INNER JOIN Productos p ON d.id_producto = p.id_producto
ORDER BY f.id_factura, p.nombre;
