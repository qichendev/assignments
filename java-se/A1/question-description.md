Create a TemperatureStatistics class (15 points):

- This class will handle the statistical operations related to temperatures, it will store an array of temperatures that it takes in with a constructor. You can assume that temperatures will be in Celsius
Constructors:
TemperatureStatistics(double[] temperatures)
Methods (3 points each):
public double calculateAverage() – Returns the average of the stored temperatures array
public double findMax() – Returns the highest temperature in the stored temperatures array
public double findMin() – Returns the lowest temperature in the stored temperatures array
public void print() - loops through the temperatures and outputs them to console
public void printAsFahrenheit() - loops through the temperatures and outputs them to console after converting the value to fahrenheit (c * (9/5) + 32 = f
methods must have javadocs, -1 for each method without a javadoc
Create a TemperatureApp class (5 points):

This class will act as the main entry point and control the flow of the program. (has a main method)
It should:
Ask the user how many temperatures they want to record
Allow the user to input temperatures (using the scanner class),
create an instance of TemperatureStatistics and pass the input to the constructor
print the min, max, and temps as fahrenheit to the console using methods in the TemperatureStatistics class