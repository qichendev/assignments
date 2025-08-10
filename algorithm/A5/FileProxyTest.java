// proxy pattern test
public class FileProxyTest {
    public static void main(String[] args) {
        File file = new FileProxy("test.txt");
        for (int i = 0; i < 10; i++) {
            try {
                file.display();
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }
    }
}