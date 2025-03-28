--Solution 1
SELECT 
city,
count(status) as total_orders
FROM trades t JOIN users u
ON (t.user_id = u.user_id)
WHERE status='Completed'
Group BY city
ORDER BY total_orders desc
LIMIT 3;

--Solution 2
WITH cte AS(
SELECT 
city,
count(status) as total_orders,
dense_rank() over(order by count(status) desc) as rnk
FROM trades t JOIN users u
ON (t.user_id = u.user_id)
WHERE status='Completed'
Group BY city)
SELECT city , total_orders
FROM cte WHERE rnk<4;
