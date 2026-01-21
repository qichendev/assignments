public class Main {
    public static void main(String[] args) {
        BinaryTree tree = new BinaryTree();
        tree.root = new BinaryTree.Node(1);
        tree.root.left = new BinaryTree.Node(2);
        tree.root.right = new BinaryTree.Node(3);
        tree.root.left.left = new BinaryTree.Node(4);
        tree.root.left.right = new BinaryTree.Node(5);
        tree.printLevelOrder();

        GadgetFactory factory = new GadgetFactory();
        Gadget tablet = factory.createGadget("Tablet");
        Gadget watch = factory.createGadget("Smartwatch");
        if (tablet != null) {
            tablet.powerOn();
        }
        if (watch != null) {
            watch.powerOn();
        }

        CarBuilder builder = new CarBuilder();
        Car car1 = builder.setEngine("V6").setColor("Red").setWheels(4).build();
        Car car2 = new CarBuilder().setEngine("Electric").setColor("Blue").setWheels(4).build();
        System.out.println(car1);
        System.out.println(car2);
    }
}


