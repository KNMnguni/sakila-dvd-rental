/* What is the month to month difference in payments from the TOP 10 customers? */

WITH t1 AS (SELECT c.first_name || ' ' || c.last_name customer_name,
			SUM(p.amount) sum_amount
			FROM customer c
			JOIN payment p
			ON c.customer_id = p.customer_id
			WHERE DATE_TRUNC('month', p.payment_date) BETWEEN '2007-01-01'
				AND '2008-01-01'
			GROUP BY 1
			ORDER BY 2 DESC
			LIMIT 10),
	 t2 AS (SELECT DATE_TRUNC('month', p.payment_date) pay_mon,
			c.first_name || ' ' || c.last_name customer_name,
			COUNT(p.amount)pay_countpermon,
			SUM(p.amount) pay_amount
			FROM customer c
			JOIN payment p
			ON c.customer_id = p.customer_id
            WHERE DATE_TRUNC('month', p.payment_date) BETWEEN '2007-01-01'
				AND '2008-01-01'
		    GROUP BY 1,2)
			
SELECT pay_mon, 
		t1.customer_name, 
		pay_countpermon, 
		pay_amount,
		pay_amount - LAG(pay_amount,1) OVER (PARTITION BY t1.customer_name ORDER BY pay_mon) AS prev_mon_diff
FROM t1
JOIN t2
ON t1.customer_name = t2.customer_name
ORDER BY 2,1;