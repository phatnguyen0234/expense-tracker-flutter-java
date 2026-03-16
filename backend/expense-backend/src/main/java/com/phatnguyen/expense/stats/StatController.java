package com.phatnguyen.expense.stats;

import com.phatnguyen.expense.category.CategoryType;
import com.phatnguyen.expense.security.CurrentUser;
import com.phatnguyen.expense.stats.dto.CategoryStatResponse;
import com.phatnguyen.expense.stats.dto.MonthlySummaryResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/stats")
@RequiredArgsConstructor
public class StatController {

    private final StatService statService;

    @GetMapping("/monthly")
    public MonthlySummaryResponse monthly(
            @RequestParam String month,
            @AuthenticationPrincipal CurrentUser user
    ) {
        return statService.getMonthlySummary(month, user.id());
    }

    @GetMapping("/by-category")
    public List<CategoryStatResponse> category(
            @RequestParam String month,
            @RequestParam CategoryType type,
            @AuthenticationPrincipal CurrentUser user
    ) {
        return statService.getCategoryStats(month, type, user.id());
    }
}
