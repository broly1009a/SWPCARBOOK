package controller;

import dal.CarModelDAO;
import dal.CarBrandDAO;
import model.CarModel;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.gson.Gson;

/**
 * CarModelServlet - AJAX handler for car models
 */
@WebServlet(name = "CarModelServlet", urlPatterns = {"/car-models"})
public class CarModelServlet extends HttpServlet {

    private CarModelDAO modelDAO = new CarModelDAO();
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        String brandIdStr = request.getParameter("brandId");
        
        if ("getByBrand".equals(action) && brandIdStr != null) {
            int brandId = Integer.parseInt(brandIdStr);
            List<CarModel> models = modelDAO.getModelsByBrandId(brandId);
            
            String json = gson.toJson(models);
            response.getWriter().write(json);
        } else {
            // Return all models
            List<CarModel> models = modelDAO.getAllModels();
            String json = gson.toJson(models);
            response.getWriter().write(json);
        }
    }
}
