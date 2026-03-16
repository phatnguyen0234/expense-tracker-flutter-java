package com.phatnguyen.expense.transaction.dto;

import com.phatnguyen.expense.category.CategoryType;
import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@Builder
public class TransactionResponse {

    private Long id;

    private Long userId;
    String userName;

    private Long categoryId;
    private String categoryName;

    private BigDecimal amount;

    private CategoryType type;

    private LocalDateTime txnDate;

    private String note;

    private String paymentMethod;
}
