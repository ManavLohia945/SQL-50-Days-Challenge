DROP TABLE IF EXISTS Products;
CREATE TABLE Products2 (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

-- Insert sample records into Product table
INSERT INTO Products2 (product_name, category, price) VALUES
('Product A', 'Category 1', 10.00),
('Product B', 'Category 2', 15.00),
('Product C', 'Category 1', 20.00),
('Product D', 'Category 3', 25.00);


-- Create Sales table
DROP TABLE IF EXISTS Sales;
CREATE TABLE Sales (
    sale_id SERIAL PRIMARY KEY,
    product_id INT,
    sale_date DATE,
    quantity INT,
    FOREIGN KEY (product_id) REFERENCES Products2(product_id)
);

-- Insert sample records into Sales table
INSERT INTO Sales (product_id, sale_date, quantity) VALUES
(1, '2023-09-15', 5),
(2, '2023-10-20', 3),
(1, '2024-01-05', 2),
(3, '2024-02-10', 4),
(4, '2023-12-03', 1);


--Write a SQL query to find all products that haven't been sold in the last six months.

SELECT
	p.*,
	s.sale_date
FROM products2 as p	
LEFT JOIN 
sales as s	
ON p.product_id = s.product_id	
WHERE s.sale_date IS NULL OR
s.sale_date < CURRENT_DATE - INTERVAL '6 month'






