import java.util.Arrays;
public class QisProgram {
    // [5] Create a static method that takes in a unsorted int array, and sorts the
    // array (ascending) (-2.5 points for using Arrays.sort())
    public static void sort(int[] toSort) {
        for (int i = 0; i < toSort.length; i++) {
            for (int j = i + 1; j < toSort.length; j++) {
                if (toSort[i] > toSort[j]) {
                    int temp = toSort[i];
                    toSort[i] = toSort[j];
                    toSort[j] = temp;
                }
            }
        }
    }

    // [5] Create a static method that takes in a int array, returns the maximum
    // number in the array

    public static int max(int[] toSearch) {
        int max = Integer.MIN_VALUE;
        for (int i = 0; i < toSearch.length; i++) {
            if (toSearch[i] > max) {
                max = toSearch[i];
            }
        }
        return max;
    }

    /*
     * [5] Create a static method that takes in a String array, and a String toFind,
     * and return true/false
     * if that array contains the string toFind
     */

    public static boolean search(String[] toSearch, String toFind) {
        for (int i = 0; i < toSearch.length; i++) {
            if (toSearch[i].equals(toFind)) {
                return true;
            }
        }
        return false;
    }

    // [5] Create a static method that takes in a int array, and returns the median
    // number
    public static int median(int[] toSearch) {
        sort(toSearch);
        return toSearch[toSearch.length / 2];
    }

    public static void main(String[] args) {
        int[] toSort = { 5, 3, 8, 4, 2 };
        System.out.println("Before sorting: " + Arrays.toString(toSort));
        sort(toSort);
        System.out.println("After sorting: " + Arrays.toString(toSort));
        System.out.println(max(toSort));
        System.out.println(median(toSort));
        System.out.println(search(new String[] { "1", "2", "3", "4", "5" }, "4"));
        System.out.println(search(new String[] { "1", "2", "3", "4", "5" }, "0"));
    }
}
