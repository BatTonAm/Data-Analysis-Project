-- CHANGE OVER TIME ANALYSIS
SELECT
DATETRUNC(MONTH, order_date) AS order_date,
SUM(sales) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customer,
SUM(quantity) AS total_quantity
FROM golden.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH, order_date)
ORDER BY DATETRUNC(MONTH, order_date);

-- CUMMULATIVE TOTAL SALES ANALYSIS
SELECT 
order_date,
total_sales,
SUM(total_sales) OVER(ORDER BY order_date) AS cummulative_total_sales,
AVG(avg_price) OVER (ORDER BY order_date) AS moving_average_price
FROM 
(
SELECT 
DATETRUNC(YEAR, order_date) AS order_date,
SUM(sales) AS total_sales,
AVG(price) AS avg_price
FROM golden.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(YEAR, order_date)) t;

--Analyze yearly performance of products 
WITH yearly_product_sales AS(
SELECT 
YEAR(s.order_date) AS order_year,
p.product_name,
SUM(s.sales) AS current_sales
FROM golden.fact_sales s
LEFT JOIN golden.dim_products p
ON s.product_key=p.product_key
WHERE order_date IS NOT NULL
GROUP BY YEAR(s.order_date), p.product_name)

SELECT 
order_year,
product_name,
current_sales,
AVG(current_sales) OVER (PARTITION BY product_name) AS avg_sales,
current_sales-AVG(current_sales) OVER (PARTITION BY product_name) AS diff_avg,
CASE 
    WHEN current_sales > AVG(current_sales) OVER (PARTITION BY product_name)
        THEN 'Above Average'
    WHEN current_sales < AVG(current_sales) OVER (PARTITION BY product_name)
        THEN 'Below Average'
    ELSE 'Average'
END AS avg_change,
--YOY ANALYSIS
LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) py_sales,
current_sales-LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS diff_py,
CASE WHEN current_sales > LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) THEN 'Increase'
    WHEN current_sales < LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) THEN 'Decrease'
    ELSE 'No change'
END AS py_change
FROM yearly_product_sales
ORDER BY product_name, order_year

-- Which category contribute the most to overall sales?
WITH category_sales AS
(SELECT
category,
SUM(sales) AS total_sales
FROM golden.fact_sales s
LEFT JOIN golden.dim_products p
ON p.product_key=s.product_key
GROUP BY category)

SELECT 
category,
total_sales,
SUM(total_sales) OVER () AS overall_sales,
CONCAT(ROUND((CAST(total_sales AS FLOAT)/ SUM(total_sales) OVER ())*100, 2), '%') AS percentage_of_total
FROM category_sales
ORDER BY total_sales DESC;

/*Segment product into cost range*/
WITH product_segment AS
(SELECT 
product_key,
product_name,
cost,
CASE WHEN cost < 100 then 'Below 100'
    WHEN cost BETWEEN 100 AND 500 THEN '100-500'
    WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
    ELSE 'Above 1000'
END AS cost_range
FROM golden.dim_products)

SELECT 
cost_range,
COUNT(product_key) AS total_products
FROM product_segment
GROUP BY cost_range
ORDER BY total_products DESC

/* Group customer into 3 categories:
VIP: lifespan at least 12 months and spent more than 5000
Regular: lifespan at least 12 months and spent <= 5000
New: lifespan <12 months*/

WITH customer_spending AS
(SELECT 
c.customer_key,
SUM(s.sales) AS total_spending,
MIN(s.order_date) AS first_order,
MAX(s.order_date) AS last_order,
DATEDIFF(month, MIN(s.order_date), MAX(s.order_date)) AS lifespan
FROM golden.fact_sales s
LEFT JOIN golden.dim_customers c
ON s.customer_key=c.customer_key
GROUP BY c.customer_key)

SELECT customer_segment,
COUNT(customer_key) AS total_customer
FROM
(SELECT 
customer_key,
CASE WHEN lifespan > 12 AND total_spending>5000 THEN 'VIP'
    WHEN lifespan > 12 AND total_spending <= 5000 THEN 'Regular'
    ELSE 'New'
END AS customer_segment
FROM customer_spending) t
GROUP BY customer_segment
ORDER BY total_customer DESC;
