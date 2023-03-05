# Project SQL Superstore

### Case 1: Increase Sales Profit in Certain Product by Categories

Analyzing sales data to identify the most sold and profitable product categories.

```
select category, sum(sales) as Total_Sales, sum(Profit) as Total_Profit
from "order" o 
group by category 
order by Total_Sales desc
```

category       |Total_Sales|Total_Profit|
---------------|-----------|------------|
Technology     |  836155.44|   145454.97|
Furniture      |  741999.06|   18451.281|
Office Supplies|  719048.25|   122490.79|

It is known that the **highest sales** are in the **Technology** category. However, the **Office Supplies** category has the **highest profit** compared to other categories.

Next, further analysis will be conducted on the Office Supplies category to determine which products are the best-selling and most profitable.

```
select sub_category, sum(sales) as Total_Sales, sum(profit) as Total_Profit
from "order" o 
where category = 'Office Supplies'
group by sub_category
order by Total_Profit desc 
```
sub_category|Total_Sales|Total_Profit|
------------|-----------|------------|
Paper       |  78479.195|    34053.61|
Binders     |  203413.02|   30221.742|
Storage     |   223843.7|   21278.824|
Appliances  |  107532.14|   18138.006|
Envelopes   |  16476.404|    6964.179|
Art         |   27118.77|   6527.7812|
Labels      | 12486.3125|    5546.257|
Fasteners   |    3024.28|   949.51843|
Supplies    |   46673.54|  -1189.1006|

The information obtained is that the **Paper** sub-category has the **highest profit**.

Then find out which paper products are the best-selling and most profitable.

```
select product_name, sum(sales) as Total_Sales, sum(profit) as Total_Profit
from "order" o 
where sub_category = 'Paper'
group by product_name
order by Total_Profit desc
limit 10
```
product_name                      |Total_Sales|Total_Profit|
----------------------------------|-----------|------------|
Xerox 1915                        |  2789.0098|    1262.394|
Easy-staple paper                 |  2504.1917|   1096.0293|
Multicolor Computer Printout Paper|  1887.2999|   851.38196|
Xerox 1908                        |  1712.9879|    799.3944|
Xerox 1945                        |   1696.986|    756.2655|
Xerox 189                         |    1782.45|     746.532|
Xerox 1919                        |  1565.8179|   729.62195|
Xerox 1941                        |    1740.51|     704.592|
Xerox 1893                        |  1434.6499|    619.3589|
Xerox 1917                        |    1222.75|    574.6925|

It is known that the **Xerox product** has the **highest profit**. Therefore, it can be concluded that Superstore can increase profits in the Office Supplies category by strengthening sales in the paper sub-category and especially in Xerox products. This can be achieved by increasing promotion, adding product stock, or offering discounts on certain products.

<br>

### Case 2: Analyzing Product Performance and Determining Which Products Need to be Promoted

Find out the best selling products

```
select product_name, count(order_id) as Total_Orders, sum(sales) as Total_Sales 
from "order" o 
group by product_name 
order by Total_Orders desc
limit 10
```

product_name                                             |Total_Orders|Total_Sales|
---------------------------------------------------------|------------|-----------|
Staple envelope                                          |          48|  1686.8121|
Staples                                                  |          46|     755.47|
Easy-staple paper                                        |          46|  2504.1917|
Avery Non-Stick Binders                                  |          20|    217.316|
Staples in misc. colors                                  |          19|  478.81204|
KI Adjustable-Height Table                               |          18|  4552.6406|
Staple remover                                           |          18|  263.08798|
Storex Dura Pro Binders                                  |          17|    278.586|
Staple-based wall hangings                               |          16|  422.28802|
Logitech 910-002974 M325 Wireless Mouse for Web Scrolling|          15|  1409.5299|

It can be seen that there are several products that have been sold more than 40 times.

Next, I need to find out the average profit obtained

```
select avg(profit) as AVG_Profit
from "order" o 
```

AVG_Profit        |
------------------|
28.656896218822997|

The average profit obtained is around 28.66. Next, determine the products that need to be promoted. 

```
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
```

sub_category|product_name                                           |Total_Orders|Total_Sales|AVG_Profit        |
------------|-------------------------------------------------------|------------|-----------|------------------|
Binders     |Premium Transparent Presentation Covers by GBC         |          10|    753.182| 28.40692024230957|
Accessories |Sony Micro Vault Click 16 GB USB 2.0 Flash Drive       |           9|   1489.334|28.368267430199516|
Storage     |Home/Office Personal File Carts                        |           7|  980.23206|  28.3045711517334|
Binders     |Trimflex Flexible Post Binders                         |           4|  346.35602|28.221599340438843|
Chairs      |Hon Every-Day Series Multi-Task Chairs                 |          10|   6748.482|28.197001647949218|
Phones      |Plantronics 81402                                      |           4|    844.672| 28.04574966430664|
Phones      |Samsung HM1900 Bluetooth Headset                       |           7|     491.68| 27.90785707746233|
Envelopes   |White Envelopes, White Envelopes with Clear Poly Window|           5|     320.25|27.815999603271486|
Paper       |Xerox 1933                                             |           5|     294.72|27.703679656982423|
Furnishings |Nu-Dell Leatherette Frames                             |           3|  246.64801|27.150399843851726|

It is known that there are products that have profits below average. Therefore, Superstore needs to promote these products specifically to increase sales and provide a greater contribution to the company's profitability.

<br>

### Case 3: Analyzing Sales Performance by Product Category in 2020.

```
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
```

category       |Total_Quantity|Percentage|
---------------|--------------|----------|
Office Supplies|          7676|61.53%    |
Furniture      |          2437|19.53%    |
Technology     |          2363|18.94%    |

From the above, it can be seen that the **Office Supplies** category is the **best-selling** product category in **2020** with a total sales of **7676 products** or **around 61.53%** of the total products sold. 

The Superstore can optimize sales in product categories with lower sales percentages such as the technology category by increasing promotion, adding stocks, or offering discounts on certain products. In addition, the Superstore can also focus on product categories with the highest sales percentages to increase revenue and profits.
