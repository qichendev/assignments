package org.qichen.c0944666;

import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

public class MidTermSolution {

    public List<Person> customersWithMatchingAndDifferentPetAges(List<Business> businesses) {
        return safeList(businesses).stream()
                .filter(Objects::nonNull)
                .flatMap(business -> safeList(business.getCustomers()).stream())
                .filter(Objects::nonNull)
                .filter(person -> {
                    List<Pet> pets = safeList(person.getPets()).stream()
                            .filter(Objects::nonNull)
                            .toList();
                    return pets.stream().anyMatch(pet -> Objects.equals(pet.getAge(), person.getAge()))
                            && pets.stream().anyMatch(pet -> !Objects.equals(pet.getAge(), person.getAge()));
                })
                .distinct()
                .toList();
    }

    public List<Person> ownersWhoAreCustomersOfOwnBusiness(List<Business> businesses) {
        return safeList(businesses).stream()
                .filter(Objects::nonNull)
                .filter(business -> business.getOwner() != null)
                .filter(business -> safeList(business.getCustomers()).contains(business.getOwner()))
                .map(Business::getOwner)
                .distinct()
                .toList();
    }

    public List<Pet> distinctPetsForBusinessesStartingWith(List<Business> businesses, String c) {
        String prefix = c == null ? "" : c;
        return safeList(businesses).stream()
                .filter(Objects::nonNull)
                .filter(business -> business.getName() != null)
                .filter(business -> business.getName().startsWith(prefix))
                .flatMap(business -> safeList(business.getCustomers()).stream())
                .filter(Objects::nonNull)
                .flatMap(person -> safeList(person.getPets()).stream())
                .filter(Objects::nonNull)
                .distinct()
                .toList();
    }

    public Map<Person, List<Business>> businessesByCustomer(List<Business> businesses) {
        return safeList(businesses).stream()
                .filter(Objects::nonNull)
                .flatMap(business -> safeList(business.getCustomers()).stream()
                        .filter(Objects::nonNull)
                        .map(customer -> Map.entry(customer, business)))
                .collect(Collectors.groupingBy(
                        Map.Entry::getKey,
                        LinkedHashMap::new,
                        Collectors.mapping(Map.Entry::getValue, Collectors.toList())
                ));
    }

    public int power(int base, int exponent) {
        if (exponent < 0) {
            throw new IllegalArgumentException("Exponent must be non-negative.");
        }
        if (exponent == 0) {
            return 1;
        }
        return base * power(base, exponent - 1);
    }

    private <T> List<T> safeList(List<T> values) {
        return values == null ? Collections.emptyList() : values;
    }
}
