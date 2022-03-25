package com.eshop.customer.validator.annotation;

import com.eshop.customer.validator.ExistsEmailValidator;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.*;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

@Target({TYPE, FIELD, ANNOTATION_TYPE})
@Retention(RUNTIME)
@Constraint(validatedBy = ExistsEmailValidator.class)
@Documented
public @interface ExistsEmail {
    String message() default "Email does not exist!";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}