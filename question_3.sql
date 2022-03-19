SELECT date_part('week', r.rental_ts) as week, count(r.rental_id) as total_Rentals, sum(p.amount) as total_revenue, count(distinct r.customer_id) as number_of_inviduals
FROM rental r
join payment p on r.rental_id = p.rental_id
join inventory i on r.inventory_id = i.inventory_id
where date(r.rental_ts) >= (select date(max(rental_ts)) - CAST(date_part('dow', max(rental_ts) - INTERVAL '1 DAY') as INT) -INTERVAL '12 weeks' FROM rental)
and i.store_id = 1
group by 1;

/*
Data accuracy was validated through checking the weeks directly on ‘rental’ as there are weeks missing 
and the count of rentals from week to week varied to a large degree.

SELECT date_part('week', rental_ts) as week, count(rental_id) as rentals FROM rental group by 1 order by 1
*/

/*
The question states to "assume the most recent week was the week with the most recent rental", a lookup was done to find the most recent date using MAX, truncated to the first day of the week, and then using INTERVAL to backdate 12 weeks. 
A condition was used to check the resulting date verses the rental timestamp (rental_ts) is either greater than or equal to that result date, giving the prior 12 weeks as well as the current week.
*/

/*
The question states, "Exclude your results to only include rentals from store_id 1." This is a great place to groom the request to ensure the requestor only want store_id 1, 
as this sentence is worded in a way that could lead to ambiguity.
*/

/*
The inventory table was queried to ensure each individual rental material had a unique id to ensure the join was proper. Query below:

SELECT count(inventory_id), count(distinct inventory_id) FROM inventory
*/

/*
The rental table was queried to ensure each individual rental had a unique id to ensure the join was proper. Query below:

SELECT count(rental_id), count(distinct rental_id) from rental
*/

/*
Based off the description of the question, there was no need for the 'address' table as referenced in the question 3's “Tables used”, 
including it would have been more database intensive so the join was left out.
*/
