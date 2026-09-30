/*
Project: theLook E-commerce SQL Analysis
File: [Điền tên file của bạn, ví dụ: 03_revenue_analysis.sql]
Business question: [Điền mục đích file, ví dụ: Phân tích xu hướng doanh thu theo tháng]
Input grain: [Ví dụ: 1 row = 1 order item]
Output grain: [Ví dụ: 1 row = 1 tháng]
*/
WITH funnel AS (
  SELECT
    COUNT(DISTINCT order_id) AS placed_orders,
    COUNT(DISTINCT CASE WHEN shipped_at IS NOT NULL THEN order_id END) AS shipped_orders,
    COUNT(DISTINCT CASE WHEN delivered_at IS NOT NULL THEN order_id END) AS delivered_orders,
    COUNT(DISTINCT CASE WHEN status = 'Cancelled' THEN order_id END) AS cancelled_orders,
    COUNT(DISTINCT CASE WHEN returned_at IS NOT NULL THEN order_id END) AS returned_orders
  FROM `bigquery-public-data.thelook_ecommerce.orders`
)
SELECT
  *,
  SAFE_DIVIDE(shipped_orders, placed_orders) * 100 AS placed_to_shipped_pct,
  SAFE_DIVIDE(delivered_orders, shipped_orders) * 100 AS shipped_to_delivered_pct,
  SAFE_DIVIDE(cancelled_orders, placed_orders) * 100 AS cancellation_rate_pct,
  SAFE_DIVIDE(returned_orders, delivered_orders) * 100 AS return_per_delivered_pct
FROM funnel;
SELECT
  DATE_TRUNC(DATE(created_at), MONTH) AS cohort_month,
  COUNT(DISTINCT order_id) AS placed_orders,
  COUNT(DISTINCT CASE WHEN shipped_at IS NOT NULL THEN order_id END) AS shipped_orders,
  COUNT(DISTINCT CASE WHEN delivered_at IS NOT NULL THEN order_id END) AS delivered_orders,
  COUNT(DISTINCT CASE WHEN status = 'Cancelled' THEN order_id END) AS cancelled_orders
FROM `bigquery-public-data.thelook_ecommerce.orders`
GROUP BY cohort_month
ORDER BY cohort_month;
SELECT
  event_type,
  COUNT(*) AS events,
  COUNT(DISTINCT session_id) AS sessions,
  COUNT(DISTINCT user_id) AS users
FROM `bigquery-public-data.thelook_ecommerce.events`
GROUP BY event_type
ORDER BY events DESC;