package com.phatnguyen.expense.category;

import com.phatnguyen.expense.category.dto.CategoryRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CategoryService {
    private final CategoryRepository repo;

    public List<Category> getAll(CategoryType type) {
        if (type == null) return repo.findAll();
        return repo.findByType(type);
    }

    public Category create(CategoryRequest req) {
        Category c = Category.builder()
                .name(req.name())
                .type(req.type())
                .build();
        return repo.save(c);
    }

    public Category update(Long id, CategoryRequest req) {
        Category c = repo.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Category not found"));
        c.setName(req.name());
        c.setType(req.type());
        return repo.save(c);
    }

    public void delete(Long id) {
        if (!repo.existsById(id)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Category not found");
        }
        repo.deleteById(id);
    }
}
