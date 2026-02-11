public class Application {
    public static void main(String[] args) {
        // create a new Person object
        Person person = new Person("John Doe", 30);

        try {
            // try to change the person's dog's name
            person.changeDogsName("Buddy");
        } catch (RuntimeException e) {
            // catch exception from person.changeDogsName()
            System.out.println("Unable to change dogs name " + e.getMessage());
        }
    }
}
