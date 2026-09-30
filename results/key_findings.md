# Key Findings

## 1. Revenue trend
- **Evidence (Số liệu thực tế):** Doanh thu tháng [Tháng đỉnh/Tháng gần nhất] đạt [Số tiền], với tổng số đơn là [Số đơn] và AOV là [Số AOV]. So với tháng trước, doanh thu thay đổi [x]% MoM.
- **Interpretation (Diễn giải):** Sự thay đổi doanh thu (tăng/giảm) trong tháng này chủ yếu được thúc đẩy bởi sự thay đổi về [lượng đơn hàng (volume) / giá trị trung bình mỗi đơn (AOV)]. 
- **Action (Bước tiếp theo):** Cần tiếp tục phân tích sâu vào các Category và Customer cohort ở tháng có biến động mạnh để xác định nguyên nhân cốt lõi.
- **Lưu ý:** Tháng [Tháng cuối cùng] là partial month (tháng chưa đầy đủ ngày) nên dữ liệu MoM của tháng này tạm thời bị loại bỏ để tránh gây sai lệch xu hướng.


## 2. Product/category performance
- **Evidence:** Danh mục **Outerwear & Coats** đóng góp cao nhất với **12.06%** tổng doanh thu, nhưng chỉ đứng hạng **11** về số lượng bán ra (2,260 units). Giá bán trung bình (ASP) của danh mục này đạt mức cao là **$144.20**. Ngược lại, danh mục *Intimates* tuy đứng hạng 1 về số lượng bán ra nhưng chỉ xếp hạng 11 về doanh thu do ASP rất thấp ($34.03).
- **Interpretation:** Vì ASP cao hơn hẳn mức trung bình, performance của danh mục Outerwear & Coats hoàn toàn được dẫn dắt bởi **giá trị (price-led)** thay vì quy mô số lượng (volume-led). Điều này cũng được thể hiện rõ ở cấp độ sản phẩm: Top 1 sản phẩm mang lại doanh thu cao nhất (*True Religion Women's Casey Stretch Leather Pants*) chỉ bán được vỏn vẹn 5 chiếc nhưng có giá lên tới $695/chiếc, cho thấy top doanh thu không trùng khớp với top volume.
- **Action:** Đội ngũ Merchandise nên ưu tiên kiểm tra lại tồn kho của các SKU thuộc danh mục **Outerwear & Coats** – nhóm đang mang lại nguồn thu chủ lực với biên lợi nhuận gộp (gross margin) cực kỳ an toàn ở mức **55.54%**. Đồng thời, có thể cân nhắc áp dụng chiến lược volume-led cho nhóm *Jeans* (đứng hạng 2 cả về doanh thu lẫn units).

## 3. Customer behavior
- **Evidence:** Tỷ lệ khách hàng mua lặp lại (có từ 2 đơn hàng hợp lệ trở lên) đạt **12.09%**. Xét về phân phối giá trị, 50% khách hàng (Median) chi tiêu ở mức **$64.00**, trong khi chi tiêu trung bình (Mean) lên tới **$98.36**. 
- **Interpretation:** Sự chênh lệch đáng kể giữa Mean ($98.36) và Median ($64.00) cho thấy cấu trúc doanh thu bị lệch phải, phụ thuộc nhiều vào một nhóm nhỏ khách hàng giá trị cao (High-value customers) – minh chứng là khách hàng Top 1 (user_id: 35524) có mức chi tiêu lên tới $1,389.83, cao gấp hàng chục lần so với trung vị. Về nguồn truy cập, khách hàng từ [Nguồn traffic] đang mang lại doanh thu cao nhất.
- **Limitation:** Mối quan hệ giữa nguồn truy cập và doanh thu chỉ là tương quan (association), không thể khẳng định nguyên nhân - kết quả (causal claim) do giới hạn của dữ liệu.

## 4. Fulfillment funnel
- **Evidence:** Trong toàn bộ chu kỳ dữ liệu, tỷ lệ chuyển đổi từ Đặt hàng (Placed) sang Giao hàng (Shipped) đạt **64.85%**, và từ Giao hàng sang Hoàn tất (Delivered) đạt **54.04%**. Tỷ lệ Hủy đơn (Cancellation rate) là **15.20%** và tỷ lệ Trả hàng trên tổng đơn đã giao (Return rate) lên tới **28.79%** (12,595 đơn trả / 43,743 đơn giao thành công).
- **Interpretation:** Nút thắt (bottleneck) của quy trình vận hành dường như nằm ở khâu **Giao hàng -> Hoàn tất** do có tỷ lệ rớt phễu cao nhất (gần 46% số đơn đã giao đi không tới được trạng thái hoàn tất). Bên cạnh đó, tỷ lệ trả hàng (Return rate) ở mức **rất cao (gần 29%)**, cho thấy **rủi ro lớn về chất lượng sản phẩm thực tế không đáp ứng kỳ vọng của khách hàng hoặc khâu đóng gói/vận chuyển làm hỏng hàng hóa**.
- **Action:** Bộ phận Operations nên drill-down sâu vào các đơn hàng bị Hủy hoặc Trả lại theo từng danh mục (Category) hoặc theo từng tháng (dựa trên bảng Monthly Cohort) để tìm ra nguyên nhân cốt lõi nhằm cải thiện chất lượng dịch vụ. Riêng với lượng đơn rớt ở khâu Giao hàng, cần làm việc lại với đối tác vận chuyển (3PL).