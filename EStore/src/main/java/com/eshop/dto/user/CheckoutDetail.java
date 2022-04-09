package com.eshop.dto.user;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serial;
import java.io.Serializable;

@Setter @Getter
@NoArgsConstructor
public class CheckoutDetail implements Serializable {
    @Serial
    private static final long serialVersionUID = 6763817204041820523L;
    private String fullname;
    private String address;
    private String phoneNumber;
    private String note;
}
