select date(day) as day, avg(rentals) over(order by day, day rows between 6 preceding and current row) as rolling_avg
  from 
	(SELECT day, count(rental_ts) as rentals 
		FROM (VALUES
    		(date('08-01-2020')),
    		(date('08-02-2020')),
    		(date('08-03-2020')),
    		(date('08-04-2020')),
   			(date('08-05-2020')),
  		  	(date('08-06-2020')),
    		(date('08-07-2020')),
    		(date('08-08-2020')),
    		(date('08-09-2020')),
    		(date('08-10-2020')),
    		(date('08-11-2020')),
    		(date('08-12-2020')),
    		(date('08-13-2020')),
    		(date('08-14-2020')),
    		(date('08-15-2020')),
    		(date('08-16-2020')),
    		(date('08-17-2020')),
    		(date('08-18-2020')),
    		(date('08-19-2020')),
    		(date('08-20-2020')),
    		(date('08-21-2020')),
    		(date('08-22-2020')),
    		(date('08-23-2020')),
    		(date('08-24-2020')),
    		(date('08-25-2020')),
    		(date('08-26-2020')),
    		(date('08-27-2020')),
    		(date('08-28-2020')),
    		(date('08-29-2020')),
    		(date('08-30-2020')),
    		(date('08-31-2020'))) datelist(day)
LEFT JOIN rental ON date(rental_ts) = date(day)
GROUP BY 1
ORDER BY 1) a

/* 

The data was observed to be substandard for use of a window function as is due to dates with no rentals. Using a window function with missing dates would lead to inaccurate results, as such, the empty days needed to be created. The empty days were observed to be 08-04-2020 through 08-16-2020 and 08-25-2020 through 08-31-2020. If the data was standard and had data for each day a simplified code could be used:

SELECT date(day) as day, avg(rentals) over(order by day, day rows between 6 preceding and current row) as rolling_avg
FROM (SELECT date(rental_ts) as day, count(rental_ts) as rentals 
	  FROM rental 
	  WHERE date(rental_ts) between date('08-01-2020') and date('08-31-2020') group by 1) a

*/
