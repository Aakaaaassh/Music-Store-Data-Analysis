use music_database;

--  Question Set 1 

-- 1. Who is the senior most employee based on job title?

SELECT first_name,last_name,employee_id,title FROM employee
WHERE reports_to NOT IN  ( SELECT employee_id FROM employee);

-- 2. Which countries have the most Invoices?

SELECT  billing_country,COUNT(invoice_id) as Invoices
FROM invoice
GROUP BY billing_country
ORDER BY Invoices DESC
LIMIT 1;

-- 3. What are top 3 values of total invoice?

SELECT total
FROM invoice
ORDER BY total DESC
LIMIT 3;

-- 4. Which city has the best customers? 
-- We would like to throw a promotional Music Festival in the city we made the most money. 
-- Write a query that returns one city that has the highest sum of invoice totals. 
-- Return both the city name & sum of all invoice totals

SELECT billing_city,SUM(total) as Total
FROM invoice
GROUP BY billing_city
ORDER BY Total DESC
LIMIT 1;

-- 5. Who is the best customer? 
-- The customer who has spent the most money will be declared the best customer.
-- Write a query that returns the person who has spent the most money

SELECT C.first_name,C.last_name, SUM(I.total) as Total
FROM invoice I 
INNER JOIN customer C 
ON C.customer_id = I.customer_id
GROUP BY C.customer_id
ORDER BY Total DESC
LIMIT 1;

-- Question Set 2 

-- 1. Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
-- Return your list ordered alphabetically by email starting with A

SELECT DISTINCT C.email, C.first_name,C.last_name,'Rock' as Genre 
FROM customer C 
INNER JOIN invoice I 
ON C.customer_id = I.customer_id
INNER JOIN invoice_line L 
ON I.invoice_id = L.invoice_id
WHERE track_id IN
(SELECT track_id FROM track WHERE genre_id IN(SELECT genre_id FROM genre WHERE name = 'Rock'));

-- 2. Let's invite the artists who have written the most rock music in our dataset. 
-- Write a query that returns the Artist name and total track count of the top 10 rock bands

SELECT AR.artist_id,AR.name,COUNT(T.track_id) AS Tracks
FROM artist AR 
INNER JOIN album AL 
ON AR.artist_id = AL.artist_id
INNER JOIN track T 
ON AL.album_id = T.album_id
WHERE T.genre_id IN(SELECT genre_id FROM genre 
WHERE name = 'Rock')
GROUP BY AR.name,AR.artist_id
ORDER BY Tracks DESC
LIMIT 10;

-- 3. Return all the track names that have a song length longer than the average song length. 
-- Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first

SELECT name,milliseconds FROM track 
WHERE milliseconds > (SELECT AVG(milliseconds) FROM track);

-- Question Set 3 

-- 1. Find how much amount spent by each customer on artists? 
-- Write a query to return customer name, artist name and total spent

WITH best_selling_artist AS(
SELECT AR.artist_id AS Artist_id,AR.name AS Name,SUM(L.unit_price*L.quantity) AS Total
FROM invoice_line L
INNER JOIN track T 
ON L.track_id = T.track_id
INNER JOIN album AL 
ON AL.album_id = T.album_id
INNER JOIN artist AR 
ON AR.artist_id = AL.artist_id
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 1)
SELECT C.customer_id,C.first_name,C.last_name,A.Name,SUM(L.unit_price*L.quantity) AS Total
FROM customer C
INNER JOIN invoice I ON I.customer_id = C.customer_id
INNER JOIN invoice_line L ON L.invoice_id = I.invoice_id
INNER JOIN track T ON L.track_id = T.track_id
INNER JOIN album AL ON AL.album_id = T.album_id
INNER JOIN best_selling_artist A ON A.Artist_id = AL.artist_id
GROUP BY 1,2,3,4
ORDER BY 5 DESC;

-- 2. We want to find out the most popular music Genre for each country. 
-- We determine the most popular genre as the genre with the highest amount of purchases. 
-- Write a query that returns each country along with the top Genre. 
-- For countries where the maximum number of purchases is shared return all Genres

WITH CTE AS (SELECT I.billing_country,T.genre_id,G.name,COUNT(L.quantity) as Quantity,
ROW_NUMBER() OVER(Partition BY I.billing_country ORDER BY COUNT(L.quantity) DESC) AS RW  
FROM invoice_line L 
JOIN invoice I 
ON I.invoice_id = L.invoice_id
JOIN track T 
ON L.track_id = T.track_id
JOIN genre G 
ON T.genre_id = G.genre_id
GROUP BY I.billing_country,T.genre_id,G.name
ORDER BY I.billing_country,Quantity DESC)
SELECT billing_country,name,genre_id,Quantity 
FROM CTE
WHERE RW = 1;

-- 3. Write a query that determines the customer that has spent the most on music for each country.
-- Write a query that returns the country along with the top customer and how much they spent. 
-- For countries where the top amount spent is shared, provide all customers who spent this amount

WITH CTE AS
(SELECT C.customer_id,C.first_name,C.last_name,I.billing_country,SUM(I.total) AS Total,
ROW_NUMBER() OVER(PARTITION BY I.billing_country ORDER BY SUM(I.total) DESC) as RN 
FROM invoice I 
JOIN customer C 
ON I.customer_id = C.customer_id
GROUP BY 1,2,3,4
ORDER BY 4,5 DESC)
SELECT * FROM CTE 
WHERE RN <= 1;
