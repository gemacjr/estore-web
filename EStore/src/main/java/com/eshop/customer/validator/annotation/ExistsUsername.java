package com.eshop.customer.validator.annotation;

import com.eshop.customer.validator.ExistsUsernameValidator;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.*;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

@Target({TYPE, FIELD, ANNOTATION_TYPE})
@Retention(RUNTIME)
@Constraint(validatedBy = ExistsUsernameValidator.class)
@Documented
public @interface ExistsUsername {
    String message() default "Username does not exist!";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}