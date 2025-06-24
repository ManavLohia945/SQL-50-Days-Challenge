CREATE TABLE Delivery (
    delivery_id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    customer_pref_delivery_date DATE
);

-- Insert data into the Delivery table
INSERT INTO Delivery (customer_id, order_date, customer_pref_delivery_date) VALUES
(1, '2019-08-01', '2019-08-02'),
(2, '2019-08-02', '2019-08-02'),
(1, '2019-08-11', '2019-08-12'),
(3, '2019-08-24', '2019-08-24'),
(3, '2019-08-21', '2019-08-22'),
(2, '2019-08-11', '2019-08-13'),
(4, '2019-08-09', '2019-08-09'),
(5, '2019-08-09', '2019-08-10'),
(4, '2019-08-10', '2019-08-12'),
(6, '2019-08-09', '2019-08-11'),
(7, '2019-08-12', '2019-08-13'),
(8, '2019-08-13', '2019-08-13'),
(9, '2019-08-11', '2019-08-12'); 

SELECT * FROM Delivery

--If the customer's preferred delivery date is the same as the order date, then the order is called immediate; otherwise, it is called scheduled.
--Write a solution to find the percentage of immediateorders in the first orders of all customers, rounded to 2 decimal places.

WITH cte1
AS
(
SELECT *, 
       CASE 
	        WHEN order_date = customer_pref_delivery_date THEN 'IMMEDIATE' 
			ELSE 'SCHEDULED'
	   END
	   AS order_type,
	   DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY order_date) as rank
FROM Delivery
ORDER BY 2,3
)
SELECT ROUND(100*COUNT(order_type)/(SELECT COUNT(delivery_id) FROM cte1 WHERE rank = 1),2)
FROM cte1
WHERE rank = 1 and order_type = 'IMMEDIATE'


------------ALTERNATE SOLUTION-------------------
SELECT 
   ROUND(
    SUM(
     CASE 
    WHEN 
    order_date = cpdd THEN 1
    ELSE 0
    END::numeric
   )/COUNT(*)::numeric * 100, 2) as imd_del_percentage
FROM
    (
    SELECT
        DISTINCT ON(customer_id)
        customer_id,
        order_date,
        customer_pref_delivery_date as cpdd
    FROM Delivery
    ORDER BY customer_id, order_date
)





