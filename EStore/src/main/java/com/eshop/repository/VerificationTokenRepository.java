package com.eshop.repository;

import com.eshop.entity.VerificationToken;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VerificationTokenRepository extends JpaRepository<VerificationToken, Integer> {
    public VerificationToken findByToken(String token);
    public VerificationToken findByUserEmail(String email);
}