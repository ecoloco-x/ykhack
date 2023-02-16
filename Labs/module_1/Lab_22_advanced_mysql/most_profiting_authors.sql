USE publications;

#########################
####### SUBQUERY ########
#########################


SELECT au_id,
	   SUM(advance_final) AS advance_final,
       SUM(sales_royalty) AS sales_final,
       SUM(advance_final + sales_royalty) AS profit_total
FROM
(SELECT title_id, 
	   au_id, 
	   ROUND(advance * royaltyper / 100.0, 2) AS advance_final,
       ROUND(price * sales_ttl * royalty / 100.0 * royaltyper / 100.0, 2) AS sales_royalty
FROM (
SELECT s.title_id,
	   au_id,
       SUM(qty) AS sales_ttl,
	   AVG(royaltyper) AS royaltyper,
       AVG(advance) AS advance,
       AVG(price) AS price,
       AVG(royalty) AS royalty
FROM sales s
LEFT JOIN titleauthor ta
	ON s.title_id = ta.title_id
LEFT JOIN titles t
	ON t.title_id = s.title_id
GROUP BY 1, 2
-- ORDER BY s.title_id, au_id
		) A
) B
GROUP BY 1 ;
    
    
    
    
##########################
####### TEMP TABLE #######
##########################


CREATE TEMPORARY TABLE IF NOT EXISTS temp
SELECT s.title_id,
	   au_id,
       SUM(qty) AS sales_ttl,
	   AVG(royaltyper) AS royaltyper,
       AVG(advance) AS advance,
       AVG(price) AS price,
       AVG(royalty) AS royalty
FROM sales s
LEFT JOIN titleauthor ta
	ON s.title_id = ta.title_id
LEFT JOIN titles t
	ON t.title_id = s.title_id
GROUP BY 1, 2
-- ORDER BY s.title_id, au_id
;

SELECT temp.au_id, 
       concat(a.au_fname,' ',a.au_lname) as tuthor_name,
       SUM(sales_ttl) AS sales_ttl,
	   SUM(ROUND(advance * royaltyper / 100.0, 2)) AS advance_final,
       SUM(ROUND(price * sales_ttl * royalty / 100.0 * royaltyper / 100.0, 2)) AS sales_royalty,
       SUM((ROUND(advance * royaltyper / 100.0, 2) + ROUND(price * sales_ttl * royalty / 100.0 * royaltyper / 100.0, 2))) AS profit_total
FROM temp
LEFT JOIN authors a
ON temp.au_id = a.au_id
GROUP  BY 1 , 2
ORDER BY profit_total DESC
;


#######################
##### CHALLENGE 3 #####
#######################
## DROP TABLE most_profiting_authors;
CREATE TABLE IF NOT EXISTS most_profiting_authors
SELECT au_id,
	   SUM(profit_total) as profit_total
FROM
(
SELECT title_id, 
	   au_id,
       advance_final,
       sales_royalty,
       (advance_final + sales_royalty) AS profit_total
FROM
	(SELECT title_id, 
	   au_id, 
	   ROUND(advance * royaltyper / 100.0, 2) AS advance_final,
       ROUND(price * sales_ttl * royalty / 100.0 * royaltyper / 100.0, 2) AS sales_royalty
FROM (
SELECT s.title_id,
	   au_id,
       SUM(qty) AS sales_ttl,
	   AVG(royaltyper) AS royaltyper,
       AVG(advance) AS advance,
       AVG(price) AS price,
       AVG(royalty) AS royalty
FROM sales s
LEFT JOIN titleauthor ta
	ON s.title_id = ta.title_id
LEFT JOIN titles t
	ON t.title_id = s.title_id
GROUP BY 1, 2
-- ORDER BY s.title_id, au_id
		) A
	) B
) C
GROUP BY 1;

SELECT * FROM most_profiting_authors
ORDER BY profit_total DESC.