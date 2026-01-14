-- Kiểm tra dữ liệu trong database
USE CRMS_DB1;
GO

-- 1. Kiểm tra tổng số xe
SELECT COUNT(*) AS 'Tổng số xe' FROM Cars;

-- 2. Kiểm tra xe theo Status
SELECT Status, COUNT(*) AS 'Số lượng' 
FROM Cars 
GROUP BY Status;

-- 3. Kiểm tra xe theo IsVerified
SELECT IsVerified, COUNT(*) AS 'Số lượng' 
FROM Cars 
GROUP BY IsVerified;

-- 4. Kiểm tra chi tiết các xe
SELECT 
    CarID,
    LicensePlate,
    Status,
    IsVerified,
    PricePerDay
FROM Cars;

-- 5. Kiểm tra số danh mục
SELECT COUNT(*) AS 'Số danh mục' FROM CarCategories;

-- 6. Kiểm tra danh sách danh mục
SELECT * FROM CarCategories;
