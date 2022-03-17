SELECT a.first_name, a.last_name, count(f.title)
FROM actor a
join film_actor fa on a.actor_id = fa.actor_id
join film f on fa.film_id = f.film_id
group by 1,2
order by 3 desc
LIMIT 100
