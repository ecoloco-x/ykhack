# Q1
select distinct prime_genre from ironhack_test.applestore;

# Q2
select prime_genre, count(distinct id) as cnt from ironhack_test.applestore
where rating_count_tot > 0
group by 1 order by 2 desc limit 1;

# Q3
select prime_genre, count(distinct id) as cnt from ironhack_test.applestore
group by 1 order by 2 desc limit 1;

# Q4
select prime_genre, count(distinct id) as cnt from ironhack_test.applestore
group by 1 order by 2 LIMIT 1;

# Q5
SELECT track_name , rating_count_tot from ironhack_test.applestore
order by 2 desc limit 10;

# Q6
SELECT track_name , user_rating from ironhack_test.applestore
order by 2 desc;

# Q10
SELECT track_name, rating_count_tot , user_rating, rating_count_tot * user_rating as ttl from ironhack_test.applestore
order by ttl desc limit 3;

# Q11
SELECT price, sum(rating_count_tot) as rating_cnt, avg(user_rating) as rating_avg from ironhack_test.applestore
group by price order by price;