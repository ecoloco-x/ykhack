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

select customer_state, count(*) as cnt from customers
group by 1 order by 2 desc;


