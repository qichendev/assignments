import java.util.Scanner;

public class C2 {
    public static void CheckDivideEvenly() {
        Scanner s = new Scanner(System.in);
        int op1 = s.nextInt();
        int op2 = s.nextInt();
        s.close();
        if (op1 % op2 == 0) {
            System.out.println("divide evenly");
        } else {
            System.out.println("divide not evenly");
        }
    }
    public static void main(String[] args) {
        CheckDivideEvenly();
    }
}