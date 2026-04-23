package org.qichen.c0944666.config;

import org.qichen.c0944666.model.Product;
import org.qichen.c0944666.service.ProductService;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;

@Component
public class SampleDataLoader implements CommandLineRunner {
    private final ProductService productService;

    public SampleDataLoader(ProductService productService) {
        this.productService = productService;
    }

    @Override
    public void run(String... args) {
        productService.save(Product.builder()
                .name("Wireless Desk Charger")
                .category("Electronics")
                .price(new BigDecimal("39.99"))
                .stockQuantity(18)
                .description("A compact charger for phones, watches, and earbuds.")
                .build());
        productService.save(Product.builder()
                .name("Cotton Market Tote")
                .category("Fashion")
                .price(new BigDecimal("14.50"))
                .stockQuantity(42)
                .description("Reusable tote bag with reinforced handles for daily shopping.")
                .build());
        productService.save(Product.builder()
                .name("Kitchen Starter Set")
                .category("Home")
                .price(new BigDecimal("79.00"))
                .stockQuantity(11)
                .description("Essential cookware bundle for apartments and dorm kitchens.")
                .build());
    }
}
