-- MySQL 8+ dimensional sales warehouse
CREATE DATABASE IF NOT EXISTS sales_warehouse;
USE sales_warehouse;
DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS dim_customer;
DROP TABLE IF EXISTS dim_product;
DROP TABLE IF EXISTS dim_region;
DROP TABLE IF EXISTS dim_date;
CREATE TABLE dim_date(date_key INT PRIMARY KEY,full_date DATE NOT NULL UNIQUE,day_num TINYINT NOT NULL,month_num TINYINT NOT NULL,month_name VARCHAR(12) NOT NULL,quarter_num TINYINT NOT NULL,year_num SMALLINT NOT NULL);
CREATE TABLE dim_region(region_key INT PRIMARY KEY AUTO_INCREMENT,region_name VARCHAR(80) NOT NULL UNIQUE);
CREATE TABLE dim_product(product_key INT PRIMARY KEY AUTO_INCREMENT,product_name VARCHAR(120) NOT NULL,category VARCHAR(80) NOT NULL,subcategory VARCHAR(80),UNIQUE KEY uq_product(product_name,category,subcategory));
CREATE TABLE dim_customer(customer_key INT PRIMARY KEY AUTO_INCREMENT,customer_code VARCHAR(40) NOT NULL UNIQUE,customer_segment VARCHAR(40));
CREATE TABLE fact_sales(sales_key BIGINT PRIMARY KEY AUTO_INCREMENT,order_id VARCHAR(40) NOT NULL,date_key INT NOT NULL,region_key INT NOT NULL,product_key INT NOT NULL,customer_key INT NOT NULL,quantity INT NOT NULL,sales_amount DECIMAL(14,2) NOT NULL,discount_amount DECIMAL(14,2) NOT NULL DEFAULT 0,cost_amount DECIMAL(14,2) NOT NULL DEFAULT 0,FOREIGN KEY(date_key) REFERENCES dim_date(date_key),FOREIGN KEY(region_key) REFERENCES dim_region(region_key),FOREIGN KEY(product_key) REFERENCES dim_product(product_key),FOREIGN KEY(customer_key) REFERENCES dim_customer(customer_key),CHECK(quantity>=0),CHECK(sales_amount>=0),INDEX ix_fact_date_region(date_key,region_key),INDEX ix_fact_product_date(product_key,date_key));
INSERT INTO dim_date VALUES(20240101,'2024-01-01',1,1,'January',1,2024),(20240102,'2024-01-02',2,1,'January',1,2024),(20240201,'2024-02-01',1,2,'February',1,2024),(20240301,'2024-03-01',1,3,'March',1,2024);
INSERT INTO dim_region(region_name) VALUES('North'),('South'),('East'),('West');
INSERT INTO dim_product(product_name,category,subcategory) VALUES('Laptop','Electronics','Computers'),('Desk','Furniture','Office'),('Phone','Electronics','Mobile');
INSERT INTO dim_customer(customer_code,customer_segment) VALUES('C001','Consumer'),('C002','Corporate'),('C003','Small Business');
INSERT INTO fact_sales(order_id,date_key,region_key,product_key,customer_key,quantity,sales_amount,discount_amount,cost_amount) VALUES('O-1001',20240101,1,1,1,2,1800,100,1300),('O-1002',20240102,2,2,2,4,960,40,600),('O-1003',20240201,3,3,3,3,2100,0,1500),('O-1004',20240301,4,1,2,1,900,50,650),('O-1005',20240301,1,2,1,5,1200,100,750);
