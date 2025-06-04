package org.qichen.c0944666;

import java.util.Scanner;

public class TemperatureApp {
    public static void main(String[] args)
    {
        System.out.println("How many temperatures you want to record?");
        var scanner = new Scanner(System.in);
        var numberOfRecords = Integer.parseInt(scanner.nextLine());
        var recordSet = new double[numberOfRecords];
        for (var i = 0; i != numberOfRecords; ++i)
        {
            System.out.print("enter record " + (i + 1) + ": ");
            recordSet[i] = Double.parseDouble(scanner.nextLine());
        }
        var ts = new TemperatureStatistics(recordSet);
        System.out.println("Average degree: " + ts.calculateAverage());
        System.out.println("Minimum degree: " + ts.findMin ());
        System.out.println("Maximum degree: " + ts.findMax());
        System.out.println("All temps: ");
        ts.print();
        System.out.println("All temps as fahrenheit: ");
        ts.printAsFahrenheit();
    }
}