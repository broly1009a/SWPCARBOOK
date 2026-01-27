package model;

import java.sql.Timestamp;

public class CarAvailability {

    private int availabilityId;
    private int carId;
    private Timestamp startDate;
    private Timestamp endDate;
    private boolean isAvailable;
    private String reason;
    private Timestamp createdAt;

    public CarAvailability() {
    }

    public CarAvailability(int availabilityId, int carId, Timestamp startDate,
                           Timestamp endDate, boolean isAvailable,
                           String reason, Timestamp createdAt) {
        this.availabilityId = availabilityId;
        this.carId = carId;
        this.startDate = startDate;
        this.endDate = endDate;
        this.isAvailable = isAvailable;
        this.reason = reason;
        this.createdAt = createdAt;
    }

    public int getAvailabilityId() {
        return availabilityId;
    }

    public void setAvailabilityId(int availabilityId) {
        this.availabilityId = availabilityId;
    }

    public int getCarId() {
        return carId;
    }

    public void setCarId(int carId) {
        this.carId = carId;
    }

    public Timestamp getStartDate() {
        return startDate;
    }

    public void setStartDate(Timestamp startDate) {
        this.startDate = startDate;
    }

    public Timestamp getEndDate() {
        return endDate;
    }

    public void setEndDate(Timestamp endDate) {
        this.endDate = endDate;
    }

    public boolean isAvailable() {
        return isAvailable;
    }

    public void setAvailable(boolean available) {
        isAvailable = available;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}