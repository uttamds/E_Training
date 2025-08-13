-- Sample data
-- CREATE TABLE Sales (
--     EmpName NVARCHAR(50),
--     SaleAmount INT
-- );

-- INSERT INTO Sales VALUES
-- ('Amit', 5000),
-- ('Neha', 7000),
-- ('Raj', 7000),
-- ('Pooja', 6000);

-- Use RANK() to rank employees by sales (highest first)
SELECT 
    EmpName,
    SaleAmount,
    RANK() OVER (ORDER BY SaleAmount DESC) AS SalesRank
FROM Sales;
