CREATE TABLE orders7 (
    order_id SERIAL PRIMARY KEY,
    order_date DATE,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2)
);

-- Inserting records for the current month
INSERT INTO orders7 (order_date, product_id, quantity, price) VALUES
    ('2024-04-01', 1, 10, 50.00),
    ('2024-04-02', 2, 8, 40.00),
    ('2024-04-03', 3, 15, 30.00),
    ('2024-04-04', 4, 12, 25.00),
    ('2024-04-05', 5, 5, 60.00),
    ('2024-04-06', 6, 20, 20.00),
    ('2024-04-07', 7, 18, 35.00),
    ('2024-04-08', 8, 14, 45.00),
    ('2024-04-09', 1, 10, 50.00),
    ('2024-04-10', 2, 8, 40.00);

-- Inserting records for the last month
INSERT INTO orders7 (order_date, product_id, quantity, price) VALUES
    ('2024-03-01', 1, 12, 50.00),
    ('2024-03-02', 2, 10, 40.00),
    ('2024-03-03', 3, 18, 30.00),
    ('2024-03-04', 4, 14, 25.00),
    ('2024-03-05', 5, 7, 60.00),
    ('2024-03-06', 6, 22, 20.00),
    ('2024-03-07', 7, 20, 35.00),
    ('2024-03-08', 8, 16, 45.00),
    ('2024-03-09', 1, 12, 50.00),
    ('2024-03-10', 2, 10, 40.00);

-- Inserting records for the previous month
INSERT INTO orders7 (order_date, product_id, quantity, price) VALUES
    ('2024-02-01', 1, 15, 50.00),
    ('2024-02-02', 2, 12, 40.00),
    ('2024-02-03', 3, 20, 30.00),
    ('2024-02-04', 4, 16, 25.00),
    ('2024-02-05', 5, 9, 60.00),
    ('2024-02-06', 6, 25, 20.00),
    ('2024-02-07', 7, 22, 35.00),
    ('2024-02-08', 8, 18, 45.00),
    ('2024-02-09', 1, 15, 50.00),
    ('2024-02-10', 2, 12, 40.00);

SELECT * FROM orders7;

/*
Write an SQL query to retrieve the product details for items whose revenue decreased compared to the previous month. 
Display the product ID, quantity sold, and revenue for both the current and previous months.
*/
WITH cte1
AS
(
SELECT product_id, 
       TO_CHAR(order_date,'YYYY-MM') as monthly_data, 
	   SUM(quantity) as total_units_sold, 
	   SUM(price) as revenue,
	   LAG(SUM(price),1) OVER(PARTITION BY product_id ORDER BY TO_CHAR(order_date,'YYYY-MM')) as prev_month_revenue
FROM orders7
GROUP BY 1,2
ORDER BY product_id, monthly_data
)
SELECT *
FROM cte1
WHERE prev_month_revenue > revenue
---------------------------------------------------ALTERNATE WITHOUT LAG FUNC--------------------------------
WITH current_month_revenue
AS
(    
    SELECT
        product_id,
        SUM(quantity) as qty_sold,
        SUM(price * quantity) as current_month_rev
    FROM orders7
    WHERE EXTRACT(MONTH FROM order_date) = EXTRACT(MONTH FROM CURRENT_DATE) 
    GROUP BY product_id
),
prev_month_revenue
AS    
(
    SELECT
        product_id,
        SUM(quantity) as qty_sold,
        SUM(price * quantity) as prev_month_rev
    FROM orders7
    WHERE EXTRACT(MONTH FROM order_date) = EXTRACT(MONTH FROM CURRENT_DATE)-1 
    GROUP BY product_id
)

SELECT
    cr.product_id,
    cr.qty_sold as cr_month_qty,
     pr.qty_sold as pr_month_qty,
    cr.current_month_rev,
    pr.prev_month_rev
FROM current_month_revenue as cr
JOIN 
prev_month_revenue as pr
ON cr.product_id = pr.product_id
WHERE cr.current_month_rev < pr.prev_month_rev


