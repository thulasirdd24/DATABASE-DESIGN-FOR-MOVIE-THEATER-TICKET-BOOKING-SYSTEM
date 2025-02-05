#Create the MovieTheater database
CREATE DATABASE IF NOT EXISTS MovieTheater;

USE MovieTheater;

show tables;
-- Movies table
CREATE TABLE Movies (
    MovieID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    Genre VARCHAR(50),
    ReleaseDate DATE,
    Duration INT,
    Director VARCHAR(100),
    Language VARCHAR(50),
    Rating DECIMAL(3,1)
);

-- Theaters table
CREATE TABLE Theaters (
    TheaterID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Location VARCHAR(255) NOT NULL,
    Capacity INT
);

-- Showtimes table
CREATE TABLE Showtimes (
    ShowtimeID INT AUTO_INCREMENT PRIMARY KEY,
    MovieID INT,
    TheaterID INT,
    ShowDateTime DATETIME,
    Price DECIMAL(6,2),
    CONSTRAINT FK_Showtime_Movie FOREIGN KEY (MovieID) REFERENCES Movies(MovieID),
    CONSTRAINT FK_Showtime_Theater FOREIGN KEY (TheaterID) REFERENCES Theaters(TheaterID)
);

-- Seats table
CREATE TABLE Seats (
    SeatID INT AUTO_INCREMENT PRIMARY KEY,
    TheaterID INT,
    RowNumber INT,
    SeatNumber INT,
    CONSTRAINT FK_Seat_Theater FOREIGN KEY (TheaterID) REFERENCES Theaters(TheaterID)
);

-- Bookings table
CREATE TABLE Bookings (
    BookingID INT AUTO_INCREMENT PRIMARY KEY,
    ShowtimeID INT,
    CustomerID INT,
    NumTickets INT,
    TotalPrice DECIMAL(8,2),
    BookingDateTime DATETIME,
    CONSTRAINT FK_Booking_Showtime FOREIGN KEY (ShowtimeID) REFERENCES Showtimes(ShowtimeID),
    CONSTRAINT FK_Booking_Customer FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Customers table
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    Phone VARCHAR(15),
    Address VARCHAR(255)
);
