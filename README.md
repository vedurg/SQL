# Data Digger — SQL Project

## Project Overview
**Data Digger** is a hands-on MySQL project designed to practice relational database management and SQL queries using an e-commerce store scenario. It covers CRUD operations, filtering, sorting, foreign keys, and aggregate functions.

## Objectives
- Create and manage relational tables in MySQL.
- Insert, retrieve, update, and delete records.
- Use primary keys and foreign-key relationships.
- Filter and sort data using `WHERE`, `BETWEEN`, and `ORDER BY`.
- Analyze order and product data using `MAX()`, `MIN()`, `AVG()`, `SUM()`, and `COUNT()`.

## Database Schema
The database is named `DataDigger` and contains four tables:

### 1. `Customers`
| Column | Description |
|---|---|
| `CustomerID` | Unique customer identifier (Primary Key) |
| `Name` | Customer name |
| `Email` | Customer email address |
| `Address` | Customer address |

### 2. `Orders`
| Column | Description |
|---|---|
| `OrderID` | Unique order identifier (Primary Key) |
| `CustomerID` | Customer who placed the order (Foreign Key) |
| `OrderDate` | Date the order was placed |
| `TotalAmount` | Total order amount |

### 3. `Products`
| Column | Description |
|---|---|
| `ProductID` | Unique product identifier (Primary Key) |
| `ProductName` | Product name |
| `Price` | Product price |
| `Stock` | Available stock quantity |

### 4. `OrderDetails`
| Column | Description |
|---|---|
| `OrderDetailID` | Unique order-detail identifier (Primary Key) |
| `OrderID` | Related order (Foreign Key) |
| `ProductID` | Related product (Foreign Key) |
| `Quantity` | Quantity in the order detail |
| `SubTotal` | Subtotal for the order-detail record |

## Relationships
- `Orders.CustomerID` references `Customers.CustomerID`.
- `OrderDetails.OrderID` references `Orders.OrderID`.
- `OrderDetails.ProductID` references `Products.ProductID`.

## SQL Tasks Completed

### Customers
- Insert at least five sample customers.
- Retrieve all customer details.
- Update a customer's address.
- Delete a customer using `CustomerID`.
- Retrieve customers whose name is `Alice`.

### Orders
- Insert at least five sample orders.
- Retrieve orders for a specific customer.
- Update an order's total amount.
- Delete an order using `OrderID`.
- Retrieve orders placed in the last 30 days.
- Find the highest, lowest, and average order amounts using `MAX()`, `MIN()`, and `AVG()`.

### Products
- Insert at least five sample products.
- Retrieve products sorted by price in descending order.
- Update the price of a specific product.
- Delete products that are out of stock.
- Retrieve products priced between ₹500 and ₹2,000.
- Find the most expensive and cheapest product prices using `MAX()` and `MIN()`.

### OrderDetails
- Insert at least five sample order-detail records.
- Retrieve details for a specific order.
- Calculate total revenue using `SUM()`.
- Retrieve the top three products by total quantity ordered.
- Count how many order-detail records contain a specific product using `COUNT()`.

## Concepts Practiced
- Database and table creation
- `CREATE DATABASE`, `USE`, and `CREATE TABLE`
- `INSERT`, `SELECT`, `UPDATE`, and `DELETE`
- Primary keys and foreign keys
- `WHERE` and `BETWEEN`
- `ORDER BY` and `LIMIT`
- `GROUP BY`
- Aggregate functions: `MAX()`, `MIN()`, `AVG()`, `SUM()`, and `COUNT()`
- Date filtering with `CURDATE()` and `INTERVAL`

## Getting Started

### Requirements
- MySQL Server 8.0 or compatible version
- MySQL Workbench or another MySQL client

### Setup
1. Open MySQL Workbench and connect to your MySQL server.
2. Create and select the database:

   ```sql
   CREATE DATABASE DataDigger;
   USE DataDigger;
   ```

3. Run the SQL statements in the project script in dependency order:
   1. `Customers`
   2. `Orders`
   3. `Products`
   4. `OrderDetails`
4. Insert sample data and run the queries for each table.

> **Note:** If the database or tables already exist, avoid running creation or insert statements again without checking first. Duplicate primary-key values may cause errors. Run the tasks in the correct order because foreign keys depend on records in related tables.

## Example Aggregate Query

```sql
SELECT
    MAX(TotalAmount) AS Highest_Order,
    MIN(TotalAmount) AS Lowest_Order,
    AVG(TotalAmount) AS Average_Order
FROM Orders;
```

## Project Structure

```text
Project 1/
├── Data_Digger.sql
└── README.md
```

## Learning Outcome
This project provides practical experience in designing a small relational database, maintaining data integrity with keys, and writing SQL queries to retrieve and analyze e-commerce data.
