--Las transacciones son fundamentales para asegurar la consistencia y la integridad de los datos.
--Una transaccion es una unidad de trabajo que se ejecuta de manera completamente exitosa o no se ejecuta en absoluto

--Begin Transaction:Inicia una nueva transaccion
--Comit Transaction:Confirma todos los cambios realizados dureante la transaccion 
--Rollback transaction:Revierte todos los cambios reLIzados durante la transaccion


use Northwind


select * from Categories
--iniciar transaction
begin transaction

insert into Categories (CategoryName,Description)
values ('Categoria11', 'Los remediales')

--cancelar transaction

rollback transaction

--aceptar transaction
commit transaction


