package com.eshop.validator;

import com.eshop.validator.annotation.NotExistsUsername;
import com.eshop.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class NotExistsUsernameValidator implements ConstraintValidator<NotExistsUsername, String> {
    @Autowired
    UserRepository userRepository;

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        if (!value.isBlank()) {
            return !userRepository.existsByUsername(value);
        }
        return true;
    }
}
