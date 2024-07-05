--TRIGERS
--SINTAXIS

CREATE TRIGGER nombre_trigger
on nombre.tabla
after insert,delete,update
as
begin
-----codigo consulta
end




--crear base de datos

create database pruebatriggersg3
go
use pruebatriggersg3;

create table tabla1(
id int not null primary key,
nombre varchar(50) not null
);
go

--crear triggers

--trigger que verifica el eventp que se ejecuto

create or alter trigger tg_verificar_insercion
on tabla1
after insert
as 
begin
print'Se ejecuto el evento insert en la tabla 1'
end;

insert into tabla1
values (1,'Nombre 1')

--Evento delete

create or alter trigger tg_verificar_delete
on tabla1
after delete
as 
begin
print'Se ejecuto el evento delete en la tabla 1'
end;

delete tabla1
where id=1

insert into tabla1
values (1,'Nombre1')


--evento update

create or alter trigger tg_verificar_update
on tabla1
after update
as 
begin
print'Se ejecuto el evento update en la tabla 1'
end;

update tabla1
set nombre='Nombre Nuevo'
where id=1;

--eliminar triggers

drop trigger tg_verificar_insercion
drop trigger tg_verificar_delete
drop trigger tg_verificar_update

--crear trigger que verifique el contenidop de inserted

create trigger verificar_contenido_inserted
on tabla1
after insert
as
begin
	--ver l,os dagtos de la tabla inserted
	select * from inserted;
end;

insert into tabla1
values (2,'Nombre 2')

select * from tabla1

insert into tabla1
values (3,'Nombre 3'),(5,'Nombre5')


use Northwind

create or alter trigger verificar_inserted_categories
on Categories
after insert
as
begin 
	select categoryid,categoryname,[description]  from inserted;
end


insert into categories (categoryname,description)
values ('Category Nueva', 'Prueba trigger')

--que actualice en categorias

create or alter trigger verificar_update_categories
on Categories
after update
as
begin 
	select categoryid,categoryname,[description]  from inserted;
	select categoryid,categoryname,[description]  from deleted;
end

--dentro de una transaccion se puede 
--comfirmar=commit
--cancelar=rollback
--rollback cancelar transaccion o operaciom
--
begin transaction

update categories
set categoryname='Categoria Otra',
	[description] = 'Si esta bien'
where categoryid=9

--eliminar triggers

drop trigger verificar_update_categories
drop trigger verificar_inserted_categories

--

create or alter trigger verificar_inserted_deleted
on categories
after insert,update,delete
as
begin
	if exists (select 1 from inserted) and not exists (select 1 from deleted)
	begin
		print ('Existen datos en la tabla inserted, se ejecuto un insert')
	end
	if exists (select 1 from deleted) and not exists (select 1 from inserted)
	begin 
	print 'Existen datos en la tabkla deleted,se realizo un delete'
	end
	else if exists (select 1 from deleted) and 
	exists (select 1 from inserted)
	begin
	print 'Existen datos en las doa tablas, se realizo un update'
	end
end;


insert into categories (categoryname,[description])
values ('categoria10 ', 'Pinpon')

drop trigger verificar_inserted_deleted

--crear un trigger en la base de datos pruebatriggers para la tabla empleados este triigeer debe evitar 
--que se inserten o modifiquen salarios mayores a 50000

use pruebatriggersg3

create table Empleado (
	id int not null primary key,
	nombre varchar(50)not null,
	salario money not null );

create or alter trigger verificar_salario
on Empleado
after insert,update
as
begin
	if  exists (select 1 from inserted) and 
	not exists (select 1 from deleted)
		begin
		--guardar declarar en variable
		declare @salarioNuevo money
		set  @salarioNuevo=(select salario from inserted);
		
		--comparación
		if @salarioNuevo >50000
		begin
		raiserror ('El salario es mayor a 50000 y no esta permitidio' , 16,1)
		--16 tipo de error y 1 que tan grave puede ser , cuando se cancele es 16,1
		rollback transaction;
		end
	end
end;

