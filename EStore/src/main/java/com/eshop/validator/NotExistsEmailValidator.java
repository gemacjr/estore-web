package com.eshop.validator;

import com.eshop.validator.annotation.NotExistsEmail;
import com.eshop.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class NotExistsEmailValidator implements ConstraintValidator<NotExistsEmail, String> {
    @Autowired
    UserRepository userRepository;

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        if (!value.isBlank()) {
            return !userRepository.existsByEmail(value);
        }
        return true;
    }
}
