CREATE TABLE bank_transactions (
    transaction_id SERIAL PRIMARY KEY,
    bank_id INT,
    customer_id INT,
    transaction_amount DECIMAL(10, 2),
    transaction_type VARCHAR(10),
    transaction_date DATE
);

-- Insert sample records into bank_transactions
INSERT INTO bank_transactions (bank_id, customer_id, transaction_amount, transaction_type, transaction_date) VALUES
(1, 101, 500.00, 'credit', '2024-01-01'),
(1, 101, 200.00, 'debit', '2024-01-02'),
(1, 101, 300.00, 'credit', '2024-01-05'),
(1, 101, 150.00, 'debit', '2024-01-08'),
(1, 102, 1000.00, 'credit', '2024-01-01'),
(1, 102, 400.00, 'debit', '2024-01-03'),
(1, 102, 600.00, 'credit', '2024-01-05'),
(1, 102, 200.00, 'debit', '2024-01-09');

--Write a query to find starting and ending trans amount for each customer
--Return cx_id, their first_transaction_amt, last_transaction and these transaction_date


WITH CTE1
AS
(
    SELECT *,
        ROW_NUMBER() OVER(PARTITION BY customer_id 
        ORDER BY transaction_date) as rn    
    FROM bank_transactions
),
CTE2 -- first_trans_details
AS    
(
    SELECT 
        customer_id,
        transaction_amount,
        transaction_date
    FROM CTE1
    WHERE rn = (SELECT MIN(rn) FROM CTE1)
),
CTE3 -- -- last_trans_details
AS    
(
    SELECT 
        customer_id,
        transaction_amount,
        transaction_date
    FROM CTE1
    WHERE rn = (SELECT MAX(rn) FROM CTE1)
)

SELECT 
    CTE2.customer_id,
    CTE2.transaction_amount as first_trans_amt,
    CTE2.transaction_date as first_trans_date,
    CTE3.transaction_amount as last_trans_amt,
    CTE3.transaction_date as last_trans_date
FROM CTE2
JOIN
CTE3 
ON CTE2.customer_id = CTE3.customer_id



