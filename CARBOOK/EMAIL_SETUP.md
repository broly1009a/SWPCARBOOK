# Hướng dẫn cấu hình Email Service cho CARBOOK

## 1. Cấu hình Gmail SMTP

### Bước 1: Tạo App Password cho Gmail

1. Đăng nhập vào tài khoản Gmail của bạn
2. Truy cập [Google Account Security](https://myaccount.google.com/security)
3. Bật **2-Step Verification** (nếu chưa bật)
4. Sau khi bật 2-Step Verification, tìm **App passwords**
5. Chọn **Select app** → **Other (Custom name)**
6. Nhập tên: "CARBOOK Mail Service"
7. Click **Generate**
8. Copy mã 16 ký tự được tạo ra

### Bước 2: Cấu hình trong EmailService.java

Mở file `src/java/utils/EmailService.java` và cập nhật:

```java
private static final String SMTP_HOST = "smtp.gmail.com";
private static final String SMTP_PORT = "587";
private static final String SMTP_USERNAME = "your-email@gmail.com"; // Thay bằng email của bạn
private static final String SMTP_PASSWORD = "xxxx xxxx xxxx xxxx"; // Thay bằng App Password vừa tạo
private static final String FROM_EMAIL = "your-email@gmail.com"; // Thay bằng email của bạn
private static final String FROM_NAME = "CARBOOK - Car Rental System";
```

## 2. Thêm JavaMail Library vào Project

### Cách 1: Tải thủ công

1. Tải các file JAR sau:
   - [javax.mail.jar](https://repo1.maven.org/maven2/com/sun/mail/javax.mail/1.6.2/javax.mail-1.6.2.jar)
   - [activation.jar](https://repo1.maven.org/maven2/javax/activation/activation/1.1/activation-1.1.jar)

2. Copy vào thư mục `lib` của project

3. Trong NetBeans:
   - Right-click vào **Libraries** trong project
   - Chọn **Add JAR/Folder**
   - Chọn 2 file JAR vừa tải

### Cách 2: Sử dụng Maven (nếu project dùng Maven)

Thêm vào `pom.xml`:

```xml
<dependency>
    <groupId>com.sun.mail</groupId>
    <artifactId>javax.mail</artifactId>
    <version>1.6.2</version>
</dependency>
```

## 3. Các chức năng Email đã tích hợp

### 3.1 Đăng ký tài khoản
```java
UserDAO userDAO = new UserDAO();
User newUser = new User();
// ... set user info ...
boolean success = userDAO.register(newUser);
// Tự động gửi email chào mừng
```

### 3.2 Quên mật khẩu
```java
UserDAO userDAO = new UserDAO();
String resetToken = userDAO.sendPasswordResetEmail("user@example.com");
// Gửi email với link reset password
```

### 3.3 Reset mật khẩu với token
```java
UserDAO userDAO = new UserDAO();
boolean success = userDAO.resetPasswordWithToken(token, newPassword);
// Tự động gửi email xác nhận đã đổi mật khẩu
```

### 3.4 Đổi mật khẩu
```java
UserDAO userDAO = new UserDAO();
boolean success = userDAO.changePassword(userId, oldPassword, newPassword);
// Tự động gửi email xác nhận
```

## 4. Template Email có sẵn

### ✅ Welcome Email
- Gửi khi đăng ký thành công
- Chào mừng người dùng mới
- Hướng dẫn bắt đầu sử dụng

### ✅ Verification Email
- Gửi mã OTP 6 số
- Xác thực email khi đăng ký
- Hiệu lực 15 phút

### ✅ Password Reset Email
- Link reset mật khẩu
- Hiệu lực 1 giờ
- HTML template đẹp mắt

### ✅ Password Changed Email
- Xác nhận mật khẩu đã thay đổi
- Cảnh báo bảo mật

## 5. Tùy chỉnh Template Email

Mở file `EmailService.java` và chỉnh sửa các phương thức:
- `buildWelcomeEmailHTML()`
- `buildVerificationEmailHTML()`
- `buildPasswordResetEmailHTML()`
- `buildPasswordChangedEmailHTML()`

## 6. Test Email Service

Tạo file test:

```java
public class TestEmail {
    public static void main(String[] args) {
        // Test send welcome email
        boolean sent = EmailService.sendWelcomeEmail(
            "test@example.com", 
            "TestUser"
        );
        
        System.out.println("Email sent: " + sent);
    }
}
```

## 7. Xử lý lỗi thường gặp

### Lỗi: "Authentication failed"
- Kiểm tra lại SMTP_USERNAME và SMTP_PASSWORD
- Đảm bảo đã bật 2-Step Verification
- Tạo lại App Password

### Lỗi: "Could not connect to SMTP host"
- Kiểm tra kết nối internet
- Kiểm tra firewall/antivirus có chặn port 587 không

### Lỗi: ClassNotFoundException - javax.mail
- Thêm lại JavaMail library vào project
- Clean and Build project

## 8. Bảo mật

⚠️ **QUAN TRỌNG:**
- KHÔNG commit SMTP_PASSWORD vào Git
- Sử dụng environment variables cho production
- Thay đổi App Password định kỳ

```java
// Nên dùng environment variables:
private static final String SMTP_PASSWORD = System.getenv("EMAIL_PASSWORD");
```

## 9. Nâng cấp cho Production

- Sử dụng email marketing service (SendGrid, Mailgun, AWS SES)
- Implement queue system cho email
- Thêm retry mechanism
- Log email history vào database
- Template engine (Thymeleaf, FreeMarker)

---

**Liên hệ hỗ trợ:** support@carbook.com
