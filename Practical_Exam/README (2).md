## 📌 Project Overview

The **Smart Event Management System** is a relational database project
built with **MySQL 8.0**. It helps organize event information, manage
venues and organizers, register attendees, book tickets, and record
payments.

The project demonstrates practical SQL skills, from basic data
operations to advanced analysis using joins, subqueries, date and string
functions, window functions, and CASE expressions.

## 🎯 Project Objectives

-   Store and manage event, venue, organizer, attendee, ticket, and
    payment information.
-   Perform CRUD operations to insert, retrieve, update, and delete
    records.
-   Filter, sort, group, and summarize event data.
-   Maintain relationships using primary keys, foreign keys, and unique
    constraints.
-   Analyze ticket bookings and successful payment revenue.
-   Practice advanced SQL concepts using realistic event-management
    scenarios.

## 🧰 Tech Stack

  -----------------------------------------------------------------------
  Technology                          Purpose
  ----------------------------------- -----------------------------------
  **MySQL 8.0**                       Relational database and SQL queries

  **MySQL Workbench**                 Database design, query execution,
                                      and result inspection

  **SQL**                             Data definition, manipulation, and
                                      analysis
  -----------------------------------------------------------------------

## 🗂️ Database Structure

The database is named SmartEventDB and contains six main tables.

  -----------------------------------------------------------------------
  Table                               Purpose
  ----------------------------------- -----------------------------------
  Venues                            Venue name, location, and capacity

  Organizers                        Organizer contact and profile
                                      information

  Events                            Event details, date, venue,
                                      organizer, ticket price, and seat
                                      counts

  Attendees                         Attendee contact information

  Tickets                           Event bookings, booking date,
                                      attendee, and booking status

  Payments                          Ticket payment amount, payment
                                      status, and payment date
  -----------------------------------------------------------------------

### 🔗 Relationship Overview

-   One venue can host multiple events.
-   An organizer can manage multiple events.
-   Attendees book tickets for events through the Tickets table.
-   Payments are linked to tickets through ticket_id.
-   Primary keys uniquely identify records; foreign keys maintain valid
    relationships.

> **Relationship note:** A unique constraint on
> (attendee_id, event_id) can be used if the business rule is that an
> attendee may book only once per event. Add it only when duplicate
> bookings do not already exist.

## 📚 SQL Concepts Covered

### 1. CRUD Operations

-   INSERT --- add venues, organizers, attendees, and bookings.
-   SELECT --- search for events and attendees.
-   UPDATE --- change ticket prices, contact numbers, and venue
    details.
-   DELETE --- remove records while respecting foreign-key
    dependencies.

### 2. SQL Clauses: WHERE, HAVING, LIMIT

-   Find upcoming events in a selected city.
-   Retrieve the top five events by successful payment revenue.
-   Find attendees who booked tickets in the last seven days.
-   Practice row filtering, group filtering, and limiting result sets.

### 3. Logical Operators: AND, OR, NOT

-   Find December events with more than 50% of seats available.
-   Find attendees with ticket bookings or pending payments.
-   Identify events that are not fully booked.

### 4. Sorting and Grouping: ORDER BY, GROUP BY

-   Sort events by date in ascending order.
-   Count ticket bookings per event.
-   Calculate successful payment revenue for each event.

### 5. Aggregate Functions

-   SUM() --- calculate total successful payment revenue.
-   AVG() --- calculate average ticket price or average payment
    amount.
-   MAX() / MIN() --- find the highest or lowest ticket price.
-   COUNT() --- count bookings and attendees.

### 6. Keys and Relationships

-   Define primary keys for uniquely identifying rows.
-   Link related tables using foreign keys.
-   Prevent duplicate attendee-event bookings when required by the
    business rules.
-   Connect payments to valid ticket records.

### 7. Joins

-   INNER JOIN --- show event details with venue information.
-   LEFT JOIN --- find ticket bookings with missing or unsuccessful
    payments.
-   RIGHT JOIN --- identify events without ticket bookings.
-   FULL OUTER JOIN concept --- emulate where needed using UNION,
    because MySQL 8.0 does not directly support FULL OUTER JOIN.

### 8. Subqueries

-   Find events whose revenue is above a comparison average.
-   Identify attendees who booked tickets for multiple events.
-   Find organizers who managed more than three events.

### 9. Date and Time Functions

-   MONTH() --- extract the month from an event date.
-   DATEDIFF() and CURDATE() --- calculate days remaining until an
    event.
-   DATE_FORMAT() --- display payment timestamps as
    YYYY-MM-DD HH:MM:SS.

### 10. String Functions

-   UPPER() --- convert organizer names to uppercase.
-   TRIM() --- remove leading and trailing spaces from attendee names.
-   COALESCE() --- replace NULL email values with Not Provided.

### 11. Window Functions

-   RANK() OVER() --- rank events by revenue.
-   COUNT() OVER() --- calculate a running ticket-booking count.
-   PARTITION BY --- calculate running counts separately for each
    event.

### 12. CASE Expressions

-   Categorize events as **High Demand**, **Moderate Demand**, or **Low
    Demand** based on available-seat percentages.
-   Convert payment statuses into readable labels: **Successful**,
    **Failed**, and **Pending**.

## ▶️ How to Run the Project

1. Install **MySQL 8.0** and open MySQL Workbench.
2. Create or select the SmartEventDB database.
3. Run your project's SQL script to create the tables in dependency order: Venues, Organizers, Events, Attendees, Tickets, and Payments.
4. Insert sample records, ensuring referenced parent records exist first.
5. Execute the assignment queries section by section in MySQL Workbench and inspect the result grid.

> **Note:** The SQL script contains the executable database commands; this README focuses on project documentation and concepts.

## ⚠️ Notes and Best Practices

-   Insert parent records before child records to satisfy foreign keys.
-   Check for duplicate (attendee_id, event_id) pairs before adding a
    unique constraint.
-   A LEFT JOIN payment query should distinguish between a missing
    payment and a payment whose status is Failed or Pending.
-   Revenue calculations should clearly define whether they include only
    Success payments.
-   FULL OUTER JOIN is not directly supported in MySQL 8.0; use a
    suitable LEFT JOIN / RIGHT JOIN and UNION pattern when a
    full-join result is required.
-   Results for "last 7 days" depend on the actual dates stored in
    Tickets.booking_date.

## 🚀 Learning Outcomes

By completing this project, you can practice:

-   Designing a relational database with linked tables.
-   Writing accurate SQL queries and debugging common errors.
-   Applying joins, aggregate functions, and subqueries to business
    questions.
-   Using date/time and string functions to clean and analyze data.
-   Building analytical queries with window functions and conditional
    logic.

## 🔮 Future Enhancements

-   Add a stored procedure for ticket booking.
-   Prevent bookings when no seats remain.
-   Add triggers to update available seats after booking or
    cancellation.
-   Create views for revenue summaries and event demand.
-   Build a dashboard to visualize ticket sales, payment status, and
    event performance.

------------------------------------------------------------------------


