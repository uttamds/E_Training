-- Sample data
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name NVARCHAR(50),
    Salary INT
);

INSERT INTO Employees VALUES
(1, 'Amit', 50000),
(2, 'Neha', 40000),
(3, 'Raj', 35000),
(4, 'Pooja', 45000);

-- Begin transaction
BEGIN TRANSACTION;

-- Increase salary by 10%
UPDATE Employees
SET Salary = Salary * 1.10;

-- Check total expenditure
DECLARE @TotalExpense INT;
SET @TotalExpense = (SELECT SUM(Salary) FROM Employees);

-- Threshold limit
DECLARE @Threshold INT = 200000;

-- If limit exceeded, rollback; else commit
IF @TotalExpense > @Threshold
BEGIN
    PRINT 'Threshold exceeded. Rolling back changes.';
    ROLLBACK TRANSACTION;
END
ELSE
BEGIN
    PRINT 'Update successful. Committing changes.';
    COMMIT TRANSACTION;
END;

-- Check result
SELECT * FROM Employees;
