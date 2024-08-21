USE ECommerceDB;

SELECT * FROM Customers;
SELECT * FROM OrderDetails;
SELECT * FROM Orders;
SELECT * FROM Products;
    
--Finding total number of orders placed by a Customer

SELECT customer_id, COUNT(order_id) as Num_orders
FROM Orders
GROUP BY customer_id;

--Finding quantity of each type of product sold

SELECT product_id, SUM(quantity) as sold_num
FROM OrderDetails
GROUP BY product_id;

-- Customers having placed more than 2 orders
SELECT customer_id,COUNT(order_id) AS num_orders
FROM Orders
GROUP BY customer_id
HAVING COUNT(order_id) > 2;

-- Total Aggregation

--Average price of all Products
SELECT AVG(price) as AvgPrice
FROM Products;

--Number of orders between date range
SELECT COUNT(order_id) AS orders
FROM Orders
WHERE order_date BETWEEN '2024-01-01' AND '2024-07-30';

--All orders placed in last 30 days
SELECT * FROM Orders
WHERE order_date >= DATEADD(DAY, -30, GETDATE());

--What the day was on for a particular order_id
SELECT DATENAME(WEEKDAY, (SELECT TOP 1 order_date FROM Orders WHERE order_id = 3)) AS Day,
DATENAME(DAY, (SELECT TOP 1 order_date FROM Orders WHERE order_id = 3)) AS Date,
DATENAME(MONTH, (SELECT TOP 1 order_date FROM Orders WHERE order_id = 3)) AS Month;

--Getting all customer names in Uppercase
SELECT UPPER(customer_name) AS UcaseName
FROM Customers;

-- using Subquery to find Customer who placed the most recent order
SELECT customer_name
FROM Customers
WHERE customer_id = (
    SELECT TOP 1 customer_id
    FROM Orders
    ORDER BY order_date DESC
);

-- Basic Join Query
--Finding Products which have been ordered more than once

SELECT P.product_name, SUM(OD.quantity) AS quant
FROM Products P
JOIN OrderDetails OD ON P.product_id = OD. product_id
GROUP BY P.product_name
HAVING SUM(OD.quantity) > 1;

-- Finding if any orders were placed on specific dates
SELECT order_id, order_date
FROM Orders
WHERE order_date IN ( '2024-04-10', '2024-04-09', '2024-04-16');

--Order of Execution
SELECT product_id, SUM(quantity) AS total_quantity
FROM OrderDetails
WHERE quantity > 1
GROUP BY product_id
HAVING SUM(quantity) > 2
ORDER BY total_quantity DESC
OFFSET 0 ROWS
FETCH NEXT 3 ROWS ONLY;
