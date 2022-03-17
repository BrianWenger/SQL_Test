SELECT c.name as category, count(f.title)
FROM film f
join film_category fc on fc.film_id = f.film_id
join category c on fc.category_id = c.category_id
where c.name not in ('Sports', 'Games')
group by 1
order by 2 desc;
