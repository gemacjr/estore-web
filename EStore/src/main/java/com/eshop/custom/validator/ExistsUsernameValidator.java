package com.eshop.custom.validator;

import com.eshop.custom.validator.annotation.ExistsUsername;
import com.eshop.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class ExistsUsernameValidator implements ConstraintValidator<ExistsUsername, String> {
    @Autowired
    UserRepository userRepository;

    @Override
    public boolean isValid(String username, ConstraintValidatorContext context) {
        if (!username.isBlank()) {
            return userRepository.existsByUsername(username);
        }
        return true;
    }
}
