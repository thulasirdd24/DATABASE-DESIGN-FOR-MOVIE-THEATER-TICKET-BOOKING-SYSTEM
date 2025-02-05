-- SQL script for 10 unique queries with at least 2 multi-table queries

-- Query 1: Retrieve all movies and their corresponding showtimes
SELECT m.Title, m.Genre, s.ShowDateTime, s.Price
FROM Movies m
JOIN Showtimes s ON m.MovieID = s.MovieID;

-- Query 2: Retrieve all bookings made by a specific customer along with the movie title and showtime details
SELECT c.Name AS CustomerName, m.Title AS MovieTitle, s.ShowDateTime, b.NumTickets, b.TotalPrice
FROM Customers c
JOIN Bookings b ON c.CustomerID = b.CustomerID
JOIN Showtimes s ON b.ShowtimeID = s.ShowtimeID
JOIN Movies m ON s.MovieID = m.MovieID
WHERE c.Name = 'John Doe';

-- Query 3: Retrieve the total number of tickets booked for each movie
SELECT m.Title, SUM(b.NumTickets) AS TotalTicketsBooked
FROM Movies m
JOIN Showtimes s ON m.MovieID = s.MovieID
JOIN Bookings b ON s.ShowtimeID = b.ShowtimeID
GROUP BY m.Title;

-- Query 4: Retrieve all bookings made for a specific showtime along with customer details
SELECT c.Name AS CustomerName, c.Email, c.Phone, c.Address, b.NumTickets, b.TotalPrice
FROM Bookings b
JOIN Customers c ON b.CustomerID = c.CustomerID
WHERE b.ShowtimeID = 1; -- Replace 1 with the desired ShowtimeID

-- Query 5: Retrieve the movie with the highest rating
SELECT *
FROM Movies
WHERE Rating = (SELECT MAX(Rating) FROM Movies);

-- Query 6: Retrieve all theaters and their total capacity along with the number of booked tickets for each theater
SELECT t.Name, t.Capacity, SUM(b.NumTickets) AS TotalBookedTickets
FROM Theaters t
LEFT JOIN Showtimes s ON t.TheaterID = s.TheaterID
LEFT JOIN Bookings b ON s.ShowtimeID = b.ShowtimeID
GROUP BY t.TheaterID;

-- Query 7: Retrieve all customers who have booked tickets for multiple movies along with the number of movies they booked tickets for
SELECT c.Name AS CustomerName, COUNT(DISTINCT b.ShowtimeID) AS NumMoviesBooked
FROM Customers c
JOIN Bookings b ON c.CustomerID = b.CustomerID
GROUP BY c.CustomerID
HAVING COUNT(DISTINCT b.ShowtimeID) > 1;

-- Query 8: Retrieve the average rating for movies in each genre
SELECT Genre, AVG(Rating) AS AverageRating
FROM Movies
GROUP BY Genre;

-- Query 9: Retrieve all movies directed by a specific director along with their average ratings
SELECT m.Title, m.Rating
FROM Movies m
WHERE m.Director = 'Christopher Nolan';

-- Query 10: Retrieve all customers who booked tickets for a specific movie
SELECT DISTINCT c.Name AS CustomerName, c.Email, c.Phone, c.Address
FROM Customers c
JOIN Bookings b ON c.CustomerID = b.CustomerID
JOIN Showtimes s ON b.ShowtimeID = s.ShowtimeID
JOIN Movies m ON s.MovieID = m.MovieID
WHERE m.Title = 'The Dark Knight'; -- Replace with the desired movie title