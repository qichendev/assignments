package org.qichen.c0944666.controller;

import org.junit.jupiter.api.Test;
import org.qichen.c0944666.config.PageHitInterceptor;
import org.qichen.c0944666.service.HitCounterService;
import org.qichen.c0944666.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.Import;
import org.springframework.test.web.servlet.MockMvc;

import java.util.List;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.redirectedUrl;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

@WebMvcTest(ProductController.class)
@Import(PageHitInterceptor.class)
class ProductControllerTest {
    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private ProductService productService;

    @MockBean
    private HitCounterService hitCounterService;

    @Test
    void listsProductsWithOptionalFilters() throws Exception {
        when(productService.categories()).thenReturn(List.of("Electronics"));
        when(productService.findProducts(any(), any(), any())).thenReturn(List.of());

        mockMvc.perform(get("/products")
                        .param("search", "desk")
                        .param("category", "Electronics")
                        .param("maxPrice", "50"))
                .andExpect(status().isOk())
                .andExpect(view().name("products"))
                .andExpect(model().attributeExists("products"));
    }

    @Test
    void rejectsInvalidFormSubmission() throws Exception {
        when(productService.categories()).thenReturn(List.of("Electronics"));

        mockMvc.perform(post("/products")
                        .param("name", "")
                        .param("category", "")
                        .param("price", "-1")
                        .param("stockQuantity", "-2")
                        .param("description", "short"))
                .andExpect(status().isOk())
                .andExpect(view().name("product-form"))
                .andExpect(model().attributeHasFieldErrors("product", "name", "category", "price", "stockQuantity", "description"));
    }

    @Test
    void savesValidFormSubmission() throws Exception {
        when(productService.categories()).thenReturn(List.of("Electronics"));

        mockMvc.perform(post("/products")
                        .param("name", "Wireless Charger")
                        .param("category", "Electronics")
                        .param("price", "39.99")
                        .param("stockQuantity", "8")
                        .param("description", "Fast charging stand for phones and earbuds."))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/products"));

        verify(productService).save(any());
    }
}
