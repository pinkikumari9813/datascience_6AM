-- Group by and Having
select * from sales.customers;

-- Aggreate Column -> Column which is defined inside aggregate function.
-- Non-Aggregate Column -> Column which is not defined inside aggregate function.

-- Rules of Group by
-- If any non-aggregate defined with aggregate column then we must need to define 
-- non-aggregate column in group by

-- Alias only can be used in order by. It cannot be used in Group By, Where or Having.
-- Aggregate -> Sum, Avg, Count, Min, Max

-- Find total customers by each state.
select
	state, count(customer_id) as total_customer
from sales.customers
group by state;

-- Find total customers and total orders by each year.
select
	Month(order_date) as Order_Month, COUNT(customer_id) as total_customer, 
	count(order_id) as total_orders, DATENAME(weekday, order_date) as order_month
from sales.orders
group by Month(order_date), DATENAME(weekday, order_date);


-- Having -> Data Filter
-- Where -> Data Filter
-- Rule 1: Having is used only to filter aggregate column data.
-- Rule 2: Having also filter data if any column is defined in group by.
-- Rule 3: If column not defined in group by clause then having cannot filter that data for this Where clause is must.
select
	state, COUNT(customer_id) as total_customer
from sales.customers
group by state
having state = 'CA';

select
	state, COUNT(customer_id) as total_customer
from sales.customers
group by state, city
having city = 'Albany';

select
	state, COUNT(customer_id) as total_customer
from sales.customers
group by state
having COUNT(customer_id) > 200;

-- Find total price spent by customer in each order only show data whose price is more than 4000.
select
	order_id, sum(((quantity * list_price) * (1 - discount))) as total_price
from sales.order_items
group by order_id
having sum(((quantity * list_price) * (1 - discount))) > 20000;
