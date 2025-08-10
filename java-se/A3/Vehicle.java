// 2. Create a class called Vehicle that contains the following fields: make, model, and year.
public class Vehicle {
    public Vehicle(String make, String model, int year) {
        this.make = make;
        this.model = model;
        this.year = year;
    }

    private String make;
    private String model;
    private int year;

    public String getMake() {
        return make;
    }
    public String getModel() {
        return model;
    }
    public int getYear() {
        return year;
    }
}