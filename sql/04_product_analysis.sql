/*
Project: theLook E-commerce SQL Analysis
File: [Điền tên file của bạn, ví dụ: 03_revenue_analysis.sql]
Business question: [Điền mục đích file, ví dụ: Phân tích xu hướng doanh thu theo tháng]
Input grain: [Ví dụ: 1 row = 1 order item]
Output grain: [Ví dụ: 1 row = 1 tháng]
*/
WITH category_perf AS (
  SELECT
    p.category,
    COUNT(oi.id) AS units_sold,
    COUNT(DISTINCT oi.order_id) AS orders,
    SUM(oi.sale_price) AS revenue,
    AVG(oi.sale_price) AS avg_selling_price
  FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
  JOIN `bigquery-public-data.thelook_ecommerce.products` p
    ON oi.product_id = p.id
  WHERE oi.delivered_at IS NOT NULL
    AND oi.returned_at IS NULL
  GROUP BY p.category
)
SELECT
  category,
  units_sold,
  orders,
  revenue,
  avg_selling_price,
  SAFE_DIVIDE(revenue, SUM(revenue) OVER()) * 100 AS revenue_share_pct,
  RANK() OVER (ORDER BY revenue DESC) AS revenue_rank,
  RANK() OVER (ORDER BY units_sold DESC) AS unit_rank
FROM category_perf
ORDER BY revenue_rank;
WITH product_perf AS (
  SELECT
    p.id AS product_id,
    p.name AS product_name,
    p.category,
    p.brand,
    COUNT(oi.id) AS units_sold,
    COUNT(DISTINCT oi.order_id) AS orders,
    SUM(oi.sale_price) AS revenue,
    AVG(oi.sale_price) AS avg_selling_price
  FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
  JOIN `bigquery-public-data.thelook_ecommerce.products` p
    ON oi.product_id = p.id
  WHERE oi.delivered_at IS NOT NULL
    AND oi.returned_at IS NULL
  GROUP BY p.id, p.name, p.category, p.brand
)
SELECT *
FROM product_perf
ORDER BY revenue DESC
LIMIT 20;
SELECT
  p.category,
  SUM(oi.sale_price) AS revenue,
  SUM(oi.sale_price - p.cost) AS gross_profit_proxy,
  SAFE_DIVIDE(SUM(oi.sale_price - p.cost), SUM(oi.sale_price)) * 100 AS gross_margin_proxy_pct
FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
JOIN `bigquery-public-data.thelook_ecommerce.products` p
  ON oi.product_id = p.id
WHERE oi.delivered_at IS NOT NULL
  AND oi.returned_at IS NULL
GROUP BY p.category
ORDER BY gross_profit_proxy DESC;