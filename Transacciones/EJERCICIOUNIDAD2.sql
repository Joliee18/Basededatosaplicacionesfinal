--ACTUALICE LOS PRECIOS DE LOS PRODUCTOS Y GUARDARLOS EN UNA TABLA DE HISTORICOS, ID DE LA TABLA, ID PRODUCTO MODIFICADO, 
--PRECIO ANTERIOR EL PRECIO NUEVO Y FECHA DE MODIFICACION

SELECT pr.ProductID,OD.OrderID
FROM Products as pr
inner join [Order Details] as od
on pr.ProductID=od.ProductID
INNER JOIN Orders as os
on od.OrderID=os.OrderID


SELECT * FROM PRECIOS


SELECT OrderDate
FROM Orders

CREATE TABLE PRECIOS(
    ProductID INT,
	PRECIOANTERIOR MONEY,
	PRECIONUEVO MONEY,
	FECHA DEFAULT GETDATE ()  );
go

INSERT INTO PRECIOS(ProductID, IDPRODUCTMODIFICADO, ORDERDATE) 
VALUES('','','')


select * from Products
select * from [Order Details]
select * from Orders

CREATE OR ALTER PROCEDURE SP_actualizar
@idproducto int,
@precioActual money
as
begin 
begin transaction;

begin try
Declare @precioviejo money;



--consulta para hacer el store
select UnitPrice = @precioviejo
from Products
where ProductID = @idproducto

update Products
set Unitprice = @precioActual
where ProductID = @idproducto

---Registros en la tabla de historicodeprecios 
insert into PRECIOS(ProductID,PRECIOANTERIOR,PRECIONUEVO,FECHA)
values (@idproducto,@precioviejo,@precioActual,default);

commit transaction 
end try 
begin catch 
rollback transaction  --SI NO LO HACE QUE REGRESE TODO
declare @mensajeError varchar (400)
set @mensajeError = ERROR_MESSAGE ();
print @mensajeError
end catch 
end;

exec SP_actualizar @idproducto= 4, @precioActual= 25

select *from Products
where ProductID= 2

select*from PRECIOS

---Aqui se ejecuta desde el store porcesudre click derecho y editamos ahi execute y editamos  

select * from [Order Details]



--STORE PROCEDURE QUE ELIMINE UNA ORDEN, ELIMINAR Y TMB EN ORDERDETAILS, ACTUALIZAR EL STOCK DE PRODUCTO