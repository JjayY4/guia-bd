CREATE DATABASE Ejercicio_3
GO

USE Ejercicio_3
GO

/* TABLAS */

CREATE TABLE Cliente(

Codigo VARCHAR(10) NOT NULL,
DUI VARCHAR(10) NOT NULL,
PrimerNombre VARCHAR(25) NOT NULL,
PrimerApellido VARCHAR(25) NOT NULL,
FechaNacimiento DATE,
Colonia VARCHAR(30),
Municipio VARCHAR(30)

)

CREATE TABLE Categoria(

Codigo VARCHAR(10) NOT NULL,
Descripcion VARCHAR(40)

)

CREATE TABLE Producto(

Codigo VARCHAR(10) NOT NULL,
NombreProducto VARCHAR(30),
Precio DECIMAL(10,2),
CodigoCategoria VARCHAR(10) NOT NULL

)

CREATE TABLE Compra(

CodigoCompra VARCHAR(10) NOT NULL,
CodigoCliente VARCHAR(10) NOT NULL,
CodigoProducto VARCHAR(10) NOT NULL,
Valor DECIMAL(10,2),
Fecha DATE

)

/* LLAVES PRIMARIAS */


ALTER TABLE Cliente
ADD CONSTRAINT PK_Cliente
PRIMARY KEY (Codigo)
GO

ALTER TABLE Categoria
ADD CONSTRAINT PK_Categoria
PRIMARY KEY (Codigo)
GO

ALTER TABLE Producto
ADD CONSTRAINT PK_Producto
PRIMARY KEY (Codigo)
GO

ALTER TABLE Compra
ADD CONSTRAINT PK_Compra
PRIMARY KEY (CodigoCompra)
GO

/* LLAVES FORANEAS */

ALTER TABLE Producto
ADD CONSTRAINT FK_Producto_Categoria
FOREIGN KEY (CodigoCategoria)
REFERENCES Categoria(Codigo)
GO

ALTER TABLE Compra
ADD CONSTRAINT FK_Compra_Cliente
FOREIGN KEY (CodigoCliente)
REFERENCES Cliente(Codigo)
GO

ALTER TABLE Compra
ADD CONSTRAINT FK_Compra_Producto
FOREIGN KEY (CodigoProducto)
REFERENCES Producto(Codigo)
GO

/* RESTRICCIONES */

ALTER TABLE Cliente
ADD CONSTRAINT UQ_Cliente_DUI
UNIQUE (DUI)
GO

ALTER TABLE Producto
ADD CONSTRAINT CK_Precio
CHECK (Precio > 0)
GO

ALTER TABLE Compra
ADD CONSTRAINT DF_FechaCompra
DEFAULT GETDATE() FOR Fecha
GO

/* REGISTROS */


/* CATEGORIA */

INSERT INTO Categoria VALUES ('CAT01','Electrodomesticos')
INSERT INTO Categoria VALUES ('CAT02','Tecnologia')
INSERT INTO Categoria VALUES ('CAT03','Ropa')
INSERT INTO Categoria VALUES ('CAT04','Hogar')
INSERT INTO Categoria VALUES ('CAT05','Juguetes')
INSERT INTO Categoria VALUES ('CAT06','Deportes')
INSERT INTO Categoria VALUES ('CAT07','Belleza')
INSERT INTO Categoria VALUES ('CAT08','Computacion')
INSERT INTO Categoria VALUES ('CAT09','Telefonia')
INSERT INTO Categoria VALUES ('CAT10','Audio')
INSERT INTO Categoria VALUES ('CAT11','Video')
INSERT INTO Categoria VALUES ('CAT12','Accesorios')
INSERT INTO Categoria VALUES ('CAT13','Muebles')
INSERT INTO Categoria VALUES ('CAT14','Cocina')
INSERT INTO Categoria VALUES ('CAT15','Herramientas')
INSERT INTO Categoria VALUES ('CAT16','Libros')
INSERT INTO Categoria VALUES ('CAT17','Mascotas')
INSERT INTO Categoria VALUES ('CAT18','Iluminacion')
INSERT INTO Categoria VALUES ('CAT19','Jardin')
INSERT INTO Categoria VALUES ('CAT20','Oficina')


/* CLIENTE */

INSERT INTO Cliente VALUES ('C01','12345678-1','Carmen','Morales','2000-05-10','Centro','San Salvador')
INSERT INTO Cliente VALUES ('C02','12345678-2','Maria','Lopez','1999-04-11','Escalon','San Salvador')
INSERT INTO Cliente VALUES ('C03','12345678-3','Ana','Valdez','1998-02-15','Soyapango','San Salvador')
INSERT INTO Cliente VALUES ('C04','12345678-4','Norberto','Colorado','2001-01-12','Apopa','San Salvador')
INSERT INTO Cliente VALUES ('C05','12345678-5','Mauricio','Muñoz','1997-08-10','Mejicanos','San Salvador')
INSERT INTO Cliente VALUES ('C06','12345678-6','Jose','Ramirez','1995-09-09','Ilopango','San Salvador')
INSERT INTO Cliente VALUES ('C07','12345678-7','Kevin','Beltran','2002-10-02','Santa Tecla','La Libertad')
INSERT INTO Cliente VALUES ('C08','12345678-8','Miguel','Flores','1996-07-07','Santa Ana','Santa Ana')
INSERT INTO Cliente VALUES ('C09','12345678-9','Josue','Garcia','2000-06-06','Ahuachapan','Ahuachapan')
INSERT INTO Cliente VALUES ('C10','12345678-0','Herberth','Cruz','1999-05-05','San Miguel','San Miguel')
INSERT INTO Cliente VALUES ('C11','22345678-1','Eduardo','Rivas','1998-04-04','Usulutan','Usulutan')
INSERT INTO Cliente VALUES ('C12','22345678-2','Daniel','Paniagua','1997-03-03','Chalatenango','Chalatenango')
INSERT INTO Cliente VALUES ('C13','22345678-3','Josue','Polanco','1996-02-02','La Union','La Union')
INSERT INTO Cliente VALUES ('C14','22345678-4','Xiomara','Mejia','1995-01-01','San Vicente','San Vicente')
INSERT INTO Cliente VALUES ('C15','22345678-5','Salmeron','Cruz','2001-11-11','Sonsonate','Sonsonate')
INSERT INTO Cliente VALUES ('C16','22345678-6','Kevin','Portillo','2000-12-12','La Paz','La Paz')
INSERT INTO Cliente VALUES ('C17','22345678-7','Carlos','Monje','1999-10-10','Morazan','Morazan')
INSERT INTO Cliente VALUES ('C18','22345678-8','Victor','Aguilar','1998-09-09','Cabanas','Cabanas')
INSERT INTO Cliente VALUES ('C19','22345678-9','Manuel','Flores','1997-08-08','Cuscatlan','Cuscatlan')
INSERT INTO Cliente VALUES ('C20','22345678-0','Jorge','Ortega','1996-07-07','San Salvador','San Salvador')


/* PRODUCTO */

INSERT INTO Producto VALUES ('P01','Laptop',1200,'CAT02')
INSERT INTO Producto VALUES ('P02','Refrigeradora',750,'CAT01')
INSERT INTO Producto VALUES ('P03','Camiseta',18,'CAT03')
INSERT INTO Producto VALUES ('P04','Televisor 55 pulgadas',650,'CAT11')
INSERT INTO Producto VALUES ('P05','iPhone 16 Pro Max',1400,'CAT09')
INSERT INTO Producto VALUES ('P06','Audifonos Samsung',90,'CAT10')
INSERT INTO Producto VALUES ('P07','Mouse',20,'CAT08')
INSERT INTO Producto VALUES ('P08','Teclado',35,'CAT08')
INSERT INTO Producto VALUES ('P09','Sofa',550,'CAT13')
INSERT INTO Producto VALUES ('P10','Licuadora',55,'CAT14')
INSERT INTO Producto VALUES ('P11','Taladro',120,'CAT15')
INSERT INTO Producto VALUES ('P12','La biblia de SQL',45,'CAT16')
INSERT INTO Producto VALUES ('P13','Juguete Carro',12,'CAT05')
INSERT INTO Producto VALUES ('P14','Bicicleta',280,'CAT06')
INSERT INTO Producto VALUES ('P15','Perfume',75,'CAT07')
INSERT INTO Producto VALUES ('P16','Lampara',40,'CAT18')
INSERT INTO Producto VALUES ('P17','Silla',65,'CAT13')
INSERT INTO Producto VALUES ('P18','Mesa',150,'CAT13')
INSERT INTO Producto VALUES ('P19','Maceta',30,'CAT19')
INSERT INTO Producto VALUES ('P20','Cuaderno',4,'CAT20')
INSERT INTO Producto VALUES ('P21','Escoba',10,'CAT04')
INSERT INTO Producto VALUES ('P22','Cable HDMI',8,'CAT12')
INSERT INTO Producto VALUES ('P23','Comida para perro',20,'CAT17')


/* COMPRA */

INSERT INTO Compra VALUES ('CO1','C01','P01',1200,GETDATE()) 
INSERT INTO Compra VALUES ('CO2','C02','P02',750,GETDATE()) 
INSERT INTO Compra VALUES ('CO3','C03','P03',18,GETDATE()) 
INSERT INTO Compra VALUES ('CO4','C04','P04',650,GETDATE())
INSERT INTO Compra VALUES ('CO5','C05','P05',1400,GETDATE()) 
INSERT INTO Compra VALUES ('CO6','C06','P06',90,GETDATE()) 
INSERT INTO Compra VALUES ('CO7','C07','P07',20,GETDATE()) 
INSERT INTO Compra VALUES ('CO8','C08','P08',35,GETDATE()) 
INSERT INTO Compra VALUES ('CO9','C09','P09',550,GETDATE()) 
INSERT INTO Compra VALUES ('CO10','C10','P10',55,GETDATE()) 
INSERT INTO Compra VALUES ('CO11','C11','P11',120,GETDATE()) 
INSERT INTO Compra VALUES ('CO12','C12','P12',45,GETDATE()) 
INSERT INTO Compra VALUES ('CO13','C13','P13',12,GETDATE()) 
INSERT INTO Compra VALUES ('CO14','C14','P14',280,GETDATE())
INSERT INTO Compra VALUES ('CO15','C15','P15',75,GETDATE()) 
INSERT INTO Compra VALUES ('CO16','C16','P16',40,GETDATE()) 
INSERT INTO Compra VALUES ('CO17','C17','P17',65,GETDATE()) 
INSERT INTO Compra VALUES ('CO18','C18','P18',150,GETDATE()) 
INSERT INTO Compra VALUES ('CO19','C19','P19',30,GETDATE()) 
INSERT INTO Compra VALUES ('CO20','C20','P20',4,GETDATE()) 

/* SUBCONSULTAS */

/* Para ver loss clientes que han comprado */

SELECT PrimerNombre
FROM Cliente
WHERE Codigo IN
(
SELECT CodigoCliente
FROM Compra
)

/* Para ver los productos que han sido comprados */

SELECT NombreProducto
FROM Producto
WHERE Codigo IN
(
SELECT CodigoProducto
FROM Compra
)

/* Para ver los productos con precio mayor al promedio */

SELECT NombreProducto, Precio
FROM Producto
WHERE Precio >
(
SELECT AVG(Precio)
FROM Producto
)

/* Para ver los clientes que compraron un producto específico */

SELECT PrimerNombre
FROM Cliente
WHERE Codigo IN
(
SELECT CodigoCliente
FROM Compra
WHERE CodigoProducto = 'P01'
)

/* Para ver las categorias que tienen productos */

SELECT Descripcion
FROM Categoria
WHERE Codigo IN
(
SELECT CodigoCategoria
FROM Producto
)

/* Vistas */

CREATE VIEW VistaComprasClientes
AS
SELECT C.PrimerNombre, P.NombreProducto, CO.Fecha
FROM Cliente C
JOIN Compra CO ON C.Codigo = CO.CodigoCliente
JOIN Producto P ON P.Codigo = CO.CodigoProducto
GO

CREATE VIEW VistaProductosCategoria
AS
SELECT P.NombreProducto, C.Descripcion
FROM Producto P
JOIN Categoria C
ON P.CodigoCategoria = C.Codigo
GO

CREATE VIEW VistaCompras
AS
SELECT CodigoCliente, CodigoProducto, Valor, Fecha
FROM Compra
GO

SELECT * FROM VistaComprasClientes

SELECT * FROM VistaProductosCategoria

SELECT * FROM VistaCompras

SELECT * FROM Cliente
SELECT * FROM Producto
SELECT * FROM Categoria
SELECT * FROM Compra