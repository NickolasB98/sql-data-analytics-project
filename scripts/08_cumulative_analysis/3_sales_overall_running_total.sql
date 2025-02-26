-- =================================================================
-- Yearly Sales Running Total Analysis
-- =================================================================
-- Description:
--   This query calculates yearly sales totals and their cumulative
--   sum across years, providing insights into sales growth and
--   overall business performance over time.
--
-- Metrics Calculated:
--   - Annual sales totals
--   - Running (cumulative) total of sales across all years
--
-- Table Dependencies:
--   - gold.fact_sales
--
-- Technical Details:
--   - Uses CTE for intermediate yearly aggregation
--   - Implements window functions for running total calculation
--   - Handles null dates for data quality
--
-- Output Columns:
--   - order_year: Year of the sales
--   - sales: Total sales for the specific year
--   - running_total: Cumulative sales up to and including that year
-- =================================================================

WITH cte_yearly_sales AS (
    SELECT
        EXTRACT(YEAR FROM order_date) AS order_year,
        SUM(sales_amount) AS sales
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY order_year
    ORDER BY order_year ASC
)
SELECT
    order_year,
    sales,
    SUM(sales) OVER (ORDER BY order_year) AS running_total
FROM cte_yearly_sales;