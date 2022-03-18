SELECT date_part('week', r.rental_ts) as Week, count(r.rental_id) as Total_Rentals, sum(p.amount) as Total_revenue, count(distinct r.customer_id) as number_of_inviduals
FROM rental r
join payment p on r.rental_id = p.rental_id
join inventory i on r.inventory_id = i.inventory_id
where date(r.rental_ts) >= (select date(max(rental_ts) - INTERVAL '12 weeks') FROM rental)
and i.store_id = 1
group by 1;

/*
Data accuracy was validated through checking the weeks directly on ‘rental’ as there are weeks missing and the count of rentals from week to week varied to a large degree.

SELECT date_part('week', rental_ts) as week, count(rental_id) as rentals FROM rental group by 1 order by 1
*/

/*
The inventory table was queried to ensure each individual rental material had a unique id to ensure the join was proper.

SELECT * FROM inventory
*/

-- Based off the description of the question, I could not see a need for the 'address' table as referenced in the question 3's “Tables used”, including it would have been more database intensive so the join was left out.
