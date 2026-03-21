# Data Dictionary for Gold Layer

---

## Overview

The Gold Layer is the business-level data representation, structured to support analytical and reporting use cases.  
It consists of **dimension tables** and **fact tables** for specific business metrics.

---

## 1. golden.dim_customers

**Purpose:**  
Stores customer details enriched with demographic and geographic data.

### Columns

| Column Name | Data Type | Description |
|---|---|---|
| customer_key | bigint | Surrogate key uniquely identifying each customer record |
| customer_id | int | Business/customer ID |
| customer_number | nvarchar(50) | Customer code |
| first_name | nvarchar(50) | Customer first name |
| last_name | nvarchar(50) | Customer last name |
| country | nvarchar(50) | Country of residence |
| marital_status | nvarchar(50) | Marital status |
| gender | nvarchar(50) | Gender |
| birthdate | date | Date of birth |
| create_date | date | Record creation date |

---

## 2. golden.dim_products

**Purpose:**  
Stores product information including category hierarchy, cost, and lifecycle dates.

### Columns

| Column Name | Data Type | Description |
|---|---|---|
| product_key | bigint | Surrogate key for product |
| product_id | int | Business product ID |
| product_number | nvarchar(50) | Product code |
| product_name | nvarchar(50) | Product name |
| category_id | nvarchar(50) | Category identifier |
| category | nvarchar(50) | Product category |
| subcategory | nvarchar(50) | Product subcategory |
| maintenance | nvarchar(50) | Maintenance flag |
| cost | int | Product cost |
| product_line | nvarchar(50) | Product line |
| start_date | date | Start date |
| end_date | date | End date |

---

## 3. golden.fact_sales

**Purpose:**  
Stores transactional sales data at the order line level.

### Columns

| Column Name | Data Type | Description |
|---|---|---|
| order_number | nvarchar(50) | Order identifier |
| product_key | bigint | FK to dim_products |
| customer_key | bigint | FK to dim_customers |
| order_date | date | Order date |
| ship_date | date | Shipment date |
| due_date | date | Due date |
| sales | int | Total sales |
| quantity | int | Quantity sold |
| price | int | Unit price |
