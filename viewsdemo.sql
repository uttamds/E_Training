-- Suppose this view already exists:
-- CREATE VIEW vw_EmployeeSales AS
-- SELECT EmpID, EmpName, DeptID, SaleAmount, SaleDate FROM EmployeeSalesTable;

SELECT
    v.EmpID,
    v.EmpName,
    d.DeptName,
    SUM(v.SaleAmount) AS TotalSales,
    COUNT(DISTINCT MONTH(v.SaleDate)) AS ActiveMonths,
    
    -- Conditional bonus: 10% if sales > 50000, else 5%
    CASE 
        WHEN SUM(v.SaleAmount) > 50000 THEN SUM(v.SaleAmount) * 0.10
        ELSE SUM(v.SaleAmount) * 0.05
    END AS BonusAmount,
    
    -- Percentage contribution to department total
    ROUND(
        (SUM(v.SaleAmount) * 100.0) / 
        SUM(SUM(v.SaleAmount)) OVER (PARTITION BY d.DeptID), 2
    ) AS DeptContributionPercent,
    
    -- Rank employees within department by sales
    RANK() OVER (PARTITION BY d.DeptID ORDER BY SUM(v.SaleAmount) DESC) AS DeptRank,
    
    -- Running total of sales company-wide by date
    SUM(SUM(v.SaleAmount)) OVER (ORDER BY MIN(v.SaleDate)) AS RunningTotal

FROM vw_EmployeeSales v
JOIN Departments d
    ON v.DeptID = d.DeptID
WHERE YEAR(v.SaleDate) = 2024
GROUP BY v.EmpID, v.EmpName, d.DeptName, d.DeptID
ORDER BY DeptName, DeptRank;
