package dal;

import model.Booking;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/**
 * BookingDAO - Data Access Object for Booking management
 */
public class BookingDAO extends DBContext {
    
    /**
     * Get all bookings
     * @return List of all bookings
     */
    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM Bookings ORDER BY CreatedAt DESC";
        
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            
            while (rs.next()) {
                bookings.add(extractBookingFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting all bookings: " + e.getMessage());
        }
        return bookings;
    }
    
    /**
     * Get booking by ID
     * @param bookingId
     * @return Booking object or null
     */
    public Booking getBookingById(int bookingId) {
        String sql = "SELECT * FROM Bookings WHERE BookingID = ?";
        
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, bookingId);
            ResultSet rs = stm.executeQuery();
            
            if (rs.next()) {
                return extractBookingFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.out.println("Error getting booking by ID: " + e.getMessage());
        }
        return null;
    }
    
    /**
     * Get booking by reference
     * @param bookingReference
     * @return Booking object or null
     */
    public Booking getBookingByReference(String bookingReference) {
        String sql = "SELECT * FROM Bookings WHERE BookingReference = ?";
        
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, bookingReference);
            ResultSet rs = stm.executeQuery();
            
            if (rs.next()) {
                return extractBookingFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.out.println("Error getting booking by reference: " + e.getMessage());
        }
        return null;
    }
    
    /**
     * Get bookings by customer ID
     * @param customerId
     * @return List of customer's bookings
     */
    public List<Booking> getBookingsByCustomerId(int customerId) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM Bookings WHERE CustomerID = ? ORDER BY CreatedAt DESC";
        
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, customerId);
            ResultSet rs = stm.executeQuery();
            
            while (rs.next()) {
                bookings.add(extractBookingFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting bookings by customer ID: " + e.getMessage());
        }
        return bookings;
    }
    
    /**
     * Get bookings by car ID
     * @param carId
     * @return List of car's bookings
     */
    public List<Booking> getBookingsByCarId(int carId) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM Bookings WHERE CarID = ? ORDER BY PickupDate DESC";
        
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, carId);
            ResultSet rs = stm.executeQuery();
            
            while (rs.next()) {
                bookings.add(extractBookingFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting bookings by car ID: " + e.getMessage());
        }
        return bookings;
    }
    
    /**
     * Get bookings by status
     * @param status
     * @return List of bookings with the status
     */
    public List<Booking> getBookingsByStatus(String status) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM Bookings WHERE Status = ? ORDER BY CreatedAt DESC";
        
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, status);
            ResultSet rs = stm.executeQuery();
            
            while (rs.next()) {
                bookings.add(extractBookingFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting bookings by status: " + e.getMessage());
        }
        return bookings;
    }
    
    /**
     * Get pending bookings
     * @return List of pending bookings
     */
    public List<Booking> getPendingBookings() {
        return getBookingsByStatus("Pending");
    }
    
    /**
     * Get active bookings (Pending or Approved)
     * @return List of active bookings
     */
    public List<Booking> getActiveBookings() {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM Bookings WHERE Status IN ('Pending', 'Approved') ORDER BY PickupDate";
        
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            
            while (rs.next()) {
                bookings.add(extractBookingFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting active bookings: " + e.getMessage());
        }
        return bookings;
    }
    
    /**
     * Create a new booking
     * @param booking
     * @return booking ID if successful, -1 otherwise
     */
    public int createBooking(Booking booking) {
        String sql = "INSERT INTO Bookings (CarID, CustomerID, BookingReference, PickupDate, ReturnDate, " +
                     "PickupLocation, ReturnLocation, TotalDays, TotalHours, BasePrice, TaxAmount, DiscountAmount, " +
                     "TotalAmount, Status, Notes) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try {
            PreparedStatement stm = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            stm.setInt(1, booking.getCarId());
            stm.setInt(2, booking.getCustomerId());
            stm.setString(3, booking.getBookingReference());
            stm.setTimestamp(4, booking.getPickupDate());
            stm.setTimestamp(5, booking.getReturnDate());
            stm.setString(6, booking.getPickupLocation());
            stm.setString(7, booking.getReturnLocation());
            stm.setInt(8, booking.getTotalDays());
            stm.setInt(9, booking.getTotalHours());
            stm.setBigDecimal(10, booking.getBasePrice());
            stm.setBigDecimal(11, booking.getTaxAmount());
            stm.setBigDecimal(12, booking.getDiscountAmount());
            stm.setBigDecimal(13, booking.getTotalAmount());
            stm.setString(14, booking.getStatus());
            stm.setString(15, booking.getNotes());
            
            int affectedRows = stm.executeUpdate();
            if (affectedRows > 0) {
                ResultSet generatedKeys = stm.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error creating booking: " + e.getMessage());
        }
        return -1;
    }
    
    /**
     * Update booking
     * @param booking
     * @return true if successful, false otherwise
     */
    public boolean updateBooking(Booking booking) {
        String sql = "UPDATE Bookings SET CarID = ?, PickupDate = ?, ReturnDate = ?, PickupLocation = ?, " +
                     "ReturnLocation = ?, TotalDays = ?, TotalHours = ?, BasePrice = ?, TaxAmount = ?, " +
                     "DiscountAmount = ?, TotalAmount = ?, Status = ?, Notes = ?, UpdatedAt = GETDATE() " +
                     "WHERE BookingID = ?";
        
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, booking.getCarId());
            stm.setTimestamp(2, booking.getPickupDate());
            stm.setTimestamp(3, booking.getReturnDate());
            stm.setString(4, booking.getPickupLocation());
            stm.setString(5, booking.getReturnLocation());
            stm.setInt(6, booking.getTotalDays());
            stm.setInt(7, booking.getTotalHours());
            stm.setBigDecimal(8, booking.getBasePrice());
            stm.setBigDecimal(9, booking.getTaxAmount());
            stm.setBigDecimal(10, booking.getDiscountAmount());
            stm.setBigDecimal(11, booking.getTotalAmount());
            stm.setString(12, booking.getStatus());
            stm.setString(13, booking.getNotes());
            stm.setInt(14, booking.getBookingId());
            
            return stm.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error updating booking: " + e.getMessage());
        }
        return false;
    }
    
    /**
     * Update booking status
     * @param bookingId
     * @param status
     * @param userId User who changed the status
     * @return true if successful, false otherwise
     */
    public boolean updateBookingStatus(int bookingId, String status, int userId) {
        String sql = "UPDATE Bookings SET Status = ?, UpdatedAt = GETDATE()";
        
        if (status.equals("Approved")) {
            sql += ", ApprovedBy = ?, ApprovedAt = GETDATE()";
        } else if (status.equals("Cancelled")) {
            sql += ", CancelledBy = ?, CancelledAt = GETDATE()";
        }
        sql += " WHERE BookingID = ?";
        
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, status);
            
            if (status.equals("Approved") || status.equals("Cancelled")) {
                stm.setInt(2, userId);
                stm.setInt(3, bookingId);
            } else {
                stm.setInt(2, bookingId);
            }
            
            return stm.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error updating booking status: " + e.getMessage());
        }
        return false;
    }
    
    /**
     * Approve booking
     * @param bookingId
     * @param approvedBy
     * @return true if successful, false otherwise
     */
    public boolean approveBooking(int bookingId, int approvedBy) {
        return updateBookingStatus(bookingId, "Approved", approvedBy);
    }
    
    /**
     * Reject booking
     * @param bookingId
     * @param rejectionReason
     * @return true if successful, false otherwise
     */
    public boolean rejectBooking(int bookingId, String rejectionReason) {
        String sql = "UPDATE Bookings SET Status = 'Rejected', RejectionReason = ?, UpdatedAt = GETDATE() WHERE BookingID = ?";
        
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, rejectionReason);
            stm.setInt(2, bookingId);
            
            return stm.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error rejecting booking: " + e.getMessage());
        }
        return false;
    }
    
    /**
     * Cancel booking
     * @param bookingId
     * @param cancelledBy
     * @param cancellationReason
     * @return true if successful, false otherwise
     */
    public boolean cancelBooking(int bookingId, int cancelledBy, String cancellationReason) {
        String sql = "UPDATE Bookings SET Status = 'Cancelled', CancelledBy = ?, CancellationReason = ?, " +
                     "CancelledAt = GETDATE(), UpdatedAt = GETDATE() WHERE BookingID = ?";
        
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, cancelledBy);
            stm.setString(2, cancellationReason);
            stm.setInt(3, bookingId);
            
            return stm.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error cancelling booking: " + e.getMessage());
        }
        return false;
    }
    
    /**
     * Complete booking
     * @param bookingId
     * @return true if successful, false otherwise
     */
    public boolean completeBooking(int bookingId) {
        return updateBookingStatus(bookingId, "Completed", 0);
    }
    
    /**
     * Delete booking
     * @param bookingId
     * @return true if successful, false otherwise
     */
    public boolean deleteBooking(int bookingId) {
        String sql = "DELETE FROM Bookings WHERE BookingID = ?";
        
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, bookingId);
            
            return stm.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error deleting booking: " + e.getMessage());
        }
        return false;
    }
    
    /**
     * Generate unique booking reference
     * @return Booking reference string
     */
    public String generateBookingReference() {
        return "BK" + System.currentTimeMillis();
    }
    
    /**
     * Extract Booking object from ResultSet
     * @param rs
     * @return Booking object
     * @throws SQLException
     */
    private Booking extractBookingFromResultSet(ResultSet rs) throws SQLException {
        Booking booking = new Booking();
        booking.setBookingId(rs.getInt("BookingID"));
        booking.setCarId(rs.getInt("CarID"));
        booking.setCustomerId(rs.getInt("CustomerID"));
        booking.setBookingReference(rs.getString("BookingReference"));
        booking.setPickupDate(rs.getTimestamp("PickupDate"));
        booking.setReturnDate(rs.getTimestamp("ReturnDate"));
        booking.setPickupLocation(rs.getString("PickupLocation"));
        booking.setReturnLocation(rs.getString("ReturnLocation"));
        booking.setTotalDays(rs.getInt("TotalDays"));
        booking.setTotalHours(rs.getInt("TotalHours"));
        booking.setBasePrice(rs.getBigDecimal("BasePrice"));
        booking.setTaxAmount(rs.getBigDecimal("TaxAmount"));
        booking.setDiscountAmount(rs.getBigDecimal("DiscountAmount"));
        booking.setTotalAmount(rs.getBigDecimal("TotalAmount"));
        booking.setStatus(rs.getString("Status"));
        booking.setApprovedBy(rs.getInt("ApprovedBy"));
        booking.setApprovedAt(rs.getTimestamp("ApprovedAt"));
        booking.setRejectionReason(rs.getString("RejectionReason"));
        booking.setCancellationReason(rs.getString("CancellationReason"));
        booking.setCancelledBy(rs.getInt("CancelledBy"));
        booking.setCancelledAt(rs.getTimestamp("CancelledAt"));
        booking.setNotes(rs.getString("Notes"));
        booking.setCreatedAt(rs.getTimestamp("CreatedAt"));
        booking.setUpdatedAt(rs.getTimestamp("UpdatedAt"));
        return booking;
    }
}
