/*
Project: theLook E-commerce SQL Analysis
File: [Điền tên file của bạn, ví dụ: 03_revenue_analysis.sql]
Business question: [Điền mục đích file, ví dụ: Phân tích xu hướng doanh thu theo tháng]
Input grain: [Ví dụ: 1 row = 1 order item]
Output grain: [Ví dụ: 1 row = 1 tháng]
*/
WITH valid_items AS (
  SELECT
    id,
    order_id,
    user_id,
    product_id,
    sale_price,
    delivered_at
  FROM `bigquery-public-data.thelook_ecommerce.order_items`
  WHERE delivered_at IS NOT NULL
    AND returned_at IS NULL
)
SELECT
  COUNT(*) AS valid_units,
  COUNT(DISTINCT order_id) AS valid_orders,
  COUNT(DISTINCT user_id) AS valid_customers,
  SUM(sale_price) AS delivered_revenue,
  SAFE_DIVIDE(SUM(sale_price), COUNT(DISTINCT order_id)) AS aov
FROM valid_items;