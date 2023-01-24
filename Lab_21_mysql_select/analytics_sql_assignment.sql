create database costco;
use costco;

/* CREATE AND POPULATE USER TABLE*/

create table users (
name VARCHAR(255),
date_joined date);

insert into users
values ('John',str_to_date('2011-01-01', '%Y-%m-%d')),
('Dave',str_to_date('2009-04-02', '%Y-%m-%d')),
('Mary',str_to_date('2008-03-04', '%Y-%m-%d'));

/* CREATE AND POPULATE PURCHASE TABLE*/
create table purchases (
user VARCHAR(255),
date_purchased date,
item VARCHAR(255),
price FLOAT);

insert into purchases 
values ('John',str_to_date('2011-02-04', '%Y-%m-%d'),'SK2341',34.54),
('John',str_to_date('2012-01-04', '%Y-%m-%d'),'LS2414', 94.98);


########################## PART 1 ##########################

# Q1
select name, coalesce(sum(price),0) as ex_user
from users u 
left join purchases p 
	on u.name = p.user
group by 1;


select item, coalesce(sum(price),0) as ex_item
from users u 
left join purchases p 
	on u.name = p.user
    group by 1;

with com as (select name, coalesce(sum(price),0) as ex_user
from users u 
left join purchases p 
	on u.name = p.user
    group by 1)
    
select (select count(name) from com where ex_user = 0) / (select count(name) from com) as percentage;

# Q2
select item, 
extract(month from date_purchased) as month,
sum(price) as sales from purchases
group by 1, 2 order by 1, 2;


########################## PART 2 ##########################

create table employees (
employee_id INT,
manager_id INT, 
employee_name VARCHAR(255)
);

INSERT INTO employees
VALUES (1, 2, 'Jane'),
(2, 3, 'Henry'),
(3, null, 'Kate'),
(4, 2, 'Moe'),
(5, 2, 'Larry');

# Q1
select e1.employee_id, e1.employee_name, e2.employee_name as manager_name from employees e1
left join employees e2
	on e1.manager_id = e2.employee_id;
    
# Q2
select employee_id, 
date_training, 
count(training_id) as nb_training 
from training_details
group by 1, 2
having nb_training > 1;

select *  from training_details
where employee_id = previous_employee_id
and date_training = previous_date_training