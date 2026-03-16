package com.phatnguyen.expense;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages = "com.phatnguyen.expense")
public class ExpenseBackendApplication {
    public static void main(String[] args) {
        SpringApplication.run(ExpenseBackendApplication.class, args);
    }
}
