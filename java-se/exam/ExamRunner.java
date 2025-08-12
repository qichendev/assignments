import java.io.*;

// This class is used to write and read the Student object to and from a file
public class ExamRunner {

    // This method is used to write the Student object to the file
    public static void studentWriter(Person[] people, String filename) {
        // Find the first Student in the array
        for (Person person : people) {
            if (person instanceof Student) {
                try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(filename))) {
                    oos.writeObject(person);
                    break; // Only write the first Student found
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    
    // This method is used to read the Student object from the file
    public static void studentReader(String filename) {
        try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(filename))) {
            Student student = (Student) ois.readObject();
            System.out.println("Name: "
                + student.getName() + " Age: "
                + student.getAge() + " Student ID: "
                + student.getStudentId() + " Major: "
                + student.getMajor());
        } catch (IOException | ClassNotFoundException | MissingStudentIdException e) {
            e.printStackTrace();
        }
    }
    
    // This method is used to run the program
    public static void main(String[] args) {
        Person[] people = {
            new Student("John", 20, 123456, "Computer Science"),
            new Student("Jane", 21, 123457, "Mathematics"),
            new Student("Jim", 22, 123458, "Physics"),
            new Student("Jill", 23, 123459, "Chemistry"),
            new Person("Bob", 30) // Plain person as required
        };
        studentWriter(people, "Student.ser");
        studentReader("Student.ser");
    }
}