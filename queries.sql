
-- Total Sales by Region
SELECT r.RegionName, SUM(s.SaleAmount) AS TotalSales
FROM Sales s
JOIN Regions r ON s.RegionID = r.RegionID
GROUP BY r.RegionName;

-- Top 3 Products by Sales Amount
SELECT p.ProductName, SUM(s.SaleAmount) AS TotalSales
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalSales DESC
LIMIT 3;

-- Monthly Sales Trends
SELECT DATE_FORMAT(SaleDate, '%Y-%m') AS Month, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY Month
ORDER BY Month;

-- Sales Performance by Product and Region
SELECT r.RegionName, p.ProductName, SUM(s.SaleAmount) AS TotalSales
FROM Sales s
JOIN Regions r ON s.RegionID = r.RegionID
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY r.RegionName, p.ProductName
ORDER BY TotalSales DESC;
