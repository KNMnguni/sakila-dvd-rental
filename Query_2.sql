/* Question 2: How does the genre of Family Friendly movies influence Rental Duration? */

WITH t1 AS (SELECT f.title film_title, c.name category_name,f.rental_duration
            FROM film f
            JOIN film_category fc
              ON f.film_id = fc.film_id
            JOIN category c
              ON fc.category_id = c.category_id),
     t2 AS (SELECT film_title, category_name, rental_duration,
                NTILE(4) OVER (ORDER BY rental_duration) standard_quartile
            FROM t1
            WHERE (category_name = 'Animation' OR category_name = 'Children' OR category_name = 'Classics' 
	                 OR category_name = 'Comedy' OR category_name = 'Family' OR category_name = 'Music'))

SELECT category_name, standard_quartile, 
        COUNT(*)
FROM t2
GROUP BY 1,2
ORDER BY 1,2;