package controller;

import dal.CarDAO;
import model.Car;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * CarDetailServlet - Handles car detail view
 */
@WebServlet(name = "CarDetailServlet", urlPatterns = {"/car-detail"})
public class CarDetailServlet extends HttpServlet {

    private CarDAO carDAO = new CarDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String carIdStr = request.getParameter("id");
            
            if (carIdStr == null || carIdStr.isEmpty()) {
                response.sendRedirect("cars");
                return;
            }
            
            int carId = Integer.parseInt(carIdStr);
            Car car = carDAO.getCarById(carId);
            
            if (car == null) {
                request.setAttribute("error", "Không tìm thấy xe với ID: " + carId);
                response.sendRedirect("cars");
                return;
            }
            
            request.setAttribute("car", car);
            request.getRequestDispatcher("car-single.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID xe không hợp lệ");
            response.sendRedirect("cars");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tải thông tin xe: " + e.getMessage());
            response.sendRedirect("cars");
        }
    }
}
