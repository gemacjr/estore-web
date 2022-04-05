package com.eshop.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
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
    private String photo = "default.png";
    private Timestamp createdDate;
    private String enabled;
    private MultipartFile photoFile;

}
