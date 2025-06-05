package org.qichen.c0944666;

public class Main {
    public static boolean match(char left, char right) {
        return left == '{' && right == '}'
                || left == '[' && right == ']'
                || left == '(' && right == ')';
    }
    public static boolean isBalanced(String expression) {
        Stack stack = new Stack();
        expression.chars().forEach(ch -> {
            if (stack.size() != 0)
            {
                if (match((char) stack.peek(), (char) ch))
                {
                    stack.pop();
                }
                else {
                    stack.push(ch);
                }
            }
            else
            {
                stack.push(ch);
            }
        });
        return stack.size() == 0;
    }
    public static void testIsBalanced() {
        var strs = new String[]{"{[()]}"
                , "{[(])}"
                , "abcd"
                , "{([])}"
                , "({[})]"
                , ""
                , "[({})]"
                , "[]][]"
        };
        for (var str: strs) {
            System.out.println(str + ": " + isBalanced(str));
        }
    }
    public static void testReverseList() {
        var numbers = new int[] {1, 23, 4, 24, 54, 12};
        var list = new LinkedList();
        for (var num: numbers) {
            list.add(num);
        }
        System.out.println("Before reversed: ");
        list.display();
        list.reverseList();
        System.out.println("After reversed: ");
        list.display();
    }
    public static void main(String[] args) {
        testIsBalanced();
        testReverseList();
    }
}