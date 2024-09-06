-- Query to find customers with the highest lifetime value
SELECT customer.customer_id, customer.first_name, customer.last_name, SUM(payment.amount) AS total_spent
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY customer.customer_id
ORDER BY total_spent DESC
LIMIT 10;

-- Query to analyze movie rental patterns by country
SELECT country.country, COUNT(rental.rental_id) AS rental_count
FROM country
JOIN city ON country.country_id = city.country_id
JOIN address ON city.city_id = address.city_id
JOIN customer ON address.address_id = customer.address_id
JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY country.country
ORDER BY rental_count DESC;

