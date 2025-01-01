
-- Create the Sales Database
CREATE DATABASE SalesDB;

-- Use the Sales Database
USE SalesDB;

-- Create the Regions Table
CREATE TABLE Regions (
    RegionID INT PRIMARY KEY,
    RegionName VARCHAR(50) NOT NULL
);

-- Create the Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50) NOT NULL
);

-- Create the Sales Table
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    SaleDate DATE NOT NULL,
    RegionID INT,
    ProductID INT,
    QuantitySold INT NOT NULL,
    SaleAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (RegionID) REFERENCES Regions(RegionID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert Sample Data into Regions
INSERT INTO Regions (RegionID, RegionName)
VALUES
(1, 'North'),
(2, 'South'),
(3, 'East'),
(4, 'West');

-- Insert Sample Data into Products
INSERT INTO Products (ProductID, ProductName)
VALUES
(1, 'Product A'),
(2, 'Product B'),
(3, 'Product C'),
(4, 'Product D');

-- Insert Sample Data into Sales
INSERT INTO Sales (SaleID, SaleDate, RegionID, ProductID, QuantitySold, SaleAmount)
VALUES
(1, '2023-01-01', 1, 1, 100, 1000.00),
(2, '2023-01-02', 2, 2, 150, 1500.00),
(3, '2023-01-03', 3, 3, 120, 1200.00),
(4, '2023-01-04', 4, 4, 90, 900.00),
(5, '2023-01-05', 1, 2, 170, 1700.00);
