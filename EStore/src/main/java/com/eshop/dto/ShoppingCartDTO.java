package com.eshop.dto;

import java.io.Serial;
import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class ShoppingCartDTO implements Serializable {
    @Serial
    private static final long serialVersionUID = 9028578045532499529L;
    private Integer id;
    private Integer quantity;
    private String note;
    private ProductDTO product;

    public Double getUnitPrice() {
        return quantity * product.getPromotionalPrice();
    }
}
