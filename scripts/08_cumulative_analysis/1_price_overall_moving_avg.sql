-- =================================================================
-- Yearly Price Analysis with Moving Averages
-- =================================================================
-- Description:
--   This query analyzes yearly price trends by calculating average
--   prices per year and their cumulative moving averages. It provides
--   insights into price evolution over time and long-term trends.
--
-- Metrics Calculated:
--   - Yearly average prices (rounded to 2 decimals)
--   - Cumulative moving average of prices across years
--
-- Table Dependencies:
--   - gold.fact_sales
--
-- Technical Details:
--   - Uses window functions for moving average calculation
--   - Implements CTE for better code organization
--   - Handles null dates for data quality
--
-- Output Columns:
--   - order_year: Year of the order
--   - avg_price: Average price for the specific year
--   - moving_avg_price: Cumulative moving average up to that year
-- =================================================================

WITH cte_yearly_sales AS (
    SELECT
        EXTRACT(YEAR FROM order_date) AS order_year,
        ROUND(AVG(price), 2) AS avg_price
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY order_year
    ORDER BY order_year ASC
)
SELECT
    order_year,
    avg_price,
    ROUND(AVG(avg_price) OVER (
        ORDER BY order_year
    ), 2) AS moving_avg_price
FROM cte_yearly_sales
ORDER BY order_year;