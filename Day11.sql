CREATE TABLE orders4 (
    order_id VARCHAR(10),
    customer_id VARCHAR(10),
    order_date DATE,
    product_id VARCHAR(10),
    quantity INT
);

-- Create the returns table
CREATE TABLE returns4 (
    return_id VARCHAR(10),
    order_id VARCHAR(10)
    );

-- Insert sample records into the orders table
INSERT INTO orders4 (order_id, customer_id, order_date, product_id, quantity)
VALUES
    ('1001', 'C001', '2023-01-15', 'P001', 4),
    ('1002', 'C001', '2023-02-20', 'P002', 3),
    ('1003', 'C002', '2023-03-10', 'P003', 8),
    ('1004', 'C003', '2023-04-05', 'P004', 2),
    ('1005', 'C004', '2023-05-20', 'P005', 3),
    ('1006', 'C002', '2023-06-15', 'P001', 6),
    ('1007', 'C003', '2023-07-20', 'P002', 1),
    ('1008', 'C004', '2023-08-10', 'P003', 2),
    ('1009', 'C005', '2023-09-05', 'P002', 3),
    ('1010', 'C001', '2023-10-20', 'P002', 1);

-- Insert sample records into the returns table
INSERT INTO returns4 (return_id, order_id)
VALUES
    ('R001', '1001'),
    ('R002', '1002'),
    ('R003', '1005'),
    ('R004', '1008'),
    ('R005', '1007');
	
--Identify returning customers based on their order history. Categorize customers as "Returning" if they have placed more than one return, and as "New" otherwise. 
	
WITH cte1
AS
(
SELECT o.customer_id, COUNT(r.return_id) as count_of_return
FROM orders4 AS o
LEFT JOIN returns4 as r
ON o.order_id = r.order_id
GROUP BY 1
),cte2
AS
(
SELECT c.customer_id, c.count_of_return, 
       CASE 
	         WHEN c.count_of_return > 1 THEN 'Returning'
			 ELSE 'New'
	   END AS category
FROM cte1 as c
)
SELECT category, COUNT(category)
FROM cte2
GROUP BY 1




