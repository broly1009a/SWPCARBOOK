
USE CRMS_DB;
GO

-- Check if GoogleID column exists
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Users') AND name = 'GoogleID')
BEGIN
    ALTER TABLE Users ADD GoogleID NVARCHAR(255) NULL;
    PRINT 'GoogleID column added to Users table successfully.';
END
ELSE
BEGIN
    PRINT 'GoogleID column already exists in Users table.';
END
GO

-- Optional: Update PasswordHash to allow NULL for Google users
IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Users') AND name = 'PasswordHash' AND is_nullable = 0)
BEGIN
    ALTER TABLE Users ALTER COLUMN PasswordHash NVARCHAR(255) NULL;
    PRINT 'PasswordHash column updated to allow NULL values for Google users.';
END
GO

PRINT 'Database update completed for Google OAuth support.';