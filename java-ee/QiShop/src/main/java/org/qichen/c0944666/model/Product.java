package org.qichen.c0944666.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Product name is required.")
    @Size(max = 80, message = "Product name must be 80 characters or fewer.")
    private String name;

    @NotBlank(message = "Category is required.")
    private String category;

    @NotNull(message = "Price is required.")
    @DecimalMin(value = "0.01", message = "Price must be at least $0.01.")
    private BigDecimal price;

    @NotNull(message = "Stock quantity is required.")
    @Min(value = 0, message = "Stock cannot be negative.")
    private Integer stockQuantity;

    @NotBlank(message = "Description is required.")
    @Size(min = 10, max = 300, message = "Description must be between 10 and 300 characters.")
    private String description;
}
