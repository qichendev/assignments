package org.qichen.c0944666.controller;

import org.qichen.c0944666.model.Occupation;
import org.qichen.c0944666.model.User;
import org.qichen.c0944666.service.UserCache;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MainController {
    private final UserCache userCache;

    @GetMapping("/users")
    public String users(Model model) {
        model.addAttribute("users", userCache.fetchAllUsers());
        return "users";
    }

    @GetMapping("/create")
    public String createForm(Model model) {
        if (!model.containsAttribute("user")) {
            model.addAttribute("user", new User("", null, new Occupation("", null)));
        }
        return "create";
    }

    @PostMapping("/create")
    public String createUser(@Valid @ModelAttribute("user") User user, BindingResult bindingResult) {
        // Re-render the form so Thymeleaf can show validation errors.
        if (bindingResult.hasErrors()) {
            return "create";
        }

        userCache.addUser(user);
        return "redirect:/users";
    }
}
