public class BST {
    private static class Node {
        int key;
        Node left;
        Node right;

        Node(int key) {
            this.key = key;
        }
    }

    private Node root;

    public void add(int key) {
        if (root == null) {
            root = new Node(key);
            return;
        }
        Node current = root;
        while (true) {
            if (key == current.key) {
                return;
            } else if (key < current.key) {
                if (current.left == null) {
                    current.left = new Node(key);
                    return;
                }
                current = current.left;
            } else {
                if (current.right == null) {
                    current.right = new Node(key);
                    return;
                }
                current = current.right;
            }
        }
    }

    public boolean contains(int key) {
        Node current = root;
        while (current != null) {
            if (key == current.key) {
                return true;
            } else if (key < current.key) {
                current = current.left;
            } else {
                current = current.right;
            }
        }
        return false;
    }

    public int getMinimum() {
        if (root == null) {
            throw new IllegalStateException("Tree is empty");
        }
        Node current = root;
        while (current.left != null) {
            current = current.left;
        }
        return current.key;
    }

    public static void main(String[] args) {
        BST bst = new BST();
        int[] values = {7, 3, 9, 1, 5, 8, 10};
        for (int v : values) {
            bst.add(v);
        }
        System.out.println(bst.contains(5));
        System.out.println(bst.contains(6));
        System.out.println(bst.getMinimum());
    }
}