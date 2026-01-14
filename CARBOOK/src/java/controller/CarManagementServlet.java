package controller;

import dal.CarDAO;
import dal.CarBrandDAO;
import dal.CarModelDAO;
import dal.CarCategoryDAO;
import model.Car;
import model.CarBrand;
import model.CarModel;
import model.CarCategory;
import model.User;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * CarManagementServlet - Handles car CRUD operations
 */
@WebServlet(name = "CarManagementServlet", urlPatterns = {"/car-management"})
public class CarManagementServlet extends HttpServlet {

    private CarDAO carDAO = new CarDAO();
    private CarBrandDAO brandDAO = new CarBrandDAO();
    private CarModelDAO modelDAO = new CarModelDAO();
    private CarCategoryDAO categoryDAO = new CarCategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "list":
                listCars(request, response, user);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteCar(request, response, user);
                break;
            case "view":
                viewCar(request, response);
                break;
            case "verify":
                verifyCar(request, response, user);
                break;
            default:
                listCars(request, response, user);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("create".equals(action)) {
            createCar(request, response, user);
        } else if ("update".equals(action)) {
            updateCar(request, response, user);
        } else if ("updateStatus".equals(action)) {
            updateCarStatus(request, response);
        }
    }

    private void listCars(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        List<Car> cars;
        
        // Admin sees all cars, CarOwner sees only their cars
        if (user.getRoleId() == 1) { // Admin
            cars = carDAO.getAllCars();
        } else if (user.getRoleId() == 2) { // CarOwner
            cars = carDAO.getCarsByOwnerId(user.getUserId());
        } else {
            cars = carDAO.getAvailableCars();
        }
        
        request.setAttribute("cars", cars);
        request.getRequestDispatcher("car-management.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<CarBrand> brands = brandDAO.getAllBrands();
        List<CarCategory> categories = categoryDAO.getAllCategories();
        
        request.setAttribute("brands", brands);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("car-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int carId = Integer.parseInt(request.getParameter("id"));
        Car car = carDAO.getCarById(carId);
        
        if (car == null) {
            request.setAttribute("error", "Không tìm thấy xe");
            response.sendRedirect("car-management");
            return;
        }
        
        List<CarBrand> brands = brandDAO.getAllBrands();
        List<CarCategory> categories = categoryDAO.getAllCategories();
        List<CarModel> models = modelDAO.getModelsByBrandId(car.getModelId());
        
        request.setAttribute("car", car);
        request.setAttribute("brands", brands);
        request.setAttribute("categories", categories);
        request.setAttribute("models", models);
        request.getRequestDispatcher("car-form.jsp").forward(request, response);
    }

    private void viewCar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int carId = Integer.parseInt(request.getParameter("id"));
        Car car = carDAO.getCarById(carId);
        
        if (car == null) {
            request.setAttribute("error", "Không tìm thấy xe");
            response.sendRedirect("car-management");
            return;
        }
        
        request.setAttribute("car", car);
        request.getRequestDispatcher("car-detail.jsp").forward(request, response);
    }

    private void createCar(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        try {
            Car car = new Car();
            car.setOwnerId(user.getUserId());
            car.setModelId(Integer.parseInt(request.getParameter("modelId")));
            car.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
            car.setLicensePlate(request.getParameter("licensePlate"));
            car.setVinNumber(request.getParameter("vinNumber"));
            car.setColor(request.getParameter("color"));
            car.setSeats(Integer.parseInt(request.getParameter("seats")));
            car.setFuelType(request.getParameter("fuelType"));
            car.setTransmission(request.getParameter("transmission"));
            
            String mileageStr = request.getParameter("mileage");
            if (mileageStr != null && !mileageStr.isEmpty()) {
                car.setMileage(new BigDecimal(mileageStr));
            }
            
            car.setPricePerDay(new BigDecimal(request.getParameter("pricePerDay")));
            
            String pricePerHourStr = request.getParameter("pricePerHour");
            if (pricePerHourStr != null && !pricePerHourStr.isEmpty()) {
                car.setPricePerHour(new BigDecimal(pricePerHourStr));
            }
            
            car.setLocation(request.getParameter("location"));
            car.setDescription(request.getParameter("description"));
            car.setFeatures(request.getParameter("features"));
            
            String insuranceDate = request.getParameter("insuranceExpiryDate");
            if (insuranceDate != null && !insuranceDate.isEmpty()) {
                car.setInsuranceExpiryDate(Date.valueOf(insuranceDate));
            }
            
            String registrationDate = request.getParameter("registrationExpiryDate");
            if (registrationDate != null && !registrationDate.isEmpty()) {
                car.setRegistrationExpiryDate(Date.valueOf(registrationDate));
            }
            
            car.setStatus("Available");
            
            if (carDAO.createCar(car)) {
                request.setAttribute("success", "Thêm xe thành công");
                response.sendRedirect("car-management");
            } else {
                request.setAttribute("error", "Lỗi khi thêm xe");
                showAddForm(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi: " + e.getMessage());
            showAddForm(request, response);
        }
    }

    private void updateCar(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        try {
            int carId = Integer.parseInt(request.getParameter("carId"));
            Car car = carDAO.getCarById(carId);
            
            if (car == null) {
                request.setAttribute("error", "Không tìm thấy xe");
                response.sendRedirect("car-management");
                return;
            }
            
            // Check ownership
            if (user.getRoleId() != 1 && car.getOwnerId() != user.getUserId()) {
                request.setAttribute("error", "Bạn không có quyền chỉnh sửa xe này");
                response.sendRedirect("car-management");
                return;
            }
            
            car.setModelId(Integer.parseInt(request.getParameter("modelId")));
            car.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
            car.setLicensePlate(request.getParameter("licensePlate"));
            car.setVinNumber(request.getParameter("vinNumber"));
            car.setColor(request.getParameter("color"));
            car.setSeats(Integer.parseInt(request.getParameter("seats")));
            car.setFuelType(request.getParameter("fuelType"));
            car.setTransmission(request.getParameter("transmission"));
            
            String mileageStr = request.getParameter("mileage");
            if (mileageStr != null && !mileageStr.isEmpty()) {
                car.setMileage(new BigDecimal(mileageStr));
            }
            
            car.setPricePerDay(new BigDecimal(request.getParameter("pricePerDay")));
            
            String pricePerHourStr = request.getParameter("pricePerHour");
            if (pricePerHourStr != null && !pricePerHourStr.isEmpty()) {
                car.setPricePerHour(new BigDecimal(pricePerHourStr));
            }
            
            car.setLocation(request.getParameter("location"));
            car.setDescription(request.getParameter("description"));
            car.setFeatures(request.getParameter("features"));
            
            String insuranceDate = request.getParameter("insuranceExpiryDate");
            if (insuranceDate != null && !insuranceDate.isEmpty()) {
                car.setInsuranceExpiryDate(Date.valueOf(insuranceDate));
            }
            
            String registrationDate = request.getParameter("registrationExpiryDate");
            if (registrationDate != null && !registrationDate.isEmpty()) {
                car.setRegistrationExpiryDate(Date.valueOf(registrationDate));
            }
            
            if (carDAO.updateCar(car)) {
                request.setAttribute("success", "Cập nhật xe thành công");
                response.sendRedirect("car-management");
            } else {
                request.setAttribute("error", "Lỗi khi cập nhật xe");
                showEditForm(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi: " + e.getMessage());
            showEditForm(request, response);
        }
    }

    private void updateCarStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int carId = Integer.parseInt(request.getParameter("carId"));
        String status = request.getParameter("status");
        
        if (carDAO.updateCarStatus(carId, status)) {
            response.getWriter().write("{\"success\": true}");
        } else {
            response.getWriter().write("{\"success\": false}");
        }
    }

    private void deleteCar(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        int carId = Integer.parseInt(request.getParameter("id"));
        Car car = carDAO.getCarById(carId);
        
        if (car == null) {
            request.setAttribute("error", "Không tìm thấy xe");
            response.sendRedirect("car-management");
            return;
        }
        
        // Check ownership
        if (user.getRoleId() != 1 && car.getOwnerId() != user.getUserId()) {
            request.setAttribute("error", "Bạn không có quyền xóa xe này");
            response.sendRedirect("car-management");
            return;
        }
        
        if (carDAO.deleteCar(carId)) {
            request.setAttribute("success", "Xóa xe thành công");
        } else {
            request.setAttribute("error", "Lỗi khi xóa xe");
        }
        
        response.sendRedirect("car-management");
    }

    private void verifyCar(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        // Only admin can verify cars
        if (user.getRoleId() != 1) {
            request.setAttribute("error", "Bạn không có quyền xác minh xe");
            response.sendRedirect("car-management");
            return;
        }
        
        int carId = Integer.parseInt(request.getParameter("id"));
        boolean isVerified = Boolean.parseBoolean(request.getParameter("verified"));
        
        if (carDAO.verifyCar(carId, isVerified)) {
            request.setAttribute("success", "Cập nhật trạng thái xác minh thành công");
        } else {
            request.setAttribute("error", "Lỗi khi cập nhật trạng thái xác minh");
        }
        
        response.sendRedirect("car-management");
    }
}
