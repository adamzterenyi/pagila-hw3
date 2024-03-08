/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */

SELECT DISTINCT d.customer_id, d.first_name, d.last_name FROM customer d
LEFT JOIN lateral (
    SELECT rental_id, rental_date, inventory_id, name FROM rental
    JOIN inventory USING (inventory_id)
    JOIN film_category USING (film_id)
    JOIN category e USING (category_id)
    WHERE customer_id = d.customer_id
    ORDER BY rental_date DESC
) cube on true
WHERE cube.name = 'Action'
GROUP BY d.customer_id HAVING count(d.customer_id) >= 4;
