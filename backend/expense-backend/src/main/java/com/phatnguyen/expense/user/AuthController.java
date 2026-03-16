package com.phatnguyen.expense.user;

import com.phatnguyen.expense.user.dto.AuthResponse;
import com.phatnguyen.expense.user.dto.LoginRequest;
import com.phatnguyen.expense.user.dto.RegisterRequest;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/auth")
@RequiredArgsConstructor
public class AuthController {

    private final UserService service;

    @PostMapping("/register")
    public User register(@RequestBody @Valid RegisterRequest req) {
        return service.register(req);
    }

    @PostMapping("/login")
    public AuthResponse login(@RequestBody @Valid LoginRequest req) {
        return service.login(req);
    }
}
