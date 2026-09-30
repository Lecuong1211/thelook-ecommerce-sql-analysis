# TheLook E-commerce SQL Analysis

## 1. Project Overview
Project này sử dụng theLook eCommerce public dataset trên BigQuery để đánh giá hiệu quả hoạt động qua revenue, product mix, customer value và order fulfillment. Mục tiêu chính là chứng minh quy trình phân tích SQL có thể tái lập end-to-end: hiểu grain -> kiểm tra chất lượng -> định nghĩa KPI -> phân tích -> validation -> business insight.

## 2. Business Problem
Phân tích dữ liệu e-commerce để trả lời các câu hỏi cốt lõi về xu hướng tăng trưởng, mặt hàng chủ lực, hành vi khách hàng và tìm ra các điểm nghẽn (bottleneck) trong quy trình vận hành/giao hàng.

## 3. Dataset & Data Model
- **Nguồn:** `bigquery-public-data.thelook_ecommerce`
- Các bảng cốt lõi gồm `users`, `orders`, `order_items` và `products`.
- Vì dataset không có bảng payment transaction riêng, project không tạo payment conversion giả định; thay vào đó sử dụng fulfillment funnel.

## 4. Metric Definitions & Technical Approach
- Phân tích revenue ở item grain và dùng metric definition thống nhất cho delivered/non-returned items.
- Time basis cho doanh thu chính được tính theo `delivered_at`.
- Kiểm soát join fan-out bằng uniqueness checks và reconciliation trước/sau JOIN.
- Dùng CTE và Window Function (LAG/RANK/APPROX_QUANTILES) để tính MoM growth, ranking và phân phối.
- Phân biệt order-level fulfillment metrics với item-level revenue metrics.

## 5. Key Findings
- **Revenue:** Tăng trưởng được thúc đẩy bởi AOV (giá trị đơn hàng) thay vì Volume (số lượng đơn).
- **Product:** Danh mục "Outerwear & Coats" mang lại doanh thu cao nhất (12.06%) với mô hình price-led (ASP = $144.20). Top revenue product không trùng khớp với top units product.
- **Customer:** Tỷ lệ lặp lại đạt 12.09%. Phân phối doanh thu lệch phải (Mean $98 > Median $64), cho thấy sự đóng góp lớn từ tệp high-value customers.
- **Funnel:** Nút thắt lớn nằm ở khâu Giao hàng (chỉ 54% thành công). Tỷ lệ hoàn trả (Return rate) lên tới 28.79%, cần can thiệp vận hành gấp.
*(Chi tiết xem tại thư mục `results/key_findings.md`)*

## 6. Limitations
- Tách biệt observation, interpretation và recommendation để tránh suy diễn nhân quả (causality) từ dữ liệu quan sát.
- Dataset là synthetic, kết quả chứng minh năng lực tư duy xử lý SQL, không dùng để ra quyết định kinh doanh thực tế.

## 7. How to Reproduce
Mở BigQuery và chạy các file trong thư mục `sql/` theo thứ tự từ `00` đến `06`.