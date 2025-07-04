public class LinkedList {
    Node head;

    public LinkedList() {
        this.head = null;
    }

    public void add(int data) {
        var newNode = new Node(data);
        if (this.head == null) {
            this.head = newNode;
        } else {
            var current = this.head;
            while (current.next != null) {
                current = current.next;
            }
            current.next = newNode;
        }
    }
    
    public boolean hasCycle() {
        if (this.head == null || this.head.next == null) {
            return false;
        }
        
        Node slow = this.head;
        Node fast = this.head;
        
        while (fast != null && fast.next != null) {
            slow = slow.next;
            fast = fast.next.next;
            if (slow == fast) {
                return true;
            }
        }
        
        return false;
    }
    
    public void createCycle(int cycleStartIndex) {
        if (this.head == null) {
            return;
        }
        
        Node current = this.head;
        while (current.next != null) {
            current = current.next;
        }
        
        Node cycleStart = this.head;
        for (int i = 0; i < cycleStartIndex && cycleStart != null; i++) {
            cycleStart = cycleStart.next;
        }
        
        if (cycleStart != null) {
            current.next = cycleStart;
        }
    }
    
    public void createCycleToHead() {
        if (this.head == null) {
            return;
        }
        
        Node current = this.head;
        while (current.next != null) {
            current = current.next;
        }
        current.next = this.head;
    }
    
    public Node reverse() {
        var current = this.head;
        if (current == null || current.next == null) {
            return current;
        }
        Node prev = null;
        while (current.next != null) {
            var next = current.next;
            if (current == head) {
                prev = null;
            }
            current.next = prev;
            prev = current;
            current = next;
        }
        current.next = prev;
        this.head = current;
        return current;
    }
    
    public void printLinkedList() {
        var current = this.head;
        while (current != null) {
            System.out.print(current.data + " ");
            current = current.next;
        }
        System.out.println();
    }
    public void printLinkedListWithCycleDetection(int maxNodes) {
        var current = this.head;
        int count = 0;
        while (current != null && count < maxNodes) {
            System.out.print(current.data + " ");
            current = current.next;
            count++;
        }
        if (count >= maxNodes) {
            System.out.print("... (cycle detected, stopping to avoid infinite loop)");
        }
        System.out.println();
    }
    
    public void testLinkedList() {
        var linkedList = new LinkedList();
        linkedList.add(1);
        linkedList.add(2);
        linkedList.add(3);
        linkedList.add(4);
        linkedList.add(5);
        linkedList.printLinkedList();
        linkedList.reverse();
        linkedList.printLinkedList();
    }
    
    public void testCycleDetection() {
        System.out.println("\nTest 1: Empty list");
        LinkedList emptyList = new LinkedList();
        System.out.println("Has cycle: " + emptyList.hasCycle());
        
        System.out.println("\nTest 2: Single node (no cycle)");
        LinkedList singleNode = new LinkedList();
        singleNode.add(1);
        System.out.println("List: ");
        singleNode.printLinkedList();
        System.out.println("Has cycle: " + singleNode.hasCycle());
        
        System.out.println("\nTest 3: Multiple nodes (no cycle)");
        LinkedList noCycleList = new LinkedList();
        noCycleList.add(1);
        noCycleList.add(2);
        noCycleList.add(3);
        noCycleList.add(4);
        noCycleList.add(5);
        System.out.println("List: ");
        noCycleList.printLinkedList();
        System.out.println("Has cycle: " + noCycleList.hasCycle());
        
        System.out.println("\nTest 4: Cycle to head");
        LinkedList cycleToHead = new LinkedList();
        cycleToHead.add(1);
        cycleToHead.add(2);
        cycleToHead.add(3);
        cycleToHead.add(4);
        cycleToHead.add(5);
        System.out.println("Original list: ");
        cycleToHead.printLinkedList();
        cycleToHead.createCycleToHead();
        System.out.println("After creating cycle to head: ");
        cycleToHead.printLinkedListWithCycleDetection(10);
        System.out.println("Has cycle: " + cycleToHead.hasCycle());
    }
}
