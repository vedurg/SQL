# Data Transformer --- SQL Project

## Project Overview

Data Transformer is a MySQL project for practicing SQL data retrieval,
transformation, analysis, and reporting using customer, order, and
employee data.

## Objectives

-   Retrieve related data using SQL joins.
-   Use subqueries to filter customers and employees.
-   Extract, compare, and format dates.
-   Transform strings using built-in SQL functions.
-   Calculate running totals and rank orders.
-   Apply conditional discount and salary categories.

## Database

-   **DBMS:** MySQL
-   **Database name:** `Data_Transformer`

## Tables

### Customers

Stores customer details.

  Column               Description
  -------------------- ------------------------------------------
  `CustomerID`         Unique customer identifier (Primary Key)
  `FirstName`          Customer's first name
  `LastName`           Customer's last name
  `Email`              Customer email address
  `RegistrationDate`   Registration date

### Orders

Stores order details and links orders to customers.

  Column          Description
  --------------- ---------------------------------------
  `OrderID`       Unique order identifier (Primary Key)
  `CustomerID`    Customer identifier (Foreign Key)
  `OrderDate`     Order date
  `TotalAmount`   Total order amount

### Employees

Stores employee and salary details.

  Column         Description
  -------------- ------------------------------------------
  `EmployeeID`   Unique employee identifier (Primary Key)
  `FirstName`    Employee's first name
  `LastName`     Employee's last name
  `Department`   Employee's department
  `HireDate`     Hiring date
  `Salary`       Employee salary

## Queries Covered

1.  **INNER JOIN:** Retrieve orders and matching customer details.
2.  **LEFT JOIN:** Retrieve all customers and any matching orders.
3.  **RIGHT JOIN:** Retrieve all customers with matching orders where
    available.
4.  **FULL OUTER JOIN equivalent:** Combine `LEFT JOIN` and `RIGHT JOIN`
    results using `UNION`, because MySQL does not directly support
    `FULL OUTER JOIN`.
5.  **Subquery:** Find customers with order amounts above the average
    order amount.
6.  **Subquery:** Find employees with salaries above the average salary.
7.  **Date extraction:** Extract the year and month from `OrderDate`.
8.  **Date difference:** Calculate days between `OrderDate` and the
    current date.
9.  **Date formatting:** Format `OrderDate` as `DD-MMM-YYYY`.
10. **String concatenation:** Combine first and last names into a full
    name.
11. **String replacement:** Replace `John` with `Jonathan`.
12. **Case conversion:** Convert first names to uppercase and last names
    to lowercase.
13. **String trimming:** Remove leading and trailing spaces from email
    values in query output.
14. **Running total:** Calculate a cumulative total of order amounts.
15. **Ranking:** Rank orders by `TotalAmount` using `RANK()`.
16. **Conditional discount:** Assign a discount category based on order
    amount.
17. **Salary categorization:** Categorize employee salaries as high,
    medium, or low.

## How to Run

1.  Open MySQL Workbench and connect to your MySQL server.
2.  Open `Project2.sql`.
3.  Execute the database and table creation statements.
4.  Insert the sample data into the tables.
5.  Run each query and review the Result Grid.

If needed, create and select the database with:

``` sql
CREATE DATABASE IF NOT EXISTS Data_Transformer;
USE Data_Transformer;
```

## Assumptions

-   `TotalAmount > 1000`: 10% discount.
-   `TotalAmount > 500`: 5% discount.
-   Otherwise: no discount.
-   `Salary >= 40000`: High.
-   `Salary >= 30000`: Medium.
-   Otherwise: Low.
-   MySQL does not directly support `FULL OUTER JOIN`; use `LEFT JOIN`,
    `RIGHT JOIN`, and `UNION` to create the equivalent result.
-   Column names in the queries must match the actual table definitions.
    This project uses `TotalAmount` in the `Orders` table.

## Skills Practiced

`SELECT` · `JOIN` · `UNION` · Subqueries · Aggregate Functions · Date
Functions · String Functions · Window Functions · `CASE`

## Project Structure

``` text
Project-2/
├── Data_Transformer.sql
└── README.md
```

------------------------------------------------------------------------

**Project:** Data Transformer\
**Category:** SQL / MySQL
