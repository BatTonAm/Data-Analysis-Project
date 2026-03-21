# 📊 Data Warehouse Project – Sales Analytics

## 📌 Overview

This project implements a **modern data warehouse pipeline** using a layered architecture:

- **Bronze Layer** → Raw data ingestion  
- **Silver Layer** → Cleaned & standardized data  
- **Gold Layer** → Business-ready data (star schema)  

The system integrates data from **CRM and ERP sources** to support analytical and reporting use cases.

---

## 🏗️ Architecture

![Architecture](Project%20Data%20Architecture.png)

### Description

- Data is ingested from **CRM and ERP systems**
- Stored initially as **raw data (Bronze)**
- Transformed into **clean structured data (Silver)**
- Modeled into **business-ready star schema (Gold)**
- Consumed by BI tools and analytics

---

## 🔄 Data Pipeline (Bronze → Silver → Gold)

![Data Flow](Data%20Flow%20Diagram.png)

### Flow Explanation

- **Bronze Layer**
  - Raw ingestion from source systems
  - No transformations applied

- **Silver Layer**
  - Data cleansing & standardization
  - Schema alignment across sources

- **Gold Layer**
  - Data integration
  - Business logic applied
  - Analytical models created

---

## 🔗 Integration Model

![Integration Model](Integration%20Diagram.png)

### Description

- Combines:
  - CRM transactional data
  - ERP master/reference data
- Builds unified entities:
  - **Customer**
  - **Product**
- Ensures consistency across systems

---

## ⭐ Data Mart (Star Schema)

![Star Schema](STAR%20schema.png)

### Description

- Central fact table: `fact_sales`
- Dimension tables:
  - `dim_customers`
  - `dim_products`
- Enables:
  - Fast querying
  - Aggregation
  - BI reporting

---

## 🚀 Key Features

- End-to-end **ETL pipeline**
- Multi-source integration (**CRM + ERP**)
- Layered architecture (**Bronze / Silver / Gold**)
- Star schema for analytics
- Ready for **Power BI / Tableau / ML use cases**

---

## 🛠️ Tech Stack

- SQL Server  
- ETL (SQL-based transformations)  
- Data Modeling (Star Schema)  
- GitHub  

---

## 📈 Use Cases

- Sales performance analysis  
- Customer segmentation  
- Product profitability  
- Time-based trend analysis  

---

## 👨‍💻 Author

**Van Dung PHAM**  
Business Analytics Student  
Data Engineering & Analytics Enthusiast

