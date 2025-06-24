create table orders2(
  	category varchar(20),
	product varchar(20),
	user_id int , 
  	spend int,
  	transaction_date DATE
);

Insert into orders2 values
('appliance','refrigerator',165,246.00,'2021/12/26'),
('appliance','refrigerator',123,299.99,'2022/03/02'),
('appliance','washingmachine',123,219.80,'2022/03/02'),
('electronics','vacuum',178,152.00,'2022/04/05'),
('electronics','wirelessheadset',156,	249.90,'2022/07/08'),
('electronics','TV',145,189.00,'2022/07/15'),
('Television','TV',165,129.00,'2022/07/15'),
('Television','TV',163,129.00,'2022/07/15'),
('Television','TV',141,129.00,'2022/07/15'),
('toys','Ben10',145,189.00,'2022/07/15'),
('toys','Ben10',145,189.00,'2022/07/15'),
('toys','yoyo',165,129.00,'2022/07/15'),
('toys','yoyo',163,129.00,'2022/07/15'),
('toys','yoyo',141,129.00,'2022/07/15'),
('toys','yoyo',145,189.00,'2022/07/15'),
('electronics','vacuum',145,189.00,'2022/07/15');

SELECT * FROM orders2

--Find the top 2 products in the top 2 categories based on spend amount?
WITH top_categories
AS
(
SELECT category AS categories, SUM(spend)
FROM orders2
GROUP BY 1
ORDER BY 2 DESC 
LIMIT 2
), rank_based
AS
(
SELECT o.product, 
       t.categories, 
	   SUM(o.spend) as product_spend,
	   DENSE_RANK() OVER(PARTITION BY categories ORDER BY SUM(o.spend) DESC) as rank
FROM orders2 as o
JOIN top_categories as t
ON t.categories = o.category
GROUP BY 1,2
ORDER BY 2, 3 DESC
) SELECT * 
FROM rank_based
WHERE rank <= 2






