package com.phatnguyen.expense.category.dto;

import com.phatnguyen.expense.category.CategoryType;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public record CategoryRequest(
        @NotBlank String name,
        @NotNull CategoryType type
) {}
