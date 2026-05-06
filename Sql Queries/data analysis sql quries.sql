use profit_analysis;

-- product wise analysis

-- product with most profit  

SELECT 
	 Product ,
     sum(Cost) as total_cost,
     sum(Profit) as total_profit,
     sum(Revenue) as total_revenue
FROM sales GROUP BY Product ORDER BY total_profit DESC;

-- product with top profit percentage 
SELECT 
	 Product ,
     sum(Cost) as total_cost,
     sum(Profit) as total_profit,
	 (sum(Profit)/sum(Cost)) AS profitPercentage
FROM sales GROUP BY Product ORDER BY profitPercentage DESC LIMIT 5;

-- product the high profit margin

     SELECT 
	 Product ,
     sum(Revenue) as total_Revenue,
     sum(Profit) as total_profit,
	 (sum(Profit)/sum(Revenue)) AS profitMargin
FROM sales GROUP BY Product ORDER BY profitMargin DESC LIMIT 5;

-- most demand product in youth
SELECT 
	product ,
    sum(Order_Quantity) as total_Quantity 
    
FROM sales 
WHERE AgeGroup='Young'
GROUP BY Product
ORDER BY total_Quantity  DESC LIMIT 5;

-- rank the product by profit
SELECT 
	Product ,
    sum(Profit) as total_profit ,
RANK() Over (ORDER BY SUM(Profit) DESC) as Profitranks
FROM sales 
GROUP BY Product ;

-- above  and below average 
SELECT 
    Product,
    SUM(Profit) AS total_profit,
    CASE
        WHEN SUM(Profit) > (
            SELECT AVG(product_profit)
            FROM (
                SELECT SUM(Profit) AS product_profit
                FROM sales
                GROUP BY Product
            ) AS avg_table
        ) THEN 'Above Average'

        WHEN SUM(Profit) = (
            SELECT AVG(product_profit)
            FROM (
                SELECT SUM(Profit) AS product_profit
                FROM sales
                GROUP BY Product
            ) AS avg_table
        ) THEN 'Average'

        ELSE 'Below Average'
    END AS ProfitAverage
FROM sales
GROUP BY Product;
    
    
	
-- country wise analysis


SELECT
	Country,
    product,
    cost,profit 
from sales;

-- total cost and total profit by country
SELECT 
	country,
    sum(Revenue) as total_revenue ,
    sum(profit) as total_profit 
FROM sales GROUP BY country ORDER BY  total_profit DESC;

-- top countries with high profit percentage

SELECT 
	country,
    sum(cost) as total_cost ,
    sum(profit) as total_profit,
    (sum(profit)/sum(cost))*100 as ProfitPercentage
FROM sales GROUP BY country ORDER BY ProfitPercentage DESC;

-- total number of customer by country

SELECT 
country ,
count(Customer_Gender) as total_customer
from sales GROUP BY country ORDER BY  total_customer DESC;

-- total number of  female customer by country

SELECT 
country ,
count(Customer_Gender) as total_customer
from sales WHERE Customer_Gender='Female' GROUP BY country ORDER BY  total_customer DESC;

SELECT 
country ,
count(Customer_Gender) as total_customer
from sales WHERE Customer_Gender='male' GROUP BY country ORDER BY  total_customer DESC;

-- by Age Group
with YoungProductSales AS 
(SELECT 
    Product,
	sum(profit) as total_profit,
    sum(Revenue) as total_revenue ,
    sum(Order_Quantity) as total_number 
FROM sales 
WHERE AgeGroup='Young' 
Group by Product )

SELECT * FROM YoungProductSales 
ORDER BY total_profit DESC;

-- trend of profit ,revenue and quantity in senior

with SeniorProductSales AS 
(SELECT 
    Product,
	sum(profit) as total_profit,
    sum(Revenue) as total_revenue ,
    sum(Order_Quantity) as total_number 
FROM sales 
WHERE AgeGroup='Senior' 
Group by Product )

SELECT * FROM SeniorProductSales 
ORDER BY total_profit DESC;	

-- total profit,revenue and number of item sold  across year 

SELECT 
	YEAR(Date) as years,
    sum(revenue) as total_revenue,
    sum(Profit) as total_profit,
    sum(Order_Quantity) as TotalItemNumber
FROM sales 
GROUP BY years ;

-- finding highest profatale product in 2014

SELECT 
	Product ,
    sum(Profit) as total_profit 
FROM sales 
WHERE YEAR(Date) = 2014
GROUP by Product Order BY total_profit DESC LIMIT 1;
