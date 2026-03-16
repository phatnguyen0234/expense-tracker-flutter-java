package com.phatnguyen.expense.transaction.dto;

import com.phatnguyen.expense.category.CategoryType;
import com.phatnguyen.expense.transaction.PaymentMethod;
import jakarta.validation.constraints.*;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class TransactionRequest {

    @NotNull
    private Long categoryId;

    @NotNull
    @DecimalMin("0.01")
    private BigDecimal amount;

    @NotNull
    private CategoryType type; // EXPENSE | INCOME

    @NotNull
    private LocalDateTime txnDate;

    private String note;

    @NotNull
    private PaymentMethod paymentMethod; // CASH | BANK | EWALLET | OTHER
}
