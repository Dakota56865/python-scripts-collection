-- Query to find the top 10 highest-revenue movies
SELECT film.title, SUM(payment.amount) AS total_revenue
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY film.title
ORDER BY total_revenue DESC
LIMIT 10;

-- Query to find the average rental duration for all movies
SELECT AVG(DATE_PART('day', rental.return_date - rental.rental_date)) AS avg_rental_duration
FROM rental;


