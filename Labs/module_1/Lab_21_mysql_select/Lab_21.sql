create database publications;
use publications;

# Q1
select a.au_id, au_fname, au_lname , t.title, pub_name from publications.titleauthor ta
left join publications.authors a
	on a.au_id = ta.au_id
left join publications.titles t
	on ta.title_id = t.title_id
left join publications.publishers p 
	on t.pub_id = p.pub_id;
    

# Q2
with combination as (
select a.au_id, au_fname, au_lname , t.title, pub_name from publications.titleauthor ta
left join publications.authors a
	on a.au_id = ta.au_id
left join publications.titles t
	on ta.title_id = t.title_id
left join publications.publishers p 
	on t.pub_id = p.pub_id)
    
select au_id, au_fname, au_lname, pub_name, count(title) as book_cnt
from combination
group by 1,2,3,4;

# Q3
with combination as (
select a.au_id, au_fname, au_lname , t.title, pub_name from publications.titleauthor ta
left join publications.authors a
	on a.au_id = ta.au_id
left join publications.titles t
	on ta.title_id = t.title_id
left join publications.publishers p 
	on t.pub_id = p.pub_id)
    
select au_id, au_fname, au_lname, count(title) as book_cnt
from combination
group by 1,2,3
order by 4 desc limit 3;

# Q4
select a.au_id, au_fname, au_lname, count(title_id) as nb_book from publications.authors a 
left join publications.titleauthor ta
	on ta.au_id = a.au_id
group by 1,2,3