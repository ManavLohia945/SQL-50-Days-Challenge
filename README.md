# SQL Interview Question Solve Challenge

Welcome to the SQL Interview Question Solve Challenge repository! In this repository, you'll find solutions to common SQL interview questions tailored for Data Analysts and Business Analysts. This repository is part of our YouTube series where we tackle one SQL interview question per day for 50 days.

## About the Series

Each day, we'll solve a different SQL interview question commonly asked by top tech companies like Amazon, Google, Facebook, and more. Our goal is to help aspiring data analysts and business analysts prepare for their interviews by providing detailed explanations and solutions to these questions.

## Getting Started

To get started with this repository, simply browse through the sections below to find solutions to specific interview questions. Each solution is accompanied by detailed SQL code snippets to help you understand the problem-solving process.

---

## Business Problems Solved

### 1️⃣ Apple Business Analyst Interview Question
**Find customers who bought Airpods after purchasing an iPhone**

```sql
-- SQL Setup
CREATE TABLE Customers3(
    CustomerID INT,
    CustomerName VARCHAR(50)
);

CREATE TABLE Purchases3 (
    PurchaseID INT,
    CustomerID INT,
    ProductName VARCHAR(50),
    PurchaseDate DATE
);

-- Sample Data
INSERT INTO Customers3 (CustomerID, CustomerName) VALUES
(1, 'John'), (2, 'Emma'), (3, 'Michael'), (4, 'Ben'), (5, 'John');

INSERT INTO Purchases3 (PurchaseID, CustomerID, ProductName, PurchaseDate) VALUES
(100, 1, 'iPhone', '2024-01-01'), (101, 1, 'MacBook', '2024-01-20'),
(102, 1, 'Airpods', '2024-03-10'), (103, 2, 'iPad', '2024-03-05'),
(104, 2, 'iPhone', '2024-03-15'), (105, 3, 'MacBook', '2024-03-20'),
(106, 3, 'Airpods', '2024-03-25'), (107, 4, 'iPhone', '2024-03-22'),
(108, 4, 'Airpods', '2024-03-29'), (110, 5, 'Airpods', '2024-02-29'),
(109, 5, 'iPhone', '2024-03-22');

-- Solution
WITH iphone_buyers AS (
  SELECT c.customerid, c.customername, p.purchaseid, p.productname, p.purchasedate
  FROM customers3 c
  INNER JOIN purchases3 p ON c.customerid = p.customerid
  WHERE productname = 'iPhone'
), airpods_buyer AS (
  SELECT c.customerid, c.customername, p.purchaseid, p.productname, p.purchasedate
  FROM customers3 c
  INNER JOIN purchases3 p ON c.customerid = p.customerid
  WHERE productname = 'Airpods'
)
SELECT i.customerid, i.customername, i.purchaseid, a.purchasedate AS airpods_date, i.purchasedate AS iphone_date
FROM iphone_buyers i
INNER JOIN airpods_buyer a ON i.customerid = a.customerid
WHERE a.purchasedate > i.purchasedate;
```

### 2️⃣ Swiggy Data Analyst Interview Question
**Identify returning customers based on their order history**

```sql
-- Setup
CREATE TABLE orders4 (
    order_id VARCHAR(10), customer_id VARCHAR(10), order_date DATE, product_id VARCHAR(10), quantity INT
);

CREATE TABLE returns4 (
    return_id VARCHAR(10), order_id VARCHAR(10)
);

-- Insert Data
-- (omitted for brevity)

-- Solution
WITH cte1 AS (
  SELECT o.customer_id, COUNT(r.return_id) as count_of_return
  FROM orders4 o
  LEFT JOIN returns4 r ON o.order_id = r.order_id
  GROUP BY 1
), cte2 AS (
  SELECT c.customer_id, c.count_of_return,
         CASE WHEN c.count_of_return > 1 THEN 'Returning' ELSE 'New' END AS category
  FROM cte1 c
)
SELECT category, COUNT(category)
FROM cte2
GROUP BY 1;
```

### 3️⃣ Flipkart Data Analyst Interview Question
**Find customers who have made purchases in all product categories**

```sql
-- Setup
CREATE TABLE Customers8 (
    customer_id INT PRIMARY KEY, customer_name VARCHAR(50)
);
CREATE TABLE Purchases8 (
    purchase_id INT PRIMARY KEY, customer_id INT, product_category VARCHAR(50)
);

-- Insert Data
-- (omitted for brevity)

-- Solution
SELECT c.customer_id, c.customer_name, COUNT(DISTINCT p.product_category)
FROM Customers8 c
JOIN Purchases8 p ON c.customer_id = p.customer_id
GROUP BY 1, 2
HAVING COUNT(DISTINCT p.product_category) = (
    SELECT COUNT(DISTINCT product_category) FROM Purchases8
);
```

### 4️⃣ Amazon Business Analyst Interview Question
**Find products sold by both Supplier A and Supplier B**

```sql
-- Setup and Insert Data for products10
-- (omitted for brevity)

-- Solution
SELECT product_id, product_name, COUNT(supplier_name) as cnt_sellers
FROM products10
WHERE supplier_name IN ('Supplier A', 'Supplier B')
GROUP BY product_id, product_name
HAVING COUNT(DISTINCT supplier_name) = 2;
```

### 5️⃣ Amazon Data Analyst Interview Question
**Identify returning active users (Amazon)**

```sql
-- Setup and Insert Data for amazon_transactions
-- (omitted for brevity)

-- Solution
WITH cte1 AS (
  SELECT *,
         LEAD(purchase_date) OVER(PARTITION BY user_id ORDER BY purchase_date) AS next_purchase_date,
         ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY purchase_date) AS row_num
  FROM amazon_transactions
), cte2 AS (
  SELECT user_id, next_purchase_date - purchase_date AS difference
  FROM cte1
  WHERE row_num = 1
)
SELECT user_id
FROM cte2
WHERE difference <= 7 AND difference IS NOT NULL;
```

### 6️⃣ Netflix Business Analyst Interview Question
**Unique users who flagged each video**

```sql
-- Setup and Insert Data for user_flags
-- (omitted for brevity)

-- Solution
SELECT video_id, COUNT(DISTINCT(CONCAT(user_firstname, user_lastname))) AS unique_flaggers
FROM user_flags
WHERE flag_id IS NOT NULL
GROUP BY video_id
ORDER BY unique_flaggers DESC;
```

### 7️⃣ AMEX Business Analyst Interview Question
**First and last transaction amounts for each customer**

```sql
-- Setup and Insert Data for bank_transactions
-- (omitted for brevity)

-- Solution
WITH CTE1 AS (
    SELECT *, ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY transaction_date) as rn
    FROM bank_transactions
),
CTE2 AS (
    SELECT customer_id, transaction_amount, transaction_date
    FROM CTE1 WHERE rn = 1
),
CTE3 AS (
    SELECT customer_id, transaction_amount, transaction_date
    FROM CTE1 WHERE rn = 2
)
SELECT CTE2.customer_id, CTE2.transaction_amount AS first_trans_amt, CTE2.transaction_date AS first_trans_date,
       CTE3.transaction_amount AS last_trans_amt, CTE3.transaction_date AS last_trans_date
FROM CTE2
JOIN CTE3 ON CTE2.customer_id = CTE3.customer_id;
```

### 8️⃣ Swiggy Business Analyst Interview Question
**Order pattern by hour with % contribution**

```sql
-- Setup and Insert Data for order_data
-- (omitted for brevity)

-- Solution
SELECT EXTRACT(HOUR FROM order_time) AS hourly_data,
       COUNT(customer_id) AS total_hourly_orders,
       ROUND(100 * COUNT(customer_id)::numeric / (SELECT COUNT(*) FROM order_data)::numeric, 2) AS order_percent_per_hr
FROM order_data
GROUP BY 1
ORDER BY order_percent_per_hr DESC;
```

---

**Prepared by:** Manav Lohia
---
**Project:** SQL 50-Day Interview Question Challenge
