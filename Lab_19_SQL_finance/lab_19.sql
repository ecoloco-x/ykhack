### Q1
# 0.85 - 6735
select price from order_items
order by price desc limit 1;

select price from order_items
order by price limit 1;


### Q2
# 2016-09-19 02:15:34 to 2020-04-10 00:35:08
select shipping_limit_date from order_items
order by 1 limit 1;

select shipping_limit_date from order_items
order by 1 desc limit 1;


### Q3
# SP

select customer_state, count(*) as cnt from olist.customers
group by 1 order by 2 desc;

# Q4
# sal paulo

select customer_city, count(*) as cnt from olist.customers where customer_state like "SP"
group by 1 order by 2 desc;


# Q5 
select distinct business_segment from olist.closed_deals where business_segment is not null;

# Q6 
select business_segment, sum(declared_monthly_revenue) from olist.closed_deals 
group by 1 order by 2 desc limit 3;


# Q7
SELECT distinct review_score FROM olist.order_reviews limit 100;

# Q8

select * from olist.order_reviews limit 100;
# alter table olist.order_reviews 
# add descriptions VARCHAR(255);

update  olist.order_reviews
set descriptions = "Super" where review_score = 5;

update  olist.order_reviews
set descriptions = "Very Good" where review_score = 4;

update  olist.order_reviews
set descriptions = "Good" where review_score = 3;

update  olist.order_reviews
set descriptions = "OK" where review_score = 2;

update  olist.order_reviews
set descriptions = "Bad" where review_score = 1;

select review_score,descriptions, count(*) as cnt from olist.order_reviews
group by 1 ,2 order by 3 desc;


# Q9 
select review_score, count(*) as cnt from olist.order_reviews
group by 1 order by 2 desc;