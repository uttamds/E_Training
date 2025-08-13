USE DatabaseB;
GO
CREATE TABLE dbo.Customers (
    CustID INT PRIMARY KEY,
    CustName NVARCHAR(50)
);

INSERT INTO dbo.Customers VALUES (1, 'Amit'), (2, 'Priya');


USE DatabaseA;
GO
CREATE SYNONYM Customers
FOR DatabaseB.dbo.Customers;



USE DatabaseA;
GO
SELECT * FROM Customers;
