package org.qichen.c0944666;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;

import java.util.List;

@Getter
@AllArgsConstructor
@EqualsAndHashCode
public class Business {
    private final String name;
    private final String address;
    private final Person owner;
    private final String postalCode;
    private final List<Person> customers;
}
