package com.phatnguyen.expense.transaction;

import com.phatnguyen.expense.category.Category;
import com.phatnguyen.expense.category.CategoryRepository;
import com.phatnguyen.expense.category.CategoryType;
import com.phatnguyen.expense.security.CurrentUser;
import com.phatnguyen.expense.transaction.dto.TransactionRequest;
import com.phatnguyen.expense.transaction.dto.TransactionResponse;
import com.phatnguyen.expense.user.User;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;
import com.phatnguyen.expense.user.UserRepository;


import java.util.List;

@Service
@RequiredArgsConstructor
public class TransactionService {

    private final TransactionRepository repo;
    private final CategoryRepository categoryRepo;
    private final UserRepository userRepo;

    public TransactionResponse create(TransactionRequest req) {

        Long userId = getCurrentUserId();
        User user = userRepo.findById(userId)
                .orElseThrow(() -> new ResponseStatusException(
                        HttpStatus.NOT_FOUND, "User not found"));

        Category cat = categoryRepo.findById(req.getCategoryId())
                .orElseThrow(() -> new ResponseStatusException(
                        HttpStatus.NOT_FOUND, "Category not found"));

        Transaction t = Transaction.builder()
                .user(user)
                .category(cat)
                .amount(req.getAmount())
                .type(req.getType())
                .txnDate(req.getTxnDate())
                .note(req.getNote())
                .paymentMethod(req.getPaymentMethod())
                .build();

        Transaction saved = repo.save(t);
        return toResponse(saved);
    }


    public TransactionResponse update(Long id, TransactionRequest req) {

        Long userId = getCurrentUserId();

        Transaction t = repo.findById(id)
                .orElseThrow(() -> new ResponseStatusException(
                        HttpStatus.NOT_FOUND, "Transaction not found"));

        if (!t.getUser().getId().equals(userId)) {
            throw new ResponseStatusException(
                    HttpStatus.FORBIDDEN, "Access denied");
        }

        Category cat = categoryRepo.findById(req.getCategoryId())
                .orElseThrow(() -> new ResponseStatusException(
                        HttpStatus.NOT_FOUND, "Category not found"));

        t.setCategory(cat);
        t.setAmount(req.getAmount());
        t.setType(req.getType());
        t.setTxnDate(req.getTxnDate());
        t.setNote(req.getNote());
        t.setPaymentMethod(req.getPaymentMethod());

        return toResponse(repo.save(t));
    }

    public TransactionResponse getById(Long id) {

        Long userId = getCurrentUserId();

        Transaction tx = repo.findById(id)
                .orElseThrow(() -> new ResponseStatusException(
                        HttpStatus.NOT_FOUND, "Transaction not found"));

        if (!tx.getUser().getId().equals(userId)) {
            throw new ResponseStatusException(
                    HttpStatus.FORBIDDEN, "Access denied");
        }

        return toResponse(tx);
    }


    public void delete(Long id) {

        Long userId = getCurrentUserId();

        Transaction t = repo.findById(id)
                .orElseThrow(() -> new ResponseStatusException(
                        HttpStatus.NOT_FOUND, "Transaction not found"));

        if (!t.getUser().getId().equals(userId)) {
            throw new ResponseStatusException(
                    HttpStatus.FORBIDDEN, "Access denied");
        }

        repo.delete(t);
    }


    public List<TransactionResponse> getAll(String month, CategoryType type, Long categoryId) {

        Long userId = getCurrentUserId();

        List<Transaction> list = repo.findByUserId(userId);

        return list.stream()
                .filter(t -> type == null || t.getType() == type)
                .filter(t -> categoryId == null || t.getCategory().getId().equals(categoryId))
                .filter(t -> {
                    if (month == null) return true;
                    try {
                        var parts = month.split("-");
                        int year = Integer.parseInt(parts[0]);
                        int m = Integer.parseInt(parts[1]);
                        return t.getTxnDate().getYear() == year
                                && t.getTxnDate().getMonthValue() == m;
                    } catch (Exception e) {
                        return true;
                    }
                })
                .map(this::toResponse)
                .toList();
    }


    private TransactionResponse toResponse(Transaction t) {
        return TransactionResponse.builder()
                .id(t.getId())
                .userId(t.getUser().getId())
                .userName(t.getUser().getEmail()) // hoặc username
                .categoryId(t.getCategory().getId())
                .categoryName(t.getCategory().getName())
                .amount(t.getAmount())
                .type(t.getType())
                .txnDate(t.getTxnDate())
                .note(t.getNote())
                .paymentMethod(
                        t.getPaymentMethod() == null ? null : t.getPaymentMethod().name()
                )
                .build();
    }

    private Long getCurrentUserId() {
        CurrentUser user = (CurrentUser) SecurityContextHolder
                .getContext()
                .getAuthentication()
                .getPrincipal();

        return user.id();
    }

}
