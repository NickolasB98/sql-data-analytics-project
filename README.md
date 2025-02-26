# SQL Data Analytics Portfolio Project

## Real-world project demonstrating trend analysis, performance tracking, segmentation, and automated reporting using SQL.

## 📌 Overview

A collection of SQL scripts for data exploration, analytics, and reporting. These scripts cover various analyses such as database exploration, measures and metrics, time-based trends, cumulative analytics, segmentation, etc. This repository contains SQL queries designed to help data analysts and BI professionals quickly explore, segment, and analyze data within a relational database. Each script focuses on a specific analytical theme and demonstrates best practices for SQL queries.

This project replicates industry-standard SQL analytics workflows, focusing on actionable insights for business stakeholders. 
It utilizes a PostgreSQL database named `SalesDB` to perform several types of analyses, including:

- **Customer Reporting:** Generating a detailed report on customer demographics, purchase behavior, and engagement.
- **Product Reporting:** Creating a comprehensive report on product performance, sales trends, and inventory management.
- **Part-to-Whole Analysis:** Understanding the contribution of different categories to overall sales.
- **Performance Analysis:** Comparing sales performance over time (month-over-month and year-over-year).
- **Exploratory Data Analysis (EDA):** Exploring the `customer_report` and `product_report` views to understand the data.

## Database Schema

The `SalesDB` database includes the following tables:

- **`dim_customers`:** Contains customer demographic information.
- **`dim_products`:** Contains product information.
- **`fact_sales`:** Contains sales transaction data.

The project also creates finalized gold views to organize data for reporting and analysis:

- **`report_customers`:** A view used for customer reporting.
- **`report_products`:** A view used for product reporting.

## 🚀 Project Structure
The repository is organized as follows:

Copy
sql-data-analytics-project/
├── SalesDB/
│   ├── Tables/
│   │   ├── dim_customers.sql
│   │   ├── dim_products.sql
│   │   └── fact_sales.sql
│   ├── Views/
│   │   ├── report_customers.sql
│   │   └── report_products.sql
│   └── Queries/
│       ├── final_reports/
│       │   ├── customer_report.sql
│       │   └── product_report.sql
│       ├── gold_views_analysis/
│       │   ├── explore_customer_report.sql
│       │   └── explore_product_report.sql
│       ├── part_to_whole_analysis/
│       │   └── categories_contribution.sql
│       └── performance_analysis/
│           ├── compare_mom_sales_performance.sql
│           └── compare_yoy_sales_performance.sql
├── README.md
