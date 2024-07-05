# Requerimientos 
Una empresa encargada de las ventas de diferentes productos desea crear una base de datos que controles los proveedores, clientes, empleados, categorías de producto y órdenes de compra. Para los proveedores se necesita almacenar un numero de control, nombre de la empresa, dirección (numero, calle, colonia, estado), cp,teléfono, página web, teléfono de contacto o contactos del proveedor, nombre del contacto, email del contacto. Para los empleados se desea almacenar un numero de nómina, nombre completo del empleado, rfc, curp, salario (El salario máximo es de 65000), para las ordenes de compra se necesita almacenar la fecha de creación de la orden, el empleado que la realizo, al cliente que se le vende, la fecha de entrega y los diferentes productos que contiene. El producto debe almacenar un numero de control y una descripción única, status, existencia y un precio. La categoría debe tener un identificador y nombre único de categoría. La compra siempre debe tener un precio de venta que se obtiene del precio unitario del producto y una cantidad vendida.

# Diagrama E/R
![Diagrama Relacional](./IMG/DiagramaER.png)
# Diagrama Relacional
![Diagrama Relacional](./IMG/bdventas.png)
# Creacion BD con Lenguaje SQL-LDD 

 sql
create database bdVentas;
use bdVentas

create table cliente (
clienteId int not null identity(1,1),
rfc varchar(20) not null,
curp varchar(18) not null,
nombres varchar(50) not null,
Apellido1 varchar(50) not null,
Apellido2 varchar (50) not null,

constraint pk_cliente
primary key(clienteId),
constraint unico_rfc
unique (rfc),
constraint unico_curp
unique (curp)
);

create table contactoProveedor (
contactoId int not null identity (1,1),
proveedorId int not null,
nombre varchar(50) not null,
Apellido1 varchar(50) not null,
Apellido2 varchar(50) not null,
constraint  pk_contactoProveedor
primary key (contactoId)
);

create table Proveedor(
proveedorId int not null identity (1,1),
nombreEmpresa varchar(20) not null,
rfc varchar (20),
calle varchar(30)not null,
colonia varchar(50)not null,
cp int not null,
paginaWeb varchar(50),

constraint pk_Proveedor
primary key (proveedorId),
constraint unico_nombreEmpresa
unique (nombreEmpresa),
constraint unico_rfc2
unique (rfc),
);

alter table contactoProveedor
add constraint fk_contactoProveedor_proveedor
foreign key (proveedorId)
references proveedor(proveedorId);

create table empleado(
empleadoId int not null identity (1,1),
nombre varchar(50) not null,
apellido1 varchar (50) not null,
apellido2 varchar(50) not null,
rfc varchar (20) not null,
curp varchar (18) not null,
numeroexterno int,
calle varchar (50) not null,
salario money not null,
numeronomina int not null,

constraint pk_Empleado
primary key (empleadoId),
constraint unico_rfc_empleado
unique(rfc),
constraint unico_curp_empleado
unique(curp),
constraint chk_salario
check (salario>=0.0 and salario <=100000),
--check (salario between 0.1 and 100000)
constraint unico_nomina_empleado
unique (numeronomina)
);

create table telefonoProveedor(
telefonoId int not null,
proveedorId int not null,
numerodetelefono varchar(15),

constraint pk_telefono_proveedor
primary key(telefonoId,proveedorId),
constraint fk_telefonoprov_proveedor
foreign key (proveedorId)
references proveedor(proveedorId)
on delete cascade
on update cascade
);

create table producto (
numerocontrol int not null identity(1,1),
descripcion varchar(50)not null,
precio money not null,
estatus int not null,
existencia int not null,
proveedorid int not null ,
constraint pk_producto
primary key(numerocontrol),
constraint unico_descripcion
unique(descripcion),
constraint chk_precio
check(precio between 1 and 200000),
constraint chk_estatus
check(estatus=1 or estatus=0),
constraint chk_existencia
check(existencia>0),
constraint fk_producto_proveedor
foreign key (proveedorid)
references proveedor(proveedorId)
);

create table ordencompra(
numeroorden int not null identity,
fechacompra date not null,
fechaentrega date not null,
clienteid int not null,
empleadoid int not null,
constraint pk_ordencompra
primary key(numeroorden),
constraint fk_ordencompra_cliente
foreign key (clienteid)
references cliente(clienteId),
constraint fk_ordencompra_empleado
foreign key(empleadoid)
references empleado(empleadoId),
);

create table detalleCompra(
productoId int not null,
numeroorden int not null,
cantidad int not null,
preciocompra money not null,
constraint pk_detallecompra
primary key (productoId, numeroorden),
constraint fk_ordencompra_producto
foreign key(productoId)
references producto (numerocontrol),
constraint fk_ordencompra_compra
foreign key (numeroorden)
references ordencompra (numeroorden)
)
# Llenar base de datos con lenguaje_SQL-lMD
use [bdventas]

select * from [Northwind].dbo.Customers
go
select * from cliente;
go
--Inaerta varios clientes en una instrucci�n--
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
HireDate as 'FechaContrataci�n', 
[address] as 'Direcci�n',
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

select * from empleado2 (empleadoid,Apellido,Primernombre,FechaNacimiento,FechaContrataci�n,Direcci�n,City,Region,CodigoPostal,Pais)
select EmployeeID as 'empleadoid',
LastName as 'Apellido' , 
FirstName as 'Primernombre' , 
BirthDate as 'FechaNacimiento',
HireDate as 'FechaContrataci�n', 
[address] as 'Direcci�n',
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
insert into producto (numerocontrol,descripcion,
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

-- Seleccionar vel total a pagar de la ordenes que contienen el producto 1
select SUM (cantidad*preciocompra) as 'total'
from detalleCompra
where productoId=1

--Sellecciona la fecha actual del sistema
select getdate()
select * from ordencompra