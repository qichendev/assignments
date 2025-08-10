// RealFile class
public class RealFile implements File {
    private String fileName;

    public RealFile(String fileName) {
        this.fileName = fileName;
    }

    @Override
    public void display() {
        System.out.println("Loading file: " + fileName);
        System.out.println("Displaying file: " + fileName);
    }
}