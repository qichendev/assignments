package org.qichen.c0944666.service;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import org.qichen.c0944666.model.Occupation;
import org.qichen.c0944666.model.User;
import org.springframework.stereotype.Component;

@Component
public class UserCache {
    private final List<User> users = new ArrayList<>();

    public UserCache() {
        users.add(new User("Alice", 27, new Occupation("Developer", 85000)));
        users.add(new User("Brian", 32, new Occupation("Manager", 99000)));
        users.add(new User("Cara", 24, new Occupation("Designer", 72000)));
    }

    public List<User> fetchUsersWithAtLeastSalaryAndUnderAge(int salary, int age) {
        // Keep only users that satisfy both the salary floor and age ceiling.
        return users.stream()
                .filter(user -> user.getOccupation() != null)
                .filter(user -> user.getOccupation().getSalary() != null)
                .filter(user -> user.getAge() != null)
                .filter(user -> user.getOccupation().getSalary() >= salary && user.getAge() < age)
                .toList();
    }

    public Occupation fetchHighestPaidOccupation() {
        // Compare occupations by salary and return the maximum one.
        return users.stream()
                .map(User::getOccupation)
                .filter(occupation -> occupation != null && occupation.getSalary() != null)
                .max(Comparator.comparingInt(Occupation::getSalary))
                .orElse(null);
    }

    public List<User> fetchAllUsers() {
        return List.copyOf(users);
    }

    public void addUser(User user) {
        users.add(user);
    }
}
