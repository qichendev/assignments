public class CarBuilder {
    private String engine;
    private String color;
    private int wheels;

    public CarBuilder setEngine(String engine) {
        this.engine = engine;
        return this;
    }

    public CarBuilder setColor(String color) {
        this.color = color;
        return this;
    }

    public CarBuilder setWheels(int wheels) {
        this.wheels = wheels;
        return this;
    }

    public Car build() {
        return new Car(engine, color, wheels);
    }
}