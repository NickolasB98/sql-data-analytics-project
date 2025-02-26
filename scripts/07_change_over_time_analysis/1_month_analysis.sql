-- =================================================================
-- Monthly Sales Performance Analysis
-- =================================================================
-- Description:
--   This query performs a monthly sales analysis by
--   calculating key performance metrics from the fact_sales table.
--
-- Metrics Calculated:
--   - Monthly total sales amount
--   - Monthly unique customer count
--   - Monthly total quantity sold
--
-- Table Dependencies:
--   - gold.fact_sales
--
-- Notes:
--   - Excludes records with null order dates for data quality
--   - Results are grouped by month and sorted chronologically
--   - All monetary values are in base currency
-- =================================================================

SELECT
    EXTRACT(MONTH FROM order_date) AS order_month,
    SUM(sales_amount) AS sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY order_month
ORDER BY order_month ASC;