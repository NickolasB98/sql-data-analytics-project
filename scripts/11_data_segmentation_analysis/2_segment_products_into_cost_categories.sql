/* Segment products into cost ranges and
count how many products fall into each segment*/
WITH cte_product_segments AS (
SELECT 
    product_key,
    product_name,
    cost,
    CASE
        WHEN cost < 100 THEN 'Below 100'
        WHEN cost BETWEEN 100 AND 500 THEN '100-500'
        WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
        ELSE 'Above 1000'
        END AS cost_range
    FROM dim_products
)
SELECT
    cost_range,
    COUNT(product_key) AS product_count
 FROM cte_product_segments
 GROUP BY cost_range
 ORDER BY product_count DESC;