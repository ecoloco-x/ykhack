USE publications;

#########################
####### SUBQUERY ########
#########################


SELECT *,
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
) B;
    
    
    
    
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

SELECT title_id, 
	   au_id, 
	   ROUND(advance * royaltyper / 100.0, 2) AS advance_final,
       ROUND(price * sales_ttl * royalty / 100.0 * royaltyper / 100.0, 2) AS sales_royalty,
       (ROUND(advance * royaltyper / 100.0, 2) + ROUND(price * sales_ttl * royalty / 100.0 * royaltyper / 100.0, 2)) AS profit_total
FROM temp
;


#######################
##### CHALLENGE 3 #####
#######################

CREATE TABLE IF NOT EXISTS most_profiting_authors
SELECT au_id,
	   profit_total
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
) C;

