package org.qichen.c0944666;

import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class StreamSolution {

    /**
     * Returns largest number in the list
     */
    public Integer largestNumber(List<Integer> list) {
        return list.stream()
                .max(Comparator.naturalOrder())
                .orElse(null);
    }

    /**
     * Returns a list containing elements from the original list that are greater than the value n
     */
    public List<Integer> filterGreaterThan(List<Integer> list, Integer n) {
        return list.stream()
                .filter(i -> i > n)
                .collect(Collectors.toList());
    }

    /**
     * Returns a list of strings: "fizz" (if div by 2), "buzz" (if div by 5), "fizzbuzz" (both), or number (neither)
     */
    public List<String> fizzBuzzStream(List<Integer> list) {
        return list.stream()
                .map(n -> {
                    if (n % 2 == 0 && n % 5 == 0) return "fizzbuzz";
                    if (n % 2 == 0) return "fizz";
                    if (n % 5 == 0) return "buzz";
                    return n.toString();
                })
                .collect(Collectors.toList());
    }

    /**
     * Returns true if the map contains a value that is less than n
     */
    public boolean containsValueLessThan(Map<String, Integer> map, Integer n) {
        return map.values().stream()
                .anyMatch(v -> v < n);
    }

    /**
     * Returns a list consisting of the largest n elements in the given list
     */
    public List<Integer> largestNElements(List<Integer> list, Integer n) {
        return list.stream()
                .sorted(Comparator.reverseOrder())
                .limit(n)
                .collect(Collectors.toList());
    }
}
