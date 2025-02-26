-- =================================================================
-- Monthly Sales with Yearly Running Totals Analysis
-- =================================================================
-- Description:
--   This query analyzes monthly sales patterns and calculates running
--   totals that reset at the beginning of each year. It provides 
--   insights into both monthly performance and cumulative progress
--   within annual periods.
--
-- Metrics Calculated:
--   - Monthly sales totals
--   - Running total of sales (resets each year)
--   - Multiple date format representations
--
-- Table Dependencies:
--   - gold.fact_sales
--
-- Technical Details:
--   - Uses CTE for monthly aggregation
--   - Implements window functions with yearly partitioning
--   - Includes multiple date formats for reporting flexibility
--   - Handles null dates for data quality
--
-- Output Columns:
--   - order_month: Truncated date at month level
--   - year: Extracted year for partitioning
--   - formatted_order_month: YYYY-MM string format
--   - sales: Total sales for the specific month
--   - running_total_by_year: Cumulative sales within each year
-- =================================================================

WITH cte_monthly_sales AS (
    SELECT
        DATE_TRUNC('month', order_date) AS order_month,
        EXTRACT(YEAR FROM order_date) AS year,
        to_char(order_date, 'YYYY-MM') AS formatted_order_month,
        SUM(sales_amount) AS sales
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY 
        DATE_TRUNC('month', order_date),
        EXTRACT(YEAR FROM order_date),
        to_char(order_date, 'YYYY-MM')
    ORDER BY order_month ASC
)
SELECT
    order_month,
    year,
    formatted_order_month,
    sales,
    SUM(sales) OVER (
        PARTITION BY year
        ORDER BY order_month
    ) AS running_total_by_year
FROM cte_monthly_sales
ORDER BY order_month;