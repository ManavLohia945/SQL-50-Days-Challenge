CREATE TABLE products2_2 (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    quantity_sold INT
);

-- Inserting sample data for products
INSERT INTO products2_2 (product_id, product_name, price, quantity_sold) VALUES
    (1, 'iPhone', 899.00, 600),
    (2, 'iMac', 1299.00, 150),
    (3, 'MacBook Pro', 1499.00, 500),
    (4, 'AirPods', 499.00, 800),
    (5, 'Accessories', 199.00, 300);

SELECT * 
FROM products2_2

--Calculate the percentage contribution of each product to total revenue?

SELECT sum(price) as total_revenue


SELECT product_id, product_name, price, ROUND(100*(price/SUM(price) OVER()),2) as percent
FROM products2_2
GROUP BY 1,2,3
ORDER BY 4 DESC

--------------ALTERNATE---------------------
SELECT product_id, product_name, price, ROUND(100*(price/(SELECT SUM(price) FROM products2_2)),2) as percent
FROM products2_2
GROUP BY 1,2,3
ORDER BY 4 DESC










