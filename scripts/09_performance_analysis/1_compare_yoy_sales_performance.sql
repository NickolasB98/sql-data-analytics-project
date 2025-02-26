/* Analyse the yearly performance of products by comparing their sales
to both the avg sales performance of the product and the 
previous year's sales */

-- =============================================
-- Yearly Product Sales Performance Analysis
-- =============================================
-- Description: This query analyzes product performance by:
--   1. Calculating yearly sales by product
--   2. Comparing against product's average performance
--   3. Comparing against previous year's performance
-- 
-- Tables Required:
--   - gold.fact_sales (order_date, sales_amount, product_key)
--   - gold.dim_products (product_key, product_name)
-- =============================================

WITH cte_yearly_product_sales AS (
    -- First CTE: Calculate total sales for each product per year
    SELECT 
        EXTRACT(YEAR FROM f.order_date) AS order_year,
        p.product_name,
        SUM(f.sales_amount) AS current_sales
    FROM gold.fact_sales f 
    LEFT JOIN gold.dim_products p 
        ON f.product_key = p.product_key
    WHERE order_date IS NOT NULL  -- Ensure data quality
    GROUP BY order_year, p.product_name
    ORDER BY order_year, p.product_name       
),
cte_avg_and_py_sales AS (
    -- Second CTE: Calculate average sales and previous year sales
    SELECT 
        order_year,
        product_name,
        current_sales,
        -- Calculate average sales across all years for each product
        ROUND(AVG(current_sales) OVER (
            PARTITION BY product_name
        )) AS avg_sales,
        -- Get previous year's sales for each product
        LAG(current_sales) OVER (
            PARTITION BY product_name 
            ORDER BY order_year
        ) AS py_sales
    FROM cte_yearly_product_sales
    ORDER BY product_name, order_year
)
-- Final query: Calculate differences and present results
SELECT 
    order_year,
    product_name,
    current_sales,
    avg_sales,
    current_sales - avg_sales AS diff_avg, -- Difference from average
    CASE 
        WHEN current_sales - avg_sales > 0 THEN 'Above Avg'
        WHEN current_sales - avg_sales < 0 THEN 'Below Avg'
        ELSE 'As Avg'
    END AS avg_change,
    current_sales - py_sales AS diff_py,  -- Year-over-year difference
    CASE
        WHEN current_sales - py_sales > 0 THEN 'Increase'
        WHEN current_sales - py_sales < 0 THEN 'Decrease'
        ELSE 'No Change'
    END AS py_change
FROM cte_avg_and_py_sales
ORDER BY product_name, order_year;

-- Example Usage:
-- To find top performing products vs average:
--   SELECT * FROM product_performance WHERE diff_avg > 0 ORDER BY diff_avg DESC;
-- To find products with best year-over-year growth:
--   SELECT * FROM product_performance WHERE diff_prev_year > 0 ORDER BY diff_prev_year DESC;