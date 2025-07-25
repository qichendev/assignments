package com.mycompany.app;

// Singleton class
public class Logger {
    private static Logger instance;
    private Logger() {
        System.out.println("Logger instance created");
    }

    // Getter method
    public static Logger getInstance() {
        if (instance == null) {
            instance = new Logger();
        }
        return instance;
    }

    // Log method
    public void log(String message) {
        System.out.println(message);
    }
}