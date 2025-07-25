package com.mycompany.app;

// Product class
public class Computer {
    // Attributes of the Computer
    private final String cpu;
    private final String ram;
    private final String storage;
    private final String graphicsCard;

    // Private constructor that takes a builder
    private Computer(Builder builder) {
        this.cpu = builder.cpu;
        this.ram = builder.ram;
        this.storage = builder.storage;
        this.graphicsCard = builder.graphicsCard;
    }

    // Getters for the attributes
    public String getCpu() {
        return cpu;
    }

    public String getRam() {
        return ram;
    }

    public String getStorage() {
        return storage;
    }

    public String getGraphicsCard() {
        return graphicsCard;
    }

    @Override
    public String toString() {
        return "Computer [cpu=" + cpu + ", ram=" + ram + ", storage=" + storage + ", graphicsCard=" + graphicsCard + "]";
    }

    // Static nested Builder class
    public static class Builder {
        private String cpu;
        private String ram;
        private String storage;
        private String graphicsCard;

        // Builder methods for setting attributes
        public Builder setCpu(String cpu) {
            this.cpu = cpu;
            return this;
        }

        public Builder setRam(String ram) {
            this.ram = ram;
            return this;
        }

        public Builder setStorage(String storage) {
            this.storage = storage;
            return this;
        }

        public Builder setGraphicsCard(String graphicsCard) {
            this.graphicsCard = graphicsCard;
            return this;
        }

        // Build method to create a Computer instance
        public Computer build() {
            return new Computer(this);
        }
    }
}