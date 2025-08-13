-- Sample data
CREATE TABLE Employees (
    EmpID INT,
    Name NVARCHAR(50),
    Department NVARCHAR(50),
    Salary INT
);

INSERT INTO Employees VALUES
(1, 'Amit', 'IT', 50000),
(2, 'Neha', 'IT', 40000),
(3, 'Raj', 'HR', 35000),
(4, 'Pooja', 'HR', 45000),
(5, 'Vikram', 'Finance', 60000);

-- CTE to calculate department-wise average salary
WITH DeptAvg AS (
    SELECT Department, AVG(Salary) AS AvgSalary
    FROM Employees
    GROUP BY Department
)
-- Use the CTE to find employees above their dept average
SELECT e.Name, e.Department, e.Salary, d.AvgSalary
FROM Employees e
JOIN DeptAvg d
    ON e.Department = d.Department
WHERE e.Salary > d.AvgSalary;


SELECT Name, Department, Salary
FROM Employees 
WHERE Salary > (select AVG(salary) from Employees GROUP by Department)
