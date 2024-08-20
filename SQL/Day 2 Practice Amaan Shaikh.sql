CREATE DATABASE HexaRevise;
USE HexaRevise;

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary DECIMAL(10, 2),
    department_id INT,
    hire_date DATE,
    manager_id INT
);


CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);


CREATE TABLE Projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    start_date DATE,
    end_date DATE,
    budget DECIMAL(15, 2)
);


CREATE TABLE employee_project (
    emp_id INT,
    project_id INT,
    assigned_date DATE,
    role VARCHAR(50),
    PRIMARY KEY (emp_id, project_id),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);


CREATE TABLE salary_history (
    emp_id INT,
    salary DECIMAL(10, 2),
    change_date DATE,
    PRIMARY KEY (emp_id, change_date),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);


INSERT INTO departments (dept_id, dept_name, location) VALUES 
(1, 'HR', 'New York'),
(2, 'Finance', 'London'),
(3, 'IT', 'San Francisco'),
(4, 'Marketing', 'Chicago');


INSERT INTO employees (emp_id, first_name, last_name, salary, department_id, hire_date, manager_id) VALUES 
(1001, 'John', 'Doe', 75000.00, 3, '2020-01-15', NULL),
(1002, 'Jane', 'Smith', 85000.00, 2, '2019-03-10', 1001),
(1003, 'Emily', 'Jones', 60000.00, 1, '2021-06-25', 1002),
(1004, 'Michael', 'Brown', 95000.00, 3, '2018-11-01', 1001),
(1005, 'Jessica', 'Williams', 70000.00, 4, '2020-05-18', 1004);


INSERT INTO projects (project_id, project_name, start_date, end_date, budget) VALUES 
(101, 'Project Alpha', '2021-01-10', '2021-12-31', 500000.00),
(102, 'Project Beta', '2020-06-15', '2021-03-15', 300000.00),
(103, 'Project Gamma', '2022-01-01', '2022-12-31', 700000.00);


INSERT INTO employee_project (emp_id, project_id, assigned_date, role) VALUES 
(1001, 101, '2021-01-15', 'Project Manager'),
(1002, 101, '2021-01-20', 'Analyst'),
(1003, 102, '2020-06-20', 'HR Specialist'),
(1004, 103, '2022-01-05', 'Developer'),
(1005, 103, '2022-01-07', 'Marketing Lead');


INSERT INTO salary_history (emp_id, salary, change_date) VALUES 
(1001, 70000.00, '2019-12-01'),
(1001, 75000.00, '2020-12-01'),
(1002, 80000.00, '2018-12-01'),
(1002, 85000.00, '2019-12-01'),
(1003, 60000.00, '2021-06-25'),
(1004, 90000.00, '2018-10-01'),
(1004, 95000.00, '2019-11-01'),
(1005, 70000.00, '2020-05-18');

--- Using inbuilt functions - Mathematical, String, Date

--String

SELECT ASCII(Employees.first_name) as ASval
FROM Employees
WHERE emp_id = 1001;

SELECT CHAR(74) AS AsVal74;

SELECT LEN(location) AS Loclen
FROM Departments
WHERE dept_id = 3;

SELECT LOWER(first_name) as lcase, UPPER(first_name) AS ucase
FROM Employees
WHERE emp_id = 1004;

SELECT STR(1098.56) AS CharConv;

SELECT REVERSE(location) as revLoc
FROM Departments
WHERE dept_id = 2;

SELECT REPLACE(first_name, 'J', 'K')
FROM Employees
WHERE emp_id = 1001;

-- Mathematical

SELECT CEILING(salary) as ceil, FLOOR(salary) as floor
FROM salary_history
WHERE emp_id = 1003;

SELECT ROUND(salary, 1) as roundsal
FROM Salary_history
WHERE emp_id = 1001;

SELECT ABS(-77);

SELECT EXP(4.5);

SELECT SIN(1.5);

SELECT LOG(12.45) AS log, POWER(12,4) AS Pow, EXP(14.45) as expo;


--- Date

SELECT GETDATE();

SELECT DAY(GETDATE()) AS dd,MONTH(GETDATE()) AS mm, YEAR(GETDATE()) AS YY;

SELECT DATEADD(DAY, 7, hire_date) FROM Employees;
SELECT DATEADD(MONTH, 2, hire_date) FROM Employees;
SELECT DATEADD(YEAR, -1, hire_date) FROM Employees;

SELECT DATENAME(DAY, GETDATE());
SELECT DATENAME(WEEKDAY, hire_date) FROM Employees;
SELECT DATENAME(MONTH, hire_date) FROM Employees WHERE emp_id = 1002;
SELECT DATENAME(YEAR, GETDATE());


SELECT DATEDIFF(YEAR, start_date, GETDATE()) FROM Projects WHERE project_name = 'Project Alpha';
SELECT DATEDIFF(MONTH, start_date, GETDATE()) FROM Projects WHERE project_name = 'Project Alpha';
SELECT DATEDIFF(DAY, start_date, GETDATE()) FROM Projects WHERE project_name = 'Project Alpha';



--- GROUP BY, ORDER BY, HAVING, Aggregate Functions, COMPUTE

SELECT department_id, AVG(salary) AS avg_salary
FROM Employees
GROUP BY department_id;

SELECT YEAR(start_date) AS project_year, SUM(budget) AS total_budget
FROM Projects
GROUP BY YEAR(start_date);

SELECT first_name, last_name, hire_date
FROM employees
ORDER BY hire_date ASC;

SELECT project_name, budget
FROM projects
ORDER BY budget DESC;

SELECT project_name, SUM(budget) AS total_budget
FROM projects
GROUP BY project_name
HAVING SUM(budget) > 500000;

SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id
HAVING AVG(salary) > 75000;


--- UNION, UNION ALL

SELECT project_name FROM projects WHERE budget > 400000
UNION
SELECT project_name FROM projects WHERE end_date < '2021-12-31';


SELECT project_name FROM projects WHERE budget > 400000
UNION ALL
SELECT project_name FROM projects WHERE end_date < '2021-12-31';


--- DCL Commands
---GRANT SELECT ON HexaRevise.employees TO 'user1';
---REVOKE SELECT ON HexaRevise.employees FROM 'user1';


--- TCL Commands - COMMIT, ROLLBAKC, SAVEPOINT.


BEGIN;

UPDATE employees
SET salary = salary * 1.05
WHERE department_id = 4;

SAVE TRANSACTION before_bonus;

UPDATE employees
SET salary = salary * 1.10
WHERE department_id = 3;

ROLLBACK TRANSACTION before_bonus;

COMMIT;





