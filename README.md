## <img width="594" alt="schema_diagram" src="https://github.com/Aakaaaassh/Music_Store_Data_Analysis/assets/66636545/b3e202fd-6a43-4170-8726-63e0e2d53177">



# Music Store Data Analysis

## Overview



This repository contains data analysis on a music store database using MySQL. The database comprises 11 tables:

- album.csv
- artist.csv
- customer.csv
- employee.csv
- genre.csv
- invoice.csv
- invoice_line.csv
- media_type.csv
- playlist.csv
- playlist_track.csv
- track.csv

The analysis is divided into three question sets, each exploring different aspects of the music store data.

# Question Set 1 
1. Who is the senior most employee based on job title?

2. Which countries have the most Invoices?

3. What are top 3 values of total invoice?

4. Which city has the best customers? 
We would like to throw a promotional Music Festival in the city we made the most money. Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals

5. Who is the best customer? 
The customer who has spent the most money will be declared the best customer. Write a query that returns the person who has spent the most money

# Question Set 2 
1. Write query to return the email, first name, last name, & Genre of all Rock Music listeners. Return your list ordered alphabetically by email starting with A

2. Let's invite the artists who have written the most rock music in our dataset. Write a query that returns the Artist name and total track count of the top 10 rock bands

3. Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first

# Question Set 3 
1. Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent

2. We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where the maximum number of purchases is shared return all Genres

3. Write a query that determines the customer that has spent the most on music for each country. Write a query that returns the country along with the top customer and how much they spent. For countries where the top amount spent is shared, provide all customers who spent this amount

# License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
