WITH tweet_count_per_user AS 
(SELECT user_id,  COUNT(tweet_id) AS tweet_bucket
FROM tweets
WHERE EXTRACT(YEAR fROM tweet_date)='2022'
GROUP BY user_id)
SELECT tweet_bucket, COUNT(user_id) AS users_num
FROM tweet_count_per_user
GROUP BY tweet_bucket
;
