package org.qichen.c0944666;

public class TemperatureStatistics {
    /**
     * Constructors
     * input Celsius temperature
     * @param temperatures Celsius temperature
     */
    TemperatureStatistics(double[] temperatures) {
        this.temperatures = temperatures;
    }

    /**
     *
     * @return return average temperature
     */
    public double calculateAverage() {
        double sum = 0;
        for (var temp : temperatures) {
            sum += temp;
        }
        return sum / temperatures.length;
    }

    /**
     *
     * @return return maximum value of all temperature
     */
    public double findMax() {
        double max = Double.MIN_VALUE;
        for (var temp : temperatures) {
            if (temp > max) {
                max = temp;
            }
        }
        return max;
    }

    /**
     *
     * @return return minimum value
     */
    public double findMin() {
        double min = Double.MAX_VALUE;
        for (var temp : temperatures) {
            if (temp < min) {
                min = temp;
            }
        }
        return min;
    }

    /**
     * print all temperature
     */
    public void print()
    {
        for (var temp: temperatures)
        {
            System.out.println(temp);
        }
    }

    /**
     * print all F degree
     */
    public void printAsFahrenheit()
    {
        for (var temp: temperatures)
        {
            System.out.println(temp * (9.0 / 5) + 32);
        }
    }

    private final double[] temperatures;
}