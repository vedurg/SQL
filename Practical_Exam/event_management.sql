-- Smart Event Management System

create database SmartEventDB
use SmartEventDB

--  Venues table

create table Venues (
    venue_id int primary key AUTO_INCREMENT,
    venue_name varchar(100) NOT NULL,
    location varchar(100),
    capacity int
);

-- Organizers table

create table Organizers (
    organizer_id int primary key AUTO_INCREMENT,
    organizer_name varchar(100) NOT NULL,
    contact_email varchar(100),
    phone_number varchar(15)
);

-- Events table

create table Events (
	event_id int primary key,
    event_name varchar(100),
    event_date datetime,
    venue_id int,
    organizer_id int,
    ticket_price decimal(10,2),
    total_seats int,
    available_seats int,
    foreign key (venue_id) references Venues(venue_id),
    foreign key (organizer_id) references Organizers(organizer_id)
)
ALTER TABLE Events
MODIFY event_id INT NOT NULL AUTO_INCREMENT;

-- Attendees table

create table Attendees (
    attendee_id int primary key AUTO_INCREMENT,
    name varchar(100) NOT NULL,
    email varchar(100),
    phone_number varchar(15)
);

-- Tickets table

create table Tickets (
	ticket_id int primary key AUTO_INCREMENT,
    event_id int NOT NULL,
    attendee_id int NOT NULL,
    booking_date datetime,
    status ENUM('Confirmed', 'Cancelled', 'Pending')
        DEFAULT 'Pending',
	foreign key (event_id) references Events(event_id),
    foreign key (attendee_id) references Attendees(attendee_id)
);

--  Payments table

create table payments (
	payment_id int primary key AUTO_INCREMENT,
    ticket_id int not null,
    amount_paid decimal(10,2) not null,
    payment_status ENUM('Success', 'Failed', 'Pending')
		default 'Pending',
	payment_date datetime,
    foreign key (ticket_id) references Tickets(ticket_id)
)

INSERT INTO Venues
(venue_name, location, capacity)
VALUES
('Grand Hall', 'Rajkot', 500),
('City Center', 'Jamnagar', 300),
('Royal Palace', 'Rajkot', 800),
('Tech Auditorium', 'Ahmedabad', 400)

INSERT INTO Organizers
(organizer_name, contact_email, phone_number)
VALUES
('Amit Shah', 'amit@gmail.com', '9876543210'),
('Neha Patel', 'neha@gmail.com', '9876543211'),
('Rahul Mehta', 'rahul@gmail.com', '9876543212'),
('Priya Joshi', NULL, '9876543213')

INSERT INTO Events
(event_name, event_date, venue_id, organizer_id,
 ticket_price, total_seats, available_seats)
VALUES
('Music Night', '2026-12-10 18:00:00', 1, 1, 500, 500, 100),
('Tech Seminar', '2026-12-15 10:00:00', 4, 2, 300, 400, 250),
('Food Festival', '2026-12-20 17:00:00', 2, 3, 200, 300, 150),
('New Year Concert', '2026-12-31 20:00:00', 3, 1, 1000, 800, 100),
('Art Workshop', '2026-11-05 11:00:00', 1, 4, 400, 500, 300),
('Business Expo', '2026-12-25 09:00:00', 4, 2, 600, 400, 200)

INSERT INTO Attendees
(name, email, phone_number)
VALUES
('Riya', 'riya@gmail.com', '9000000001'),
('Karan', 'karan@gmail.com', '9000000002'),
('Meera', 'meera@gmail.com', '9000000003'),
('Jay', 'jay@gmail.com', '9000000004'),
('Pooja', 'pooja@gmail.com', '9000000005'),
('Dev', 'dev@gmail.com', '9000000006')

INSERT INTO Tickets
(event_id, attendee_id, booking_date, status)
VALUES
(1, 1, '2026-10-01 10:00:00', 'Confirmed'),
(1, 2, '2026-10-02 11:00:00', 'Confirmed'),
(2, 1, '2026-10-03 12:00:00', 'Confirmed'),
(2, 3, '2026-10-04 13:00:00', 'Pending'),
(3, 4, '2026-10-05 14:00:00', 'Confirmed'),
(4, 5, '2026-10-06 15:00:00', 'Confirmed'),
(4, 6, '2026-10-07 16:00:00', 'Cancelled'),
(6, 2, '2026-10-08 17:00:00', 'Confirmed')

INSERT INTO Payments
(ticket_id, amount_paid, payment_status, payment_date)
VALUES
(1, 500, 'Success', '2026-10-01 10:05:00'),
(2, 500, 'Success', '2026-10-02 11:05:00'),
(3, 300, 'Success', '2026-10-03 12:05:00'),
(4, 300, 'Pending', '2026-10-04 13:05:00'),
(5, 200, 'Success', '2026-10-05 14:05:00'),
(6, 1000, 'Success', '2026-10-06 15:05:00'),
(7, 0, 'Failed', '2026-10-07 16:05:00'),
(8, 600, 'Success', '2026-10-08 17:05:00')
	
select * from events

-- 1. Implement CRUD Operations (Low Weightage)

-- Add a new venue
insert into venues (venue_name, location, capacity)
values('Grand Palace', 'Rajkot', 1000)

--  Update the capacity of a venue
update venues
set capacity = 1200
where venue_id = 1

-- Delete a venue from the system
delete from venues
where venue_id = 1 

--  Search for events by name
select * from events
where event_name = 'Music Night'

-- Add a new organizer
insert into organizers 
(organizer_name, contact_email, phone_number)
values
('Rahul Patel', 'rahul@example.com', '9876543210')

-- Update an attendee's phone number
update Attendees
set phone_number = '9876510283'
where  attendee_id = 1

-- Search for an attendee by name
select * from Attendees
where name = 'Pooja'
 
-- Update an event's ticket price
update Events
set ticket_price = 550
where event_id = 1;

--  Add a new attendee
insert into Attendees (name, email, phone_number)
values ('Neha Shah', 'neha@example.com', '9876543210');

select * from Attendees

-- 2. Use SQL Clauses (Low Weightage)

-- Get upcoming events happening in a specific city.

select * from events
where event_date > now()
and venue_id in (
	select venue_id
    from venues
    where location = 'Rajkot'
)
order by event_date asc

-- Retrieve the top 5 highest revenue-generating events 

select e.event_id,e.event_name,sum(p.amount_paid) as total_revenue
from events e
join tickets t on e.event_id = t.event_id
join payments p on t.ticket_id = p.ticket_id
where p.payment_status = 'Success'
group by e.event_id , e.event_name
order by total_revenue desc
limit 5

-- Find attendees who booked tickets in the last 7 days.

select distinct a.attendee_id, a.name, a.email
from attendees a
join Tickets t ON a.attendee_id = t.attendee_id
where t.booking_date >= now() - INTERVAL 7 DAY
order by  a.attendee_id;

-- 3.  Apply SQL Operators (AND, OR, NOT)

--  Retrieve events scheduled in December AND have more than 50% available seats

select event_id, event_name, event_date, total_seats, available_seats
from events
where month(event_date) = 12
and available_seats > total_seats * 0.50

-- List attendees who booked a ticket OR have a pending payment. 

select distinct a.attendee_id, a.name, a.email
FROM Attendees a
LEFT JOIN Tickets t
    ON a.attendee_id = t.attendee_id
LEFT JOIN Payments p
    ON t.ticket_id = p.ticket_id
WHERE t.ticket_id IS NOT NULL
OR p.payment_status = 'Pending';

-- Identify events that are NOT fully booked.

SELECT event_id, event_name, total_seats, available_seats
FROM Events
WHERE NOT (available_seats = 0);

-- 4. Sorting & Grouping Data (ORDER BY, GROUP BY)

--  Sort events by date in ascending order

select event_id , event_name, event_date
from events
order by event_date asc

--  Count the number of attendees per event

select e.event_id, e.event_name, count(t.attendee_id) as Total_attendees
from events e
left join tickets t
	on e.event_id = t.event_id
group by e.event_id, e.event_name

--  Show the total revenue generated per event

SELECT e.event_id, e.event_name,
       SUM(p.amount_paid) AS total_revenue
FROM Events e
JOIN Tickets t
    ON e.event_id = t.event_id
JOIN Payments p
    ON t.ticket_id = p.ticket_id
WHERE p.payment_status = 'Success'
GROUP BY e.event_id, e.event_name
ORDER BY total_revenue DESC

-- 5. Use Aggregate Functions (SUM, AVG, MAX, MIN, COUNT)

--  Calculate the total revenue generated from all events.

SELECT SUM(amount_paid) AS total_revenue
FROM Payments
WHERE payment_status = 'Success'

--  Find the event with the highest number of attendees.

SELECT e.event_id, e.event_name,
       COUNT(t.attendee_id) AS total_attendees
FROM Events e
LEFT JOIN Tickets t
    ON e.event_id = t.event_id
GROUP BY e.event_id, e.event_name
ORDER BY total_attendees DESC
LIMIT 1

-- Compute the average ticket price across all events. 

SELECT AVG(ticket_price) AS average_ticket_price
FROM Events

-- 6. Establish Primary & Foreign Key Relationships

-- Ensure that attendees cannot book the same event multiple times

ALTER TABLE Tickets
ADD CONSTRAINT unique_attendee_event
UNIQUE (attendee_id, event_id)

-- Link payments to tickets, ensuring a valid foreign key relationship

ALTER TABLE Payments
ADD CONSTRAINT fk_payments_tickets
FOREIGN KEY (ticket_id)
REFERENCES Tickets(ticket_id)

-- 7.  Perform Joins

--  Retrieve event details along with their venue names

SELECT e.event_id, e.event_name, v.venue_name, v.location
FROM Events e
INNER JOIN Venues v
ON e.venue_id = v.venue_id

-- Get a list of attendees who booked a ticket but did not complete payment using LEFT JOIN.
 
SELECT DISTINCT a.attendee_id, a.name, a.email
FROM Attendees a
INNER JOIN Tickets t
ON a.attendee_id = t.attendee_id
LEFT JOIN Payments p
ON t.ticket_id = p.ticket_id
WHERE p.payment_id IS NULL
   OR p.payment_status <> 'Success'

-- Identify events without any attendees using RIGHT JOIN.

SELECT e.event_id, e.event_name
FROM Tickets t
RIGHT JOIN Events e
ON t.event_id = e.event_id
WHERE t.ticket_id IS NULL

-- Show attendees who have not booked any ticket using FULL OUTER JOIN.
 
SELECT a.attendee_id, a.name, a.email
FROM Attendees a
LEFT JOIN Tickets t
ON a.attendee_id = t.attendee_id
WHERE t.ticket_id IS NULL

UNION

SELECT a.attendee_id, a.name, a.email
FROM Attendees a
RIGHT JOIN Tickets t
ON a.attendee_id = t.attendee_id
WHERE a.attendee_id IS NULL

-- 8. Use Subqueries

--  Find events that generated revenue above the average ticket sales

SELECT e.event_id, e.event_name,
       SUM(p.amount_paid) AS total_revenue
FROM Events e
JOIN Tickets t ON e.event_id = t.event_id
JOIN Payments p ON t.ticket_id = p.ticket_id
WHERE p.payment_status = 'Success'
GROUP BY e.event_id, e.event_name
HAVING SUM(p.amount_paid) > (
    SELECT AVG(amount_paid)
    FROM Payments
    WHERE payment_status = 'Success'
)

-- Identify attendees who have booked tickets for multiple events.

SELECT attendee_id, name, email
FROM Attendees
WHERE attendee_id IN (
    SELECT attendee_id
    FROM Tickets
    GROUP BY attendee_id
    HAVING COUNT(DISTINCT event_id) > 1
)

-- Retrieve organizers who have managed more than 3 events.

SELECT organizer_id, organizer_name, contact_email
FROM Organizers
WHERE organizer_id IN (
    SELECT organizer_id
    FROM Events
    GROUP BY organizer_id
    HAVING COUNT(event_id) > 3
)

-- 9.  Implement Date & Time Functions

-- Extract the month from event_date to analyze event trends

SELECT event_id, event_name,
       MONTH(event_date) AS event_month
FROM Events

-- Calculate the number of days remaining for an upcoming event. 

SELECT event_id, event_name, event_date,
       DATEDIFF(event_date, CURDATE()) AS days_remaining
FROM Events
WHERE event_date >= CURDATE()
ORDER BY event_date ASC

--  Format payment_date as YYYY-MM-DD HH:MM:SS

SELECT payment_id,
       DATE_FORMAT(payment_date, '%Y-%m-%d %H:%i:%s')
       AS formatted_payment_date
FROM Payments

-- 10.  Use String Manipulation Functions

--  Convert all organizer names to uppercase

SELECT organizer_id,
       UPPER(organizer_name) AS organizer_name_uppercase
FROM Organizers

-- Remove extra spaces from attendee names using TRIM().
 
SELECT attendee_id,
       TRIM(name) AS cleaned_name
FROM Attendees

-- Replace NULL email fields with "Not Provided".

SELECT attendee_id, name,
       COALESCE(email, 'Not Provided') AS email
FROM Attendees

-- 11. Implement Window Functions

-- Rank events based on total revenue earned.

SELECT event_id, event_name, total_revenue,
       RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM (
    SELECT e.event_id, e.event_name,
           COALESCE(SUM(
               CASE
                   WHEN p.payment_status = 'Success'
                   THEN p.amount_paid
                   ELSE 0
               END
           ), 0) AS total_revenue
    FROM Events e
    LEFT JOIN Tickets t ON e.event_id = t.event_id
    LEFT JOIN Payments p ON t.ticket_id = p.ticket_id
    GROUP BY e.event_id, e.event_name
) AS event_revenue

--  Display the cumulative sum of ticket sales

SELECT ticket_id, event_id, booking_date,
       COUNT(*) OVER (
           ORDER BY booking_date, ticket_id
       ) AS cumulative_ticket_sales
FROM Tickets
WHERE status = 'Confirmed'

-- Show the running total of attendees registered per event.

SELECT event_id, ticket_id, attendee_id, booking_date,
       COUNT(*) OVER (
           PARTITION BY event_id
           ORDER BY booking_date, ticket_id
       ) AS running_attendees
FROM Tickets
WHERE status = 'Confirmed'

-- 12. Apply SQL CASE Expressions

-- Categorize events based on ticket sales:
-- - "High Demand" if available_seats is less than 20% of total_seats.
-- - "Moderate Demand" if available_seats is between 20% and 50% of total_seats.
-- - "Low Demand" otherwise.

SELECT event_id, event_name, total_seats, available_seats,
       CASE
           WHEN available_seats < total_seats * 0.20
               THEN 'High Demand'
           WHEN available_seats BETWEEN total_seats * 0.20
               AND total_seats * 0.50
               THEN 'Moderate Demand'
           ELSE 'Low Demand'
       END AS demand_category
FROM Events

--  Assign payment statuses:
-- - "Successful" if payment_status = 'Success'.
-- - "Failed" if payment_status = 'Failed'.
-- - "Pending" otherwise.

SELECT payment_id, ticket_id, amount_paid, payment_status,
       CASE
           WHEN payment_status = 'Success'
               THEN 'Successful'
           WHEN payment_status = 'Failed'
               THEN 'Failed'
           ELSE 'Pending'
       END AS payment_result
FROM Payments


