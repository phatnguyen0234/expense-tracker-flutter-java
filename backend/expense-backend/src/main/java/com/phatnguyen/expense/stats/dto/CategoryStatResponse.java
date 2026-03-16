package com.phatnguyen.expense.stats.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.math.BigDecimal;

@Data
@AllArgsConstructor
public class CategoryStatResponse {

    private Long categoryId;
    private String categoryName;
    private BigDecimal totalAmount;
    private Double percent; // service sẽ tính
}
