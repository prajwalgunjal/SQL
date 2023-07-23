--Create a table named "Employees" with columns for employee ID, name, age, and department.
--Add a new column named "Salary" to the "Employees" table.
--Rename the column "Department" to "Dept" in the "Employees" table.
--Insert a new employee record into the "Employees" table.
--Update the salary of employee with ID 1 to 55000.00 in the "Employees" table.
--Delete all records from the "Employees" table where the age is less than 25.



create table Employees (
employee_ID int,
name varchar(50),
age int ,
department varchar(50),
)

drop table Employees
ALTER TABLE Employees
RENAME COLUMN Department TO Dept;


UPDATE Employees
SET Dept = Department;



--rename department set dept
--alter table Employees set (
--Salary int
--)

select * from Employees
alter table Employees ADD Salary decimal
insert into Employees values(5,'Prajkta',23,'IT'),(3,'suknya',22,'SDE'),(4,'sanjana',22,'abc'),(1,'Prajwal',23,'IT')

select * from Employees



update Employees set Salary = 55000.00 where employee_ID =1;

delete from Employees where age < 25

alter table Employees 
RENAME column department to dept

------------------------------------------------------------------------------
--select query
select first_name,last_name from sales.staffs order by first_name 
	

-- order by	asc
select first_name,last_name from sales.staffs order by first_name

-- order by desc 

select first_name,last_name from sales.staffs order by first_name desc



select first_name,last_name,City from sales.customers order by first_name,last_name,city asc



--To skip the first 10 products and return the rest, you use the OFFSET
select first_name,last_name,City from sales.customers order by first_name,last_name,city asc offset 10 rows;

--PERCENT uses to specify the number of products returned in the result set. The production.products table has 321 rows, therefore, 
--one percent of 321 is a fraction value ( 3.21), SQL Server rounds it up to the next whole number which is four ( 4) in this case.
select top 3 percent 
	category_id,
	category_name
from
	production.categories
order by 
	category_name desc

--distinct 
select distinct(city) from sales.customers order by city

SELECT top 10 product_id,product_name,category_id,model_year,list_price
FROM
    production.products
WHERE
    category_id = 1
ORDER BY
    list_price DESC

select top 11 product_id,product_name,category_id,model_year,list_price
from
	production.products
where category_id =1 and model_year=2018
order by list_price desc


select category_id , product_name from production.products where category_id in (1,10) order by category_id


select product_name, product_id,category_id,model_year,list_price from production.products where list_price>300 and model_year=2018 order by list_price


select product_name, product_id,category_id,model_year,list_price from production.products where list_price in (299.99,369.99,489.99) order by list_price asc
















----------------------------------------------------------------join----------------------------------------------------------------------------------------------------------
select product_name,category_name,list_price from production.products p join production.categories c on c.category_id = p.category_id order by product_name desc

select product_name,category_name,brand_name,list_price from production.products p join production.categories c on c.category_id = p.category_id 
inner join production.brands b on b.brand_id = p.brand_id


SELECT product_name, order_id FROM production.products p LEFT JOIN sales.order_items o ON o.product_id = p.product_id ORDER BY order_id;



SELECT product_name, order_id FROM production.products p LEFT JOIN sales.order_items o ON o.product_id = p.product_id WHERE order_id IS NULL

SELECT p.product_name, o.order_id, i.item_id, o.order_date FROM production.products p LEFT JOIN sales.order_items i ON i.product_id = p.product_id LEFT JOIN sales.orders o ON o.order_id = i.order_id ORDER BY order_id;

SELECT product_name, order_id FROM sales.order_items o RIGHT JOIN production.products p ON o.product_id = p.product_id ORDER BY order_id;


WITH cte_sales AS (
    SELECT staff_id, COUNT(*) order_count  
    FROM sales.orders WHERE YEAR(order_date) = 2018 GROUP BY staff_id
)

SELECT AVG(order_count) average_orders_by_staff FROM cte_sales;

SELECT staff_id, COUNT(*) order_count FROM sales.orders WHERE YEAR(order_date) = 2018 GROUP BY staff_id;

WITH cte_sales_amounts (staff, sales, year) AS (
SELECT   first_name + ' ' + last_name, SUM(quantity * list_price * (1 - discount)),YEAR(order_date)
    FROM  sales.orders o
    INNER JOIN sales.order_items i ON i.order_id = o.order_id
    INNER JOIN sales.staffs s ON s.staff_id = o.staff_id
    GROUP BY first_name + ' ' + last_name, year(order_date)
)

SELECT staff,  sales FROM  cte_sales_amounts WHERE year = 2018;

-------------------------------------------------------------Stored Procedure--------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE uspProductList AS BEGIN
    SELECT product_name, list_price FROM production.products
    ORDER BY product_name END;

	exec uspProductList

ALTER PROCEDURE uspProductList
AS
BEGIN
        SELECT product_name,list_price 
		FROM production.products
        ORDER BY list_price END;

exec uspProductList

DROP PROCEDURE uspProductList;

CREATE PROCEDURE uspFindProducts 
AS
BEGIN 
SELECT product_name,list_price
    FROM production.products ORDER BY list_price 
	END;
exec uspFindProducts



First, we added a parameter named @min_list_price to the uspFindProducts stored procedure.
Every parameter must start with the @ sign. The AS DECIMAL keywords specify the data type of the @min_list_price parameter.
The parameter must be surrounded by the opening and closing brackets.
Second, we used @min_list_price parameter in the WHERE clause of the SELECT statement to filter only the products whose
list prices are greater than or equal to the @min_list_price.

ALTER PROCEDURE uspFindProducts
(
@min_list_price AS DECIMAL)
AS
BEGIN
    SELECT
        product_name,
        list_price
    FROM 
        production.products
    WHERE
        list_price >= @min_list_price
    ORDER BY
        list_price;
END;

EXEC uspFindProducts 100;
EXEC uspFindProducts 200;



ALTER PROCEDURE uspFindProducts(
    @min_list_price AS DECIMAL
    ,@max_list_price AS DECIMAL
)
AS
BEGIN
    SELECT
        product_name,
        list_price
    FROM 
        production.products
    WHERE
        list_price >= @min_list_price AND
        list_price <= @max_list_price
    ORDER BY
        list_price;
END;


EXECUTE uspFindProducts 900, 1000;


--------------------------------------------------------------------------------------------------------------------------------------
A CTE (Common Table Expression) is a temporary result set in SQL that allows you to define a named query within the scope of a single SQL statement
use - breaking down complex queries into smaller, 
more manageable parts, making SQL code more readable and maintainable.
CTEs are defined using the WITH keyword, followed by the CTE name and the query that defines it. 
The CTE is then referenced within the main query as if it were a regular table or view.
CTEs are particularly useful when dealing with complex queries involving multiple joins, aggregations, or subqueries. 
They improve query readability and maintainability by isolating intermediary steps.
In many cases, CTEs can enhance query performance by allowing the database optimizer to materialize the 
temporary result set and optimize its usage within the main query.

Syntax: CTEs are defined using the WITH keyword, followed by the CTE name and the query that defines it. 
The CTE is then referenced within the main query as if it were a regular table or view.

Usage: CTEs are particularly useful in scenarios where you need to refer to the same subquery multiple times within the main query.
Instead of repeating the subquery or using temporary tables, you can define it once using a CTE and then use the CTE in the main query.


eg 
WITH SalesCTE AS (
    SELECT ProductID, SUM(Quantity) AS TotalSold
    FROM Sales
    GROUP BY ProductID
)
SELECT ProductID, TotalSold
FROM SalesCTE
WHERE TotalSold > 100;

In this example, the CTE "SalesCTE" calculates the total quantity sold for each product from the "Sales" table. 
The main query then filters the results and retrieves only the products with a total quantity sold greater than 100.






WITH cte_sales_amounts (staff, sales, year) AS (
    SELECT    
        first_name + ' ' + last_name, 
        SUM(quantity * list_price * (1 - discount)),
        YEAR(order_date)
    FROM    
        sales.orders o
    INNER JOIN sales.order_items i ON i.order_id = o.order_id
    INNER JOIN sales.staffs s ON s.staff_id = o.staff_id
    GROUP BY 
        first_name + ' ' + last_name,
        year(order_date)
)

SELECT
    staff, 
    sales
FROM 
    cte_sales_amounts
WHERE
    year = 2018;








	WITH cte_sales AS (
    SELECT 
        staff_id, 
        COUNT(*) order_count  
    FROM
        sales.orders
    WHERE 
        YEAR(order_date) = 2018
    GROUP BY
        staff_id

)
SELECT
    AVG(order_count) average_orders_by_staff
FROM 
    cte_sales;














































----------------------------------------------------------------------------------------------------------------
--Modify an existing table by adding, modifying, or dropping columns or constraints.
alter table Employees add Salary decimal 
select * from Employees


--Deletes an existing table and all its data.
drop table Employees

--Inserts new rows into a table.
insert into Employees values(10,'Rohit',55,'Electrical',5000.5),(9,'Sahil',22,'Computer',50000.5)

--Modifies existing rows in a table.
update Employees set employee_ID = 10000 where employee_ID = 5
update Employees set Salary = 1000 where employee_ID = 10000
update Employees set Salary = 2000 where employee_ID = 2
update Employees set Salary = 3000 where employee_ID = 3
update Employees set Salary = 4000 where employee_ID = 4
update Employees set Salary = 5000 where employee_ID = 10
update Employees set Salary = 6000 where employee_ID = 9



--Retrieve the names of employees in alphabetical order.
select name from Employees order by name 


--Retrieve the names and salaries of the first 5 highest-paid employees.
select top 5 max(Salary) from Employees group by Salary order by Salary desc


--Retrieve the names of employees whose names start with the letter 'A'.
select name from Employees where name like 's%'


--Skip first 2 data and retrieve next data from table.
select name from Employees order by name offset 2 rows

-- use db OrderManagement 
--Do inner join on two table of your choice.
use OrderManagementSystem
select FirstName, LastName,OrderDate from Customers join Orders on Customers.CustomerId = Orders.CustomerId

--Removes rows from a table.
use master
delete * from Employees where name is not Null


--Deletes all rows from a table while keeping the table structure intact.
delete Employees