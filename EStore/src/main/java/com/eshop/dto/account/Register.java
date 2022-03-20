package com.eshop.dto.account;

import com.eshop.custom.validator.annotation.NotExistsEmail;
import com.eshop.custom.validator.annotation.NotExistsUsername;
import com.eshop.custom.validator.annotation.PasswordMatches;
import com.eshop.custom.validator.annotation.ValidEmail;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.NotBlank;
import java.io.Serial;
import java.io.Serializable;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Getter @Setter
@NoArgsConstructor
@PasswordMatches
public class Register implements Serializable {
    @Serial
    private static final long serialVersionUID = 4759520964447340990L;
    @NotBlank(message = "{NotBlank.firstName}")
    private String firstName;
    @NotBlank(message = "{NotBlank.lastName}")
    private String lastName;
    @NotBlank(message = "{NotBlank.username}")
    @NotExistsUsername(message = "{NotExistsUsername}")
    private String username;
    @NotBlank(message = "{NotBlank.email}")
    @ValidEmail(message = "{ValidEmail}")
    @NotExistsEmail(message = "{NotExistsEmail}")
    private String email;
    @NotBlank(message = "{NotBlank.password}")
    private String password;
    @NotBlank(message = "{NotBlank.passwordConfirm}")
    private String passwordConfirm;

    public String getFullname() {
        return Stream
                .of(lastName, firstName)
                .filter(x -> x != null && !x.isBlank())
                .collect(Collectors.joining(" "));
    }
}
