package dal;

import model.CarAvailability;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CarAvailabilityDAO extends DBContext {

    public List<CarAvailability> getAvailabilityByCarId(int carId) {
        List<CarAvailability> list = new ArrayList<>();
        String sql = "SELECT * FROM CarAvailability WHERE CarID = ? ORDER BY StartDate";

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, carId);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                list.add(extractAvailability(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error get availability by car: " + e.getMessage());
        }
        return list;
    }

    public boolean createAvailability(CarAvailability a) {
        String sql = "INSERT INTO CarAvailability (CarID, StartDate, EndDate, IsAvailable, Reason) "
                   + "VALUES (?, ?, ?, ?, ?)";

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, a.getCarId());
            stm.setTimestamp(2, a.getStartDate());
            stm.setTimestamp(3, a.getEndDate());
            stm.setBoolean(4, a.isAvailable());
            stm.setString(5, a.getReason());

            return stm.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error create availability: " + e.getMessage());
        }
        return false;
    }

    public boolean updateAvailability(CarAvailability a) {
        String sql = "UPDATE CarAvailability SET StartDate = ?, EndDate = ?, "
                   + "IsAvailable = ?, Reason = ? WHERE AvailabilityID = ?";

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setTimestamp(1, a.getStartDate());
            stm.setTimestamp(2, a.getEndDate());
            stm.setBoolean(3, a.isAvailable());
            stm.setString(4, a.getReason());
            stm.setInt(5, a.getAvailabilityId());

            return stm.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error update availability: " + e.getMessage());
        }
        return false;
    }

    public boolean deleteAvailability(int availabilityId) {
        String sql = "DELETE FROM CarAvailability WHERE AvailabilityID = ?";

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, availabilityId);
            return stm.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error delete availability: " + e.getMessage());
        }
        return false;
    }

    private CarAvailability extractAvailability(ResultSet rs) throws SQLException {
        CarAvailability a = new CarAvailability();
        a.setAvailabilityId(rs.getInt("AvailabilityID"));
        a.setCarId(rs.getInt("CarID"));
        a.setStartDate(rs.getTimestamp("StartDate"));
        a.setEndDate(rs.getTimestamp("EndDate"));
        a.setAvailable(rs.getBoolean("IsAvailable"));
        a.setReason(rs.getString("Reason"));
        a.setCreatedAt(rs.getTimestamp("CreatedAt"));
        return a;
    }
}
