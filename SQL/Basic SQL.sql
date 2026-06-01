use BikeStores;

-- For data filtering use Where Clause
-- Where, Group by, Having, Order by -> Clause

select
	*
from sales.customers
where city  = 'Orchard Park';

-- Concat function / Concatenation Operator (+)
-- concat first name and last name as full name.

select
	CONCAT(first_name, ' ', last_name) as full_name,
	email, state, city, street, zip_code
from sales.customers;

select
	first_name + ' ' + last_name as full_name,
	email, state, city, street, zip_code
from sales.customers;

select
	CONCAT(product_name, '-----', list_price) as unique_product_name
from production.products;

select
	product_name + '-----' + list_price as	unique_product_name
from production.products;

-- Extract year, month and day.
select
	YEAR(order_date) as order_year, MONTH(order_date) as order_Month,
	DAY(order_date) as order_Day,
	DATENAME(MONTH, order_date) as month_name,
	DATENAME(WEEKDAY, order_date) as day_name
from sales.orders;

-- Substring, left, right
-- Extracts specific number of letters/digits from text.

-- substring(column_name, start, numbers of letters to extract)
select
	first_name, SUBSTRING(first_name, 5, 3) as extracted_letters
from sales.customers;

-- Right(column_name, numbers of letters to extract)
select
	first_name, RIGHT(first_name, 4) as last_letters
from sales.customers;

-- Left(column_name, numbers of letters to extract)
select
	first_name, Left(first_name, 2) as first_letters
from sales.customers;

select * from sales.customers;

--customer_id - first_name(3, 5) - last_name(last 3 letters) - email(5, 4) - 
--street(4, 2) - city(last 3 letters) - state - zip_code(2, 3)

--1-bra-rks-a.bur-3 Tho-ve.-NY-412
select
	CONCAT(customer_id, '-', SUBSTRING(first_name, 3, 5), '-',
		RIGHT(last_name, 3), '-', SUBSTRING(email, 5, 4), '-', 
		SUBSTRING(street, 4, 2), '-', right(city, 3), '-', state, '-',
		SUBSTRING(zip_code, 2, 3)) as customer_id,
	first_name, last_name, email, phone, street, city, zip_code, state
from sales.customers;

--Where
-- Find details of customers whose last name is Burks.
select
	first_name, last_name, email, state, zip_code
from sales.customers
where last_name = 'Burks';

-- Find customer details who lives in NY (New York) or CA (California).
select
	first_name, last_name, email, state, zip_code
from sales.customers;

-- Mysql/pgsql -> limit
-- oracle -> offset-fetch
-- sqlserver -> top

-- Where
-- Between -> It simplifies AND Condition Filtering
-- In -> It simplifies OR Condition Filtering
-- And
-- OR
-- Like -> Pattern Matching

-- Find details of customers who lives in city Orchard Park, Fairport.
select
	first_name, last_name, email, street, city, state, zip_code
from sales.customers
where city = 'Fairport' OR city = 'Orchard Park' or city = 'Campbell';

select
	first_name, last_name, email, street, city, state, zip_code
from sales.customers
where city in('Fairport', 'Orchard Park', 'Campbell');

-- find price range of order item details from 1000 to 3000.
select
	*
from sales.order_items
where list_price > 1000 and list_price < 3000;

select
	*
from sales.order_items
where list_price between 1000 and 3000;

-- Like -> Used for pattern matching
-- Wildcards -> %, _
-- Find details of customers whose first name starts with letter S.
select
	*
from sales.customers
where first_name like 'S%';

-- Find details of customers whose first name ends with letter s.
select
	*
from sales.customers
where first_name like '%s';

-- Find details of customers whose first name must consist of 'iu'.
select
	*
from sales.customers
where first_name like '%iu%';

select
	*
from sales.customers
where first_name like 'J%u%u%';

-- Find customer details whose name must start with letter L and must consist of 3 letters.
select
	*
from sales.customers
where first_name like 'L__';

-- Find customer details whose name must start with letter L and third letter must be s.
select
	*
from sales.customers
where first_name like 'L_s%';

-- SQL CASE
-- Order status: 1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed
--CASE
--	When Condition Then 'show anything 1'
--	When Condition Then 'show anything 2'
--	Else 'show anything 1'
--End

select
	customer_id, order_date, store_id, staff_id, order_status,
	CASE
		When order_status = 1 Then 'Pending'
		When order_status = 2 Then 'Processing'
		When order_status = 3 Then 'Rejected'
		When order_status = 4 Then 'Completed'
	END as order_label
from sales.orders
where 
	CASE
		When order_status = 1 Then 'Pending'
		When order_status = 2 Then 'Processing'
		When order_status = 3 Then 'Rejected'
		When order_status = 4 Then 'Completed'
	END = 'Rejected'
order by 5;

-- Find total price of order item details
-- Total Price 70 - 500 -> Low Price
-- Total Price 501 - 2500 -> Medium Price
-- Total Price > 2500 -> High Price

select
	product_id, quantity, list_price, discount,
	(list_price * quantity) * (1 - discount) as total_price,
	CASE
		When (list_price * quantity) * (1 - discount) between 70 and 500 Then 'Low Price'
		When (list_price * quantity) * (1 - discount) between 501 and 2500 Then 'Medium Price'
		When (list_price * quantity) * (1 - discount) > 2500 Then 'High Price'
	End as price_label
from sales.order_items
order by 5;

select
	product_id, quantity, list_price, discount,
	((list_price * quantity) - ((list_price * quantity) * discount)) as total_price
from sales.order_items;






