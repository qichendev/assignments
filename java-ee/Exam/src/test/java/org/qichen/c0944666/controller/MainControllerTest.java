package org.qichen.c0944666.controller;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.qichen.c0944666.model.Occupation;
import org.qichen.c0944666.model.User;
import org.qichen.c0944666.service.UserCache;
import org.springframework.ui.ExtendedModelMap;
import org.springframework.validation.BeanPropertyBindingResult;
import org.springframework.validation.BindingResult;

@ExtendWith(MockitoExtension.class)
class MainControllerTest {
    @Mock
    private UserCache userCache;

    @InjectMocks
    private MainController mainController;

    @Test
    void usersAddsUsersToModelAndReturnsUsersTemplate() {
        List<User> users = List.of(
                new User("Alice", 22, new Occupation("Developer", 60000)),
                new User("Bob", 30, new Occupation("Tester", 50000))
        );
        when(userCache.fetchAllUsers()).thenReturn(users);

        ExtendedModelMap model = new ExtendedModelMap();
        String viewName = mainController.users(model);

        assertEquals("users", viewName);
        assertSame(users, model.get("users"));
    }

    @Test
    void createFormAddsDefaultUserWhenMissing() {
        ExtendedModelMap model = new ExtendedModelMap();

        String viewName = mainController.createForm(model);

        assertEquals("create", viewName);
        assertTrue(model.containsAttribute("user"));
    }

    @Test
    void createUserSavesValidUserAndRedirects() {
        User user = new User("Alice", 22, new Occupation("Developer", 60000));
        BindingResult bindingResult = new BeanPropertyBindingResult(user, "user");

        String viewName = mainController.createUser(user, bindingResult);

        assertEquals("redirect:/users", viewName);
        verify(userCache).addUser(user);
    }

    @Test
    void createUserReturnsFormWhenValidationFails() {
        User user = new User("A", 16, new Occupation("Intern", 0));
        BindingResult bindingResult = new BeanPropertyBindingResult(user, "user");
        bindingResult.rejectValue("name", "Size");

        String viewName = mainController.createUser(user, bindingResult);

        assertEquals("create", viewName);
        verify(userCache, never()).addUser(user);
    }
}
