-- Funciones de fecha

-- Seleccionar los años,días,mes y cuatrimestre de las ordenes
use Northwind;

select GETDATE()
--Función que devueleve alguna de una fecha

select DATEPART(YEAR,'2024-06-06') AS 'AÑO',
DATEPART(month,'2024-06-06') as 'Mes',
DATEPART(quarter,'2024-06-06') as 'Trimetre',
DATEPART(week,'2024-06-06') as 'Semana',
DATEPART(day,'2024-06-06') as 'Día',
DATEPART(weekday,'2024-06-06') as 'Día de la Semana',
DATEPART(yy,'2024-06-06') as 'Año 2'


select DATEPART(YEAR,OrderDate) AS 'AÑO',
DATEPART(month,OrderDate) as 'Mes',
DATEPART(quarter,OrderDate) as 'Trimetre',
DATEPART(week,OrderDate) as 'Semana',
DATEPART(day,OrderDate) as 'Día',
DATEPART(weekday,OrderDate) as 'Día de la Semana',
DATEPART(yy,OrderDate) as 'Año 2'
from Orders;

--Función que regresa el nombre de un mes o día etc
select DATENAME(month,GETDATE()) as Mes,DATENAME(weekday,GETDATE()) as Dìa

select DATENAME(YEAR,OrderDate) AS 'AÑO',
DATENAME(month,OrderDate) as 'Mes',
DATENAME(quarter,OrderDate) as 'Trimetre',
DATENAME(week,OrderDate) as 'Semana',
DATENAME(day,OrderDate) as 'Día',
DATENAME(weekday,OrderDate) as 'Día de la Semana',
DATENAME(yy,OrderDate) as 'Año 2'
from Orders;

--Función para obtener la diferencia entre años, meses,días,etc
select DATEDIFF(YEAR,'1983-04-06',GETDATE()) AS 'Tiempo de vejez'
--Seleccionar el numero de días transcurridos entre la fecha pedido y la de entrega
select OrderID,OrderDate,DATEDIFF (day,OrderDate,Shippeddate) as 'Días Transcurridos 'from Orders ;
