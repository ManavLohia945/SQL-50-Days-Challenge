CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10, 2)
);

-- Insert records for three departments
INSERT INTO employees (name, department, salary) VALUES 
('John Doe', 'Engineering', 63000),
('Jane Smith', 'Engineering', 55000),
('Michael Johnson', 'Engineering', 64000),
('Emily Davis', 'Marketing', 58000),
('Chris Brown', 'Marketing', 56000),
('Emma Wilson', 'Marketing', 59000),
('Alex Lee', 'Sales', 58000),
('Sarah Adams', 'Sales', 58000),
('Ryan Clark', 'Sales', 61000);


SELECT * FROM EMPLOYEES;

--1ST OPTION 
--Write the SQL query to find the second highest salary
SELECT max(e1.salary) as second_highest
from employees as e1
WHERE salary < (
                  SELECT max(e2.salary)
				  FROM employees as e2
               )

--2ND OPTION 
SELECT name, department, salary
FROM Employees 
ORDER BY salary DESC
OFFSET 1 LIMIT 1;

--2ND HIGHEST IN EACH DEPT
SELECT e1.department, max(e1.salary) as second_highest
from employees as e1
WHERE e1.salary < (
                  SELECT max(e2.salary)
				  FROM employees as e2
				  WHERE e1.department = e2.department
               )
GROUP BY 1











