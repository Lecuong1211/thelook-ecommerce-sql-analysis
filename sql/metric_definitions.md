# Metric Definitions
## Delivered Revenue- Source: order_items- Grain input: 1 row = 1 order item- Valid item: delivered_at IS NOT NULL AND returned_at IS NULL- Formula: SUM(sale_price)- Time dimension in main trend: DATE(delivered_at)
## AOV- Numerator: Delivered Revenue- Denominator: COUNT(DISTINCT order_id) among valid items- Formula: revenue / valid_orders
## Cancellation Rate- Source: orders- Numerator: COUNT(DISTINCT order_id) where status = 'Cancelled'- Denominator: COUNT(DISTINCT order_id)
## Return Rate- Define denominator before use and keep it consistent.