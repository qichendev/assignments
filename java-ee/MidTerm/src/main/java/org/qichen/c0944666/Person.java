package org.qichen.c0944666;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;

import java.util.List;

@Getter
@AllArgsConstructor
@EqualsAndHashCode
public class Person {
    private final String name;
    private final Integer age;
    private final List<Pet> pets;
}
