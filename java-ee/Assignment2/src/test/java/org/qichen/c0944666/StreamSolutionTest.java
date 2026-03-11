package org.qichen.c0944666;

import org.junit.jupiter.api.Test;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

class StreamSolutionTest {

    private final StreamSolution solution = new StreamSolution();

    @Test
    void testLargestNumber() {
        List<Integer> list = Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        assertEquals(10, solution.largestNumber(list));
    }

    @Test
    void testFilterGreaterThan() {
        List<Integer> list = Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        List<Integer> expected = Arrays.asList(6, 7, 8, 9, 10);
        assertEquals(expected, solution.filterGreaterThan(list, 5));
    }

    @Test
    void testFizzBuzzStream() {
        List<Integer> list = Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        List<String> expected = Arrays.asList("1", "fizz", "3", "fizz", "buzz", "fizz", "7", "fizz", "9", "fizzbuzz");
        assertEquals(expected, solution.fizzBuzzStream(list));
    }

    @Test
    void testContainsValueLessThan() {
        Map<String, Integer> map = new HashMap<>();
        map.put("A", 10);
        map.put("B", 20);
        map.put("C", 5);
        
        assertTrue(solution.containsValueLessThan(map, 6));
        assertFalse(solution.containsValueLessThan(map, 5));
    }

    @Test
    void testLargestNElements() {
        List<Integer> list = Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        List<Integer> result = solution.largestNElements(list, 3);
        
        assertEquals(3, result.size());
        assertTrue(result.containsAll(Arrays.asList(10, 8, 9)));
    }
}
