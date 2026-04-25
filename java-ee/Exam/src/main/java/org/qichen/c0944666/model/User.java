package org.qichen.c0944666.model;

import jakarta.validation.Valid;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
    @NotBlank
    @Size(min = 2, max = 40)
    private String name;

    @Min(18)
    @NotNull
    private Integer age;

    @NotNull
    @Valid
    private Occupation occupation;
}
