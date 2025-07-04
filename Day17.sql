CREATE TABLE Customers8 (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);


DROP TABLE IF EXISTS purchases;
-- Creating the Purchases table
CREATE TABLE Purchases8 (
    purchase_id INT PRIMARY KEY,
    customer_id INT,
    product_category VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES Customers8(customer_id)
);

-- Inserting sample data into Customers table
INSERT INTO Customers8 (customer_id, customer_name) VALUES
    (1, 'Alice'),
    (2, 'Bob'),
    (3, 'Charlie'),
    (4, 'David'),
    (5, 'Emma');

-- Inserting sample data into Purchases table
INSERT INTO Purchases8 (purchase_id, customer_id, product_category) VALUES
    (101, 1, 'Electronics'),
    (102, 1, 'Books'),
    (103, 1, 'Clothing'),
    (104, 1, 'Electronics'),
    (105, 2, 'Clothing'),
    (106, 1, 'Beauty'),
    (107, 3, 'Electronics'),
    (108, 3, 'Books'),
    (109, 4, 'Books'),
    (110, 4, 'Clothing'),
    (111, 4, 'Beauty'),
    (112, 5, 'Electronics'),
    (113, 5, 'Books');


SELECT * 
FROM customers8 AS c
JOIN purchases8 AS p
ON c.customer_id = p.customer_id

--Write an SQL query to find customers who have made purchases in all product categories.

SELECT c.customer_id, c.customer_name, COUNT(DISTINCT(p.product_category))
FROM customers8 AS c
JOIN purchases8 AS p
ON c.customer_id = p.customer_id
GROUP BY 1,2
HAVING COUNT(DISTINCT(p.product_category)) =  
         (
         SELECT COUNT(DISTINCT(product_category))
         FROM purchases8
		 )









	