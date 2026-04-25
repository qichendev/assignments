package org.qichen.c0944666;

public final class ExamQuestions {
    private ExamQuestions() {
    }

    public static int countConsonants(String value) {
        // Base case: no characters left to inspect.
        if (value == null || value.isEmpty()) {
            return 0;
        }

        char current = Character.toLowerCase(value.charAt(0));
        int currentCount = isConsonant(current) ? 1 : 0;
        // Count the first character, then recurse on the remaining substring.
        return currentCount + countConsonants(value.substring(1));
    }

    private static boolean isConsonant(char current) {
        return current >= 'a' && current <= 'z'
                && current != 'a'
                && current != 'e'
                && current != 'i'
                && current != 'o'
                && current != 'u';
    }
}
