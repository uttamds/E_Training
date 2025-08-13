-- CREATE TABLE Employees (
--     EmpID INT PRIMARY KEY,
--     EmpName NVARCHAR(50),
--     Salary DECIMAL(10,2)
-- );

-- CREATE TABLE Employee_Update_Log (
--     LogID INT IDENTITY PRIMARY KEY,
--     EmpID INT,
--     OldSalary DECIMAL(10,2),
--     NewSalary DECIMAL(10,2),
--     UpdatedOn DATETIME
-- );

-- CREATE TRIGGER trg_AfterUpdate_Employees
-- ON Employees
-- AFTER UPDATE
-- AS
-- BEGIN
--     -- Insert old and new values into log table
--     INSERT INTO Employee_Update_Log (EmpID, OldSalary, NewSalary, UpdatedOn)
--     SELECT
--         d.EmpID,
--         d.Salary AS OldSalary,
--         i.Salary AS NewSalary,
--         GETDATE()
--     FROM DELETED d
--     INNER JOIN INSERTED i ON d.EmpID = i.EmpID;

--     PRINT 'Update operation logged successfully.';
-- END;
-- GO

-- -- Insert sample data
-- INSERT INTO Employees VALUES
-- (1, 'Amit', 50000),
-- (2, 'Priya', 60000);

-- -- Update salary (trigger will fire)
-- UPDATE Employees
-- SET Salary = 55000
-- WHERE EmpID = 1;

-- -- Check the log
-- SELECT * FROM Employee_Update_Log;


