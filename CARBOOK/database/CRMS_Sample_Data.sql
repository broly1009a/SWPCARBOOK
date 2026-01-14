-- ============================================
-- Car Rental Management System (CRMS)
-- Sample Data Insertion Script
-- Created: January 14, 2026
-- ============================================

USE CRMS_DB;
GO

-- ============================================
-- 1. INSERT SAMPLE USERS
-- ============================================

-- Insert Admin User (Password: Admin@123)
INSERT INTO Users (Username, Email, PasswordHash, FullName, PhoneNumber, Address, DateOfBirth, RoleID, IsActive, IsEmailVerified)
VALUES 
('admin', 'admin@carbook.com', '$2a$10$xKZ8h5ZqL9mXJx0vQKqGHu5y3r2wVnP4lMxF8tC9dE6gH7iJ8kL0m', N'Nguyễn Văn Admin', '0901234567', N'Hà Nội, Việt Nam', '1985-01-15', 1, 1, 1);

-- Insert Car Owners
INSERT INTO Users (Username, Email, PasswordHash, FullName, PhoneNumber, Address, DateOfBirth, DriverLicenseNumber, DriverLicenseExpiry, RoleID, IsActive, IsEmailVerified)
VALUES 
('owner1', 'owner1@carbook.com', '$2a$10$xKZ8h5ZqL9mXJx0vQKqGHu5y3r2wVnP4lMxF8tC9dE6gH7iJ8kL0m', N'Trần Thị Mai', '0902345678', N'Quận 1, TP.HCM', '1988-03-20', 'B2-123456', '2027-12-31', 2, 1, 1),
('owner2', 'owner2@carbook.com', '$2a$10$xKZ8h5ZqL9mXJx0vQKqGHu5y3r2wVnP4lMxF8tC9dE6gH7iJ8kL0m', N'Lê Văn Hùng', '0903456789', N'Quận 3, TP.HCM', '1990-05-10', 'B2-234567', '2028-06-30', 2, 1, 1),
('owner3', 'owner3@carbook.com', '$2a$10$xKZ8h5ZqL9mXJx0vQKqGHu5y3r2wVnP4lMxF8tC9dE6gH7iJ8kL0m', N'Phạm Thị Lan', '0904567890', N'Cầu Giấy, Hà Nội', '1992-07-25', 'B2-345678', '2029-03-15', 2, 1, 1);

-- Insert Customers
INSERT INTO Users (Username, Email, PasswordHash, FullName, PhoneNumber, Address, DateOfBirth, DriverLicenseNumber, DriverLicenseExpiry, RoleID, IsActive, IsEmailVerified)
VALUES 
('customer1', 'customer1@gmail.com', '$2a$10$xKZ8h5ZqL9mXJx0vQKqGHu5y3r2wVnP4lMxF8tC9dE6gH7iJ8kL0m', N'Hoàng Văn Nam', '0905678901', N'Quận 7, TP.HCM', '1995-09-12', 'B2-456789', '2026-12-31', 3, 1, 1),
('customer2', 'customer2@gmail.com', '$2a$10$xKZ8h5ZqL9mXJx0vQKqGHu5y3r2wVnP4lMxF8tC9dE6gH7iJ8kL0m', N'Đặng Thị Hoa', '0906789012', N'Quận 10, TP.HCM', '1996-11-08', 'B2-567890', '2027-08-20', 3, 1, 1),
('customer3', 'customer3@gmail.com', '$2a$10$xKZ8h5ZqL9mXJx0vQKqGHu5y3r2wVnP4lMxF8tC9dE6gH7iJ8kL0m', N'Vũ Văn Tùng', '0907890123', N'Hai Bà Trưng, Hà Nội', '1994-02-14', 'B2-678901', '2028-11-10', 3, 1, 1),
('customer4', 'customer4@gmail.com', '$2a$10$xKZ8h5ZqL9mXJx0vQKqGHu5y3r2wVnP4lMxF8tC9dE6gH7iJ8kL0m', N'Bùi Thị Thu', '0908901234', N'Đống Đa, Hà Nội', '1997-04-22', 'B2-789012', '2029-05-15', 3, 1, 1),
('customer5', 'customer5@gmail.com', '$2a$10$xKZ8h5ZqL9mXJx0vQKqGHu5y3r2wVnP4lMxF8tC9dE6gH7iJ8kL0m', N'Ngô Văn Đức', '0909012345', N'Quận 5, TP.HCM', '1993-12-30', 'B2-890123', '2027-02-28', 3, 1, 1);

GO

-- ============================================
-- 2. INSERT CAR MODELS
-- ============================================

-- Toyota Models
INSERT INTO CarModels (BrandID, ModelName, Year) VALUES
(1, 'Vios', 2023),
(1, 'Camry', 2023),
(1, 'Fortuner', 2023),
(1, 'Innova', 2022),
(1, 'Corolla Altis', 2023),
(1, 'Veloz Cross', 2024);

-- Honda Models
INSERT INTO CarModels (BrandID, ModelName, Year) VALUES
(2, 'City', 2023),
(2, 'Civic', 2023),
(2, 'CR-V', 2023),
(2, 'Accord', 2022),
(2, 'HR-V', 2023);

-- Ford Models
INSERT INTO CarModels (BrandID, ModelName, Year) VALUES
(3, 'Ranger', 2023),
(3, 'Everest', 2023),
(3, 'Explorer', 2022),
(3, 'Mustang', 2023);

-- Hyundai Models
INSERT INTO CarModels (BrandID, ModelName, Year) VALUES
(4, 'Accent', 2023),
(4, 'Elantra', 2023),
(4, 'Tucson', 2023),
(4, 'Santa Fe', 2023),
(4, 'Kona', 2024);

-- Mazda Models
INSERT INTO CarModels (BrandID, ModelName, Year) VALUES
(5, 'Mazda3', 2023),
(5, 'Mazda6', 2022),
(5, 'CX-5', 2023),
(5, 'CX-8', 2023);

-- Kia Models
INSERT INTO CarModels (BrandID, ModelName, Year) VALUES
(6, 'Seltos', 2023),
(6, 'Sorento', 2023),
(6, 'Carnival', 2023);

-- Mercedes-Benz Models
INSERT INTO CarModels (BrandID, ModelName, Year) VALUES
(7, 'C-Class', 2023),
(7, 'E-Class', 2023),
(7, 'S-Class', 2022),
(7, 'GLC', 2023);

-- BMW Models
INSERT INTO CarModels (BrandID, ModelName, Year) VALUES
(8, '3 Series', 2023),
(8, '5 Series', 2023),
(8, 'X5', 2023);

-- Vinfast Models
INSERT INTO CarModels (BrandID, ModelName, Year) VALUES
(9, 'VF 5', 2024),
(9, 'VF 8', 2024),
(9, 'VF 9', 2023),
(9, 'Lux A2.0', 2023),
(9, 'Fadil', 2022);

GO

-- ============================================
-- 3. INSERT SAMPLE CARS
-- ============================================

-- Owner 1's Cars (Trần Thị Mai)
INSERT INTO Cars (OwnerID, ModelID, CategoryID, LicensePlate, VINNumber, Color, Seats, FuelType, Transmission, Mileage, PricePerDay, Status, Location, Description, Features)
VALUES 
(2, 1, 1, '51A-12345', 'VIN1TOYOTAVIOS001', N'Trắng', 5, 'Petrol', 'Automatic', 15000, 500000, 'Available', N'Quận 1, TP.HCM', N'Toyota Vios 2023 mới, xe đẹp, tiết kiệm xăng', N'AC, GPS, Bluetooth'),
(2, 3, 2, '51B-23456', 'VIN2TOYOTAFORT002', N'Đen', 7, 'Diesel', 'Automatic', 20000, 1200000, 'Available', N'Quận 1, TP.HCM', N'Toyota Fortuner 2023, xe sang trọng, rộng rãi', N'AC, GPS, Bluetooth, Cruise Control'),
(2, 9, 2, '51C-34567', 'VIN3HONDACRV0003', N'Xanh', 7, 'Petrol', 'Automatic', 18000, 850000, 'Available', N'Quận 3, TP.HCM', N'Honda CR-V 2023, xe gia đình lý tưởng', N'AC, GPS, Bluetooth, Reverse Camera');

-- Owner 2's Cars (Lê Văn Hùng)
INSERT INTO Cars (OwnerID, ModelID, CategoryID, LicensePlate, VINNumber, Color, Seats, FuelType, Transmission, Mileage, PricePerDay, Status, Location, Description, Features)
VALUES 
(3, 7, 1, '51D-45678', 'VIN4HONDACITY004', N'Bạc', 5, 'Petrol', 'Automatic', 12000, 550000, 'Available', N'Quận 3, TP.HCM', N'Honda City 2023, xe mới, tiện nghi', N'AC, GPS, Bluetooth'),
(3, 15, 1, '51E-56789', 'VIN5HYUNDAIACC005', N'Đỏ', 5, 'Petrol', 'Automatic', 8000, 600000, 'Available', N'Quận 5, TP.HCM', N'Hyundai Accent 2023, xe đẹp lung linh', N'AC, GPS, Bluetooth, USB Port'),
(3, 23, 5, '51F-67890', 'VIN6MERCEDESBENZ', N'Đen', 5, 'Petrol', 'Automatic', 5000, 2500000, 'Available', N'Quận 7, TP.HCM', N'Mercedes C-Class 2023, xe sang trọng', N'AC, GPS, Bluetooth, Leather Seats, Sunroof');

-- Owner 3's Cars (Phạm Thị Lan)
INSERT INTO Cars (OwnerID, ModelID, CategoryID, LicensePlate, VINNumber, Color, Seats, FuelType, Transmission, Mileage, PricePerDay, Status, Location, Description, Features)
VALUES 
(4, 20, 1, '30A-11111', 'VIN7MAZDA3000007', N'Xanh', 5, 'Petrol', 'Manual', 25000, 480000, 'Available', N'Cầu Giấy, Hà Nội', N'Mazda3 2023, xe đẹp, vận hành tốt', N'AC, GPS, Bluetooth'),
(4, 17, 2, '30B-22222', 'VIN8HYUNDAITUC008', N'Trắng', 7, 'Diesel', 'Automatic', 30000, 1100000, 'Available', N'Hai Bà Trưng, Hà Nội', N'Hyundai Tucson 2023, xe SUV gia đình', N'AC, GPS, Bluetooth, Reverse Camera'),
(4, 11, 7, '30C-33333', 'VIN9FORDRANGER009', N'Bạc', 5, 'Diesel', 'Manual', 35000, 800000, 'Available', N'Đống Đa, Hà Nội', N'Ford Ranger 2023, xe bán tải mạnh mẽ', N'AC, GPS, 4WD'),
(4, 33, 6, '30D-44444', 'VINAVINFASTVF510', N'Xanh', 5, 'Electric', 'Automatic', 10000, 700000, 'Available', N'Cầu Giấy, Hà Nội', N'Vinfast VF 5 2024, xe điện thân thiện môi trường', N'AC, GPS, Bluetooth, Fast Charging');

GO

-- ============================================
-- 4. INSERT CAR IMAGES
-- ============================================

INSERT INTO CarImages (CarID, ImageURL, IsPrimary, DisplayOrder)
VALUES 
-- Car 1 (Vios)
(1, 'images/cars/vios-white-1.jpg', 1, 1),
(1, 'images/cars/vios-white-2.jpg', 0, 2),
(1, 'images/cars/vios-white-3.jpg', 0, 3),
-- Car 2 (Fortuner)
(2, 'images/cars/fortuner-black-1.jpg', 1, 1),
(2, 'images/cars/fortuner-black-2.jpg', 0, 2),
-- Car 3 (CR-V)
(3, 'images/cars/crv-blue-1.jpg', 1, 1),
(3, 'images/cars/crv-blue-2.jpg', 0, 2),
-- Car 4 (City)
(4, 'images/cars/city-silver-1.jpg', 1, 1),
-- Car 5 (Accent)
(5, 'images/cars/accent-red-1.jpg', 1, 1),
(5, 'images/cars/accent-red-2.jpg', 0, 2),
-- Car 6 (C-Class)
(6, 'images/cars/mercedes-c-1.jpg', 1, 1),
(6, 'images/cars/mercedes-c-2.jpg', 0, 2),
(6, 'images/cars/mercedes-c-3.jpg', 0, 3),
-- Car 7 (Mazda3)
(7, 'images/cars/mazda3-blue-1.jpg', 1, 1),
-- Car 8 (Tucson)
(8, 'images/cars/tucson-white-1.jpg', 1, 1),
(8, 'images/cars/tucson-white-2.jpg', 0, 2),
-- Car 9 (Ranger)
(9, 'images/cars/ranger-silver-1.jpg', 1, 1),
-- Car 10 (VF 5)
(10, 'images/cars/vf5-green-1.jpg', 1, 1),
(10, 'images/cars/vf5-green-2.jpg', 0, 2);

GO

-- ============================================
-- 5. INSERT SAMPLE BOOKINGS
-- ============================================

-- Completed bookings
INSERT INTO Bookings (CarID, CustomerID, BookingReference, PickupDate, ReturnDate, PickupLocation, ReturnLocation, TotalDays, BasePrice, TaxAmount, TotalAmount, Status, ApprovedBy, ApprovedAt, CreatedAt, UpdatedAt)
VALUES 
(1, 5, 'BK2026010001', '2026-01-05 09:00', '2026-01-08 09:00', N'Quận 1, TP.HCM', N'Quận 1, TP.HCM', 3, 1500000, 150000, 1650000, 'Completed', 1, '2026-01-04 14:00', '2026-01-03 10:00', '2026-01-08 10:00'),
(2, 6, 'BK2026010002', '2026-01-06 08:00', '2026-01-09 08:00', N'Quận 3, TP.HCM', N'Quận 1, TP.HCM', 3, 3600000, 360000, 3960000, 'Completed', 1, '2026-01-05 15:00', '2026-01-04 11:00', '2026-01-09 11:00'),
(3, 7, 'BK2026010003', '2026-01-07 10:00', '2026-01-10 10:00', N'Quận 3, TP.HCM', N'Quận 3, TP.HCM', 3, 2550000, 255000, 2805000, 'Completed', 1, '2026-01-06 16:00', '2026-01-05 12:00', '2026-01-10 12:00');

-- Approved bookings (ongoing)
INSERT INTO Bookings (CarID, CustomerID, BookingReference, PickupDate, ReturnDate, PickupLocation, ReturnLocation, TotalDays, BasePrice, TaxAmount, TotalAmount, Status, ApprovedBy, ApprovedAt, CreatedAt)
VALUES 
(4, 8, 'BK2026011001', '2026-01-14 09:00', '2026-01-17 09:00', N'Quận 5, TP.HCM', N'Quận 5, TP.HCM', 3, 1650000, 165000, 1815000, 'Approved', 1, '2026-01-13 10:00', '2026-01-12 14:00'),
(5, 9, 'BK2026011002', '2026-01-15 08:00', '2026-01-18 08:00', N'Quận 7, TP.HCM', N'Quận 7, TP.HCM', 3, 1800000, 180000, 1980000, 'Approved', 1, '2026-01-14 11:00', '2026-01-13 15:00');

-- Pending bookings
INSERT INTO Bookings (CarID, CustomerID, BookingReference, PickupDate, ReturnDate, PickupLocation, ReturnLocation, TotalDays, BasePrice, TaxAmount, TotalAmount, Status, CreatedAt)
VALUES 
(7, 5, 'BK2026011003', '2026-01-16 10:00', '2026-01-19 10:00', N'Cầu Giấy, Hà Nội', N'Cầu Giấy, Hà Nội', 3, 1440000, 144000, 1584000, 'Pending', '2026-01-14 16:00'),
(8, 6, 'BK2026011004', '2026-01-17 09:00', '2026-01-20 09:00', N'Hai Bà Trưng, Hà Nội', N'Đống Đa, Hà Nội', 3, 3300000, 330000, 3630000, 'Pending', '2026-01-14 17:00'),
(9, 7, 'BK2026011005', '2026-01-18 08:00', '2026-01-21 08:00', N'Đống Đa, Hà Nội', N'Đống Đa, Hà Nội', 3, 2400000, 240000, 2640000, 'Pending', '2026-01-14 18:00');

GO

-- ============================================
-- 6. INSERT SAMPLE PAYMENTS
-- ============================================

-- Payments for completed bookings
INSERT INTO Payments (BookingID, PaymentMethodID, PaymentReference, Amount, PaymentDate, Status, TransactionID)
VALUES 
(1, 1, 'PAY2026010001', 1650000, '2026-01-04 15:00', 'Paid', 'TXN001'),
(2, 2, 'PAY2026010002', 3960000, '2026-01-05 16:00', 'Paid', 'TXN002'),
(3, 5, 'PAY2026010003', 2805000, '2026-01-06 17:00', 'Paid', 'TXN003');

-- Payments for approved bookings
INSERT INTO Payments (BookingID, PaymentMethodID, PaymentReference, Amount, PaymentDate, Status, TransactionID)
VALUES 
(4, 2, 'PAY2026011001', 1815000, '2026-01-13 11:00', 'Paid', 'TXN004'),
(5, 3, 'PAY2026011002', 1980000, '2026-01-14 12:00', 'Paid', 'TXN005');

GO

-- ============================================
-- 7. INSERT SAMPLE REVIEWS
-- ============================================

INSERT INTO Reviews (BookingID, CarID, CustomerID, Rating, Comment, IsApproved, ApprovedBy, CreatedAt)
VALUES 
(1, 1, 5, 5, N'Xe rất tuyệt vời, chủ xe nhiệt tình. Sẽ thuê lại lần sau!', 1, 1, '2026-01-08 11:00'),
(2, 2, 6, 5, N'Fortuner rất sang trọng và rộng rãi. Phù hợp cho gia đình đi du lịch.', 1, 1, '2026-01-09 12:00'),
(3, 3, 7, 4, N'Xe tốt, sạch sẽ. Tuy nhiên giá hơi cao một chút.', 1, 1, '2026-01-10 13:00');

GO

-- ============================================
-- 8. INSERT SAMPLE NOTIFICATIONS
-- ============================================

INSERT INTO Notifications (UserID, Type, Title, Message, RelatedEntityType, RelatedEntityID, IsRead, CreatedAt)
VALUES 
-- For Customer 1
(5, 'Booking', N'Đặt xe thành công', N'Đơn đặt xe BK2026010001 của bạn đã được xác nhận.', 'Booking', 1, 1, '2026-01-04 14:00'),
(5, 'Payment', N'Thanh toán thành công', N'Thanh toán 1,650,000 VNĐ cho đơn BK2026010001 đã hoàn tất.', 'Payment', 1, 1, '2026-01-04 15:00'),
(5, 'Booking', N'Đơn mới chờ duyệt', N'Đơn đặt xe BK2026011003 đang chờ chủ xe xác nhận.', 'Booking', 6, 0, '2026-01-14 16:00'),

-- For Owner 1
(2, 'Booking', N'Có đơn đặt xe mới', N'Bạn có đơn đặt xe mới BK2026010001 cho xe 51A-12345.', 'Booking', 1, 1, '2026-01-03 10:00'),
(2, 'Review', N'Đánh giá mới', N'Xe 51A-12345 nhận được đánh giá 5 sao từ khách hàng.', 'Review', 1, 0, '2026-01-08 11:00'),

-- For Owner 3
(4, 'Booking', N'Có đơn đặt xe mới', N'Bạn có đơn đặt xe mới BK2026011003 cho xe 30A-11111.', 'Booking', 6, 0, '2026-01-14 16:00');

GO

-- ============================================
-- 9. INSERT CAR AVAILABILITY
-- ============================================

INSERT INTO CarAvailability (CarID, StartDate, EndDate, IsAvailable, Reason)
VALUES 
-- Car 6 (Mercedes) unavailable for maintenance
(6, '2026-01-20', '2026-01-25', 0, N'Bảo dưỡng định kỳ'),
-- Car 10 (VF 5) unavailable - owner personal use
(10, '2026-01-22', '2026-01-24', 0, N'Chủ xe sử dụng cá nhân');

GO

-- ============================================
-- 10. INSERT MAINTENANCE RECORDS
-- ============================================

INSERT INTO MaintenanceRecords (CarID, MaintenanceType, Description, ServiceProvider, ServiceDate, ServiceCost, NextServiceDate, Status, PerformedBy)
VALUES 
(1, 'Routine', N'Thay dầu và bảo dưỡng định kỳ', N'Toyota Service Center', '2026-01-02', 1500000, '2026-07-02', 'Completed', 2),
(2, 'Routine', N'Kiểm tra và thay lọc gió', N'Toyota Service Center', '2025-12-15', 800000, '2026-06-15', 'Completed', 2),
(6, 'Routine', N'Bảo dưỡng 10,000km', N'Mercedes Service Center', '2026-01-20', 5000000, '2026-07-20', 'Scheduled', 3);

GO

-- ============================================
-- 11. INSERT BOOKING STATUS HISTORY
-- ============================================

INSERT INTO BookingStatusHistory (BookingID, OldStatus, NewStatus, ChangedBy, Comments)
VALUES 
(1, 'Pending', 'Approved', 1, N'Đơn đặt xe được duyệt'),
(1, 'Approved', 'Completed', 1, N'Hoàn thành đơn đặt xe'),
(2, 'Pending', 'Approved', 1, N'Đơn đặt xe được duyệt'),
(2, 'Approved', 'Completed', 1, N'Hoàn thành đơn đặt xe'),
(3, 'Pending', 'Approved', 1, N'Đơn đặt xe được duyệt'),
(3, 'Approved', 'Completed', 1, N'Hoàn thành đơn đặt xe'),
(4, 'Pending', 'Approved', 1, N'Đơn đặt xe được duyệt'),
(5, 'Pending', 'Approved', 1, N'Đơn đặt xe được duyệt');

GO

-- ============================================
-- 12. INSERT INVOICES
-- ============================================

INSERT INTO Invoices (BookingID, InvoiceNumber, InvoiceDate, DueDate, SubTotal, TaxAmount, TotalAmount, Status)
VALUES 
(1, 'INV2026010001', '2026-01-04', '2026-01-05', 1500000, 150000, 1650000, 'Paid'),
(2, 'INV2026010002', '2026-01-05', '2026-01-06', 3600000, 360000, 3960000, 'Paid'),
(3, 'INV2026010003', '2026-01-06', '2026-01-07', 2550000, 255000, 2805000, 'Paid'),
(4, 'INV2026011001', '2026-01-13', '2026-01-14', 1650000, 165000, 1815000, 'Paid'),
(5, 'INV2026011002', '2026-01-14', '2026-01-15', 1800000, 180000, 1980000, 'Paid'),
(6, 'INV2026011003', '2026-01-14', '2026-01-16', 1440000, 144000, 1584000, 'Unpaid'),
(7, 'INV2026011004', '2026-01-14', '2026-01-17', 3300000, 330000, 3630000, 'Unpaid'),
(8, 'INV2026011005', '2026-01-14', '2026-01-18', 2400000, 240000, 2640000, 'Unpaid');

GO

-- ============================================
-- 13. INSERT RECEIPTS
-- ============================================

INSERT INTO Receipts (PaymentID, ReceiptNumber, ReceiptDate, Amount, PaymentMethod, IssuedTo)
VALUES 
(1, 'RCP2026010001', '2026-01-04 15:00', 1650000, 'Cash', 5),
(2, 'RCP2026010002', '2026-01-05 16:00', 3960000, 'Credit Card', 6),
(3, 'RCP2026010003', '2026-01-06 17:00', 2805000, 'E-Wallet', 7),
(4, 'RCP2026011001', '2026-01-13 11:00', 1815000, 'Credit Card', 8),
(5, 'RCP2026011002', '2026-01-14 12:00', 1980000, 'Debit Card', 9);

GO

-- ============================================
-- 14. INSERT CAR RETURNS
-- ============================================

INSERT INTO CarReturns (BookingID, ActualReturnDate, ReturnCondition, FuelLevel, Mileage, DistanceTraveled, IsLatReturn, LateReturnHours, LateReturnPenalty, HasDamage, TotalPenalty, ReturnNotes, InspectedBy)
VALUES 
(1, '2026-01-08 09:15', 'Excellent', 95.00, 15300, 300, 0, 0, 0, 0, 0, N'Xe trả đúng hẹn, tình trạng tốt', 2),
(2, '2026-01-09 09:30', 'Good', 80.00, 20450, 450, 0, 0, 0, 0, 0, N'Xe trả đúng giờ, sạch sẽ', 2),
(3, '2026-01-10 11:00', 'Good', 90.00, 18350, 350, 1, 1, 50000, 0, 50000, N'Trả muộn 1 giờ', 2);

GO

-- ============================================
-- 15. INSERT AUDIT LOGS (Sample)
-- ============================================

INSERT INTO AuditLogs (UserID, Action, EntityType, EntityID, IPAddress, UserAgent)
VALUES 
(1, 'Login', 'User', 1, '192.168.1.100', 'Mozilla/5.0'),
(5, 'Create Booking', 'Booking', 1, '192.168.1.101', 'Mozilla/5.0'),
(1, 'Approve Booking', 'Booking', 1, '192.168.1.100', 'Mozilla/5.0'),
(5, 'Create Payment', 'Payment', 1, '192.168.1.101', 'Mozilla/5.0'),
(2, 'Update Car', 'Car', 1, '192.168.1.102', 'Mozilla/5.0');

GO

PRINT '============================================';
PRINT 'Sample data inserted successfully!';
PRINT '============================================';
PRINT 'Summary:';
PRINT '- Users: 8 (1 Admin, 3 Car Owners, 5 Customers)';
PRINT '- Car Brands: 9';
PRINT '- Car Models: 38';
PRINT '- Cars: 10';
PRINT '- Car Images: 18';
PRINT '- Bookings: 8 (3 Completed, 2 Approved, 3 Pending)';
PRINT '- Payments: 5';
PRINT '- Reviews: 3';
PRINT '- Notifications: 6';
PRINT '- Invoices: 8';
PRINT '- Receipts: 5';
PRINT '- Car Returns: 3';
PRINT '- Maintenance Records: 3';
PRINT '============================================';
PRINT 'Login credentials (all passwords: Admin@123):';
PRINT '- Admin: admin / admin@carbook.com';
PRINT '- Owner 1: owner1 / owner1@carbook.com';
PRINT '- Owner 2: owner2 / owner2@carbook.com';
PRINT '- Owner 3: owner3 / owner3@carbook.com';
PRINT '- Customer 1: customer1 / customer1@gmail.com';
PRINT '- Customer 2: customer2 / customer2@gmail.com';
PRINT '- Customer 3: customer3 / customer3@gmail.com';
PRINT '- Customer 4: customer4 / customer4@gmail.com';
PRINT '- Customer 5: customer5 / customer5@gmail.com';
PRINT '============================================';
GO
