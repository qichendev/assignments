// 3. Create a class called Truck that extends Vehicle and contains the following fields: maxPayload and bedLength.
public class Truck extends Vehicle {
    public Truck(String make, String model, int year, double maxPayload, double bedLength) {
        super(make, model, year);
        this.maxPayload = maxPayload;
        this.bedLength = bedLength;
    }
    private double maxPayload;
    private double bedLength;

    public double getMaxPayload() {
        return maxPayload;
    }
    public double getBedLength() {
        return bedLength;
    }
}