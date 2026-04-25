package org.qichen.c0944666;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

class ExamQuestionsTest {

    @Test
    void countConsonantsCountsLettersRecursively() {
        assertEquals(2, ExamQuestions.countConsonants("food"));
        assertEquals(7, ExamQuestions.countConsonants("Strength"));
        assertEquals(0, ExamQuestions.countConsonants("aeiou"));
    }
}
