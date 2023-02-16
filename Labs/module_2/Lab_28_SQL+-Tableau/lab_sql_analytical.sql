use sakila;
select customer_id, 
		date(payment_date) as payment_date,
        amount, 
        sum(amount) over (partition by customer_id order by payment_date) as running_total
from payment;

select date(payment_date) as payment_date,
	   amount,
       rank() over (partition by date(payment_date) order by amount desc) as rnk,
       dense_rank() over (partition by date(payment_date) order by amount desc) as dens_rnk
from payment;


select * from
(select c.name as category,
		f.title, 
        rental_rate ,
        rank() over (partition by c.name order by rental_rate desc) as rnk,
        dense_rank() over (partition by c.name order by rental_rate desc) as dense_rnk,
        row_number() over (partition by c.name order by rental_rate desc) as row_num
from film f
left join film_category fc
	on f.film_id = fc.film_id
left join category c
	on fc.category_id = c.category_id) com
where row_num <=5;


select payment_id,
	   customer_id,
       date(payment_date) as payment_date,
       amount,
       amount - lag(amount) over (partition by customer_id order by date(payment_date) ) diff_from_prev,
       amount - lead(amount) over (partition by customer_id order by date(payment_date) )diff_from_next
from payment

