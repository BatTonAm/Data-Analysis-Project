### NOTE: 
for anyone who will use this project, please save the dataset as C:\data_analysis_project\datasets.

# 📊 Data Analysis Project

## 📌 Overview

This project implements a **modern data warehouse pipeline** using a layered architecture:

- **Bronze Layer** → Raw data ingestion  
- **Silver Layer** → Cleaned & standardized data  
- **Golden Layer** → Business-ready data (star schema)  

The system integrates data from **CRM and ERP sources** to support analytical and reporting use cases.
Then we implement analysis to evaluate performance and create reports regarding customer and product dimensions.

---

## 🏗️ Architecture

![Architecture](images/Project%20Data%20Architecture%20Final.png)

### Description

- Data is ingested from **CRM and ERP systems**
- Stored initially as **raw data (Bronze)**
- Transformed into **clean structured data (Silver)**
- Modeled into **business-ready star schema (Gold)**
- Consumed by BI tools and analytics

---

## 🔄 Data Pipeline (Bronze → Silver → Gold)

![Data Flow](images/Data%20Flow%20Diagram.png)

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

![Integration Model](images/Integration%20Diagram.png)

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

![Star Schema](images/STAR%20schema.png)

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

## 🛠️ Tech Stack

- SQL Server  
- ETL (SQL-based transformations)  
- Data Modeling (Star Schema)  
- GitHub & Git for Version control
- Draw.io for Drawing Diagram

---

## Analysis
The analysis is divided into three key areas:

### 🔹 Sales Performance Analysis
- Sales Performance Analysis
- Evaluate overall revenue trends over time
- Measure key metrics such as total sales, order volume, and quantity sold
- Identify seasonal patterns and business growth trends

### 🔹 Customer Insights
- Analyze customer demographics (e.g., age, lifecycle)
- Track customer purchasing behavior and lifespan
- Segment customers based on spending patterns and engagement

### 🔹 Product Performance
- Identify top-performing and underperforming products
- Compare product sales against average benchmarks
- Understand product demand and contribution to total revenue

---

## 👨‍💻 Author

**Van Dung PHAM**  
Business Analytics Student  

## Credit
Sources and Guidelines from Data with Baraa

