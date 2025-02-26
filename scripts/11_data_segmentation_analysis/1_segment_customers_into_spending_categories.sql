/* Group customers into three segments based on their spending behaviour:
   -  VIP: Customers with at least 12 months of history and spending
   more than 5000EUR.
   -  Regular: Customers with at least 12 months of history but spending
   50000EUR or less.
   -  New: Customers with less than 12 months of history.
And find the total number of customers by each group.
*/

WITH cte_customer_spending AS (
    SELECT 
        s.customer_key,
        SUM(s.sales_amount) AS total_spending,
        MIN(s.order_date) AS first_order,
        MAX(s.order_date) AS last_order
    FROM fact_sales s 
    LEFT JOIN dim_customers c
        ON s.customer_key = c.customer_key
    WHERE s.order_date IS NOT NULL
    GROUP BY s.customer_key
),
cte_months_diff AS (
    SELECT 
        customer_key,
        total_spending,
        first_order,
        last_order,
        -- extract the year and convert to months
        -- then add the remaining months
        (EXTRACT(YEAR FROM AGE(last_order, first_order)) * 12 + 
         EXTRACT(MONTH FROM AGE(last_order, first_order))) AS months_active
    FROM cte_customer_spending
)
SELECT
    CASE 
        WHEN total_spending > 5000 AND months_active >= 12 THEN 'VIP'
        WHEN total_spending <= 5000 AND months_active >= 12 THEN 'Regular'
        ELSE 'New'
    END AS spending_segment,
    COUNT(customer_key) AS total_customers
FROM cte_months_diff
GROUP BY spending_segment
ORDER BY total_customers DESC;