package org.qichen.c0944666;

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
    public static void testSortingAlgorithms() {
        var sortingAlgorithms = new SortingAlgorithms();
        int[] dataSet1 = {
                6, 5, 12, 10, 9 ,1
        };
        sortingAlgorithms.mergeSort(dataSet1, 0, dataSet1.length);
    }
    public static void main(String[] args) {
//        testCustomHash();
        testSortingAlgorithms();
    }
}