# [Bài tập] Xây dựng cơ sở dữ liệu Quản lý bán hàng

## 1. Mục tiêu
- Thiết kế và tạo cơ sở dữ liệu `QuanLyBanHang`.
- Tạo các bảng theo lược đồ quan hệ và thiết lập đầy đủ các ràng buộc: Khóa chính (Primary Key), Khóa ngoại (Foreign Key), Ràng buộc kiểm tra (Check Constraint) và giá trị không rỗng (NOT NULL).

---

## 2. Cấu trúc các bảng và thuộc tính trong hệ thống

### 2.1. Bảng `Customer` (Khách hàng)
- `cID` (INT, Khóa chính, Auto Increment): Mã định danh duy nhất của khách hàng.
- `cName` (VARCHAR(50), NOT NULL): Họ và tên khách hàng.
- `cAge` (TINYINT UNSIGNED): Tuổi của khách hàng, có ràng buộc `CHECK (cAge > 0)`.

### 2.2. Bảng `Order` (Hóa đơn)
- `oID` (INT, Khóa chính, Auto Increment): Số hóa đơn.
- `cID` (INT, Khóa ngoại, NOT NULL): Mã khách hàng, tham chiếu đến `Customer(cID)`.
- `oDate` (DATETIME, NOT NULL): Ngày lập hóa đơn.
- `oTotalPrice` (DECIMAL(12, 2)): Tổng giá tiền của đơn hàng.

### 2.3. Bảng `Product` (Sản phẩm)
- `pID` (INT, Khóa chính, Auto Increment): Mã sản phẩm.
- `pName` (VARCHAR(100), NOT NULL): Tên sản phẩm.
- `pPrice` (DECIMAL(10, 2), NOT NULL): Đơn giá, có ràng buộc `CHECK (pPrice >= 0)`.

### 2.4. Bảng `OrderDetail` (Chi tiết hóa đơn)
- `oID` (INT, Khóa ngoại 1, Khóa chính kết hợp): Tham chiếu đến `Order(oID)` với quy tắc `ON DELETE CASCADE`.
- `pID` (INT, Khóa ngoại 2, Khóa chính kết hợp): Tham chiếu đến `Product(pID)` với quy tắc `ON DELETE RESTRICT`.
- `odQTY` (INT, NOT NULL): Số lượng sản phẩm mua, có ràng buộc `CHECK (odQTY > 0)`.
- **Khóa chính**: `PRIMARY KEY (oID, pID)`.

---

## 3. Các mối quan hệ (Cardinality)
1. **Customer - Order (1 - N)**: Một khách hàng có thể có nhiều hóa đơn; mỗi hóa đơn chỉ thuộc về duy nhất một khách hàng.
2. **Order - OrderDetail (1 - N)**: Một hóa đơn có thể có nhiều chi tiết mặt hàng.
3. **Product - OrderDetail (1 - N)**: Một sản phẩm có thể xuất hiện trong nhiều chi tiết hóa đơn khác nhau.
4. **Order - Product (N - M)**: Quan hệ nhiều - nhiều giữa Hóa đơn và Sản phẩm được chuẩn hóa thông qua bảng liên kết `OrderDetail`.
