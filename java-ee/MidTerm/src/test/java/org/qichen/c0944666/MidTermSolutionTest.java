package org.qichen.c0944666;

import org.junit.jupiter.api.Test;

import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertIterableEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

class MidTermSolutionTest {

    private final MidTermSolution solution = new MidTermSolution();

    @Test
    void q1ReturnsCustomersWithAtLeastOneMatchingAndOneDifferentPetAge() {
        Person qualified = new Person(
                "Alice",
                30,
                List.of(new Pet("Rex", 30, "dog"), new Pet("Milo", 4, "cat"))
        );
        Person noMatch = new Person(
                "Bob",
                25,
                List.of(new Pet("Goldie", 1, "fish"), new Pet("Bunny", 2, "rabbit"))
        );
        Person allSame = new Person(
                "Cara",
                22,
                List.of(new Pet("Luna", 22, "dog"), new Pet("Nova", 22, "cat"))
        );
        Business business = new Business("Alpha Pets", "A1", noMatch, "P1", List.of(qualified, noMatch, allSame));

        List<Person> result = solution.customersWithMatchingAndDifferentPetAges(List.of(business));

        assertEquals(List.of(qualified), result);
    }

    @Test
    void q1ReturnsDistinctCustomersAcrossBusinesses() {
        Person repeated = new Person(
                "Dana",
                40,
                List.of(new Pet("Spot", 40, "dog"), new Pet("Nemo", 2, "fish"))
        );
        Business first = new Business("Alpha", "A1", repeated, "P1", List.of(repeated));
        Business second = new Business("Beta", "B1", repeated, "P2", List.of(repeated));

        List<Person> result = solution.customersWithMatchingAndDifferentPetAges(List.of(first, second));

        assertEquals(1, result.size());
        assertEquals(repeated, result.getFirst());
    }

    @Test
    void q2ReturnsOwnersWhoAlsoAppearInTheirCustomerList() {
        Person ownerCustomer = new Person("Emma", 35, List.of());
        Person ownerOnly = new Person("Finn", 28, List.of());
        Business matching = new Business("Corner Shop", "A1", ownerCustomer, "P1", List.of(ownerCustomer));
        Business notMatching = new Business("Town Cafe", "B2", ownerOnly, "P2", List.of(ownerCustomer));

        List<Person> result = solution.ownersWhoAreCustomersOfOwnBusiness(List.of(matching, notMatching));

        assertEquals(List.of(ownerCustomer), result);
    }

    @Test
    void q3ReturnsDistinctPetsFromBusinessesWhoseNamesStartWithRequestedLetter() {
        Pet sharedPet = new Pet("Buddy", 3, "dog");
        Pet alphaPet = new Pet("Coco", 5, "bird");
        Pet betaPet = new Pet("Tiger", 7, "cat");
        Person alphaCustomerOne = new Person("Gina", 31, List.of(sharedPet, alphaPet));
        Person alphaCustomerTwo = new Person("Hank", 29, List.of(sharedPet));
        Person betaCustomer = new Person("Ivy", 26, List.of(betaPet));

        Business alpha = new Business("Atlas Grooming", "A1", alphaCustomerOne, "P1", List.of(alphaCustomerOne, alphaCustomerTwo));
        Business beta = new Business("Bravo Vet", "B2", betaCustomer, "P2", List.of(betaCustomer));

        List<Pet> result = solution.distinctPetsForBusinessesStartingWith(List.of(alpha, beta), "A");

        assertIterableEquals(List.of(sharedPet, alphaPet), result);
    }

    @Test
    void q3ReturnsEmptyListWhenNoBusinessMatchesPrefix() {
        Person customer = new Person("Jay", 20, List.of(new Pet("Pip", 1, "bird")));
        Business business = new Business("Nova Pets", "A1", customer, "P1", List.of(customer));

        List<Pet> result = solution.distinctPetsForBusinessesStartingWith(List.of(business), "Z");

        assertTrue(result.isEmpty());
    }

    @Test
    void q4GroupsBusinessesByCustomer() {
        Person alex = new Person("Alex", 30, List.of());
        Person blair = new Person("Blair", 32, List.of());
        Business first = new Business("Alpha", "A1", alex, "P1", List.of(alex, blair));
        Business second = new Business("Beta", "B1", blair, "P2", List.of(alex));

        Map<Person, List<Business>> result = solution.businessesByCustomer(List.of(first, second));

        assertEquals(List.of(first, second), result.get(alex));
        assertEquals(List.of(first), result.get(blair));
        assertEquals(2, result.size());
    }

    @Test
    void q4ReturnsEmptyMapForNoBusinesses() {
        Map<Person, List<Business>> result = solution.businessesByCustomer(List.of());

        assertTrue(result.isEmpty());
    }

    @Test
    void q5CalculatesPowerRecursively() {
        assertEquals(81, solution.power(3, 4));
        assertEquals(1, solution.power(7, 0));
        assertEquals(-8, solution.power(-2, 3));
    }

    @Test
    void q5RejectsNegativeExponent() {
        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> solution.power(2, -1));

        assertEquals("Exponent must be non-negative.", exception.getMessage());
    }
}
