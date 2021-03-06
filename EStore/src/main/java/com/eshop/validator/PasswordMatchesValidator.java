package com.eshop.validator;

import com.eshop.validator.annotation.PasswordMatches;
import com.eshop.dto.user.ChangePass;
import com.eshop.dto.user.Register;
import com.eshop.dto.user.ResetPass;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class PasswordMatchesValidator implements ConstraintValidator<PasswordMatches, Object> {
    @Override
    public boolean isValid(Object obj, ConstraintValidatorContext context) {
        if (obj instanceof ResetPass resetPass) {
            if (resetPass.getPasswordConfirm().isBlank()) return true;
            return resetPass.getPassword().equals(resetPass.getPasswordConfirm());
        } else if (obj instanceof ChangePass changePass) {
            if (changePass.getNewPasswordConfirm().isBlank()) return true;
            return changePass.getNewPassword().equals(changePass.getNewPasswordConfirm());
        } else if (obj instanceof Register register) {
            if (register.getPasswordConfirm().isBlank()) return true;
            return register.getPassword().equals(register.getPasswordConfirm());
        }
        return true;
    }
}
