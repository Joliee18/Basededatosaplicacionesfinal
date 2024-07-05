--sp total de ventas agrupado por proveedor de tablas



create or alter procedure SP_VENTASDEPROVEEDOR
@year int, @month int, @day int
as 
begin

select* from Orders

select s.CompanyName,
sum (od.UnitPrice * quantity) as Total
from
Suppliers as s
inner join Products as p
on s.SupplierID=P.SupplierID
inner join [Order Details] as od
on p.ProductID=od.ProductID
inner join Orders as o 
on o.OrderID=od.OrderID
where  datepart (year,o.OrderDate)=@year
and datepart (month, o.OrderDate)=@month
and datepart (day,o.OrderDate)=@day
group by s.CompanyName
order by s.companyName; 
end 
go

--Formas de ejecutar un sp

execute SP_VENTASDEPROVEEDOR  1997,07,04

exec SP_VENTASDEPROVEEDOR  1996,07,04

exec SP_VENTASDEPROVEEDOR @day=04,@year=1996,@month=04

exec SP_VENTASDEPROVEEDOR @day=

--crear un sp que premita visualizar cuantas ordenes se han haecho por año y paselect s.CompanyName,

create or alter procedure SPOrdenesPaisyAño
@pais varchar(50),
@año int
as
begin
select count (*) as [Numero de ordenes]
from Orders as o
where o.shipcountry = @pais and datepart(year,o.OrderDate)=@año

end 
go

exec SPOrdenesPaisyAño @pais='Austria', @año=1996



----crear un sp que inserte o actualice los registros nuevos o los cambios en la tabla product, supplier,customers,employees
----------------------------Product-------------------------------------------
CREATE PROCEDURE Producto
    @ProductID INT,
    @ProductName NVARCHAR(40),
    @SupplierID INT,
    @CategoryID INT,
    @QuantityPerUnit NVARCHAR(20),
    @UnitPrice DECIMAL(18, 2),
    @UnitsInStock SMALLINT,
    @UnitsOnOrder SMALLINT,
    @ReorderLevel SMALLINT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Products WHERE ProductID = @ProductID)
    BEGIN
        UPDATE Products
        SET ProductName = @ProductName,
            SupplierID = @SupplierID,
            CategoryID = @CategoryID,
            QuantityPerUnit = @QuantityPerUnit,
            UnitPrice = @UnitPrice,
            UnitsInStock = @UnitsInStock,
            UnitsOnOrder = @UnitsOnOrder,
            ReorderLevel = @ReorderLevel
        WHERE ProductID = @ProductID;
    END
    ELSE
    BEGIN
        INSERT INTO Products (ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel)
        VALUES (@ProductName, @SupplierID, @CategoryID, @QuantityPerUnit, @UnitPrice, @UnitsInStock, @UnitsOnOrder, @ReorderLevel);
    END
END;
GO
---ejecutar sp
EXEC Producto 
    @ProductID = 1, 
    @ProductName = 'Camaron', 
    @SupplierID = 1, 
    @CategoryID = 1, 
    @QuantityPerUnit = '5', 
    @UnitPrice = 18.00, 
    @UnitsInStock = 39, 
    @UnitsOnOrder = 0, 
    @ReorderLevel = 10;
	select * from Products;
	-------------Supliers----------------------------------------
	CREATE PROCEDURE Supliers
    @SupplierID INT,
    @CompanyName NVARCHAR(40),
    @ContactName NVARCHAR(30),
    @ContactTitle NVARCHAR(30),
    @Address NVARCHAR(60),
    @City NVARCHAR(15),
    @Region NVARCHAR(15),
    @PostalCode NVARCHAR(10),
    @Country NVARCHAR(15),
    @Phone NVARCHAR(24),
    @Fax NVARCHAR(24),
    @HomePage NTEXT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Suppliers WHERE SupplierID = @SupplierID)
    BEGIN
        UPDATE Suppliers
        SET CompanyName = @CompanyName,
            ContactName = @ContactName,
            ContactTitle = @ContactTitle,
            Address = @Address,
            City = @City,
            Region = @Region,
            PostalCode = @PostalCode,
            Country = @Country,
            Phone = @Phone,
            Fax = @Fax,
            HomePage = @HomePage
        WHERE SupplierID = @SupplierID;
    END
    ELSE
    BEGIN
        INSERT INTO Suppliers (CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax, HomePage)
        VALUES (@CompanyName, @ContactName, @ContactTitle, @Address, @City, @Region, @PostalCode, @Country, @Phone, @Fax, @HomePage);
    END
END;
GO
----Ejecutar Sp---------
EXEC Supliers
    @SupplierID = 1, 
    @CompanyName = 'GARCIA', 
    @ContactName = 'Melany Samnatha', 
    @ContactTitle = 'Martinez', 
    @Address = '37 San Polo', 
    @City = 'Francia', 
    @Region = NULL, 
    @PostalCode = '42960', 
    @Country = 'Mexico', 
    @Phone = '(773) 553-82829', 
    @Fax = NULL, 
    @HomePage = NULL;
	select * from Suppliers
	------------------Customers------------------
	CREATE PROCEDURE Customer
    @CustomerID NCHAR(5),
    @CompanyName NVARCHAR(40),
    @ContactName NVARCHAR(30),
    @ContactTitle NVARCHAR(30),
    @Address NVARCHAR(60),
    @City NVARCHAR(15),
    @Region NVARCHAR(15),
    @PostalCode NVARCHAR(10),
    @Country NVARCHAR(15),
    @Phone NVARCHAR(24),
    @Fax NVARCHAR(24)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Customers WHERE CustomerID = @CustomerID)
    BEGIN
        UPDATE Customers
        SET CompanyName = @CompanyName,
            ContactName = @ContactName,
            ContactTitle = @ContactTitle,
            Address = @Address,
            City = @City,
            Region = @Region,
            PostalCode = @PostalCode,
            Country = @Country,
            Phone = @Phone,
            Fax = @Fax
        WHERE CustomerID = @CustomerID;
    END
    ELSE
    BEGIN
        INSERT INTO Customers (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax)
        VALUES (@CustomerID, @CompanyName, @ContactName, @ContactTitle, @Address, @City, @Region, @PostalCode, @Country, @Phone, @Fax);
    END
END;
GO
-----Ejecutar Sp---------------
EXEC Customer
    @CustomerID = 1, 
    @CompanyName = 'Aross', 
    @ContactName = 'Santiago Salas', 
    @ContactTitle = 'Diolo', 
    @Address = 'William.de', 
    @City = 'Berlin', 
    @Region = NULL, 
    @PostalCode = '92929', 
    @Country = 'Jamaica', 
    @Phone = '2340-0074321', 
    @Fax = '030-0099545';
	select *  from Customers
	-----------------Employees-------------------------
	CREATE PROCEDURE Empleado
    @EmployeeID INT,
    @LastName NVARCHAR(20),
    @FirstName NVARCHAR(10),
    @Title NVARCHAR(30),
    @TitleOfCourtesy NVARCHAR(25),
    @BirthDate DATETIME,
    @HireDate DATETIME,
    @Address NVARCHAR(60),
    @City NVARCHAR(15),
    @Region NVARCHAR(15),
    @PostalCode NVARCHAR(10),
    @Country NVARCHAR(15),
    @HomePhone NVARCHAR(24),
    @Extension NVARCHAR(4),
    @Photo VARBINARY(MAX),
    @Notes NTEXT,
    @ReportsTo INT,
    @PhotoPath NVARCHAR(255)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Employees WHERE EmployeeID = @EmployeeID)
    BEGIN
        UPDATE Employees
        SET LastName = @LastName,
            FirstName = @FirstName,
            Title = @Title,
            TitleOfCourtesy = @TitleOfCourtesy,
            BirthDate = @BirthDate,
            HireDate = @HireDate,
            Address = @Address,
            City = @City,
            Region = @Region,
            PostalCode = @PostalCode,
            Country = @Country,
            HomePhone = @HomePhone,
            Extension = @Extension,
            Photo = @Photo,
            Notes = @Notes,
            ReportsTo = @ReportsTo,
            PhotoPath = @PhotoPath
        WHERE EmployeeID = @EmployeeID;
    END
    ELSE
    BEGIN
        INSERT INTO Employees (LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address, City, Region, PostalCode, Country, HomePhone, Extension, Photo, Notes, ReportsTo, PhotoPath)
        VALUES (@LastName, @FirstName, @Title, @TitleOfCourtesy, @BirthDate, @HireDate, @Address, @City, @Region, @PostalCode, @Country, @HomePhone, @Extension, @Photo, @Notes, @ReportsTo, @PhotoPath);
    END
END;
GO
	---Ejecutar SP----------------------------
	EXEC Empleado
    @EmployeeID = 1, 
    @LastName = 'Karin', 
    @FirstName = 'Martina', 
    @Title = 'Salas', 
    @TitleOfCourtesy = 'Ms.', 
    @BirthDate = '1933-05-30', 
    @HireDate = '1990-02-21', 
    @Address = 'salas.sj', 
    @City = 'Mexico', 
    @Region = 'WA', 
    @PostalCode = '23440', 
    @Country = 'UK', 
    @HomePhone = '(926) 555-9257', 
    @Extension = '22290', 
    @Photo = NULL, 
    @Notes = 'Evaluaciones',
    @ReportsTo = 2, 
    @PhotoPath = 'http://accweb/emmployees/davolio.bmp';
	select * from Employees

	----*****Crear un sp que actualice la tabla ventas******-------------------------------
	CREATE PROCEDURE ventas
    @OrderID INT,
    @CustomerID NCHAR(5),
    @EmployeeID INT,
    @OrderDate DATETIME,
    @RequiredDate DATETIME,
    @ShippedDate DATETIME,
    @ShipVia INT,
    @Freight DECIMAL(18, 2),
    @ShipName NVARCHAR(40),
    @ShipAddress NVARCHAR(60),
    @ShipCity NVARCHAR(15),
    @ShipRegion NVARCHAR(15),
    @ShipPostalCode NVARCHAR(10),
    @ShipCountry NVARCHAR(15)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Orders WHERE OrderID = @OrderID)
    BEGIN
        -- Actualiza el registro
        UPDATE Orders
        SET CustomerID = @CustomerID,
            EmployeeID = @EmployeeID,
            OrderDate = @OrderDate,
            RequiredDate = @RequiredDate,
            ShippedDate = @ShippedDate,
            ShipVia = @ShipVia,
            Freight = @Freight,
            ShipName = @ShipName,
            ShipAddress = @ShipAddress,
            ShipCity = @ShipCity,
            ShipRegion = @ShipRegion,
            ShipPostalCode = @ShipPostalCode,
            ShipCountry = @ShipCountry
        WHERE OrderID = @OrderID;
    END
    /*ELSE
    BEGIN
      /* ---Si no existe lanze un error o manejarlo de otra manera
        RAISERROR('La orden con OrderID = %d no existe.', 16, 1, @OrderID);*/
    --end*/
END;
GO
----EJECUTAR SP---------------------
EXEC ventas 
    @OrderID = 10248,
    @CustomerID = 'ERTUS',
    @EmployeeID = 5,
    @OrderDate = '1990-05-07',
    @RequiredDate = '1993-09-27',
    @ShippedDate = '1990-03-20',
    @ShipVia = 3,
    @Freight = 32.38,
    @ShipName = 'cupra',
    @ShipAddress = 'esedr.uhj',
    @ShipCity = 'Arcantara',
    @ShipRegion = NULL,
    @ShipPostalCode = '52020',
    @ShipCountry = 'London';
	select * from Orders


	--STORES PROCERURES
	--parametros de salida


	--crear store procedure que calcule el area de un circulo

	create or alter procedure sp_calcularareacirculo
	@radio float, --parametro de entrada
	@area float output --parametro de salida
	as
	begin
		set @area =PI()*@radio * @radio
	end;
	go

	declare @resultado float
	exec sp_calcularareacirculo @radio=22.3, @area =@resultado output
	print 'El valor del area es :' + cast(@resultado as varchar);
	go


	--crear store procedure que obtenga los nombres de un empleado

	create or alter proc sp_obtenerinformaciondelempleado

	@employeeid int =-1,
	@apellido nvarchar (20) output,
	@nombre as nvarchar (10) output
	as
	begin

	if @employeeid<>-1
	begin
	select @nombre=FirstName,@apellido=lastname
	from Employees
	where EmployeeID=@employeeid 
	end
	else 
	begin
	print('El valor del empleado no es valido')
	end
	end


	declare @firstname as nvarchar (10),
	@lastname nvarchar (20) 
	exec sp_obtenerinformaciondelempleado @employeeid = 1,
		@nombre=@firstname output, @apellido = @lastname output
		
		print ('El nombre es:' + @firstname)
		print ('El apellido es:' + @lastname)

-----------------------------------------------------------------------------------
--No tiene el valor del empleado id

declare @firstname as nvarchar (10),
	@lastname nvarchar (20) 
	exec sp_obtenerinformaciondelempleado 
		@nombre=@firstname output, @apellido = @lastname output
		
		print ('El nombre es:' + @firstname)
		print ('El apellido es:' + @lastname)

-- Verifique si el empleyeeid introducido existe
select * from Employees

create or alter proc sp_obtener_informacion_empleado2
@employeeid int = -1,
@apellido nvarchar(20) output,
@nombre as nvarchar(10) output
AS
begin

   DECLARE @existe int
   set @existe=(select count(*) from Employees where EmployeeID =@employeeid)
   -- select @existe = count(*) from Employees where EmployeeID =@employeeid
   

   IF @existe > 0
   begin
    Select @nombre = FirstName, @apellido=lastname
    from Employees
    where EmployeeID = @employeeid
   end
   else
   begin
   if @existe = 0
   begin
      print 'El id del empleado no existe'
   end
  end
end

-------------------------------------------------------------

declare @firstname as nvarchar(10),
@lastname nvarchar(20)

exec sp_obtener_informacion_empleado2
@nombre=@firstname output, @apellido = @lastname output

print ('El nombre es: ' + @firstname)
print ('El apellido es: ' + @lastname)


´--realizar un store procedure que guarde en una variable de salida el total de compras
--que ha realizado uin cliente en un rango de fechas

--diseñar consulta y store

create or alter proc sp_obtener_ventas_por_clientes
@customerid nchar(5),
@fechainicial date,
@fechafinal date,
@total decimal (10,2) output

as
begin
select @total=sum (od.UnitPrice * od.quantity) 
from [Order Details] AS od
inner join Orders as o
on od.OrderID = o.OrderID
where CustomerID=@customerid and OrderDate BETWEEN @fechainicial and @fechafinal;
end 

select * from Orders
where CustomerID='ALFKI'

