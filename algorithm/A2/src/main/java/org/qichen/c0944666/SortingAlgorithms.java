package org.qichen.c0944666;

import java.util.ArrayList;
import java.util.Deque;
import java.util.Queue;

public class SortingAlgorithms {
    public void bubbleSort(int[] array) {
        for (var i = 0; i != array.length; ++i) {
            for (var j = i + 1; j != array.length; ++j) {
                if (array[i] > array[j]) {
                    var tmp = array[i];
                    array[i] = array[j];
                    array[j] = tmp;
                }
            }
        }
    }
    private final ArrayList<Integer> buffer = new ArrayList<Integer>();
    private void combineSortedArries(int[] array, int lstart, int lend, int rstart, int rend) {
        var start = lstart;
        buffer.clear();
        while (lstart != lend && rstart != rend) {
            buffer.add(array[lstart] > array[rstart] ? array[rstart++] : array[lstart++]);
        }
        while (lstart != lend || rstart != rend) {
            buffer.add(rstart != rend ? array[rstart++] : array[lstart++]);
        }
        var arrayIterator = start;
        for (var i: buffer) {
            array[arrayIterator++] = i;
        }
    }
    public void mergeSort(int[] array, int start, int end) {
        if (end - start == 2) {
            var tmp = array[start];
            array[start] = array[start + 1];
            array[start + 1] = tmp;
        } else if (end - start > 2){
            mergeSort(array, start, end / 2 - 1);
            mergeSort(array, end / 2 - 1, end);
            combineSortedArries(array, start, end / 2, end / 2, end);
        }
    }
}
