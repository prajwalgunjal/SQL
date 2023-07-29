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

with cte_product 
as 
(select order_date, s.first_name,s.last_name from sales.orders o join sales.customers s on o.customer_id = s.customer_id)
select * from cte_product



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


	=-----------------------------------------
	=-----------------------------------------
	=-----------------------------------------
	=-----------------------------------------


	create procedure display 
as 
begin 
select s.first_name,s.last_name,s.phone,o.order_date,o.order_status from sales.customers s join sales.orders o on s.customer_id = o.customer_id
end 

exec display

create view viewdisplay
as 
select * from sales.customers

select * from viewdisplay



with cte_display
as
(select first_name,last_name from sales.customers)

select * from cte_display


