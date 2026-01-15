-- Test query để kiểm tra xe trong database
USE CRMS_DB1;
GO

-- 1. Tổng số xe
SELECT COUNT(*) AS 'Total Cars' FROM Cars;

-- 2. Xe theo trạng thái
SELECT Status, COUNT(*) AS Count FROM Cars GROUP BY Status;

-- 3. Xe Available và Verified (cho Customer)
SELECT COUNT(*) AS 'Available & Verified Cars' 
FROM Cars 
WHERE Status = 'Available' AND IsVerified = 1;

-- 4. Chi tiết tất cả xe
SELECT 
    c.CarID,
    c.LicensePlate,
    c.OwnerID,
    m.ModelName,
    b.BrandName,
    c.Status,
    c.IsVerified,
    c.PricePerDay
FROM Cars c
LEFT JOIN CarModels m ON c.ModelID = m.ModelID
LEFT JOIN CarBrands b ON m.BrandID = b.BrandID
ORDER BY c.CarID;

-- 5. Kiểm tra user roles
SELECT UserID, FullName, Email, RoleID FROM Users;
