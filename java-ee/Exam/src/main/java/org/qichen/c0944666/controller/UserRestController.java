package org.qichen.c0944666.controller;

import org.qichen.c0944666.model.Occupation;
import org.qichen.c0944666.service.UserCache;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class UserRestController {
    private final UserCache userCache;

    @GetMapping("/mostpaid")
    public Occupation mostPaid() {
        return userCache.fetchHighestPaidOccupation();
    }
}
