// 1. Create a class called VehicleTest that contains a main method.
public class VehicleTest {
    public static void main(String[] args) {
        // 5. Create an array of Vehicle objects and add 5 different vehicles to the array.
        Vehicle[] vehicles = new Vehicle[]{
            new Car("Toyota", "Camry", 2024, 4, 5),
            new Truck("Ford", "F-150", 2024, 1000, 10),
            new Car("Mercedes", "C-Class", 2010, 4, 5),
            new Truck("Audi", "A4", 2015, 1000, 10),
            new Car("Volkswagen", "Golf", 2012, 4, 5)
        };
        // 6. Iterate through the array and print the make, model, year, and type of each vehicle.
        for (Vehicle vehicle : vehicles) {
            System.out.println(vehicle.getMake() + ", " + vehicle.getModel() + " " + vehicle.getYear() + " type: " + vehicle.getClass().getSimpleName());
        }
    }
}