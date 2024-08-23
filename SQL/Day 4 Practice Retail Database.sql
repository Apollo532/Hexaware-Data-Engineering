CREATE DATABASE RetailPractice;

USE RetailPractice;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY IDENTITY(1,1),
    customer_name VARCHAR(50),
    email VARCHAR(50),
    address VARCHAR(100)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY IDENTITY(1,1),
    product_name VARCHAR(50),
    price DECIMAL(10, 2)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE OrderDetails (
    detail_id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Customers (customer_name, email, address) VALUES
('John Doe', 'johndoe@example.com', 'New York'),
('Jane Smith', 'janesmith@example.com', 'Boston'),
('Robert Brown', 'robertbrown@example.com', 'Los Angeles'),
('Emily White', 'emilywhite@example.com', 'Boston'),
('Michael Green', 'michaelgreen@example.com', 'Washington DC');

INSERT INTO Products (product_name, price) VALUES
('Laptop', 1200.00),
('Smartphone', 800.00),
('Tablet', 400.00),
('Headphones', 150.00),
('Smartwatch', 250.00);

INSERT INTO Orders (customer_id, order_date) VALUES
(1, '2024-08-01'),
(2, '2024-08-02'),
(3, '2024-08-03'),
(4, '2024-08-04'),
(5, '2024-08-05'),
(1, '2024-08-06');

INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES
(1, 1, 2),
(1, 4, 1),
(2, 2, 1),
(3, 3, 3),
(4, 5, 1),
(5, 1, 1),
(6, 2, 2),
(6, 3, 1),
(6, 5, 1),
(6, 4, 2);

-- Inner Join -- Getting customer name with all their orders

SELECT O.order_id, O.order_date, C.customer_name
FROM Orders O
INNER JOIN Customers C ON O.customer_id = C.customer_id
ORDER BY C.customer_name;

-- Left Join -- All customers and their orders (including those who haven't placed an order yet)

INSERT INTO Customers(customer_name, email, address) VALUES
('Jim Halpert', 'halpertjim@dunmiff.com', 'Scranton');

SELECT C.customer_name, O.order_id, O.order_date
FROM Customers C
LEFT JOIN Orders O ON C.customer_id = O.customer_id
ORDER BY O.order_date;


-- Right Join -- Getting all orders, even those without customer info

INSERT INTO Orders(customer_id, order_date) VALUES
(NULL, '2024-08-17');

SELECT C.customer_name, O.order_id, O.order_date
FROM Customers C
RIGHT JOIN Orders O ON C.customer_id = O.customer_id;


--- Full outer and Cross Joins

SELECT C.customer_name, O.order_id, O.order_date
FROM Customers C
FULL OUTER JOIN Orders O ON C.customer_id = O.customer_id;

SELECT C.customer_name, P.product_name
FROM Customers C
CROSS JOIN Products P;

-- Equi Join -- Getting all order details

SELECT O.order_id, C.customer_name, P.product_name, OD.quantity
FROM Orders O
JOIN Customers C ON O.customer_id = C.customer_id
JOIN OrderDetails OD ON O.order_id = OD.order_id
JOIN Products P ON OD.product_id = P.product_id;


-- Self Join -- Finding customers having the same address
SELECT C1.customer_name AS Cust1, C1.address, C2.customer_name AS Cust2
FROM Customers C1
JOIN Customers C2 ON C1.address = C2.address AND C1.customer_id <> C2.customer_id;


--Grouping and Filtering Join Queries

-- Total Units of each product sold
SELECT P.product_name, SUM(OD.quantity) AS Units_Sold
FROM Products P
JOIN OrderDetails OD ON P.product_id = OD.product_id
GROUP BY P.product_name;

-- Showing customers with more than 1 order

SELECT C.customer_name, COUNT(O.order_id) AS Total_Orders
FROM Customers C
INNER JOIN Orders O ON C.customer_id = O.customer_id
GROUP BY customer_name
HAVING COUNT(O.order_id) > 1;


-- Using Subquerying

--Findign customers who have ordered for more than a certain value

SELECT customer_name
FROM Customers
WHERE customer_id IN (
	SELECT O.customer_id
	FROM Orders O
	INNER JOIN OrderDetails OD ON O.order_id = OD.order_id
	INNER JOIN Products P ON P.product_id = OD.product_id
	WHERE P.price > 250
	);


-- Products Ordered by customer - John Doe
--Nested

SELECT product_name
FROM Products
WHERE product_id IN (
	SELECT OD.product_id
	FROM OrderDetails OD
	WHERE OD.order_id IN (
		SELECT O.order_id
		FROM Orders O
		WHERE O.customer_id = (SELECT customer_id FROM Customers WHERE customer_name LIKE 'John Doe')
		)
		);


-- EXISTS, ANY and ALL Keywords

SELECT customer_name
FROM Customers C
WHERE EXISTS (
    SELECT 1
    FROM Orders O
    WHERE O.customer_id = 1
);

SELECT customer_name 
FROM Customers C
WHERE C.customer_id = ANY (
	SELECT O.customer_id
	FROM Orders O
	INNER JOIN OrderDetails OD ON O.order_id = OD.order_id
    INNER JOIN Products P ON OD.product_id = P.product_id
    WHERE p.price > 150);


SELECT O.order_id, O.order_date
FROM Orders O
WHERE O.order_date > ALL (
	SELECT O.order_date
	FROM Orders O
	INNER JOIN Customers C ON O.customer_id = C.customer_id
	WHERE C.address = 'Los Angeles');


-- UNION, EXCEPT, INTERSECT

SELECT customer_name AS name FROM Customers
UNION
SELECT product_name AS name FROM Products;


--Finding all customers who bought laptop and phone  -- INTERSECT
SELECT C.customer_name
FROM Customers C
INNER JOIN Orders O ON C.customer_id = O.customer_id
INNER JOIN OrderDetails OD ON O.order_id = OD.order_id
WHERE OD.product_id = (SELECT product_id FROM Products WHERE product_name = 'Laptop')
INTERSECT
SELECT C.customer_name
FROM Customers C
INNER JOIN Orders O ON C.customer_id = O.customer_id
INNER JOIN OrderDetails OD ON O.order_id = OD.order_id
WHERE OD.product_id = (SELECT product_id FROM Products WHERE product_name = 'Smartphone')



-- Bought Laptop but not Phone -- Same query but with EXCEPT
SELECT C.customer_name
FROM Customers C
INNER JOIN Orders O ON C.customer_id = O.customer_id
INNER JOIN OrderDetails OD ON O.order_id = OD.order_id
WHERE OD.product_id = (SELECT product_id FROM Products WHERE product_name = 'Laptop')
EXCEPT
SELECT C.customer_name
FROM Customers C
INNER JOIN Orders O ON C.customer_id = O.customer_id
INNER JOIN OrderDetails OD ON O.order_id = OD.order_id
WHERE OD.product_id = (SELECT product_id FROM Products WHERE product_name = 'Smartphone')

