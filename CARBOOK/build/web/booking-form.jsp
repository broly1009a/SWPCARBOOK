<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt xe - CarBook</title>
    <link href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,500,600,700,800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/open-iconic-bootstrap.min.css">
    <link rel="stylesheet" href="css/animate.css">
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/owl.theme.default.min.css">
    <link rel="stylesheet" href="css/magnific-popup.css">
    <link rel="stylesheet" href="css/aos.css">
    <link rel="stylesheet" href="css/ionicons.min.css">
    <link rel="stylesheet" href="css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="css/jquery.timepicker.css">
    <link rel="stylesheet" href="css/flaticon.css">
    <link rel="stylesheet" href="css/icomoon.css">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <%@ include file="includes/navbar.jsp" %>
    
    <section class="ftco-section">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h2>Đặt xe</h2>
                    
                    <c:if test="${empty car}">
                        <div class="alert alert-danger">
                            <h4>Lỗi!</h4>
                            <p>Không thể tải thông tin xe. Vui lòng thử lại.</p>
                            <a href="cars" class="btn btn-primary">Quay lại danh sách xe</a>
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty car}">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>
                    <c:if test="${not empty sessionScope.success}">
                        <div class="alert alert-success">${sessionScope.success}</div>
                        <c:remove var="success" scope="session"/>
                    </c:if>
                    
                    <div class="row">
                        <div class="col-md-8">
                            <form action="booking" method="post">
                                <input type="hidden" name="action" value="create">
                                <input type="hidden" name="carId" value="${car.carId}">
                                
                                <div class="card mb-3">
                                    <div class="card-header">
                                        <h5>Thông tin xe</h5>
                                    </div>
                                    <div class="card-body">
                                        <p><strong>Biển số:</strong> ${car.licensePlate}</p>
                                        <p><strong>Màu sắc:</strong> ${car.color}</p>
                                        <p><strong>Số chỗ:</strong> ${car.seats}</p>
                                        <p><strong>Nhiên liệu:</strong> ${car.fuelType}</p>
                                        <p><strong>Hộp số:</strong> ${car.transmission}</p>
                                        <c:if test="${not empty car.model && not empty car.model.brand}">
                                            <p><strong>Xe:</strong> ${car.model.brand.brandName} ${car.model.modelName}</p>
                                        </c:if>
                                    </div>
                                </div>
                                
                                <div class="card mb-3">
                                    <div class="card-header">
                                        <h5>Thời gian thuê</h5>
                                    </div>
                                    <div class="card-body">
                                        <div class="form-group">
                                            <label>Ngày nhận xe <span class="text-danger">*</span></label>
                                            <input type="datetime-local" class="form-control" name="pickupDate" required>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label>Ngày trả xe <span class="text-danger">*</span></label>
                                            <input type="datetime-local" class="form-control" name="returnDate" required>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label>Địa điểm nhận xe</label>
                                            <input type="text" class="form-control" name="pickupLocation" placeholder="Nhập địa điểm nhận xe">
                                        </div>
                                        
                                        <div class="form-group">
                                            <label>Địa điểm trả xe</label>
                                            <input type="text" class="form-control" name="returnLocation" placeholder="Nhập địa điểm trả xe">
                                        </div>
                                        
                                        <div class="form-group">
                                            <label>Ghi chú</label>
                                            <textarea class="form-control" name="notes" rows="3" placeholder="Ghi chú thêm (nếu có)"></textarea>
                                        </div>
                                    </div>
                                </div>
                                
                                <button type="submit" class="btn btn-primary btn-lg btn-block">Xác nhận đặt xe</button>
                                <a href="cars" class="btn btn-secondary btn-lg btn-block">Hủy</a>
                            </form>
                        </div>
                        
                        <div class="col-md-4">
                            <div class="card">
                                <div class="card-header">
                                    <h5>Thông tin giá</h5>
                                </div>
                                <div class="card-body">
                                    <p><strong>Giá thuê:</strong> 
                                        <c:choose>
                                            <c:when test="${not empty car.pricePerDay}">
                                                <fmt:formatNumber value="${car.pricePerDay}" type="currency" currencySymbol="₫"/>/ngày
                                            </c:when>
                                            <c:otherwise>
                                                Liên hệ
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                    <p><small class="text-muted">* Thuế 10% sẽ được tính vào tổng tiền</small></p>
                                    <p><small class="text-muted">* Tổng tiền sẽ được tính sau khi chọn ngày</small></p>
                                </div>
                            </div>
                            
                            <div class="card mt-3">
                                <div class="card-header">
                                    <h5>Chính sách</h5>
                                </div>
                                <div class="card-body">
                                    <ul class="list-unstyled">
                                        <li>✓ Hủy miễn phí trước 24h</li>
                                        <li>✓ Bảo hiểm toàn diện</li>
                                        <li>✓ Hỗ trợ 24/7</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    </c:if>
                </div>
            </div>
        </div>
    </section>
    
    <%@ include file="includes/footer.jsp" %>
    
    <script src="js/jquery.min.js"></script>
    <script src="js/jquery-migrate-3.0.1.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.easing.1.3.js"></script>
    <script src="js/jquery.waypoints.min.js"></script>
    <script src="js/jquery.stellar.min.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/jquery.magnific-popup.min.js"></script>
    <script src="js/aos.js"></script>
    <script src="js/jquery.animateNumber.min.js"></script>
    <script src="js/bootstrap-datepicker.js"></script>
    <script src="js/jquery.timepicker.min.js"></script>
    <script src="js/scrollax.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
