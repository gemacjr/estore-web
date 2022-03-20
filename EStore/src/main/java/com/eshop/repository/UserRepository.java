package com.eshop.repository;

import com.eshop.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Integer> {
    User findByEmail(String email);
    User findByVerificationTokenToken(String token);
    Boolean existsByEmail(String email);
    Boolean existsByUsername(String username);
}