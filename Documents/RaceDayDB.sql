CREATE DATABASE RaceDayDB;

USE RaceDayDB;

-- Users 
CREATE TABLE Users (
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(150) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    Role VARCHAR(20) NOT NULL, -- 'Organiser' or 'Participant'
    PhoneNumber VARCHAR(20),
    CreatedAt DATETIME DEFAULT GETDATE()
);


-- Events 
CREATE TABLE Events (
    EventId INT IDENTITY(1,1) PRIMARY KEY,
    OrganiserId INT NOT NULL FOREIGN KEY REFERENCES Users(UserId),
    EventName VARCHAR(150) NOT NULL,
    Description VARCHAR(MAX),
    EventDate DATE NOT NULL,
    Location VARCHAR(150) NOT NULL,
    EventType VARCHAR(50) DEFAULT 'Running',
    CreatedAt DATETIME DEFAULT GETDATE()
);


-- Categories 
CREATE TABLE Categories (
    CategoryId INT IDENTITY(1,1) PRIMARY KEY,
    EventId INT NOT NULL FOREIGN KEY REFERENCES Events(EventId),
    CategoryName VARCHAR(100) NOT NULL,
    DistanceKm DECIMAL(5,2) NOT NULL,
    EntryFee DECIMAL(8,2) DEFAULT 0,
    MaxParticipants INT
);


-- Enrolments 
CREATE TABLE Enrolments (
    EnrolmentId INT IDENTITY(1,1) PRIMARY KEY,
    ParticipantId INT NOT NULL FOREIGN KEY REFERENCES Users(UserId),
    CategoryId INT NOT NULL FOREIGN KEY REFERENCES Categories(CategoryId),
    EnrolmentDate DATETIME DEFAULT GETDATE(),
    Status VARCHAR(20) DEFAULT 'Confirmed'
);


-- Results 
CREATE TABLE Results (
    ResultId INT IDENTITY(1,1) PRIMARY KEY,
    EnrolmentId INT NOT NULL UNIQUE FOREIGN KEY REFERENCES Enrolments(EnrolmentId),
    FinishTime TIME,
    Position INT,
    Status VARCHAR(20) DEFAULT 'Finished'
);


-- Payments
CREATE TABLE Payments (
    PaymentId INT IDENTITY(1,1) PRIMARY KEY,
    EnrolmentId INT NOT NULL UNIQUE FOREIGN KEY REFERENCES Enrolments(EnrolmentId),
    Amount DECIMAL(8,2) NOT NULL,
    PaymentDate DATETIME DEFAULT GETDATE(),
    PaymentMethod VARCHAR(30) DEFAULT 'Card',
    PaymentStatus VARCHAR(20) DEFAULT 'Paid'
);


---
---- sample data
---

-- 2 organisers and 2 participants
INSERT INTO Users (FullName, Email, PasswordHash, Role, PhoneNumber) VALUES
('Thandiwe Nkosi', 'thandiwe.nkosi@raceday.co.za', 'hashedpassword1', 'Organiser', '0821234567'),
('Pieter van Wyk', 'pieter.vanwyk@raceday.co.za', 'hashedpassword2', 'Organiser', '0837654321'),
('Amahle Dlamini', 'amahle.dlamini@gmail.com', 'hashedpassword3', 'Participant', '0712345678'),
('Johan Botha', 'johan.botha@gmail.com', 'hashedpassword4', 'Participant', '0768889999');

-- 3 events
INSERT INTO Events (OrganiserId, EventName, Description, EventDate, Location, EventType) VALUES
(1, 'Cape Town Cycle Tour', 'Cycling tour around the Cape Peninsula', '2026-03-08', 'Cape Town', 'Cycling'),
(1, 'Two Oceans Marathon', 'Marathon along the Cape coastline', '2026-04-04', 'Cape Town', 'Running'),
(2, 'Soweto Marathon', 'Community marathon in Soweto', '2026-11-08', 'Soweto', 'Running');

-- categories
INSERT INTO Categories (EventId, CategoryName, DistanceKm, EntryFee, MaxParticipants) VALUES
(1, 'Individual Ride 109km', 109.00, 950.00, 15000),
(1, 'Mini Peloton 56km', 56.00, 650.00, 8000),
(2, 'Half Marathon 21km', 21.10, 450.00, 5000),
(2, 'Ultra Marathon 56km', 56.00, 650.00, 3000),
(3, '10km Fun Run', 10.00, 200.00, 4000),
(3, 'Full Marathon 42.2km', 42.20, 500.00, 6000);

-- enrolments
INSERT INTO Enrolments (ParticipantId, CategoryId, Status) VALUES
(3, 1, 'Confirmed'), -- Amahle enters the 109km ride
(3, 3, 'Confirmed'), -- Amahle enters the Half Marathon
(4, 2, 'Confirmed'), -- Johan enters the 56km ride
(4, 5, 'Confirmed'); -- Johan enters the 10km Fun Run

-- results
INSERT INTO Results (EnrolmentId, FinishTime, Position, Status) VALUES
(1, '04:12:35', 1245, 'Finished'),
(3, '02:05:10', 340, 'Finished');

-- payments
INSERT INTO Payments (EnrolmentId, Amount, PaymentMethod, PaymentStatus) VALUES
(1, 950.00, 'Card', 'Paid'),
(2, 450.00, 'Card', 'Paid'),
(3, 650.00, 'EFT', 'Paid'),
(4, 200.00, 'Card', 'Pending');