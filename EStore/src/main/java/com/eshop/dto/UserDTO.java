package com.eshop.dto;

import lombok.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.Serial;
import java.io.Serializable;
import java.sql.Timestamp;

@Setter
@Getter
@ToString
public class UserDTO implements Serializable {
    @Serial
    private static final long serialVersionUID = -222833040234824879L;
    private Integer id;
    private String username;
    private String password;
    private String fullname;
    private String email;
    private String address;
    private String phoneNumber;
    private MultipartFile photoFile;
    private String photo;
    private String enabled;
    private String isAdmin;
    private Timestamp createdDate;
}
