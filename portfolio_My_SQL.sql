-- Q1. whe is the seniior most employee based on job titile.

 Select * from employee
 order by levels desc
 limit 1;


 -- Q2. which countries have the most invoices.
 
select count(*) , billing_country
from invoice
group by billing_country
order by billing_country desc;

 -- or 

select count(*)as c , billing_country
from invoice
group by billing_country
order by c desc;

 -- Q3. what are the top 3 values of total invoices.
Select total
from invoice
order by total desc;
 

 -- Q4. which city has bast customers? we should like to throw
 --  a promotional music festival in the city we made the most
 --  money. write a query that returns one city that has the heighest
 --  sum of invoice totals. return both the city name and sum of all 
 --  invoice totals.

Select sum(total) as invoice_total, billing_city
from invoice
group by billing_city
order by invoice_total desc;

-- Q5. who is the best customer the customer who has spent the most money 
--  will be declared the best customer. write a query that returns
-- the person who has spent the most money.

select customer.customer_id, customer.first_name, customer.last_name, sum(invoice.total) as total
from customer
join invoice on customer.customer_id = invoice.customer_id
group by customer.customer_id
order by total desc
limit 1;


-- Q6. write query tp return the email, first name, last name, &
--  genre of all rock music listeners. return your list orderd 
-- alphabetically by email starting with A.

Select Distinct email, first_name , last_name
from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
where track_id in (
	select track_id from track
	join genre on track.genre_id = genre.genre_id
	where genre.name like 'Rock'
)
order by email;


--  Q2. lets invite the artist who have written the most rock music 
--  in our dataset . write a query that return the artist name and 
--  total track count of the top 10 rock bands.

Select artist.artist_id, artist.name, count(artist.artist_id) as number_of_songs
from track
join album on album.album_id = track.album_id
join artist on artist.artist_id = album.artist_id
join genre on genre.genre_id = track.genre_id
where genre.name Like 'Rock'
group by artist.artist_id
order by number_of_songs desc
limit 10;


-- Q3. Return all the track names that have a song length longer than
-- the average song length. return the name and millisecond for each
-- track. order by the song length with the longest song listed first.

Select name, milliseconds
from track
where milliseconds > (
	select avg(milliseconds) as avg_track_length
	from track
	)
order by milliseconds desc;