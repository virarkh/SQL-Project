--Case 1: Increase Sales Profit in Certain Product by Categories

select category, sum(sales) as Total_Sales, sum(Profit) as Total_Profit
from "order" o 
group by category 
order by Total_Sales desc

select sub_category, sum(sales) as Total_Sales, sum(profit) as Total_Profit
from "order" o 
where category = 'Office Supplies'
group by sub_category
order by Total_Profit desc 

select product_name, sum(sales) as Total_Sales, sum(profit) as Total_Profit
from "order" o 
where sub_category = 'Paper'
group by product_name
order by Total_Profit desc
limit 10


--Case 2: Analyzing Product Performance and Determining Which Products Need to be Promoted

select product_name, count(order_id) as Total_Orders, sum(sales) as Total_Sales 
from "order" o 
group by product_name 
order by Total_Orders desc
limit 10

select avg(profit) as AVG_Profit
from "order" o 

select sub_category, product_name, count(order_id) as Total_Orders, sum(sales) as Total_Sales, avg(profit) as AVG_Profit
from "order" o 
where product_name in (
	select product_name
	from "order" o 
	group by product_name 
	having avg(profit) < 28.656896218822997
)
group by sub_category, product_name 
order by AVG_Profit desc
limit 10


--Case 3: Analyzing Sales Performance by Product Category in 2020.

with order_date as (
	select category, sum(quantity) as Total_Quantity
	from "order" o 
	where extract(year from o.order_date) = 2020
	group by category 
),
order_percentage as (
	select category, Total_Quantity, cast(Total_Quantity as decimal) / sum(Total_Quantity) over() as percentage
	from order_date
)

select category, Total_Quantity, concat(round(percentage * 100, 2), '%') as Percentage
from order_percentage
order by Total_Quantity desc


--Case 4: Analyze sales performance in each segment for the city of Los Angeles in Q4 2019.

select c.segment, count(o.quantity) as Total_Orders, sum(o.sales) as Total_Sales
from "order" o 
inner join customer c on c.customer_id = o.customer_id 
where c.city = 'Los Angeles' and o.order_date between '2019-10-01' and '2019-12-31'
group by c.segment 
order by Total_Orders desc



































