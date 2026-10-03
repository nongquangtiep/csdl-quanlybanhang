-- ========================================================
-- BÀI TẬP: XÂY DỰNG CƠ SỞ DỮ LIỆU QUẢN LÝ BÁN HÀNG
-- ========================================================

DROP DATABASE IF EXISTS QuanLyBanHang;
CREATE DATABASE QuanLyBanHang CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE QuanLyBanHang;

-- 1. BẢNG CUSTOMER (Khách hàng)
CREATE TABLE Customer (
    cID INT AUTO_INCREMENT PRIMARY KEY,
    cName VARCHAR(50) NOT NULL,
    cAge TINYINT UNSIGNED CHECK (cAge > 0)
) ENGINE=InnoDB;

-- 2. BẢNG `ORDER` (Hóa đơn - Quan hệ 1 - N với Customer)
CREATE TABLE `Order` (
    oID INT AUTO_INCREMENT PRIMARY KEY,
    cID INT NOT NULL,
    oDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    oTotalPrice DECIMAL(12, 2) DEFAULT NULL,
    FOREIGN KEY (cID) REFERENCES Customer(cID) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 3. BẢNG PRODUCT (Sản phẩm)
CREATE TABLE Product (
    pID INT AUTO_INCREMENT PRIMARY KEY,
    pName VARCHAR(100) NOT NULL,
    pPrice DECIMAL(10, 2) NOT NULL CHECK (pPrice >= 0)
) ENGINE=InnoDB;

-- 4. BẢNG ORDERDETAIL (Chi tiết hóa đơn - Bảng liên kết N - M)
CREATE TABLE OrderDetail (
    oID INT NOT NULL,
    pID INT NOT NULL,
    odQTY INT NOT NULL CHECK (odQTY > 0),
    PRIMARY KEY (oID, pID),
    FOREIGN KEY (oID) REFERENCES `Order`(oID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (pID) REFERENCES Product(pID) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ========================================================
-- CHÈN DỮ LIỆU MẪU KIỂM THỬ (DML)
-- ========================================================

-- Chèn dữ liệu khách hàng
INSERT INTO Customer (cName, cAge) VALUES 
('Minh Quan', 20),
('Ngoc Oanh', 20),
('Hong Ha', 50);

-- Chèn dữ liệu hóa đơn
INSERT INTO `Order` (oID, cID, oDate, oTotalPrice) VALUES 
(1, 1, '2006-03-21', NULL),
(2, 2, '2006-03-23', NULL),
(3, 1, '2006-03-16', NULL);

-- Chèn dữ liệu sản phẩm
INSERT INTO Product (pID, pName, pPrice) VALUES 
(1, 'May Giat', 300.00),
(2, 'Tu Lanh', 500.00),
(3, 'Dieu Hoa', 700.00),
(4, 'Quat', 100.00),
(5, 'Bep Dien', 200.00);

-- Chèn dữ liệu chi tiết hóa đơn
INSERT INTO OrderDetail (oID, pID, odQTY) VALUES 
(1, 1, 3),
(1, 3, 7),
(1, 4, 2),
(2, 1, 1),
(3, 1, 8),
(2, 5, 4),
(2, 3, 3);