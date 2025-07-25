package com.mycompany.app;

public class App {
    public void runBuilderPattern() {
        // Using the Builder to create a Computer instance
        Computer gamingComputer = new Computer.Builder()
                .setCpu("Intel i9")
                .setRam("32GB")
                .setStorage("1TB SSD")
                .setGraphicsCard("NVIDIA RTX 4090")
                .build();

        // Using the Builder to create another Computer instance with different configuration
        Computer officeComputer = new Computer.Builder()
                .setCpu("Intel i5")
                .setRam("16GB")
                .setStorage("512GB SSD")
                .build(); // Graphics card is optional

        System.out.println("Gaming Computer Configuration:");
        System.out.println(gamingComputer);

        System.out.println("\nOffice Computer Configuration:");
        System.out.println(officeComputer);
    }

    public void runSingletonPattern() {
        Logger logger = Logger.getInstance();
        logger.log("This is a log message");
    }

    public void runFactoryPattern() {
        Vehicle[] vehicles = { VehicleFactory.getVehicle("car")
            , VehicleFactory.getVehicle("truck")
            , VehicleFactory.getVehicle("bike") };
        for (Vehicle vehicle : vehicles) {
            vehicle.drive();
        }
    }

    public static void main(String[] args) {
        App app = new App();
        app.runBuilderPattern();
        app.runSingletonPattern();
        app.runFactoryPattern();
    }
}
