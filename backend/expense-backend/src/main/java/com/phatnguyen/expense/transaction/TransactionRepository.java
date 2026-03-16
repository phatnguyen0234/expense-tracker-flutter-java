package com.phatnguyen.expense.transaction;

import com.phatnguyen.expense.category.CategoryType;
import com.phatnguyen.expense.stats.dto.CategoryStatResponse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;


import java.time.LocalDateTime;
import java.util.List;

public interface TransactionRepository extends JpaRepository<Transaction, Long> {

    List<Transaction> findByUserId(Long userId);

    @Query("""
SELECT 
    COALESCE(SUM(CASE WHEN t.type = com.phatnguyen.expense.category.CategoryType.INCOME THEN t.amount ELSE 0.0 END),0.0),
    COALESCE(SUM(CASE WHEN t.type = com.phatnguyen.expense.category.CategoryType.EXPENSE THEN t.amount ELSE 0.0 END),0.0)
FROM Transaction t
WHERE t.user.id = :userId
AND t.txnDate BETWEEN :start AND :end
""")
    List<Object[]> sumMonthly(
            @Param("userId") Long userId,
            @Param("start") LocalDateTime start,
            @Param("end") LocalDateTime end
    );




    @Query("""
    SELECT new com.phatnguyen.expense.stats.dto.CategoryStatResponse(
        t.category.id,
        t.category.name,
        CAST(SUM(t.amount) as bigdecimal),
        0.0
    )
    FROM Transaction t
    WHERE t.user.id = :userId
    AND t.type = :type
    AND t.txnDate BETWEEN :start AND :end
    GROUP BY t.category.id, t.category.name
    ORDER BY SUM(t.amount) DESC
    """)
    List<CategoryStatResponse> sumByCategory(
            @Param("userId") Long userId,
            @Param("type") CategoryType type,
            @Param("start") LocalDateTime start,
            @Param("end") LocalDateTime end
    );
}

