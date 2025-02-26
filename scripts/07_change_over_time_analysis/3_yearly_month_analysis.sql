-- =================================================================
-- Monthly Sales Analysis with Formatted Dates
-- =================================================================
-- Description:
--   This query analyzes monthly sales data with properly formatted
--   date representations for reporting purposes.
--
-- Metrics Calculated:
--   - Monthly total sales amount
--   - Two date formats: truncated date and YYYY-MM string format
--
-- Table Dependencies:
--   - gold.fact_sales
--
-- Notes:
--   - Excludes records with null order dates
--   - Uses DATE_TRUNC for proper month-level aggregation
--   - Includes formatted month string for better readability
--   - Results are sorted chronologically by month
-- =================================================================

SELECT
    DATE_TRUNC('month', order_date) AS order_month,
    to_char(order_date, 'YYYY-MM') AS formatted_order_month,
    SUM(sales_amount) AS sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY order_month, formatted_order_month
ORDER BY order_month ASC;