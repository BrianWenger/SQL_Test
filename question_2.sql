SELECT c.name as category, count(distinct f.title) as total_films
FROM film f
join film_category fc on fc.film_id = f.film_id
join category c on fc.category_id = c.category_id
where c.name not in ('Sports', 'Games')
group by 1
order by 2 desc;

/* 

As checked on question 1, checking for duplicate records through 'distinct' shows no duplicate records. 
Though the distinct count was don't to ensure no duplicates were counted.

*/
