package com.phatnguyen.expense.category;

import com.phatnguyen.expense.category.dto.CategoryRequest;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/categories")
@RequiredArgsConstructor
public class CategoryController {

    private final CategoryService service;

    // GET /api/v1/categories?type=EXPENSE
    @GetMapping
    public List<Category> getAll(@RequestParam(required = false) CategoryType type) {
        return service.getAll(type);
    }

    // POST /api/v1/categories
    @PostMapping
    public Category create(@RequestBody @Valid CategoryRequest req) {
        return service.create(req);
    }

    // PUT /api/v1/categories/{id}
    @PutMapping("/{id}")
    public Category update(@PathVariable Long id, @RequestBody @Valid CategoryRequest req) {
        return service.update(id, req);
    }

    // DELETE /api/v1/categories/{id}
    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        service.delete(id);
    }
}
