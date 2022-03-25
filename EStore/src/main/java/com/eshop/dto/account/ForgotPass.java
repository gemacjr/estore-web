package com.eshop.dto.account;

import com.eshop.customer.validator.annotation.ExistsEmail;
import com.eshop.customer.validator.annotation.ValidEmail;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotBlank;
import java.io.Serial;
import java.io.Serializable;

@Setter @Getter
public class ForgotPass implements Serializable {
    @Serial
    private static final long serialVersionUID = 1912783137081146374L;
    @NotBlank(message = "{NotBlank.email}")
    @ValidEmail(message = "{ValidEmail.email}")
    @ExistsEmail(message = "{ExistsEmail.email}")
    private String email;
}
