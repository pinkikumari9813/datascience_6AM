-- CTE (Common Table Expressions)
-- Temporary Table
-- Syntax
--With cte_name as (
--	query.....
--)select * from cte_name;

With brand_quantity as (
	select
		pb.brand_name, sum(soi.quantity) as total_quantity,
		Case	
			When sum(soi.quantity) > 500 then 'Top Performer'
			Else 'Standard'
		End as Quantity_Label
	from production.brands pb
	join production.products pp
	on pb.brand_id = pp.brand_id
	join sales.order_items soi
	on pp.product_id = soi.product_id
	group by pb.brand_name
	having sum(soi.quantity) > 100
)
select * from brand_quantity where Quantity_Label = 'Standard';

With brand_quantity_count as (
	select
		pb.brand_name, sum(soi.quantity) as total_quantity,
		Case	
			When sum(soi.quantity) > 500 then 'Top Performer'
			Else 'Standard'
		End as Quantity_Label
	from production.brands pb
	join production.products pp
	on pb.brand_id = pp.brand_id
	join sales.order_items soi
	on pp.product_id = soi.product_id
	group by pb.brand_name
	having sum(soi.quantity) > 100
)
select quantity_label, count(brand_name) as total_brand
from brand_quantity_count group by quantity_label;

With category_price as (
	select
		pp.product_name, pc.category_name, pp.list_price,
		CASE
			When pp.list_price < 500 Then 'Budget'
			When pp.list_price >= 500 and pp.list_price <= 2000 Then 'Mid-Range'
			Else 'Premium'
		END as Price_Segment
	from production.products pp
	join production.categories pc
	on pp.category_id = pc.category_id
)select category_name, sum(list_price) as total_price from category_price
group by category_name;

-- Window Function
-- Row_Number()
-- Rank()
-- Dense_Rank()

-- NTile()
-- Lead()
-- Lag()

-- Row Number
select
	first_name, last_name, email, state, city, zip_code,
	ROW_NUMBER() OVER(partition by city order by city) as rn
from sales.customers;

-- Rank
select
	order_id, item_id, product_id, quantity, list_price, discount,
	RANK() OVER(order by list_price) as rn
from sales.order_items;

-- Dense Rank
select * from (
	select
		order_id, item_id, product_id, quantity, list_price, discount,
		DENSE_RANK() OVER(order by list_price desc) as rn
	from sales.order_items
) as list_price_details
where rn = 10;

-- NTile
select
	first_name, last_name, email, state, city, zip_code,
	NTILE(10) OVER(order by city) as rn
from sales.customers;

-- LEAD (Next Value)
select
	first_name, last_name, email, state, city, zip_code,
	LEAD(first_name) OVER(order by first_name) as val
from sales.customers;

-- LAG (Previous Value)
select
	first_name, last_name, email, state, city, zip_code,
	LAG(first_name) OVER(order by first_name) as val
from sales.customers;





