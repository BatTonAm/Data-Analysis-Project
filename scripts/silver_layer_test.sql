/*
TEST FOR DATA QUALITY AND CONSISTENCY FROM PROCESSED DATA IN SILVER LAYER
*/

--CRM CUST INFO
-- CHECK DUPLICATES 
SELECT 
cst_id,
COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING count(*) >1 OR cst_id IS NULL;

-- CHECK UNWANTED SPACES
SELECT 
cst_key
FROM silver.crm_cust_info
WHERE cst_key != TRIM(cst_key);

SELECT 
cst_firstname
FROM silver.crm_cust_info
WHERE cst_key != TRIM(cst_firstname);

SELECT 
cst_lastname
FROM silver.crm_cust_info
WHERE cst_key != TRIM(cst_lastname);

-- DATA STANDARDIZATION AND CONSISTENCY
SELECT DISTINCT cst_marital_status
FROM silver.crm_cust_info;

SELECT * FROM silver.crm_cust_info;

--CRM PRD INFO
-- CHECK DUPLICATES 
SELECT 
prd_id,
COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING count(*) >1 OR prd_id IS NULL;

-- CHECK UNWANTED SPACES
SELECT 
prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

--CHECK NULL OR NEGATIVE NUMBERS
SELECT 
prd_cost
FROM silver.crm_prd_info
WHERE prd_cost <0 or prd_cost IS NULL;

-- DATA STANDARDIZATION AND CONSISTENCY
SELECT DISTINCT prd_line
FROM silver.crm_prd_info;

-- CHECK INVALID DATE ORDERS
SELECT *
FROM silver.crm_prd_info
WHERE prd_start_dt >prd_end_dt;

SELECT * FROM silver.crm_prd_info;


-- CRM SALES DETAILS
--CHECK INVALID DATE
SELECT NULLIF(sls_order_dt,0) sls_order_dt
FROM bronze.crm_sales_details
WHERE sls_order_dt <0
OR LEN(sls_order_dt) !=8
OR sls_order_dt > 20500101
OR sls_order_dt<19900101;

SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_due_dt
OR sls_order_dt > sls_ship_dt;

-- CHECK CONSISTENCY BETWEEN SALES, PRICE AND QUANTITY
--->> SALES =PRICE*QUANT
--->> VALUE SHOULD NOT BE NULL, zero, negative

SELECT
sls_sales,
sls_quantity,
sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0;

SELECT *
FROM silver.crm_sales_details;

--ERP CUST AZ12
-- DETECT INVALID CID
SELECT cid
FROM bronze.erp_cust_az12
WHERE cid LIKE '%AW0001%';
SELECT cst_key FROM silver.crm_cust_info;

-- INVALID BDATE
SELECT bdate
FROM silver.erp_cust_az12
WHERE bdate > GETDATE()
OR bdate < '1925-01-01';

-- DATA CONSISTENCY IN GENDER

SELECT DISTINCT gen
FROM silver.erp_cust_az12

SELECT * FROM silver.erp_cust_az12

-- ERP LOC A101
-- DETECT INVALID CID
SELECT 
cid
FROM silver.erp_loc_a101
WHERE cid NOT IN (SELECT cst_key FROM silver.crm_cust_info);

-- DATA CONSISTENCY

SELECT DISTINCT
cntry
FROM silver.erp_loc_a101
