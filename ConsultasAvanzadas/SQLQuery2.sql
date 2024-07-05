--CONSULTAS SIMPLES (CONSULTAS A UNA SOLA TABLA )--
use Northwind;
--Seleccionar todos los Customers(clientes)--
select * from Customers

--Proyecci�n seleccionar algunos campos de l tabla--
--top= cantidad de registros a proyectar--
select  top 10 CustomerID,CompanyName,City,Country
from Customers

--Alias de Columna
--country as pais--
--country pais--
--country 'pais'
--conutry as 'pais'
--country as 'psais de las maravilas'

select CustomerID as 'Numero Cliente ',CompanyName as 'Nombre Empresa',City as 'Ciudad',Country as 'Pa�s'
from Customers

--Alias de tabla--
select Customers.CustomerID,Customers.CompanyName,Customers.City,Customers.Country
from Customers

select c.CustomerID,c.CompanyName,c.City,c.Country
from Customers as c

-- Campo calculado--

select * , ( p.UnitPrice*p.UnitsInStock) as 'Costo Inventario' from Products as p

select ProductName as 'Nombre Producto',
UnitsInStock as 'Existencia',
UnitPrice as 'Precio Unitario',
( p.UnitPrice*p.UnitsInStock) as 'Costo Inventario' 
from Products as p

--Filtarr Datos
--Clausula where y operadores relacionales
/*
  <   ->Menor que
  >   ->Mayor que
  <=  ->Menor o igual
  >=  ->Mayor o igual
  <>  ->Diferente
  !=  ->Diferente
  =   ->Igual a
  between =rango 
  */
  select * from Customers
  --Seleccionas todos los clientes de Alemni�a--

  select * 
  from   Customers
  where Country='Germany'

  --Seleccionar todos los productos que temngan un stick mayor a 20, mostrando solamente el niombre del producto el precio y la existencia
  --3 formas
  --desc= descente
  --asc

  select p.ProductName as 'Nombre del producto',
  p.UnitPrice as 'Precio',
  p.UnitsInStock as 'Existencia'
  from Products as p
 where p.UnitsInStock > 20
  order 1 desc
 
 select p.ProductName as 'Nombre del producto',
  p.UnitPrice as 'Precio',
  p.UnitsInStock as 'Existencia'
  from Products as p
 where p.UnitsInStock > 20
  order by p.ProductName desc

  select p.ProductName as 'Nombre del producto',
  p.UnitPrice as 'Precio',
  p.UnitsInStock as 'Existencia'
  from Products as p
 where p.UnitsInStock > 20
  order by 'Nombre del producto' desc

  --Seleccionar todos los clientes ordenados de forma ascendente por pa�s y dentro del pais ordenados de froma ascendente por ciudad
  
  select c.Country,c.City from Customers c
  where country ='Germany'
  order by c.Country,c.City asc 

  --Elimar valores repetidos en una consulta
  --Seleccionar los pa�ses de los clientes
  --distinct muestra los campos distintos--
  select distinct country from Customers
  order by 1 asc

  select count ( distinct Country)
  from Customers

  --Selecciona todos lls prodfuctos donde el precio es mayor o igual a 18
  select * from Products as p
  where p.UnitPrice >=18.0

  --Selecciona cuantos son diferentes a 18
  select * from Products as p
  where p.UnitPrice <>18.0

  select * from Products as p
  where p.UnitPrice !=18.0

  --Seleccionar todos los productos que tengan un precio entre 18 y 25 dolares

  select  * from Products  as p
  where p.UnitPrice >=18 and p.UnitPrice <=25

  select  * from Products  as p
  where p.UnitPrice between 18 and 25


  --Seleccionar todos los produyctos donde el precio sea mayor a 38 y su existencia sea mayor e igual a 22 
   
   select  * from Products  as p
   where p.UnitPrice>38 and p.UnitsInStock>=22

   --Seleccionar todos los productos que no tengan un oprecio entre 18 y 25 dolares
  
  select * from Products as p
  where p.UnitPrice <> 18 and p.UnitPrice <> 25

  select * from Products as p
  where p.UnitPrice  not between  18 and  25

  select * from Products as p
  where not ( p.UnitPrice>=18 and p.UnitPrice<= 25)
  
  --Seleccionar todos los productos donde el precio sea mayor a 38

  select * from Products as p
  where p.UnitPrice>38 and p.UnitsInStock>=22

  --Seleccionar todos los clinetes de Alemania MexicoY Francia
  select * from Customers as c
  where c.Country='Germany' or c.Country='Mexico D.f'  or c.Country='France'

  select * from Customers as c
  where c.Country in ('Germany' ,'Mexico D.f','France')

  --Seleccionar todos los clientes quen no tengan Region

  select * from Customers as c
  where Region is NULL

�--Seleccionar todos los que tengan region

select * from Customers
where Region is not null

--Seleccionar todas las ordenes enviadas en julio de 1996 a abril de 1998 para los empleados Buchanan, Leverling, Davolio
select * from Employees

select * from Orders as o
where o.ShippedDate between '1996-07-01' and '1998-04-01'
and  o.EmployeeID in (5,3,1)

select e.LastName as 'Empleado',o.ShippedDate from Employees as e
inner join Orders as o 
on e. EmployeeID= o.EmployeeID
where o.ShippedDate between '1996-07-01' and '1998-04-01'
and e.LastName in ('Buchanan','Leverling','Davolio')

select * from Orders
where (ShippedDate>= '1996-07-01' and  ShippedDate<='1998-04-01')
and (EmployeeID in (5,3,1))

--Seleccionar solo los años de las ordenes de compra

select * from Orders;

select year (OrderDate) as año from Orders;

--Selecciona toda las ordenes de compra en donde para 1996

select year (OrderDate) as año from Orders;

select * from Orders
where year (OrderDate)= '1996'  

select OrderID as 'Numero Orden', OrderDate as 'Fecha Orden',
year (OrderDate) as año from Orders 
where year (OrderDate) ='1996'

--Seleccionar todas las ordenes de compra mostrando el num de orden, fecha de orden , año, mes, y día de 1996 y 1998

select OrderID as 'Numero Orden', OrderDate as 'Fecha Orden',
year (OrderDate) as Año , month (OrderDate) as 'Mes', day(OrderDate) as 'Día' from Orders 
where year (OrderDate) ='1996'or year (OrderDate) ='1998'

select OrderID as 'Numero Orden', OrderDate as 'Fecha Orden',
year (OrderDate) as Año , month (OrderDate) as 'Mes', day(OrderDate) as 'Día' from Orders 
where year (OrderDate)  in ('1996','1998')

--Seleccionar todos los apellidos de los empleados que comiencen con D

select * from Employees
where  LastName like 'D%'

--Seleccionar todos los empleados que su apellido comiencen con una Da
select * from Employees
where  LastName like 'Da%'

--Seleccionar ytodos los empleados que su apellido termine con a

select * from Employees
where  LastName like '%A'

--Seleccionar todos los empleados que su aepllido contenga la palabra A
select * from Employees
where  LastName like '%A%'

--Seleccionar todos los emppleados que su apellido no contenga la letra A
select * from Employees
where  LastName  not like '%A%'

--Seleccionar todos los empleados que contengan su apellido cualqueir letra y una i
select * from Employees
where  LastName like '%_I%'

select * from Employees
where  LastName like '%__I%'

--Selecionar todos los empleados donde su nombre contenga tres caracteres
--antes la palabra li, depues un caracter y finalmente la letra g

select * from Employees
where  LastName like '%__li__g%'

--Seleccionar los apellidos que comiencen con D o L de los empleaods

select * from Employees
where  LastName like '[DL]%'

--Seleccionar todos los empleados que su apellido comiencen con un S C

select * from Employees
where  LastName like '[SC]%'

--Seleccionar todos los empleados que en su apellido contengan una D o una L
select * from Employees
where  LastName like '%[DL]%'

--Seleccionar todos los empleados en donde su apellido contenga las letras entre la a y la f
select * from Employees
where  LastName like '%[A-F]%'

--Seleccionar cuantos empleados en su apellido contienen las letras entre la a y la f 

select count (*)  as 'Total de Empleados' from Employees 
where  LastName like '%[A-F]%'

--Seleccionar todos los empleados en donde sus apellidos que no terminen con c y b
select * from Employees
where  LastName like '%[C-B]%'

--FUNCIONES DE AGREGADO (GROUP BY, HAVING)--
/*
 sum
 count(*)- Contar los registros de una tabla
 count (campo)- Cuenta el numero de  registros de una zona
 avg () - Calcula Media 
 max ()
 min()

*/

--Selecciona el numero total de ordenes realizadas

 select count(*)  as 'Total de Ordenes' from Orders

 select count(ShipRegion) as 'Total de ordenes en una zona' from Orders

--Selecciona el numero de paises a los que les eh enviado ordenes

select count ( distinct ShipCountry)   as 'Cantidad de paises'  from Orders 

 --Seleccionar el total de ordenes enviadas Francia entre 1996 y 1998
select * from Orders

select count (*)  as 'Numero de Ordenes' from Orders 
where ShipCountry='Germany' and year (ShippedDate) between '1996' and '1998'

--Seleccionar el preci minimo de los productos
select min (UnitPrice) as 'Cantidad mínima' from Products

--Seleccionar el precio mas caro  de los productos
select max (UnitPrice) as 'Cantidad maxima' from Products

--Seleccionar el nombre del producto, precio de aquel que sea más caro
select top 1 ProductName, UnitPrice from Products
order  by UnitPrice desc

--Seleccionar el monto total de todas las ordenes 
select sum  (UnitPrice*Quantity) as 'Total de ventas' from [Order Details]

--Seleccionar el total de ventas realizadas a los productos que  no tienen desc
select sum  (UnitPrice*Quantity) as 'Total de ventas' from [Order Details]
where Discount=0

--Seleccionar el promedio dde vetnas para los productos
select avg  (UnitPrice*Quantity) as 'Total de ventas' from [Order Details]
where ProductID in (72,42)

select avg  (UnitPrice*Quantity) as 'Total de ventas' from [Order Details]
where ProductID =72 or ProductID=42

--Seleccionar el total de ventas para el cliente Chup-suey Chinese de 1996 a 1998
select* from Customers
select* from [Orders]
select * from [Order Details]

--JOINS
--inner join - Junta las tablas (select  * from Categorias as c inner join Products on c.PK (IDCATEGORIA)= P.ID CATEGORIA)
--Seleccionar los datos d elas tablas de categorias y de productos
select * from Categories as c 
inner join Products as p
on c.CategoryID=p.CategoryID

select c.CategoryName as 'Nombre Categoria',
p.ProductName as 'Nombre del prodcuto',
p.UnitPrice as 'Precio Unitario',
p.UnitsInStock as 'Existencia', 
(p.UnitPrice*p.UnitsInStock) as 'Precio Inventario'
from Categories as c 
inner join Products as p
on c.CategoryID=p.CategoryID

--Seleccionar los productos de la categoria Beverages
select c.CategoryName as 'Nombre Categoria',
p.ProductName as 'Nombre del prodcuto',
p.UnitPrice as 'Precio Unitario',
p.UnitsInStock as 'Existencia', 
(p.UnitPrice*p.UnitsInStock) as 'Precio Inventario'
from Categories as c 
inner join Products as p
on c.CategoryID=p.CategoryID
where c.CategoryName='Beverages'

--Seleccionar de precio unitario se amayor o igual a 20
select c.CategoryName as 'Nombre Categoria',
p.ProductName as 'Nombre del prodcuto',
p.UnitPrice as 'Precio Unitario',
p.UnitsInStock as 'Existencia', 
(p.UnitPrice*p.UnitsInStock) as 'Precio Inventario'
from Categories as c 
inner join Products as p
on c.CategoryID=p.CategoryID
where c.CategoryName='Beverages'
and p.UnitPrice>20
--Seleccionar el promedio del inventario
select avg (p.UnitPrice*p.UnitsInStock) as 'Precio Inventario'
from Categories as c 
inner join Products as p
on c.CategoryID=p.CategoryID
where c.CategoryName='Beverages'
and p.UnitPrice>20


