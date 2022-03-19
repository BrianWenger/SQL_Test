SELECT a.first_name, a.last_name, count(distinct f.title) as total_films
FROM actor a
join film_actor fa on a.actor_id = fa.actor_id
join film f on fa.film_id = f.film_id
group by 1,2
order by 3 desc
LIMIT 100;

/* 
Verified there do not appear to be duplicated film records. Though the distinct count was included to ensure no duplicates were counted. Query below:

SELECT count(title) as films, count(distinct title) as distinct_films FROM film
*/

/* 
There do  appear to be duplicated actor records. For example, Susan Davis appears twice in the actor table under both actor_id 101 and 110. 
Unless these are two diffect actors, the data should be validated. Query below:

SELECT first_name, last_name, actor_id FROM actor WHERE first_name = 'SUSAN'
*/
