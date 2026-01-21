public class Car {
    private final String engine;
    private final String color;
    private final int wheels;

    Car(String engine, String color, int wheels) {
        this.engine = engine;
        this.color = color;
        this.wheels = wheels;
    }

    public String getEngine() {
        return engine;
    }

    public String getColor() {
        return color;
    }

    public int getWheels() {
        return wheels;
    }

    public String toString() {
        return "Car(engine=" + engine + ", color=" + color + ", wheels=" + wheels + ")";
    }
}