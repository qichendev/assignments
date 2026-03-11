package org.qichen.c0944666;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class PersonTest {

    @Test
    void buildingPersonWithNullIdShouldThrowException() {
        assertThrows(IllegalArgumentException.class, () ->
            Person.builder()
                .id(null)
                .firstName("John")
                .lastName("Doe")
                .build()
        );
    }

    @Test
    void buildingPersonWithNullFirstNameShouldThrowException() {
        assertThrows(IllegalArgumentException.class, () ->
            Person.builder()
                .id("1")
                .firstName(null)
                .lastName("Doe")
                .build()
        );
    }

    @Test
    void buildingPersonWithBlankFirstNameShouldThrowException() {
        assertThrows(IllegalArgumentException.class, () ->
            Person.builder()
                .id("1")
                .firstName("   ")
                .lastName("Doe")
                .build()
        );
    }

    @Test
    void buildingPersonWithNullLastNameShouldThrowException() {
        assertThrows(IllegalArgumentException.class, () ->
            Person.builder()
                .id("1")
                .firstName("John")
                .lastName(null)
                .build()
        );
    }

    @Test
    void buildingPersonWithBlankLastNameShouldThrowException() {
        assertThrows(IllegalArgumentException.class, () ->
            Person.builder()
                .id("1")
                .firstName("John")
                .lastName("   ")
                .build()
        );
    }

    @Test
    void buildingPersonWithNegativeAgeShouldThrowException() {
        assertThrows(IllegalArgumentException.class, () ->
            Person.builder()
                .id("1")
                .firstName("John")
                .lastName("Doe")
                .age(-1)
                .build()
        );
    }

    @Test
    void personShouldBeBuiltWithValidArguments() {
        Person person = Person.builder()
                .id("1")
                .firstName("John")
                .lastName("Doe")
                .age(25)
                .gender("Male")
                .build();

        assertEquals("1", person.getId());
        assertEquals("John", person.getFirstName());
        assertEquals("Doe", person.getLastName());
        assertEquals(25, person.getAge());
        assertEquals("Male", person.getGender());
    }

    @Test
    void personShouldBeBuiltWithNullAgeAndGender() {
        Person person = Person.builder()
                .id("1")
                .firstName("John")
                .lastName("Doe")
                .build();

        assertEquals("1", person.getId());
        assertEquals("John", person.getFirstName());
        assertEquals("Doe", person.getLastName());
        assertNull(person.getAge());
        assertNull(person.getGender());
    }
}
