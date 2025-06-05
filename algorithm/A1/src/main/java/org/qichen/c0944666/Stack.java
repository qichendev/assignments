package org.qichen.c0944666;

public class Stack {
    public Stack() {
        list = new LinkedList();
    }
    public void push(int data) {
        list.add(data);
    }
    public int pop() {
        var ret = list.end().data;
        list.removeTail();
        return ret;
    }
    public int peek() {
        return list.end().data;
    }
    public int size() {
        return list.size();
    }
    private final LinkedList list;
}
