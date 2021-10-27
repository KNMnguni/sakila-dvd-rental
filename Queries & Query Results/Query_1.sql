/*Question 1: What were thetotal rental orders for Family Friendly Movies genres? */

WITH t1 AS (SELECT f.title film_title, c.name category_name, r.inventory_id rental
            FROM film f
            JOIN film_category fc
              ON f.film_id = fc.film_id
            JOIN category c
              ON fc.category_id = c.category_id
            JOIN inventory i
              ON f.film_id = i.film_id
            JOIN rental r
              ON i.inventory_id = r.inventory_id)
  
SELECT film_title, category_name, COUNT(rental) AS rental_count
FROM t1
WHERE (category_name = 'Animation' OR category_name = 'Children' OR category_name = 'Classics' 
	  OR category_name = 'Comedy' OR category_name = 'Family' OR category_name = 'Music')
GROUP BY 1,2
ORDER BY 2;