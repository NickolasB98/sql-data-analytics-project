-- =================================================================
-- Yearly Sales Performance Analysis
-- =================================================================
-- Description:
--   This query performs a yearly sales analysis by
--   calculating key performance metrics from the fact_sales table.
--
-- Metrics Calculated:
--   - Annual total sales amount
--   - Annual unique customer count
--   - Annual total quantity sold
--
-- Table Dependencies:
--   - gold.fact_sales
--
-- Notes:
--   - Excludes records with null order dates for data quality
--   - Results are grouped by year and sorted chronologically
--   - All monetary values are in base currency
-- =================================================================

SELECT
    EXTRACT(YEAR FROM order_date) AS order_year,
    SUM(sales_amount) AS sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY order_year
ORDER BY order_year ASC;