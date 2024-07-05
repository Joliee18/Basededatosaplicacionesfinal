use Northwind
--Consuktas Avanzadas
--Seleccionar cuantos productos tiene cada categoría 

select CategoryID, count(*) from Products

select CategoryID from Products
select count(*) from Products


select CategoryID, count(*) from Products group by CategoryID 
select * from Products
select * from Categories

select c.CategoryName, count(*) as 'Numero de Productos' from Categories as C
inner join Products as P
on C.CategoryID= p.CategoryID
group by CategoryName;

--Consultar todos los productos juntos con su categorias  y sus precios

select c.CategoryName,c.CategoryID, p.UnitPrice ,count(*) as 'Numero de Productos' 
from Categories as C
inner join Products as P
on C.CategoryID= p.CategoryID
group by CategoryName,c.CategoryID,p.UnitPrice; 


--Consulta para mostrar los nombre de lo productos y los nombre de sus proveedores 
select p.ProductName, s.CompanyName, count(*) as 'Numero de Productos' 
from Suppliers as S
inner join Products as P
on S.SupplierID = P.SupplierID
group by ProductName,s.CompanyName; 

--Seleccionar las ordenes de compra mostrandi los nombres de los productos y sus importes 
select od.OrderId  as 'Numero de Orden'
p.ProductName as 'Nombre del Producto'
(od.Quantity*od.UnitPrice) as 'Importe'
from [Order Details] as od
inner join Products as p
on od.ProductID= P.ProductID
where (od.Quantity*od.UnitPrice)<=15000
order by 'Importe ' desc 

--Mostrara las ordenes de compra y los nombres de los empleados que las realizaron
select o.OrderID as 'Numero de Orden' ,
CONCAT(e.FirstName,'  ',e.LastName) as 'Nombre Completo'
from Orders as o
inner join Employees as e
on o.EmployeeID=p.EmployeeID
where  year (OrderDate) in ('1996','1999')
use Northwind
--Seleccionar las ordenes mostrando los clinetes a las que se les hicieron las cantidades vendidas y los nombres de los productos

--Ejercicio 1: Obtener el nombre del cliente y el nombre del empleado del representante de ventas de cada pedido.
Select o.OrderID as 'Numero de Orden',o.OrderDate as 'Fecha de Orden',c.CompanyName as 'Nombre de Cliente',
CONCAT(e.FirstName,' ',e.LastName) as 'Nombre de Empleado'  
From Employees as e 
inner Join Orders as o 
on e.EmployeeID = o.EmployeeID
Inner Join [Customers] as c 
on o.CustomerID = c.CustomerID;

--Ejercicio 2: Mostrar el nombre del producto, el nombre del proveedor y el precio unitario de cada producto.
select p.ProductName as 'Nombre del Producto',s.CompanyName as 'Nombre de proveedor',p.UnitPrice as 'Precio'
from Products as p  
inner join Suppliers as s 
on p.SupplierID=s.SupplierID;
--
select p.ProductName
from (
    select  SupplierID,ProductName,UnitPrice,UnitsInStock
 from Products 
 ) as p
inner join Suppliers as s 
on p.SupplierID=s.SupplierID;

select p.ProductName,s.CompanyName,p.UnitPrice
from (
    select  SupplierID,ProductName,UnitPrice,UnitsInStock
 from Products 
 ) as p
inner join 
(
    select SupplierId,CompanyName from Suppliers
) as s
on p.SupplierID=s.SupplierID;



--Ejercicio 3: Listar el nombre del cliente, el ID del pedido y la fecha del pedido para cada pedido.
select c.CompanyName as 'Nombre del cliente',
o.OrderID as 'ID del pedido',
o.OrderDate as 'Fecha del pedido',
year (o.OrderDate) as 'Año de compra',
month (o.OrderDate) as 'Mes de compra',
day (o.OrderDate) as 'Día de compra'
from Customers as c
inner join Orders as o
on c.CustomerID=o.CustomerID;

select o.OrderID as 'Numero de Orden', 
c.CompanyName as 'Nombre del cliente',
o.OrderDate as 'Fecha del pedido',
year (o.OrderDate) as 'Año de compra',
month (o.OrderDate) as 'Mes de compra',
day (o.OrderDate) as 'Día de compra'
from (
    select  CustomerID,CompanyName from Customers
) as c
inner join (select CustomerID,OrderID,OrderDate from Orders ) as o
on c.CustomerID=o.CustomerID;

--Ejercicio 4: Obtener el nombre del empleado, el título del cargo y el territorio del empleado para cada empleado.
select CONCAT (e.FirstName,'',e.LastName) AS 'Nombre del Empleado',
e.Title as 'Cargo',t.TerritoryDescription as 'Territorio'
from EmployeeTerritories as et
inner join Employees as e 
on et.EmployeeID=e.EmployeeID
inner join Territories as t 
on t.TerritoryID=et.TerritoryID;

select CONCAT (e.FirstName,'',e.LastName) AS 'Nombre del Empleado',
e.Title as 'Cargo',t.TerritoryDescription as 'Territorio'
from (
    select TerritoryID,EmployeeID from EmployeeTerritories
) as et
inner join (select EmployeeID,FirstName,LastName,Title from Employees) as e 
on et.EmployeeID=e.EmployeeID
inner join (select TerritoryID,TerritoryDescription from Territories) as t 
on t.TerritoryID=et.TerritoryID;

select * from Employees

--Ejercicio de RED
--Seleccionar todas las ordenes mostrando el empleado que la realixo, el cliente al que se le vendio, 
-- el nombre de lo productos, sus categorias,el precio que se vendio las unidades vcendidas y el importe Enero 199
--7 a feb de 1998


select CONCAT (FirstName,'',LastName )as 'Empleado', c.CompanyName as 'Cliente',
p.ProductName as 'Nombre del Producto',ca.CategoryName as 'Categoria',(od.UnitPrice*od.Quantity) as 'Precio'
from Employees AS e
inner join Orders as o
on e.EmployeeID=o.EmployeeID
inner join Customers as c
on c.CustomerID=o.CustomerID
inner join [Order Details] as od
on o.OrderID=od.OrderID
inner join Products as p
on p.ProductID=od.ProductID
inner join Categories as ca
on ca.CategoryID=p.CategoryID
where o.OrderDate between  '1997-01-01' and '1998-02-28'
and ca.CategoryName in('Beverages')
order by c.CompanyName 

--Cuanto eh vendidio de la cantidad Beverages 
select sum(od.UnitPrice * od.Quantity) 'Total de ventas'
from Categories as c
inner join Products as p
on c.CategoryID=p.CategoryID
inner join [Order Details] as od
on od.ProductID=p.ProductID
inner join Orders as o
on o.OrderID=od.OrderID
where o.OrderDate between  '1997-01-01' and '1998-02-28'
and c.CategoryName in('Beverages');


--Ejercicio 5: Mostrar el nombre del proveedor, el nombre del contacto y el teléfono del contacto para cada proveedor.
select s.CompanyName as  'Nombre  del proveedor'
from  Suppliers as s
inner join 
--Ejercicio 6: Listar el nombre del producto, la categoría del producto y el nombre del proveedor para cada producto.
--Ejercicio 7: Obtener el nombre del cliente, el ID del pedido, el nombre del producto y la cantidad del producto para cada detalle del pedido.
--Ejercicio 8: Obtener el nombre del empleado, el nombre del territorio y la región del territorio para cada empleado que tiene asignado un territorio.
--Ejercicio 9: Mostrar el nombre del cliente, el nombre del transportista y el nombre del país del transportista para cada pedido enviado por un transportista.
--Ejercicio 10: Obtener el nombre del producto, el nombre de la categoría y la descripción de la categoría para cada producto que pertenece a una categoría.