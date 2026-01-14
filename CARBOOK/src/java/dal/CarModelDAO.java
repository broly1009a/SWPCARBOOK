package dal;

import model.CarModel;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * CarModelDAO - Data Access Object for Car Model management
 */
public class CarModelDAO extends DBContext {
    
    /**
     * Get all car models
     * @return List of all models
     */
    public List<CarModel> getAllModels() {
        List<CarModel> models = new ArrayList<>();
        String sql = "SELECT * FROM CarModels ORDER BY ModelName";
        
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            
            while (rs.next()) {
                models.add(extractModelFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting all models: " + e.getMessage());
        }
        return models;
    }
    
    /**
     * Get model by ID
     * @param modelId
     * @return CarModel object or null
     */
    public CarModel getModelById(int modelId) {
        String sql = "SELECT * FROM CarModels WHERE ModelID = ?";
        
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, modelId);
            ResultSet rs = stm.executeQuery();
            
            if (rs.next()) {
                return extractModelFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.out.println("Error getting model by ID: " + e.getMessage());
        }
        return null;
    }
    
    /**
     * Get models by brand ID
     * @param brandId
     * @return List of models for the brand
     */
    public List<CarModel> getModelsByBrandId(int brandId) {
        List<CarModel> models = new ArrayList<>();
        String sql = "SELECT * FROM CarModels WHERE BrandID = ? ORDER BY ModelName";
        
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, brandId);
            ResultSet rs = stm.executeQuery();
            
            while (rs.next()) {
                models.add(extractModelFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting models by brand ID: " + e.getMessage());
        }
        return models;
    }
    
    /**
     * Create a new model
     * @param model
     * @return true if successful, false otherwise
     */
    public boolean createModel(CarModel model) {
        String sql = "INSERT INTO CarModels (BrandID, ModelName, Year) VALUES (?, ?, ?)";
        
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, model.getBrandId());
            stm.setString(2, model.getModelName());
            stm.setInt(3, model.getYear());
            
            return stm.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error creating model: " + e.getMessage());
        }
        return false;
    }
    
    /**
     * Update model
     * @param model
     * @return true if successful, false otherwise
     */
    public boolean updateModel(CarModel model) {
        String sql = "UPDATE CarModels SET BrandID = ?, ModelName = ?, Year = ? WHERE ModelID = ?";
        
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, model.getBrandId());
            stm.setString(2, model.getModelName());
            stm.setInt(3, model.getYear());
            stm.setInt(4, model.getModelId());
            
            return stm.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error updating model: " + e.getMessage());
        }
        return false;
    }
    
    /**
     * Delete model
     * @param modelId
     * @return true if successful, false otherwise
     */
    public boolean deleteModel(int modelId) {
        String sql = "DELETE FROM CarModels WHERE ModelID = ?";
        
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, modelId);
            
            return stm.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error deleting model: " + e.getMessage());
        }
        return false;
    }
    
    /**
     * Extract CarModel object from ResultSet
     * @param rs
     * @return CarModel object
     * @throws SQLException
     */
    private CarModel extractModelFromResultSet(ResultSet rs) throws SQLException {
        CarModel model = new CarModel();
        model.setModelId(rs.getInt("ModelID"));
        model.setBrandId(rs.getInt("BrandID"));
        model.setModelName(rs.getString("ModelName"));
        model.setYear(rs.getInt("Year"));
        return model;
    }
}
