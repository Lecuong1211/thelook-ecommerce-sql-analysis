/*
Project: theLook E-commerce SQL Analysis
File: [Điền tên file của bạn, ví dụ: 03_revenue_analysis.sql]
Business question: [Điền mục đích file, ví dụ: Phân tích xu hướng doanh thu theo tháng]
Input grain: [Ví dụ: 1 row = 1 order item]
Output grain: [Ví dụ: 1 row = 1 tháng]
*/
WITH customer_metrics AS (
  SELECT
    user_id,
    COUNT(DISTINCT order_id) AS orders,
    COUNT(*) AS units,
    SUM(sale_price) AS revenue,
    MIN(DATE(delivered_at)) AS first_valid_delivery_date,
    MAX(DATE(delivered_at)) AS last_valid_delivery_date
  FROM `bigquery-public-data.thelook_ecommerce.order_items`
  WHERE delivered_at IS NOT NULL
    AND returned_at IS NULL
  GROUP BY user_id
)
SELECT
  user_id,
  orders,
  units,
  revenue,
  SAFE_DIVIDE(revenue, orders) AS aov,
  first_valid_delivery_date,
  last_valid_delivery_date,
  RANK() OVER (ORDER BY revenue DESC) AS revenue_rank
FROM customer_metrics
ORDER BY revenue_rank
LIMIT 50;
WITH per_customer AS (
  SELECT
    user_id,
    COUNT(DISTINCT order_id) AS orders
  FROM `bigquery-public-data.thelook_ecommerce.order_items`
  WHERE delivered_at IS NOT NULL
    AND returned_at IS NULL
  GROUP BY user_id
)
SELECT
  COUNT(*) AS customers,
  COUNTIF(orders >= 2) AS repeat_customers,
  SAFE_DIVIDE(COUNTIF(orders >= 2), COUNT(*)) * 100 AS repeat_customer_rate_pct
FROM per_customer;

WITH per_customer AS (
  SELECT
    user_id,
    COUNT(DISTINCT order_id) AS orders,
    SUM(sale_price) AS revenue
  FROM `bigquery-public-data.thelook_ecommerce.order_items`
  WHERE delivered_at IS NOT NULL
    AND returned_at IS NULL
  GROUP BY user_id
)
SELECT
  APPROX_QUANTILES(revenue, 100)[OFFSET(50)] AS median_customer_revenue,
  APPROX_QUANTILES(revenue, 100)[OFFSET(75)] AS p75_customer_revenue,
  APPROX_QUANTILES(revenue, 100)[OFFSET(90)] AS p90_customer_revenue,
  APPROX_QUANTILES(revenue, 100)[OFFSET(95)] AS p95_customer_revenue,
  AVG(revenue) AS avg_customer_revenue
FROM per_customer;

WITH customer_value AS (
  SELECT user_id, SUM(sale_price) AS revenue, COUNT(DISTINCT order_id) AS orders
  FROM `bigquery-public-data.thelook_ecommerce.order_items`
  WHERE delivered_at IS NOT NULL AND returned_at IS NULL
  GROUP BY user_id
)
SELECT
  u.traffic_source,
  COUNT(*) AS customers,
  SUM(cv.revenue) AS revenue,
  AVG(cv.revenue) AS avg_revenue_per_customer,
  AVG(cv.orders) AS avg_orders_per_customer
FROM customer_value cv
JOIN `bigquery-public-data.thelook_ecommerce.users` u
  ON cv.user_id = u.id
GROUP BY u.traffic_source
ORDER BY revenue DESC;