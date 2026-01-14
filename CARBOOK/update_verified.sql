-- Cập nhật tất cả xe thành IsVerified = 1 để có thể hiển thị
USE CRMS_DB1;
GO

UPDATE Cars 
SET IsVerified = 1
WHERE Status = 'Available';

-- Kiểm tra lại
SELECT 
    CarID,
    LicensePlate,
    Status,
    IsVerified,
    PricePerDay
FROM Cars;

PRINT 'Đã cập nhật thành công!';
