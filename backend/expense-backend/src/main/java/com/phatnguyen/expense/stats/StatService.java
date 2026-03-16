package com.phatnguyen.expense.stats;

import com.phatnguyen.expense.category.CategoryType;
import com.phatnguyen.expense.security.CurrentUser;
import com.phatnguyen.expense.stats.dto.CategoryStatResponse;
import com.phatnguyen.expense.stats.dto.MonthlySummaryResponse;
import com.phatnguyen.expense.transaction.TransactionRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class StatService {

    private final TransactionRepository transactionRepository;

    public MonthlySummaryResponse getMonthlySummary(String month, Long userId) {

        YearMonth ym = YearMonth.parse(month);

        LocalDateTime start = ym.atDay(1).atStartOfDay();
        LocalDateTime end = ym.atEndOfMonth().atTime(23,59,59);

        List<Object[]> results = transactionRepository.sumMonthly(userId, start, end);

        Object[] row = results.get(0);

        BigDecimal income = (BigDecimal) row[0];
        BigDecimal expense = (BigDecimal) row[1];

        BigDecimal balance = income.subtract(expense);

        return new MonthlySummaryResponse(income, expense, balance);
    }


    public List<CategoryStatResponse> getCategoryStats(String month, CategoryType type, Long userId) {

        YearMonth ym = YearMonth.parse(month);
        LocalDateTime start = ym.atDay(1).atStartOfDay();
        LocalDateTime end = ym.atEndOfMonth().atTime(23,59,59);

        List<CategoryStatResponse> stats =
                transactionRepository.sumByCategory(userId, type, start, end);

        // tính tổng
        BigDecimal total = stats.stream()
                .map(CategoryStatResponse::getTotalAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        // tính percent
        for (CategoryStatResponse s : stats) {
            double percent = 0;
            if(total.compareTo(BigDecimal.ZERO) > 0) {
                percent = s.getTotalAmount()
                        .multiply(BigDecimal.valueOf(100))
                        .divide(total, 2, RoundingMode.HALF_UP)
                        .doubleValue();
            }
            s.setPercent(percent);
        }

        return stats;
    }


}
