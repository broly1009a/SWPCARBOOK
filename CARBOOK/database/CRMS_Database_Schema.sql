-- ============================================
-- Car Rental Management System (CRMS)
-- SQL Server Database Schema
-- Created: January 13, 2026
-- ============================================

-- Drop existing database if exists (use with caution)
-- DROP DATABASE IF EXISTS CRMS_DB;
-- GO

-- Create database
CREATE DATABASE CRMS_DB;
GO

USE CRMS_DB;
GO

-- ============================================
-- 1. USER & ROLE MANAGEMENT TABLES
-- ============================================

-- Roles Table
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY IDENTITY(1,1),
    RoleName NVARCHAR(50) NOT NULL UNIQUE,
    Description NVARCHAR(255),
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE()
);

-- Users Table
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Username NVARCHAR(50) NOT NULL UNIQUE,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255), -- Allow NULL for Google OAuth users
    FullName NVARCHAR(100),
    PhoneNumber NVARCHAR(20),
    Address NVARCHAR(255),
    DateOfBirth DATE,
    DriverLicenseNumber NVARCHAR(50),
    DriverLicenseExpiry DATE,
    ProfileImageURL NVARCHAR(500),
    GoogleID NVARCHAR(255), -- Google OAuth ID
    RoleID INT NOT NULL DEFAULT 3, -- Default to Customer role
    IsActive BIT DEFAULT 1,
    IsEmailVerified BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
    LastLoginAt DATETIME,
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);

-- Password Reset Tokens
CREATE TABLE PasswordResetTokens (
    TokenID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    Token NVARCHAR(255) NOT NULL UNIQUE,
    ExpiryDate DATETIME NOT NULL,
    IsUsed BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

-- ============================================
-- 2. CAR MANAGEMENT TABLES
-- ============================================

-- Car Categories
CREATE TABLE CarCategories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(50) NOT NULL UNIQUE,
    Description NVARCHAR(255),
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- Car Brands
CREATE TABLE CarBrands (
    BrandID INT PRIMARY KEY IDENTITY(1,1),
    BrandName NVARCHAR(50) NOT NULL UNIQUE,
    Country NVARCHAR(50),
    LogoURL NVARCHAR(500),
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- Car Models
CREATE TABLE CarModels (
    ModelID INT PRIMARY KEY IDENTITY(1,1),
    BrandID INT NOT NULL,
    ModelName NVARCHAR(100) NOT NULL,
    Year INT,
    FOREIGN KEY (BrandID) REFERENCES CarBrands(BrandID) ON DELETE CASCADE
);

-- Cars Table
CREATE TABLE Cars (
    CarID INT PRIMARY KEY IDENTITY(1,1),
    OwnerID INT NOT NULL,
    ModelID INT NOT NULL,
    CategoryID INT NOT NULL,
    LicensePlate NVARCHAR(20) NOT NULL UNIQUE,
    VINNumber NVARCHAR(50) UNIQUE,
    Color NVARCHAR(30),
    Seats INT,
    FuelType NVARCHAR(20), -- Petrol, Diesel, Electric, Hybrid
    Transmission NVARCHAR(20), -- Manual, Automatic
    Mileage DECIMAL(10,2),
    PricePerDay DECIMAL(10,2) NOT NULL,
    PricePerHour DECIMAL(10,2),
    Status NVARCHAR(20) DEFAULT 'Available', -- Available, Booked, Maintenance, Inactive
    Location NVARCHAR(255),
    Description NVARCHAR(1000),
    Features NVARCHAR(500), -- AC, GPS, Bluetooth, etc.
    InsuranceExpiryDate DATE,
    RegistrationExpiryDate DATE,
    IsVerified BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (OwnerID) REFERENCES Users(UserID),
    FOREIGN KEY (ModelID) REFERENCES CarModels(ModelID),
    FOREIGN KEY (CategoryID) REFERENCES CarCategories(CategoryID)
);

-- Car Images
CREATE TABLE CarImages (
    ImageID INT PRIMARY KEY IDENTITY(1,1),
    CarID INT NOT NULL,
    ImageURL NVARCHAR(500) NOT NULL,
    IsPrimary BIT DEFAULT 0,
    DisplayOrder INT DEFAULT 0,
    UploadedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CarID) REFERENCES Cars(CarID) ON DELETE CASCADE
);

-- Car Availability Schedule
CREATE TABLE CarAvailability (
    AvailabilityID INT PRIMARY KEY IDENTITY(1,1),
    CarID INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    IsAvailable BIT DEFAULT 1,
    Reason NVARCHAR(255),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CarID) REFERENCES Cars(CarID) ON DELETE CASCADE
);

-- ============================================
-- 3. BOOKING MANAGEMENT TABLES
-- ============================================

-- Bookings Table
CREATE TABLE Bookings (
    BookingID INT PRIMARY KEY IDENTITY(1,1),
    CarID INT NOT NULL,
    CustomerID INT NOT NULL,
    BookingReference NVARCHAR(50) NOT NULL UNIQUE,
    PickupDate DATETIME NOT NULL,
    ReturnDate DATETIME NOT NULL,
    PickupLocation NVARCHAR(255),
    ReturnLocation NVARCHAR(255),
    TotalDays INT,
    TotalHours INT,
    BasePrice DECIMAL(10,2) NOT NULL,
    TaxAmount DECIMAL(10,2) DEFAULT 0,
    DiscountAmount DECIMAL(10,2) DEFAULT 0,
    TotalAmount DECIMAL(10,2) NOT NULL,
    Status NVARCHAR(20) DEFAULT 'Pending', -- Pending, Approved, Rejected, Completed, Cancelled
    ApprovedBy INT,
    ApprovedAt DATETIME,
    RejectionReason NVARCHAR(500),
    CancellationReason NVARCHAR(500),
    CancelledBy INT,
    CancelledAt DATETIME,
    Notes NVARCHAR(1000),
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CarID) REFERENCES Cars(CarID),
    FOREIGN KEY (CustomerID) REFERENCES Users(UserID),
    FOREIGN KEY (ApprovedBy) REFERENCES Users(UserID),
    FOREIGN KEY (CancelledBy) REFERENCES Users(UserID)
);

-- Booking Status History
CREATE TABLE BookingStatusHistory (
    HistoryID INT PRIMARY KEY IDENTITY(1,1),
    BookingID INT NOT NULL,
    OldStatus NVARCHAR(20),
    NewStatus NVARCHAR(20) NOT NULL,
    ChangedBy INT,
    ChangedAt DATETIME DEFAULT GETDATE(),
    Comments NVARCHAR(500),
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID) ON DELETE CASCADE,
    FOREIGN KEY (ChangedBy) REFERENCES Users(UserID)
);

-- ============================================
-- 4. PAYMENT & BILLING TABLES
-- ============================================

-- Payment Methods
CREATE TABLE PaymentMethods (
    PaymentMethodID INT PRIMARY KEY IDENTITY(1,1),
    MethodName NVARCHAR(50) NOT NULL UNIQUE,
    Description NVARCHAR(255),
    IsActive BIT DEFAULT 1,
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- Payments Table
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    BookingID INT NOT NULL,
    PaymentMethodID INT NOT NULL,
    PaymentReference NVARCHAR(100) UNIQUE,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentDate DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(20) DEFAULT 'Pending', -- Pending, Paid, Failed, Refunded
    TransactionID NVARCHAR(100),
    Notes NVARCHAR(500),
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID),
    FOREIGN KEY (PaymentMethodID) REFERENCES PaymentMethods(PaymentMethodID)
);

-- Invoices Table
CREATE TABLE Invoices (
    InvoiceID INT PRIMARY KEY IDENTITY(1,1),
    BookingID INT NOT NULL,
    InvoiceNumber NVARCHAR(50) NOT NULL UNIQUE,
    InvoiceDate DATETIME DEFAULT GETDATE(),
    DueDate DATETIME,
    SubTotal DECIMAL(10,2) NOT NULL,
    TaxAmount DECIMAL(10,2) DEFAULT 0,
    DiscountAmount DECIMAL(10,2) DEFAULT 0,
    TotalAmount DECIMAL(10,2) NOT NULL,
    Status NVARCHAR(20) DEFAULT 'Unpaid', -- Unpaid, Paid, Overdue, Cancelled
    Notes NVARCHAR(500),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID)
);

-- Receipts Table
CREATE TABLE Receipts (
    ReceiptID INT PRIMARY KEY IDENTITY(1,1),
    PaymentID INT NOT NULL,
    ReceiptNumber NVARCHAR(50) NOT NULL UNIQUE,
    ReceiptDate DATETIME DEFAULT GETDATE(),
    Amount DECIMAL(10,2) NOT NULL,
    PaymentMethod NVARCHAR(50),
    IssuedTo INT NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (PaymentID) REFERENCES Payments(PaymentID),
    FOREIGN KEY (IssuedTo) REFERENCES Users(UserID)
);

-- Refunds Table
CREATE TABLE Refunds (
    RefundID INT PRIMARY KEY IDENTITY(1,1),
    PaymentID INT NOT NULL,
    BookingID INT NOT NULL,
    RefundReference NVARCHAR(100) UNIQUE,
    RefundAmount DECIMAL(10,2) NOT NULL,
    RefundReason NVARCHAR(500),
    Status NVARCHAR(20) DEFAULT 'Pending', -- Pending, Processed, Rejected
    ProcessedBy INT,
    ProcessedAt DATETIME,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (PaymentID) REFERENCES Payments(PaymentID),
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID),
    FOREIGN KEY (ProcessedBy) REFERENCES Users(UserID)
);

-- ============================================
-- 5. RETURN & MAINTENANCE TABLES
-- ============================================

-- Car Returns Table
CREATE TABLE CarReturns (
    ReturnID INT PRIMARY KEY IDENTITY(1,1),
    BookingID INT NOT NULL,
    ActualReturnDate DATETIME NOT NULL,
    ReturnCondition NVARCHAR(20), -- Excellent, Good, Fair, Poor, Damaged
    FuelLevel DECIMAL(5,2), -- Percentage
    Mileage DECIMAL(10,2),
    DistanceTraveled DECIMAL(10,2),
    IsLatReturn BIT DEFAULT 0,
    LateReturnHours INT DEFAULT 0,
    LateReturnPenalty DECIMAL(10,2) DEFAULT 0,
    HasDamage BIT DEFAULT 0,
    DamageDescription NVARCHAR(1000),
    DamagePenalty DECIMAL(10,2) DEFAULT 0,
    TotalPenalty DECIMAL(10,2) DEFAULT 0,
    ReturnNotes NVARCHAR(1000),
    InspectedBy INT,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID),
    FOREIGN KEY (InspectedBy) REFERENCES Users(UserID)
);

-- Damage Records
CREATE TABLE DamageRecords (
    DamageID INT PRIMARY KEY IDENTITY(1,1),
    ReturnID INT NOT NULL,
    DamageType NVARCHAR(50), -- Scratch, Dent, Broken, Missing Part
    DamageLocation NVARCHAR(100), -- Front, Rear, Left, Right, Interior
    DamageSeverity NVARCHAR(20), -- Minor, Moderate, Major
    RepairCost DECIMAL(10,2),
    Description NVARCHAR(500),
    ImageURL NVARCHAR(500),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ReturnID) REFERENCES CarReturns(ReturnID) ON DELETE CASCADE
);

-- Maintenance Records
CREATE TABLE MaintenanceRecords (
    MaintenanceID INT PRIMARY KEY IDENTITY(1,1),
    CarID INT NOT NULL,
    MaintenanceType NVARCHAR(50), -- Routine, Repair, Inspection
    Description NVARCHAR(1000),
    ServiceProvider NVARCHAR(100),
    ServiceDate DATETIME,
    ServiceCost DECIMAL(10,2),
    NextServiceDate DATE,
    Status NVARCHAR(20) DEFAULT 'Scheduled', -- Scheduled, In Progress, Completed, Cancelled
    PerformedBy INT,
    Notes NVARCHAR(500),
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CarID) REFERENCES Cars(CarID),
    FOREIGN KEY (PerformedBy) REFERENCES Users(UserID)
);

-- ============================================
-- 6. NOTIFICATION & REPORTING TABLES
-- ============================================

-- Notifications Table
CREATE TABLE Notifications (
    NotificationID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    Type NVARCHAR(50), -- Booking, Payment, System, Alert
    Title NVARCHAR(200) NOT NULL,
    Message NVARCHAR(1000) NOT NULL,
    RelatedEntityType NVARCHAR(50), -- Booking, Payment, Car
    RelatedEntityID INT,
    IsRead BIT DEFAULT 0,
    IsSent BIT DEFAULT 0,
    SentAt DATETIME,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

-- System Alerts
CREATE TABLE SystemAlerts (
    AlertID INT PRIMARY KEY IDENTITY(1,1),
    AlertType NVARCHAR(50), -- Warning, Error, Info, Critical
    Title NVARCHAR(200) NOT NULL,
    Message NVARCHAR(1000) NOT NULL,
    Source NVARCHAR(100),
    IsResolved BIT DEFAULT 0,
    ResolvedBy INT,
    ResolvedAt DATETIME,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ResolvedBy) REFERENCES Users(UserID)
);

-- Reviews and Ratings
CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY IDENTITY(1,1),
    BookingID INT NOT NULL,
    CarID INT NOT NULL,
    CustomerID INT NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment NVARCHAR(1000),
    IsApproved BIT DEFAULT 0,
    ApprovedBy INT,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID),
    FOREIGN KEY (CarID) REFERENCES Cars(CarID),
    FOREIGN KEY (CustomerID) REFERENCES Users(UserID),
    FOREIGN KEY (ApprovedBy) REFERENCES Users(UserID)
);

-- ============================================
-- 7. AUDIT & LOGGING TABLES
-- ============================================

-- Audit Logs
CREATE TABLE AuditLogs (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    Action NVARCHAR(100) NOT NULL,
    EntityType NVARCHAR(50),
    EntityID INT,
    OldValue NVARCHAR(MAX),
    NewValue NVARCHAR(MAX),
    IPAddress NVARCHAR(45),
    UserAgent NVARCHAR(500),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- System Settings
CREATE TABLE SystemSettings (
    SettingID INT PRIMARY KEY IDENTITY(1,1),
    SettingKey NVARCHAR(100) NOT NULL UNIQUE,
    SettingValue NVARCHAR(500),
    Description NVARCHAR(255),
    Category NVARCHAR(50),
    UpdatedBy INT,
    UpdatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UpdatedBy) REFERENCES Users(UserID)
);

-- ============================================
-- INDEXES FOR PERFORMANCE OPTIMIZATION
-- ============================================

-- Users indexes
CREATE INDEX IX_Users_Email ON Users(Email);
CREATE INDEX IX_Users_Username ON Users(Username);
CREATE INDEX IX_Users_IsActive ON Users(IsActive);
CREATE INDEX IX_Users_RoleID ON Users(RoleID);

-- Cars indexes
CREATE INDEX IX_Cars_OwnerID ON Cars(OwnerID);
CREATE INDEX IX_Cars_Status ON Cars(Status);
CREATE INDEX IX_Cars_CategoryID ON Cars(CategoryID);
CREATE INDEX IX_Cars_ModelID ON Cars(ModelID);
CREATE INDEX IX_Cars_PricePerDay ON Cars(PricePerDay);

-- Bookings indexes
CREATE INDEX IX_Bookings_CarID ON Bookings(CarID);
CREATE INDEX IX_Bookings_CustomerID ON Bookings(CustomerID);
CREATE INDEX IX_Bookings_Status ON Bookings(Status);
CREATE INDEX IX_Bookings_PickupDate ON Bookings(PickupDate);
CREATE INDEX IX_Bookings_ReturnDate ON Bookings(ReturnDate);
CREATE INDEX IX_Bookings_BookingReference ON Bookings(BookingReference);

-- Payments indexes
CREATE INDEX IX_Payments_BookingID ON Payments(BookingID);
CREATE INDEX IX_Payments_Status ON Payments(Status);
CREATE INDEX IX_Payments_PaymentDate ON Payments(PaymentDate);

-- Notifications indexes
CREATE INDEX IX_Notifications_UserID ON Notifications(UserID);
CREATE INDEX IX_Notifications_IsRead ON Notifications(IsRead);
CREATE INDEX IX_Notifications_CreatedAt ON Notifications(CreatedAt);

-- ============================================
-- INSERT DEFAULT DATA
-- ============================================

-- Insert Default Roles
INSERT INTO Roles (RoleName, Description) VALUES
('Admin', 'System Administrator with full access'),
('CarOwner', 'Car owner who can list and manage their cars'),
('Customer', 'Customer who can book cars'),
('Guest', 'Guest user with limited access');

-- Insert Default Payment Methods
INSERT INTO PaymentMethods (MethodName, Description) VALUES
('Cash', 'Cash payment'),
('Credit Card', 'Credit card payment'),
('Debit Card', 'Debit card payment'),
('Bank Transfer', 'Bank transfer payment'),
('E-Wallet', 'E-wallet payment (Momo, ZaloPay, etc.)');

-- Insert Default Car Categories
INSERT INTO CarCategories (CategoryName, Description) VALUES
('Sedan', 'Standard sedan cars'),
('SUV', 'Sport Utility Vehicles'),
('Hatchback', 'Hatchback cars'),
('Minivan', 'Family minivans'),
('Luxury', 'Luxury and premium cars'),
('Electric', 'Electric vehicles'),
('Pickup', 'Pickup trucks');

-- Insert Default Car Brands
INSERT INTO CarBrands (BrandName, Country) VALUES
('Toyota', 'Japan'),
('Honda', 'Japan'),
('Ford', 'USA'),
('Hyundai', 'South Korea'),
('Mazda', 'Japan'),
('Kia', 'South Korea'),
('Mercedes-Benz', 'Germany'),
('BMW', 'Germany'),
('Vinfast', 'Vietnam');

-- Insert System Settings
INSERT INTO SystemSettings (SettingKey, SettingValue, Description, Category) VALUES
('BookingCancellationHours', '24', 'Hours before pickup to allow free cancellation', 'Booking'),
('LateReturnPenaltyPerHour', '50000', 'Penalty amount per hour for late returns (VND)', 'Penalty'),
('TaxRate', '10', 'Tax rate percentage for bookings', 'Billing'),
('MinBookingHours', '4', 'Minimum booking duration in hours', 'Booking'),
('MaxBookingDays', '30', 'Maximum booking duration in days', 'Booking');

GO

-- ============================================
-- STORED PROCEDURES
-- ============================================

-- Procedure to check car availability
CREATE PROCEDURE sp_CheckCarAvailability
    @CarID INT,
    @StartDate DATETIME,
    @EndDate DATETIME
AS
BEGIN
    SELECT 
        CASE 
            WHEN EXISTS (
                SELECT 1 FROM Bookings 
                WHERE CarID = @CarID 
                AND Status IN ('Pending', 'Approved')
                AND (
                    (@StartDate BETWEEN PickupDate AND ReturnDate)
                    OR (@EndDate BETWEEN PickupDate AND ReturnDate)
                    OR (PickupDate BETWEEN @StartDate AND @EndDate)
                )
            ) THEN 0
            WHEN EXISTS (
                SELECT 1 FROM Cars 
                WHERE CarID = @CarID 
                AND Status != 'Available'
            ) THEN 0
            ELSE 1
        END AS IsAvailable
END
GO

-- Procedure to calculate booking total
CREATE PROCEDURE sp_CalculateBookingTotal
    @CarID INT,
    @PickupDate DATETIME,
    @ReturnDate DATETIME,
    @TotalAmount DECIMAL(10,2) OUTPUT
AS
BEGIN
    DECLARE @PricePerDay DECIMAL(10,2)
    DECLARE @TotalDays INT
    DECLARE @TaxRate DECIMAL(5,2)
    
    SELECT @PricePerDay = PricePerDay FROM Cars WHERE CarID = @CarID
    SET @TotalDays = DATEDIFF(DAY, @PickupDate, @ReturnDate)
    
    SELECT @TaxRate = CAST(SettingValue AS DECIMAL(5,2)) 
    FROM SystemSettings 
    WHERE SettingKey = 'TaxRate'
    
    SET @TotalAmount = (@PricePerDay * @TotalDays) * (1 + @TaxRate / 100)
END
GO

-- Procedure to get revenue report
CREATE PROCEDURE sp_GetRevenueReport
    @StartDate DATETIME,
    @EndDate DATETIME
AS
BEGIN
    SELECT 
        CONVERT(DATE, p.PaymentDate) AS PaymentDate,
        COUNT(DISTINCT b.BookingID) AS TotalBookings,
        SUM(p.Amount) AS TotalRevenue,
        AVG(p.Amount) AS AverageRevenue,
        COUNT(DISTINCT b.CarID) AS CarsRented
    FROM Payments p
    INNER JOIN Bookings b ON p.BookingID = b.BookingID
    WHERE p.PaymentDate BETWEEN @StartDate AND @EndDate
    AND p.Status = 'Paid'
    GROUP BY CONVERT(DATE, p.PaymentDate)
    ORDER BY PaymentDate DESC
END
GO

-- Procedure to get car usage statistics
CREATE PROCEDURE sp_GetCarUsageStats
    @CarID INT = NULL,
    @StartDate DATETIME,
    @EndDate DATETIME
AS
BEGIN
    SELECT 
        c.CarID,
        c.LicensePlate,
        cb.BrandName,
        cm.ModelName,
        COUNT(b.BookingID) AS TotalBookings,
        SUM(b.TotalDays) AS TotalDaysRented,
        SUM(b.TotalAmount) AS TotalRevenue,
        AVG(CAST(r.Rating AS FLOAT)) AS AverageRating
    FROM Cars c
    INNER JOIN CarModels cm ON c.ModelID = cm.ModelID
    INNER JOIN CarBrands cb ON cm.BrandID = cb.BrandID
    LEFT JOIN Bookings b ON c.CarID = b.CarID 
        AND b.Status = 'Completed'
        AND b.PickupDate BETWEEN @StartDate AND @EndDate
    LEFT JOIN Reviews r ON c.CarID = r.CarID
    WHERE (@CarID IS NULL OR c.CarID = @CarID)
    GROUP BY c.CarID, c.LicensePlate, cb.BrandName, cm.ModelName
    ORDER BY TotalRevenue DESC
END
GO

-- ============================================
-- VIEWS FOR REPORTING
-- ============================================

-- View for active bookings
CREATE VIEW vw_ActiveBookings AS
SELECT 
    b.BookingID,
    b.BookingReference,
    c.LicensePlate,
    cb.BrandName,
    cm.ModelName,
    u.FullName AS CustomerName,
    u.Email AS CustomerEmail,
    b.PickupDate,
    b.ReturnDate,
    b.TotalAmount,
    b.Status
FROM Bookings b
INNER JOIN Cars c ON b.CarID = c.CarID
INNER JOIN CarModels cm ON c.ModelID = cm.ModelID
INNER JOIN CarBrands cb ON cm.BrandID = cb.BrandID
INNER JOIN Users u ON b.CustomerID = u.UserID
WHERE b.Status IN ('Pending', 'Approved');
GO

-- View for available cars
CREATE VIEW vw_AvailableCars AS
SELECT 
    c.CarID,
    c.LicensePlate,
    cb.BrandName,
    cm.ModelName,
    cc.CategoryName,
    c.PricePerDay,
    c.Seats,
    c.FuelType,
    c.Transmission,
    c.Location,
    u.FullName AS OwnerName,
    u.PhoneNumber AS OwnerPhone
FROM Cars c
INNER JOIN CarModels cm ON c.ModelID = cm.ModelID
INNER JOIN CarBrands cb ON cm.BrandID = cb.BrandID
INNER JOIN CarCategories cc ON c.CategoryID = cc.CategoryID
INNER JOIN Users u ON c.OwnerID = u.UserID
WHERE c.Status = 'Available' AND c.IsVerified = 1;
GO

-- View for payment summary
CREATE VIEW vw_PaymentSummary AS
SELECT 
    p.PaymentID,
    p.PaymentReference,
    b.BookingReference,
    u.FullName AS CustomerName,
    p.Amount,
    p.PaymentDate,
    p.Status,
    pm.MethodName AS PaymentMethod
FROM Payments p
INNER JOIN Bookings b ON p.BookingID = b.BookingID
INNER JOIN Users u ON b.CustomerID = u.UserID
INNER JOIN PaymentMethods pm ON p.PaymentMethodID = pm.PaymentMethodID;
GO

PRINT 'Database schema created successfully!';
PRINT 'Total Tables Created: 32';
PRINT 'Total Views Created: 3';
PRINT 'Total Stored Procedures Created: 4';
PRINT 'Note: Users now have direct RoleID reference - UserRoles and Permissions tables removed';
GO
