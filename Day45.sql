CREATE TABLE Orders13 (
    Order_id INT PRIMARY KEY,
    Customer_id INT,
    Order_Date DATE,
    Amount DECIMAL(10, 2)
);


DROP TABLE IF EXISTS Customers;
-- Create Customers table
CREATE TABLE Customers13 (
    Customer_id INT PRIMARY KEY,
    Customer_Name VARCHAR(50),
    Join_Date DATE
);

-- Insert records into Orders table
INSERT INTO Orders13 (Order_id, Customer_id, Order_Date, Amount)
VALUES
    (1, 1, '2024-05-01', 100),
    (2, 2, '2024-05-02', 150),
    (3, 3, '2023-12-15', 200),
    (4, 1, '2024-05-03', 120),
    (5, 2, '2024-01-20', 180),
    (6, 4, '2024-03-10', 90);

-- Insert records into Customers table
INSERT INTO Customers13 (Customer_id, Customer_Name, Join_Date)
VALUES
    (1, 'Alice', '2024-01-15'),
    (2, 'Bob', '2024-02-20'),
    (3, 'Charlie', '2023-12-01'),
    (4, 'David', '2024-03-01');

SELECT *
FROM orders13 AS o
JOIN customers13 AS c
ON o.customer_id = c.customer_id

--Write an SQL query to calculate the total order amount for each customer who joined in the current year. 
--The output should contain Customer_Name and the total amount.

SELECT c.customer_name, SUM(o.amount)
FROM orders13 AS o
JOIN customers13 AS c
ON o.customer_id = c.customer_id
WHERE EXTRACT(YEAR FROM c.join_date) = 2024 
GROUP BY 1





	