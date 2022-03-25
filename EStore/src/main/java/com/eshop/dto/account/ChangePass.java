package com.eshop.dto.account;

import com.eshop.customer.validator.annotation.ExistsPassword;
import com.eshop.customer.validator.annotation.NotExistsPassword;
import com.eshop.customer.validator.annotation.PasswordMatches;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.NotBlank;
import java.io.Serial;
import java.io.Serializable;

@Setter @Getter
@NoArgsConstructor
@PasswordMatches(message = "{PasswordMatches}")
@NotExistsPassword(message = "{NotExistsPassword}")
@ExistsPassword(message = "{ExistsPassword}")
public class ChangePass implements Serializable {
    @Serial
    private static final long serialVersionUID = 4243061275200514707L;
    @NotBlank(message = "{NotBlank.password}")
    private String oldPassword;
    @NotBlank(message = "{NotBlank.password}")
    private String newPassword;
    @NotBlank(message = "{NotBlank.passwordConfirm}")
    private String newPasswordConfirm;
}