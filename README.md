# SQL Advanced Analytics Project

## 📌 Overview

A collection of SQL scripts for data exploration, analytics, and reporting. These scripts cover various analyses such as database exploration, measures and metrics, time-based trends, cumulative analytics, segmentation, etc. This repository contains SQL queries designed to help data analysts and BI professionals quickly explore, segment, and analyze data within a relational database. Each script focuses on a specific analytical theme and demonstrates best practices for SQL queries.

This project replicates industry-standard SQL analytics workflows, focusing on actionable insights for business stakeholders. 
It utilizes a PostgreSQL database named `SalesDB` to perform several types of analyses, including:

- **Customer Reporting:** Generating a detailed report on customer demographics, purchase behavior, and engagement.
- **Product Reporting:** Creating a comprehensive report on product performance, sales trends, and inventory management.
- **Part-to-Whole Analysis:** Understanding the contribution of different categories to overall sales.
- **Performance Analysis:** Comparing sales performance over time (month-over-month and year-over-year).
- **Exploratory Data Analysis (EDA):** Exploring the `customer_report` and `product_report` views to understand the data.

## 🗃️ Database Schema

The `SalesDB` database consists of the following tables:

- **`dim_customers`:** Stores customer demographic information (e.g., name, age, location).
- **`dim_products`:** Contains product details (e.g., product name, category, price).
- **`fact_sales`:** Records sales transaction data (e.g., transaction ID, customer ID, product ID, sales amount, date).

The project also creates finalized gold views to organize data for reporting and analysis:

- **`report_customers`:** A view used for customer reporting.
- **`report_products`:** A view used for product reporting.

### Finalized Gold Views:
To streamline reporting and analysis, the project creates two key views:
- **`report_customers`:** A consolidated view for customer-related reporting.
- **`report_products`:** A consolidated view for product-related reporting.

## 🛠️ Key Scripts Examples and Analyses

### 1. **Customer Reporting**
- **Script:** `customer_report.sql`
- **Purpose:** Generates a detailed report on customer demographics, purchase behavior, and engagement metrics.
<img width="1439" alt="image" src="https://github.com/user-attachments/assets/2fff8932-36d7-4f97-bdbe-df1d56fc9533" />


### 2. **Product Reporting**
- **Script:** `product_report.sql`
- **Purpose:** Provides insights into product performance, sales trends, and inventory management.
<img width="1392" alt="image" src="https://github.com/user-attachments/assets/a1e1d731-0041-405d-9b97-b19d42995cd2" />

### 3. **Part-to-Whole Analysis**
- **Script:** `categories_contribution.sql`
- **Purpose:** Analyzes the contribution of different product categories to overall sales.
<img width="1025" alt="image" src="https://github.com/user-attachments/assets/452a1658-c9d6-498b-bfd0-6a72e4f23a7f" />

### 4. **Performance Analysis**
- **Scripts:** 
  - `compare_mom_sales_performance.sql` (Month-over-Month analysis)
  - `compare_yoy_sales_performance.sql` (Year-over-Year analysis)
- **Purpose:** Tracks sales performance over time to identify trends and growth patterns.
<img width="1021" alt="image" src="https://github.com/user-attachments/assets/c6979b34-ddf3-4766-94b0-5de8c3f1d13f" />


### 5. **Exploratory Data Analysis (EDA)**
- **Scripts:**
  - `explore_customer_report.sql`
  - `explore_product_report.sql`
- **Purpose:** Investigates the `customer_report` and `product_report` views to uncover patterns, anomalies, and trends.
  
<img width="929" alt="image" src="https://github.com/user-attachments/assets/1823db48-ba11-4e82-b191-aae2c730e2be" />

<img width="977" alt="image" src="https://github.com/user-attachments/assets/ee464dc4-5e42-4321-915e-02726f7832db" />


---

## 🧑‍💻 How to Use This Repository

1. **Clone the Repository:**
   
   ```
     git clone https://github.com/your-username/sql-data-analytics-project.git
   ```
   
2. **Set Up the Database:**

Ensure PostgreSQL is installed and running.

Create the SalesDB database and load the schema using the scripts in the SalesDB/Tables/ directory.

3. **Run the Queries:**

Navigate to the **/scripts/** directory and execute the SQL scripts based on your analysis needs.

4. **Explore the Views:**

Use the report_customers and report_products views for streamlined reporting and analysis.

## 📊 Key Takeaways

This project demonstrates how SQL can be used to perform robust data analysis and generate actionable insights for business stakeholders. By leveraging structured queries, views, and best practices, you can efficiently explore data, track performance, and automate reporting workflows.

## 🙏 Acknowledgments

Special thanks to the open-source community and the countless resources that inspired this project. If you have any suggestions or feedback, please feel free to open an issue or submit a pull request!



