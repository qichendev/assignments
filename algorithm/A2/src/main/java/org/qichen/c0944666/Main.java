package org.qichen.c0944666;

import java.util.Date;

public class Main {
    public static void testCustomHash() {
        var customHash = new CustomHash();
        var hash = customHash.hash(10, "first string");
        if (hash != -1) {
            System.out.println(hash);
        }
        hash = customHash.hash(-1, "first string");
        if (hash != -1) {
            System.out.println(hash);
        }
        hash = customHash.hash(10, "first中文 string");
        if (hash != -1) {
            System.out.println(hash);
        }
        hash = customHash.hash(10, "");
        if (hash != -1) {
            System.out.println(hash);
        }
    }
    public interface Action {
        public void sort(int[] arr);
    }

    public static long calculateSortingTimeMs(Action action) {
        var sortingAlgorithms = new SortingAlgorithms();
        var dataSet = new int[1000];
        for (var i = 0; i != 1000; ++i) {
            dataSet[i] = 1000 - dataSet[i];
        }
        var start = System.nanoTime();
        action.sort(dataSet);
        var end = System.nanoTime();
        return end - start;
    }

    public static void testSortingAlgorithms() {
        System.out.println("bubbleSort spent\t" + calculateSortingTimeMs(new Action() {
            @Override
            public void sort(int[] arr) {
                new SortingAlgorithms().bubbleSort(arr);
            }
        }) + " ns");
        System.out.println("mergeSort spent\t\t" + calculateSortingTimeMs(new Action() {
            @Override
            public void sort(int[] arr) {
                new SortingAlgorithms().mergeSort(arr);
            }
        }) + " ns");
    }
    public static void testStudentInformation() {
        StudentInformation studentInfo = new StudentInformation();
        try {
            studentInfo.addStudent(1, "Alice");
            if (!"Alice".equals(studentInfo.getStudent(1))) throw new RuntimeException("Test 1 Fail");
            System.out.println("Test 1 Pass");
        } catch (Exception e) { System.err.println("Test 1 Fail: " + e.getMessage()); }

        try {
            studentInfo.addStudent(1, "Bob");
            System.err.println("Test 2 Fail: No exception on duplicate ID");
        } catch (RuntimeException e) {
            if (!"id already exist".equals(e.getMessage())) throw new RuntimeException("Test 2 Fail: Wrong message");
            System.out.println("Test 2 Pass");
        } catch (Exception e) { System.err.println("Test 2 Fail: Unexpected exception " + e.getMessage()); }

        try {
            studentInfo.getStudent(99);
            System.err.println("Test 3 Fail: No exception on non-existent ID");
        } catch (RuntimeException e) {
            if (!"id doesn't exist".equals(e.getMessage())) throw new RuntimeException("Test 3 Fail: Wrong message");
            System.out.println("Test 3 Pass");
        } catch (Exception e) { System.err.println("Test 3 Fail: Unexpected exception " + e.getMessage()); }
    }
    public static void main(String[] args) {
        testCustomHash();
        testSortingAlgorithms();
        testStudentInformation();
    }
}