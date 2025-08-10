// proxy pattern
public class FileProxy implements File {
    private RealFile realFile;

    public FileProxy(String fileName) {
        this.realFile = new RealFile(fileName);
    }

    @Override
    public void display() {
        if (Math.random() > 0.5) {
            throw new RuntimeException("File not found");
        }
        realFile.display();
    }
}