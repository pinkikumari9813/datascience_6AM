-- SQL Join
-- 1. Inner Join
-- 2. Left Join / Full Outer Left Join
-- 3. Right Join / Full Outer Right Join
-- 4. Full Outer Join
-- 5. Self Join
-- 6. Cross Join

-- Inner Join -> Common Record -> Primary Key and Foreign Key
--select
--	t1.column_name1, t1.column_name2, t2.column_name3, t2.column_name4
--from table1 t1
--join table 2 t2
--on t2.fk = t1.pk;

-- Find all order details of customers.
select
	sc.customer_id, sc.first_name, sc.last_name, sc.email, sc.street, sc.zip_code, sc.city,
	so.order_id, so.order_status, so.store_id,
	CASE
		When order_status = 1 Then 'Pending'
		When order_status = 2 Then 'Processing'
		When order_status = 3 Then 'Rejected'
		When order_status = 4 Then 'Completed'
	END as order_label
from sales.customers sc
join sales.orders so
on sc.customer_id = so.customer_id
where sc.first_name = 'Debra';


-- Find details of staffs who have handled which stores.
select
	Concat(ss.first_name, ' ', ss.last_name) as full_name,
	st.store_name
from sales.staffs ss
join sales.stores st
on ss.store_id = st.store_id;


-- Find total staffs in each store.
select
	st.store_id, st.state, st.store_name, count(ss.staff_id) as total_staffs
from sales.staffs ss
join sales.stores st
on ss.store_id = st.store_id
group by st.store_name, st.store_id, st.state;

-- Find total quantity that customer has purchased.
select
	concat(sc.first_name, ' ', sc.last_name) as full_name,
	sum(soi.quantity) as total_quantity
from sales.customers sc
join sales.orders so
on sc.customer_id = so.customer_id
join sales.order_items soi
on so.order_id = soi.order_id
group by concat(sc.first_name, ' ', sc.last_name)
having sum(soi.quantity) > 10;

-- Find all the names of customer and product they have purchased.
select
	CONCAT(sc.first_name, ' ', sc.last_name) as full_name,
	pp.product_name, pp.list_price
from sales.customers sc
join sales.orders so
on sc.customer_id = so.customer_id
join sales.order_items soi
on so.order_id = soi.order_id
join production.products pp
on soi.product_id = pp.product_id;


-- Find all the details of customers and orders even if they have ordered or not.
select
	*
from sales.customers sc
left join sales.orders so
on sc.customer_id = so.customer_id;

select
	*
from sales.orders sc
right join sales.customers so
on sc.customer_id = so.customer_id;

select
	*
from sales.customers sc
full outer join sales.orders so
on sc.customer_id = so.customer_id;

-- Self Join
-- Find name of staff and their assocoiate managers.
select
	CONCAT(s1.first_name, ' ', s1.last_name) as Manager_name,
	CONCAT(s2.first_name, ' ', s2.last_name) as Staff_name
from sales.staffs s1
join sales.staffs s2
on s1.staff_id = s2.manager_id;

select * from sales.customers;

select * from sales.orders;

select
	*
from sales.customers
cross join sales.orders;

-- subquery

--Product Pricing Tiers List all products, their category names, and their list prices. Use a 
--CASE statement to create a new column called 'Price_Segment' that labels them as: 
--• 'Budget' (if price is under $500) 
--• 'Mid-Range' (if price is between $500 and $2000) 
--• 'Premium' (if price is over $2000) 

select
	pp.product_name, pc.category_name, pp.list_price,
	CASE
		When pp.list_price < 500 Then 'Budget'
		When pp.list_price >= 500 and pp.list_price <= 2000 Then 'Mid-Range'
		Else 'Premium'
	END as Price_Segment
from production.products pp
join production.categories pc
on pp.category_id = pc.category_id;