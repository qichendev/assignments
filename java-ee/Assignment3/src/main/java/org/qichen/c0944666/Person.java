package org.qichen.c0944666;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
@EqualsAndHashCode
@JsonIgnoreProperties(ignoreUnknown = true)
@Builder
public class Person {
    private String id;
    private String firstName;
    private String lastName;
    private Integer age;
    private String gender;

    private Person(String id, String firstName, String lastName, Integer age, String gender) {
        if (id == null) {
            throw new IllegalArgumentException("id cannot be null");
        }
        if (firstName == null || firstName.isBlank()) {
            throw new IllegalArgumentException("firstName cannot be null or blank");
        }
        if (lastName == null || lastName.isBlank()) {
            throw new IllegalArgumentException("lastName cannot be null or blank");
        }
        if (age != null && age < 0) {
            throw new IllegalArgumentException("age must be >= 0");
        }
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.age = age;
        this.gender = gender;
    }
}
