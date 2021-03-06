SELECT count(active_US_customers) as count_active_US_customers
FROM (
SELECT distinct r.customer_id as active_US_customers
FROM rental r
join customer c on r.customer_id = c.customer_id
join address a on c.address_id = a.address_id
join city ci on a.city_id = ci.city_id
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id
WHERE city != 'Dallas'
and f.rating = 'PG'
and country_id = 103
group by 1
having sum(CASE WHEN date(rental_ts) between (date('07-01-2020') + INTERVAL '1 MONTH' - INTERVAL '15 DAY') and (date('07-01-2020') + INTERVAL '1 MONTH' - INTERVAL '1 DAY') THEN 1 else 0 end) >= 2
and sum(CASE WHEN date(rental_ts) between (date('08-01-2020') + INTERVAL '1 MONTH' - INTERVAL '15 DAY') and (date('08-01-2020') + INTERVAL '1 MONTH' - INTERVAL '1 DAY') THEN 1 else 0 end) >= 2
) a;

/*
The question doesn't state to only include US cities, yet the requested columns appear to want to include only US cities. This would be another point
instance to groom the request with the requestor. The query was narrowed to the US only through finding the country_id of the US which is 103.

The country_id was assumed based on cities in the city table, as the country table was inaccessible. Query below:

SELECT country, country_id
FROM country

Error message:
Bad Request
permission denied for table country
*/

/*
Intervals were used in the having clause to allow for quick expansion without the need to count out the days in each month,
if for example, we were to expand the months to include February (28 days) or September (30 days).
The code could have been simplified by hard coding the dates as such:

having sum(CASE WHEN date(rental_ts) between date('07-17-2020') and date('07-31-2020')) >= 2
and sum(CASE WHEN date(rental_ts) between date('08-17-2020') and date('08-31-2020')) >= 2
*/


/*
The data was validated for a single customer to ensure the aggregate data was correct. Query below:

SELECT r.customer_id as customer_id, rental_id, rental_ts
FROM rental r
join customer c on r.customer_id = c.customer_id
join address a on c.address_id = a.address_id
join city ci on a.city_id = ci.city_id
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id
WHERE city != 'Dallas'
and (date(rental_ts) between (date('07-01-2020') + INTERVAL '1 MONTH' - INTERVAL '15 DAY') and (date('07-01-2020') + INTERVAL '1 MONTH' - INTERVAL '1 DAY')
or date(rental_ts) between (date('08-01-2020') + INTERVAL '1 MONTH' - INTERVAL '15 DAY') and (date('08-01-2020') + INTERVAL '1 MONTH' - INTERVAL '1 DAY'))
and f.rating = 'PG'
and r.customer_id = 273
*/


/*
Proper Rating format was pulled from the proper table. Query below:

SELECT rating FROM film group by 1
*/
