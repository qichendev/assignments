// 4. Create a class called Car that extends Vehicle and contains the following fields: numDoors and numPassengers.
public class Car extends Vehicle {
    public Car(String make, String model, int year, int numDoors, int numPassengers) {
        super(make, model, year);
        this.numDoors = numDoors;
        this.numPassengers = numPassengers;
    }
    private int numDoors;
    private int numPassengers;

    public int getNumDoors() {
        return numDoors;
    }
    public int getNumPassengers() {
        return numPassengers;
    }
}