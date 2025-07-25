package com.mycompany.app;

// Factory class
public class VehicleFactory {
    public static Vehicle getVehicle(String vehicleType) {
        if (vehicleType.equalsIgnoreCase("car")) {
            return new Car();
        } else if (vehicleType.equalsIgnoreCase("truck")) {
            return new Truck();
        } else if (vehicleType.equalsIgnoreCase("bike")) {
            return new Bike();
        }
        return null;
    }
}