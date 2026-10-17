create database Data_Transformer
use Data_Transformer

-- 1. Customers Table

create table Customers (
	CustomerID int primary key,
    FirstName varchar(100),
    LastName varchar(100),
    Email varchar(100),
    RegistrationDate date
)

insert into customers
(CustomerID, FirstName, LastName, Email, RegistrationDate)
values
(1,'John','Doe','jonh.doe@email.com','2022-03-15'),
(2,'Jane','Smith','jane.smith@email.com','2021-11-02')

select * from customers

-- 2. Order Table

create table Orders (
	OrderID int primary key,
    CustomerID int,
    OrderDate date,
    TotalAmount decimal(10,2),
    foreign key (customerID) references customers (customerID)
)
    
insert into orders 
(OrderID, CustomerID, OrderDate, TotalAmount)
values
(101,1,'2023-07-01',150),
(102,2,'2023-07-03',200)

select * from orders

-- 3. Employees Table

create table Employee (
	EmployeeID int primary key,
    FirstName varchar(100),
    LastName varchar(100),
    Department varchar(100),
    HireDate date,
    Salary decimal(10,2)
)
    
insert into employee 
(employeeID,FirstName,LastName,Department,hireDate,Salary)
values
(1,'Mark','Johson','Sales','2020-01-15',50000),
(2,'Susan','Lee','HR','2021-03-20',55000)
 
 select * from employee
 
 -- 1.INNER JOIN
 
 select * from orders
 inner join customers
 on orders.customerID = customers.customerID 
 
 -- 2. LEFT JOIN
 
 select * from customers
 left join orders
 on customers.customerID = orders.customerID
 
 -- 3. RIGHT JOIN
 
select * from orders
right join customers
on orders.customerID = customers.customerID 

-- 4. FULL OUTER JOIN

select * from customers
left join orders
on customers.customerID = orders.customerID

union

select * from orders
right join customers
on orders.customerID = customers.customerID

--  5 Subquery to find customers who have placed orders worth more than the average amount.

select * from customers
where customerID in (
	select customerID
    from orders
    where totalamount > (select avg(totalamount) from orders)
)
    
-- 6 Subquery to find employees with salaries above the average salary

select * from employee
where salary > (
	select avg(salary)
    from employee
)
 
-- 7. Extract Year and Month from OrderDate

select 
	orderID,
    YEAR(orderdate) as OrderYear,
    MONTH(orderdate) as OrderMonth
from orders

-- 8. Calculate the difference in days between two dates (order date and current date).

select 
	orderID,
    orderDate,
    DateDiff(curdate(),orderdate) as DaysDifference
from orders

-- 9. Format the OrderDate to a more readable format (e.g., DD-MMM-YYYY)

select 
	orderID,
    Date_Format(orderDate, '%d-%b-%Y') as FormattedDate
from orders

-- 10.  Concatenate FirstName and LastName to form a full name.
	
select 
	employeeID,
    concat(FirstName,' ',LastName) as FullName
from employee

-- 11.  Replace part of a string (e.g., replace 'John' with 'Jonathan').

select 
	FirstName,
    Replace(firstname, 'John', 'Jonathan') as UpdatedName
from customers

-- 12. Convert FirstName to uppercase and LastName to lowercase

select 
	upper(FirstName) as FirstName,
    lower(LastName) as LastName
from employee

-- 13. Trim extra spaces from the Email field.

select 
	customerID,
    trim(Email) as email
from customers

-- 14.  Calculate the running total of TotalAmount for each order

select
	orderID,
    TotalAmount,
    sum(TotalAmount) over (
		order by orderID ) as RunningTotal
from orders

-- 15.  Rank orders based on TotalAmount using the RANK() function.

select 
	orderID,
    TotalAmount,
    rank() over (order by TotalAmount desc) as OrderRank
from orders

-- 16.  Assign a discount based on TotalAmount in orders (e.g., greater than 1000: 10% off, greater than 500: 5% off).

select 
	orderID,
    TotalAmount,
    case
		when TotalAmount > 1000 then '10% Discount'
        when TotalAmount > 500 then '5% Discount'
		else 'No Discount'
	end as Discount
from orders

-- 17. Categorize employees' salaries as high, medium, or low.

select 
	employeeID,
    FirstName,
    Salary,
    case
		when salary >= 40000 then 'High'
        when salary >= 30000 then 'Medium'
        else 'Low'
	end as SalaryCategory
from employee