package org.qichen.c0944666;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;

@Getter
@AllArgsConstructor
@EqualsAndHashCode
public class Pet {
    private final String name;
    private final Integer age;
    private final String type;
}
