package com.eshop.custom.validator;

import com.eshop.custom.validator.annotation.ExistsPassword;
import com.eshop.dto.account.ChangePass;
import com.eshop.dto.account.ResetPass;
import com.eshop.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class ExistsPasswordValidator implements ConstraintValidator<ExistsPassword, Object> {
    @Autowired
    UserService userService;

    @Override
    public boolean isValid(Object obj, ConstraintValidatorContext context) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();

        if (obj instanceof ResetPass resetPass) {
            if (!resetPass.getPassword().isBlank() || resetPass.getPassword() != null) {
                return userService.existsByPasswordAndToken(resetPass.getPassword(), resetPass.getToken());
            }
        } else if (obj instanceof ChangePass changePass) {
            if (changePass.getOldPassword().length() > 0) {
                return userService.existsByEmailAndPassword(auth.getName(), changePass.getOldPassword());
            }
        }
        return true;
    }
}
