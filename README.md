# Project SQL Superstore
Analyzing the Superstore dataset using PostgreSQL

### Case 1: Increase Sales Profit in Certain Product by Categories

Analyzing sales data to identify the most sold and profitable product categories.

```
select category , sum(sales) as Total_Sales, sum(Profit) as Total_Profit
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

Didapatkan informasi bahwa total


