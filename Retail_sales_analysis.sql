Create database SQL_PROJECT_P1;
Drop table if exists retail_sales;
Create table retail_sales
				(
				transactions_id INT PRIMARY KEY,
                sale_date date,
                sale_time TIME,	
                customer_id INT,	
                gender VARCHAR(15),
                age int,
                category VARCHAR(15),	
                quantiy INT,
                price_per_unitFL float,	
                cogs FLOAT,
                total_sale float
                );

-- Finding null values. 


SELECT * FROM retail_sales
where transactions_id is null
or 
sale_date is null
or 
sale_time is null
or 
customer_id is null
or
gender is null
or 
age is null
or 
category IS NULL
or 
quantiy is null
or
price_per_unitFL is null
or 
cogs is null
or 
total_sale is null
;

-- Deleting null values. 


delete FROM retail_sales
where transactions_id is null
or 
sale_date is null
or 
sale_time is null
or 
customer_id is null
or
gender is null
or 
age is null
or 
category IS NULL
or 
quantiy is null
or
price_per_unitFL is null
or 
cogs is null
or 
total_sale is null
;

-- Q-1 Write a sql query to retrieve all columns for sales made on '2022-11-05

select * from retail_sales
where sale_date = '2022-11-05';

-- Q-2 Write a Sql query to retrieve all transactions where the category is 'clothing' and the quantity sold is more than 4 in the month of Nov-2022.

select *
from retail_sales
where category = 'Clothing'
and 
sale_date between '2022-11-01' and '2022-11-30'
and 
quantiy >= '4';  

-- Q-3 Write a sql query to calculate the total sales for each category.

select  distinct(category)
from retail_sales;

select category, 
	SUM(total_sale) as Net_sale,
    count(*) as Total_Orders
from retail_sales
GROUP BY category;

-- Q-4 Write a SQL query to find the average age of customers who purchased items from the 'beauty' category.

select category, 
	   AVG(age) AS Average_Age
from retail_sales
where category = 'beauty'
GROUP BY category;

-- Q-5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select count(*) from retail_sales
where total_sale > 1000;

-- Q-6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select category, 
	   gender, 
	   count(transactions_id)
from retail_sales 
group by category,
		 gender;

-- Q-7  Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.

select year, month, AVG_SALE
FROM
(select 
	   year(sale_date) as YEAR,
	   month(sale_date) as MONTH,
       avg(total_sale) as AVG_SALE,
       rank() over(partition by year(sale_date) order by avg(total_sale) desc) as rnk
from retail_sales
group by 
		YEAR,
        MONTH)
		as t
where rnk = 1;

-- Q-8 Write a SQL query to find the top 5 customers based on the highest total sales.

select 
	customer_id,
    sum(total_sale) as total_sales
from retail_sales
group by 
	customer_id
order by 
	total_sales DESC
    LIMIT 5;

-- Q-9 Write a SQL query to find the number of unique customers who purchased items from each category. 

select 
	category,
    count(distinct customer_id) as Unique_customer
from retail_sales
group by category;

-- Q-10 Write a SQL query to create each shift and number of orders. 

select 
	shift,
	count(transactions_id) as Orders
from
(
select *,
	CASE
		WHEN hour(sale_time) < 12 THEN 'Morning'
        WHEN hour(sale_time) between 12 and 17 THEN 'Afternoon'
        ELSE 'Evening'
	END as shift
from retail_sales) as Orders_by_shift
group by shift;