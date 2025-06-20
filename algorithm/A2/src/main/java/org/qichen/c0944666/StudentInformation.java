package org.qichen.c0944666;

import java.util.HashMap;
import java.util.function.BiConsumer;

public class StudentInformation {
    public void addStudent(int id, String name) {
        if (studentData.containsKey(id)) {
            throw new RuntimeException("id already exist");
        }
        studentData.put(id, name);
    }
    public void removeStudent(int id) {
        if (!studentData.containsKey(id)) {
            throw new RuntimeException("id doesn't exist");
        }
        studentData.remove(id);
    }
    public String getStudent(int id) {
        if (!studentData.containsKey(id)) {
            throw new RuntimeException("id doesn't exist");
        }
        return studentData.get(id);
    }
    public void displayAllStudents() {
        studentData.forEach(new BiConsumer<Integer, String>() {
            @Override
            public void accept(Integer id, String name) {
                System.out.println("student id: " + id + ", student full name: " + name);
            }
        });
    }
    private final HashMap<Integer, String> studentData = new HashMap<>();
}
