-- =================================================================
-- Category Sales Contribution Analysis
-- =================================================================
-- Description:
--   This query analyzes the contribution of each product category
--   to overall sales, helping identify key revenue-driving categories
--   and their relative importance to the business.
--
-- Metrics Calculated:
--   - Total sales by category
--   - Overall sales across all categories
--   - Percentage contribution of each category
--
-- Table Dependencies:
--   - gold.fact_sales
--   - gold.dim_products
--
-- Technical Details:
--   - Uses CTEs for staged calculations
--   - Implements window functions for overall totals
--   - Formats percentage with CONCAT and ROUND functions
--   - Includes LEFT JOIN to handle products without sales
--
-- Output Columns:
--   - category: Product category name
--   - total_sales: Total sales amount for the category
--   - sales_contribution: Percentage of overall sales (formatted)
-- =================================================================

WITH cte_category_sales AS (
    SELECT
        p.category,
        SUM(s.sales_amount) AS total_sales
    FROM gold.fact_sales s 
    LEFT JOIN gold.dim_products p 
        ON s.product_key = p.product_key
    GROUP BY p.category
    ORDER BY total_sales DESC
),
cte_total_sales AS (
    SELECT 
        category,
        total_sales,
        SUM(total_sales) OVER () AS overall_sales
    FROM cte_category_sales
)
SELECT
    category,
    total_sales,
    CONCAT(ROUND(total_sales / overall_sales * 100, 2), '%') AS sales_contribution
FROM cte_total_sales
ORDER BY sales_contribution DESC;