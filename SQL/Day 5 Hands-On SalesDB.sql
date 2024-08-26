create database subtotal;

use subtotal;

CREATE TABLE
SalesList
(SalesMonth NVARCHAR(20), SalesQuartes  VARCHAR(5), SalesYear  SMALLINT, SalesTotal MONEY)
GO
INSERT INTO  SalesList(SalesMonth,SalesQuartes,SalesYear,SalesTotal) VALUES (N'March','Q1',2019,60)
INSERT INTO SalesList(SalesMonth,SalesQuartes,SalesYear,SalesTotal) VALUES (N'March','Q1',2020,50)
INSERT INTO SalesList(SalesMonth,SalesQuartes,SalesYear,SalesTotal) VALUES (N'May','Q2',2019,30)
INSERT INTO SalesList(SalesMonth,SalesQuartes,SalesYear,SalesTotal) VALUES (N'July','Q3',2020,10)
INSERT INTO SalesList(SalesMonth,SalesQuartes,SalesYear,SalesTotal) VALUES (N'November','Q4',2019,120)
INSERT INTO SalesList(SalesMonth,SalesQuartes,SalesYear,SalesTotal) VALUES (N'October','Q4',2019,150)
INSERT INTO SalesList(SalesMonth,SalesQuartes,SalesYear,SalesTotal) VALUES (N'November','Q4',2019,180)
INSERT INTO SalesList(SalesMonth,SalesQuartes,SalesYear,SalesTotal) VALUES (N'November','Q4',2020,120)
INSERT INTO SalesList(SalesMonth,SalesQuartes,SalesYear,SalesTotal) VALUES (N'July','Q3',2019,160)
INSERT INTO SalesList(SalesMonth,SalesQuartes,SalesYear,SalesTotal) VALUES (N'March','Q1',2020,170)
GO
SELECT  * FROM SalesList

SELECT  SalesYear, SUM(SalesTotal) AS SalesTotal FROM SalesList
GROUP BY ROLLUP(SalesYear); /* null is the grand total*/ 


SELECT  SalesYear,SalesQuartes, SUM(SalesTotal) AS SalesTotal
FROM SalesList GROUP BY ROLLUP(SalesYear, SalesQuartes); /* null is the grand total*/ 


SELECT SalesMonth, SalesQuartes,SalesYear, SUM(SalesTotal) AS TotalSales
FROM SalesList
GROUP BY ROLLUP(SalesMonth, SalesQuartes, SalesYear);


SELECT SalesYear, SalesQuartes, SUM(SalesTotal) AS SalesTotal ,
	GROUPING(SalesQuartes) AS SalesQuarterGrp,
	GROUPING(SalesYear) AS SYearGrp
FROM SalesList
GROUP BY ROLLUP(SalesYear, SalesQuartes);


SELECT SalesMonth,SalesTotal , 
ROW_NUMBER() OVER(ORDER BY NEWID()) AS RowNumber FROM SalesList;

---------- NEW DATABASE ------------------------------------------------------------------
CREATE DATABASE SalesAnalyticsDB;


USE SalesAnalyticsDB;


CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(15),
    address VARCHAR(255)
);


CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2),
    stock_quantity INT
);


CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);


CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);


INSERT INTO Customers (customer_id, customer_name, email, phone_number, address) VALUES
(1, 'John Doe', 'john.doe@example.com', '123-456-7890', '123 Elm Street'),
(2, 'Jane Smith', 'jane.smith@example.com', '987-654-3210', '456 Oak Avenue'),
(3, 'Alice Johnson', 'alice.j@example.com', '555-123-4567', '789 Pine Road'),
(4, 'Bob Brown', 'bob.brown@example.com', '444-987-6543', '321 Maple Boulevard');


INSERT INTO Products (product_id, product_name, category, price, stock_quantity) VALUES
(1, 'Laptop', 'Electronics', 1200.00, 10),
(2, 'Smartphone', 'Electronics', 800.00, 25),
(3, 'Tablet', 'Electronics', 400.00, 15),
(4, 'Headphones', 'Accessories', 100.00, 50),
(5, 'Monitor', 'Electronics', 300.00, 20);


INSERT INTO Orders (order_id, customer_id, order_date) VALUES
(1, 1, '2024-07-01'),
(2, 2, '2024-07-02'),
(3, 1, '2024-07-03'),
(4, 3, '2024-07-04'),
(5, 4, '2024-07-05');


INSERT INTO Sales (sale_id, order_id, product_id, quantity) VALUES
(1, 1, 1, 2),
(2, 2, 2, 1),
(3, 3, 3, 3),
(4, 4, 4, 4),
(5, 5, 1, 1),
(6, 1, 5, 1),
(7, 2, 4, 2),
(8, 3, 2, 2);


--Total Amount for each Sale

SELECT S.sale_id, S.order_id, S.product_id, S.quantity, P.price * S.quantity AS SalesTotal
FROM Sales S
JOIN Products P ON S.product_id = P.product_id;

--Ranking functions

SELECT product_id, SUM(quantity) AS units_sold,
	RANK() OVER(ORDER BY SUM(quantity) DESC) AS Salesrank
FROM Sales
GROUP BY(product_id);

SELECT product_id, SUM(quantity) AS units_sold,
	DENSE_RANK() OVER(ORDER BY SUM(quantity) DESC) AS Salesrank
FROM Sales
GROUP BY(product_id);

SELECT product_id, SUM(quantity) AS units_sold,
	ROW_NUMBER() OVER(ORDER BY SUM(quantity) DESC) AS Rownum
FROM Sales
GROUP BY(product_id);

SELECT product_id, SUM(quantity) AS units_sold,
	NTILE(3) OVER(ORDER BY SUM(quantity) DESC) AS Quartile
FROM Sales
GROUP BY(product_id);

----CTEs

WITH CustomerSales AS (
    SELECT O.customer_id, SUM(S.quantity * P.price) AS total_spent
    FROM Sales S
    JOIN Orders O ON S.order_id = O.order_id
    JOIN Products P ON S.product_id = P.product_id
    GROUP BY O.customer_id
)
SELECT * FROM CustomerSales WHERE total_spent > 1000;


---OVER() and PARTITION BY

--Running total of sales by product

SELECT product_id, order_id, quantity, 
	SUM(quantity) OVER(PARTITION BY product_id ORDER BY order_id) AS Quant_R_Total
FROM Sales;


--Average Sale quantity per order by Customer
SELECT O.customer_id, S.order_id, S.quantity,
	AVG(quantity) OVER(PARTITION BY customer_id) AS Avg_Q_perCustomer
FROM Sales S
JOIN Orders O ON S.order_id = O.order_id;



---ROLLUP and CUBE
SELECT category, SUM(price * stock_quantity) AS inventory_value, GROUPING(category) AS Total
FROM Products
GROUP BY ROLLUP(category);


SELECT category, SUM(price * stock_quantity) AS inventory_value, GROUPING(category) AS Total
FROM Products
GROUP BY CUBE(category);


---Correlated Subquery

-- Customers who have ordered a specific product
SELECT customer_name
FROM Customers C
WHERE EXISTS (
	SELECT 1
	FROM Orders O
	JOIN Sales S ON O.order_id = S.order_id
	JOIN Products P ON S.product_id = P.product_id
	WHERE P.product_name LIKE 'Laptop' AND O.customer_id = C.customer_id);


---PROCEDURE - that calculates and returns the total sale by Customer

CREATE PROCEDURE SalesbyCustomer 
	@CustId INT
AS
BEGIN
SELECT C.customer_name, SUM(S.quantity*P.Price) AS SalesValue
FROM Customers C
JOIN Orders O ON C.customer_id = O.order_id
JOIN Sales S ON O.order_id = S.order_id
JOIN Products P ON S.product_id = P.product_id
WHERE C.customer_id = @CustId
GROUP BY C.customer_name;
END;

EXEC SalesbyCustomer @CustId = 3;

