/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'datawarehouseanalytics' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
	
WARNING:
    Running this script will drop the entire 'datawarehouseanalytics' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

-- Terminate active connections and drop the database if it exists
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'datawarehouseanalytics';

DROP DATABASE IF EXISTS datawarehouseanalytics;

-- Create the 'datawarehouseanalytics' database
CREATE DATABASE datawarehouseanalytics;

-- Connect to the new database

-- Create Schemas
CREATE SCHEMA gold;

-- Create Tables
CREATE TABLE gold.dim_customers(
	customer_key int,
	customer_id int,
	customer_number varchar(50),
	first_name varchar(50),
	last_name varchar(50),
	country varchar(50),
	marital_status varchar(50),
	gender varchar(50),
	birthdate date,
	create_date date
);

CREATE TABLE gold.dim_products(
	product_key int,
	product_id int,
	product_number varchar(50),
	product_name varchar(50),
	category_id varchar(50),
	category varchar(50),
	subcategory varchar(50),
	maintenance varchar(50),
	cost int,
	product_line varchar(50),
	start_date date
);

CREATE TABLE gold.fact_sales(
	order_number varchar(50),
	product_key int,
	customer_key int,
	order_date date,
	shipping_date date,
	due_date date,
	sales_amount int,
	quantity smallint,
	price int
);

-- Truncate Tables
TRUNCATE TABLE gold.dim_customers RESTART IDENTITY CASCADE;
TRUNCATE TABLE gold.dim_products RESTART IDENTITY CASCADE;
TRUNCATE TABLE gold.fact_sales RESTART IDENTITY CASCADE;

-- Bulk Insert using COPY
COPY gold.dim_customers FROM '/Users/user/Downloads/sql-data-analytics-project-main/datasets/csv-files/gold.dim_customers.csv' DELIMITER ',' CSV HEADER;
COPY gold.dim_products FROM '/Users/user/Downloads/sql-data-analytics-project-main/datasets/csv-files/gold.dim_products.csv' DELIMITER ',' CSV HEADER;
COPY gold.fact_sales FROM '/Users/user/Downloads/sql-data-analytics-project-main/datasets/csv-files/gold.fact_sales.csv' DELIMITER ',' CSV HEADER;