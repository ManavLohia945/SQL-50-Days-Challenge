CREATE TABLE Customers3(
    CustomerID INT,
    CustomerName VARCHAR(50)
);

-- Create Purchases table
CREATE TABLE Purchases3 (
    PurchaseID INT,
    CustomerID INT,
    ProductName VARCHAR(50),
    PurchaseDate DATE
);

-- Insert sample data into Customers table
INSERT INTO Customers3 (CustomerID, CustomerName) VALUES
(1, 'John'),
(2, 'Emma'),
(3, 'Michael'),
(4, 'Ben'),
(5, 'John')	;

-- Insert sample data into Purchases table
INSERT INTO Purchases3 (PurchaseID, CustomerID, ProductName, PurchaseDate) VALUES
(100, 1, 'iPhone', '2024-01-01'),
(101, 1, 'MacBook', '2024-01-20'),	
(102, 1, 'Airpods', '2024-03-10'),
(103, 2, 'iPad', '2024-03-05'),
(104, 2, 'iPhone', '2024-03-15'),
(105, 3, 'MacBook', '2024-03-20'),
(106, 3, 'Airpods', '2024-03-25'),
(107, 4, 'iPhone', '2024-03-22'),	
(108, 4, 'Airpods', '2024-03-29'),
(110, 5, 'Airpods', '2024-02-29'),
(109, 5, 'iPhone', '2024-03-22');

SELECT * 
FROM customers3 as c
INNER JOIN purchases3 as p
ON c.customerid = p.customerid;

--Q: write a SQL query to find customers who bought Airpods after purchasing an iPhone.

WITH iphone_buyers
AS
(
SELECT c.customerid, c.customername, p.purchaseid, p.productname, p.purchasedate
FROM customers3 as c
INNER JOIN purchases3 as p
ON c.customerid = p.customerid
WHERE productname = 'iPhone'
), airpods_buyer
AS
(
SELECT c.customerid, c.customername, p.purchaseid, p.productname, p.purchasedate 
FROM customers3 as c
INNER JOIN purchases3 as p
ON c.customerid = p.customerid
WHERE productname = 'Airpods'
)
SELECT i.customerid, i.customername, i.purchaseid, a.purchasedate, i.purchasedate 
FROM iphone_buyers as i
INNER JOIN airpods_buyer as a
ON i.customerid = a.customerid
WHERE a.purchasedate > i.purchasedate 

--Find out what is the % of chance is there that the customer who bought MacBook will buy an Airpods


	












