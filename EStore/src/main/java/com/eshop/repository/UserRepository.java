package com.eshop.repository;

import com.eshop.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserRepository extends JpaRepository<User, Integer> {
    List<User> findByEnabled(boolean enabled);
    User findByEmail(String email);
    User findByVerificationTokenToken(String token);
    Boolean existsByEmail(String email);
    Boolean existsByUsername(String username);
}