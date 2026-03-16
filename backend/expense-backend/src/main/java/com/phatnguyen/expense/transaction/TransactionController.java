package com.phatnguyen.expense.transaction;

import com.phatnguyen.expense.category.CategoryType;
import com.phatnguyen.expense.transaction.dto.TransactionRequest;
import com.phatnguyen.expense.transaction.dto.TransactionResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/transactions")
@RequiredArgsConstructor
public class TransactionController {

    private final TransactionService service;

    @PostMapping
    public TransactionResponse create(@RequestBody @Valid TransactionRequest req) {
        return service.create(req);
    }

    @PutMapping("/{id}")
    public TransactionResponse update(@PathVariable Long id, @RequestBody @Valid TransactionRequest req) {
        return service.update(id, req);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        service.delete(id);
    }

    @GetMapping("/{id}")
    public TransactionResponse getById(@PathVariable Long id) {
        return service.getById(id);
    }


    @GetMapping
    public List<TransactionResponse> getAll(
            @RequestParam(required = false) String month,
            @RequestParam(required = false) CategoryType type,
            @RequestParam(required = false) Long categoryId
    ) {
        return service.getAll(month, type, categoryId);
    }
}
