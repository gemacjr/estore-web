package com.eshop.customer.validator.annotation;

import com.eshop.customer.validator.ExistsPasswordValidator;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.*;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

@Target({TYPE, FIELD, ANNOTATION_TYPE})
@Retention(RUNTIME)
@Constraint(validatedBy = ExistsPasswordValidator.class)
@Documented
public @interface ExistsPassword {
    String message() default "Incorrect password!";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}