/* How many rentals were made across the stores? */

SELECT DATE_PART('month', r.rental_date) rental_month, 
		DATE_PART('year', r.rental_date)rental_year, 
		i.store_id, 
		COUNT(r.inventory_id)count_rentals
FROM inventory i
JOIN rental r
  ON i.inventory_id = r.inventory_id
GROUP BY 1,2,3
ORDER BY 4 DESC;