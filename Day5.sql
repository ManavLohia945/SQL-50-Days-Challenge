DROP TABLE IF EXISTS Employees;
-- Create the Employee table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE
);

-- Insert sample records into the Employee table
INSERT INTO Employees (EmployeeID, Name, Department, Salary, HireDate) VALUES
(101, 'John Smith', 'Sales', 60000.00, '2022-01-15'),
(102, 'Jane Doe', 'Marketing', 55000.00, '2022-02-20'),
(103, 'Michael Johnson', 'Finance', 70000.00, '2021-12-10'),
(104, 'Emily Brown', 'Sales', 62000.00, '2022-03-05'),
(106, 'Sam Brown', 'IT', 62000.00, '2022-03-05'),	
(105, 'Chris Wilson', 'Marketing', 58000.00, '2022-01-30');

SELECT * FROM employees
--Write a SQL query to retrieve the third highest salary from the Employee table.

SELECT employeeid, name, department, w1.salary
FROM employees as w1
WHERE 3 = (
            SELECT COUNT(DISTINCT(w2.salary))
			FROM employees as w2
			WHERE w2.salary >= w1.salary
          )






