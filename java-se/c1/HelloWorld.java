public class HelloWorld {
    public double F2CDegree(double fahrenheit) {
        return (5.0 / 9.0) * (fahrenheit - 32);
    }
    public static void main(String[] args) {
        System.out.println("Hello, World!");
        System.out.println(new HelloWorld().F2CDegree(82));
    }
}