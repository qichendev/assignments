package org.qichen.c0944666.service;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertIterableEquals;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.qichen.c0944666.model.Occupation;
import org.qichen.c0944666.model.User;

class UserCacheTest {

    @Test
    void fetchUsersWithAtLeastSalaryAndUnderAgeFiltersCorrectly() {
        UserCache userCache = new UserCache();

        List<User> users = userCache.fetchUsersWithAtLeastSalaryAndUnderAge(80000, 30);

        assertIterableEquals(
                List.of(new User("Alice", 27, new Occupation("Developer", 85000))),
                users
        );
    }

    @Test
    void fetchHighestPaidOccupationReturnsLargestSalary() {
        UserCache userCache = new UserCache();

        Occupation occupation = userCache.fetchHighestPaidOccupation();

        assertEquals(new Occupation("Manager", 99000), occupation);
    }

    @Test
    void addUserStoresUserAndReturnsItFromFetchAllUsers() {
        UserCache userCache = new UserCache();
        User user = new User("Diana", 29, new Occupation("Architect", 120000));

        userCache.addUser(user);

        assertEquals(4, userCache.fetchAllUsers().size());
        assertEquals(user, userCache.fetchAllUsers().get(3));
    }
}
