/* Customer Report
1. names, ages, transaction details
2. VIP, Regular, New?
3. Aggregate metrics:
-total orders
-total sales
-total quantity purchase
-total products
-lifespan
4. Calculate KPIS:
- Recency
- Average order value
- Average monthly spending
*/
CREATE VIEW golden.customer_report AS
WITH base AS (SELECT 
c.customer_key,
c.customer_number,
CONCAT(c.first_name,c.last_name) AS customer_name,
DATEDIFF(YEAR,c.birthdate,GETDATE()) AS age,
s.order_number,
s.product_key,
s.order_date,
s.sales,
s.quantity
FROM golden.fact_sales s
LEFT JOIN golden.dim_customers c
ON s.customer_key=c.customer_key
WHERE order_date IS NOT NULL)
, customer_aggregate AS (SELECT 
    customer_key,
    customer_number,
    customer_name,
    age,
    COUNT(DISTINCT order_number) AS total_orders,
    SUM(sales) AS total_sales,
    SUM(quantity) AS total_quantity,
    COUNT(DISTINCT product_key) AS total_products,
    MAX(order_date) AS last_order_date,
    DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan
FROM base
GROUP BY 
    customer_key,
    customer_number,
    customer_name,
    age)
SELECT 
customer_key,
customer_number,
customer_name,
age,
CASE WHEN age < 20 THEN 'Under 20'
    WHEN age BETWEEN 20 AND 29 THEN '20-29'
    WHEN age BETWEEN 30 AND 39 THEN '30-39'
    WHEN age BETWEEN 40 AND 49 THEN '40-49'
    ELSE 'Above 50'
END AS age_group,
total_orders,
total_sales,
total_quantity,
total_products,
last_order_date,
DATEDIFF(month,last_order_date, GETDATE()) AS recency,
lifespan,
total_sales/total_orders AS avg_order_value,
CASE WHEN lifespan > 12 AND total_sales >5000 THEN 'VIP'
    WHEN lifespan > 12 AND total_sales <= 5000 THEN 'Regular'
    ELSE 'New'
END AS customer_segment,
CASE WHEN lifespan = 0 THEN total_sales
    ELSE total_sales/lifespan
END AS avg_monthly_spending
FROM customer_aggregate