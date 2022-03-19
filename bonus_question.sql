/*
The goal of this exercise is to determine which types of movies are trending in our 5 most actives cities. 
We will then use this trending analysis to promote and draw in new customers through marketing and displaying of these trending categories.
*/


/*
The first step is to determine our 5 most popular cities:

select city, count(rental_id) as rentals
from rental r
join customer cu on r.customer_id = cu.customer_id
join address a on cu.address_id = a.address_id
join city c on a.city_id = c.city_id
group by 1
order by 2 desc

These are our most popular cities:
city	count
Aurora	50
London	48
Saint-Denis	46
Cape Coral	45
Tanza	4

A better way to check this would have been based on the store's location/city rather than the customer's, unfortunately the 'store' table is permission locked,
in the same way that the country table is permissioned locked from an earlier question. Query below:

select * FROM store

Error code:
Bad Request
permission denied for table store 
*/

/*
Next, let’s find the top 3 movie categories per city:

select city, category, rentals
from
(select row_number () over (
           partition by city
           order by count(rental_id) desc
         ) rn, city, ca.name as category, count(rental_id) as rentals
from rental r
join customer cu on r.customer_id = cu.customer_id
join address a on cu.address_id = a.address_id
join city c on a.city_id = c.city_id
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id
join film_category fc on f.film_id = fc.film_id
join category ca on fc.category_id = ca.category_id
Where c.city in ('Aurora', 'London', 'Saint-Denis', 'Cape Coral', 'Tanza')
group by 2,3
order by 2,4 desc)a
where rn <=3

These are our most popular categories in each of our top cities. These movies show which movies are currently trending higher than the others:
city	category	rentals
Aurora	Children	6
Aurora	Documentary	5
Aurora	Action	5
Cape Coral	Animation	8
Cape Coral	Family	7
Cape Coral	Documentary	5
London	Drama	6
London	Children	5
London	Sci-Fi	5
Saint-Denis	Sci-Fi	7
Saint-Denis	Family	6
Saint-Denis	Travel	5
Tanza	Foreign	5
Tanza	Games	5
Tanza	Family	4
*/

/*
Finally, we will determine the average rental count per month, and can use this as a benchmark to see if any changes 
we make in promotion and visibility of these categories (through better in-store positioning and display) effect the future sales. 
We would hope that future sales would beat these numbers due to our changes. That is also to say we hope we are not losing 
customers over time to streaming services.

We will run this for one city, ’Saint-Denis’, though the same could be run for each of the other top cities.

We check which months have rentals within these categories for Saint-Denis in 2020:

select date_part('month', rental_ts), count(rental_id) as rentals
from rental r
join customer cu on r.customer_id = cu.customer_id
join address a on cu.address_id = a.address_id
join city c on a.city_id = c.city_id
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id
join film_category fc on f.film_id = fc.film_id
join category ca on fc.category_id = ca.category_id
Where c.city = 'Saint-Denis'
and ca.name in ('Sci-Fi', 'Family', 'Travel')
and date_part('year', rental_ts) = 2020
group by 1
order by 1

date_part	rentals
6	1
7	9
8	8

It appears that the only months in which we have rentals are June, July and August. 
Although not conclusive with the little data we are working with, June could be an outlier, 
whereas July and August are more in line with one another. If we have more than,

(8+9)/2 = 8.5 rentals

then we might be able to infer the better in-store placement and advertising 
did in fact have a positive impact on our rentals in these categories.
*/

