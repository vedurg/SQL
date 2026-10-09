create database DataDigger

use DataDigger

show databases

-- 1. Customers Table...
 
create table Customers (
	Customer_id int primary key,
    Name varchar(100),
    Email varchar(100),
    Address varchar(200)
)
-- Insert values....
 
insert into customers (customer_id,Name,Email,Address)
values
(1,'Alice','alice@gmail.com','Rajkot'),
(2,'Bob','bob@gmail.com','Rajkot'),
(3,'David','david@gmail.com','Surat'),
(4,'Charlie','charlie@gmail.com','Baroda'),
(5,'Emma','emma@gmail.com','Ahmedabad')

-- Retrieve all customers
select * from customers

-- Update customers address 
update customers
set address = 'Gandhinagar'
where customer_id = 2

-- Delete customers using customer_id 
delete from customers
where customer_id = 4

-- Display all customers whose name is 'Alice' 
select * from customers
where name = 'emma'

-- 2. Order Table......

create table Orders (
	Order_id int primary key,
    Customer_id int,
    Order_date date,
    TotalAmount decimal(10,2),
    foreign key (customer_id) References customers (customer_id)
)

-- Insert valuess.... 
insert into orders (Order_id,customer_id,Order_date,TotalAmount)
values
(101,1,'2026-10-01','1500'),
(102,2,'2026-10-02','2500'),
(103,3,'2026-10-03','800'),
(104,1,'2026-10-05','3200'),
(105,5,'2026-10-06','1200')

-- Retrieve all orders made by a specific customer 
select * from orders
where customer_id = 1

-- Update order's total amount 
update orders
set TotalAmount = 2000
where order_id = 101

-- Delete an order using its order_id 
delete from orders
where order_id = 105

-- Retrieve order placed in the last 30 days 
select * from orders
where order_date >= curdate() - interval 30 day

-- highest, lowest, and average order amount using aggregate fun.. 
select max(TotalAmount) as Highest_Order,
	   min(TotalAmount) as Lowest_Order,
	   avg(TotalAmount) as Average_Order
from orders

-- 3. Products Table

create table Products (
	Product_id int primary key,
    Product_name varchar(100),
    Price decimal(10,2),
    Stock int
)

-- Insert values.....
insert into products (Product_id, Product_name, Price,Stock)
values
(1,'Laptop','55000',10),
(2,'Mouse','800',25),
(3,'Keyboard','1500',15),
(4,'Moniter','12000',8),
(5,'Headphones','2000',5)

select * from products

-- Retrieve all products sorted by price in descending order

order by price desc

-- Update the price aa specific product
update products
set stock = 0
where product_id = 5
 
-- Delete a product if it's out of stock
delete from products
where stock = 0

select * from products

-- product whose price between 500 and 2000
select * from products
where price between 500 AND 2000

-- most expensive and cheapest product using MAX() MIN()   
select 
	max(price) as Most_Expensive,
    min(price) as Cheapest
from products

-- 4. OrderDetails table

create table OrderDetails (
	OrderDetailID int primary key,
    Order_ID int,
    Product_ID int,
    Quantity int,
    SubTotal decimal(10,2),
    foreign key (Order_ID) References Orders(order_ID),
	foreign key (Product_ID) References Products(product_ID)
)

-- Insert values
insert into OrderDetails
(OrderDetailID, Order_ID, Product_ID, Quantity, SubTotal)
values
(1, 101, 1, 1, 1800),
(2, 101, 3, 2, 3000),
(3, 102, 2, 2, 2000),
(4, 103, 3, 1, 1500),
(5, 104, 4, 1, 12000);

select * from OrderDetails

-- order details for a specific order
select * from OrderDetails
where Order_ID = 101

-- calculate the total revenue generated from all order using SUM()
select sum(subtotal) as Total_Revenue
from OrderDetails

-- top 3 most ordered products
select product_ID, sum(Quantity) as Total_Quantity
from OrderDetails
group by Product_ID
order by Total_Quantity desc
limit 3;

-- count how many times a specific product has been sold using COUNT()  
select Product_ID, count(*) as Times_Sold
from OrderDetails
where Product_ID = 3
group by Product_ID
    
select * from OrderDetails
