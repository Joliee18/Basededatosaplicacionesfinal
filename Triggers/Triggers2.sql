--Crear un trigger que permita gestionar una venta, en la cual se debe actualizar la existencia de 
--Producto vendido, bajo las sig condiciones:
--1.-Verificar si la existencia es suficiente, si la existencia no es sufuciente cancelar la inserción
--2.-Si es suficiente, agregar la venta y dosminuir el stock del producto
--hacer un sp inserte en orders details el unitpice
--1.-insertar en orders
--2.-insertar en ordersdetails
--3.-verificar si el unitinstock es suficiente
--4.-si es suficiente aceptar la insercion y disminuir el unitinstock lo vendido

use Northwind

--create or alter proc insertar_unit_price
   @orderid int, @productid int, @quantity smallint, @discount real
   AS
   begin
   declare @precio money
	select @precio = unitprice
	from Products
	where ProductID = @productid;

	insert into [Order Details]
	values(@orderid, @productid,@precio,@quantity, @discount)
   end;-;


create or alter trigger verificar_venta_stock
on [Order Details]
after insert,update
as
begin
	begin transaction
	declare @productid int,
	@UnitsInStock smallint,
	@orderid int,
	@quantity int

	set @quantity= (select Quantity from inserted)
    set @productid= (select ProductID from inserted)
	set @UnitsInStock=(select UnitsInStock from Products where ProductID=@productid)
	set @orderid=(select OrderID from inserted)

	if @quantity>@UnitsInStock
	begin
	rollback transaction
		raiserror('Cantidad superada en el stock, error',16,1)
	end

	if @quantity<=@UnitsInStock
	begin
		update Products set UnitsInStock=(@UnitsInStock-@quantity)
		where ProductID=@productid
	end
	commit
end;

------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
begin transaction

create or alter procedure sp_insertar_order
@OrderID int,
@ProductID int,
@Quantity smallint,
@discount real
as
begin
declare @UnitPrice money
select @UnitPrice=UnitPrice from Products where ProductID=@ProductID 
	if exists(select 1 from Products where ProductID=@ProductID)
	begin
		insert into [Order Details](OrderID,ProductID,UnitPrice,Quantity,Discount)
		values(@OrderID,@ProductID,@UnitPrice,@Quantity,@discount)
		print ('operacion exitosa') 
	end

else 
begin
print ('algo salio mal')
end
end


-----------------------------------------------------------------------------------------

declare @idproducto int=1, @idorder int=10400, @cantidad smallint=1,@descuento real=0
exec sp_insertar_order @OrderID=@idorder,@ProductID=@idproducto,@Quantity=@cantidad,@discount=@descuento

select * from Products
select * from [Order Details] where OrderID=10400

delete [Order Details] where OrderID=10400
