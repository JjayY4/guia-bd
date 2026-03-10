
-- 1. CREACIÓN DE LA BASE DE DATOS
USE master;
GO


CREATE DATABASE EjercicioDosEmpresa;
GO

USE EjercicioDosEmpresa;
GO

-- 2. CREACIÓN DE TABLAS Y CONSTRAINTS

-- TABLA: DEPARTAMENTOS
-- Entidad Fuerte (Independiente)
CREATE TABLE Departamentos (
    -- Código único, inicia con DP seguido de números
    codigo_departamento VARCHAR(10) PRIMARY KEY 
        CONSTRAINT CK_Depto_Codigo CHECK (codigo_departamento LIKE 'DP[0-9]%'),
    
    nombre_departamento VARCHAR(100) NOT NULL 
        CONSTRAINT UQ_Depto_Nombre UNIQUE
);
GO

-- TABLA: PROYECTOS
-- Relación 1:N con Departamento (Un departamento tiene varios proyectos)
CREATE TABLE Proyectos (
    -- Código único, inicia con PR seguido de números
    codigo_proyecto VARCHAR(10) PRIMARY KEY 
        CONSTRAINT CK_Proyecto_Codigo CHECK (codigo_proyecto LIKE 'PR[0-9]%'),
    
    nombre_proyecto VARCHAR(200) NOT NULL 
        CONSTRAINT UQ_Proyecto_Nombre UNIQUE,
    
    fecha_inicio DATE NOT NULL,
    fecha_finalizacion DATE NULL,
    
    presupuesto DECIMAL(12, 2) NOT NULL 
        CONSTRAINT CK_Proyecto_Presupuesto CHECK (presupuesto >= 0),
    
    codigo_departamento VARCHAR(10) NOT NULL,

    -- Llave foránea con reglas de Cascada
    CONSTRAINT FK_Proyecto_Depto FOREIGN KEY (codigo_departamento)
        REFERENCES Departamentos(codigo_departamento)
        ON UPDATE CASCADE 
        ON DELETE CASCADE,

    -- Restricción de fechas lógicas
    CONSTRAINT CK_Proyecto_Fechas CHECK (fecha_finalizacion >= fecha_inicio)
);
GO

-- TABLA: EMPLEADOS
-- Relación 1:N con Departamento (Un empleado pertenece a un departamento)
CREATE TABLE Empleados (
    -- Código único, inicia con EM seguido de números
    codigo_empleado VARCHAR(10) PRIMARY KEY 
        CONSTRAINT CK_Empleado_Codigo CHECK (codigo_empleado LIKE 'EM[0-9]%'),
    
    -- DUI exacto: 7 números, un guion, 1 número (Según requerimiento 'c')
    DUI VARCHAR(10) NOT NULL 
        CONSTRAINT UQ_Empleado_DUI UNIQUE 
        CONSTRAINT CK_Empleado_DUI CHECK (DUI LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9]-[0-9]'),
    
    -- Nombres, apellidos y cargos sin números permitidos
    nombre VARCHAR(100) NOT NULL 
        CONSTRAINT CK_Empleado_Nombre CHECK (nombre NOT LIKE '%[0-9]%'),
    
    apellido VARCHAR(100) NOT NULL 
        CONSTRAINT CK_Empleado_Apellido CHECK (apellido NOT LIKE '%[0-9]%'),
    
    cargo VARCHAR(100) NOT NULL 
        CONSTRAINT CK_Empleado_Cargo CHECK (cargo NOT LIKE '%[0-9]%'),
    
    salario DECIMAL(10, 2) NOT NULL 
        CONSTRAINT CK_Empleado_Salario CHECK (salario >= 0),
    
    codigo_departamento VARCHAR(10) NOT NULL,

    -- Llave foránea con reglas de Cascada
    CONSTRAINT FK_Empleado_Depto FOREIGN KEY (codigo_departamento)
        REFERENCES Departamentos(codigo_departamento)
        ON UPDATE CASCADE 
        ON DELETE CASCADE
);
GO

-- TABLA: ASIGNACION_PROYECTOS (Tabla Intermedia)
-- Resuelve la relación Muchos a Muchos (N:M) entre Empleados y Proyectos
CREATE TABLE Asignacion_Proyectos (
    codigo_empleado VARCHAR(10) NOT NULL,
    codigo_proyecto VARCHAR(10) NOT NULL,
    fecha_asignacion DATE DEFAULT GETDATE(),

    -- Llave primaria compuesta
    PRIMARY KEY (codigo_empleado, codigo_proyecto),

    -- Ruta 1: Se mantiene el CASCADE para el empleado
    CONSTRAINT FK_Asignacion_Empleado FOREIGN KEY (codigo_empleado)
        REFERENCES Empleados(codigo_empleado)
        ON UPDATE CASCADE 
        ON DELETE CASCADE,

    -- Ruta 2: Se desactiva el CASCADE para evitar el Error 1785 (Ciclos múltiples)
    CONSTRAINT FK_Asignacion_Proyecto FOREIGN KEY (codigo_proyecto)
        REFERENCES Proyectos(codigo_proyecto)
        ON UPDATE NO ACTION 
        ON DELETE NO ACTION
);
GO