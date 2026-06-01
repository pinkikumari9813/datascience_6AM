-- SubQuery/Nested Query

-- Query nested inside another query.

-- Outer Query
-- Inner Query -> Executes first

-- Single Row Subquery -> Inner query provides single row and single column data.
-- Multi Row Subquery -> Inner query provides multi row and single column data.

-- Single Row Subquery -> =, !=, >, <, >=, <=
-- Multi Row Subquery -> In (category), Any, All (continuous)
-- comparision operator is used with Any and All.

-- Find details of orders list price whose list price is less than average list price.
select avg(list_price) from sales.order_items;

select
	*
from sales.order_items where list_price < 1212.707871;

select * from sales.order_items where list_price > (
	select avg(list_price) from sales.order_items
);

-- Find second highest list price among all list price.
select * from sales.order_items where list_price = (
	select max(list_price) from sales.order_items where list_price < (
		select max(list_price) from sales.order_items
	)
);

select * from sales.orders where order_date = (
	select min(order_date) from sales.orders where order_date > (
		select min(order_date) from sales.orders
	)
);

-- find product details whose categories are Children Bicycles, Comfort Bicycles

select
	pp.product_name, pp.brand_id, pp.category_id, pp.model_year, pp.list_price
from production.products pp
join production.categories pc
on pp.category_id = pc.category_id
where pc.category_name in ('Children Bicycles', 'Comfort Bicycles');

select product_name, brand_id, category_id, model_year, list_price from 
production.products where category_id in (
	select
		category_id
	from production.categories where category_name in ('Children Bicycles', 'Comfort Bicycles')
);


-- 109.99, 189.99

-- any -> Inclusive
select * from sales.order_items where list_price <any (
	select list_price from sales.order_items where list_price in (109.99, 189.99)
);

-- all -> Exclusive
select * from sales.order_items where list_price <all (
	select list_price from sales.order_items where list_price in (109.99, 189.99)
);

--8. Brand Performance Analysis Identify the brands that have sold more than 100 units in 
--total. Your output should include the Brand Name, the total Quantity Sold, and a CASE 
--statement that flags the brand as "Top Performer" if sales exceed 500 units, and 
--"Standard" otherwise. (Hint: Join brands, products, and order_items).

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
and Case	
		When sum(soi.quantity) > 500 then 'Top Performer'
		Else 'Standard'
	End = 'Top Performer';

--window function