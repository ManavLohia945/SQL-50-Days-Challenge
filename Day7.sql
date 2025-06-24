DROP TABLE IF EXISTS employees;

-- Create the employee_salary table
CREATE TABLE employees (
    emp_id INT,
    name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10, 2)
);



-- Insert all records again to simulate duplicates
INSERT INTO employees(emp_id, name, department, salary) VALUES
(1, 'John Doe', 'Finance', 60000.00),
(2, 'Jane Smith', 'Finance', 65000.00), 
(2, 'Jane Smith', 'Finance', 65000.00),   -- Duplicate
(9, 'Lisa Anderson', 'Sales', 63000.00),
(9, 'Lisa Anderson', 'Sales', 63000.00),  -- Duplicate
(9, 'Lisa Anderson', 'Sales', 63000.00),  -- Duplicate
(10, 'Kevin Martinez', 'Sales', 61000.00);


SELECT * FROM employees

--How would you identify duplicate entries in a SQL in given table employees columns are emp_id, name, department, salary


SELECT COUNT(emp_id), name, department, salary
FROM employees
GROUP BY 2,3,4
HAVING(COUNT(emp_id) > 1)






