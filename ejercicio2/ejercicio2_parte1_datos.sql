USE EjercicioDosEmpresa;
GO

-- 1. INSERTAR DEPARTAMENTOS
INSERT INTO Departamentos (codigo_departamento, nombre_departamento)
VALUES 
('DP1', 'Informática'),
('DP2', 'Financiero'),
('DP3', 'Recursos Humanos'),
('DP4', 'Administración'),
('DP5', 'Marketing');
GO

-- 2. INSERTAR PROYECTOS
-- El formato de fecha seguro en SQL Server es YYYY-MM-DD.
-- Se asigna el código de departamento principal al que pertenece el proyecto.
INSERT INTO Proyectos (codigo_proyecto, nombre_proyecto, fecha_inicio, fecha_finalizacion, presupuesto, codigo_departamento)
VALUES 
('PR1', 'Llevar control de ventas de las empresa Nuevo Horizonte', '2015-11-12', '2016-05-05', 13679.00, 'DP1'),
('PR2', 'Llevar el control de los suministros de los deptos.', '2015-03-03', '2016-04-12', 5900.00, 'DP2'),
('PR3', 'Controlar las cuentas de la empresa', '2015-01-01', '2016-02-12', 3800.00, 'DP2');
GO

-- 3. INSERTAR EMPLEADOS
-- Los DUI respetan exactamente el formato de 7 dígitos y 1 guion.
INSERT INTO Empleados (codigo_empleado, nombre, apellido, DUI, salario, cargo, codigo_departamento)
VALUES 
('EM01', 'Jorge', 'Pérez', '1256897-1', 1500.00, 'Coordinador', 'DP1'),
('EM02', 'María', 'Morales', '7648975-9', 850.00, 'Desarrollador', 'DP1'),
('EM03', 'Julieta', 'Vargas', '3452190-8', 550.00, 'Secretaria', 'DP1'),
('EM04', 'Juan', 'Pineda', '5634980-1', 1700.00, 'Coordinador', 'DP2'),
('EM05', 'Karla', 'Pérez', '4539087-5', 890.00, 'Contador', 'DP2'),
('EM06', 'Mario', 'Rodríguez', '6723109-4', 750.00, 'Auxiliar Contable', 'DP2'),
('EM07', 'Felipe', 'Torres', '4567908-6', 950.00, 'Contador', 'DP2'),
('EM08', 'Claudia', 'Montoya', '1235687-7', 550.00, 'Secretaria', 'DP2'),
('EM09', 'Vanessa', 'Linares', '2309116-0', 1000.00, 'Coordinador', 'DP3'),
('EM10', 'Camila', 'Fuentes', '9873450-6', 550.00, 'Secretaria', 'DP3'),
('EM11', 'Roberto', 'Martínez', '2956678-6', 1200.00, 'Director', 'DP4'),
('EM12', 'Teresa', 'Saravia', '3749876-4', 550.00, 'Secretaria', 'DP4'),
('EM13', 'Luis', 'Aguilar', '6572345-7', 1000.00, 'Coordinador', 'DP5');
GO

-- 4. INSERTAR ASIGNACIONES DE PROYECTOS (N:M)
-- Se insertan únicamente las relaciones de empleados que tienen un proyecto asignado en la tabla de origen.
-- Se utiliza GETDATE() para registrar el momento actual como fecha de asignación.
INSERT INTO Asignacion_Proyectos (codigo_empleado, codigo_proyecto, fecha_asignacion)
VALUES 
('EM01', 'PR1', GETDATE()),
('EM02', 'PR1', GETDATE()),
('EM04', 'PR2', GETDATE()),
('EM05', 'PR3', GETDATE()),
('EM06', 'PR3', GETDATE()),
('EM07', 'PR1', GETDATE()),
('EM11', 'PR3', GETDATE()),
('EM13', 'PR1', GETDATE());
GO

PRINT 'Datos insertados correctamente en EmpresaProyectosDB.';
GO