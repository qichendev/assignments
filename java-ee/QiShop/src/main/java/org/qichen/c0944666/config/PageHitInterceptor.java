package org.qichen.c0944666.config;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.qichen.c0944666.service.HitCounterService;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class PageHitInterceptor implements HandlerInterceptor {
    private final HitCounterService hitCounterService;

    public PageHitInterceptor(HitCounterService hitCounterService) {
        this.hitCounterService = hitCounterService;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        hitCounterService.recordPageHit();
        return true;
    }
}
