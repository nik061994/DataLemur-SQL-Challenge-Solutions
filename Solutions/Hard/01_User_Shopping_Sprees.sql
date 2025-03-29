WITH ConsecutivePurchases AS (
    SELECT 
        user_id,
        transaction_date,
        -- Calculate the difference between the current and previous transaction_date
        transaction_date - LAG(transaction_date) OVER (PARTITION BY user_id ORDER BY transaction_date) AS day_diff
    FROM transactions 
),
SpreeGroups AS (
    SELECT
        user_id,
        transaction_date,
        -- Assign a group number to consecutive days for each user
        SUM(CASE WHEN day_diff = INTERVAL '1 day' THEN 0 ELSE 1 END) 
            OVER (PARTITION BY user_id ORDER BY transaction_date) AS spree_group
    FROM ConsecutivePurchases
)
SELECT DISTINCT user_id
FROM SpreeGroups
GROUP BY user_id, spree_group
HAVING COUNT(*) >= 3
ORDER BY user_id;
