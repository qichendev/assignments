package org.qichen.c0944666.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    private final PageHitInterceptor pageHitInterceptor;

    public WebConfig(PageHitInterceptor pageHitInterceptor) {
        this.pageHitInterceptor = pageHitInterceptor;
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(pageHitInterceptor)
                .excludePathPatterns("/api/**", "/css/**", "/js/**", "/h2-console/**", "/error");
    }
}
