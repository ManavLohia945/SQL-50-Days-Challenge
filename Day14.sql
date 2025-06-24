
CREATE TABLE customers6 (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    customer_email VARCHAR(100)
);

CREATE TABLE orders6 (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers6(customer_id)
);

INSERT INTO customers6 (customer_id, customer_name, customer_email) VALUES
(1, 'John Doe', 'john@example.com'),
(2, 'Jane Smith', 'jane@example.com'),
(3, 'Alice Johnson', 'alice@example.com'),
(4, 'Bob Brown', 'bob@example.com');

INSERT INTO orders6 (order_id, customer_id, order_date, order_amount) VALUES
(1, 1, '2024-01-03', 50.00),
(2, 2, '2024-01-05', 75.00),
(3, 1, '2024-01-10', 25.00),
(4, 3, '2024-01-15', 60.00),
(5, 2, '2024-01-20', 50.00),
(6, 1, '2024-02-01', 100.00),
(7, 2, '2024-02-05', 25.00),
(8, 3, '2024-02-10', 90.00),
(9, 1, '2024-02-15', 50.00),
(10, 2, '2024-02-20', 75.00);

SELECT * 
FROM customers6 as c
RIGHT JOIN orders6 as o
ON c.customer_id = o.customer_id

-- Find the top 2 customers who have spent the most money across all their orders. 
-- Return their names, emails, and total amounts spent.

SELECT c.customer_name, c.customer_email, SUM(o.order_amount)
FROM customers6 as c
RIGHT JOIN orders6 as o
ON c.customer_id = o.customer_id
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 2







