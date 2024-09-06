-- Suquery to find the top 5 films that contributed the least to revenue
SELECT film_title, total_revenue
FROM (
    SELECT f.title AS film_title, SUM(p.amount) AS total_revenue
    FROM film f
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    JOIN payment p ON r.rental_id = p.rental_id
    GROUP BY f.title
) AS revenue_data
ORDER BY total_revenue ASC
LIMIT 5;

-- Subquery to find customers from regions with the highest rental frequency
WITH region_rentals AS (
    SELECT city.city AS region, COUNT(rental.rental_id) AS total_rentals, address.address_id
    FROM rental
    JOIN customer ON rental.customer_id = customer.customer_id
    JOIN address ON customer.address_id = address.address_id
    JOIN city ON address.city_id = city.city_id
    GROUP BY city.city, address.address_id
    ORDER BY total_rentals DESC
    LIMIT 5
)
SELECT customer.first_name, customer.last_name, region_rentals.region, region_rentals.total_rentals
FROM customer
JOIN region_rentals ON customer.address_id = region_rentals.address_id;
