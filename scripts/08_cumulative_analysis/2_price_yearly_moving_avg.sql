-- =============================================
-- Monthly Price Analysis with Yearly Moving Averages
-- =============================================
-- Description:
--   This query analyzes price trends by calculating:
--   1. Monthly average prices
--   2. Moving averages that reset each year
--   Useful for identifying pricing patterns and seasonality
--
-- Tables Required:
--   gold.fact_sales (requires: order_date, price columns)
--
-- Output Columns:
--   - order_month: First day of each month
--   - year: The year extracted from order_date
--   - formatted_order_month: Month in YYYY-MM format
--   - avg_price: Average price for the month
--   - moving_avg_price_by_year: Moving average within each year
-- =============================================

WITH cte_monthly_price AS (
    -- Calculate monthly average prices
    SELECT
        DATE_TRUNC('month', order_date) AS order_month,        -- Truncate to first day of month
        EXTRACT(YEAR FROM order_date) AS year,                 -- Extract year for partitioning
        to_char(order_date, 'YYYY-MM') AS formatted_order_month, -- Format month for readability
        ROUND(AVG(price), 2) AS avg_price                      -- Calculate monthly average price
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL                               -- Ensure data quality
    GROUP BY 
        DATE_TRUNC('month', order_date),
        EXTRACT(YEAR FROM order_date),
        to_char(order_date, 'YYYY-MM')
    ORDER BY order_month ASC                                   -- Sort chronologically
)
SELECT
    order_month,
    year,
    formatted_order_month,
    avg_price,
    -- Calculate moving average that resets each year
    ROUND(AVG(avg_price) OVER (
        PARTITION BY year                                      -- Reset calculations per year
        ORDER BY order_month                                   -- Order by month within each year
    ), 2) AS moving_avg_price_by_year
FROM cte_monthly_price
ORDER BY order_month;
