-- CTE to find the top 5 movies with the highest revenue in each category
WITH movie_revenue AS (
    SELECT film.title, category.name AS category, SUM(payment.amount) AS total_revenue
    FROM film
    JOIN film_category ON film.film_id = film_category.film_id
    JOIN category ON film_category.category_id = category.category_id
    JOIN inventory ON film.film_id = inventory.film_id
    JOIN rental ON inventory.inventory_id = rental.inventory_id
    JOIN payment ON rental.rental_id = payment.rental_id
    GROUP BY film.title, category.name
)
SELECT *
FROM movie_revenue
ORDER BY total_revenue DESC
LIMIT 5;

-- CTE to find customers with the highest average spend per rental
WITH customer_spend AS (
    SELECT customer.customer_id, customer.first_name, customer.last_name, AVG(payment.amount) AS avg_spend
    FROM customer
    JOIN rental ON customer.customer_id = rental.customer_id
    JOIN payment ON rental.rental_id = payment.rental_id
    GROUP BY customer.customer_id
)
SELECT *
FROM customer_spend
ORDER BY avg_spend DESC
LIMIT 10;

-- CTE to analyze rental counts by day of the week
WITH rental_by_day AS (
    SELECT EXTRACT(DOW FROM rental.rental_date) AS day_of_week, COUNT(rental.rental_id) AS total_rentals
    FROM rental
    GROUP BY day_of_week
)
SELECT day_of_week, total_rentals
FROM rental_by_day
ORDER BY total_rentals DESC;

