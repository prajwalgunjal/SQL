use bikestore
CREATE VIEW sales.product_info
AS
SELECT
    product_name, 
    brand_name, 
    list_price
FROM
    production.products p
INNER JOIN production.brands b 
        ON b.brand_id = p.brand_id;

SELECT * FROM sales.product_info;




CREATE VIEW sales.daily_sales
AS
SELECT
    year(order_date) AS y,
    month(order_date) AS m,
    day(order_date) AS d,
    p.product_id,
    product_name,
    quantity * i.list_price AS sales
FROM sales.orders AS o
INNER JOIN sales.order_items AS i
    ON o.order_id = i.order_id
INNER JOIN production.products AS p
    ON p.product_id = i.product_id;


SELECT * FROM sales.daily_sales
ORDER BY y, m, d, product_name;

--------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS sales.daily_sales;





---------------------------------------------------------------------------------------------------------------------------------
create view display_Orders
as
select * from sales.orders

select * from display_Orders

-- basic cmd 
---------------------------------------------------------------------------------------------------------------------------------
alter view display_Orders
as 
select c.first_name,c.last_name,c.phone,o.order_date,o.order_status from sales.customers c join sales.orders o on c.customer_id = o.customer_id

select * from display_Orders

---------------------------------------------------------------------------------------------------------------------------------




---------------------------------------------------------------------------------------------------------------------------------









---------------------------------------------------------------------------------------------------------------------------------





---------------------------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------------------------------



---------------------------------------------------------------------------------------------------------------------------------




---------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------