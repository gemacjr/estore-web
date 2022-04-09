package com.eshop.dto.user;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.NotBlank;
import java.io.Serial;
import java.io.Serializable;

@Setter
@Getter
@NoArgsConstructor
public class Profile implements Serializable {
    @Serial
    private static final long serialVersionUID = -7772791367607905186L;
    @NotBlank(message = "{NotBlank.fullName}")
    private String fullname;
    private String email;
    private String username;
    private String address;
    private String phoneNumber;
    private String photo;
    private MultipartFile photoFile;
}
