import java.util.Stack;

public class MidtermQuestions {

	/**(5) Marks
	 * Finish the method so that it takes in an array of ints
	 * and sums all numbers in the array that are even.
	 * 
	 * @param toProcess array to search for even numbers
	 * @return sum of even numbers
	 */
	public static int sumAllEvenNumbers(int[] toProcess) {
		int sum = 0;
		for (int num : toProcess) {
			if (num % 2 == 0) {
				sum += num;
			}
		}
		return sum;
	}
	
	/**(5) Marks
	 * Finish the method so that it takes in an array of chars
	 * and a char to join with, and joins all the characters in toJoin
	 * with joinWith between each char
	 * 
	 * e.x ['a','b','c'], '+'
	 * 
	 * results = "a+b+c"
	 * 
	 * @param toJoin array to join
	 * @param joinWith character to join between characters
	 * @return the sum of all the characters after the join
	 */
	public static String join(char[] toJoin, char joinWith) {
		if (toJoin.length == 0) {
			return "";
		}
		StringBuilder result = new StringBuilder();
		result.append(toJoin[0]);
		for (int i = 1; i < toJoin.length; i++) {
			result.append(joinWith);
			result.append(toJoin[i]);
		}
		return result.toString();
	}
	
	/**(5) Marks
	 * Finish the method so that it takes in an array of Strings
	 * and returns the count of strings with a length greater than 5
	 * 
	 * @param toProcess array to search
	 * @return count of all large strings
	 */
	public static int countLargeStrings(String[] toProcess) {
		int count = 0;
		for (String str : toProcess) {
			if (str.length() > 5) {
				count++;
			}
		}
		return count;
	}
	
	/**(5) Marks
	 * Finish the method so that it takes in an array of ints
	 * and return the largest number in the array. return -1 
	 * if the array is empty
	 * 
	 * @param toSearch array to search for the large number
	 * @return largest number
	 */
	public static int findLargestNumber(int[] toSearch) {
		if (toSearch.length == 0) {
			return -1;
		}
		int largest = toSearch[0];
		for (int i = 1; i < toSearch.length; i++) {
			if (toSearch[i] > largest) {
				largest = toSearch[i];
			}
		}
		return largest;
	}
	
	/** (5) Marks
	 * Finish the method so that it takes in an array of chars
	 * and return true if the array is a palindrome (reads the same backwards as forwards
	 * or false if its not
	 * 
	 * e.x ['a','b','c']
	 * 
	 * results = false
	 * 
	 * 	 * 
	 * e.x ['a','b','b', 'a']
	 * 
	 * results = true
	 * 
	 * @param toCheck array to join
	 * @return the true if the character array is a palindrome
	 */
	public static boolean isPalindrome(char[] toCheck) {
		var s = new Stack<Character>();
		for (var c: toCheck) {
			if (!s.empty() && s.peek() == c) {
				s.pop();
			} else {
				s.push(c);
			}
		}
		return s.empty();
	}
	public static void main(String[] args){
		System.out.println(sumAllEvenNumbers(new int[]{
				1, 2, 3, 4, 5
		}));
		System.out.println(sumAllEvenNumbers(new int[]{
		}));
		System.out.println(join(new char[]{'a', 'b', 'c'}, '+'));
		System.out.println(join(new char[]{}, '+'));
		System.out.println(countLargeStrings(new String[]{
				"1th",
				"first string"
		}));
		System.out.println(countLargeStrings(new String[]{
		}));
		System.out.println(findLargestNumber(new int[]{
				2, 4, 6, 80, 23, 1
		}));
		System.out.println(findLargestNumber(new int[]{
		}));
		System.out.println(isPalindrome(new char[]{
				'a', 'b', 'c'
		}));
		System.out.println(isPalindrome(new char[]{
				'a', 'b', 'b', 'a'
		}));
		System.out.println(isPalindrome(new char[]{
		}));
	}
}
