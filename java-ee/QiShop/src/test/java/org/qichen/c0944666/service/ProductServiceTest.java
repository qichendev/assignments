package org.qichen.c0944666.service;

import org.junit.jupiter.api.Test;
import org.qichen.c0944666.model.Product;
import org.qichen.c0944666.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.context.annotation.Import;

import java.math.BigDecimal;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@DataJpaTest
@Import(ProductService.class)
class ProductServiceTest {
    @Autowired
    private ProductService productService;

    @Autowired
    private ProductRepository productRepository;

    @Test
    void filtersProductsBySearchCategoryAndMaxPrice() {
        productRepository.save(Product.builder()
                .name("Wireless Mouse")
                .category("Electronics")
                .price(new BigDecimal("29.99"))
                .stockQuantity(12)
                .description("Compact wireless mouse for checkout counters.")
                .build());
        productRepository.save(Product.builder()
                .name("Cookware Kit")
                .category("Home")
                .price(new BigDecimal("89.99"))
                .stockQuantity(5)
                .description("Durable kitchen cookware for everyday meals.")
                .build());

        List<Product> products = productService.findProducts("wireless", "Electronics", new BigDecimal("40.00"));

        assertThat(products)
                .hasSize(1)
                .first()
                .extracting(Product::getName)
                .isEqualTo("Wireless Mouse");
    }
}
