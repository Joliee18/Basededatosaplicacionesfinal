use [bdventas]

select * from [Northwind].dbo.Customers
go
select * from cliente;
go
--Inaerta varios clientes en una instrucción--
insert into cliente (RFC,curp,nombres,Apellido1,Apellido2)
values('hdsjisdjkd','NKJE628367289','Alfreds Futterkiste','jsjsjsjjsjf','Futterkiste')
insert into cliente (RFC,curp,nombres,Apellido1,Apellido2)
values
('hjsskaksg','KIJU627286822','Maria Magdalena','njsjjqja','Magdalena'),
('bdwucbowe','AEiG345732456','Santigao jonedon','jwksnmje','Narces'),
('njdsksjsj','TVDH382382999','Degdkji Jnixouns','osajojend','Naindd'),
('jnohjswnq','EDGH529485914','Martin Yondwjr','jdoiwjdeoi','Marctes');
go
insert into empleado2()
--ELIMAN LOS DATOS DE LA TABLA CLIENTE
delete cliente 
select * from cliente 
--comando para reiniciar en identity de una tabla--
DBCC CHECKIDENT (cliente, RESED, 0)
--as es= xxxx--
--Crea una tabla apartir de una aconsulta--
select top 0  EmployeeID as 'empleadoid',
LastName as 'Apellido' , 
FirstName as 'Primernombre' , 
BirthDate as 'FechaNacimiento',
HireDate as 'FechaContratación', 
[address] as 'Dirección',
city as 'City',
region as 'Region',
PostalCode as 'CodigoPostal',
country as 'Pais'
into empleado2
from Northwind.dbo.Employees
select * from 
go
--drop=borrar la tabla empleado--
drop table empleado2
-- iNSERTYAR DATOS APARTIR DE UNA CONSULTA--
select * from empleado2
go
-- ALTERA UN CONSTRAINT DE pPRIMARY KEY EN UNA TABLA --
--alter= crear objeto--
alter table empleado2
add constraint pk_empleado2
primary key (empleadoid)
go

--top ordenar datos --
select top 5 * from Northwind.dbo.[Order Details]
order by OrderID desc
select * from empleado2
go
--Insertar datos apartir de una consulta--

select * from empleado2 (empleadoid,Apellido,Primernombre,FechaNacimiento,FechaContratación,Dirección,City,Region,CodigoPostal,Pais)
select EmployeeID as 'empleadoid',
LastName as 'Apellido' , 
FirstName as 'Primernombre' , 
BirthDate as 'FechaNacimiento',
HireDate as 'FechaContratación', 
[address] as 'Dirección',
city as 'City',
region as 'Region',
PostalCode as 'CodigoPostal',
country as 'Pais'
from Northwind.dbo.Employees
go
select * from cliente;
select * from empleado
insert into empleado(nombre,apellido1,apellido2,curp,rfc,numeroexterno,calle,salario,numeronomina)
values('Alan','Santiago','Molina','ALM2632736','ALM82892','23','Calle del manzano',72882.9,727828),
('Yamileth','Aguirre','Rangel','YMFB872892','YAT278393','32','Calle del hambre',77338.90,728782),
('Samatha','Dominguez','Lopez','SDLK88918','SDL832908','20','Calle de la gordura',29190,839283);

insert into ordencompra
values (getDate(),'2024-06-10',17,3),
       (getDate(),'2024-07-11',18,2);

select * from empleado

select * from producto
insert into producto (numerocontrol,descripcion,precio,
[estatus],existencia,proveedorid)
select ProductID,ProductName,UnitPrice,Discontinued,UnitsInStock,SupplierID from Northwind.dbo.Products
where UnitsInStock =0
insert into producto (numerocontrol,descripcion)
select * from Proveedor
select * from Northwind.dbo.Suppliers
insert into Proveedor
select  supplierid,CompanyName,PostalCode,'Calle Soledad',city,2345 as cp,'www.prueba.com.mx' as 'pagina web'from Northwind.dbo.Suppliers

select * from ordencompra
insert into detalleCompra
values (1,14,10, (select precio from producto where numerocontrol=1))

select * from producto

select * from detalleCompra
update producto
set precio=20.2
where numerocontrol =1

--Seleccioinar las ordenes de compra seleccionadas al producto 1
select*,(cantidad* preciocompra)as importe from detalleCompra
where productoId=1

-- Seleccionar el total a pagar de las ordenes que contienen el producto 1
select SUM (cantidad*preciocompra) as 'total'
from detalleCompra
where productoId=1

--Sellecciona la fecha actual del sistema
select getdate()
select * from ordencompra