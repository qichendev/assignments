## TemperatureStatistics Class (15 points)

This class will handle the statistical operations related to temperatures. It will store an array of temperatures that it takes in with a constructor. You can assume that temperatures will be in Celsius.

### Constructors:
- **TemperatureStatistics(double[] temperatures)**

### Methods (3 points each):
1. **public double calculateAverage()**  
   Returns the average of the stored temperatures array.

2. **public double findMax()**  
   Returns the highest temperature in the stored temperatures array.

3. **public double findMin()**  
   Returns the lowest temperature in the stored temperatures array.

4. **public void print()**  
   Loops through the temperatures and outputs them to the console.

5. **public void printAsFahrenheit()**  
   Loops through the temperatures and outputs them to the console after converting the values to Fahrenheit using the formula:  
   `c * (9/5) + 32 = f`

### Notes:
- Methods must have Javadocs.  
  **Penalty:** -1 point for each method without a Javadoc.

---

## TemperatureApp Class (5 points)

This class will act as the main entry point and control the flow of the program. It contains the `main` method.

### Responsibilities:
1. Ask the user how many temperatures they want to record.
2. Allow the user to input temperatures (using the `Scanner` class).
3. Create an instance of `TemperatureStatistics` and pass the input to the constructor.
4. Print the minimum, maximum, and temperatures as Fahrenheit to the console using methods in the `TemperatureStatistics` class.