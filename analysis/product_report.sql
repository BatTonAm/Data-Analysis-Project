/*
Product Report:
1. product name, category, subcategory, cost
2. segmentation: High Performer, Mid Range, Low Performer
3. Aggregation: total_sales, total_orders, total_customers, lifespan (months)
4. KPIS: recency in months, Avg monthly revenue, Avg order revenue
*/
CREATE OR ALTER VIEW golden.products_report AS
WITH base AS 
(SELECT 
s.order_number,
s.order_date,
s.customer_key,
s.sales,
s.price,
s.quantity,
p.product_key,
p.product_name,
p.category,
p.subcategory,
p.cost
FROM golden.fact_sales s
LEFT JOIN golden.dim_products p
ON s.product_key=p.product_key
WHERE order_date IS NOT NULL)
, product_aggregate AS
(SELECT 
	product_key,
	product_name,
	category,
	subcategory,
	cost,
	DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan,
	MAX(order_date) AS last_sale_date,
	COUNT(DISTINCT order_number) AS total_orders,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(sales) AS total_sales,
	SUM(quantity) AS total_quantity,
	ROUND(AVG(CAST (sales AS FLOAT)/NULLIF(quantity,0)),1) AS avg_selling_price
FROM base
GROUP BY
	product_key,
	product_name,
	category,
	subcategory,
	cost)

SELECT 
	product_key,
	product_name,
	category,
	subcategory,
	cost,
	lifespan,
	last_sale_date,
	DATEDIFF(MONTH, last_sale_date, GETDATE()) AS recency_in_months,
	CASE WHEN total_sales >50000 THEN 'High Perfomer'
		WHEN total_sales >=10000 THEN 'Mid Range'
		ELSE 'Low Performer'
	END AS product_segment,
	total_orders,
	total_customers,
	total_sales,
	total_quantity,
	avg_selling_price,
	CASE WHEN total_orders =0 THEN 0
		ELSE total_sales/total_orders
	END AS avg_order_revenue,
	CASE WHEN lifespan=0 THEN total_sales
		ELSE total_sales/lifespan
	END AS avg_monthly_revenue
FROM product_aggregate