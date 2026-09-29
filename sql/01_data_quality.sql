-- orders.order_id có unique không?
SELECT
  COUNT(*) AS num_rows,
  COUNT(DISTINCT order_id) AS unique_order_id,
  COUNT(*) - COUNT(DISTINCT order_id) AS duplicate_gap
FROM `bigquery-public-data.thelook_ecommerce.orders`;

-- products.id có unique không?
SELECT
  COUNT(*) AS num_rows,
  COUNT(DISTINCT id) AS unique_product_id,
  COUNT(*) - COUNT(DISTINCT id) AS duplicate_gap
FROM `bigquery-public-data.thelook_ecommerce.products`;
SELECT
  COUNTIF(order_id IS NULL) AS null_order_id,
  COUNTIF(user_id IS NULL) AS null_user_id,
  COUNTIF(created_at IS NULL) AS null_created_at,
  COUNTIF(shipped_at IS NULL) AS null_shipped_at,
  COUNTIF(delivered_at IS NULL) AS null_delivered_at,
  COUNTIF(returned_at IS NULL) AS null_returned_at
FROM `bigquery-public-data.thelook_ecommerce.orders`;
-- order_items.product_id không tìm thấy product
SELECT COUNT(*) AS unmatched_product_rows
FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
LEFT JOIN `bigquery-public-data.thelook_ecommerce.products` p
  ON oi.product_id = p.id
WHERE p.id IS NULL;

-- orders.user_id không tìm thấy user
SELECT COUNT(*) AS unmatched_user_rows
FROM `bigquery-public-data.thelook_ecommerce.orders` o
LEFT JOIN `bigquery-public-data.thelook_ecommerce.users` u
  ON o.user_id = u.id
WHERE u.id IS NULL;
SELECT
  COUNTIF(delivered_at IS NOT NULL AND shipped_at IS NULL) AS delivered_without_ship,
  COUNTIF(returned_at IS NOT NULL AND delivered_at IS NULL) AS returned_without_delivery,
  COUNTIF(shipped_at < created_at) AS shipped_before_created,
  COUNTIF(delivered_at < shipped_at) AS delivered_before_shipped,
  COUNTIF(returned_at < delivered_at) AS returned_before_delivered
FROM `bigquery-public-data.thelook_ecommerce.orders`;
-- Row count order_items trước JOIN
SELECT COUNT(*) AS rows_before
FROM `bigquery-public-data.thelook_ecommerce.order_items`;

-- Row count sau LEFT JOIN products
SELECT COUNT(*) AS rows_after
FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
LEFT JOIN `bigquery-public-data.thelook_ecommerce.products` p
  ON oi.product_id = p.id;
-- Kiểm tra khoảng giá trị của sale_price
SELECT
  MIN(sale_price) AS min_price,
  MAX(sale_price) AS max_price,
  COUNTIF(sale_price <= 0) AS invalid_price_count
FROM `bigquery-public-data.thelook_ecommerce.order_items`;
/*
KẾT LUẬN DATA QUALITY:
- Khóa chính (order_id, id) đều unique, duplicate_gap = 0.
- Lỗi logic thời gian (Lifecycle anomalies) có tồn tại nhưng tỷ lệ nhỏ (ghi nhận cụ thể số lượng bạn thấy).
- Không xảy ra fan-out khi JOIN bảng order_items và products.
- Giá sale_price hợp lệ, không có giá trị âm.
-> Dữ liệu đủ điều kiện để tiếp tục phân tích Revenue.
*/