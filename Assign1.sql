-- -- Step 1: Create the Products table
-- CREATE TABLE Products (
--     ProductID INT PRIMARY KEY,
--     ProductName NVARCHAR(50),
--     Price DECIMAL(10,2)
-- );

-- Step 2: Insert sample data
-- INSERT INTO Products (ProductID, ProductName, Price) VALUES
-- (1, 'Notebook', 200),
-- (2, 'Pen', 20),
-- (3, 'Bag', 450),
-- (4, 'Shoes', 800),
-- (5, 'Watch', 1200);

-- -- Step 3: Create the stored procedure
-- CREATE PROCEDURE IncreasePrice
-- AS
-- BEGIN
--     DECLARE @ProdID INT;
--     DECLARE @CurrentPrice DECIMAL(10,2);

--     -- Declare the cursor for all products
--     DECLARE product_cursor CURSOR FOR
--         SELECT ProductID, Price FROM Products;

--     -- Open the cursor
--     OPEN product_cursor;

--     -- Fetch the first row
--     FETCH NEXT FROM product_cursor INTO @ProdID, @CurrentPrice;

--     -- Loop through all rows
--     WHILE @@FETCH_STATUS = 0
--     BEGIN
--         -- Update price by 5%
--         UPDATE Products
--         SET Price = @CurrentPrice * 1.05
--         WHERE ProductID = @ProdID;

--         -- Print message
--         PRINT 'Price updated for ProductID = ' + CAST(@ProdID AS NVARCHAR);

--         -- Move to next row
--         FETCH NEXT FROM product_cursor INTO @ProdID, @CurrentPrice;
--     END

--     -- Close and deallocate cursor
--     CLOSE product_cursor;
--     DEALLOCATE product_cursor;
-- END;
-- GO

-- -- Step 4: Execute the stored procedure
-- EXEC IncreasePrice;

-- -- Step 5: Verify results
--SELECT * FROM Products;

--drop PROC IncreasePrice

-- CREATE PROCEDURE IncreasePrice
--     @Multiplier DECIMAL(5, 2)  -- Input parameter for multiplier value
-- AS
-- BEGIN
--     DECLARE @ProdID INT;
--     DECLARE @CurrentPrice DECIMAL(10,2);

--     -- Declare the cursor for all products
--     DECLARE product_cursor CURSOR FOR
--         SELECT ProductID, Price FROM Products;

--     -- Open the cursor
--     OPEN product_cursor;

--     -- Fetch the first row
--     FETCH NEXT FROM product_cursor INTO @ProdID, @CurrentPrice;

--     -- Loop through all rows
--     WHILE @@FETCH_STATUS = 0
--     BEGIN
--         -- Update price using input multiplier
--         UPDATE Products
--         SET Price = @CurrentPrice * @Multiplier
--         WHERE ProductID = @ProdID;

--         -- Print message
--         PRINT 'Price updated for ProductID = ' + CAST(@ProdID AS NVARCHAR);

--         -- Move to next row
--         FETCH NEXT FROM product_cursor INTO @ProdID, @CurrentPrice;
--     END

--     -- Close and deallocate cursor
--     CLOSE product_cursor;
--     DEALLOCATE product_cursor;
-- END;
-- GO

--SELECT * from Products;

-- EXEC IncreasePrice 1.1

