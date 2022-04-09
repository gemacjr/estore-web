package com.eshop.dto.user;

import com.eshop.validator.annotation.NotExistsPassword;
import com.eshop.validator.annotation.PasswordMatches;
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
public class ResetPass implements Serializable {
    @Serial
    private static final long serialVersionUID = 4856258996702106939L;
    private String token;
    @NotBlank (message = "{NotBlank.password}")
    private String password;
    @NotBlank (message = "{NotBlank.passwordConfirm}")
    private String passwordConfirm;
}
