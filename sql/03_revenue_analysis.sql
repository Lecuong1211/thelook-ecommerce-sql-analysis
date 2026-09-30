/*
Project: theLook E-commerce SQL Analysis
File: [Điền tên file của bạn, ví dụ: 03_revenue_analysis.sql]
Business question: [Điền mục đích file, ví dụ: Phân tích xu hướng doanh thu theo tháng]
Input grain: [Ví dụ: 1 row = 1 order item]
Output grain: [Ví dụ: 1 row = 1 tháng]
*/
WITH monthly_revenue AS (
  SELECT
    DATE_TRUNC(DATE(delivered_at), MONTH) AS month,
    SUM(sale_price) AS revenue,
    COUNT(DISTINCT order_id) AS orders,
    COUNT(*) AS units,
    COUNT(DISTINCT user_id) AS customers
  FROM `bigquery-public-data.thelook_ecommerce.order_items`
  WHERE delivered_at IS NOT NULL
    AND returned_at IS NULL
  GROUP BY month
),
with_prev AS (
  SELECT
    *,
    LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
    LAG(orders) OVER (ORDER BY month) AS prev_orders,
    LAG(units) OVER (ORDER BY month) AS prev_units
  FROM monthly_revenue
)
SELECT
  month,
  revenue,
  orders,
  units,
  customers,
  SAFE_DIVIDE(revenue, orders) AS aov,
  SAFE_DIVIDE(revenue - prev_revenue, prev_revenue) * 100 AS mom_revenue_pct,
  SAFE_DIVIDE(orders - prev_orders, prev_orders) * 100 AS mom_orders_pct,
  SAFE_DIVIDE(units - prev_units, prev_units) * 100 AS mom_units_pct
FROM with_prev
ORDER BY month;

-- Revenue ca valid items nhưng g n vào tháng tạo item/order
SELECT
  DATE_TRUNC(DATE(created_at), MONTH) AS created_month,
  SUM(sale_price) AS revenue_of_eventually_valid_items
FROM `bigquery-public-data.thelook_ecommerce.order_items`
WHERE delivered_at IS NOT NULL
  AND returned_at IS NULL
GROUP BY created_month
ORDER BY created_month;
