-- Kiểm tra xe có model và brand hợp lệ không
USE CRMS_DB1;
GO

-- Kiểm tra xe có ModelID NULL hoặc không tồn tại
SELECT 
    c.CarID,
    c.LicensePlate,
    c.ModelID,
    c.CategoryID,
    CASE 
        WHEN c.ModelID IS NULL THEN 'ModelID NULL'
        WHEN NOT EXISTS (SELECT 1 FROM CarModels WHERE ModelID = c.ModelID) THEN 'ModelID không tồn tại'
        ELSE 'OK'
    END AS ModelStatus
FROM Cars c;

-- Kiểm tra model có BrandID NULL hoặc không tồn tại
SELECT 
    m.ModelID,
    m.ModelName,
    m.BrandID,
    CASE 
        WHEN m.BrandID IS NULL THEN 'BrandID NULL'
        WHEN NOT EXISTS (SELECT 1 FROM CarBrands WHERE BrandID = m.BrandID) THEN 'BrandID không tồn tại'
        ELSE 'OK'
    END AS BrandStatus
FROM CarModels m;

-- Kiểm tra xe và thông tin model/brand
SELECT 
    c.CarID,
    c.LicensePlate,
    c.ModelID,
    m.ModelName,
    m.BrandID,
    b.BrandName
FROM Cars c
LEFT JOIN CarModels m ON c.ModelID = m.ModelID
LEFT JOIN CarBrands b ON m.BrandID = b.BrandID
WHERE m.ModelID IS NULL OR b.BrandID IS NULL;
