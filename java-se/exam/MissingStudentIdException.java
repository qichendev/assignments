// This class is used to throw an exception if the Student ID is missing
public class MissingStudentIdException extends Exception {
    public MissingStudentIdException(String message) {
        super(message);
    }
}