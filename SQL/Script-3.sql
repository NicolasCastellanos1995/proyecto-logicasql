--2
SELECT title
FROM film
WHERE rating = 'R';


--3
SELECT first_name, last_name
FROM actor
WHERE actor_id BETWEEN 30 AND 40;

--4
SELECT title
FROM film
WHERE language_id = original_language_id;

--5
SELECT title
FROM film
ORDER BY length ASC;

--6
SELECT first_name, last_name
FROM actor
WHERE last_name = 'ALLEN';

--7
SELECT rating, COUNT(*) AS totalmovies
FROM film
GROUP BY rating
ORDER BY totalmovies DESC;

--8
select TITLE, LENGTH
from film 
order BY LENGTH DESC; --PARA SABER SI ESTA EN MINUTOS O HORAS
select TITLE 
from film 
where rating = 'PG-13' or length > 180;



--9
SELECT STDDEV(replacement_cost) AS VARIABILIDAD
FROM film;


--10
select  MAX(length), min(length)
from film; 


--11
WITH ORDEN AS (
  SELECT p.amount, r.rental_date, ROW_NUMBER() OVER (ORDER BY r.rental_date DESC) AS row_num
  FROM rental r
  JOIN payment p ON r.rental_id = p.rental_id
)
SELECT amount
FROM ORDEN
WHERE row_num = 3;

--12
SELECT title
FROM film
WHERE rating != 'NC-17' AND rating != 'G';

--13
SELECT rating, AVG(length) AS PROMEDIO
FROM film
GROUP BY rating;

--14
SELECT title
FROM film
WHERE length > 180;

--15
select sum(amount) as generado
from payment ;

--16
select customer_id
from customer
order by customer_id desc 
limit 10;

--17
select a.first_name, a.last_name
from actor a
join film_actor fa on a.actor_id = fa.actor_id 
join film f on f.film_id = fa.film_id 
where f.title='EGG IGBY';

--18
select distinct title 
from film ;

--19
select f.title
from film f 
join film_category fc on f.film_id = fc.film_id 
join category c on c.category_id = fc.category_id
where f.length >180 and c."name" = 'Comedy';

--20
SELECT c.name, AVG(f.length) AS promedio
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON c.category_id = fc.category_id
GROUP BY c.name
HAVING AVG(f.length) > 110;

--21
select avg(return_date - rental_date) as  PROMALQUILER
from rental;

--22
select  concat(first_name,' ',last_name) as NOMBREAPELLIDO
from actor;

--23
SELECT  DATE(r.rental_date) AS rentxdia,COUNT(*) AS cuenta            
FROM rental r
GROUP BY rentxdia                     
ORDER BY rentxdia DESC; 

--24
select title
from film f  
where f.length >(select avg(length) from film); 

--25
SELECT 
    TO_CHAR(r.rental_date, 'YYYY-MM') AS rentaxmes,  
    COUNT(*) AS cantidad                          
FROM rental r
GROUP BY rentaxmes order by rentaxmes desc ; 

--26
select avg(amount) as promedio,
	   variance(amount) as varianza,
	   stddev(amount) as desviacion
from payment ;	

--27 supongo que quieren saber las peliculas que se han alquilado y su precio es mayor al promedio 
select f.title 
from film f
join inventory i on f.film_id = i.film_id 
join rental r on r.inventory_id = i.inventory_id 
where r.rental_date is not null and f.rental_rate >(select avg(rental_rate) from film); 

--28
select  a.actor_id
from actor a
join film_actor f on a.actor_id = f.actor_id 
group by a.actor_id 
having count(f.film_id) > 40 ;

--29
select f.title,  
    case 
        when i.inventory_id is not null then 'SI'
        else 'No'
    end as disponibile  
from film f
JOIN inventory i ON f.film_id = i.film_id;

--30
select a.first_name, a.last_name,count(f.film_id) as cantidad 
from actor a
join film_actor f on f.actor_id = a.actor_id
group by a.first_name,a.last_name ;

--31
select f.title,a.first_name,a.last_name 
from film f
left join film_actor fa on fa.film_id = f.film_id 
left join actor a on a.actor_id = fa.actor_id ;

--32
select a.first_name,a.last_name,f.title
from actor a
left join film_actor fa on a.actor_id = fa.actor_id 
left join film f on fa.film_id = f.film_id;

--33
select f.title, r.rental_id
from inventory i 
left join film f on i.film_id = f.film_id 
left join rental r on r.inventory_id = i.inventory_id ;

--34
select c.first_name,c.last_name, sum(p.amount) as TOTAL 
from customer c 
join payment p on c.customer_id = p.customer_id 
group by c.customer_id, c.last_name
order by TOTAL
limit 5;

--35
select first_name, last_name 
from actor 
where first_name = 'JOHNNY';

--36
select first_name as NOMBRE, last_name as APELLIDO
from actor; 

--37
select actor_id
from actor 
where actor_id=(select min(actor_id) from actor)
or actor_id=(select max(actor_id) from actor ); 

--38
select count(actor_id) as cantidad
from actor;

--39
select first_name, last_name 
from actor
order by last_name asc ;

--40
select title
from film 
order by film_id asc 
limit 5;



--41 a

select 
    first_name, 
    count(*) as cantidad  
from actor
group by first_name; 

--41 b 

select 
    first_name, 
    count(*) as cantidad  
from actor
group by first_name  
order by cantidad desc
limit 1;

--42
select r.rental_id,c.first_name,c.last_name
from rental r
left join customer c on c.customer_id = r.customer_id ;

--43
select c.first_name,c.last_name,r.rental_id
from customer c
left join rental r on c.customer_id = r.customer_id ;

--44
select f.title, c.name
from film f
cross join category c;

--en este caso no es util porque pueden ser relacionadas por una fk, pero si en lugar de estas categorias
--tuviera sucesos y quisiera calcular la probabilidad de que ocurra quisas podria servir

--45
select a.first_name,a.last_name 
from actor a 
join film_actor fa on fa.actor_id = a.actor_id 
join film f on f.film_id = fa.film_id 
join film_category fc on f.film_id = fc.film_id 
join category c on c.category_id = fc.category_id 
where c."name" = 'Action';

--46
select a.first_name,a.last_name 
from actor a 
left join film_actor f on f.actor_id = a.actor_id 
where f.film_id is null;

--47
select a.first_name,a.last_name, count(fa.film_id) as CANTIDAD_PELIS
from actor a 
join film_actor fa on fa.actor_id = a.actor_id 
group by a.first_name, a.last_name;

--48
create view nombre_actor_num_pelis as
select a.first_name,a.last_name, count(fa.film_id) as CANTIDAD_PELIS
from actor a 
join film_actor fa on fa.actor_id = a.actor_id 
group by a.first_name, a.last_name;

--49
select c.last_name,c.first_name,count(r.rental_id) as CANTIDAD_ALQ
from customer c
join rental r on r.customer_id = c.customer_id 
group by c.first_name,c.last_name;

--50
select sum(f.length) as Duracion
from film f 
join film_category fc on fc.film_id = f.film_id 
join category c on c.category_id = fc.category_id 
where "name" = 'Action';

--51
create temporary table cliente_renta as
select c.last_name,c.first_name,count(r.rental_id) as CANTIDAD_ALQ
from customer c
join rental r on r.customer_id = c.customer_id 
group by c.first_name,c.last_name;

--52
CREATE TEMPORARY TABLE peliculas_alquiladas AS
SELECT f.film_id, f.title, COUNT(r.rental_id) AS total_alquileres
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
HAVING COUNT(r.rental_id) >= 10;

--53
select f.title
from film f 
join inventory i on i.film_id = f.film_id 
join rental r on r.inventory_id = i.inventory_id 
join customer c on c.customer_id = r.customer_id 
where c.first_name = 'TAMMY' and c.last_name='SANDERS' and r.return_date is null
order by f.title asc;

--54
select distinct a.first_name,a.last_name 
from actor a 
join film_actor fa on fa.actor_id = a.actor_id 
join film f on f.film_id = fa.film_id 
join film_category fc on fc.film_id = f.film_id 
join category c on c.category_id = fc.category_id 
where c."name"= 'Sci-Fi'
order by a.last_name ;

--55
SELECT DISTINCT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id 
JOIN rental r ON i.inventory_id = r.inventory_id 
WHERE r.rental_date > (
    SELECT MIN(r2.rental_date)
    FROM rental r2
    JOIN inventory i2 ON r2.inventory_id = i2.inventory_id
    JOIN film f2 ON i2.film_id = f2.film_id 
    WHERE f2.title = 'SPARTACUS CHEAPER'
)
ORDER BY a.last_name, a.first_name;

--56
select distinct a.first_name,a.last_name 
from actor a 
join film_actor fa on fa.actor_id = a.actor_id 
join film f on f.film_id = fa.film_id 
join film_category fc on fc.film_id = f.film_id 
join category c on c.category_id = fc.category_id 
where c."name" != 'Music' ;

--57 
SELECT DISTINCT f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.return_date IS NOT NULL
AND (r.return_date - r.rental_date) > 8;

--58
SELECT f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
WHERE fc.category_id = (
    SELECT fc2.category_id
    FROM film_category fc2
    JOIN film f2 ON f2.film_id = fc2.film_id
    WHERE f2.title = 'ANIMATION')
ORDER BY f.title;

-- estuve 1 hora provando hasta que verifique que no existe tal peli 

--59
select title 
from film f
where f.length = (
	select f2.length
	from film f2
	where title = 'DANCING FEVER')
order by title asc;	

--60
SELECT c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
GROUP BY c.customer_id
HAVING COUNT(DISTINCT i.film_id) > 6
ORDER BY c.last_name, c.first_name;


--61
SELECT c.name AS CATEGORIA, COUNT(r.rental_id) AS ALQUILADA
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.category_id
ORDER BY ALQUILADA DESC;

--62
SELECT c.name AS CATEGORIA, COUNT(f.film_id) AS POST_2006
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
WHERE f.release_year = 2006
GROUP BY c.category_id
ORDER BY POST_2006 DESC;

--63
SELECT s.staff_id,st.store_id 
FROM staff s 
cross JOIN store st;

--64
SELECT c.customer_id, c.first_name, c.last_name, COUNT(DISTINCT i.film_id) AS TOTAL
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
GROUP BY c.customer_id
ORDER BY TOTAL DESC;









 




