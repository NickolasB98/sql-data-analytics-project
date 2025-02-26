-- =============================================
-- Monthly Product Sales Performance Analysis
-- =============================================
-- Description: This query analyzes product performance by:
--   1. Calculating monthly sales by product
--   2. Comparing against product's average monthly performance
--   3. Comparing against previous month's performance
-- 
-- Tables Required:
--   - gold.fact_sales (order_date, sales_amount, product_key)
--   - gold.dim_products (product_key, product_name)
-- =============================================

WITH cte_monthly_product_sales AS (
    -- First CTE: Calculate total sales for each product per month
    SELECT 
        DATE_TRUNC('month', f.order_date) AS order_month,
        to_char(f.order_date, 'YYYY-MM') AS formatted_month,
        p.product_name,
        SUM(f.sales_amount) AS current_sales
    FROM gold.fact_sales f 
    LEFT JOIN gold.dim_products p 
        ON f.product_key = p.product_key
    WHERE order_date IS NOT NULL  -- Ensure data quality
    GROUP BY 
        DATE_TRUNC('month', f.order_date),
        to_char(f.order_date, 'YYYY-MM'),
        p.product_name
    ORDER BY order_month, p.product_name       
),
cte_avg_and_pm_sales AS (
    -- Second CTE: Calculate average sales and previous month sales
    SELECT 
        order_month,
        formatted_month,
        product_name,
        current_sales,
        -- Calculate average monthly sales for each product
        ROUND(AVG(current_sales) OVER (
            PARTITION BY product_name
        )) AS avg_sales,
        -- Get previous month's sales for each product
        LAG(current_sales) OVER (
            PARTITION BY product_name 
            ORDER BY order_month
        ) AS pm_sales
    FROM cte_monthly_product_sales
    ORDER BY product_name, order_month
)
-- Final query: Calculate differences and present results
SELECT 
    formatted_month,
    product_name,
    current_sales,
    avg_sales,
    current_sales - avg_sales AS diff_avg,  -- Difference from average
    CASE 
        WHEN current_sales - avg_sales > 0 THEN 'Above Avg'
        WHEN current_sales - avg_sales < 0 THEN 'Below Avg'
        ELSE 'As Avg'
    END AS avg_change,
    current_sales - pm_sales AS diff_pm,    -- Month-over-month difference
    CASE
        WHEN current_sales - pm_sales > 0 THEN 'Increase'
        WHEN current_sales - pm_sales < 0 THEN 'Decrease'
        ELSE 'No Change'
    END AS mom_change
FROM cte_avg_and_pm_sales
ORDER BY product_name, order_month;

