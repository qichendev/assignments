package org.qichen.c0944666.controller;

import jakarta.validation.Valid;
import org.qichen.c0944666.model.Product;
import org.qichen.c0944666.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.util.List;

@Controller
public class ProductController {
    private final ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    @ModelAttribute("categories")
    public List<String> categories() {
        return productService.categories();
    }

    @GetMapping("/")
    public String home() {
        return "redirect:/products";
    }

    @GetMapping("/products")
    public String listProducts(@RequestParam(required = false) String search,
                               @RequestParam(required = false) String category,
                               @RequestParam(required = false) BigDecimal maxPrice,
                               Model model) {
        model.addAttribute("products", productService.findProducts(search, category, maxPrice));
        model.addAttribute("search", search);
        model.addAttribute("selectedCategory", category);
        model.addAttribute("maxPrice", maxPrice);
        return "products";
    }

    @GetMapping("/products/new")
    public String newProduct(Model model) {
        model.addAttribute("product", new Product());
        return "product-form";
    }

    @PostMapping("/products")
    public String createProduct(@Valid @ModelAttribute Product product,
                                BindingResult bindingResult,
                                RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            return "product-form";
        }

        productService.save(product);
        redirectAttributes.addFlashAttribute("message", "Product added to QiShop.");
        return "redirect:/products";
    }
}
