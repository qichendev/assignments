package org.qichen.c0944666.controller;

import org.qichen.c0944666.service.HitCounterService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class HitCounterController {
    private final HitCounterService hitCounterService;

    public HitCounterController(HitCounterService hitCounterService) {
        this.hitCounterService = hitCounterService;
    }

    @GetMapping("/api/hits")
    public Map<String, Long> hits() {
        return Map.of("hits", hitCounterService.getHits());
    }
}
