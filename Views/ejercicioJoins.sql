
--Ejercicios
--1 Crear una base de datos llamda Ejercicio Joins 
create database EjercicioJoins;
use EjercicioJoins;
--2 Crear una tabla que se llame Empleados como base la tabla employees de northwind no tomar todos solo 4
select * from Northwind.dbo.Employees;

select top 0 employeeid as 'Empleado ID',
CONCAT (FirstName,'',LastName) as 'Nombre Completo',
title as 'Titulo',
HireDate as 'FechaContratación'
into EjercicioJoins.dbo.empleados
from Northwind.dbo.Employees; 

select * from EjercicioJoins.dbo.empleados;

--3 Llenar la tabla con una consulta a la tbala employees

insert into EjercicioJoins.dbo.empleados (NombreCompleto,Titulo,FechaContratación)
select top 0 employeeid as 'Empleado ID',
    CONCAT (FirstName,'',LastName) as 'Nombre Completo',
    title as 'Titulo',
    HireDate as 'FechaContratación'
from Northwind.dbo.Employees; 

select top 0 * 
into EjercicioJoins.dbo.dimempleados
from EjercicioJoins.dbo.empleados

select * from dimempleados

--4 Agregar nuevos datos a la tabla empleados por lo menos 2
--5 Actualizar la tabla empleados con los nuevos registros la cual se llenaran en una nueva tabla llamada dim_productokj


