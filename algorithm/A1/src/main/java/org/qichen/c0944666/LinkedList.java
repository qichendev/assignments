package org.qichen.c0944666;

public class LinkedList {
    public LinkedList(){
        head = null;
        tail = null;
        length = 0;
    }
    public void add(int data){
        if (head == null) {
            head = new Node(data);
            tail = head;
        }
        else {
            tail.next = new Node(data);
            tail = tail.next;
        }
        ++length;
    }
    public void remove(int data)
    {
        if (head == null) {
            return;
        }
        if (head.data == data) {
            head = head.next;
        }
        else {
            var iterator = head;
            while (iterator.next.data != data) {
                iterator = iterator.next;
            }
            if (iterator.next == tail) {
                tail = iterator;
            }
            else {
                iterator.next = iterator.next.next;
            }
        }
        --length;
    }
    public void display(){
        for (var i = head; i != null; i = i.next) {
            System.out.print(i.data + ", ");
        }
        System.out.println();
    }
    public void removeTail()
    {
        if (head == null) {
            return;
        }
        var iterator = head;
        while (iterator.next != null
                && iterator.next != tail) {
            iterator = iterator.next;
        }
        tail = iterator;
        iterator.next = null;
        --length;
    }
    public Node begin() {
        return head;
    }
    public Node end() {
        return tail;
    }
    public int size() {
        return length;
    }
    public void reverseList()
    {
        var stack = new Stack();
        for (var i = head; i != null; i = i.next)
        {
            stack.push(i.data);
        }
        head = null;
        length = 0;
        while (stack.size() != 0){
            if (head == null) {
                head = new Node(stack.pop());
                tail = head;
            } else {
                tail.next = new Node(stack.pop());
                tail = tail.next;
            }
            ++length;
        }
    }
    private Node head;
    private Node tail;
    private int length;
}