USE EjercicioDosEmpresa;
GO

-- a. Obtener los empleados en donde el apellido comience con la letra P
SELECT * FROM Empleados 
WHERE apellido LIKE 'P%';
GO

-- b. Mostrar el número de empleados por cada departamento
SELECT d.nombre_departamento, COUNT(e.codigo_empleado) AS NumeroEmpleados 
FROM Departamentos d 
LEFT JOIN Empleados e ON d.codigo_departamento = e.codigo_departamento 
GROUP BY d.nombre_departamento;
GO

-- c. Obtener el presupuesto total de los proyectos que pertenecen a cada departamento
SELECT d.nombre_departamento, SUM(p.presupuesto) AS PresupuestoTotal 
FROM Departamentos d 
JOIN Proyectos p ON d.codigo_departamento = p.codigo_departamento 
GROUP BY d.nombre_departamento;
GO

-- d. Mostrar el nombre, apellido del empleado junto con el nombre del departamento al cual este pertenece
SELECT e.nombre, e.apellido, d.nombre_departamento 
FROM Empleados e 
JOIN Departamentos d ON e.codigo_departamento = d.codigo_departamento;
GO

-- e. Mostrar los empleados y los nombres de los proyectos a los cuales están asignados
SELECT e.nombre, e.apellido, p.nombre_proyecto 
FROM Empleados e 
JOIN Asignacion_Proyectos ap ON e.codigo_empleado = ap.codigo_empleado 
JOIN Proyectos p ON ap.codigo_proyecto = p.codigo_proyecto;
GO

-- f. Mostrar los empleados que no tienen asignado un proyecto
-- Se utiliza LEFT JOIN para encontrar los registros en Empleados que no cruzan con Asignacion_Proyectos
SELECT e.nombre, e.apellido 
FROM Empleados e 
LEFT JOIN Asignacion_Proyectos ap ON e.codigo_empleado = ap.codigo_empleado 
WHERE ap.codigo_proyecto IS NULL;
GO

-- g. Obtener los nombres de los departamentos que tienen más de dos empleados
SELECT d.nombre_departamento 
FROM Departamentos d 
JOIN Empleados e ON d.codigo_departamento = e.codigo_departamento 
GROUP BY d.nombre_departamento 
HAVING COUNT(e.codigo_empleado) > 2;
GO

-- h. Mostrar cuantas secretarias hay por cada departamento
SELECT d.nombre_departamento, COUNT(e.codigo_empleado) AS TotalSecretarias 
FROM Departamentos d 
JOIN Empleados e ON d.codigo_departamento = e.codigo_departamento 
WHERE e.cargo = 'Secretaria' 
GROUP BY d.nombre_departamento;
GO

-- i. Obtener el proyecto que tiene el mayor presupuesto asignado
SELECT TOP 1 nombre_proyecto, presupuesto 
FROM Proyectos 
ORDER BY presupuesto DESC;
GO

-- j. Mostrar la suma de salarios por cada departamento y ordenarlos de mayor a menor
SELECT d.nombre_departamento, SUM(e.salario) AS SumaSalarios 
FROM Departamentos d 
JOIN Empleados e ON d.codigo_departamento = e.codigo_departamento 
GROUP BY d.nombre_departamento 
ORDER BY SumaSalarios DESC;
GO

---------------------------------------
-- CREACIÓN DE 5 CONSULTAS DE ACTUALIZACIÓN


-- 1. Actualizar el salario de todos los empleados con cargo 'Secretaria', dándoles un aumento del 10%
UPDATE Empleados 
SET salario = salario * 1.10 
WHERE cargo = 'Secretaria';
GO

-- 2. Modificar la fecha de finalización del proyecto con código 'PR1'
UPDATE Proyectos 
SET fecha_finalizacion = '2016-06-30' 
WHERE codigo_proyecto = 'PR1';
GO

-- 3. Trasladar al empleado 'EM03' (Julieta Vargas) al departamento de 'Recursos Humanos' (DP3)
UPDATE Empleados 
SET codigo_departamento = 'DP3' 
WHERE codigo_empleado = 'EM03';
GO

-- 4. Corregir el nombre del departamento 'Informática' a 'Tecnologías de la Información'
UPDATE Departamentos 
SET nombre_departamento = 'Tecnologías de la Información' 
WHERE codigo_departamento = 'DP1';
GO

-- 5. Aumentar el presupuesto en $500 para todos los proyectos que iniciaron en el año 2015
UPDATE Proyectos 
SET presupuesto = presupuesto + 500 
WHERE YEAR(fecha_inicio) = 2015;
GO

-----------------------------------
-- CREACIÓN DE 5 CONSULTAS DE ELIMINACIÓN

-- 1. Eliminar únicamente la asignación del empleado 'EM01' al proyecto 'PR1' (Tabla intermedia)
DELETE FROM Asignacion_Proyectos 
WHERE codigo_empleado = 'EM01' AND codigo_proyecto = 'PR1';
GO

-- 2. Dar de baja (eliminar) a la empleada con código 'EM12' (Teresa Saravia)
DELETE FROM Empleados 
WHERE codigo_empleado = 'EM12';
GO

-- 3. Borrar todos los proyectos cuyo presupuesto actual sea menor a $4000
DELETE FROM Proyectos 
WHERE presupuesto < 4000;
GO

-- 4. Eliminar las asignaciones de proyectos de todos los empleados con cargo 'Director'
-- Requiere una subconsulta porque el cargo está en la tabla Empleados, no en Asignacion_Proyectos
DELETE FROM Asignacion_Proyectos 
WHERE codigo_empleado IN (SELECT codigo_empleado FROM Empleados WHERE cargo = 'Director');
GO

-- 5. Eliminar el departamento de 'Administración' (DP4)
-- NOTA: Por el ON DELETE CASCADE, esto también elimina a todos los empleados de ese departamento.
DELETE FROM Departamentos 
WHERE codigo_departamento = 'DP4';
GO