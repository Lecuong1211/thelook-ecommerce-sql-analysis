/*
Project: theLook E-commerce SQL Analysis
File: [Điền tên file của bạn, ví dụ: 03_revenue_analysis.sql]
Business question: [Điền mục đích file, ví dụ: Phân tích xu hướng doanh thu theo tháng]
Input grain: [Ví dụ: 1 row = 1 order item]
Output grain: [Ví dụ: 1 row = 1 tháng]
*/
SELECT
  table_name,
  table_type
FROM `bigquery-public-data.thelook_ecommerce.INFORMATION_SCHEMA.TABLES`
ORDER BY table_name;
SELECT
  table_name,
  ordinal_position,
  column_name,
  data_type,
  is_nullable
FROM `bigquery-public-data.thelook_ecommerce.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name IN ('users','orders','order_items','products','events')
ORDER BY table_name, ordinal_position;
SELECT order_id, user_id, status, created_at, shipped_at, delivered_at, returned_at, num_of_item
FROM `bigquery-public-data.thelook_ecommerce.orders`
LIMIT 20;

SELECT id, order_id, user_id, product_id, status, created_at, shipped_at, delivered_at, returned_at, sale_price
FROM `bigquery-public-data.thelook_ecommerce.order_items`
LIMIT 20;

SELECT id, category, name, brand, cost, retail_price, department
FROM `bigquery-public-data.thelook_ecommerce.products`
LIMIT 20;
SELECT
  status,
  COUNT(*) AS num_rows,
  COUNT(DISTINCT order_id) AS orders
FROM `bigquery-public-data.thelook_ecommerce.orders`
GROUP BY status
ORDER BY orders DESC;
SELECT
  MIN(created_at) AS first_order_created_at,
  MAX(created_at) AS latest_order_created_at,
  MIN(delivered_at) AS first_delivery_at,
  MAX(delivered_at) AS latest_delivery_at
FROM `bigquery-public-data.thelook_ecommerce.orders`;
SELECT
  (SELECT COUNT(*) FROM `bigquery-public-data.thelook_ecommerce.users`) AS users_rows,
  (SELECT COUNT(*) FROM `bigquery-public-data.thelook_ecommerce.orders`) AS orders_rows,
  (SELECT COUNT(*) FROM `bigquery-public-data.thelook_ecommerce.order_items`) AS order_items_rows,
  (SELECT COUNT(*) FROM `bigquery-public-data.thelook_ecommerce.products`) AS products_rows,
  (SELECT COUNT(*) FROM `bigquery-public-data.thelook_ecommerce.events`) AS events_rows;
