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