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

    /**
     *
     * @param arr input array, sorting array after processing
     */
    public void mergeSort(int[] arr) {
        if (arr == null || arr.length < 2) {
            return;
        }
        sort(arr, 0, arr.length - 1);
    }

    private void sort(int[] arr, int left, int right) {
        if (left == right) {
            return;
        }
        int mid = left + (right - left) / 2;
        sort(arr, left, mid);
        sort(arr, mid + 1, right);
        merge(arr, left, mid, right);
    }

    private void merge(int[] arr, int left, int mid, int right) {
        int[] help = new int[right - left + 1];
        int i = 0;

        int p1 = left;
        int p2 = mid + 1;

        while (p1 <= mid && p2 <= right) {
            help[i++] = arr[p1] <= arr[p2] ? arr[p1++] : arr[p2++];
        }
        while (p1 <= mid) {
            help[i++] = arr[p1++];
        }
        while (p2 <= right) {
            help[i++] = arr[p2++];
        }
        for (i = 0; i < help.length; i++) {
            arr[left + i] = help[i];
        }
    }
}