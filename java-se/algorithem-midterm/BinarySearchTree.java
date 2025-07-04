public class BinarySearchTree {
    TreeNode root;

    public BinarySearchTree() {
        this.root = null;
    }

    public void insert(int data) {
        var newNode = new TreeNode(data);
        if (this.root == null) {
            this.root = newNode;
            return;
        }
        var current = this.root;
        while (current != null) {
            if (data < current.data) {
                if (current.left == null) {
                    current.left = newNode;
                    return;
                }
                current = current.left;
            } else {
                if (current.right == null) {
                    current.right = newNode;
                    return;
                }
                current = current.right;
            }
        }
    }

    public boolean search(int data) {
        var current = this.root;
        while (current != null) {
            if (current.data == data) {
                return true;
            } else if (current.data > data) {
                current = current.left;
            } else {
                current = current.right;
            }
        }
        return false;
    }

    public int findMin() {
        var current = this.root;
        while (current.left != null) {
            current = current.left;
        }
        return current.data;
    }
    public void printInOrder() {
        printInOrder(this.root);
    }
    private void printInOrder(TreeNode node) {
        if (node == null) {
            return;
        }
        printInOrder(node.left);
        System.out.println(node.data);
        printInOrder(node.right);
    }
    public void testBinarySearchTree() {
        var bst = new BinarySearchTree();
        bst.insert(10);
        bst.insert(5);
        bst.insert(15);
        bst.insert(3);
        bst.insert(7);
        bst.insert(12);
        bst.printInOrder();
        System.out.println(bst.search(10));
        System.out.println(bst.search(100));
        System.out.println(bst.findMin());
    }
}