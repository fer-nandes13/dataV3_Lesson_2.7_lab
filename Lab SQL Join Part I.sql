

# Lab | SQL Join (Part I)


### Instructions

#1. How many films are there for each of the categories in the category table. Use appropriate join to write this query.
#2. Display the total amount rung up by each staff member in August of 2005.
#3. Which actor has appeared in the most films?
#4. Most active customer (the customer that has rented the most number of films)
#5. Display the first and last names, as well as the address, of each staff member.
#6. List each film and the number of actors who are listed for that film.
#7. Using the tables `payment` and `customer` and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.
#8. List the titles of films per `category`.

#1How many films are there for each of the categories in the category table. Use appropriate join to write this query.

USE sakila;
SELECT *
FROM sakila.category;

SELECT *
FROM film_category;

SELECT c.name AS category_name, COUNT(fc.film_id) AS film_count
FROM category AS c
INNER JOIN film_category AS fc 
ON c.category_id = fc.category_id
GROUP BY c.name;

SELECT COUNT(film_id) AS film_count
FROM film_category AS fc
JOIN category AS c ON fc.category_id = c.category_id
WHERE c.name = 'Action';

# 2. Display the total amount rung up by each staff member in August of 2005.
SELECT SUM(amount) AS Sum_sales, staff_id
FROM payment p
WHERE DATE(p.payment_date) BETWEEN '2005-08-01' AND '2005-08-31'
group by p.staff_id;

# 3 Which actor has appeared in the most films?
SELECT COUNT(film_id) AS number_of_films, f.actor_id as Actor_ID
FROM film_actor f
GROUP BY f.actor_id
ORDER BY number_of_films DESC;

# 4 Most active customer (the customer that has rented the most number of films)
SELECT* 
FROM customer;
SELECT active
FROM customer;
SELECT*
FROM payment;
SELECT customer.customer_id, payment.amount
FROM customer
JOIN payment
on customer.customer_id = payment.customer_id;

SELECT customer.customer_id, COUNT(payment.payment_id) AS payment_count, customer.first_name, customer.last_name
FROM customer
LEFT JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY payment_count DESC;
# The most active customer is costumer with customer ID 148 (Eleanor Hunt) with 46 payments, if we assume that each payment count is equivalent to a film rental.

#5 Display the first and last names, as well as the address, of each staff member.
SELECT*
FROM staff; 
SELECT*
FROM address;
SELECT staff.first_name, staff.last_name, address.address_id, address.address
FROM staff
JOIN address
ON staff.address_id = address.address_id;

#6 List each film and the number of actors who are listed for that film.
SELECT fa.film_id, COUNT(DISTINCT fa.actor_id) AS actor_count
FROM film_actor fa
JOIN actor a 
ON fa.actor_id = a.actor_id
GROUP BY fa.film_id;


SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(p.amount) AS total_paid
FROM
    customer c
LEFT JOIN
    payment p ON c.customer_id = p.customer_id
GROUP BY
    c.customer_id, c.last_name, c.first_name
ORDER BY
    c.last_name;
#7 Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.
SELECT customer.customer_id, customer.last_name AS customer_name, SUM(payment.amount) AS total_paid
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id, customer.last_name
ORDER BY customer.last_name;

